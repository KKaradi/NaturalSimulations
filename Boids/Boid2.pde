class Boid {
  PVector p;
  PVector v;
  PVector a;
  float repelw = 1;
  float alighnw = 1;
  float cohesionw = 1;
  float runw = 2;
  float mult = 1;
  float maxv = 2;
  float maxa = .03;

  float r;// = 3;
  float range = 50;
  float mass;
  float[] col = new float[3];
  float[] truecol = new float[3];
  int w;
  int h;
  PVector[] forcescopy = {new PVector(0, 0), new PVector(0, 0), new PVector(0, 0)};

  Boid(int w, int h) {
    this.w = w;
    this.h = h;
    p = new PVector(random(w), random(h));
    v = new PVector(0, 0);
    a = new PVector(0, 0);
    r = random(3, 3);
    mass = sq(r)*1/9;
    for (int i = 0; i < truecol.length; i++) {
      truecol[i] = 255;//random(127,129);
      col[i] = truecol[i];
    }
  }

  void run(Boid[] boids) {
    PVector run = new PVector(0, 0);
    int count = 0;
    for (Boid otherboid : boids) {
      float dist = PVector.sub(otherboid.p, p).mag();

      if (dist>0 && dist<range) {
        count++;
        run.add(calcsepforce(otherboid.p, dist));
        //println(calcsepforce(otherboid.p, dist));
      }
    }
    //println(run);
    if (count != 0) {
      run.div(count);
      //println(run);
      run.normalize();
      //println(run);
      run.mult(maxv);
      //println(run);
      run.sub(v).limit(maxa);
      //println(run);
      run.mult(runw);

      //println(run);
      a.add(run.div(mass));
    }
  }


  void act(Boid[] boids) {
    PVector[] forces = new PVector[3];
    for (int i = 0; i < forces.length; i++) {
      forces[i] = new PVector(0, 0);
    }
    int count = 0;
    for (int i = 0; i < col.length; i++) {
      col[i] = 0;
    }
    for (Boid otherboid : boids) {
      float dist = PVector.dist(otherboid.p, p);//PVector.sub(otherboid.p, p).mag();
      if (dist>0 && dist<range) {
        count++;
        forces[0].add(calcsepforce(otherboid.p, dist));
        forces[1].add(otherboid.v);
        forces[2].add(otherboid.p.copy().sub(p));
        for (int i = 0; i < col.length; i++) {
          col[i] += otherboid.truecol[i];
        }
      }
    }
    if (count > 0) {
      for (int i = 0; i < 3; i++) {
        forces[i].div(count);
      }
    }
    if (forces[0].mag() > 0) {
      forces[0].normalize();
      forces[0].mult(maxv);
      forcescopy[0] = PVector.add(forces[0].copy().mult(20), p);
      forces[0].sub(v);
      //forces[0].limit(maxa);
    }
    if (forces[1].mag() > 0) {
      forces[1].normalize();
      forces[1].mult(maxv);
      forcescopy[1] = PVector.add(forces[1].copy().mult(20), p);
      forces[1].sub(v);
      forces[1].limit(maxa);
    }
    if (forces[2].mag() > 0) {
      forces[2].normalize();
      forces[2].mult(maxv);
      forcescopy[2] = PVector.add(forces[2].copy().mult(20), p);
      forces[2].sub(v);
      //forces[2].limit(maxa);
    }
    /*
        forces[i].normalize();
     forces[i].mult(maxv);
     forcescopy[i] = PVector.add(forces[i].copy().mult(20),p);
     forces[i].sub(v).limit(maxa);
     }
     */
    float n = (repelw+alighnw+cohesionw);
    //float[] true = new float[3];
    float truea = repelw/n*mult;
    float trueb = alighnw/n*mult;
    float truec = cohesionw/n*mult;

    //forces[0].mult(truea);
    //forces[1].mult(trueb);
    //forces[2].mult(truec);
    for (PVector force : forces) {
      a.add(force);//.div(mass)/*PVector.sub(force, v).limit(maxa)*/);
    }

    for (int i = 0; i < col.length; i++) {
      col[i] += truecol[i];
      col[i]/=(count+1);
      if (col[i]>=128) {
        col[i] = 255;
      } else {
        col[i] = 0;
      }
    }
  }

  PVector calcsepforce(PVector other, float dist) {
    PVector sepforce = PVector.sub(p, other);
    sepforce.normalize().mult(1/dist);
    return(sepforce);
  }

  void dispdebug() {
    noFill();
    stroke(0, 0, 0);
    ellipse(p.x, p.y, range*2, range*2);

    stroke(255, 0, 0);
    if (forcescopy[0].mag() > 0) {
      line(forcescopy[0].x, forcescopy[0].y, p.x, p.y);
    }
    stroke(0, 0, 255);
    if (forcescopy[1].mag() > 0) {
      line(forcescopy[1].x, forcescopy[1].y, p.x, p.y);
    }
    stroke(0, 255, 0);
    if (forcescopy[2].mag() > 0) {
      line(forcescopy[2].x, forcescopy[2].y, p.x, p.y);
    }
    for (int i = 0; i<3; i++) {
      forcescopy[i].mult(0);
    }
  }

  void disp() {
    float vr =  r;//sqrt(r);
    float theta = v.heading() + PI/2;
    //fill(color(col[0], col[1], col[2]));
    fill(color(truecol[0], truecol[1], truecol[2]));
    stroke(0);
    pushMatrix();
    translate(p.x, p.y);
    rotate(theta);
    beginShape();
    vertex(0, -vr*2);
    vertex(-vr, vr*2);
    vertex(vr, vr*2);
    endShape(CLOSE);
    popMatrix();
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, p);
    desired.normalize().mult(maxv);
    PVector steer = PVector.sub(desired, v);
    steer.limit(maxa);
    a.add(steer);
  }

  void update() {
    v.add(a);
    p.add(v);
    a.mult(0);
    if (p.x<0) {
      p.x = w;
    }
    if (p.x>w) {
      p.x = 0;
    }
    if (p.y<0) {
      p.y = h;
    }
    if (p.y>h) {
      p.y = 0;
    }
  }
}
