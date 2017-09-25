//@version May 12, 2017

import processing.video.*;
import java.util.*;

Capture cam;
PFont font;
boolean savingImage;

final int TIMER_DURATION = 90; //how long save message displayed
int timer;
int messageBoxHeight = 35;
String instructions = "Press a key on the keyboard to save your image";

String[] categories = {"House", "Car", "Flower"};
char[] keyOptions = {'h', 'c', 'f'};

String infoCenterMessage = "WAITING...";
int infoCenterPadding = 15;
int infoCenterWidth = 300;
int INFO_CENTER_STATE = 0;
String guess = "";

void setup() {
  println("start setup");
  size(640, 480); //size(1920, 1080);

  font = createFont("Arial", 24, true);

  //setup video feed
  cam = new Capture(this, width, height, 30);
  cam.start();

  savingImage = false;
  timer = TIMER_DURATION;
  println("end setup");
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  pushMatrix();
  scale(1.0, -1.0);
  image(cam, 0, -height);
  popMatrix();

  if (savingImage) {
    //display the save message for timer amount of frames 
    if (timer > 0) {
      //println("display save message");
      displaySaveMessage();
      //println("decrement timer");
      timer--;
      //println("timer is " + timer);
    } else {
      savingImage = false;
      //reset timer
      //println("reset timer");
      timer = TIMER_DURATION;
    }
  }

  //display instructions
  fill(255);
  rect(0, 0, width, messageBoxHeight);
  textFont(font);
  fill(0);
  float textWidth = textWidth(instructions);
  text("Build a house with pieces below!", width/2-textWidth/2, 25);
}

void keyPressed() {
  println("image saved");
  //save image with timestamp for name (in sketch folder)
  String filename = System.currentTimeMillis() + ".jpg";
  cam.save(filename);

  savingImage = true; //triggers display of save message in draw()
}

void displaySaveMessage() {
  //display saving message
  fill(0);
  rect(0, height-messageBoxHeight, width, messageBoxHeight);
  textFont(font);
  fill(255);
  float textWidth = textWidth("Image saved");
  text("Image saved", width/2-textWidth/2, height - 10);
  println("text displayed");
}