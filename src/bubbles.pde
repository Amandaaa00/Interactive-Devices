import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port

String xVal;
String yVal;
String zVal;
String bVal;

float xpos;
float ypos;

int numBalls = 100;
float spring = 0.001;
float gravity = -0.003;
float friction = 0.06;
Ball[] balls = new Ball[numBalls];
int num = 6;
int i=0;
color[] colorList = {color(255,255,255,50), color(255,200,200,60), color(240,201,255,50), color(175,230,237,50), color(255,200,200,50), color(240,230,120,50)};
color[] colorList2 = {color(0), color(255,200,200), color(240,201,255), color(175,230,237), color(255,200,200), color(240,230,120)};

void setup() {
  size(640, 360);
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(30, 70), i, balls);
  }
  
  stroke(255,200,200);
  fill(255, 200, 200, 30);
  
  String portName = Serial.list()[2];
  System.out.println(portName);
  myPort = new Serial(this, portName, 9600);
  
}

void draw() {
  background(255);
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');    // read it and store it in val
    val =trim(val);
    if (val != null){
    xVal = val.substring(0, val.indexOf('x'));
    yVal = val.substring(val.indexOf('x')+1, val.indexOf('y'));
    zVal = val.substring(val.indexOf('y')+1, val.indexOf('z'));
    bVal = val.substring(val.indexOf('z')+1, val.indexOf('b'));
    }
  }
  
  System.out.println(val);
  System.out.println(xVal);
  System.out.println(yVal);
  System.out.println(zVal);
  System.out.println(bVal);
  
  System.out.println(mouseX);
  System.out.println(mouseY);
  ellipse(int(xVal), int(yVal), 2, 2);
  if (int(bVal) == 0) {
    balls[num] = new Ball(int(xVal)/5, int(yVal)/5, random(40, 80), num, balls);
    num = num+1;
    if (num == 100){
      num = 0;
    }
  }
  for (int i = 0; i < num; i++){
    Ball ball = balls[i];
    ball.collide();
    ball.move();
    ball.display();  
  }
  System.out.println(int(bVal));
  
  if (int(zVal) == 0){
    System.out.println("hi");
    //stroke(0);
    //fill(255, 200, 200, 30);
    stroke(colorList2[i%5]);
    fill(colorList[i%5]);
  }
  else {
    stroke(90,145,165);
    fill(156,214,234,40);
    i = i+1;
  }
  
  
}

Ball[] addBall(int x, int y){
  
  Ball[] balls = new Ball[numBalls+1];
  for (int i = 0; i < numBalls; i++){
           balls[i]=balls[i];
  }
  balls[numBalls] = new Ball(x, y, random(40, 80), numBalls, balls);
  numBalls = numBalls+1;
  return balls;
}


class Ball {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 
  
  void collide() {

    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  
  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
