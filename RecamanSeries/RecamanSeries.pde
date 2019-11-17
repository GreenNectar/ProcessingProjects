// Github - GreenNectar - github.com/GreenNectar
// Youtube - GreenNectar - youtube.com/channel/UC37Zd9XXGKxtjEfaYJZkm6Q
// Discord - discord.gg/vGJKxj

import processing.pdf.*;

// Pdf stuff
boolean record = false;

// Lists to manage stuff
ArrayList<float[]> positions = new ArrayList<float[]>();
IntList numbersUsed = new IntList();


//You can change these values
float multiplier = 0.285; // This just scales the drawn series, larger is larger
int circleResolution = 10; // Resolution of each SEMI circle, not circle
int resolutionIncreaseStep = 1; // How many steps until the resolution increases by 1
int resolutionIncreaseStepStep = 1; // How many steps to increase the step when the step, steps
int maximumNumbers = 100; //Zero is unlimited
float strokeSize = 1f; // Stroke for circles and points
boolean isHueEnabled = true; // If stroke uses hue or colour
color strokeColour = color(222, 255, 0); // Colour of stroke, only when isHue is disabled
float hue = 0; // Starting hue
float hueIncrement = 2f; // How fast the hue increments, larger = faster
int iterationsPerFrame = 1000; // How many times to iterate per frame
boolean drawPoints = true; // Draw points
color pointsColour = color(0); // Points colour...
boolean drawBackground = true; // Draw background
color backgroundColour = color(255); // Background colour...


// Do not change these
int hueMultiplier = 0; // This is to make the hue go back and forth
int amountOfNumbers = 0; // To stop when maximumNumbers is reached
float value = 1f; // To flip the semi circles
int currentNumber = 1; // Starting number to count from
int positionNumber = 0; // Starting position number
int previousNumber = 0; // Previous position number
float middlePointx = 0.5f / multiplier; // Where the middle of the circle is
float middlePointy = height/2f; // Middle of screen

void setup() {
  // You can change these two
  size(800, 600);
  background(255); // Don't draw background in draw event, saves energy and time

  // Middle of screen, last value doesn't work as the screen size hasn't been set yet
  middlePointy = height/2f;

  // Get the naming structure
  String extraStrings = "";
  if (isHueEnabled == true) {
    extraStrings += "Hue " + hue + "," + hueIncrement + " - ";
  } else {
    extraStrings += "Col " + red(strokeColour) + "," + green(strokeColour) + "," + blue(strokeColour) + " - ";
  }

  if (drawBackground == true) {
    extraStrings += "Bgc " + red(backgroundColour) + "," + green(backgroundColour) + "," + blue(backgroundColour) + " - ";
  } else {
    extraStrings += "Bgc False - ";
  }

  if (drawPoints == true) {
    extraStrings += "Dot True - ";
  } else {
    extraStrings += "Dot False - ";
  }

  // Start pdf recording I guess, I put a naming sequence in so you don't have to rename them
  beginRecord(PDF, "Images/FinalImage " + "Max " + maximumNumbers + " - " +
    "Mul " + multiplier + " - " +
    "Str " + strokeSize + " - " +
    extraStrings +
    "Res " + circleResolution + "," + resolutionIncreaseStep + "," + resolutionIncreaseStepStep + 
    ".pdf");

  // Uh I don't know how to make it unlimited um TODO this thing
  frameRate(1000);

  // Put 0 in the list so it doesn't think it's free
  numbersUsed.append(0);

  // For some reason the for loop doesn't do the last point if I don't do this
  circleResolution--;

  // Draw the background
  if (drawBackground == true) {
    colorMode(RGB);
    fill(backgroundColour);
    rect(0, 0, width, height);
  }

  if (isHueEnabled) {
    // This one is for pretty colours :3
    colorMode(HSB);
  } else {
    // This one is for set colour
    colorMode(RGB);
  }
}

