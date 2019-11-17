// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QLHMtE5XsMs

import processing.video.*;

Capture video;
Capture video2;
PImage prev;

float threshold = 50;//25;

float motionX = 0;
float motionY = 0;

float lerpX = 0;
float lerpY = 0;
float xPrev = 0;
float yPrev = 0;

int iniTimer = 4;
int timer = iniTimer;
boolean added = false;
ArrayList<float[]> oldLocations = new ArrayList<float[]>();


void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[1]);
  video2 = video;
  video.start();
  video2.start();
  prev = createImage(640, 480, RGB);
  // Start off tracking for red
}


void mousePressed() {
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  video.loadPixels();
  prev.loadPixels();
  image(video2, 0, 0);

  //threshold = map(mouseX, 0, width, 0, 100);


  int count = 0;

  float avgX = 0;
  float avgY = 0;

  loadPixels();
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      color prevColor = prev.pixels[loc];
      float r2 = red(prevColor);
      float g2 = green(prevColor);
      float b2 = blue(prevColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d > threshold*threshold) {
        //stroke(255);
        //strokeWeight(1);
        //point(x, y);
        avgX += x;
        avgY += y;
        count++;
        pixels[loc] = color(255);
      } else {
        pixels[loc] = color(0);
      }
    }
  }
  updatePixels();

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (count > 20) { 
    motionX = avgX / count;
    motionY = avgY / count;
    // Draw a circle at the tracked pixel
  }

  lerpX = lerp(lerpX, motionX, 0.25); 
  lerpY = lerp(lerpY, motionY, 0.25); 

  //image(video, 0, 0);

  if (lerpX == xPrev && lerpY == yPrev) {
    if (timer > 0) {
      timer--;
    } else {
      if (added == false) {
        float[] loc = {lerpX, lerpY};
        oldLocations.add(loc);
        added = true;
      }
    }
  } else {
    timer = iniTimer;
    added = false;
  }
  
  strokeWeight(2.0);
  stroke(0);
  for (int i = 2; i < oldLocations.size(); i++) {
    float brightness = (255/oldLocations.size()) * i;
    fill(brightness);
    float[] location = oldLocations.get(i);
    ellipse(location[0], location[1], 36, 36);
  }

  xPrev = lerpX;
  yPrev = lerpY;

  fill(255, 255, 255);
  strokeWeight(2.0);
  stroke(0);
  ellipse(lerpX, lerpY, 36, 36);
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}
