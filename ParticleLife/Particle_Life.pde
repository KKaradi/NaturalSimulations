float[] parm = {5, 10, 100, 150, -.15, .15, .01, 1.5};
// {5, 10, 100, 150, -.15, .15, .01, 1.5};
//(20, 50, 5, parm, height, width, 0.15)
boolean loop = true;
ParticleManager pm;
void setup(){
  fullScreen();
  //size(400,400);
  rectMode(CENTER);
  colorMode(HSB);
  //noStroke();
  stroke(255,5);
  background(0);
  int num = 20;
  //println(height);
  // ParticleManager(int types_, int per_, int r_, float sRange_, float dMin_, float dMax_, float aRange_, int h_, int w_, float fricThresh_, float fric_) {
  pm = new ParticleManager(num, 700/num, 10, parm, height, width, 0.15);
  //aprintln(pm.listInRadius(0));
  //println("------------------------");
  //pm.magSet(0,0);
  frameRate(60.0);
  pm.applyForce();
   
}  

//ParticleManager pm = new ParticleManager(10, 20, 5, 10, 100, 250, .1, 1080, 1920, 10, 5);

void draw(){
 
  background(0);
  scale(1, -1);
  translate(0, -height);
  pm.run();
  //saveFrame("output/partlife_####");
}
void mousePressed(){
   if(loop){
       noLoop();
   }else{
     loop();
   }
   loop = !loop;
}

//void aprintln(ArrayList<float[]> list){
//  for(int i = 0; i<list.size(); i++){
//    println(list.get(i));
//  }
//}
/*
void setangles(){
  PVector c = new PVector(1920/2, 1080/2);
  angles[0] = PVector.sub(new PVector(0,0), c).heading();
  angles[1] = PVector.sub(new PVector(1920,0), c).heading();
  angles[2] = PVector.sub(new PVector(1920,1080), c).heading();
  angles[3] = PVector.sub(new PVector(0,1080), c).heading();
}
*/
