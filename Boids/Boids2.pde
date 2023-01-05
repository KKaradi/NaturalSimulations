Boid[] boids = new Boid[200];
Falcon[] falcons = new Falcon[50];
void setup(){
  //fullScreen();
  size(1000,1000);
  //colorMode(HSB);
  
  for(int i = 0; i<boids.length; i++){
    boids[i]=new Boid(width, height);
  }
  
  for(int i = 0; i<falcons.length; i++){
    falcons[i]=new Falcon(width, height);
  }
}

void draw(){
  background(255);
  
  for(int i = 0; i<boids.length; i++){
    boids[i].act(boids);
    //boids[i].run(falcons);
    boids[i].update();
    boids[i].disp();
  }
  
  for(int i = 0; i<falcons.length; i++){
    falcons[i].act(falcons);
    falcons[i].chase(boids);
    falcons[i].update();
    falcons[i].disp();
  }
  falcons[0].dispdebug();
  boids[0].dispdebug();
}
