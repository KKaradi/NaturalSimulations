class Graph {
  NeuralNetwork nn = new NeuralNetwork(10, 9, 4);
  float period = 100;
  float[] l = new float[9];
  Graph() {
    for (int i = 0; i < l.length; i++) {
      l[i] = .5;
    }
  }

  float tanh(double x) {
    return((float)(2/(1+Math.pow(Math.E, 2*x))-1));
  }

  void graph() {
    double[] input = new double[10];
    input[0] = 0*sin(2*PI/period*frameCount);
    for (int i = 0; i < l.length; i++) {
      input[i+1] = map(l[i],0,1,-.25,.25);
    }
    double[] output = nn.ff(input);
    for (int i = 0; i < l.length; i++) {
      //println(output[i]);
      l[i]+=(2*(tanh(output[i])));
      if (l[i]>1) {
        l[i] = 1;
      }
      if (l[i]<0) {
        l[i] = 0;
      }
    }
    colorMode(HSB);
    for (int i = 0; i < l.length; i++) {
      fill(i/(l.length+1.0)*255, 255, 255);
      ellipse(frameCount, l[i]*height, 10, 10);
    }
  }
}
