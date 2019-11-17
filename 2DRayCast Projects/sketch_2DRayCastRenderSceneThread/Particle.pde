class Particle {

  PVector pos;
  Ray[] rays;

  Particle(int amountOfRays, float FOV) {
    pos = new PVector(width/2, height/2);
    rays = new Ray[amountOfRays];
    for (int i = 0; i < amountOfRays; i++) {
      rays[i] = new Ray(pos, radians(((float(i) / float(amountOfRays)) * FOV) - FOV / 2f));
    }
  }

  color render(ArrayList<Boundary> bounds) {
    fill(255);
    ArrayList<ColouredPoint> points = new ArrayList<ColouredPoint>();
    for (int i = 0; i < rays.length; i++) {
      Ray ray = rays[i];
      float record = sqrt((width*width) + (height*height));
      PVector closest = null;
      color closestCol = color(0);
      for (Boundary bound : bounds) {
        PVector point = ray.cast(bound);
        if (point != null) {
          float distance = PVector.dist(pos, point);
          if (distance < record) {
            record = distance;
            closest = point;
            closestCol = bound.col;
          }
          record = min(distance, record);
        }
      }
      if (closest != null) {
        ColouredPoint point = new ColouredPoint(closest, closestCol);
        points.add(point);
        //line(pos.x, pos.y, closest.x, closest.y);
      }
    }

    float r = 0;
    float g = 0;
    float b = 0;
    for (int i = 0; i < points.size(); i++) {
      float mult = sqrt(PVector.dist(pos, points.get(i).pos)) / brightness;
      r += red(points.get(i).col) / mult;
      g += green(points.get(i).col) / mult;
      b += blue(points.get(i).col) / mult;
    }
    r /= rays.length;
    g /= rays.length;
    b /= rays.length;
    color finalCol = color(r, g, b);

    return finalCol;
  }

  void update(float x, float y) {
    pos.x = x;
    pos.y = y;
  }
}
