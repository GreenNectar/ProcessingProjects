PImage Image; //<>// //<>//
String fileToOpen = "Slutbunny.png";
String Text;
int textBits;
PImage iniImage;
boolean finished;
boolean isRed = false;
void setup() {
  Image = loadImage(fileToOpen);
  size(1600, 800);

  Image.filter(GRAY);
  Image.filter(INVERT);
  image(Image, 0, 0);

  byte bytes[] = loadBytes("audio32full.mp3");

  String[] out = new String[bytes.length];

  for (int i = 0; i < bytes.length; i++) {
    out[i] = str(bytes[i] & 0xFF);
  }

  saveStrings("out.txt", out);

  String[] text = new String[bytes.length];

  for (int i = 0; i < bytes.length; i++) { 
    // bytes are from -128 to 127, this converts to 0 to 255 
    text[i] = str(bytes[i] & 0xff);
  }

  Text = "";
  for (int i = 0; i < text.length; i++) {
    Text += turnToBinary(text[i]);
  }
  textBits = Text.length();

  String[] list = split(Text, " ");
  saveStrings("Binary.txt", list);

  finished = false;
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

int colWhite() {
  if (isRed == true) {
    return color(255, 0, 0);
  } else {
    return color(255, 255, 255);
  }
}

int colBlack() {
  return color(0, 0, 0);
}

void draw() {

  if (finished == false) {

    Image = loadImage(fileToOpen);
    PImage newImage = Image;
    Image.filter(GRAY);
    Image.filter(INVERT);
    Image.loadPixels();

    int y = 0;
    int currentBit = 0;

    while (y < Image.height - 1) {
      int x = 0;
      while (x < Image.width - 1) {

        color pix = Image.pixels[index(x, y)];

        float oldR = red(pix);
        float oldG = green(pix);
        float oldB = blue(pix);

        int factor = 1;

        int newR = roundColor(factor, oldR);
        int newG = roundColor(factor, oldG);
        int newB = roundColor(factor, oldB);

        Image.pixels[index(x, y)] = color(newR, newG, newB);

        if (currentBit >= Text.length()) {
          Text += str(random(0, 1));
        }
        
        String curChar = "";

        if (currentBit < Text.length()) {
          curChar = str(Text.charAt(currentBit));
        }

        if (isWhite(Image.pixels[index(x, y)])) {
          if (currentBit < Text.length()) {
            if (curChar.equals("1")) {
              newImage.pixels[index(x, y)] = colWhite();
              newImage.pixels[index(x + 1, y)] = colWhite();
              newImage.pixels[index(x + 2, y)] = colBlack();
              currentBit += 1;
              x+=2;
            } else if (curChar.equals("0")) {
              newImage.pixels[index(x, y)] = colWhite();
              newImage.pixels[index(x + 1, y)] = colBlack();
              currentBit += 1;
              x+=1;
            }
          }
        } else {
          newImage.pixels[index(x, y)] = colBlack();
        }
        x++;
      }
      y++;
    }

    newImage.updatePixels();
    newImage.save("outputImage.bmp");
    image(newImage, 800, 0);

    print("Finished\n");
    print(Text.length() + "\n");
    print(textBits + "\n");
    print(currentBit + "\n");
    finished = true;
  }
}
