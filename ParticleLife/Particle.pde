class Particle {
  PVector p;
  PVector v;
  PVector a;
  PVector c;
  int type;
  int types;
  int r;
  int index;
  int h;
  int w;
  float dMax;

  float fric;

  Particle(int type_, int types_, int index_, PVector p_, int r_, float dMax_, int h_, int w_, float fric_) {
    type = type_;
    types = types_;
    index = index_;
    r = r_;
    p = p_;
    h = h_;   
    w = w_;
    c = new PVector(w/2, h/2);
    dMax = dMax_;
    fric = fric_;

    v = new PVector(0, 0);
    a = new PVector(0, 0);
  }

  void display() {


    fill(float(type)/(types)*255, 255, 255);
    /*
    ArrayList<float[]> list = pm.magSet(0, 0);
     
     for (int i = 0; i<list.size(); i++) {
     if (list.get(i)[0] == index) {
     fill(float(type)/(types-1)*255, 255, 50);
     }
     }
     */
    ellipse(p.x, p.y, 1*r, 1*r);
    //rect(p.x,p.y,1,1);
    //point(p.x,p.y);
  }

  void applyForce(PVector force) {
    a.add(force);
  }

  void update() {
    friction();
    v.add(a);
    p.add(v);
    v.limit(10);
    a.mult(0);
  }

  void friction() {
    PVector friction = v.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(fric);
    applyForce(friction);
  }
  
  void edge(){
    PVector line = PVector.sub(p, new PVector(w/2, h/2));
    float truemag = line.mag();
    float angle = line.heading();
    float forheight = abs((width/2)/cos(angle));
    float forwidth = abs((height/2)/sin(angle));
    float mag = min(forheight, forwidth);
    float vmag = pow(10, 10*(truemag/mag-1));
    line.normalize();
    line.mult(-vmag);
    applyForce(line);
    //println(vmag);
  }
  void checkEdge() {
    if (p.x<0) {
      p.x = 0;    
      //v.x*=-1;
      //a.x*=-1;
    }
    if (p.x>w) {
      p.x = w;
      //v.x*=-1;
      //a.x*=-1;
    }
    if (p.y<0) {
      p.y = 0; 
      //v.y*=-1;
      //a.y*=-1;
    }
    if (p.y>h) {
      p.y = h;
      //v.y*=-1;
      //a.y*=-1;
    }
  }
}
