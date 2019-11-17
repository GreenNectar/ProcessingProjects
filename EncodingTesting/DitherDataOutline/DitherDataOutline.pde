PImage Image; //<>//
String Text;
int textBits;
PImage iniImage;
boolean finished;
boolean isRed = false;
void setup() {
  size(1600, 800);
  Image = loadImage("image1.bmp");
  Image.filter(GRAY);
  Image.filter(INVERT);
  image(Image, 0, 0);

  String[] text = loadStrings("File.txt");
  Text = "";
  for (int i = 0; i < text.length; i++) {
    Text += text[i];
  }
  Text = turnToMorse(Text);
  Text = turnToBinary(Text);
  textBits = Text.length();

  String[] list = split(Text, " ");
  saveStrings("Binary.txt", list);

  finished = false;
}

String turnToBinary(String text) {
  String finalText = "";
  for (int i = 0; i < text.length(); i++) {
    switch(str(text.charAt(i))) {
    case "0":
      finalText += "10";
      break;
    case "1":
      finalText += "1110";
      break;
    case "2":
      finalText += "00";
      break;
    case "3":
      finalText += "0000";
      break;
    case "4":
      finalText += "@";
      break;
    default:
      break;
    }
  }
  return finalText;
}

String turnToMorse(String text) {
  String finalText = "";
  for (int i = 0; i < text.length(); i++) {
    switch (str(text.charAt(i)).toUpperCase()) {
    case "A":
      finalText += "012";
      break;
    case "B":
      finalText += "10002";
      break;
    case "C":
      finalText += "10102";
      break;
    case "D":
      finalText += "1002";
      break;
    case "E":
      finalText += "02";
      break;
    case "F":
      finalText += "00102";
      break;
    case "G":
      finalText += "110";
      break;
    case "H":
      finalText += "00002";
      break;
    case "I":
      finalText += "002";
      break;
    case "J":
      finalText += "01112";
      break;
    case "K":
      finalText += "1012";
      break;
    case "L":
      finalText += "01002";
      break;
    case "M":
      finalText += "112";
      break;
    case "N":
      finalText += "102";
      break;
    case "O":
      finalText += "1112";
      break;
    case "P":
      finalText += "01102";
      break;
    case "Q":
      finalText += "11012";
      break;
    case "R":
      finalText += "0102";
      break;
    case "S":
      finalText += "0002";
      break;
    case "T":
      finalText += "12";
      break;
    case "U":
      finalText += "0012";
      break;
    case "V":
      finalText += "00012";
      break;
    case "W":
      finalText += "0112";
      break;
    case "X":
      finalText += "10012";
      break;
    case "Y":
      finalText += "10112";
      break;
    case "Z":
      finalText += "11002";
      break;
    case "1":
      finalText += "011112";
      break;
    case "2":
      finalText += "001112";
      break;
    case "3":
      finalText += "000112";
      break;
    case "4":
      finalText += "000012";
      break;
    case "5":
      finalText += "000002";
      break;
    case "6":
      finalText += "100002";
      break;
    case "7":
      finalText += "110002";
      break;
    case "8":
      finalText += "111002";
      break;
    case "9":
      finalText += "111102";
      break;
    case "0":
      finalText += "111112";
      break;
    case "/":
      finalText += "100102";
      break;
    case "(":
      finalText += "101102";
      break;
    case ")":
      finalText += "1011012";
      break;
    case "!":
      finalText += "1010112";
      break;
    case ";":
      finalText += "1010102";
      break;
    case ":":
      finalText += "1110002";
      break;
    case "&":
      finalText += "010002";
      break;
    case ".":
      finalText += "0101012";
      break;
    case ",":
      finalText += "1100112";
      break;
    case "'":
      finalText += "0111102";
      break;
    case "?":
      finalText += "0011002";
      break;
    case "-":
      finalText += "1000012";
      break;
    case "_":
      finalText += "0011012";
      break;
    case "$":
      finalText += "00010012";
      break;
    case "\"":
      finalText += "0100102";
      break;
    case "@":
      finalText += "4";
      break;
    default:
      finalText += "3";
      break;
    }
  }
  return finalText;
}

int index(int x, int y) {
  return x + y * Image.width;
}

int roundColor(int factor, float old) {
  return round(factor * old / 255) * (255 / factor);
}

boolean isWhite(color c) {
  if (red(c) * green(c) * blue(c) > 128*128*128) { //(255*255*255)/2) {
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

    Image = loadImage("image1.bmp");
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

        String curChar = "";

        if (currentBit >= Text.length()) {
          Text = Text.toString() + turnToBinary(turnToMorse(str(random(0, 1))));
          //Text = Text.toString() + "a";
        }
        curChar = str(Text.charAt(currentBit));

        while (str(Text.charAt(currentBit)).equals("@")) {
          isRed = !isRed;
          currentBit+=1;
          if (currentBit < Text.length()) {
            curChar = str(Text.charAt(currentBit));
          }
        }

        if (isWhite(Image.pixels[index(x + 3, y)]) && isWhite(Image.pixels[index(x + 4, y)]) && isWhite(Image.pixels[index(x - 3, y)]) && isWhite(Image.pixels[index(x - 4, y)])) {
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
        }
        x++;
      }
      y++;
    }

    /*
        if (isWhite(Image.pixels[index(x, y)])) {
     if (isWhite(Image.pixels[index(x + 1, y)])) {
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
     } else if (currentBit < Text.length()) {
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
     } else {
     newImage.pixels[index(x, y)] = colBlack();
     }
     }
     } else {
     newImage.pixels[index(x, y)] = colBlack();
     }
     x++;
     }
     y++;
     }
     */
    newImage.updatePixels();
    newImage.save("outputImage.bmp");
    image(newImage, 800, 0);

    print("Finished\n");
    print(textBits + "\n");
    print(currentBit + "\n");
    finished = true;
  }
}
