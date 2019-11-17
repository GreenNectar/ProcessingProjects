Peg[] pegs;
int amountOfDiscs = 10;
int[] binarys = new int[amountOfDiscs];
int discHeight = 12;
float minW = 40;
float maxW = 160;
ArrayList<Disc> allDiscs = new ArrayList<Disc>();
int moves = 0;

void setup() {
  size(800, 400);
  pegs = new Peg[3];

  for (int i = 0; i < 3; i++) {
    ArrayList<Disc> discs = new ArrayList<Disc>();
    int currDisc = 0;
    if (i == 0) {
      for (int j = amountOfDiscs; j > 0; j--) {
        Disc disc = new Disc(GetScale(currDisc), GetPosition(amountOfDiscs - currDisc - 1, i), currDisc + 1);
        discs.add(disc);
        allDiscs.add(disc);
        currDisc++;
      }
    }
    pegs[i] = new Peg(discs);
  }

  frameRate(30);
}



void draw() {
  background(0);
  fill(255);
  noStroke();
  textAlign(CENTER, CENTER);

  fill(180, 20, 20);
  for (int i = 0; i < pegs.length; i++) {
    int w = 10;
    int h = discHeight * (amountOfDiscs + 1);
    float x = i * (width / 3) + (width / 3 / 2);
    float y = height - (h / 2);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
  fill(255);

  colorMode(HSB);
  for (int i = 0; i < allDiscs.size(); i++) {
    float val = 255 / allDiscs.size();
    val *= allDiscs.size() - 1;
    fill(map(i, 0, allDiscs.size() - 1, 0, val), 150, 255);
    allDiscs.get(i).Render();
  }
  colorMode(RGB);
  
  
  textSize(30);
  if (pegs[2].discs.size() >= amountOfDiscs || pegs[1].discs.size() >= amountOfDiscs) {
    text("Finished in " + str(moves) + " moves", width/2, 50);
  } else {
    MoveDisc(IncrementBinary(0));
    moves++;
    text("Moves - " + str(moves), width/2, 50);
  }
  
  String binaryString = "";
  for (int i = binarys.length - 1; i >= 0; i--) {
    binaryString += str(binarys[i]);
  }
  text(binaryString, width/2, 100);
}


int IncrementBinary(int index) {
  if (binarys[index] == 0) {
    binarys[index] += 1;
  } else {
    binarys[index] = 0;
    if (index+1 < binarys.length) {
      index = IncrementBinary(index+1);
    }
  }
  return index;
}

void MoveDisc(int disc) {
  Disc currDisc = allDiscs.get(disc);
  boolean broke = false;
  for (int i = 0; i < pegs.length; i++) {
    for (int j = pegs[i].discs.size() - 1; j >= 0; j--) {
      int iterate = 1;


      if (pegs[i].discs.get(j) == currDisc) {

        int nextPeg = (i + iterate) % 3;

        int dval = amountOfDiscs + 1;
        if (pegs[nextPeg].discs.size() > 0) {
          dval = pegs[nextPeg].discs.get(0).discValue;
        }

        while (broke == false) {
          nextPeg = (i + iterate) % 3;
          dval = amountOfDiscs + 1;
          if (pegs[nextPeg].discs.size() > 0) {
            dval = pegs[nextPeg].discs.get(0).discValue;
          }

          if (dval > currDisc.discValue) {
            currDisc.position = GetPosition(pegs[nextPeg].discs.size(), nextPeg);
            pegs[i].discs.remove(currDisc);
            pegs[nextPeg].discs.add(0, currDisc);
            //println(dval);
            //println(nextPeg + 1);
            broke = true;
            break;
          } else {
            iterate++;
          }
        }

        if (broke == true) {
          break;
        }
      }
    }
    if (broke == true) {
      break;
    }
  }
}

PVector GetPosition(int disc, int pos) {//, int pos) {
  disc += amountOfDiscs;
  float x = pos * (width / 3) + (width / 3 / 2);
  float y = height - ((disc - amountOfDiscs) * discHeight) - (discHeight / 2);
  return new PVector(x, y);
}

PVector GetScale(int disc) {
  float w = map(disc, 0, amountOfDiscs, minW, maxW);
  float h = discHeight;
  return new PVector(w, h);
}
