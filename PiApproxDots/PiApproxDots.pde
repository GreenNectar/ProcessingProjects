int step = 1000;
long amountOfPoints = 0;
long pointsInCircle = 0;
PVector middle;

void setup() {
  size(800, 800);
  middle = new PVector(width/2, height/2);
  background(0);
  //DrawMiddleCircle();
}



void draw() {
  fill(255);
  noStroke();
  for (int i = 0; i < step; i++) {
    PVector pos = new PVector(random(width), random(height));
    if (PVector.dist(pos, middle) < width/2) {
      pointsInCircle++;
      fill(0, 255, 0);
    } else {
      fill(255, 50, 0);
    }
    ellipse(pos.x, pos.y, 2, 2);
    amountOfPoints++;
  }
  DrawMiddleCircle();

  println(4 * (double)pointsInCircle / (double)amountOfPoints);
}

void DrawMiddleCircle() {
  stroke(50, 150, 255);
  strokeWeight(2);
  noFill();
  ellipse(middle.x, middle.y, width, height);
}
