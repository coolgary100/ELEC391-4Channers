
const int select1 = 3; //Controls Reading from Output Buffer
const int select2 = 4; // (select1=Pin4 & select2=Pin17)

const int outputEnable = 2; //Active-Low Enable

const int d0 = 6; //Tri-State Output Bus
const int d1 = 7;
const int d2 = 8;
const int d3 = 9;
const int d4 = 10;
const int d5 = 11;
const int d6 = 12;
const int d7 = 13;

const int rst = 5;

byte MSB = 0;
byte SecondByte = 0;
byte ThirdByte = 0;
byte LSB = 0;

byte thirdNew = 0;
byte thirdOld = 0;
byte lsbNew = 0;
byte lsbOld = 0;
byte secondOld = 0;
byte secondNew = 0;
byte msbNew = 0; 
byte msbOld = 0;

double multiplier = 0;
double tempValue = 0;
double result = 0;

double  count = 0; // Count of Encoder (400CPR)
double  angle = 0; // Angle of Rotation

void setup() {
  Serial.begin(9600);

  pinMode(d0, INPUT);
  pinMode(d1, INPUT);
  pinMode(d2, INPUT);
  pinMode(d3, INPUT);
  pinMode(d4, INPUT);
  pinMode(d5, INPUT);
  pinMode(d6, INPUT);
  pinMode(d7, INPUT);


  pinMode(select1, OUTPUT);
  pinMode(select2, OUTPUT);
  pinMode(outputEnable, OUTPUT);
  pinMode(rst, OUTPUT);

  digitalWrite(rst, LOW);

}

void loop() {

  digitalWrite(rst, HIGH);
  digitalWrite(outputEnable, LOW);
  //delay (25);

   digitalWrite(select1, LOW); //Reset SEL1
   digitalWrite(select2, HIGH); //Set SEL2
   //digitalWrite(outputEnable, LOW); //Reset OE
  
   MSB = Get_MSB(); //Get MostSignificantByte
  
   digitalWrite(select1, HIGH);
   digitalWrite(select2, HIGH);

   SecondByte = Get_2nd();

  digitalWrite(select1, LOW);
  digitalWrite(select2, LOW);
  digitalWrite(outputEnable, LOW); //Reset OE

  ThirdByte = Get_3rd();

  digitalWrite(select1, HIGH);
  digitalWrite(select2, LOW);

  LSB = Get_LSB();

  digitalWrite(outputEnable, HIGH);
  //delay(25);

  multiplier = 1;
  tempValue = LSB * multiplier;  //Assign LSB
  count = tempValue;

  multiplier = multiplier * 256;
  tempValue = ThirdByte * multiplier;  //Assign ThirdByte
  count = count + tempValue;

  multiplier = multiplier * 256;
  tempValue = SecondByte * multiplier;  //Assign SecondByte
  count = count + tempValue;
  
  multiplier = multiplier * 256;
  tempValue = MSB * multiplier;  //Assign MSB
  count = count + tempValue;

  // result == 32-BIT COUNT DATA i.e WHAT IS READ TO ARDUINO AND USED

//  count = (ThirdByte<<8) | LSB;
  count = double (count);
  angle = count*0.9;
 Serial.println(angle);

}


 byte Get_MSB() {
    msbOld = Read_Byte();  //Get Current Data --> WHAT IS PINA
    msbNew = Read_Byte();  //Get 2nd Data

  if (msbNew == msbOld) {
    MSB = msbNew;  //Get Stable Data
    return MSB;
  }
  else {
    Get_MSB();
  }
}
//
byte Get_2nd() {
    secondOld = Read_Byte();  //Get Current Data --> WHAT IS PINA
    secondNew = Read_Byte();  //Get 2nd Data

  if (secondNew == secondOld) {
    SecondByte = secondNew;  //Get Stable Data
    return SecondByte;
  }
  else {
    Get_2nd();
  }
}

byte Get_3rd() {
    thirdOld = Read_Byte();  //Get Current Data --> WHAT IS PINA
    thirdNew = Read_Byte();  //Get 2nd Data

  if (thirdNew == thirdOld) {
    ThirdByte = thirdNew;  //Get Stable Data
    return ThirdByte;
  }
  else {
    Get_3rd();
  }
}

byte Get_LSB() {
  lsbOld = Read_Byte();  //Get Current Data --> WHAT IS PINA
  lsbNew = Read_Byte();  //Get 2nd Data

  if (lsbNew == lsbOld) {
    LSB = lsbNew;  //Get Stable Data
    return LSB;
  }
  else {
    Get_LSB();
  }
}

byte Read_Byte() {
  byte requestedByte = 0;

  bitWrite(requestedByte, 0, digitalRead(6));
  bitWrite(requestedByte, 1, digitalRead(7));
  bitWrite(requestedByte, 2, digitalRead(8));
  bitWrite(requestedByte, 3, digitalRead(9));
  bitWrite(requestedByte, 4, digitalRead(10));
  bitWrite(requestedByte, 5, digitalRead(11));
  bitWrite(requestedByte, 6, digitalRead(12));
  bitWrite(requestedByte, 7, digitalRead(13));

  return requestedByte;
}
