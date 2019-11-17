import processing.video.*;
Movie myMovie;


char[] characters = {' ', '░', '▒', '▓', '█'};
char[] values = {'N', 'R', 'G', 'Y', 'B', 'P', 'C', 'W'};


void setup() {
  size(1440, 900);

  //myMovie = new Movie(this, "Idubbztvpuke.mp4");
  //myMovie.loop();
}

float a = 0;
void draw() {

  background(0);

  //image(myMovie, 0, 0);
  scale(1);

  DrawRectangle();

  noStroke();
  a+=0.5;
  RenderCircles();

  RenderAsText(10);

  //noLoop();
}

void movieEvent(Movie m) {
  m.read();
}

void RenderAsText(float scale) {
  color[][] finalPixels = new color[width][height];
  loadPixels();
  for (int x = 0; x < width; x+=scale) {
    for (int y = 0; y < height; y+=scale) {
      int index = x + y * width;
      finalPixels[x][y] = color(red(pixels[index]), green(pixels[index]), blue(pixels[index]));
      //pixels[index] = color(255, 0, 0);
    }
  }
  updatePixels();
  background(0);

  for (int x = 0; x < width; x+=scale) {
    for (int y = 0; y < height; y+=scale) {
      color val = finalPixels[x][y];
      //color col = color(0);
      //println("red - " + red(val) + ": " + "green - " + green(val) + ": " + "blue - " + blue(val) + ": ");
      int r = 0, g = 0, b = 0;
      if (red(val) > 128) {
        r = 1;
      }
      if (green(val) > 128) {
        g = 2;
      }
      if (blue(val) > 128) {
        b = 4;
      }
      fill(val);
      textSize(scale);
      text(values[r + g + b], x, y);
      //rect(x, y, x+10, y+10);
    }
  }
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
