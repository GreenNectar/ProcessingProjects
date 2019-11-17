ArrayList<Relative> ListOfRelatives = new ArrayList<Relative>();
Relative[] previousRelatives;
int amountOfPeople = 100;
int amountOfGenerations = 14;
int currGeneration = 0;

// This is just to show how eventually nearly everyone at the end of the tree
// (most recent ancestors) are going to have a common ancestor somewhere
// N - Not associated with any of the youngest gen
// E - Common ancestor to all of the youngest gen

void setup() {
  size(800, 800);
  background(0);
  previousRelatives = new Relative[amountOfPeople];
  CreateNewGeneration();
  noLoop();
}

void mousePressed() {
  //boolean draw = true;
  if (currGeneration < amountOfGenerations) {
    CreateNewGeneration();
    redraw();
  }
}

void draw() {
  //background(0);

  fill(255);
  stroke(255, 0, 0);
  textAlign(CENTER);
  for (Relative relative : previousRelatives) {
    relative.show();
  }
}

void CreateNewGeneration() {
  Relative[] tempRelatives = new Relative[amountOfPeople];

  for (int i = 0; i < amountOfPeople; i++) {
    tempRelatives[i] = new Relative(currGeneration, i);
  }

  currGeneration++;

  for (Relative relative : previousRelatives) {
    if (relative != null) {
      for (int i = 0; i < 2; i++) {
        int roll = (int)random(0, amountOfPeople);
        if (tempRelatives[roll] != null) {
          tempRelatives[roll].parents.add(relative);

          for (int j = 0; j < amountOfPeople; j++) {//(boolean isRelated : previousRelatives[i].relations) {
            if (relative.relations[j] == true) {
              tempRelatives[roll].relations[j] = true;
            }
          }
        }
      }
      //for (int i = 0; i < amountOfPeople; i++) {
      //  if (tempRelatives[i] != null){
      //    tempRelatives[i].parents.add(relative);

      //    for (int j = 0; j < amountOfPeople; j++) {//(boolean isRelated : previousRelatives[i].relations) {
      //      if (relative.relations[j] == true) {
      //        tempRelatives[i].relations[j] = true;
      //      }
      //    }
      //  }
      //}
    }
  }

  //for (Relative relative : tempRelatives) {
  //  for (int i = 0; i < amountOfPeople; i++) {
  //    if (previousRelatives[i] != null && random(1f) < 2f / 6f) {
  //      previousRelatives[i].parents.add(relative);

  //      for (int j = 0; j < amountOfPeople; j++) {//(boolean isRelated : previousRelatives[i].relations) {
  //        if (previousRelatives[i].relations[j] == true) {
  //          relative.relations[j] = true;
  //        }
  //      }
  //    }
  //  }
  //}

  for (int i = 0; i < amountOfPeople; i++) {//Relative relative : tempRelatives) {
    previousRelatives[i] = tempRelatives[i];
    ListOfRelatives.add(tempRelatives[i]);
  }
}
