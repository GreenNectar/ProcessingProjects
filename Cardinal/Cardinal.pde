float r;
float rot = 0;
float factor = 0;
float speed = 0.005;
float hueStart = 140;//140;
float hueEnd = 200;//200;
float min = 1;
float max = 4;
int total = 1000;
int frames = 480;
int t = 0;

void setup() {
  size(400, 400);
  r = width/2 - 16;
}


void draw() {
  colorMode(RGB);
  background(0);


  //factor += speed;
  factor = map(sin(map(t, 0, frames, 0, TWO_PI)), -1, 1, min, max);
  t++;
  //factor = 0.8;

  translate(width/2, height/2);
  //rotate(rot);
  //rot = -map(factor - (factor % factor), 0, 1, 0, TWO_PI);

  strokeWeight(3);
  noFill();

  strokeWeight(1);
  colorMode(HSB);
  //for(int i = 0; i < total; i++) {
  //PVector v = getVector(i, total);
  //fill(255);
  //ellipse(v.x, v.y, 8, 8);
  //}

  for (int i = 0; i < total; i++) {
    PVector a = getVector(i, total);
    PVector b = getVector(i * factor, total);
    float hue = map(dist(a.x, a.y, b.x, b.y), 0, r*2, hueStart, hueEnd);
    stroke(hue, 255, 255);
    line(a.x, a.y, b.x, b.y);
  }

  stroke((hueStart + hueEnd) / 2, 255, 255);
  ellipse(0, 0, r*2, r*2);

  if (t < frames && t % 1 == 0) {
    //saveFrame("FRAME-######.png");
  }
}

PVector getVector(float index, float total) {
  float angle = map(index % total, 0, total, 0, TWO_PI);
  PVector v = PVector.fromAngle(angle + PI);
  v.mult(r);
  return v;
}
