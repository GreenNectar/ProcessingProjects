class Segment {

  PVector a, b;

  Segment(PVector a_, PVector b_) {
    a = a_;
    b = b_;
  }

  ArrayList<Segment> segment(int points) {

    points+=2;

    if (points < 4) {
      points = 4;
    }

    int amount = points;

    ArrayList<Segment> segments = new ArrayList<Segment>();

    PVector start = a.copy();
    PVector diff = PVector.sub(b, a);

    float[] rots = {-60, 120, -60, 0};

    float[] triRots = {-60, 120, -60, 0};
    float[] quadRots = {-90, 90, 90, -90, 0};
    float[] pentRots = {-108, 72, 72, 72, -108, 0};
    float[] hexaRots = {-90, 90, 90, -90, 0};

    float[][] roties = {triRots, quadRots, pentRots};

    diff.setMag(PVector.dist(a, b) / (float(amount) - (points - 3)));
    rots = roties[points - 5];




    for (int i = 0; i < amount - 1; i++) {
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
