// Wiring Arduino Code

int xyzPins[] = {13, 12, 25};   //x,y,z pins
void setup() {
  Serial.begin(9600);
  pinMode(xyzPins[2], INPUT_PULLUP);  //z axis is a button.
  pinMode(17, INPUT_PULLUP);  //button
}

void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);
  int buttonVal = digitalRead(17); 
  Serial.print(xVal);
  Serial.print("x");
  Serial.print(yVal);
  Serial.print("y");
  Serial.print(zVal);
  Serial.print("z");
  Serial.print(buttonVal);
  Serial.print("b");
  Serial.print('\n');

  delay(100);
}
