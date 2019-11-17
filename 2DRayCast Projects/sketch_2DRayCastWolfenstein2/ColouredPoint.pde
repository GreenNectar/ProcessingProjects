class ColouredPoint {
  
  PVector pos;
  color col;
  
  ColouredPoint(PVector pos_, color col_) {
    pos = pos_;
    col = col_;
  }
  
  void show() {
    fill(col);
    ellipse(pos.x, pos.y, 4, 4);
  }
}
