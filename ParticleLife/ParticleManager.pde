class ParticleManager {
  int types;
  int per;
  int r;
  float[] parm;
  float[][][] forceParm;
  int h;
  int w;
  float dMax;
  float fricThresh;
  float fric;
  //float[] angles;
  Particle [] particles;

  ParticleManager(int types_, int per_, int r_, float[] parm_, int h_, int w_, float fric_) {
    types = types_;
    per = per_;
    r = r_;
    h = h_;
    w = w_;
    fric = fric_;
    parm = parm_; 
    //angles = angles_;
    forceParm = new float[types][types][3];    
    setforceParm();
    particles = new Particle[types*per];
    setParticles();
    dMax = parm[3];
  }

  //stable, distance, "a"x^2
  void setforceParm() {
    for (int i = 0; i<types; i++) {
      for (int j = 0; j<types; j++) {
        for (int k = 0; k<3; k++) {
          forceParm[i][j][k] = random(parm[2*k], parm[2*k+1]);
        }
      }
    }
  }

  void setParticles() {
    
    for (int i = 0; i<particles.length; i++) {
      particles[i] = new Particle(i/per, types, i, new PVector(random(w), random(h)), r, dMax, h, w, fric);
    }
  }

  float magReturn(int type1, int type2, float dist) {
    float mag;
    float start = forceParm[type1][type2][0];
    float end = forceParm[type1][type2][1];
    float apex = forceParm[type1][type2][2];
    //println(s+" "+d+" "+a);
    if (dist>=start) {
      mag = absolute(dist, start, end, apex);
    } else {
      //subject 1/s to change
      mag = exponential(dist, start);
    }

    return(mag);
  }
  
  float absolute(float x, float start, float end, float apex){
    return((-2*apex)/(-start+end)*abs(x-((start+end)/2))+apex);
  }
  
  float exponential(float x, float start){
    return(parm[6]*pow(parm[7],-x)-parm[6]*pow(parm[7], start));
  }
  
  ArrayList<float[]> listInRadius(int index) {
    ArrayList<float[]> list = new ArrayList<float[]>();
    for (int i = 0; i<particles.length; i++) {
      if (i != index) {
        float dist = PVector.dist(particles[index].p, particles[i].p);
        if (dist<=dMax) {
          float[] dists = {i, particles[i].type, dist, 0};  
          list.add(dists);  
        }
      }
    }
    return(list);
  }

  ArrayList<float[]> listEffected(int type, ArrayList<float[]> listInRadius) {
    //println(listInRadius.size());
    for (int i = listInRadius.size()-1; i>=0; i--) {
      float dMax = forceParm[type][int(listInRadius.get(i)[1])][1];

      if (dMax<=listInRadius.get(i)[2]) {
        listInRadius.remove(i);
      }
    }
    //println(listInRadius.size());
    return(listInRadius);
  }

  ArrayList<float[]> magSetT(int type, ArrayList<float[]> listEffected) {
    for (int i = 0; i<listEffected.size(); i++) {
      listEffected.get(i)[3] = magReturn(int(type), int(listEffected.get(i)[1]), listEffected.get(i)[2]);
    }
    return(listEffected);
  }

  ArrayList<float[]> magSet(Particle particle) {
    int index = particle.index;
    int type = particle.type;
    ArrayList<float[]> list = listInRadius(index);
    list = listEffected(type, list);
    list = magSetT(type, list);
    //aprintln(list);
    return(list);
  }

  void applyForce() {
    for (int i = 0; i<particles.length; i++) {
      ArrayList<float[]> magList = magSet(particles[i]);
      for (int j = 0; j<magList.size(); j++) {
        int effected = int(magList.get(j)[0]);
        float mag = magList.get(j)[3];
        //println(mag);
        PVector vec = getVec(particles[i].p, particles[effected].p, mag);
        particles[effected].applyForce(vec);
        //particles[int(mag.get(j)[0])].applyForce(getVec(particles[i].p, particles[int(mag.get(j)[0])].p, mag.get(j)[]);
      }
    }
  }

  PVector getVec(PVector self, PVector target, float mag) {
    PVector dir = PVector.sub(self, target);
    dir.normalize();
    dir.mult(mag);
    //stroke(0);
    line(self.x,self.y,target.x,target.y);
    //noStroke();
    return(dir);
  }


  void run() {
    applyForce();

    for (int i = 0; i<particles.length; i++) {
      particles[i].edge();
      particles[i].update();
      particles[i].checkEdge();
      particles[i].display();
    }
  }
}
