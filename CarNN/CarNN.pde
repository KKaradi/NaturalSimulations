  float maxdist;
int len = 21;
float[] wid = new float[len];
PVector[] node = new PVector[len];
float s = 3;
boolean[] inputs = new boolean[4];
int num = 300;
ArrayList<Car> carlist = new ArrayList<Car>(num);
ArrayList<NN> nnlist = new ArrayList<NN>();
Track track = new Track(node, len, wid);
int resetInterval = 10000;
PVector startPos; 
int gen = 0;
int time = 0;

ArrayList<Float> maxDists = new ArrayList<Float>();
ArrayList<Float> aveDists = new ArrayList<Float>();

//RESET VARS
int survNum = 25;
boolean disp = true;
boolean b = false;

//END RESET VARS
void setup() {


  frameRate(1000);

  //size(1000, 1000);
  fullScreen(P2D);
  /*
  for (int i=0; i<10; i++) {
   node[i] = new PVector(random(400), random(400));
   }
   */

  //node = new PVector[]{new PVector(100, 100), new PVector(200, 200), new PVector(100, 100), new PVector(100, 100)};







  node[0]= new PVector(220.0,208.0);  node[1]= new PVector(653.0,121.0);  node[2]= new PVector(1161.0,132.0);  node[3]= new PVector(1544.0,221.0);  node[4]= new PVector(1695.0,389.0);  node[5]= new PVector(1760.0,549.0);  node[6]= new PVector(1640.0,675.0);  node[7]= new PVector(1342.0,643.0);  node[8]= new PVector(1101.0,507.0);  node[9]= new PVector(825.0,455.0);  node[10]= new PVector(736.0,586.0);  node[11]= new PVector(870.0,780.0);  node[12]= new PVector(1260.0,824.0);  node[13]= new PVector(1483.0,910.0);  node[14]= new PVector(1456.0,1020.0);  node[15]= new PVector(1116.0,1028.0);  node[16]= new PVector(725.0,1021.0);  node[17]= new PVector(377.0,981.0);  node[18]= new PVector(227.0,838.0);  node[19]= new PVector(161.0,617.0);  node[20]= new PVector(160.0,457.0);

  //node[0]= new PVector(100.0,62.0);  node[1]= new PVector(1761.0,74.0);  node[2]= new PVector(1776.0,999.0);

  //node[0]= new PVector(318.0,258.0);  node[1]= new PVector(361.0,200.0);  node[2]= new PVector(455.0,160.0);  node[3]= new PVector(542.0,179.0);  node[4]= new PVector(588.0,231.0);  node[5]= new PVector(605.0,316.0);  node[6]= new PVector(660.0,316.0);  node[7]= new PVector(753.0,313.0);  node[8]= new PVector(858.0,312.0);  node[9]= new PVector(967.0,305.0);  node[10]= new PVector(1073.0,303.0);  node[11]= new PVector(1170.0,297.0);  node[12]= new PVector(1239.0,302.0);  node[13]= new PVector(1279.0,356.0);  node[14]= new PVector(1253.0,433.0);  node[15]= new PVector(1154.0,452.0);  node[16]= new PVector(1040.0,450.0);  node[17]= new PVector(954.0,462.0);  node[18]= new PVector(808.0,471.0);  node[19]= new PVector(635.0,449.0);  node[20]= new PVector(568.0,463.0);  node[21]= new PVector(572.0,537.0);  node[22]= new PVector(520.0,587.0);  node[23]= new PVector(410.0,597.0);  node[24]= new PVector(328.0,565.0);  node[25]= new PVector(274.0,492.0);  node[26]= new PVector(291.0,381.0);  node[27]= new PVector(296.0,324.0);
  //node[0]= new PVector(1038.0+10,234+50);  node[1]= new PVector(1136.0,281.0);  node[2]= new PVector(1028.0,386.0);  node[3]= new PVector(1264.0,521.0);  node[4]= new PVector(984.0,568.0);  node[5]= new PVector(921.0,739.0);  node[6]= new PVector(1145.0,824.0);  node[7]= new PVector(1009.0,925.0);  node[8]= new PVector(610.0,952.0);  node[9]= new PVector(550.0,749.0);  node[10]= new PVector(723.0,710.0);  node[11]= new PVector(496.0,571.0);  node[12]= new PVector(291.0,686.0);  node[13]= new PVector(193.0,536.0);  node[14]= new PVector(294.0,411.0);  node[15]= new PVector(128.0,342.0);  node[16]= new PVector(152.0,149.0);  node[17]= new PVector(314.0,86.0);  node[18]= new PVector(370.0,217.0);  node[19]= new PVector(574.0,325.0);  node[20]= new PVector(597.0,141.0);  node[21]= new PVector(789.0,298.0);  node[22]= new PVector(864.0,154.0);

  //node[0]= new PVector(1119.0,148.0);  node[1]= new PVector(1288.0,148.0);  node[2]= new PVector(1192.0,281.0);  node[3]= new PVector(1085.0,299.0);  node[4]= new PVector(946.0,306.0);  node[5]= new PVector(991.0,404.0);  node[6]= new PVector(1130.0,402.0);  node[7]= new PVector(1256.0,523.0);  node[8]= new PVector(1109.0,617.0);  node[9]= new PVector(968.0,670.0);  node[10]= new PVector(896.0,585.0);  node[11]= new PVector(932.0,458.0);  node[12]= new PVector(795.0,458.0);  node[13]= new PVector(626.0,462.0);  node[14]= new PVector(626.0,462.0);  node[15]= new PVector(467.0,428.0);  node[16]= new PVector(321.0,431.0);  node[17]= new PVector(197.0,427.0);  node[18]= new PVector(148.0,386.0);  node[19]= new PVector(147.0,349.0);  node[20]= new PVector(156.0,328.0);  node[21]= new PVector(192.0,310.0);  node[22]= new PVector(336.0,297.0);  node[23]= new PVector(467.0,289.0);  node[24]= new PVector(669.0,311.0);  node[25]= new PVector(768.0,317.0);  node[26]= new PVector(901.0,317.0);  node[27]= new PVector(869.0,259.0);  node[28]= new PVector(842.0,129.0);  node[29]= new PVector(947.0,16.0);  node[30]= new PVector(1076.0,56.0);


//node[0]= new PVector(91.0,237.0);  node[1]= new PVector(163.0,143.0);  node[2]= new PVector(291.0,95.0);  node[3]= new PVector(436.0,132.0);  node[4]= new PVector(526.0,236.0);  node[5]= new PVector(470.0,373.0);  node[6]= new PVector(339.0,489.0);  node[7]= new PVector(303.0,664.0);  node[8]= new PVector(446.0,800.0);  node[9]= new PVector(644.0,764.0);  node[10]= new PVector(736.0,628.0);  node[11]= new PVector(739.0,517.0);  node[12]= new PVector(694.0,395.0);  node[13]= new PVector(758.0,204.0);  node[14]= new PVector(934.0,113.0);  node[15]= new PVector(1138.0,74.0);  node[16]= new PVector(1330.0,99.0);  node[17]= new PVector(1556.0,80.0);  node[18]= new PVector(1699.0,106.0);  node[19]= new PVector(1810.0,249.0);  node[20]= new PVector(1656.0,382.0);  node[21]= new PVector(1306.0,346.0);  node[22]= new PVector(1072.0,317.0);  node[23]= new PVector(957.0,456.0);  node[24]= new PVector(1030.0,584.0);  node[25]= new PVector(1175.0,689.0);  node[26]= new PVector(1355.0,674.0);  node[27]= new PVector(1495.0,567.0);  node[28]= new PVector(1691.0,622.0);  node[29]= new PVector(1702.0,780.0);  node[30]= new PVector(1634.0,909.0);  node[31]= new PVector(1288.0,990.0);  node[32]= new PVector(966.0,1002.0);  node[33]= new PVector(640.0,1013.0);  node[34]= new PVector(380.0,1015.0);  node[35]= new PVector(132.0,1010.0);  node[36]= new PVector(132.0,808.0);  node[37]= new PVector(118.0,496.0);

 //node[0]= new PVector(102.0,92.0);  node[1]= new PVector(208.0,323.0);  node[2]= new PVector(317.0,93.0);  node[3]= new PVector(434.0,316.0);  node[4]= new PVector(545.0,91.0);  node[5]= new PVector(626.0,291.0);  node[6]= new PVector(720.0,86.0);  node[7]= new PVector(825.0,279.0);  node[8]= new PVector(953.0,84.0);  node[9]= new PVector(1045.0,288.0);  node[10]= new PVector(1148.0,92.0);  node[11]= new PVector(1253.0,259.0);  node[12]= new PVector(1352.0,89.0);  node[13]= new PVector(1460.0,258.0);  node[14]= new PVector(1569.0,93.0);  node[15]= new PVector(1666.0,241.0);  node[16]= new PVector(1821.0,101.0);  node[17]= new PVector(1836.0,1039.0);  node[18]= new PVector(1726.0,865.0);  node[19]= new PVector(1613.0,1025.0);  node[20]= new PVector(1525.0,860.0);  node[21]= new PVector(1381.0,1034.0);  node[22]= new PVector(1277.0,859.0);  node[23]= new PVector(1128.0,1039.0);  node[24]= new PVector(1047.0,841.0);  node[25]= new PVector(920.0,1024.0);  node[26]= new PVector(819.0,831.0);  node[27]= new PVector(685.0,1002.0);  node[28]= new PVector(604.0,826.0);  node[29]= new PVector(490.0,1001.0);  node[30]= new PVector(387.0,830.0);  node[31]= new PVector(220.0,996.0);  node[32]= new PVector(120.0,832.0);  node[33]= new PVector(221.0,638.0);  node[34]= new PVector(1569.0,638.0);  node[35]= new PVector(1563.0,445.0);  node[36]= new PVector(214.0,461.0);  node[37]= new PVector(55.0,347.0);
startPos = node[0];
  //node[4] = new PVector(150,150);
  for (int i = 0; i<len; i++) {
    //node[i] = new PVector(random(width), random(height));
    wid[i]= 100;
  }
  //wid[4] = 40;
  track.setWall();

  for (int i = 0; i < num; i++) {
    nnlist.add(new NN());
    carlist.add(new Car(startPos, track, nnlist.get(i)));
  }
  maxDists.add(0, 0.0);
  aveDists.add(0,0.0);
}
/*
NN net = new NN();
 
 Car car = new Car(new PVector(100, 100), track, net);
 */
