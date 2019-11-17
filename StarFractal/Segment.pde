class Segment {

  PVector a, b;

  Segment(PVector a_, PVector b_) {
    a = a_;
    b = b_;
  }

  ArrayList<Segment> segment(boolean isSquare) {

    int amount = 4;

    if (isSquare) {
      amount = 5;
    }

    ArrayList<Segment> segments = new ArrayList<Segment>();

    PVector start = a.copy();
    PVector diff = PVector.sub(b, a);

    float[] rots = {-60, 120, -60, 0};

    float[] triRots = {-60, 120, -60, 0};
    float[] quadRots = {-90, 90, 90, -90, 0};

    if (isSquare) {
      diff.setMag(PVector.dist(a, b) / (float(amount) - 2));
      rots = quadRots;
    } else {
      diff.setMag(PVector.dist(a, b) / (float(amount) - 1));
    }




    for (int i = 0; i < amount; i++) {
      PVector end = PVector.add(diff, start);
      diff.rotate(radians(rots[i]));
      Segment segment = new Segment(start, end);
      start = new PVector(end.x, end.y);
      segments.add(segment);
    }

    return segments;
  }

  void show() {
    line(a.x, a.y, b.x, b.y);
  }
}
