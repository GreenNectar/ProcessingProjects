// I'll refactor this later ;)


// These don't have to be here
/// TODO, delete these
Train train;
Circle pentagon;
Circle circle;
Rectangle rect;
Rectangle outsideWall;
Particle particle;

/// Change these values
int fidelity = 64; // How many rays to shoot out per pixel
int trainSkip = 20; // How many vectors to skip in the vector image
float brightness = 2f; // How bright the boundaries are
boolean threadRender = false; // My thread implementation has a few artefacts !NOT ALWAYS FASTER! (Don't know why)
int threadRendersPer = 150; // Render only a certain number of points, the higher this is the more artifacts. Also it chews up cpu
int rendersPer = 1000;
/// TODO, add a half render and then fill in the blanks by using an average of neighbouring pixels

float maximumScreenDistance;
ArrayList<int[]> positions; // Keep record of remaining pixels to render
ArrayList<Boundary> boundaries; // Make an array of boundaries
PImage image;

void setup() {
  size(800, 400);

  maximumScreenDistance = sqrt(sq(width) + sq(height));
  boundaries = new ArrayList<Boundary>(); // Make a new array of boundaries
  colorMode(HSB);

  /// You can uncomment some of these if you like
  /// I made a shape using all the... shapes, and it looked like a train... so you know what I had to do :3

  //outsideWall = new Rectangle(0, 0, width / 2, height, color(255)); 
  //rect = new Rectangle(100, 150, 200, 200, color(50, 100, 255));
  //rect = new Rectangle(100, 150, 200, 200, color(random(0, 255), 255, 255));
  //rect = new Rectangle(100, 230, 200, 280, color(random(0, 255), 255, 255));
  //pentagon = new Circle(300, 250, 40, 5, color(random(0, 255), 255, 255));
  //circle = new Circle(300, 50, 40, 10, color(random(0, 255), 255, 255));
  train = new Train(width/4, height/2, 0.75f * (float(height) / 400f), trainSkip); // Make train boundaries

  colorMode(RGB);
  image = createImage(width, height, RGB); // Create blank image
  positions = new ArrayList<int[]>(); // Create an array for pixel positions

  // Make image pixels equal to -1, to make the threading more accurate
  loadPixels();
  for (int i = 0; i < width / 2; i++) {
    for (int j = 0; j < height; j++) {
      int[] pos = {i, j};
      positions.add(pos); // Add the pixel position to the array
      if (threadRender == true) {
        image.pixels[i + (j * width)] = -1; // Make pixel equal to -1
      }
    }
  }
  updatePixels();
}

boolean saved = false;

void draw() {
  background(0);

  for (Boundary bound : boundaries) {
    bound.show(); // Show all the boundaries
  }

  if (threadRender == true) {
    thread("RenderThread"); // Render using thread
  } else {
    Render(); // Render "normally?"
  }

  image(image, width / 2, 0); // Place rendered image on the screen


  boolean finished = true;

  for (int i = 0; i < width / 2; i++) {
    for (int j = 0; j < height; j++) {
      if (image.pixels[i + (j * width)] == -1) {
        finished = false;
      }
    }
  }

  if (((positions.size() <= 0 && threadRender == false) || (finished == true && threadRender == true)) && saved == false) {
    save("Render.png"); // Save render
    saved = true;
  }
}

void RenderThread() {
  Particle part = new Particle(fidelity, 360); // Create particle
  image.loadPixels();

  ArrayList<int[]> values = new ArrayList<int[]>(); // Create array of pixel position values

  for (int i = 0; i < width / 2; i++) {
    for (int j = 0; j < height; j++) {
      int[] pos = {i, j};
      if (image.pixels[i + (j * width)] == -1) { // If the pixel value is -1
        values.add(pos); // Add position to the array
      }

      if (values.size() >= threadRendersPer) {
        break;
      }
    }
    if (values.size() >= threadRendersPer) {
      break;
    }
  }


  for (int i = 0; i < values.size(); i++) {
    int[] pos = values.get(i);
    if (image.pixels[pos[0] + (pos[1] * width)] == -1) {
      part.update(pos[0], pos[1]); // Change particle location
      image.pixels[pos[0] + (pos[1] * width)] = part.render(boundaries); // Render the pixel
    }
  }
  image.updatePixels(); // Update image pixels
}

void Render() {
  Particle part = new Particle(fidelity, 360);
  image.loadPixels();
  for (int i = 0; i < rendersPer; i++) {
    if (positions.size() > 0) {//current < width / 2 * height) {
      int val = (int) random(positions.size() - 1); // Get random position index
      int[] pos = positions.get(val); // Get random pixel position
      positions.remove(val); // Remove position from array
      part.update(pos[0], pos[1]); // Move particle to new position
      image.pixels[pos[0] + (pos[1] * width)] = part.render(boundaries); // Render the pixel
    }
  }
  image.updatePixels();
}