Graph graph = new Graph(maxDists, aveDists);
void draw() {

  background(255);

  for (int i = 0; i < num; i++) {
    if (!carlist.get(i).hit) {


      carlist.get(i).setC();
      carlist.get(i).minKill();

      carlist.get(i).intbodytrack();
      carlist.get(i).rayconnect();

      //car.targetch();


      carlist.get(i).prop();
      carlist.get(i).setHead(/*inputs*/);

      carlist.get(i).move(); 
      carlist.get(i).setVArray();
      carlist.get(i).setDist();
    }
  }
  int k = 0;

  if (b) {
    float[][] distZ = new float[carlist.size()][2];

    returnDists(distZ, true); 
    sortDists(distZ);
    k = int(distZ[0][1]);
  }


  for (int i = 0; i < num; i++) {
    //-----------------------
    boolean top = false;
    if (b) {
      if (i == k) {
        top = true;
      }
    }

    //------------------------
    if (!carlist.get(i).hit) {
      carlist.get(i).display(disp, top);


      carlist.get(i).prepos();
    }
  }


  //println(carlist.get(0).dist+" "+carlist.get(0).hit+" "+carlist.get(0).p);

  if (disp) {
    textSize(25);
    fill(255, 0, 0);
    text("Generation:"+gen+"   Time:"+time, 0, 25);

    track.display();
  }


  allhit();
  if (time == resetInterval) {
    reset();
  } else {
    time+=1;
  }
  if (gen != 0) {
    graph.setMax();
    graph.setProp();
    if (!disp) {
      graph.display();
    }
  }
}

