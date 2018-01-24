/*
  Purpose: The 
  Created by: Gary
*/

// Pin Assignments
const int enablePin = 2;
const int fwdPin = 3;
const int bwdPin = 4;
const int buttonPin = 5;
const int encoderA = 8;
const int encoderB = 9;

// System Clock Frequency
const unsigned long int CLK = 16001675;

// State Parameters:
/*
const int hardStop = 0;
const int forward = 1;
const int backward = 2;
*/

enum stateType {
  hardStop,
  forward,
  backward
  };

stateType state = hardStop;
stateType nstate = forward;

void setup() {
  // initialize output pins:
  pinMode(enablePin, OUTPUT);
  pinMode(fwdPin, OUTPUT);
  pinMode(bwdPin, OUTPUT);
  digitalWrite(enablePin, LOW);
  digitalWrite(fwdPin, LOW);
  digitalWrite(bwdPin, LOW);
  
  // initialize input pins:
  pinMode(buttonPin, INPUT);
  pinMode(encoderA, INPUT);
  pinMode(encoderB, INPUT);
  Serial.begin(9600);
}

void loop() {
  
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
  */
  String A = "A = ";
  A = A + digitalRead(encoderA);
  String B = "B = ";
  B = B + digitalRead(encoderB);
  Serial.println(A);
  Serial.println(B);

  //If the button is pressed, got to next state
  if( digitalRead(buttonPin) == LOW){
    state = nstate;
   // if (state == 3) state = 0;
    delay(100);
    pinUpdate(state, &nstate);
    };
  
}

/*
================================================
FUNCTIONS
================================================
*/

/*
Adjusts pin ouptuts based on current state.
*/
void pinUpdate(stateType state, stateType* nstate){
  if(state == backward){
    digitalWrite(enablePin, HIGH);
    digitalWrite(fwdPin, LOW);
    digitalWrite(bwdPin, HIGH);
    *nstate = hardStop;
    //Serial.println("BACKWARD");
  }
  else if(state == forward){
    digitalWrite(enablePin, HIGH);
    digitalWrite(fwdPin, HIGH);
    digitalWrite(bwdPin, LOW);
    *nstate = backward;
    //Serial.println("FORWARD");
  }
  else{
    digitalWrite(enablePin, LOW);
    digitalWrite(fwdPin, LOW);
    digitalWrite(bwdPin, LOW);
    *nstate = forward;
    //Serial.println("STOP");
    }
  };


