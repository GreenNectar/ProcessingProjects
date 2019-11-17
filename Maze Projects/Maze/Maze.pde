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
int w = 3;
ArrayList<Cell> grid = new ArrayList<Cell>();

Cell current;

ArrayList<Cell> stack = new ArrayList<Cell>();
ArrayList<Cell> stackBiggest = new ArrayList<Cell>();

void setup() {
  size(600, 600);
  cols = floor(width/w);
  rows = floor(height/w);
  //frameRate(5);

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }

  current = grid.get(0);
}

void draw() {
  background(51);
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show();
  }

  current.visited = true;
  current.highlight(0, 0, 255, 255);

  for (int i = 0; i < stackBiggest.size() - 1; i++) {
    Cell square1 = stackBiggest.get(i);
    Cell square2 = stackBiggest.get(i + 1);
    //square.highlight(0, 0, 255, 100);
    if (i == 0) {
      square1.highlight(0, 255, 0, 255);
    } else if (i == stackBiggest.size() - 2) {
      square2.highlight(255, 0, 0, 255);
    }
    stroke(255);
    line(square1.i*w + w/2, square1.j*w + w/2, square2.i*w + w/2, square2.j*w + w/2);
    //noStroke();
    //fill(0, 0, 255, 100);
    //rect(square.i * w, square.j*w, w, w);
  }

  // STEP 1
  Cell next = current.checkNeighbors();
  if (next != null) {
    next.visited = true;

    // STEP 2
    stack.add(current);
    if (current.i == 0 || current.i == cols - 1 || current.j == 0 || current.j == rows - 1) {
      if (stack.size() > stackBiggest.size()) {
        stackBiggest = cloneArray(stack);
        print(stackBiggest.size() + "\n");
        //stackBiggest = stack;
      }
    }

    // STEP 3
    removeWalls(current, next);

    // STEP 4
    current = next;
  } else if (stack.size() > 0) {
    current = stack.remove(stack.size()-1);
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
