


ArrayList<Segment> segments = new ArrayList<Segment>();
ArrayList<Segment> oldSegments = new ArrayList<Segment>();



int segmentShape = 3;
int amountOfSides = 5;
float distanceFromCenter = 300;
boolean isSquare = true;

boolean saved = false;

void setup() {
  size(1000, 1000);

  //distanceFromCenter = width / 2;

  for (int i = 0; i < amountOfSides; i++) {
    float midx = width/2;
    float midy = height/2;

    float angle = i * (2 * PI / amountOfSides);
    float x1 = midx + distanceFromCenter * cos(angle);
    float y1 = midy + distanceFromCenter * sin(angle);
    angle = (i + 1) * (2 * PI / amountOfSides);
    float x2 = midx + distanceFromCenter * cos(angle);
    float y2 = midy + distanceFromCenter * sin(angle);

    Segment segment = new Segment(new PVector(x1, y1), new PVector(x2, y2));
    segments.add(segment);
  }

  //segment.segment();

  //AddSegments(segment.segment());
}

void mousePressed() {
  CopySegments();

  for (int i = 0; i < oldSegments.size(); i++) {
    Segment segment = oldSegments.get(i);
    AddSegments(segment.segment(segmentShape));
  }
  
  saved = false;
}

void draw() {
  background(0);

  stroke(255);
  strokeWeight(1);
  //for (Segment segment : segments) {
  //  segment.show();
  //}
  colorMode(HSB);
  for (int i = 0; i < segments.size(); i++) {
    float hue = map(i, 0, segments.size(), 0, 255);
    stroke(hue, 200, 255);
    Segment segment = segments.get(i);
    segment.show();
  }
  colorMode(RGB);
  
  if (saved == false) {
    save("Capture.png");
    saved = true;
  }
}


void CopySegments() {
  oldSegments = new ArrayList<Segment>();
  for (Segment segment : segments) {
    oldSegments.add(segment);
  }
  segments = new ArrayList<Segment>();
}


void AddSegments(ArrayList<Segment> segs) {
  for (Segment seg : segs) {
    segments.add(seg);
  }
}
