int r = 255;
float a = PI/100;
float l = 10;
PVector p;
void setup(){
  size(1000,1000);
  colorMode(HSB);
  p = new PVector(width/2, height/2);
}

void draw(){
  background(255);
  float a  = atan2(mouseY-500,mouseX-500);
  float angle = 0;
  for(int i = 0; i < r; i ++){
    fill(i,255,255);
    el(p);
    angle+=Math.pow(a,((float)i)/r);
    p.add(PVector.fromAngle(angle).mult(l));
  }
  
  p.x = 500;
  p.y = 500;
}

void el(PVector p){
  ellipse(p.x,p.y,10,10);
}
