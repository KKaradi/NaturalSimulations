class Falcon extends Boid{
  float chasew = 1;
  float maxv = 3;
  float range = 100;
  float repelw = 1;
  float alighnw = 1;
  float cohesionw = 1;
  Falcon(int w, int h){
    super(w, h);
    r = 3;
    
    for(int i = 0; i < truecol.length; i++){
      truecol[i] = 0;
    }
  }
  
  void chase(Boid[] boids){
    PVector chase = new PVector(0,0);
    int count = 0;
    for(Boid otherboid: boids){
      float dist = PVector.sub(otherboid.p,p).mag();
      if(dist>0 && dist<range){
        count++;
        chase.add(PVector.sub(otherboid.p, p));
      }
    }
    if(count != 0){
      chase.div(count);
      chase.normalize();
      chase.mult(maxv);
      chase.sub(v).limit(maxa);
      chase.mult(chasew);
      println(chase.div(mass));
      
      //a.add(chase.div(mass));
    }
  }
}
