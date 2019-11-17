class Point {
  float x, y, dir, sp, sinL, sinH, size;


  Point(float x, float y, float dir, float sp, float sinL, float sinH, float size) {
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.sp = sp;
    this.sinL = sinL;
    this.sinH = sinH;
    this.size = size;
  }

  void Move() {
    //float angle = map(this.y, -height/2, height/2, PI/2, -PI/2);
    float angle = sin(x / sinL);
    this.dir = angle;
    
    float xPos = sinH * cos(angle);
    float yPos = sinH * sin(angle);
    this.x = this.x + xPos;
    this.y = this.y + yPos;


    //if (this.x > width) {
    //  this.x = 0;
    //}
    //if (this.x < 0) {
    //  this.x = width;
    //}
    //if (this.y < -height/2) {
    //  this.y = height/2;
    //}
    //if (this.y > height/2) {
    //  this.y = -height/2;
    //}
  }


  void Render() {
    ellipse(this.x, this.y, this.size, this.size);
  }
}
