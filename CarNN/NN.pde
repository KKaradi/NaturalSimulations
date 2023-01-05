class NN {
  int[] size = new int[3];{
  size[0] = 9;
  size[1] = 9;
  size[2] = 2;
  }
  
  boolean remove = false;
  float[][][] layers;
  int[][] weightsRowColumn;
  float[][][] weights;
  float[][][] biases;
  //float[][] inputs;
  //float[][] outputs;
  float mutationAmountW = 0.25;
  float mutationAmountB = 0.25;
  /*
  float changeW = 0;
  float changeB = 0;
  
  float c1;
  float c2; 
  float c3;
  
  float colorWeight = 10;
  */
  NN() {
    layers = new float[size.length][][];
    setLayers();
    weights = new float[size.length-1][][];
    biases = new float[size.length-1][][];
    weightsRowColumn = new int[size.length-1][2];
    setWeightsRowColumn();
    setWeightsBiases();
    /*
    c1 = random(255);
    c2 = random(255);
    c3 = random(255);
    */
  }

  float[] propogate(float[] In) {
    layers[0] = d(In);

    for (int i = 0; i<size.length-1; i++) {

      layers[i+1] = sig(add(mult(weights[i], layers[i]), biases[i]));
    }
    int lay = layers.length-1;
    float [] outVec = new float[layers[lay].length];
    for (int i = 0; i<layers[lay].length; i++) {
      outVec[i] = layers[lay][i][0];
    }
    return(outVec);
  }

  NN(NN parent) {
    size = parent.size;
    layers = new float[size.length][][];
    setLayers();
    weights = new float[size.length-1][][];
    biases = new float[size.length-1][][];
    weightsRowColumn = parent.weightsRowColumn;

    setWeightsBiases();
    //println(weights[0][0].length+"gray");
    
    for(int i = 0; i<parent.weights.length; i++){
      for(int j = 0; j<parent.weights[i].length; j++){
        for(int k = 0; k<parent.weights[i][j].length; k++){
          weights[i][j][k] = parent.weights[i][j][k];  
        }
      }
    }
    for(int i = 0; i<parent.biases.length; i++){
      for(int j = 0; j<parent.biases[i].length; j++){
        for(int k = 0; k<parent.biases[i][j].length; k++){
          biases[i][j][k] = parent.biases[i][j][k];  
        }
      }
    }
    
    //biases = parent.biases;
    
    //inputs = parent.inputs;
    //outputs = parent.outputs;
    //println(weights[0][0][0]+"b");
    for(int i = 0; i<weights.length; i++){
      weights[i] = mutateWeights(weights[i]); 
      
    }
    //println(weights[0][0][0]+"s");
    
    for(int i = 0; i<biases.length; i++){
      biases[i] = mutateBiases(biases[i]);
    }
    /*
    c1 = parent.c1+randomGaussian()*(changeW+changeB)*colorWeight;
    c2 = parent.c2+randomGaussian()*(changeW+changeB)*colorWeight;
    c3 = parent.c3+randomGaussian()*(changeW+changeB)*colorWeight;
    */
    
  }

  float[][] d(float[] a) {
    float[][] data = new float[a.length][1];
    for (int i = 0; i<data.length; i++) {
      data[i][0] = a[i];
    }
    return(data);
  }

  float[][] mutateWeights(float [][] data) {
    int count = 0;
    for (int i = 0; i < data.length; i ++) {
      for (int j = 0; j < data[0].length; j++) {
        data[i][j] += mutationAmountW*randomGaussian()/(sqrt(data[0].length));
        //changeW += abs(data[i][j]*(sqrt(data[0].length)));
        count += 1;
      }
    }
    //changeW /= count;
    return(data);
    
  }

  float [][] mutateBiases(float [][] data) {
    int count = 0;
    for (int i = 0; i < data.length; i ++) {
      for (int j = 0; j < data[0].length; j++) {
        data[i][j] += mutationAmountB*randomGaussian();
        //changeW += abs(data[i][j]);
        count += 1;
      }
    }
    //changeW /= count;
    return(data);
  }

  void setLayers() {
    for (int i = 0; i<size.length; i++) {
      layers[i] = new float[i][1];
    }
  }
  void p2D(float [][] data) {
    for (int i = 0; i < data.length; i ++) {
      for (int j = 0; j < data[0].length; j++) {
        print(data[i][j]+"   ");
      }
      println();
    }
  }

  void setWeightsRowColumn() {
    for (int i = 0; i<weightsRowColumn.length; i++) {
      weightsRowColumn[i][0] = size[i+1];
      weightsRowColumn[i][1] = size[i];
    }
  }

  void setWeightsBiases() {
    for (int i = 0; i<weights.length; i++) {
      int r = weightsRowColumn[i][0];
      int c = weightsRowColumn[i][1];
      weights[i] = new float[r][c];
      weights[i] = setGaussian(r, c, true);
    }
    for (int i = 0; i<biases.length; i++) {
      int r = size[i+1];

      biases[i] = new float[r][1];
      biases[i] = setGaussian(r, 1, false);
    }
  }

  float[][] setGaussian(int R, int C, boolean weight) {
    int r = R;
    int c = C;
    float[][] data = new float[r][c];

    for (int i = 0; i<r; i ++) {
      for (int j = 0; j<c; j++) {

        data[i][j] = randomGaussian();
        if (weight) {
          data[i][j]/=sqrt(c);
        }
      }
    }
    return(data);
  }

  float[][] add(float [][] a, float [][]b) {
    int r = a.length;
    int c = a[0].length;
    float[][] data = new float[r][c];
    for (int i = 0; i<r; i ++) {
      for (int j = 0; j<c; j++) {
        data[i][j] = a[i][j]+b[i][j];
      }
    }
    return(data);
  }

  float[][] sig(float[][] a) {
    int r = a.length;
    int c = a[0].length;

    for (int i = 0; i<r; i ++) {
      for (int j = 0; j<c; j++) {
        a[i][j] = sig(a[i][j]);
      }
    }
    return(a);
  }


  float sig(float n) {
    return(1/(1+exp(-n)));
  }



  float[][] mult(float [][] a, float [][]b) {
    int r = a.length;
    int c = b[0].length;
    float[][] data = new float[r][c];
    for (int i = 0; i<r; i ++) {
      for (int j = 0; j<c; j++) {
        float n = 0;
        for (int k = 0; k<a[0].length; k++) {
          n += a[i][k]*b[k][j];
        }
        data[i][j] = n;
      }
    }
    return(data);
  }
}
