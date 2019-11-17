// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain

// Videos
// https://youtu.be/HyK_Q5rrcr4
// https://youtu.be/D8UgRyRnvXU
// https://youtu.be/8Ju_uxJ9v44
// https://youtu.be/_p5IH0L63wo

// Depth-first search
// Recursive backtracker
// https://en.wikipedia.org/wiki/Maze_generation_algorithm

int cols, rows;
int w = 15;//45;
int step = 1000;//250;
ArrayList<Cell> grid = new ArrayList<Cell>();

Cell current;

ArrayList<Cell> stack = new ArrayList<Cell>();
ArrayList<Cell> stackBiggest = new ArrayList<Cell>();

long startTime;
long endTime;
boolean hasPrinted = false;

void setup() {

  size(900, 900);
  cols = floor(width/w);
  rows = floor(height/w);
  //frameRate(2);

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }

  current = grid.get(0);

  startTime = System.nanoTime();
}

void draw() {
  boolean print = false;

  for (int s = 0; s < step; s++) {
    background(51);

    current.visited = true;

    // STEP 1
    Cell next = current.checkNeighbors();
    if (next != null) {
      next.visited = true;

      // STEP 2
      stack.add(current);

      if (stack.size() >= stackBiggest.size()) {
        if (current.i == 0 || current.i == cols - 1 || current.j == 0 || current.j == rows - 1) {
          stackBiggest = cloneArray(stack);
        }
        if (next.i == 0 || next.i == cols - 1 || next.j == 0 || next.j == rows - 1) {
          stackBiggest = cloneArray(stack);
          stackBiggest.add(next);
        }
        print = true;
      }

      // STEP 3
      removeWalls(current, next);

      // STEP 4
      current = next;
    } else if (stack.size() > 0) {
      current = stack.remove(stack.size()-1);
    }
  }

  if (stack.size() == 0) {
    for (int i = 0; i < grid.size(); i++) {
      grid.get(i).show();
      //if (grid.get(i).visited == false) {
      //  isComplete = false;
      //}
    }
  }

  if (print == true) {
    print(stackBiggest.size() + "\n");
  }

  if (stack.size() == 0) {
    step = 0;

    for (int i = 0; i < stackBiggest.size() - 1; i++) {
      Cell square1 = stackBiggest.get(i);
      Cell square2 = stackBiggest.get(i + 1);
      if (i == 0) {
        square1.highlight(0, 255, 0, 255);
        stroke(0, 255, 0, 255);
        line(square1.i*w + w/2, square1.j*w + w/2, square2.i*w + w/2, square2.j*w + w/2);
      } else if (i == stackBiggest.size() - 2) {
        square2.highlight(255, 0, 0, 255);
        stroke(255, 0, 0, 255);
        line(square1.i*w + w/2, square1.j*w + w/2, square2.i*w + w/2, square2.j*w + w/2);
      } else {
        if (mousePressed && (mouseButton == LEFT)) {
          stroke(255);
          line(square1.i*w + w/2, square1.j*w + w/2, square2.i*w + w/2, square2.j*w + w/2);
        }
      }
    }

    if (hasPrinted == false) {
      endTime = System.nanoTime();
      saveFrame("Maze " + str(cols) + " by " + str(rows) + ".png");
      print(((endTime - startTime) / 1000000000) + "s to complete\n");
      hasPrinted = true;
    }

    if (mousePressed && (mouseButton == RIGHT)) {
      
    }
  }
}

int index(int i, int j) {
  if (i < 0 || j < 0 || i > cols-1 || j > rows-1) {
    return 0;
  }
  return i + j * cols;
}

ArrayList<Cell> cloneArray(ArrayList<Cell> array) {
  ArrayList<Cell> clone = new ArrayList<Cell>();
  for (int i = 0; i < array.size(); i++) {
    clone.add(array.get(i));
  }
  return clone;
}

void removeWalls(Cell a, Cell b) {
  int x = a.i - b.i;
  if (x == 1) {
    a.walls[3] = false;
    b.walls[1] = false;
  } else if (x == -1) {
    a.walls[1] = false;
    b.walls[3] = false;
  }
  int y = a.j - b.j;
  if (y == 1) {
    a.walls[0] = false;
    b.walls[2] = false;
  } else if (y == -1) {
    a.walls[2] = false;
    b.walls[0] = false;
  }
}
