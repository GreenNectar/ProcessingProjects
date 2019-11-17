class Ray {

  PVector pos, dir;

  Ray(PVector position, float direction) {
    pos = position;
    dir = PVector.fromAngle(direction);
  }

  void lookAt(float x, float y) {
    dir.x = x - pos.x;
    dir.y = y - pos.y;
    dir.normalize();
  }

  void showLine() {
    stroke(255);
    push();
    translate(pos.x, pos.y);
    line(0, 0, dir.x * 10, dir.y * 10);
    pop();
  }

  void showDot() {
    stroke(255);
    push();
    translate(pos.x, pos.y);
    ellipse(0, 0, 4, 4);
    pop();
  }

  PVector cast(Boundary bound) {
    float x1 = bound.a.x;
    float y1 = bound.a.y;
    float x2 = bound.b.x;
    float y2 = bound.b.y;

    float x3 = pos.x;
    float y3 = pos.y;
    float x4 = pos.x + dir.x;
    float y4 = pos.y + dir.y;

    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) {
      return null;
    }

    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    float u = - ((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;

    if (t > 0 && t < 1 && u > 0) {
      PVector point = new PVector();
      point.x = x1 + t * (x2 - x1);
      point.y = y1 + t * (y2 - y1);
      return point;
    } else {
      return null;
    }
  }
}
