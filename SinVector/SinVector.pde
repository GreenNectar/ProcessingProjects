int vectors = 20;
float t = 0;
float amount = 0.001;
int pAmount = 10000;
int steps = 1000;
ArrayList<Point> points = new ArrayList<Point>();

void setup() {
  size(800, 800);

  //for (int p = 0; p < pAmount; p++) {
  //  Point point = new Point(0, random(-60, 60), random(TWO_PI), 5, random(0.04, 0.004), 10);
  //  points.add(point);
  //}
}


void draw() {
  colorMode(RGB);
  background(69);
  stroke(0);
  strokeWeight(5);
  t+=0.01;
  translate(0, height/2);

  //ShowVectors();

  if (points.size() < pAmount) {
    for (int p = 0; p < pAmount / steps; p++) {
      AddNewPoint();
    }
  }

  noStroke();
  //colorMode(RGB);
  //fill(180, 0, 255);
  colorMode(HSB);
  for (int p = 0; p < points.size(); p++) {
    Point point = points.get(p);
    point.Move();

    if (point.x > width + 200) {
      points.remove(point);
      AddNewPoint();
    }


    float hue = map(point.dir, -PI/4, PI/4, 210, 170);
    fill(hue, 255, 255);

    point.Render();
  }
}

void AddNewPoint() {
  Point temp = new Point(random(-400, 200), random(-60, 60), random(-PI/4, PI/4), 5, random(40, 60), random(5, 6), 10);
  points.add(temp);
}

void ShowVectors() {
  float w = width/vectors;
  for (int x = 0; x < width+w; x+=w) {
    for (int y = -height/2; y < (height/2)+w; y+=w) {
      //float a = map(noise(x * amount, y * amount, t), 0, 1, 0, TWO_PI);
      float a = map(y, -height/2, height/2, PI/2, -PI/2);
      float xPos = w * cos(a);
      float yPos = w * sin(a);
      line(x, y, x + xPos, y + yPos);
    }
  }
}
