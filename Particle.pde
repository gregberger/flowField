class Particle {
  PVector pos;
  PVector prevPos;
  private PVector vel;
  private PVector accel;
  private float maxSpeed = 6.6;

  public Particle(float x, float y) {
    this.pos = new PVector(x, y);
    this.prevPos = pos.copy();
    this.vel = new PVector(0, 0);
    this.accel = new PVector(0, 0);
  }

  public Particle() {
    this(random(width), random(height));
  }

  public void applyForce(PVector force) {
    /*
    if(pos.x < width*0.1){
       force.mult(-3); 
    }else if(pos.x > width*0.99){
       force.mult(-45); 
    }
    */
    this.accel.add(force);
  }

  public void update() {
    
    this.vel.add(this.accel);
    this.vel.limit(maxSpeed);
    this.pos.add(this.vel);
    this.accel.mult(0);
    
  }

  public void follow(PVector[] vectors) {
    int x = floor(this.pos.x/scl);
    int y = floor(this.pos.y/scl);
    int idx = x + y * cols;
    
    PVector force = vectors[idx];
    applyForce(force);
    
  }

  private void updatePrevious(){
    
     prevPos.x = pos.x;
     prevPos.y = pos.y;
  }

  public void checkEdges() {
    if (this.pos.x > width) {
      this.pos.x = 0;
      updatePrevious();
    }
    if (this.pos.x < 0) {
      this.pos.x = width;
      updatePrevious();
    }
    if (this.pos.y > height) {
      this.pos.y = 0;
      updatePrevious();
    }
    if (this.pos.y < 0) {
      this.pos.y = height;
      updatePrevious();
    }
  }

  public void display() {
    
    stroke(255,1);
    
    strokeWeight(1);
    line(prevPos.x, prevPos.y, pos.x, pos.y);
    stroke(10, 0,255,1);
    strokeWeight(0.4);
    line(prevPos.x+1, prevPos.y-1, pos.x+1, pos.y-1);
    
    updatePrevious();
  }
}