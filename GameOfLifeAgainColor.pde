
//WORKS!!

Cell[][] grid;
Cell[][] next;
static int cols = 100;
int rows = 100;

static int windowWidth = 1920;
int windowHeight = 1080;

boolean pause = false;

void setup() {
  fullScreen();
  //size(1920, 1080);
  initialiseGrid(cols, rows);
  initialiseNext(cols, rows);
  frameRate(20);
}

void draw() {
  if (!pause) {
    background(0);
    update();
    renderGrid();
  }
  //printGrid();
  //println();
}

void initialiseGrid(int cols, int rows) {


  /*
      col = x
   row = y o  o  o
   o  o  o
   o  o  o
   */

  grid = new Cell[cols][rows];

  // 1 = alive, 0 = dead
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      grid[i][j] = new Cell(i, j, floor(random(0, 2)));
    }
  }
}

void renderGrid() { //<>//
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      grid[i][j].render();
    }
  }
}

void initialiseNext(int cols, int rows) {
  next = new Cell[cols][rows];
  
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      next[i][j] = new Cell(i, j, 0);
    }
  }
}


void update() {
  initialiseNext(cols, rows);


  //update next based on grid
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      grid[i][j].update();
      int neighbourCount = getNeighbourCount(i, j);
      if (grid[i][j].getState() ==  0 && neighbourCount==3) {
        next[i][j].revive();
      } else if (grid[i][j].getState() == 1 && (neighbourCount>3 || neighbourCount<2)) {
        next[i][j].kill();
      } else {
        next[i][j].setState(grid[i][j].getState());
        if (next[i][j].getState()==1) {
          next[i][j].setAge(1+grid[i][j].getAge());
        }
      }


    }
  }
  //assign next to grid and then render

  grid = next;
}

int getNeighbourCount(int col, int row) {
  int count = 0;
  for (int i=max(0, col-1); i<=min(col+1, cols-1); i++) {
    for (int j=max(0, row-1); j<=min(row+1, rows-1); j++) {
      if (grid[i][j].getState() == 1) {
        count++;
      }
    }
  }

  if (grid[col][row].getState() == 1) {
    count--;
  }

  return count;
}

/*void setAges() {
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      next[i][j].setAge(next[i][j].getAge() + (grid[i][j].getState()==1?grid[i][j].getAge():0));
    }
  }
}
*/

void mouseClicked() {
  pause = !pause;
}
