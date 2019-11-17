
ArrayList<Point> points = new ArrayList<Point>();
int amountOfPoints = 100;

void setup() {

  size(800, 800);
  smooth(8);
  
  for (int i = 0; i < amountOfPoints; i++) {
    points.add(new Point());
  }
}


void draw() {
  background(0);
  
  for(Point point : points){
    //noStroke();
    //point.renderPoint();
    stroke(255);
    point.renderLines();
    point.move(0.5);
  }
}
