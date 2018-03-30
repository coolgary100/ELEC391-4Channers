const int d0 = 6;
const int d1 = 7;
const int d2 = 8;
const int d3 = 9;
const int d4 = 10;
const int d5 = 11;
const int d6 = 12;
const int d7 = 13;
const int oe = 2;
const int sel1 = 3;
const int sel2 = 4;
const int rst = 5;


// System Clock Frequency
const unsigned long int CLK = 16001675;

int flag = 0;
byte totalByte = 0; 

// Values for external interupt.

void setup() {
    
  // initialize input pins:
  pinMode(d0, INPUT);
  pinMode(d1, INPUT);
  pinMode(d2, INPUT);
  pinMode(d3, INPUT);
  pinMode(d4, INPUT);
  pinMode(d5, INPUT);
  pinMode(d6, INPUT);
  pinMode(d7, INPUT);
  pinMode(sel1, OUTPUT);
  pinMode(sel2, OUTPUT);
  pinMode(oe, OUTPUT);
  pinMode(rst, OUTPUT);
  
  Serial.begin(9600);

  digitalWrite(rst, LOW);

}
void loop() {  

  digitalWrite(oe, LOW);
  digitalWrite(sel1, HIGH);
  digitalWrite(sel2, LOW);
  digitalWrite(rst, HIGH);

  //Serial.println(rst);
  
  bitWrite( totalByte, 0, digitalRead(d0));
  bitWrite( totalByte, 1, digitalRead(d1));
  bitWrite( totalByte, 2, digitalRead(d2));
  bitWrite( totalByte, 3, digitalRead(d3));
  bitWrite( totalByte, 4, digitalRead(d4));
  bitWrite( totalByte, 5, digitalRead(d5));
  bitWrite( totalByte, 6, digitalRead(d6));
  bitWrite( totalByte, 7, digitalRead(d7));

  Serial.println((double) totalByte);
  
  
}




