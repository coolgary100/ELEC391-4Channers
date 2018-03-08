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

double motorPos = 0;

//Define Variables we'll be connecting to
//const double Kd = 0.078;
//const double Kd = 0.005;
//const double Kp = 1.7*Kd;
//const double Kp = 51*Kd;
//const double Ki = 1.7*Kd;
//const double Kd = 0.082;
//const double Kp = 6*Kd;
//const double Ki = 0;  

//Test more if other fails
//const double Kp = 0.495;
//const double Ki = 0.005;
//const double Kd = 0.0225;

const double Kp = 0.353306578885394;
const double Ki = 0.0118608742288199;
const double Kd = 0.283718414734085; 

double Error, previousError;
double input, output;
double Integral = 0;
double setPoint = 360;

bool milliSet = false;

void setup() {

  
  // initialize output pins:
  pinMode(enablePin, OUTPUT);
  pinMode(fwdPin, OUTPUT);
  pinMode(bwdPin, OUTPUT);
  analogWrite(enablePin, output);
  digitalWrite(fwdPin, HIGH);
  digitalWrite(bwdPin, LOW);
  
  // initialize input pins:
  pinMode(buttonPin, INPUT);
  pinMode(aPin, INPUT);
  pinMode(bPin, INPUT);

  //Timer Initialization
  noInterrupts();           // disable all interrupts
  
  Serial.begin(250000);

  while ( !digitalRead(aPin) or !digitalRead(bPin)){
    //Do nothing until motor is homed at 1,1
    };
  
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

  motorPos = motorPos * 0.9;
  Serial.print("Motor pos ");
  Serial.println(motorPos);
  input = motorPos;
  //delay(5);
  output = PID_Controller(input, setPoint);
  Serial.print("Output ");
  Serial.println(output);
  output = output;
  if(output >= 0) {
     digitalWrite(fwdPin, LOW);
     digitalWrite(bwdPin, HIGH);
   }
   else {
     digitalWrite(fwdPin, HIGH);
     digitalWrite(bwdPin, LOW);
   }
   /*if(abs(Error) < 40) {
    setPoint = -setPoint;
    Serial.println("SWITCHED ");
   }
   */

  /*if(!(millis() % 5000)){
      setPoint += 120;
  }*/
  analogWrite(enablePin, byte abs(output));  
  //analogWrite(enablePin, abs((byte)(((Output - 180) / 180) * 155)));
  
}

/*
================================================
FUNCTIONS
================================================
*/

double PID_Controller (double input, double desired) {
  Error = desired - input;
  Integral = Integral + Error;
  if(abs(Error) < 1) {
      Integral = 0;
  }
  if(abs(Error) > 60) {
    Integral = 0;
  }
  
  double Derivative = Error - previousError;
  previousError = Error;

  double output;
  output = Kp*Error + Ki*Integral + Kd*Derivative; 
  if( output >= 255 ) {
    output = 255;
  }
  if( output <= -255) {
    output = -255;
  }
  return output;
};
  
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