void allhit() {
  boolean startReset = true;
  for (int i = 0; i<carlist.size(); i ++) {
    if (!carlist.get(i).hit) {
      startReset = false;
    }
  }
  if (startReset) {
    reset();
  }
}
void reset() {

  //resetInterval+=40;
  gen+=1;
  float[][] dists = new float[carlist.size()][2];
  float[][] survDists = new float[survNum][2];
  int[] death = new int[num-survNum];
  int[][] newNN = new int[survNum][2];
  returnDists(dists, false); 
  sortDists(dists);
  //p2D(dists);
  //println(dists[0][0]);
  aveDists.add(ave(dists));
  maxDists.add(dists[0][0]);
  setSurvDists(dists, survDists, death);
  setNewNN(survDists, newNN);
  newNNadd(newNN);
  setRemove(death);   
  removeNN();
  resetCars();
  time = 0;

  graph.setMax();
  graph.setProp();
}

void setRemove(int[] death) {
  for (int i = 0; i<death.length; i++) {
    nnlist.get(death[i]).remove = true;
  }
}

void newNNadd(int[][] newNN) {
  for (int i = 0; i<newNN.length; i++) {
    for (int j = 0; j<newNN[i][0]; j++) {
      nnlist.add(new NN(nnlist.get(newNN[i][1])));
    }
  }
}

