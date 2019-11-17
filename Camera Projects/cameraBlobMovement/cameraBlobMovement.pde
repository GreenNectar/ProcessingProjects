// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QLHMtE5XsMs

import processing.video.*;

Capture video;
Capture video2;
PImage prev;

float threshold = 45;//25;

color trackColor; 
float thresholdBlob = 40;
float distThreshold = 10;

ArrayList<Blob> blobs = new ArrayList<Blob>();

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
  trackColor = color(255, 255, 255);
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

  blobs.clear();

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
        pixels[loc] = color(255);
      } else {
        pixels[loc] = color(0);
      }
    }
  }
  updatePixels();

  for (int x = 0; x < width; x++ ) {
    for (int y = 0; y < height; y++ ) {
      int loc = x + y * width;
      // What is current color
      color currentColor = pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < thresholdBlob*thresholdBlob) {

        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }

  image(video, 0, 0);
  int amount = 0;
  for (Blob b : blobs) {
    if (b.size() > 20) {
      b.show();
      amount++;
    }
  }
  fill(255);
  text("Potential obects moving - " + amount, 10, 10);

  //image(video, 0, 0);
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}


float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}
