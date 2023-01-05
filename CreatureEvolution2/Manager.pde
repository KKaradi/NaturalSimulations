import java.util.Arrays.*;

class Manager{
  float changemin = 1, changemax = 3;
  float periodmin = 20, periodmax = 40;
  float minMidPoint = 5, maxMidPoint = 10;
  int nnLength = 4;
  
  float changeMrate = .1;
  float periodMrate = 5;
  float midPointMrate = .5;
  float differenceMrate = .5;
  float weightMrate = .1;
  float biaseMrate = .1;
  Manager(){
  }
  
  Creature cloneCreature(Creature c){
    return(new Creature(c.change, c.period, c.template, c.lengths.clone(), new EvoNeuralNetwork(c.nn,0,0)));
  }
  
  Creature mutateCreature(Creature c){
    return(new Creature(limit(c.change+changeMrate*randomGaussian(),changemin, changemax), limit(c.period+periodMrate*randomGaussian(), periodmin, periodmax), c.template, mutateLengths(c.lengths), new EvoNeuralNetwork(c.nn,weightMrate, biaseMrate)));
  }
  
  Creature createRandomCreature(int nodesc){
    float change = random(changemin, changemax);
    float period = random(periodmin, periodmax);
    boolean[][] template = createTemplate(nodesc);
    int musclesc = musclesc(template);
    EvoNeuralNetwork nn = new EvoNeuralNetwork(musclesc+1, musclesc ,nnLength);
    //return(new Creature(change, period, template, genLengths(musclesc, maxDifference), nn));
    return(new Creature(change, period, template, genLengths(musclesc), nn));
  }
   
  float[][] genLengths(int muscles){
    float[][] lengths = new float[muscles][2];
    
    for(int i  = 0 ; i < muscles; i++){
      float midPoint = random(minMidPoint, maxMidPoint);
      float difference1 = maxMidPoint-midPoint;
      float difference2 = midPoint-minMidPoint;
      float difference = 2*min(difference1, difference2);
      lengths[i][0] = midPoint;
      lengths[i][1] = difference;
    }
    return(lengths);
  }
  
  float[][] mutateLengths(float[][] givenlengths){
    float[][] lengths = givenlengths.clone();
    for(int i = 0 ; i < lengths.length; i++){
      lengths[i][0] += midPointMrate*randomGaussian();
      lengths[i][0] = limit(lengths[i][0], minMidPoint, maxMidPoint);
      lengths[i][1] += differenceMrate*randomGaussian();
      float difference1 = maxMidPoint-lengths[i][0];
      float difference2 = lengths[i][0]-minMidPoint;
      float difference = 2*min(difference1, difference2);
      lengths[i][1] = limit(lengths[i][1], 0, difference);
    }
    return(lengths);
  }
  
  float limit(float a, float min, float max){
    if(a > max){
      a = max;
    }
    if(a < min){
      a = min;
    }
    return(a);
  }
}
