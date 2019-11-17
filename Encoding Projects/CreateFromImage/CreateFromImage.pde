import java.nio.*; //<>//
import java.net.*;

void setup() {
  String fileName = "sound";
  byte[] finalBytes = convert(loadStrings("Binary.txt"));

  for (int i = 0; i < finalBytes.length; i++) {
    print(str(finalBytes[i]));
  }

  saveBytes(fileName + ".mp3", finalBytes);
  print("File saved - " + fileName + ".mp3");
}

byte[] convert(String[] binaryText){
  byte[] outByte = toByte(convertTo8bit(splitStringToArray(binaryText[0])));
  return outByte;
}

byte[] toByte(String[] strValues) {
  
  int[] values = int(strValues);
  int srcLength = values.length;
  byte[]outBytes = new byte[(srcLength / 4) + 1 << 2];

  for (int i = 0; i < srcLength; i++) {
    int x = values[i];
    int j = i;
    outBytes[j++] = (byte) ((x >> 0) & 0xff);
    outBytes[j++] = (byte) ((x >> 8) & 0xff);
    outBytes[j++] = (byte) ((x >> 16) & 0xff);
    outBytes[j++] = (byte) ((x >> 24) & 0xff);
  } 
  return outBytes;
}

String[] splitStringToArray(String text) {
  
  String[] splitText = new String[text.length() / 8];
  
  for (int i = 0; i < splitText.length; i++) {
    splitText[i] = "";
  }
  
  for (int i = 0; i < text.length(); i+=8) {
    for (int j = 0; j < 8; j++) {
      splitText[i / 8] += str( text.charAt(i + j) );
    }
    print(splitText[i / 8] + "\n");
  }

  return splitText;
}

String[] convertTo8bit(String[] values) {
  
  String[] convertedValues = new String[values.length];
  int number = 0;
  
  for (int currentString = 0; currentString < values.length; currentString += 1) {
    number = 0;
    for (int i = 0; i < 8; i++) {
      String compare = str(values[currentString].charAt(i));
      if (compare.equals("1")) {
        number += pow(2, 7 - i);
      }
    }
    convertedValues[currentString] = str(number);
  }
  return convertedValues;
}