void draw() {

  strokeWeight(strokeSize);

  // Now for the yuck, I went over this code sooo many times (hence some not necessery lists I can get rid of) I might redo this... probs not
  for (int it = 0; it < iterationsPerFrame; it++) {
    if (amountOfNumbers < maximumNumbers || maximumNumbers == 0) {

      if (value == 0) {
        value = PI;
      } else {
        value = 0;
      }

      // If the position is not free of the left of the current position (distance of currentNumber) than go right, otherwise go left
      // Or if the position is less than zero from the current position - current number, than go right
      boolean goLeft = true;
      for (int number : numbersUsed) {
        if (positionNumber - currentNumber == number || positionNumber - currentNumber <= 0) {
          goLeft = false;
        }
      }

      // Either left or right from current position by currentNumber distance
      if (goLeft == true) {
        positionNumber -= currentNumber;
      } else {
        positionNumber += currentNumber;
      }

      positions = new ArrayList<float[]>(); // New position array
      float r = (abs(positionNumber - previousNumber) / 2f) / multiplier; // Find radius of the semi circle

      middlePointx = (positionNumber - ((positionNumber - previousNumber) / 2f)) / multiplier; // Find the middle of the semi circle

      // Create the points around the point in a semi circles, then add it to the positions, and add that to the shapes
      for (int i = 0; i <= circleResolution; i++) {
        float x = r * cos(i * PI/circleResolution + value);
        float y = r * sin(i * PI/circleResolution + value);
        float[] position = {middlePointx + x, middlePointy + y};
        positions.add(position);
      }
      numbersUsed.append(positionNumber); // Add the number that was just used, so we don't go back to it

      // Increase the resolution of the semi circle
      if (resolutionIncreaseStep - 1 == 0) {
        circleResolution++;
        resolutionIncreaseStep += resolutionIncreaseStepStep;
      } else {
        resolutionIncreaseStep--;
      }

      // Draw the semi circle
      if (positionNumber > previousNumber) {
        for (int j = 0; j < positions.size() - 1; j++) {
          DrawCircle(j);
        }
      } else {
        for (int j = positions.size() - 2; j >= 0; j--) {
          DrawCircle(j);
        }
      }

      previousNumber = positionNumber; // Previous position
      currentNumber++; // Iterate to next number
      amountOfNumbers++;

      // If the middle point of the semi circle is beyond the screen, then save and exit
      if (middlePointx >= width) {

        DrawPoints();

        FinishUp();
      }
    } else {
      //delay(2000);

      DrawPoints();
      FinishUp();
    }
  }
}

void FinishUp() {
  // End pdf, print the number it got up to, and exit 
  endRecord();
}

void DrawPoints() {
  // Draw Points along the x axis for each positive integer that fits on the screen
  if (drawPoints == true) {
    for (int q = 0; q < (width * multiplier) + 1; q++) {
      stroke(pointsColour);
      ellipse(q /multiplier, middlePointy, strokeSize, strokeSize);
    }
  }
}

void DrawCircleLeft(int j) {
  float[] position1 = positions.get(j);
  float[] position2 = positions.get(j + 1);

  // If hue is enabled then change the colour according to hue, else change it to the set colour
  if (isHueEnabled) {
    stroke(hue, 255, 255);
  } else {
    stroke(strokeColour);
  }

  // Connect the lines boi
  line(position1[0], position1[1], position2[0], position2[1]);

  // If hue is enabled then increment the value
  if (isHueEnabled) {
    hue += hueIncrement * hueMultiplier;

    if (hue <= 0) {
      hueMultiplier = 1;
    }
    if (hue >= 255) {
      hueMultiplier = -1;
    }
  }
}

void DrawCircleRight(int j) {
  float[] position1 = positions.get(j);
  float[] position2 = positions.get(j - 1);

  // If hue is enabled then change the colour according to hue, else change it to the set colour
  if (isHueEnabled) {
    stroke(hue, 255, 255);
  } else {
    stroke(strokeColour);
  }

  // Connect the lines boi
  line(position1[0], position1[1], position2[0], position2[1]);

  // If hue is enabled then increment the value
  if (isHueEnabled) {
    hue += hueIncrement * hueMultiplier;

    if (hue <= 0) {
      hueMultiplier = 1;
    }
    if (hue >= 255) {
      hueMultiplier = -1;
    }
  }
}
