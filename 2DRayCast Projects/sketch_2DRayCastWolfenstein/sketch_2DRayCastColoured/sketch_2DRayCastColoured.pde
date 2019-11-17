

ArrayList<Boundary> boundaries;

Rectangle rect;
Rectangle outsideWall;
Particle particle;

ArrayList<int[]> positions;

void setup() {
  size(800, 400);

  positions = new ArrayList<int[]>();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      int[] pos = {i, j};
      positions.add(pos);
    }
  }

  boundaries = new ArrayList<Boundary>();
  outsideWall = new Rectangle(0, 0, width, height); 
  rect = new Rectangle(100, 150, 200, 200);
  particle = new Particle(500);
}

void draw() {
  background(0);

  for (Boundary bound : boundaries) {
    //bound.show();
  }

  particle.update(mouseX, mouseY);
  for (ColouredPoint point : particle.look(boundaries)) {
    //ellipse(point.position.x, point.position.y, 4, 4);
    stroke(point.col);
    fill(point.col);
    line(particle.pos.x, particle.pos.y, point.pos.x, point.pos.y);
    //point.show();
  }
  particle.show();
}
