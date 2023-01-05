class Car {
  boolean remove;
  float size = 10;
  int raynum = 9;
  PVector p = new PVector(0, 0);
  PVector pp = new PVector(0, 0);
  PVector[] cp = new PVector[4];
  PVector[] raya = new PVector[raynum];
  PVector[] ray = new PVector[raynum];
  PVector[] c = new PVector[4];
  float[] minray = new float[raynum];
  boolean hit = false;
  float heading = radians(1);
  float v = 0;
  float accel  = 0;
  float raydiff = 0;
  float raymaxlen = 200;
  float raystart = -90;
  float turn = 5;
  float dist = 0;
  int target = 1;
  int trackmode = 1;
  int[] section;
  int lap = 0;
  float turnamount = 2;
  float accelamount = 0.05;
  float[] out = new float[2];
  float cap = 20;
  float aveV;
  int amnistFrame = 25;
  float vthres = 0.01;
  float defalt = 1;
  float[] vArray = new float[amnistFrame];
  color col;

  
  NN nn;
  Track track;

  Car(PVector P, Track ttrack, NN n) {
    p.set(P.x, P.y);
    setCP();
    nn = n;
    track = ttrack;
    section = new int[track.len];
    for (int i = 0; i<section.length; i++) {
      if (i == 0) {
        section[i] = track.len-1;
      } else {
        section[i] = i-1;
      }
    }
    for(int i = 0; i<vArray.length;i++){
      vArray[i] = defalt;  
    }
   
  }
  
  void setVArray(){
      for(int i = 0; i<vArray.length-1; i++){
        vArray[i+1] = vArray[i];
        
      }        
      vArray[0] = abs(v);
      float tot = 0;
      for(int i = 0; i<vArray.length-1; i++){
        tot+=vArray[i];        
      }      
      tot /= vArray.length;
      if(tot < vthres){
        hit = true;
      }
      
  }
  
  void prop() {
    out = nn.propogate(minray);
  };

  void setCP() {

    cp[0]=new PVector(size, -size/2);
    cp[1]=new PVector(size, size/2);
    cp[3]=new PVector(-size, -size/2);
    cp[2]=new PVector(-size, size/2);

    for (int i = 0; i < raya.length; i++) {
      raya[i] = PVector.fromAngle(radians(raystart+i*(abs(raystart*2)/(raynum-1))));
      raya[i].mult(-abs(raydiff*(i-((raynum-1)/2)))+raymaxlen);
    }
    for (int i = 0; i < c.length; i++) {
      c[i] = new PVector(0, 0);
    }
  }

  void setC() {

    for (int i = 0; i < c.length; i++) {
      c[i] = PVector.add(p, PVector.fromAngle(heading - cp[i].heading()).mult(cp[i].mag()));
    }

    for (int i = 0; i < ray.length; i++) {
      ray[i] = PVector.add(p.copy().add(PVector.fromAngle(heading).mult(size)), PVector.fromAngle(heading - raya[i].heading()).mult(raya[i].mag()));
    }
  }

  void ro(PVector C, float t) {
    C.sub(p);    
    C.rotate(0);
    C.add(p);
  }

  void setDist() { 
     
    if (!hit) {
      //println(p+" ------- "+pp);
      if (intersect(p, pp, track.wall1[target], track.wall2[target])) {
        
        int s = target;
        if (target == track.len-1) {
          target = 0;
        } else {
          target += 1;
        }

        if (s == 0 && target == 1) {
          lap+=1;
        }
      }

      dist = PVector.dist(track.node[target], p);
      if (target != 1) {
        dist = track.dists[section[target]]-dist+track.distsum[section[target]-1];
      } else {
        dist = track.dists[section[target]]-dist;
      }
      dist+=lap*track.sum;
    }
   
  }



  void prepos() {
    //println(p);
    //println(pp+"e");

    pp.set(p.x, p.y);
  }

  void setHead(/*boolean[] in*/) {
    /*
    if (in[1]&&!in[2]) {
     heading+=radians(-turn);
     }
     if (!in[1]&&in[2]) {
     heading+=radians(turn);
     }
     */
    turn = radians(turnamount*(out[0]-.5));

    heading+=turn;

    accel = accelamount*(out[1]-0.5);
    
  }



  void move() {
    PVector a = PVector.fromAngle(heading);

    v+=accel;
    /*
    if (cap<v) {
      v = cap;
    }
    if (-cap>v) {
      v = -cap;
    }
    */
    a.mult(v);
    //line(p.x, p.y, p.x+a.x, p.y+a.y);

    p.add(a);
  }

  void display(boolean disp, boolean top) {
    /*
    text(dist, 130, 100);
     text(target, 200, 100);
     
     if (hit) {
     background(255, 0, 0, 25);
     }
     */
    if(disp){
    stroke(0);
    fill(255);
    if(top){
      fill(255,0,0);  
    }
    beginShape();
      vertex(c[0].x,c[0].y);
      vertex(c[1].x,c[1].y);
      vertex(c[2].x,c[2].y);
      vertex(c[3].x,c[3].y);
      
    endShape(CLOSE);
    /*
    line(c[0].x, c[0].y, c[1].x, c[1].y);
    line(c[1].x, c[1].y, c[2].x, c[2].y); 
    line(c[2].x, c[2].y, c[3].x, c[3].y); 
    line(c[3].x, c[3].y, c[0].x, c[0].y); 
    */
    PVector out = p.copy().add(PVector.fromAngle(heading).mult(size));
    /*
    for (int i = 0; i < ray.length; i++) {
      stroke(255, 0, 0, 50);
      
      if(i == 2){
       stroke(255,0,0); 
       }else{
       stroke(0);  
       }
       
      line(out.x, out.y, ray[i].x, ray[i].y);
      
    }
    */
    
    //ellipse(cramersrule(out, ray[4], track.wall1[iret(0, track.wall1.length, 0)], track.wall1[iret(0, track.wall1.length, 1)]).x, cramersrule(out, ray[2], track.wall1[iret(0, track.wall1.length, 0)], track.wall1[iret(0, track.wall1.length, 1)]).y, 10, 10);
    
    strokeWeight(0.25);
    for (int i = 0; i<ray.length; i++) {
      PVector raymag = PVector.fromAngle(heading - raya[i].heading()).mult(minray[i]);
      
      raymag.add(out);
      
      //println(raymag.mag());
       //println(ray[i].mag());
       
      //stroke(0);
      line(out.x, out.y, raymag.x, raymag.y);
    }
    strokeWeight(1);
    
    }
  }

  int booltoint(boolean mode) {
    int ret;
    if (mode) {
      ret = -1;
    } else {
      ret = 0;
    }
    return(ret);
  }

  void intbodytrack() {
    
    for (int i = 0; i<c.length; i++) {
      for (int j = 0; j<track.wall1.length+booltoint(track.trackmode); j++) {

        if (intersect(c[iret(i, c.length, 0)], c[iret(i, c.length, 1)], track.wall1[iret(j, track.wall1.length, 0)], track.wall1[iret(j, track.wall1.length, 1)])) {
          hit = true;
        }
        if (intersect(c[iret(i, c.length, 0)], c[iret(i, c.length, 1)], track.wall2[iret(j, track.wall2.length, 0)], track.wall2[iret(j, track.wall2.length, 1)])) {
          hit = true;
        }
      }
      if (intersect(c[iret(i, c.length, 0)], c[iret(i, c.length, 1)], track.wall1[0], track.wall2[0])&&track.trackmode) {
        hit = true;
      }
    }
  }

  void rayconnect() {
    PVector out = p.copy().add(PVector.fromAngle(heading).mult(size));
    for (int i = 0; i<ray.length; i++) {
      for (int j =0; j<track.wall1.length+booltoint(track.trackmode); j++) {

        if (intersect(out, ray[i], track.wall1[iret(j, track.wall1.length, 0)], track.wall1[iret(j, track.wall1.length, 1)])) {
          setMin(cramersrule(out, ray[i], track.wall1[iret(j, track.wall1.length, 0)], track.wall1[iret(j, track.wall1.length, 1)]), i);
        }
        if (intersect(out, ray[i], track.wall2[iret(j, track.wall2.length, 0)], track.wall2[iret(j, track.wall2.length, 1)])) {
          setMin(cramersrule(out, ray[i], track.wall2[iret(j, track.wall2.length, 0)], track.wall2[iret(j, track.wall2.length, 1)]), i);
          //println(cramersrule(out, ray[i], track.wall2[iret(j, track.wall2.length, 0)], track.wall2[iret(j, track.wall2.length, 1)]));
        }
      }
      if (intersect(out, ray[i], track.wall1[0], track.wall2[0])&&track.trackmode) {
        setMin(cramersrule(out, ray[i], track.wall1[0], track.wall2[0]), i);
      }
    }
  }
  void minKill() {
    for (int i = 0; i<minray.length; i++) {
      PVector out = p.copy().add(PVector.fromAngle(heading).mult(size));
      minray[i]=ray[i].copy().sub(out).mag();
    }
  }


  void setMin(float test, int index) {
    if (minray[index] == 0) {
      minray[index] = test;
    }
    minray[index] = min(test, minray[index]);
  }

  int iret(int i, int len, int in) {
    int[] ret = new int[2];
    if (i == len-1) {
      ret[0] = i;
      ret[1] = 0;
    } else {
      ret[0] = i;
      ret[1] = i+1;
    }
    return(ret[in]);
  }

  boolean ccw(PVector A, PVector B, PVector C) {
    return( (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x)  );
  }


  boolean intersect(PVector A, PVector B, PVector C, PVector D) {
    return(( ccw(A, C, D) != ccw(B, C, D) )&&( ccw(A, B, C) != ccw(A, B, D) ));
  }

  float cramersrule(PVector A, PVector B, PVector C, PVector D) {
    boolean if0slp = false;
    PVector magl = new PVector(0, 0);
    float mab = (A.y-B.y)/(A.x-B.x);
    float mcd = (C.y-D.y)/(C.x-D.x);
    if (C.x-D.x == 0) {
      if0slp = true;
      magl.set(C.x, slopepointx(mab, new PVector(A.x, A.y), C.x));
    }

    if (!if0slp) {
      float a=-mab;
      float b=1;
      float c=-mab*A.x+A.y;
      float d=-mcd;
      float e=1;
      float f=-mcd*C.x+C.y;
      float de = det(a, b, d, e);
      float nux= det(c, b, f, e);
      float nuy = det(a, c, d, f);
      magl.set(nux/de, nuy/de);
    }

    magl.sub(A);

    return(magl.mag());

    //return(nu);
    //return(A.copy().add(new PVector(nux/de, nuy/de)).mag());
  }

  float slopepointx(float m, PVector p, float x) {
    return(m*(x-p.x)+p.y);
  }

  float det(float a, float b, float c, float d) {
    return((a*d)-(b*c));
  }

  /*
 float dist(PVector caster, PVector castend, PVector seg1, PVector seg2) {
   if (intersect(caster, castend, seg1, seg2)) {
   }
   }
   */
}
