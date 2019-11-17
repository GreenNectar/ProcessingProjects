class Relative {

  PVector pos;
  ArrayList<Relative> parents;
  int generation, person;
  boolean[] relations;

  Relative(int generation_, int person_) {
    generation = generation_;
    person = person_;
    relations = new boolean[amountOfPeople];
    if (generation == 0) {
      for (int i = 0; i < amountOfPeople; i++) {
        relations[i] = false;
      }
      relations[person] = true;
    }

    parents = new ArrayList<Relative>();
    pos = new PVector(((float)person / (float)amountOfPeople) * width + (width / (float)amountOfPeople / 2), ((float)generation / (float)amountOfGenerations) * height);
    pos.y = height - pos.y - (height / amountOfGenerations / 2);
  }

  void show() {

    for (Relative parent : parents) {
      line(pos.x, pos.y, parent.pos.x, parent.pos.y);
    }

    ellipse(pos.x, pos.y, 4, 4);

    boolean isNull = true;
    int total = 0;
    for (int i = 0; i < amountOfPeople; i++) {
      if (relations[i] == true) {
        isNull = false;
        total++;
      }
    }
    if (isNull) {
      text("N", pos.x, pos.y);
    }
    if (total == amountOfPeople) {
      text("E", pos.x, pos.y);
    } else {
      if (amountOfPeople <= 10) {
        for (int i = 0; i < amountOfPeople; i++) {
          if (relations[i] == true) {
            text(i + 1, pos.x + (i * 5) - (amountOfPeople * 5 / 2), pos.y);
          }
        }
      }
    }
  }
}
