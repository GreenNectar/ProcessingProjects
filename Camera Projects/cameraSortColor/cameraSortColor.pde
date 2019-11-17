// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QLHMtE5XsMs

import processing.video.*;

Capture video;
Capture video2;
PImage prev;

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
color[] colors = new color[640 * 480];


void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[1]);
  video.start();
  prev = createImage(640, 480, RGB);

  //colors = new color[video.width * video.height];

  // Start off tracking for red
}

void captureEvent(Capture video) {
  prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw() {
  video.loadPixels();
  prev.loadPixels();
  image(video, 0, 0);

  loadPixels();
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int current = x + y * video.width;
      //float h = hue(video.pixels[current]);
      //float s = saturation(video.pixels[current]);
      //float b = brightness(video.pixels[current]);
      float r = red(video.pixels[current]);
      float g = green(video.pixels[current]);
      float b = blue(video.pixels[current]);
      pixels[current] = color((255 - g) * 2, 255 - b, r);//color(pixels[current]);
      //colorMode(HSB);
      //pixels[current] = color((h + s) / 2, (s + h) / 2, (b + h) / 2);//color(pixels[current]);
      //color currentColor = video.pixels[current];
    }
  }
  updatePixels();

  text(frameRate, 40, height - 10);
}
