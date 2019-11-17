class Disc {
  PVector scale;
  PVector position;
  int discValue;
  
  Disc(PVector scale_, PVector position_, int discValue_) {
    scale = scale_;
    position = position_;
    discValue = discValue_;
  }
  
  void Render() {
    rectMode(CENTER);
    rect(position.x, position.y, scale.x, scale.y);
    fill(0);
    textSize(10);
    text(discValue, position.x, position.y);
    fill(255);
  }
}
