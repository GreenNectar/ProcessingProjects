class Circle {

  Boundary[] bounds;

  Circle(float x, float y, float scale, int resolution, color col) {
    bounds = new Boundary[resolution];

    for (int i = 0; i < resolution; i++) {
      float dir1 = (float(i) / float(resolution)) * PI * 2f;
      float dir2 = (float(i + 1) / float(resolution)) * PI * 2f;

      float x1 = scale * cos(dir1);
      float y1 = scale * sin(dir1);
      float x2 = scale * cos(dir2);
      float y2 = scale * sin(dir2);

      Boundary bound = new Boundary(x + x1, y + y1, x + x2, y + y2, col);
      boundaries.add(bound);
      bounds[i] = bound;
    }
  }
}
