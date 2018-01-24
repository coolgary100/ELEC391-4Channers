/*
*/

// constants won't change. They're used here to set pin numbers:
const int enablePin = 2;
const int fwdPin = 3;
const int bwdPin = 4;
const int buttonPin = 5;
const int encoderA = 8;
const int encoderB = 9;

const unsigned long int CLK = 16001675;

// State Parameters:
const int idle = 0;
const int motorStop = 1;
const int forward = 2;
const int backward = 3;

int state, nstate = 0;

void setup() {
  // initialize the LED pin as an output:
  pinMode(enablePin, OUTPUT);
  pinMode(fwdPin, OUTPUT);
  pinMode(bwdPin, OUTPUT);
  digitalWrite(enablePin, LOW);
  digitalWrite(fwdPin, LOW);
  digitalWrite(bwdPin, LOW);
  
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);
  pinMode(encoderA, INPUT);
  pinMode(encoderB, INPUT);
  Serial.begin(9600);
}

void loop() {
  // read the state of the pushbutton value:
  String A = "A = ";
  A = A + digitalRead(encoderA);
  String B = "B = ";
  B = B + digitalRead(encoderB);
  Serial.println(A);
  Serial.println(B);
  if( digitalRead(buttonPin) == LOW){
    state++;
    if (state == 3) state = 0;
    delay(100);
    };
  
  if(state == 2){
    digitalWrite(enablePin, HIGH);
    digitalWrite(fwdPin, LOW);
    digitalWrite(bwdPin, HIGH);
    //Serial.println("BACKWARD");
  }
  else if(state == 1){
    digitalWrite(enablePin, HIGH);
    digitalWrite(fwdPin, HIGH);
    digitalWrite(bwdPin, LOW);
    //Serial.println("FORWARD");
  }
  else{
    digitalWrite(enablePin, LOW);
    digitalWrite(fwdPin, LOW);
    digitalWrite(bwdPin, LOW);
    //Serial.println("STOP");
    }
}
