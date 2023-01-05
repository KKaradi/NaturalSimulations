class Muscle {
  float len;
  float freq = 5;//3;
  float damp = 0;//0.1;
  Node a;
  Node b;

  float maxLen;
  float minLen;
  float difference;
  float midPoint;

  DistanceJoint joint; 
  /*
  Muscle(Node a, Node b, int musclesC, int nodesC) {
    this.a = a;
    this.b = b;

    //this.nodesC = nodesC;
    //this.musclesC = musclesC;
    generatemuscle();
  }
  */
  Muscle(Node a, Node b, float midPoint, float difference) {
    this.a = a;
    this.b = b;
    this.difference = difference;
    len = midPoint;
    minLen = midPoint - difference/2;
    maxLen = midPoint + difference/2;
    generatemuscle();
  }

  void change(float changeP) {
    len+=changeP*difference;
    
    if (len<minLen) {
      len = minLen;
    }
    if (len>maxLen) {
      len = maxLen;
    }
    joint.setLength(len);
  }  
  
  float getP(){
    //return(0);
    return(map(len, minLen, maxLen, -1, 1));
  }
  
  /*
  Muscle(Node a, Node b, float deflen, float freq, float damp, float dmaxlen) {
   this.a = a;
   this.b = b;
   this.freq = freq;
   this.damp = damp;
   r = a.r; 
   generatemuscles();
   }
   */
  void generatemuscle() {
    DistanceJointDef jointdef = new DistanceJointDef();

    jointdef.bodyA = a.body;
    jointdef.bodyB = b.body;

    //random(minlen, maxlen);

    jointdef.length = box2d.scalarPixelsToWorld(len);

    jointdef.frequencyHz = 0;//0-5 0 = static
    jointdef.dampingRatio = 0.1;//0-1 1 = static

    joint = (DistanceJoint) box2d.world.createJoint(jointdef);
  }
  
  String toString(){
    return(""+map(len, minLen, maxLen, 0, 1));
  }
  
  void disp() {
    //joint.setLength(A*sin(w*frameCount)+B);
    //translate(tralate);
    Vec2 pos1 = box2d.getBodyPixelCoord(a.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(b.body);
    stroke(0);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
  }
}