void removeNN() {
  for (int i = nnlist.size()-1; i>=0; i--) {
    if (nnlist.get(i).remove) {
      nnlist.remove(i);
    }
  }
}

void resetCars() {
  for (int i = (carlist.size()-1); i>=0; i--) {
    carlist.remove(i);
  }
  for (int i = 0; i<num; i++) {

    carlist.add(new Car(startPos, track, nnlist.get(i)));
  }
}


void setNewNN(float[][] survDist, int[][] newNN) {
  int fill = num-survNum;
  float total = 0;
  for (int i = 0; i<survDist.length; i++) {
    total+=survDist[i][0];
    survDist[i][0]*=fill;
    newNN[i][1] = int(survDist[i][1]);
  }

  float remain = 0;
  for (int i = (survDist.length-1); i>0; i--) {
    boolean floor = false;
    int goal;

    survDist[i][0] += remain;
    if (round(survDist[i][0]/total) == int(survDist[i][0]/total)) {
      floor = true;
    }

    if (floor) {
      goal = int(survDist[i][0]/total);
    } else {
      goal = int(survDist[i][0]/total) + 1;
    }
    newNN[i][0] = goal;
    remain = survDist[i][0] - goal*total;
  }

  int sumup = 0;
  for (int i = (survDist.length-1); i>0; i--) {
    sumup+=newNN[i][0];
  }

  newNN[0][0] = (fill-sumup);
}

void sortDists(float[][] dists) {
  boolean change = true;
  while (change) {
    change = false;
    for (int i = 0; i<(dists.length-1); i++) {
      if (dists[i][0]<dists[i+1][0]) {
        float[] save = dists[i];
        dists[i] = dists[i+1];
        dists[i+1] = save;
        change = true;
      }
    }
  }
}


void setSurvDists(float[][] dists, float[][] survDists, int[] death) {
  for (int i = 0; i<survNum; i++) {
    survDists[i] = dists[i];
  }

  for (int i = survNum; i<num; i++) {
    int j = i-survNum;
    death[j] = int(dists[i][1]);
  }
}

void returnDists(float[][] dists, boolean kill0) {
  for (int i = 0; i<carlist.size(); i++) {


    dists[i][0] = carlist.get(i).dist;
    if (kill0) {
      if (carlist.get(i).hit) {
        dists[i][0] = 0;
      }
    }

    dists[i][1] = i;
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

void p2D(int  [][] data) {
  for (int i = 0; i < data.length; i ++) {
    for (int j = 0; j < data[0].length; j++) {
      print(data[i][j]+"   ");
    }
    println();
  }
}

float ave(float[][] dists){
  float tot = 0;
  for(int i = 0; i<dists.length; i++){
    tot += dists[i][0];
  }
  tot /= dists.length;
  return(tot);
    
  
}

void keyPressed() {
  if (key == 'a') {
    disp = !disp;
  }
  if (key == 'b') {
    b = !b;
  }
  //setMove(keyCode, true);
};
/*
void keyReleased() {
 setMove(keyCode, false);
 };
 
 boolean setMove(int k, boolean b) {
 switch (k) {
 case +' ':
 return inputs[0] = b;
 
 case +'A':
 return inputs[1] = b;
 
 case +'D':
 return inputs[2] = b;
 
 case +'S':
 return inputs[3] = b;
 default:
 return b;
 }
 };
 */
