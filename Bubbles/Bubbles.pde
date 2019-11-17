int numberPerSweep = 20;
int numberOfSweeps = 6;
int image = 0;
boolean draw = true;


void setup() {

  size(1920, 1080);
  background(20, 30, 245);
}

void draw() {
  if (draw == true) {
    noStroke();
    saveFrame("Bubbles Image - " + image + ".png");
    image += 1;
    for (int i = 0; i < numberOfSweeps; i++) {
      //filter(BLUR);
      //filter(BLUR);
      background(0);
      for (int j = 0; j < numberPerSweep; j++) {
        fill(random(10, 150), random(50, 100), 220, random(80, 200));
        int size = int(random(50, 500));
        ellipse(random(0, width), random(0, height), size, size);
      }
      image += 1;
      saveFrame("Bubbles Image - " + image + ".png");
    }

    numberOfSweeps = 0;
    draw = false;
  }
}
