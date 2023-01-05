class NeuralNetwork {
  int[] layers;
  RealMatrix[] weights;
  RealMatrix[] biases;

  int layerslength;
  int inputlength;
  int outputlength;
  String fileName;

  NeuralNetwork(int inputlength, int outputlength, int layerslength) {
    this.inputlength = inputlength;
    this.outputlength = outputlength;
    this.layerslength = layerslength;
    
    genlayers();
    genweights();
    genbiases();
  }


  NeuralNetwork(int inputlength, int outputlength, int layerslength, String fileName) {
    this.inputlength = inputlength;
    this.outputlength = outputlength;
    this.layerslength = layerslength;

    genlayers();
    genweights();
    genbiases();
    this.fileName = fileName;
  }

  NeuralNetwork(String fileName) {
    load(fileName);
  }

  NeuralNetwork(NeuralNetwork nn) {
    this.layers = nn.layers.clone();
    this.layerslength = nn.layerslength;
    this.inputlength = nn.inputlength;
    this.outputlength = nn.outputlength;
    this.weights = clone(nn.weights);
    this.biases = clone(nn.biases);
  }
  
  RealMatrix[] clone(RealMatrix[] matrix){
    RealMatrix[] matrixR = new RealMatrix[matrix.length];
    for(int i = 0; i < matrix.length; i++){
      matrixR[i] = matrix[i].copy();
    }
    return(matrixR);
  }
  
  void genlayers() {
    layers = new int[layerslength];
    for (int i = 0; i < layerslength-1; i++) {
      layers[i] = inputlength;
    }
    layers[layerslength-1] = outputlength;
  }

  void genweights() {
    weights = new RealMatrix[layerslength-1];
    for (int i = 0; i < layerslength-1; i++) {
      //println(layers[i].getColumnDimension(), layers[i+1].getColumnDimension());
      double[][] weight = new double[layers[i]][layers[i+1]];
      for (int j = 0; j < weight.length; j++) {
        for (int k = 0; k < weight[j].length; k++) {
          weight[j][k] = randomGaussian()/pow(weight.length, .5);
          //println(randomGaussian()/pow(j, .5));
        }
      }
      weights[i] = MatrixUtils.createRealMatrix(weight);
    }
    //println(weights);
  }

  void genweights(String[] weightsString) {
    weights = new RealMatrix[layerslength-1];
    int c = 0;
    for (int i = 0; i < layerslength-1; i++) {
      double[][] weight = new double[layers[i]][layers[i+1]];
      for (int j = 0; j < weight.length; j++) {
        for (int k = 0; k < weight[j].length; k++) {
          weight[j][k] = Double.parseDouble(weightsString[c]);
          c++;
        }
      }
      weights[i] = MatrixUtils.createRealMatrix(weight);
    }
  }

  void genbiases() {
    biases = new RealMatrix[layerslength-1];
    for (int i = 0; i < layerslength-1; i++) {
      biases[i] = MatrixUtils.createRealMatrix(arraytocolvec(new double[layers[i+1]]));
    }
  }

  void genbiases(String[] biasesString) {
    biases = new RealMatrix[layerslength-1];
    int c = 0;
    for (int i = 0; i < layerslength-1; i++) {
      double[] biaseArray = new double[(layers[i+1])];
      for (int j = 0; j < biaseArray.length; j++) {
        biaseArray[j] = Double.parseDouble(biasesString[c]);
        c++;
      }
      biases[i] = MatrixUtils.createRealMatrix(arraytocolvec(biaseArray));
    }
  }

  void load(String fileName) {
    String[] data = loadStrings(fileName+"/data.txt");
    String[] weights = loadStrings(fileName+"/weight.txt");
    String[] biases = loadStrings(fileName+"/biase.txt");
    layerslength = Integer.parseInt(data[0]);
    inputlength  = Integer.parseInt(data[1]); 
    outputlength = Integer.parseInt(data[2]);
    genlayers();
    genweights(weights);
    genbiases(biases);
  }

  void save(String fileName) {
    PrintWriter dataWriter = createWriter(fileName+"/data.txt");
    PrintWriter weightWriter = createWriter(fileName+"/weight.txt");
    PrintWriter biaseWriter = createWriter(fileName+"/biase.txt");
    //data
    dataWriter.println(layerslength);
    dataWriter.println(inputlength);
    dataWriter.println(outputlength);
    dataWriter.flush();
    dataWriter.close();
    //weight
    for (int i = 0; i < weights.length; i++) {
      for (int j = 0; j < weights[i].getRowDimension(); j++) {
        for (int k = 0; k < weights[i].getColumnDimension(); k++) {
          weightWriter.println(weights[i].getEntry(j, k));
        }
      }
    }
    weightWriter.flush();
    weightWriter.close();
    for (int i = 0; i < biases.length; i++) {
      for (int j = 0; j < biases[i].getRowDimension(); j++) {
        for (int k = 0; k < biases[i].getColumnDimension(); k++) {
          biaseWriter.println(biases[i].getEntry(j, k));
        }
      }
    }
    biaseWriter.flush();
    biaseWriter.close();
  }

  void loadFile(String fileName) {
    // Open the file from the createWriter() example
    String[] data = loadStrings(fileName);
    this.inputlength = Integer.parseInt(data[0]);
    this.outputlength = Integer.parseInt(data[1]);
    this.layerslength = Integer.parseInt(data[2]);


    genlayers();
  } 

  double[] ff(double[] input) {
    if (input.length != inputlength) {
      throw new IllegalArgumentException();
    }

    RealMatrix ff = MatrixUtils.createRealMatrix(arraytocolvec(input));
    for (int i = 0; i < weights.length; i++) {
      ff = ff.multiply(weights[i]);
      ff = ff.add(biases[i]);
      if (i != weights.length-1) {
        sig(ff);
      }
    }
    return(colvectoarray(ff.getData()));
  }

  void sig(RealMatrix matrix) {
    int rows = matrix.getRowDimension();
    int cols = matrix.getColumnDimension();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        matrix.setEntry(i, j, sig(matrix.getEntry(i, j)));
      }
    }
  }

  double sig(double x) {
    return(1/(1+Math.pow(Math.E, x)));
  }

  double[][] arraytocolvec(double[] array) {
    double[][] colvec = new double[1][array.length];
    for (int i = 0; i < colvec[0].length; i++) {
      colvec[0][i] = array[i];
    }
    return(colvec);
  }

  double[] colvectoarray(double[][] colvec) {
    double[] array = new double[colvec[0].length];
    for (int i = 0; i < colvec[0].length; i++) {
      array[i] = colvec[0][i];
    }
    return(array);
  }

  String toString() {
    String str = "layerslength: ";//+layers.length;
    str+=layers.length +"\n" +"layers: ";
    for (int i = 0; i < layers.length; i++) {
      str += layers[i];
    }
    str+='\n'+"weights: ";
    for (int i = 0; i < weights.length; i++) {
      str += weights[i];
    }
    str+="\nbiases: ";
    for (int i = 0; i < biases.length; i++) {
      str += biases[i];
    }
    return str;
  }
}
