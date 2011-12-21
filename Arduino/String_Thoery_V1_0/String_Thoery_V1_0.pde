/*
  String Thoery Code

 reads the box and outputs messages with routing containers.
 Also does DMX and shit

 created 29 Oct 2010
 by Myles Borins
 */
 
#include <DmxSimple.h>

//pin values
int lever1pin = 1;      // Lever Pin Biatch
int lever2pin = 0;      // Lever Pin Biatch
int button1pin = 12;    // Pin for button 1 my jigga
int button2pin = 10;    // Pin for button 2 my jigga

//Variable for the box
int lever1value = 0;    // variable to hold the analog value
int lever1lastvalue = 0;    // variable to hold the last analog value

int lever2value = 0;    // variable to hold the analog value
int lever2lastvalue = 0;    // variable to hold the last analog value

int button1value = 0;   // Variable to hold the digital value
int button1lastvalue = 0;   // Variable to hold the last digital value

int button2value = 0;   // Variable to hold the digital value
int button2lastvalue = 0;   // Variable to hold the digital value

//Variable for Checkign to send data
int serialcheck = 48;

//Variable for DMX-Serial SHIATE
int value = 0;
int channel;


void setup() {
  // open the serial port at 9600 bps:
  Serial.begin(9600);
  // set pinmode
  pinMode(button1pin, INPUT);
  pinMode(button2pin, INPUT);
  // Setup DMX
  DmxSimple.usePin(11);
  }

void loop() {
  
  int c;
  
  while(!Serial.available())
  {
    // Poll that shit:
    lever1value = analogRead(lever1pin);
    lever2value = analogRead(lever2pin);
    button1value = digitalRead(button1pin);
    button2value = digitalRead(button2pin);

    // print it out in many formats: Also check if value was recently sent
    if (lever1value != lever1lastvalue)
    {
      Serial.print("/lever1 ");       // print routing information
      Serial.println(lever1value);    // print value
      lever1lastvalue = lever1value;
    }
    
    if (lever2value != lever2lastvalue)
    {
      Serial.print("/lever2 ");       // print routing information
      Serial.println(lever2value);    // print value
      lever2lastvalue = lever2value;
    }
    
    if (button1value != button1lastvalue)
    {
      Serial.print("/button1 ");       // print routing information
      Serial.println(button1value);    // print value
      button1lastvalue = button1value;
    }
    
    if (button2value != button2lastvalue)
    {
      Serial.print("/button2 ");       // print routing information
      Serial.println(button2value);    // print value
      button2lastvalue = button2value;
    }
    
    // delay 10 milliseconds before the next reading:
    delay(10);
  }
  c = Serial.read();
  if ((c>='0') && (c<='9')) {
    value = 10*value + c - '0';
  } else {
    if (c=='c') channel = value;
    else if (c=='w') {
      DmxSimple.write(channel, value);
    }
    value = 0;
  }
}

