float[] detail = new float[1000];

void setup(){
  size(1000,1000);
  frameRate(60);
}

void draw(){
  for(int j = 0; j < 100; j++){
    detail[round(20*randomGaussian())+500]++;
    for(int i = 0; i < detail.length; i++){
      rect(i, 750-(detail[i]/frameCount*100), 1, (detail[i]/frameCount*100));
    }
  }
}
