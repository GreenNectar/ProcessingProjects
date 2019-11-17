

ArrayList<Boundary> boundaries;

Circle circle;
Rectangle rect;
Rectangle outsideWall;
Particle particle;

int FOV = 360;
int resolution = 400;

ArrayList<int[]> positions;

ColouredWolfenstein[] scene;

void setup() {
  size(800, 400);

  scene = new ColouredWolfenstein[resolution];

  positions = new ArrayList<int[]>();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      int[] pos = {i, j};
      positions.add(pos);
    }
  }

  boundaries = new ArrayList<Boundary>();
  outsideWall = new Rectangle(0, 0, width / 2, height, color(255)); 
  colorMode(HSB);
  //outsideWall = new Rectangle(0, 0, width / 2, height, color(255)); 
  //rect = new Rectangle(100, 150, 200, 200, color(50, 100, 255));
  //circle = new Circle(300, 250, 40, 5, color(255, 100, 50));
  rect = new Rectangle(100, 150, 200, 200, color(random(0, 255), 255, 255));
  circle = new Circle(300, 250, 40, 5, color(random(0, 255), 255, 255));
  colorMode(RGB);
  particle = new Particle(resolution, FOV);
}

void draw() {
  background(0);

  for (Boundary bound : boundaries) {
    bound.show();
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

  float w = width / 2 / scene.length;
  translate(width/2, 0);
  rectMode(CENTER);
  float maxDistance = sqrt(sq(width/2) + sq(height));
  for (int i = 0; i < scene.length; i++) {
    //float antiFishEye = acos((i / scene.length) * FOV);
    float b = sq(map(scene[i].distance, 0f, maxDistance, 1f, 0f));
    float h = b * height;
    color col = scene[i].col;
    color c = color(red(col) * b, green(col) * b, blue(col) * b);
    fill(c);
    rect(i * w + w / 2, height / 2, w, h);
  }
}
