
int points = 200;
int s = 20;
float t = 0;

float cx, cy;
float angle = 0;

int minHeight = -250;
int maxHeight = 1500;
int heightAdd = 100;
float noiseAmount = 2;

int[][] h = {};

void setup() {
  size(800, 800, P3D);

  h = new int[points][points];

  for (int x = 0; x < points; x++) {
    for (int y = 0; y < points; y++) {
      h[x][y] = (int) map(sq(noise(x * noiseAmount / points, y * noiseAmount / points, t)), 0, 1, minHeight, maxHeight);
    }
  }
  background(0);
}

void draw() {
  t+=0.0025;
  for (int x = 0; x < points; x++) {
    for (int y = 0; y < points; y++) {
      h[x][y] = (int) map(sq(noise(x * noiseAmount / points, y * noiseAmount / points, t)), 0, 1, minHeight, maxHeight);
    }
  }

  float centerX = (width/2) - (s * (points - 1) / 2);
  float centerY = (height/2) - (s * (points - 1) / 2);
  //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  camera(width/2, height/2, 500, width/2, height/2, 0, -1, 0, 0);

  //angle = map(mouseX, 0, width, 0, 360);
  //rotateZ(radians(angle));

  rotateY(PI / 4);
  translate(cx, cy, 0);
  translate(centerX + 1000, centerY, 0);
  //rotateZ(-radians(angle));

  colorMode(RGB);
  background(0);
  lights();

  //cx += ((width/2) - (mouseX)) / 100;
  //cy += ((height/2) - (mouseY)) / 100;

  //translate(-s*(points - 1) / 2, -s*(points - 1) / 2, 0);

  for (int x = 0; x < points - 1; x++) {
    for (int y = 0; y < points - 1; y++) {
      noStroke();

      CreateTriangle(x, y, 0);
      CreateTriangle(x, y, 1);
    }
  }

  Move();
}

void Move() {
  if (keyPressed) {
    float s = 50;
    if (key == 'w') { 
      float x = s * cos(radians(angle + 180));
      float y = s * sin(radians(angle));
      cx+=x;
      cy+=y;
    }
    if (key == 'a') { 
      float x = s * cos(radians(angle + 90));
      float y = s * sin(radians(angle + 90));
      cx+=x;
      cy+=y;
    }
    if (key == 's') { 
      float x = s * cos(radians(angle));
      float y = s * sin(radians(angle));
      cx+=x;
      cy+=y;
    }
    if (key == 'd') { 
      float x = s * cos(radians(angle + 270));
      float y = s * sin(radians(angle + 270));
      cx+=x;
      cy+=y;
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  heightAdd -= e * 10;
}

//void keyPressed() {
//  //if (key == 'w') { 
//  //  cy+=10;
//  //}
//  //if (key == 'a') { 
//  //  cx+=10;
//  //}
//  //if (key == 's') { 
//  //  cy-=10;
//  //}
//  //if (key == 'd') { 
//  //  cx-=10;
//  //}

//  if (key == 'w') { 
//    float x = 10 * cos(radians(angle + 180));
//    float y = 10 * sin(radians(angle));
//    cx+=x;
//    cy+=y;
//  }
//  if (key == 'a') { 
//    float x = 10 * cos(radians(angle + 90));
//    float y = 10 * sin(radians(angle + 90));
//    cx+=x;
//    cy+=y;
//  }
//  if (key == 's') { 
//    float x = 10 * cos(radians(angle));
//    float y = 10 * sin(radians(angle));
//    cx+=x;
//    cy+=y;
//  }
//  if (key == 'd') { 
//    float x = 10 * cos(radians(angle + 270));
//    float y = 10 * sin(radians(angle + 270));
//    cx+=x;
//    cy+=y;
//  }
//}

void CreateTriangle(int x, int y, int triangle) {
  float val;
  if (triangle == 0) {
    val = map(noise((x + 2/3) * noiseAmount / points, (y + 0.5) * noiseAmount / points, t), 0, 1, 0, 255) + 50;
  } else {
    val = map(noise((x + 0.5) * noiseAmount / points, (y + 1/3) * noiseAmount / points, t), 0, 1, 0, 255) + 50;
  }
  color col = color(0, 0, 0);

  if (val <= 76.5) {
    col = color(0, 0, 200);
  }
  if (val > 76.5) {
    col = color(0, 0, 255);
  }
  if (val > 117.3) {
    col = color(100, 100, 255);
  }
  if (val > 127.5) {
    col = color(255, 255, 0);
  }
  if (val > 135.15) {
    col = color(50, 255, 50);
  }
  if (val > 153) {
    col = color(40, 200, 40);
  }
  if (val > 165.75) {
    col = color(130);
  }
  if (val > 178.5) {
    col = color(170);
  }
  if (val > 193.8) {
    col = color(200);
  }
  if (val > 220) {
    col = color(255);
  }
  //if (val > 200) {//224.4) {
  //  col = color(240, 120, 20);
  //}

  fill(col);

  if (triangle == 0) {
    //Triangle1
    beginShape();
    vertex(x * s, y * s, h[x][y] + heightAdd);
    vertex((x + 1) * s, (y + 1) * s, h[x+1][y+1] + heightAdd);
    vertex(x * s, (y + 1) * s, h[x][y+1] + heightAdd);
    endShape(CLOSE);
  } else {
    //Triangle2
    beginShape();
    vertex(x * s, y * s, h[x][y] + heightAdd);
    vertex((x + 1) * s, y * s, h[x+1][y] + heightAdd);
    vertex((x + 1) * s, (y + 1) * s, h[x+1][y+1] + heightAdd);
    endShape(CLOSE);
  }
}
