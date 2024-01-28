#include <HCSR04.h>
#include <Servo.h>

UltraSonicDistanceSensor distanceSensor(6, 7);
UltraSonicDistanceSensor distanceSensor2(5, 4);
Servo servoMotor;

int delayTime = 5;
long d;
long d2; 

void setup() {
  Serial.begin(9600);

  //Check the servo motor working
  servoMotor.attach(3);
  servoMotor.write(180);
  delay(1000);
  servoMotor.write(0);
  delay(1000);

}

void loop() {

  //Get ultrasonic sensor reading
  for (int i = 1; i < 180; i++) {
    readSensors();      
    Serial.print(i);      
    Serial.print(d);        
    Serial.print(",");       
    Serial.println(d2);      
    servoMotor.write(i);     
    delay(delayTime);      
  }

  for (int i = 180; i > 1; i--) {  
    readSensors();     
    Serial.print(i);   
    Serial.print(",");   
    Serial.print(d);     
    Serial.print(",");   
    Serial.println(d2);     
    servoMotor.write(i);    
    delay(delayTime);     
  }
}

void readSensors() {
  d = distanceSensor.measureDistanceCm();
  d2 = distanceSensor2.measureDistanceCm();
}
