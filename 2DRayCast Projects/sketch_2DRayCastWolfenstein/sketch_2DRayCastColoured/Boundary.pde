class Boundary {
  
  color col;
  PVector a, b;
  
  Boundary(float x1, float y1, float x2, float y2) {
    a = new PVector(x1, y1);
    b = new PVector(x2, y2);
    
    colorMode(HSB);
    col = color(random(0, 255), 255, 255);
    colorMode(RGB);
  }
  
  void show() {
    stroke(col);
    line(a.x, a.y, b.x, b.y);
    noStroke();
  }
}
