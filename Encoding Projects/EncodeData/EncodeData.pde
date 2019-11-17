PImage Image; //<>//
String imageFile = "file.png";
int textBits;
int bitsAdded;
PImage iniImage;
boolean finished;

void setup() {
  Image = loadImage(imageFile);

  size(1600, 800);

  //Image.filter(GRAY);
  //Image.filter(INVERT);

  print("Contrasting Image\n");
  Image = contrast(Image, 1.2);
  print("Contrasting Complete\n\n");
  
  print("loading File Data as Bytes\n");
  byte bytes[] = loadBytes("data.png"); //"audio16.mp3");
  print("loaded File Data\n\n");

  //print("Saving Data as Numbers\n");
  //saveData(bytes);
  //print("Saved Data\n\n");

  print("Convert Data to Binary\n");
  String Text = convertToBinary(bytes, false);
  print("Converted Data\n\n");

  print("Dithering Image\n");
  Image = ditherImage(Image);
  print("Dithering Complete\n\n");

  print("Encoding File Data\n");
  Image = encodeImage(Image, Text, true, false);
  print("Encoding Complete\n\n");

  print("Blending Images\n");
  Image = blendImage(Image, imageFile);
  print("Finished Blending Images\n\n");

  print("Saving\n");
  Image.save("outputImage.png");
  print("Saving Complete\n");
}

void draw() {
  image(Image, 0, 0);
  if (finished == false) {
    //print(Text.length() + "\n");
    print(textBits + "\n");
    print(bitsAdded + "\n");
    finished = true;
  }
}

PImage contrast(PImage image, float scale) {
  PImage finalImage = image;
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      color pix = image.pixels[index(x, y)];
      float r = (red(pix) - 128) * scale;
      float g = (green(pix) - 128) * scale;
      float b = (blue(pix) - 128) * scale;
      r = 128 + r;
      g = 128 + g;
      b = 128 + b;
      finalImage.pixels[index(x, y)] = color(r, g, b);
    }
  }
  finalImage.updatePixels();
  return finalImage;
}

PImage blendImage(PImage image, String file) {
  image.loadPixels();
  PImage replaceImage = loadImage(file);
  replaceImage.loadPixels();
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      color pix = image.pixels[index(x, y)];
      color pixReplace = replaceImage.pixels[index(x, y)];
      if (red(pix) * green(pix) * blue(pix) > 0) {
        image.pixels[index(x, y)] = pixReplace;
      }
    }
  }
  return image;
}

PImage ditherImage(PImage image) {
  image.loadPixels();

  for (int y = 0; y < image.height - 1; y++) {
    for (int x = 0; x < image.width - 1; x++) {
      color pix = image.pixels[index(x, y)];

      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);

      int factor = 1;

      int newR = roundColor(factor, oldR);
      int newG = roundColor(factor, oldG);
      int newB = roundColor(factor, oldB);

      image.pixels[index(x, y)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;

      int index = index(x + 1, y   );
      image.pixels[index] = dither(image.pixels[index], 7, errR, errG, errB);

      index = index(x - 1, y + 1);
      image.pixels[index] = dither(image.pixels[index], 3, errR, errG, errB);

      index = index(x, y + 1);
      image.pixels[index] = dither(image.pixels[index], 5, errR, errG, errB);

      index = index(x + 1, y + 1);
      image.pixels[index] = dither(image.pixels[index], 1, errR, errG, errB);
    }
  }
  image.updatePixels();
  //image(image, 800, 0);
  //image.save("output.bmp");

  return image;
}

