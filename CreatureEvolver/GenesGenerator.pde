class GenesGenerator {
  /*
  float maxLen = 10;
  float minLen = 5;
  float pointMutationAmount = .02;
  float propMutationAmount = .02;

  float minMav = 2;
  float maxMav = 2;

  float mavMutationAmount = .02;

  float minw = 2*PI/50;
  float maxw = 2*PI/30;

  float wmutationAmount = .02;

  float weightMutationAmount = .01;
  float biaseMutationAmount = .01;

  float range = maxLen - minLen;
  
  GenesGenerator() {
  }

  Genes generateRandomGenes(Creature c) {
    //Creature c, float mav, float w, float[] lengths
    float mav = random(minMav, maxMav);
    float w = random(minw, maxw);
    float[][] lengths = new float[c.muscles.length][5];
    for (int i = 0; i < c.muscles.length; i++) {
      float point = random(1);
      float proportion = random(1);

      lengths[i][0] = point*range+minLen;
      lengths[i][3] = point;
      lengths[i][4] = proportion;
      lengths[i][1] = lengths[i][4]*lengths[i][3]*range+minLen;
      lengths[i][2] = range-lengths[i][4]*range+lengths[i][4]*range*lengths[i][3]+minLen;
    }    
    //saveGenes(mav, w, weightMutationAmount, biaseMutationAmount, lengths);
    return(new Genes(c, mav, w, lengths, weightMutationAmount, biaseMutationAmount));
  }
  
  Genes generateSave(Creature c, String file){
    float mav = random(minMav, maxMav);
    float w = random(minw, maxw);
    float[][] lengths = new float[c.muscles.length][5];
    for (int i = 0; i < c.muscles.length; i++) {
      float point = random(1);
      float proportion = random(1);

      lengths[i][0] = point*range+minLen;
      lengths[i][3] = point;
      lengths[i][4] = proportion;
      lengths[i][1] = lengths[i][4]*lengths[i][3]*range+minLen;
      lengths[i][2] = range-lengths[i][4]*range+lengths[i][4]*range*lengths[i][3]+minLen;
    }    
    saveGenes(mav, w, weightMutationAmount, biaseMutationAmount, lengths, file);
    return(new Genes(c, mav, w, lengths, weightMutationAmount, biaseMutationAmount));
    
  }
  
  void saveGenes(float m, float w, float a, float b, float[][] l, String file){
    PrintWriter save = createWriter(file+"/args.txt");
    save.println(m);
    save.println(w);
    save.println(a);
    save.println(b);
    save.flush();
    save.close();
    save = createWriter(file+"/lengths.txt");
    for(int i = 0 ; i < l.length; i++){
      for(int j = 0; j < l[0].length; j++){
        save.println(l[i][j]);
      }
    }
    save.flush();
    save.close();
  }

  Genes clone(Creature c, Genes g) {
    float[][] lengths = g.lengths.clone();

    for (int i = 0; i < lengths.length; i++) {
      lengths[i][3] += randomGaussian()*pointMutationAmount;
      lengths[i][4] += randomGaussian()*propMutationAmount;
      lengths[i][3] = limit(lengths[i][3], 0, 1);
      lengths[i][4] = limit(lengths[i][4], 0, .99);
      lengths[i][1] = lengths[i][4]*lengths[i][3]*range+minLen;
      lengths[i][2] = range-lengths[i][4]*range+lengths[i][4]*range*lengths[i][3]+minLen;
    }
    return(new Genes(c, limit(g.mav+randomGaussian()*mavMutationAmount, minMav, maxMav), limit(g.w+randomGaussian()+wmutationAmount, minw, maxw), lengths, g.nn));
  }
  
  Genes copy(Creature c, Genes g) {
    //float[][] lengths = g.lengths.clone();

    return(new Genes(c, g.mav, g.w, g.lengths.clone(), g.nn));
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
  */
}
