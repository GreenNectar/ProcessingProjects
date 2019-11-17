class Point {

  float posx, posy;
  float direction;
  float mouseDist = 50;
  float pointDist = 100;

  Point() {
    posx = random(width);
    posy = random(height);
    direction = random(TWO_PI);
  }

  void move(float speed) {
    posx += speed * cos(direction);
    posy += speed * sin(direction);

    checkBoundary();

    //checkMouse();
  }

  void renderPoint() {
    ellipse(posx, posy, 10, 10);
  }

  void renderLines() {
    joinOtherPoints();
  }

  void checkBoundary() {
    if (posx > width || posx < 0) {
      posx = width - posx;
    }

    if (posy > height || posy < 0) {
      posy = height - posy;
    }
  }

  void joinOtherPoints() {

    for (Point point : points) { 
      if (point != this) {
        float distance = distSqr(point.posx, point.posy, posx, posy);
        if (distance < sq(pointDist)) {
          float alpha = map(distance, 0, sq(pointDist), 255, 0);
          stroke(255, 255, 255, alpha);
          line(posx, posy, point.posx, point.posy);
        }
      }
    }

    //float distance = distSqr(mouseX, mouseY, posx, posy);
    //if (distance < sq(pointDist)) {
    //  float alpha = map(distance, 0, sq(pointDist), 255, 0);
    //  stroke(255, 255, 255, alpha);
    //  line(posx, posy, mouseX, mouseY);
    //}
  }

  void checkMouse() {
    if (distSqr(mouseX, mouseY, posx, posy) > sq(mouseDist)) {
    }
  }

  float distSqr(float x1, float y1, float x2, float y2) {
    return sq(x2 - x1) + sq(y2 - y1);
  }
}
