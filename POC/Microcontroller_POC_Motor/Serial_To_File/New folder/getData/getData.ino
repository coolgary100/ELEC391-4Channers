
/*
  Purpose: To control a motor's speed and direction using feedback from an optical encoder
  Requirements: Arduino Uno, Encoder, Motor, Current driver
  Created by: Gary Jiang and Zachary Anderson
  Resources:  https://www.arduino.cc/reference/en/language/functions/external-interrupts/attachinterrupt/
              https://learn.adafruit.com/multi-tasking-the-arduino-part-2/timers
*/

// Pin Assignments
const byte aPin = 2;
const byte bPin = 3;
const byte enablePin = 9;
const byte fwdPin = 5;
const byte bwdPin = 6;
const byte buttonPin = 7;

// System Clock Frequency
const unsigned long int CLK = 16001675;

// Values for external interupt.
volatile long int motorPos_ISR = 0; //in degrees.  Assuming 360
volatile bool dir = true; // true if forward, false if backward
volatile bool transition = false; // true if last transition A, false if B
volatile bool interruptFlag = false;
volatile bool miliFlag = false;
volatile long int counterTime = 0;

double motorPos, currentMotorPos, lastMotorPos, lastMillis, currentMillis, posDiff, timeDiff, velocity;

void setup() {

  motorPos = 0;
  currentMotorPos = 0;
  lastMotorPos = 0;
  lastMillis = 0;
  currentMillis = 0;
  posDiff = 0;
  timeDiff = 0;
  velocity = 0;

  // initialize output pins:
  pinMode(enablePin, OUTPUT);
  pinMode(fwdPin, OUTPUT);
  pinMode(bwdPin, OUTPUT);
  //analogWrite(enablePin, 255);
  digitalWrite(fwdPin, HIGH);
  digitalWrite(bwdPin, LOW);
  
  // initialize input pins:
  pinMode(buttonPin, INPUT);
  pinMode(aPin, INPUT);
  pinMode(bPin, INPUT);

  //Timer Initialization
  noInterrupts();           // disable all interrupts

  OCR0A = 0xAF;
  TIMSK0 |= _BV(OCIE0A);
  
  Serial.begin(9600);

  /*while ( !digitalRead(aPin) or !digitalRead(bPin)){
    //Do nothing until motor is homed at 1,1
    };
  */
  // Enable the interupts to exec on any transition of A or B.
  attachInterrupt(digitalPinToInterrupt(aPin), ISR_A, CHANGE);
  attachInterrupt(digitalPinToInterrupt(bPin), ISR_B, CHANGE);
  interrupts();             // enable all interrupts
}

void loop() {
  do{
    interruptFlag = false;
    motorPos = motorPos_ISR;
  }while(interruptFlag);

  motorPos = motorPos * 0.9 * 3.141592653587/180;
  currentMotorPos = motorPos;
  currentMillis = millis();
  timeDiff = (currentMillis - lastMillis)/1000;
  posDiff = currentMotorPos - lastMotorPos;
  velocity = posDiff/timeDiff;
  if(miliFlag) {
    miliFlag = false;
    Serial.println(velocity);
    Serial.println(currentMillis);
  }
  lastMotorPos = currentMotorPos;
  lastMillis = currentMillis;
  //analogWrite(enablePin, byte(255));  
}

/*
================================================
FUNCTIONS
================================================
*/

/*
Adjusts pin ouptuts based on current state.
*/
/*
void pinUpdate(stateType state, stateType* nstate){
  if(state == backward){
    digitalWrite(enablePin, HIGH);
    digitalWrite(fwdPin, LOW);
    digitalWrite(bwdPin, HIGH);
    *nstate = softStop;
  }
  else if(state == forward){
    digitalWrite(enablePin, HIGH);
    digitalWrite(fwdPin, HIGH);
    digitalWrite(bwdPin, LOW);
    *nstate = backward;
  }
  else{
    digitalWrite(enablePin, LOW);
    digitalWrite(fwdPin, LOW);
    digitalWrite(bwdPin, LOW);
    *nstate = forward;
    }
  };
*/
/*
================================================
ISR ROUTINES
================================================
*/
  //Read from the encoder
  /*
  A,B = 0,0 ->1 staring point
  A,B = 1,0 ->2 motor is moving forward
  A,B = 0,1 ->2 motor is moving backward
  A,B = 1,1 ->3 if it isn't this, dir is rev

  A,B = 1,1 ->1 starting point
  A,B = 0,1 ->2 motor is moving forward
  A,B = 1,0 ->2 motor is moving backward
  A,B = 0,0 ->3 if it isn't this, dir is rev

  We will use an external interupt to count transitions of a and b with a counter.
  We will use an timer interrupt to track time accurately.
  If we are limited to 1 pin, we could connect A and B to an XOR gate and connect to
  our external interrupt.  On the ext we read A and B.
  */
  
void ISR_A(){
  // if last trans was A, then direction was switched
  if(transition == true) dir = !dir;
  transition = true;
  interruptFlag = true;
  
  motorPos_ISR = dir ? (motorPos_ISR + 1) : (motorPos_ISR - 1);
  };

void ISR_B(){
  //if last trans was B, direction was switched
  if(transition == false) dir = !dir;
  transition = false;
  interruptFlag = true;
  
  motorPos_ISR = dir ? (motorPos_ISR + 1) : (motorPos_ISR - 1);
  };

SIGNAL(TIMER0_COMPA_vect) {
   //counterTime++;
   miliFlag = true;
   //Serial.println(counterTime);
}

