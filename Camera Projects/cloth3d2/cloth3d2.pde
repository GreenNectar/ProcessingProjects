// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/QLHMtE5XsMs
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.geom.*;
import processing.video.*;

Capture video;

int lockedPoints = 6;
float res = 1;
int cols = int(60 / res);
int rows = int(60 / res);

float xOffset = 0;
float yOffset = 0;
float zOffset = 0;

Particle[][] particles = new Particle[cols][rows];
ArrayList<Spring> springs;
float w = 10 * res;

VerletPhysics3D physics;


void setup() {
  size(640, 480, P3D);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[1]);
  video.start();

  springs = new ArrayList<Spring>();

  physics = new VerletPhysics3D();
  Vec3D gravity = new Vec3D(0, 1, 0);
  GravityBehavior3D gb = new GravityBehavior3D(gravity);
  physics.addBehavior(gb);

  float x = -cols*w/2 + xOffset;
  for (int i = 0; i < cols; i++) {
    float z = 0 + zOffset;
    for (int j = 0; j < rows; j++) {
      Particle p = new Particle(x + xOffset, -200 + yOffset, z + zOffset);
      particles[i][j] = p;
      physics.addParticle(p);
      z = z + w;
    }
    x = x + w;
  }

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      Particle a = particles[i][j];
      if (i != cols-1) {
        Particle b1 = particles[i+1][j];
        Spring s1 = new Spring(a, b1);
        springs.add(s1);
        physics.addSpring(s1);
      }
      if (j != rows-1) {
        Particle b2 = particles[i][j+1];
        Spring s2 = new Spring(a, b2);
        springs.add(s2);
        physics.addSpring(s2);
      }
    }
  }

  for (int i = 0; i < lockedPoints - 1; i++) {
    particles[(i + 1) * (rows / lockedPoints)][0].lock();
    particles[rows - 1][0].lock();
  }

  //particles[0][0].lock();
  //particles[int(cols/2)][0].lock();
  //particles[cols-1][0].lock();
}


void mousePressed() {
}

void captureEvent(Capture video) {
  video.read();
}

float a = 0;

void draw() {
  video.loadPixels();

  //image(video, 0, 0);

  background(51);

  translate(width/2, height/2);
  rotateY(a);
  a += 0.01;
  physics.update();


  noFill();
  //strokeWeight(1);
  noStroke();
  textureMode(NORMAL);
  for (int j = 0; j < rows - 1; j++) {
    beginShape(TRIANGLE_STRIP);
    texture(video);
    for (int i = 0; i < cols; i++) {
      float x1 = particles[i][j].x;
      float y1 =  particles[i][j].y;
      float z1 =  particles[i][j].z;
      float u = map(i, 0, cols - 1, 0, 1);
      float v = map(j, 0, rows - 1, 0, 1);
      vertex(x1, y1, z1, u, v);
      float x2 = particles[i][j + 1].x;
      float y2 =  particles[i][j + 1].y;
      float z2 =  particles[i][j + 1].z;
      v = map(j + 1, 0, rows - 1, 0, 1);
      vertex(x2, y2, z2, u, v);
    }
    endShape();
  }


  //for (Spring s : springs) {
  //  s.display();
  //}
}
