
ArrayList<PVector> lastPoints = new ArrayList<PVector>();
ArrayList<PVector> allPoints = new ArrayList<PVector>();
//float distance = 2f;
float distance = 3f;
//float distance = 5f;
int position = 1;
//int maxSteps = 500;
int maxSteps = 330;
//int maxSteps = 198;

void setup() {
  size(1001, 1001);
  background(0);
  //background(69);

  PVector firstPoint = new PVector(width/2, height/2);
  lastPoints.add(firstPoint);
  allPoints.add(firstPoint);

  stroke(220, 255, 0);
  strokeWeight(1);
  fill(255);

  //noLoop();
}

void mousePressed() {
  redraw();
}

int step = 0;
boolean saved = false;
int maxLastPoints = 0;

void draw() {
  //stroke(255);
  //stroke(220, 255, 0);

  //if (lastPoints.size() > maxLastPoints) {
  //  maxLastPoints = lastPoints.size();
  //}

  colorMode(HSB);
  float hue = map(step, 0, maxSteps, 0, 255f) % 255f;
  //float hue = map(lastPoints.size(), 0, 5000, 0, 255f) % 255f;
  //float hue = map(lastPoints.size(), 0, maxLastPoints, 0, 255f) % 255f;
  stroke(hue, 255, 255);

  //DrawPreviousPoints();
  if (step < maxSteps) {
    //stroke(100, 150, 255);
    //stroke(255);
    CreateNextPoint();
    //save("data/Frame-" + str(step) + ".png");
    step++;
  } else {
    if (saved == false) {
      save("Final.png");
      saved = true;
    }
  }
  //print(lastPoints.get(0));
}

void CreateNextPoint() {

  for (int i = lastPoints.size() - 1; i >= 0; i--) {
    PVector origin = lastPoints.get(i);
    lastPoints.remove(i);

    if (GetFreePoint(origin)) {
      if (position % 2 == 0) {
        PVector one = new PVector(origin.x - distance, origin.y);
        PVector two = new PVector(origin.x + distance, origin.y);
        line(one.x, one.y, two.x, two.y);
        allPoints.add(one);
        lastPoints.add(one);
        allPoints.add(two);
        lastPoints.add(two);
      } else {
        PVector one = new PVector(origin.x, origin.y - distance);
        PVector two = new PVector(origin.x, origin.y + distance);
        line(one.x, one.y, two.x, two.y);
        allPoints.add(one);
        lastPoints.add(one);
        allPoints.add(two);
        lastPoints.add(two);
      }
    }
  }
  position++;
}

void DrawPreviousPoints() {
  for (int i = 1; i < allPoints.size() - 1; i+=2) {
    PVector point1 = allPoints.get(i);
    PVector point2 = allPoints.get(i + 1);

    line(point1.x, point1.y, point2.x, point2.y);
  }
}

boolean GetFreePoint(PVector point) {
  int count = 0;
  for (int i = 0; i < allPoints.size(); i++) {
    PVector check = allPoints.get(i);

    if (point.x == check.x && point.y == check.y) {
      count++;
    }

    if (count > 1) {
      return false;
    }
  }
  return true;
}
