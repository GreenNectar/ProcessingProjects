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

  ArrayList<ColouredPoint> look(ArrayList<Boundary> bounds) {
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
      ColouredWolfenstein colWolf = new ColouredWolfenstein(record, closestCol);
      scene[i] = colWolf;
    }
    return points;
  }

  void update(float x, float y) {
    pos.x = x;
    pos.y = y;
  }

  void show() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, 16, 16);
    //for (Ray ray : rays) {
    //  ray.showLine();
    //}
  }
}
