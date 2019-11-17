float t = 0;
float scale = 1;
float n = 0.02;
int seed = (int) random(100000);
ArrayList<float[]> points = new ArrayList<float[]>();





void setup() {
  size(500, 500);
}





void draw() {
  //noLoop();
  //t = mouseY;
  //n = mouseX / width / 100;
  t += 1;
  drawIsland(seed);
  text("Seed : " + seed, 20, 20);
  text("Time : " + t, 20, 35);
}



void mouseClicked() {
  t = 0;
  seed = (int) random(100000);
  drawIsland(seed);
  text("Seed - " + seed, 20, 20);
}



void drawIsland(int seed) {
  colorMode(RGB);
  background(255);
  randomSeed(seed);
  noiseSeed(seed);
  //colorMode(HSB);
  loadPixels();
  n *= scale;

  for (int y = 0; y < height; y++) {

    for (int x = 0; x < width; x++) {
      int index = x + (y * width);
      color col = color(0);
      float time = t /0100;
      float val = noise(x * n, y * n, time) * map(noise(x*n/8, y*n/8, time+10), 0.3, 0.7, 0, 1);

      if (val <= 0.3) {
        col = color(0, 0, 200);
      }
      if (val > 0.3) {
        col = color(0, 0, 255);
      }
      if (val > 0.46) {
        col = color(100, 100, 255);
      }
      if (val > 0.5) {
        col = color(255, 255, 0);
      }
      if (val > 0.53) {
        col = color(50, 255, 50);
      }
      if (val > 0.6) {
        col = color(40, 200, 40);
      }
      if (val > 0.65) {
        col = color(130);
      }
      if (val > 0.7) {
        col = color(170);
      }
      if (val > 0.76) {
        col = color(200);
      }
      if (val > 0.88) {
        col = color(240, 120, 20);
      }
      if (val > 0.524 && val < 0.526 && random(1) < sq(n*5)) {
        float[] point = {x, y};
        points.add(point);
        //ellipse(x, y, 5, 5);
      }
      pixels[index] = col;
    }
  }

  updatePixels();

  for (int i = 0; i < points.size(); i++) {
    float[] point = points.get(i);
    float x = point[0];
    float y = point[1];
    //square(x - 2.5, y - 2.5, x + 2.5, y + 2.5);
    drawHouse(x, y, 10);
    //ellipse(point[0], point[1], 5, 5);
  }
  points = new ArrayList<float[]>();
}



void drawHouse(float x, float y, float size) {
  float s = size/2;
  float[][] housePoints = {{x-s, y+s}, {x-s, y-s}, {x, y-(9*size/10)}, {x+s, y-s}, {x+s, y+s}};
  beginShape();
  for (int i = 0; i < housePoints.length; i++) {
    float[] point = housePoints[i];
    float xPos = point[0];
    float yPos = point[1];
    vertex(xPos, yPos);
  }
  endShape(CLOSE);
}
