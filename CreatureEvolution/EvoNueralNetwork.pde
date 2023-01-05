class EvoNeuralNetwork extends NeuralNetwork {
  EvoNeuralNetwork(int inputlength, int outputlength, int layerslength) {
    super(inputlength, outputlength, layerslength);

  }

  void mutate(float weightMutationAmount, float biaseMutationAmount) {
    mutateWeight(weightMutationAmount);
    mutateBiase(biaseMutationAmount);
  }

  void mutateWeight(float weightMutationAmount) {
    for (int i = 0; i < weights.length; i++) {
      for(int j = 0; j < weights[i].getRowDimension(); j++){
        for(int k = 0; k < weights[i].getColumnDimension(); k++){
          weights[i].addToEntry(j, k, mutateElement(weights[i].getRowDimension(), weightMutationAmount));
        }
      }
    }
  }

  void mutateBiase(float biaseMutationAmount) {
    for (int i = 0; i < biases.length; i++) {
      for(int j = 0; j < biases[i].getRowDimension(); j++){
        for(int k = 0; k < biases[i].getColumnDimension(); k++){
          biases[i].addToEntry(j, k, mutateElement(biaseMutationAmount));
        }
      }
    }
  }
  
  float mutateElement(int row, float weightMutationAmount){
    return(weightMutationAmount*randomGaussian()*pow(row, .5));
  }
  
  float mutateElement(float biaseMutationAmount){
    return(biaseMutationAmount*randomGaussian());
  }
  
  EvoNeuralNetwork(EvoNeuralNetwork nn, float weightMutationAmount, float biaseMutationAmount){
    super(nn);
    mutate(weightMutationAmount, biaseMutationAmount);
  }
  /*
  EvoNeuralNetwork(EvoNeuralNetwork nn){
    super(nn);
    this.biaseMutationAmount = nn.biaseMutationAmount;
    this.weightMutationAmount = nn.weightMutationAmount;
  }
  */
}
