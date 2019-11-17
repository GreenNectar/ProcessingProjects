PImage kitten;
boolean isComplete = false;
void setup() {
  size(1600, 500);
  kitten = loadImage("maxresdefault2.png");
  kitten.filter(GRAY);
  image(kitten, 0, 0);
}

int index(int x, int y) {
  return x + y * kitten.width;
}

int dither(color c, int value, float errR, float errG, float errB) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  r += errR * value / 16.0;
  g += errG * value / 16.0;
  b += errB * value / 16.0;
  return color(r, g, b);
}

int roundColor(int factor, float old) {
  return round(factor * old / 255) * (255 / factor);
}

void draw() {
  if (isComplete == false) {
    kitten.loadPixels();
    for (int y = 0; y < kitten.height - 1; y++) {
      for (int x = 0; x < kitten.width - 1; x++) {
        color pix = kitten.pixels[index(x, y)];

        float oldR = red(pix);
        float oldG = green(pix);
        float oldB = blue(pix);

        int factor = 1;

        int newR = roundColor(factor, oldR);
        int newG = roundColor(factor, oldG);
        int newB = roundColor(factor, oldB);

        kitten.pixels[index(x, y)] = color(newR, newG, newB);

        float errR = oldR - newR;
        float errG = oldG - newG;
        float errB = oldB - newB;

        int index = index(x + 1, y   );
        kitten.pixels[index] = dither(kitten.pixels[index], 7, errR, errG, errB);

        index = index(x - 1, y + 1);
        kitten.pixels[index] = dither(kitten.pixels[index], 3, errR, errG, errB);

        index = index(x, y + 1);
        kitten.pixels[index] = dither(kitten.pixels[index], 5, errR, errG, errB);

        index = index(x + 1, y + 1);
        kitten.pixels[index] = dither(kitten.pixels[index], 1, errR, errG, errB);
      }
    }
    kitten.updatePixels();
    image(kitten, 800, 0);
    isComplete = true;
    kitten.save("output.bmp");
  }
}
