// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QLHMtE5XsMs

import processing.video.*;

Capture video;
PImage temp;

float threshold = 0;//25;

float motionX = 0;
float motionY = 0;

float lerpX = 0;
float lerpY = 0;
float xPrev = 0;
float yPrev = 0;

int iniTimer = 4;
int timer = iniTimer;
boolean added = false;


void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[1]);
  video.start();
  temp = createImage(640, 480, RGB);
  //colors = new color[video.width * video.height];
  // Start off tracking for red
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  //image(video, 0, 0); // Displays the image from point (0,0) 
  video.loadPixels();
  // Create an opaque image of the same size as the original
  PImage edgeImg = createImage(video.width, video.height, RGB);
  // Loop through every pixel in the image.
  for (int y = 1; y < video.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < video.width-1; x++) { // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*video.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(video.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      edgeImg.pixels[y*video.width + x] = color(sum, sum, sum);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();
  image(edgeImg, 0, 0); // Draw the new image

  text(frameRate, 40, height - 10);
}

float[][] kernel = {{ -1, -1, -1}, 
  { -1, 8, -1}, 
  { -1, -1, -1}};