int index(int x, int y, PImage image) {
  return x + y * image.width;
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

PImage encodeImage(PImage Image, String text, boolean redEnd, boolean drawNoiseRed) {
  boolean redNoise = false;
  finished = false;
  PImage newImage = Image;
  Image.filter(GRAY);
  Image.loadPixels();

  int y = 0;
  int currentBit = 0;

  while (y < Image.height) {
    int x = 0;
    while (x < Image.width) {

      color pix = Image.pixels[index(x, y)];

      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);

      int factor = 1;

      int newR = roundColor(factor, oldR);
      int newG = roundColor(factor, oldG);
      int newB = roundColor(factor, oldB);

      Image.pixels[index(x, y)] = color(newR, newG, newB);

      //if (currentBit >= Text.length()) {
      //  Text += str(random(0, 1));
      //}

      String curChar = "";

      if (currentBit < text.length()) {
        curChar = str(text.charAt(currentBit));
      } else if (currentBit == text.length()) {
        curChar = "2";
      } else {
        if (random(-1, 1) > 0) {
          curChar = "1";
        } else {
          curChar = "0";
        }
      }

      if (isWhite(Image.pixels[index(x, y)])) {
        if (curChar.equals("1")) {
          newImage.pixels[index(x, y)] = col(redNoise);
          newImage.pixels[index(x + 1, y)] = col(redNoise);
          if (x + 2 < Image.width) {
            newImage.pixels[index(x + 2, y)] = col("black");
          }
          currentBit += 1;
          x+=2;
        } else if (curChar.equals("0")) {
          newImage.pixels[index(x, y)] = col(redNoise);
          if (x + 1 < Image.width) {
            newImage.pixels[index(x + 1, y)] = col("black");
          }
          currentBit += 1;
          x+=1;
        } else if (curChar.equals("2")) {
          newImage.pixels[index(x, y)] = col(redEnd);
          newImage.pixels[index(x + 1, y)] = col(redEnd);
          newImage.pixels[index(x + 2, y)] = col(redEnd);
          if (x + 3 < Image.width) {
            newImage.pixels[index(x + 3, y)] = col("black");
          }
          if (drawNoiseRed == true) {
            redNoise = true;
          }
          currentBit += 1;
          x+=3;
        }
      } else {
        newImage.pixels[index(x, y)] = col("black");
      }
      x++;
    }
    y++;
  }
  bitsAdded = currentBit;

  newImage.updatePixels();
  //newImage.save("outputImage.png");
  return newImage;
}

String convertToBinary(byte[] bytes, boolean saveData) {
  String[] text = new String[bytes.length];
  String finalText = "";

  for (int i = 0; i < bytes.length; i++) { 
    // bytes are from -128 to 127, this converts to 0 to 255 
    text[i] = str(bytes[i] & 0xff);
  }

  finalText = "";
  for (int i = 0; i < text.length; i++) {
    finalText += turnToBinary(text[i]);
  }
  textBits = finalText.length();

  if (saveData == true) {
    String[] list = split(finalText, " ");
    saveStrings("Binary.txt", list);
  }

  return finalText;
}

void saveData(byte[] bytes) {
  String[] out = new String[bytes.length];

  for (int i = 0; i < bytes.length; i++) {
    out[i] = str(bytes[i] & 0xFF);
  }

  saveStrings("number data.txt", out);
}

String turnToBinary(String text) {
  String finalText = "";
  int number = 0;
  number = int(text);
  for (int i = 0; i < 8; i++) {
    finalText += str(number % 2);
    number = floor(number / 2);
  }
  String output = new String(reverse(finalText.toCharArray()));
  return output;
}

int index(int x, int y) {
  return x + y * Image.width;
}

int roundColor(int factor, float old) {
  return round(factor * old / 255) * (255 / factor);
}

boolean isWhite(color c) {
  if (red(c) * green(c) * blue(c) > 128*128*128) {
    return true;
  } else {
    return false;
  }
}

int col(String colour) {
  if (colour == "red") {
    return color(255, 0, 0);
  } else if (colour == "white") {
    return color(255, 255, 255);
  } else if (colour == "black") {
    return color(0, 0, 0);
  } else {
    return color(255, 255, 255);
  }
}

int col(boolean drawRed) {
  if (drawRed == true) {
    return color(255, 0, 0);
  } else {
    return color(255, 255, 255);
  }
}
