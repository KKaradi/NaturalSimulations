class Track {
  int len;
  PVector[] node;// = new PVector[len];
  PVector[] wall;
  PVector[] wall1;
  PVector[] wall2;
  float[] wid;
  float[] dists;
  float[] distsum;
  boolean trackmode = false;
  float sum = 0;
  
  
  Track(PVector[] Node, int Len, float[] Wid) {
    len = Len;
    node = new PVector[Len];
    wid = new float[Len];
    wall1 = new PVector[Len];
    wall2 = new PVector[Len];
    dists = new float[len];
    distsum = new float[len];
    node = Node;
    wid = Wid;
    //track.setWall();
  }

  void setWall() {
    for (int i = 0; i < len; i++) {

      PVector a = new PVector(0, 0);
      PVector b = new PVector(0, 0);
      PVector wn1 = new PVector(wid[i]/2, 0);
      PVector wn2 = new PVector(wid[i]/2, 0);

      PVector piv = node[i].copy();

      if (i == 0) {

        a = node[node.length-1].copy();
      } else {
        a = node[i-1].copy();
      }    
      if (i == node.length-1) {
        b = node[0].copy();
      } else {
        b = node[i+1].copy();
      }


      a.sub(piv);

      b.sub(piv);

      float aa = atan2(a.y, a.x);
      //println(degrees(aa));
      float ab = atan2(b.y, b.x);
      //println(degrees(ab));
      float newa = (aa+ab)/2;
      if (i==0&& trackmode) {

        newa = radians(90);
      }
      if (i==node.length-1 && trackmode) {
        newa = radians(90);
      }
      wn1.rotate(newa);
      wn1.add(piv);

      wn2.rotate(PI+newa);
      wn2.add(piv);
      if (i == 0) {
        wall1[0] = wn1;
        wall2[0] = wn2;
      } else {

        PVector pwn1 = wall1[i-1].copy();  
        PVector pwn2= wall2[i-1].copy();
        pwn1.sub(a);
        pwn2.sub(a);
        float pa1 = atan2(pwn1.y, pwn1.x);
        float pa2 = atan2(pwn2.y, pwn2.x);
        if (aa<pa1&&pa1<aa+PI) {
          if (aa<newa&&newa<aa+PI) {
            wall1[i]=wn2;
            wall2[i]=wn1;
          } else {
            wall1[i]=wn1;
            wall2[i]=wn2;
          }
        } else {

          if (aa<newa&&newa<aa+PI) {
            wall1[i]=wn2;
            wall2[i]=wn1;
          } else {
            wall1[i]=wn1;
            wall2[i]=wn2;
          }
        }
      }
    }
    for (int i = 0; i<dists.length; i++) {
      if (i == len-1) {
        dists[i] = PVector.dist(node[i], node[0]);
      } else {
        dists[i] = PVector.dist(node[i], node[i+1]);
      }
    }
    //println(dists);
    for (int i = 0; i<distsum.length; i++) {
      for (int j = i; j != -1; j--) {
        distsum[i] += dists[j];
      }
    }
    for(int i = 0; i<dists.length; i++){
      sum+=dists[i];  
    }
    //println(distsum);
  }

  void setdistarr() {
    for (int i = 0; i< dists.length; i++) {
    }
  }

  void display() {
    stroke(0);
    /*
    fill(255, 0, 0);
    for (PVector p : node) {
      ellipse(p.x, p.y, 10, 10);
    }
    fill(0, 0, 255);
    for (PVector p : wall1) {
      ellipse(p.x, p.y, 10, 10);
    }
    fill(0, 255, 0);
    for (PVector p : wall2) {
      ellipse(p.x, p.y, 10, 10);
    }
    */
    if (trackmode) {
      line(wall1[0].x, wall1[0].y, wall2[0].x, wall2[0].y);
    }
    for (int i = 0; i<wall1.length+booltoint(trackmode); i++) {
      if (i == wall1.length-1) {
        line(wall1[i].x, wall1[i].y, wall1[0].x, wall1[0].y);
        line(wall2[i].x, wall2[i].y, wall2[0].x, wall2[0].y);
      } else {
        line(wall1[i].x, wall1[i].y, wall1[i+1].x, wall1[i+1].y);
        line(wall2[i].x, wall2[i].y, wall2[i+1].x, wall2[i+1].y);
      }
    }
    if (trackmode) {
      stroke(255, 0, 0);
      line(wall1[wall1.length-1].x, wall1[wall1.length-1].y, wall2[wall2.length-1].x, wall2[wall2.length-1].y);
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
}
