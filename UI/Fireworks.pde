
class Particle {
  Firework parent;
  float xPos, yPos, size, angle, speed;
  float timeSync, timeAlive;
  color colour;

  Particle(Firework p) {
    parent = p;
    xPos = parent.xPos;
    yPos = parent.yPos;
    size = random(5,8);
    angle = random(-PI,PI);
    speed = random(1,3)+parent.mul;
    timeAlive = random(800, 1200);
    timeSync = millis() + timeAlive;
    colour = parent.colour;
  }

  void render() {
    if (millis() < timeSync) {
      //size-=0.1;
      xPos += sin(angle) * speed;
      yPos += cos(angle) * speed;
      strokeWeight(size);
      stroke(colour);
      point(xPos, yPos);
    } else {
      parent.particles.remove(this);
    }
  }
}



class Firework {
  ArrayList < Particle > particles = new ArrayList();
  float xPos, yPos;
  float mul;
  color colour;

  Firework(float x, float y, float mag, color col) {
    xPos = x;
    yPos = y;
    mul = mag;
    //colour = color(random(150, 255), random(150, 255), random(150, 255));
    colour = col;
    for (int iter = 0; iter < 300; iter++)
      particles.add(new Particle(this));
  }


  void render() {      
    for( int i = 0; i<particles.size();i++){
      Particle particle = (Particle)particles.get(i);
      particle.render();
    }
    if (particles.size() <= 0){
      show.remove(this);
    }
  }
}


void firework(color h){
}
