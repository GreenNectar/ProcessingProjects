import processing.video.*;
Movie myMovie;

import java.awt.Robot;
import java.awt.image.BufferedImage;
import java.awt.Rectangle;
Robot robot;

char[] characters = {' ', '░', '▒', '▓', '█'};
char[] values = {'N', 'R', 'G', 'Y', 'B', 'P', 'C', 'W'};

Rectangle r;

void setup() {
  size(1600, 900);

  myMovie = new Movie(this, "Ash speedhack.mp4");
  myMovie.loop();

  //try {
  //  robot = new Robot();
  //} 
  //catch (Exception e) {
  //  println(e.getMessage());
  //}

  r = new Rectangle(-1600, 160, width, height);
}

PImage img2;
PImage prev;
float threshold = 25;

float a = 0;
void draw() {

  background(0);

  //GetScreen();
  //GetScreen();



  //scale(0.85);
  image(myMovie, 0, 0);


  //DrawRectangle();

  noStroke();
  a+=1;
  //RenderCircles();
  //scale(1/0.85);
  //RenderAsText(1);

  //BufferedImage img1 = robot.createScreenCapture(r);
  if (img2 != null) {
    prev = createImage(img2.width, img2.height, RGB);
    prev.copy(img2, 0, 0, img2.width, img2.height, 0, 0, img2.width, img2.height);
    prev.updatePixels();
    prev.loadPixels();
    img2.loadPixels();
  }
  //img2 = new PImage(img1);
  img2 = myMovie;

  int count = 0;
  if (img2 != null && prev != null) {
    loadPixels();
    // Begin loop to walk through every pixel
    for (int x = 0; x < img2.width; x+=10) {
      for (int y = 0; y < img2.height; y+=10) {
        int loc = x + y * img2.width;
        // What is current color
        color currentColor = img2.pixels[loc];
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
          count++;
        }
      }
    }
    updatePixels();
  }
  
  image(img2, 0, 0);

  //println(count);
  count/=8;
  float mult = float(count) / ((width/20) * (height/20));
  println(mult);
  mult = map(mult, 0, 1, 0.5, 8);

  RenderScreenAsText(img2, mult);

  //noLoop();
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void movieEvent(Movie m) {
  m.read();
}

void RenderScreenAsText(PImage image, float scale) {
  color[][] finalPixels = new color[width][height];
  //image.loadPixels();
  for (int x = 0; x < width; x+=scale * 10) {
    for (int y = 0; y < height; y+=scale * 10) {
      int index = x + y * width;
      color pix = image.pixels[index];
      finalPixels[x][y] = color(red(pix), green(pix), blue(pix));
      //pixels[index] = color(255, 0, 0);
    }
  }
  background(0);

  for (int x = 0; x < width; x+=scale * 10) {
    for (int y = 0; y < height; y+=scale * 10) {
      color val = finalPixels[x][y];

      float r = red(val);
      float g = green(val);
      float b = blue(val);
      char c = ' ';

      //val = toFourBitColor(val);

      if ((r + g + b) / 3 < 25) {
        c = characters[0];
      }
      if ((r + g + b) / 3 > 25) {
        c = characters[1];
      }
      if ((r + g + b) / 3 > 90) {
        c = characters[2];
      }
      if ((r + g + b) / 3 > 170) {
        c = characters[3];
      }
      if ((r + g + b) / 3 > 240) {
        c = characters[4];
      }



      fill(val);
      textSize(scale * 10);
      text(c, x, y);
    }
  }
}

void RenderAsText(float scale) {
  color[][] finalPixels = new color[width][height];
  loadPixels();

  for (int x = 0; x < width; x+=scale * 10) {
    for (int y = 0; y < height; y+=scale * 10) {
      int index = x + y * width;
      finalPixels[x][y] = color(red(pixels[index]), green(pixels[index]), blue(pixels[index]));
      //pixels[index] = color(255, 0, 0);
    }
  }
  updatePixels();
  background(0);

  for (int x = 0; x < width; x+=scale * 10) {
    for (int y = 0; y < height; y+=scale * 10) {
      color val = finalPixels[x][y];

      float r = red(val);
      float g = green(val);
      float b = blue(val);
      char c = ' ';

      //val = toFourBitColor(val);

      if ((r + g + b) / 3 < 25) {
        c = characters[0];
      }
      if ((r + g + b) / 3 > 25) {
        c = characters[1];
      }
      if ((r + g + b) / 3 > 90) {
        c = characters[2];
      }
      if ((r + g + b) / 3 > 170) {
        c = characters[3];
      }
      if ((r + g + b) / 3 > 240) {
        c = characters[4];
      }



      fill(val);
      textSize(scale * 10);
      text(c, x, y);
    }
  }
}

void GetScreen() {
  Rectangle r = new Rectangle(-1600, 160, width, height);
  BufferedImage img1 = robot.createScreenCapture(r);
  PImage img2 = new PImage(img1);
  image(img2, 0, 0);
}

int toThreeBitColor(int randomColor) {
  int r, g, b;

  r = (randomColor >> 16) & 128;
  r = r | (r >> 1);
  r = r | (r >> 2);
  r = r | (r >> 4);

  g = (randomColor >> 8) & 128;
  g = g | (g >> 1);
  g = g | (g >> 2);
  g = g | (g >> 4);

  b = randomColor & 128;
  b = b | (b >> 1);
  b = b | (b >> 2);
  b = b | (b >> 4);

  return 0xff000000 | (r << 16) | (g << 8) | b;
}

int toFourBitColor(int randomColor) {
  int r, g, b;

  r = (randomColor >> 32) & 83;
  r = r | (r >> 1);
  r = r | (r >> 2);
  r = r | (r >> 4);
  r = r | (r >> 8);

  g = (randomColor >> 16) & 83;
  g = g | (g >> 1);
  g = g | (g >> 2);
  g = g | (g >> 4);
  g = g | (g >> 8);

  b = (randomColor >> 8) & 83;
  b = b | (b >> 1);
  b = b | (b >> 2);
  b = b | (b >> 4);
  b = b | (b >> 8);

  return 0xff000000 | (r << 32) | (g << 16) | b;
}

void DrawRectangle() {
  pushMatrix();
  translate(width/2, height/2);
  beginShape();
  float sSize = 300;
  float x1 = sSize * cos(radians(-a));
  float y1 = sSize * sin(radians(-a));
  float x2 = sSize * cos(radians(-a + 90));
  float y2 = sSize * sin(radians(-a + 90));
  float x3 = sSize * cos(radians(-a + 180));
  float y3 = sSize * sin(radians(-a + 180));
  float x4 = sSize * cos(radians(-a + 270));
  float y4 = sSize * sin(radians(-a + 270));
  fill(255);
  vertex(x1, y1);
  vertex(x2, y2);
  vertex(x3, y3);
  vertex(x4, y4);
  endShape(CLOSE);
  popMatrix();
}

void RenderCircles() {
  float dist = 120;
  float size = 250;
  float xp = dist * cos(radians(a));
  float yp = dist * sin(radians(a));
  colorMode(RGB);
  fill(255, 0, 0);
  ellipse(width/2 + xp, height/2 + yp, size, size);
  xp = dist * cos(radians(a + 120));
  yp = dist * sin(radians(a + 120));
  fill(0, 255, 0);
  ellipse(width/2 + xp, height/2 + yp, size, size);
  xp = dist * cos(radians(a + 240));
  yp = dist * sin(radians(a + 240));
  fill(0, 100, 255);
  ellipse(width/2 + xp, height/2 + yp, size, size);
}
