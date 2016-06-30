/*
 * Fooling around with Dan Schiffman's Flow Field/2d Perlin noise algorithms
 * @see : https://www.youtube.com/watch?v=BjoM9oKOAKY&list=PLRqwX-V7Uu6ZiZxtDDRCi6uhfTH4FilpH&index=27
 *
 *
 */

int scl = 15;
float xoff=0.0;
float yoff=0.0;
float zoff=0;
float inc = 0.07;
int cols, rows;
ArrayList<Particle> particles;
PVector[] flowField;


void setup() {
  size(1920, 1080, P2D);
  pixelDensity(2);
  //rectMode(CENTER);

  cols = floor(width/scl);
  rows = floor(height/scl);

  flowField = new PVector[(cols*rows)];
  particles = new ArrayList();
  for (int i=0; i<10000; i++) {
    particles.add(new Particle());
  }


  //fill(255, 10);
  //stroke(0,20);
  background(0);
}

void draw() {
  //background(255);
  println(frameRate);
  yoff=0;

  for (int y = 0; y < rows; y++) {
    xoff=0;
    for (int x = 0; x < cols; x++) {
      int index = x + y * cols;

      float angle = noise(xoff, yoff, zoff)*TWO_PI*4;

      PVector v = PVector.fromAngle(angle);

      v.setMag(1.2);

      flowField[index] = v;
      //*
      pushMatrix();
      translate(x*scl, y*scl);
      rotate(v.heading());
      // stroke(190, 100, 80, 1);
      stroke(255,1);
      
      line(0, 0, scl, 0);
      popMatrix();
      //*/
      xoff+=inc;
    }

    yoff+=inc;
    zoff+=0.00003;
  }
  for (Particle p : particles) {
    p.checkEdges();
    try {
      p.follow(flowField);
      p.update();
      p.display();
    }
    catch(Exception e) {
      // silence is gold 
      //println(e );
      //println(flowField.length);
      //println(floor(p.pos.x/scl)+floor(p.pos.y/scl)*cols);
      p.update();
    }
  }
}

void keyPressed() {
  switch(key) {
  case ' ':
    saveFrame("example-#####.png");
    break;
  case 'r':
    setup();
    break;
  }
}