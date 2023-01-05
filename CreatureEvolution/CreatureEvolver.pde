class CreatureEvolver {  //<>//

  int c;
  int framesPerRound;
  int nodes;
  int hold;
  int cycle = 0;
  int cycleFrame;
  int tareFrame = 20;
  Creature[] creatures;
  Manager m;
  Comparator withDist = new Comparator<Creature>() {
    public int compare(Creature c1, Creature c2) {
      return Float.compare(c1.distance, c2.distance);
    }
  };

  CreatureEvolver(int c, int framesPerRound, int nodes, int hold) {
    this.c = c;
    this.framesPerRound = framesPerRound;
    this.nodes = nodes;
    this.hold = hold;
    this.m = new Manager();
    generateCreatures();
  }

  void generateCreatures() {
    creatures = new Creature[c];
    for (int i =0; i < c; i++) {
      creatures[i] = m.createRandomCreature(nodes);
    }
  }

  void runSim() {
      if(frameCount % framesPerRound == 0){
        cycleFrame = frameCount;
        regenerateCreatures();
      }
      cycle(cycleFrame);
  }
  
  void cycle(int cycleFrame){
    int relativeFrame = cycleFrame - frameCount;
    if(relativeFrame == tareFrame){
      tare();
    }
    stepCreatures();
    
  }
  
  void tare(){
    for (int i =0; i < c; i++) {
      creatures[i].tareDistance();
    }
  }

  void stepCreatures() {
    for (int i = 0; i < c; i++) {
      creatures[i].step();
      box2d.step();
      creatures[i].display();
    }
  }

  void regenerateCreatures() {
    Arrays.sort(creatures, withDist);
    int drop = creatures.length - hold;
    int canfill = drop;
    int indexfill = 0;
    float distanceSum = 0;
    
    for (int i = c-hold; i < c; i++) {
      distanceSum+=creatures[i].distance;
    }

    for (int i = c-hold; i < c; i++) {
      int fill = ceil(drop*(creatures[i].distance/distanceSum));
      for (int j = 0; j < fill; j++) {
        if (canfill <= 0 ) {
          break;
        }
        creatures[indexfill] = m.cloneCreature(creatures[i]);
        indexfill++;
        canfill--;
      }
    }

    for (int i = c-hold; i < c; i++) {
      creatures[i] = m.cloneCreature(creatures[i]);
      //println("--------------------");
    }

    creatures[0] = m.cloneCreature(creatures[0]);
  }
}
