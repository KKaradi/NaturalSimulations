class Graph {
  
  //int size = 2020;
  ArrayList<Float> maxDists = new ArrayList<Float>(/*20*/);
  
  int gen;
  float max;
  int border = 140;
  int ticks = 10;
  int tickthick = 10;
  int w = 1920-border*2;
  int h = 1080-border*2;
  float propW;
  float propH;
  float lap;
  int lapnum;
  
  Graph(ArrayList<Float> MaxDists, ArrayList<Float> AveDists) {
    maxDists = MaxDists;
    //float lap = Lap;
    /*
    for(int i = 0; i<size; i++){
      maxDists.add(random(255));  
    }
    */
  }

  
  void setMax() {
    
    
    max = maxDists.get(maxDists.size()-1);
    gen = maxDists.size();
    gen-=1;
    //lapnum = floor(max/lap);
    
  }
  
  void setProp(){
    
    propW = float(w)/gen; 
    
    propH = float(h)/max;
  }
  
  void display(){
    
    
    
    
    stroke(0);
    strokeWeight(4);
    line(border,border,border, h+border);
    line(border, h+border, w+border, h+border);
    for(int i = 0; i<ticks; i++){
      float a = h*i/float(ticks) + border;
      line(border-tickthick, a, border+tickthick, a);  
      text(max*(ticks - i)/float(ticks), border-130, h*i/float(ticks)+border+10);
    }
    /*
    for(int i = 0; i<lapnum; i++){
        float a = h*(lap*i)/max + border;
        line(border-tickthick, a, border+tickthick, a);  
    }
    */
    for(int i = ticks; i>0; i--){
      //line(w*i/float(ticks)+2*border, h-tickthick+border, w*i/float(ticks)+2*border,h+tickthick+border);  
      line((w)*i/float(ticks)+border, h+border-tickthick, (w)*i/float(ticks)+border, h+border+tickthick);
      text(gen*i/float(ticks),(w)*i/float(ticks)+border-50, h+border+30);
      
    }
    
    stroke(255,0,0);
    strokeWeight(2);
    for(int i = 0; i<maxDists.size()-1; i++){
      stroke(255,0,0);
      strokeWeight(2);
      
      
      float one = propW*i+border;
      float two = -propH*maxDists.get(i)+h+border;
      float three = propW*(i+1)+border;
      
      float four = -propH*maxDists.get(i+1)+h+border;
      
      float two2 = -propH*aveDists.get(i)+h+border;
      
      float four2 = -propH*aveDists.get(i+1)+h+border;
      line(one, two , three, four);  
      stroke(0,0,255);
      line(one, two2, three, four2);
      
    }
    //textSize(10);
    //text(gen, w+border, h+border);
    //text(max, border, border);
    //ellipse(w+border, border,10,10);
    for(int i = 0; i<maxDists.size(); i++){
      
    }
  }
    
    
}
