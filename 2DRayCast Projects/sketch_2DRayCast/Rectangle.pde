class Rectangle {

  Boundary[] bounds;

  Rectangle(float x1, float y1, float x2, float y2) {
    bounds = new Boundary[4];
    bounds[0] = new Boundary(x1, y1, x2, y1);
    bounds[1] = new Boundary(x2, y1, x2, y2);
    bounds[2] = new Boundary(x2, y2, x1, y2);
    bounds[3] = new Boundary(x1, y2, x1, y1);
    for(Boundary bound : bounds) {
      boundaries.add(bound);
    }
  }
}
