class Particle {

  PVector pos;
  Ray[] rays;

  Particle(int amountOfRays) {
    pos = new PVector(width/2, height/2);
    rays = new Ray[amountOfRays];
    for (int i = 0; i < amountOfRays; i++) {
      rays[i] = new Ray(pos, radians((float(i) / float(amountOfRays)) * 360f));
    }
  }

  void look(ArrayList<Boundary> bounds) {
    fill(255);
    for (Ray ray : rays) {
      float record = sqrt((width*width) + (height*height));
      PVector closest = null;
      for (Boundary bound : bounds) {
        PVector point = ray.cast(bound);
        if (point != null) {
          float distance = PVector.dist(pos, point);
          if (distance < record) {
            record = distance;
            closest = point;
          }
          record = min(distance, record);
        }
      }
      if (closest != null) {
        stroke(255);
        //line(pos.x, pos.y, closest.x, closest.y);
        ellipse(closest.x, closest.y, 4, 4);
      }
    }
  }

  void update(int x, int y) {
    pos.x = x;
    pos.y = y;
  }

  void show() {
    fill(255);
    //ellipse(pos.x, pos.y, 16, 16);
    for (Ray ray : rays) {
      //ray.show();
    }
  }
}
