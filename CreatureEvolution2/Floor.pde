class Floor{
  float den = 1;
  float fric = 0.5;
  float rest = 0.1;
  
  float floory;
  float y;
  float w;
  float h;
  
  int markOffSet;
  Body body;
  
  Floor(float floory, float w, int markOffSet){
    this.floory = floory;
    this.w = w;
    this.markOffSet = markOffSet;
    generateFloor();
  }
  
  void generateFloor(){
    y = (height - floory)/2+floory;
    h = (height - floory)/2;
    BodyDef bodydef= new BodyDef();
    bodydef.type = BodyType.STATIC;
    bodydef.position = box2d.coordPixelsToWorld(0, y);

    PolygonShape box = new PolygonShape();
    box.setAsBox(box2d.scalarPixelsToWorld(w), box2d.scalarPixelsToWorld(h));
    
    FixtureDef fixturedef = new FixtureDef();
    fixturedef.shape = box;
    fixturedef.density = den;//!0
    fixturedef.friction = fric;//0-1
    fixturedef.restitution = rest;//0-1
    
    body = box2d.world.createBody(bodydef);
    body.createFixture(fixturedef);
  }
  
  void disp(){
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(0,y,2*w,2*h);
    fill(255,0,0);
    for(int i = 0; i < 2*w/markOffSet; i++){
      text(round(i*markOffSet-w), i*markOffSet-w, floory+10);
    }
  }
}
