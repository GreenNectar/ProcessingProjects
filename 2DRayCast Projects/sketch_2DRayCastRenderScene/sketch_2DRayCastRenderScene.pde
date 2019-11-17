

ArrayList<Boundary> boundaries;

Train train;
Circle pentagon;
Circle circle;
Rectangle rect;
Rectangle outsideWall;
Particle particle;

int fidelity = 64;
int trainSkip = 20;

float maximumScreenDistance;

ArrayList<int[]> positions;

PImage image;

void setup() {
  size(800, 400);

  maximumScreenDistance = sqrt(sq(width) + sq(height));

  positions = new ArrayList<int[]>();
  for (int i = 0; i < width / 2; i++) {
    for (int j = 0; j < height; j++) {
      int[] pos = {i, j};
      positions.add(pos);
    }
  }

  boundaries = new ArrayList<Boundary>();
  //outsideWall = new Rectangle(0, 0, width, height, color(255)); 
  colorMode(HSB);
  //outsideWall = new Rectangle(0, 0, width / 2, height, color(255)); 
  //rect = new Rectangle(100, 150, 200, 200, color(50, 100, 255));
  train = new Train(width/4, height/2, 0.75f, trainSkip);
  //rect = new Rectangle(100, 150, 200, 200, color(random(0, 255), 255, 255));
  //rect = new Rectangle(100, 230, 200, 280, color(random(0, 255), 255, 255));
  //pentagon = new Circle(300, 250, 40, 5, color(random(0, 255), 255, 255));
  //circle = new Circle(300, 50, 40, 10, color(random(0, 255), 255, 255));
  colorMode(RGB);
  particle = new Particle(fidelity, 360);


  image = createImage(width, height, RGB);
}

int current = 0;
boolean saved = false;

void draw() {
  background(0);

  for (Boundary bound : boundaries) {
    bound.show();
  }

  for (int i = 0; i < 2000; i++) {
    if (current < width / 2 * height) {
      int val = (int) random(positions.size() - 1);
      int[] pos = positions.get(val);
      particle.update(pos[0], pos[1]);
      image.loadPixels();
      image.pixels[pos[0] + (pos[1] * width)] = particle.render(boundaries);
      image.updatePixels();
      positions.remove(val);
      current++;
    }
  }

  image(image, 400, 0);

  if (positions.size() <= 0 && saved == false) {
    save("Render.png");
    saved = true;
  }
}
