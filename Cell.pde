class Cell {

  int cellWidth = windowWidth/cols;
  int col;
  int row;
  int state;

  int prevState;
  int age;

  static final int ALIVE = 1;
  static final int DEAD = 0;

  static final int BLACK      = 0;
  static final int RED        = 1;
  static final int ORANGE     = 2;
  static final int YELLOW     = 3;
  static final int GREEN      = 4;
  static final int TURQUOISE  = 5;
  static final int CYAN       = 6;
  static final int BLUE       = 7;
  static final int PURPLE     = 8;
  static final int MAGENTA    = 9;
  static final int WHITE_ERROR = 10;

  //int[][] colors = new int[10][3];

  int[][] colors = {{0, 0, 0}, {255, 0, 0}, {255, 128, 0}, {255, 255, 0}, 
    {0, 255, 0}, {0, 255, 180}, {0, 255, 255}, {26, 3, 255}, 
    {178, 3, 255}, {255, 3, 214}, {255, 255, 255}};



  public Cell(int col, int row, int state) {
    this.col = col;
    this.row = row;
    this.state = state;

    prevState = 0;
    age = 0;
  }

  void revive() {
    state = 1;

    age = 1;
  }

  void update() {

    
    if (state==ALIVE && prevState == ALIVE) {
      age++;
    }

    prevState = state;
  }

  void render() {
    int[] colorComponents = getColor(age);
    fill(colorComponents[0], colorComponents[1], colorComponents[2]);
    
    rect(col*cellWidth, row*cellWidth, cellWidth, cellWidth);
  }

  void kill() {
    state = DEAD;
    age = 0;
  }

  int getState() {
    return state;
  }
  
  void setState(int state) {
    this.state = state;
  }
  
  int getAge() {
     return age; 
  }

  void setAge(int age) {
     this.age = age;
  }
   int[] getColor(int age) {
    if (age>9) {
      age = 9;
    }
    switch (age) {
    case 0:
      return colors[0];
    case 1:
      return colors[1];
    case 2:
      return colors[2];
    case 3:
      return colors[3];
    case 4:
      return colors[4];
    case 5:
      return colors[5];
    case 6:
      return colors[6];
    case 7:
      return colors[7];
    case 8:
      return colors[8];
    case 9:
      return colors[9];
    default:
      return colors[10];
    }
  }
}
