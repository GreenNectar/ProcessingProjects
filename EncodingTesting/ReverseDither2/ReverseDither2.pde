import java.nio.*; //<>//
import java.net.*;
//String[] Text;
boolean finished = false;
void setup() {
  if (finished == false) {

    String[] Text = loadStrings("Binary.txt");

    String temp = Text[0];

    String[] ByteText = new String[temp.length() / 8];

    for (int i = 0; i < ByteText.length; i++) {
      ByteText[i] = "";
    }

    for (int i = 0; i < temp.length(); i+=8) {
      for (int j = 0; j < 8; j++) {
        ByteText[i / 8] += str( temp.charAt(i + j) );
      }
      print(ByteText[i / 8] + "\n");
    }

    print("This one - " + ByteText[ByteText.length - 1] + "\n");

    String text = Text[0];
    String[] finalText = new String[ByteText.length];

    int number = 0;

    for (int currentString = 0; currentString < ByteText.length; currentString += 1) {
      number = 0;
      for (int i = 0; i < 8; i++) {
        String compare = str(ByteText[currentString].charAt(i));
        if (compare.equals("1")) {
          number += pow(2, 7 - i);
        }
      }
      finalText[currentString] = str(number);
    }
    finished = true;

    int[] values = int(finalText);

    byte bytes[] = loadBytes("audiocomp.mp3");

    String[] out = new String[bytes.length];

    for (int i = 0; i < bytes.length; i++) {
      out[i] = str(bytes[i] & 0xFF);
    }

    saveStrings("out.txt", out);

    print(bytes[0] + "\n");
    print(ByteText[0] + "\n");
    print(values[0]);

    
    int srcLength = values.length;
    byte[]b = new byte[(srcLength / 4) + 1 << 2];

    for (int i = 0; i < srcLength; i++) {
      int x = values[i];
      int j = i;
      b[j++] = (byte) ((x >> 0) & 0xff);
      b[j++] = (byte) ((x >> 8) & 0xff);
      b[j++] = (byte) ((x >> 16) & 0xff);
      b[j++] = (byte) ((x >> 24) & 0xff);
    }

    for (int i = 0; i < b.length; i++) {
      print(str(b[i]));
    }

    saveBytes("sound.mp3", b);

    //saveStrings("Finished.txt", finalText);
  }
}
