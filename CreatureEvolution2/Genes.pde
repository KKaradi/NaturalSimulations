class Genes { //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  /*
  EvoNeuralNetwork nn;

  float mav;
  float mavMutationAmount;
  float w;
  float[][] lengths;
  PrintWriter debug = createWriter("debug.txt");
  Creature c;



  //boolean[][] template;

  //double[] inputs;
  //EvoNeuralNetwork e;

  Genes(Creature c, float mav, float w, float[][] lengths, float weightMutationAmount, float biaseMutationAmount) {
    this.c = c;
    this.mav = mav;
    this.w = w;
    this.lengths = lengths;
    nn = new EvoNeuralNetwork(lengths.length+1, lengths.length, 3, weightMutationAmount, biaseMutationAmount);
    //geneAmount();
  }
  
  Genes(Creature c, float mav, float w, float[][] lengths, EvoNeuralNetwork nn) {
    this.c = c;
    this.mav = mav;
    this.w = w;
    this.lengths = lengths;
    this.nn = new EvoNeuralNetwork(nn);
    //geneAmount();
  }
  
  Genes() {
  }
  void step() {
    debug.println("a");
    if(frameCount == 100){
      debug.flush();
      debug.close();
      exit();
    }
    double inputs[] = new double[lengths.length+1];
    for(int i = 0; i < lengths.length; i++){
      inputs[i] = 5*sin(2*PI/40*frameCount)+10;
    }
    
    inputs[0] = 10*sin(w*frameCount);
    //println(inputs[0],frameCount);
    for (int i = 1; i < inputs.length; i++) {
      //println(lengths[i-1][0], lengths[i-1][1], lengths[i-1][2]);
      inputs[i] = map(lengths[i-1][0], lengths[i-1][1], lengths[i-1][2], -.25, .25);
    }
    double[] output = nn.ff(inputs);
    for (int i = 0; i < output.length; i++) {
      output[i] = tanh(output[i]);
    }
    //println(output);
    outputToVelocity(output);
    for(int i = 0 ; i < output.length; i++){
      debug.println(output[i]);
    //println(output);
    }
    
    updateLengths(inputs);

    //for (int i = 0; i < lengths.length; i++) {
    //lengths[i][0]+=output[i];
    //println(output[i]);
    //println(lengths[i][0]);
    //}

    //println(output);
    //println(lengths.length, output.length);


    //println(lengths[i][0], lengths[i][1], lengths[i][2]);
  }
  void updateLengths(double[] output) {
    for (int i = 0; i < lengths.length; i++) {
      lengths[i][0]+=output[i];

      lengths[i][0] = limit(lengths[i][0], lengths[i][1], lengths[i][2]);
      //println(lengths[i][1], lengths[i][0], lengths[i][2], i, frameCount % 10);
      c.muscles[i].setdist(lengths[i][0]);
    }
    //println();
  }
  float limit(float initalValue, float min, float max) {
    if (initalValue < min) {
      initalValue = min;
    }
    if (initalValue > max) {
      initalValue = max;
    }
    return(initalValue);
  }
  void debug(int a) {
    for (int i = 0; i < a; i++) {
      stroke(map(i, 0, a, 0, 255/2), 255, 255);
      fill(map(i, 0, a, 0, 255/2), 255, 255);
      ellipse(frameCount*6, map(lengths[i][0], lengths[i][1], lengths[i][2], 0, 1000), 4, 4);
    }
  }
  void outputToVelocity(double[] output) {
    for (int i = 0; i < output.length; i++) {
      output[i] *= mav;
    }
  }
  float tanh(double x) {
    return((float)(2/(1+Math.pow(Math.E, 2*x))-1));
  }
  float randommutation(float a, float o) {
    float randdrift = randomGaussian()*a;
    if (randdrift > 0) {
      randdrift+=o;
    } else if (randdrift < 0) {
      randdrift-=o;
    } else {
      if (.5 > random(1)) {
        randdrift = o;
      } else {
        randdrift = -o;
      }
    }
    return(randdrift);
  }
  /*
  Genes clone(Creature c) {
   Genes copy = new Genes();
   copy.c = c;
   copy.mav = mutate(mav, mavmin, mavmax);
   t = mutate(t, tmin, tmax);
   
   copy.lengths = new float[c.muscles.length][3];
   for (int i = 0; i < lengths.length; i++) {
   copy.lengths[i][1] = mutate(lengths[i][1], dumin, dumax);
   copy.lengths[i][2] = mutate(lengths[i][2], dumin, dumax);
   copy.lengths[i][0] = (lengths[i][1]+lengths[i][2])/2;
   //println(copy.lengths[i][0], copy.lengths[i][1], copy.lengths[i][2]);
   }
   copy.w = 2*PI/t;
   copy.inputs = new double[c.muscles.length+1];
   copy.nn = new EvoNeuralNetwork(c.muscles.length+1, c.muscles.length, 3, mutationAmount, drifta, mutationa, mutationo);
   //copy.nn.mutate();
   return(copy);
   }
   
   void geneAmount() {
   lengths = new float[c.muscles.length][3];
   for (int i = 0; i < lengths.length; i++) {
   float split = random(dumin, dumax);
   lengths[i][1] = random(dumin, split);
   lengths[i][2] = random(split, dumax);
   lengths[i][0] = (lengths[i][1]+lengths[i][2])/2;
   }
   t = random(tmin, tmax);
   w = 2*PI/t;//random(tmin, tmax);
   inputs = new double[c.muscles.length+1];
   println(c.muscles.length);
   nn = new EvoNeuralNetwork(c.muscles.length+1, c.muscles.length, 3, mutationAmount, drifta, mutationa, mutationo);
   }
   */

}
