# Interactive Devices

# Guide: How to create an interactive device?

[*Click here to link to the github repository*](https://github.com/Amandaaa00/Interactive-Devices)

**Components needed:** ESP32 TTGO T-Display, a joystick, a button, computer

# Connecting wires
### 1. Connect the ESP32 to the bread board
Simply press the ESP32 into the bread board.
### 2. Connect the joystick
Following the tutorial [here](https://github.com/Freenove/Freenove_Ultimate_Starter_Kit_for_ESP32/blob/master/C/C_Tutorial.pdf) in Chapter 14. 
I connected the GND pin of joystick to G pin of ESP32, the +5V pin of joystick to ESP32's 3V pin, the VRx pin of joystick to ESP32's pin 13, the VRy pin of joystick to ESP32's pin 12, and the SW pin of joystick to ESP32's pin 25.
### 3. Connect the button
Following the previous tutorial again in Chapter 2.
I connected the upper pin of the button to ESP32's 17, and the lower pin of the button to ESP32's another G pin.

The picture of connected bread board is here.
![bread_board.jpg](bread_board.jpg)

# Write Arduino code
The Arduino code is written as uploaded in the git repository.
Note that I set the xyz pins into 13, 12, and 25 respectively, just as how I connected the wires. Also, I read the button value from pin 17.
Then the values of x,y,z from the joystick and the value of the button are printed out to the Serial, each followed by a character indicating whhich values it is. And then print a new line character in the end.
From here, we can test whether the joystick, ESP32, and button are connected to the computer correctly and whether interacting with the joystick and button and print their corresponding values on the computer
# Write Processing code
Firstly, we should make sure the value can be passed from the Arduino to the Processing. I used methods of readStringUntil and indexof methods to read the values of xyz and the button separately. The program I wrote can be found in the github repository.
# Use the interactive device
Firstly, connect the ESP32 to the computer and run the Arduino. Then run the Processing code.
Running this program, an animation interface will be created by Processing. Initially, there are 6 bubbles on the screen. They collide with each other freely and rise slowly to the top. When we scroll the joystick to different positions, and then press the button, there will be more bubbles created, which then collide with each other freely and slowly rise to the top. And when the joystick is pressed, the bubbles will change to different colors. Each time the joystick the pressed, the bubbles will all change to a randomly different color. 

The video of running the program and the resulting animation is here.
[]

# Possible Technical Issues and Difficulties
### 1. Unstable wire connection
The connection of joystick and button to the breadboard can be unstable, especially for the joystick. I noticed that the value of whether the joystick is pressed is continuously changing when it is not pressed, showing the connection of it is unstable. So in the Processing program, I avoid the function that would check the times or frequency of the joystick is not pressed.
### 2. Simulating the bubbles behavior
It's hard to simulate the bubbles behavior and making it seem realistic. The collide void, and move void are pretty complicated, and all of the bubbles must be in an array in order to deal with their interaction. I referenced some code from the Processing Example, and tried to find the best index of gravity, friction, and spring factors that have influence in the collide and move voids.

