/*
  Button

  Turns on and off a light emitting diode(LED) connected to digital pin 13,
  when pressing a pushbutton attached to pin 2.

  The circuit:
  - LED attached from pin 13 to ground
  - pushbutton attached to pin 2 and 3 from +5V
  - 10K resistor attached to pin 2 and 3 from ground
  - Output wire attached to pin 7 and 8 which feeds to input of AND gate

  Result:
  - Pressing the button on pin 2 will lead to the LED attached from pin 13 to turn on
  - Pressing both buttons will send a HIGH output to an AND gate which will turn on another LED
  
  - Note: on most Arduinos there is already an LED on the board
    attached to pin 13.
*/

// constants won't change. They're used here to set pin numbers:
const int buttonPin = 2;     // the number of the pushbutton pin
const int buttonPin1 = 3;    // the number of the second pushbutton pin
const int ledPin =  13;      // the number of the LED pin
const int andGate1 = 7;      // output that feeds into input of an AND gate
const int andGate2 = 8; 	 // output that feeds into input of an AND gate

// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status
int buttonState1 = 0;         // variable for reading the pushbutton status

void setup() {
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);
  // initialize the second pushbutton pin as an input:
  pinMode(buttonPin1, INPUT);
  // intialize the 2 output to AND gate as output
  pinMode(andGate1, OUTPUT);
  pinMode(andGate2, OUTPUT);
}

void loop() {
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);
  buttonState1 = digitalRead(buttonPin1);

  // check if the pushbutton is pressed. If it is, the buttonState is HIGH:
  if (buttonState == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }
  
  // check if the pushbuttons are pressed. If they are, the button states are HIGH:
  if (buttonState == HIGH) {
	  // output HIGH from andGate1:
	  digitalWrite(andGate1, HIGH);
  } else {
	  // output LOW from andGate1:
	  digitalWrite(andGate1, LOW);
  }
  
  if(buttonState1 == HIGH) {
	  // output HIGH from andGate2:
	  digitalWrite(andGate2, HIGH);
  } else {
	  // output LOW from andGate2:
	  digitalWrite(andGate2, LOW);
  }
  
}
