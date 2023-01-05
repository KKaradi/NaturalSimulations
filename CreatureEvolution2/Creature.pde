class Creature {
  float r = 10;
  int id;
  
  float change;
  float period;
  Node[] nodes;
  Muscle[] muscles;
  EvoNeuralNetwork nn;
  float[][] lengths;
  boolean[][] template;  
  
  float distance;
  float tare;
  
  Creature(float change, float period, boolean[][] template, float[][] lengths, EvoNeuralNetwork  nn) {
    this.change = change;
    this.period = period;
    this.template = template;
    this.lengths = lengths;
    this.nn = nn;
    
    generatenodes(template.length);
    generatemuscles(template, lengths);
    id = (int)random(0, Integer.MAX_VALUE);
  }

  void generatemuscles(boolean[][] template, float[][] lengths) {
    int musclesc = 0;
    for (int i = 0; i < template.length; i++) {
      for (int j = 0; j < i; j++) {
        if (template[i][j]) {
          musclesc++;
        }
      }
    }
    muscles = new Muscle[musclesc];
    int index = 0;
    for (int i = 0; i < template.length; i++) {
      for (int j = 0; j < i; j++) {
        if (template[i][j]) {
          muscles[index] = new Muscle(nodes[i], nodes[j], lengths[i][0], lengths[i][1]);
          index++;
        }
      }
    }
  }

  void generatenodes(int nodesc) {
    nodes = new Node[nodesc];
    for (int i = 0; i < nodesc; i++) {
      nodes[i] = new Node(cos(2*PI*(i+1)/nodes.length)*100, sin(2*PI*(i+1)/nodes.length)*100+width/2);
    }
    setDistance();
  }

  void step() {
    double[] inputs = new double[muscles.length+1];
    inputs[0] = 10*sin(2*PI/period*frameCount);
    for (int i = 0; i < muscles.length; i++) {
      inputs[i+1] = muscles[i].getP();
    }
    double[] outputs = nn.ff(inputs);
    for (int i = 0; i < outputs.length; i++) {
      muscles[i].change(tanh(outputs[i]) *change);
    }
    distance = setDistance();
  }

  float tanh(double x) {
    return((float)(2/(1+Math.pow(Math.E, 2*x))-1));
  }

  String toString() {
    String to = "";
    for (int i= 0; i < muscles.length; i++) {
      to+=muscles[i].toString()+",";
    }
    return(to);
  }

  
  float setDistance(){
    float sum = 0;
    for(int i  = 0; i < nodes.length; i++){
      sum+=box2d.getBodyPixelCoord(nodes[i].body).x;
    }
    sum/=nodes.length;
    return(sum-tare);
  }
  
  void tareDistance(){
    tare = setDistance();
  }
  
  void display() {
    pushMatrix();
    for (int i = 0; i < nodes.length; i++) {
      nodes[i].disp();
    }
    for (int i = 0; i < muscles.length; i++) {
      muscles[i].disp();
    }
    popMatrix();
  }
}
