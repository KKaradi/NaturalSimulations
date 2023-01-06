class Node {
  float r = 10;
  float den = 1;
  float fric = 1;
  float rest = 0;
  Body body;

  Node(float x, float y, float r, float den, float fric, float rest) {
    this.r = r;
    this.den = den;
    this.fric = fric;
    this.rest = rest;

    generatenodes(x, y);
  }

  Node(float r, float den, float fric, float rest) {
    this.r = r;
    this.den = den;
    this.fric = fric;
    this.rest = rest;

    float x = random(450, 550);
    float y = random(-20, 20);

    generatenodes(x, y);
  }

  Node(float x, float y) {
    generatenodes(x, y);
  }
  
  Node(){
    float x = random(450, 550);
    float y = random(-20, 20);
    
    generatenodes(x, y);
  }

  void generatenodes(float x, float y) {

    BodyDef bodydef= new BodyDef();

    //bodydef.position = box2d.coordPixelsToWorld(random(1),random(1));
    bodydef.type = BodyType.DYNAMIC;
    bodydef.position = box2d.coordPixelsToWorld(x, y);

    CircleShape circleshape = new CircleShape();
    circleshape.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fixturedef = new FixtureDef();
    fixturedef.shape = circleshape;
    fixturedef.density = den;//!0
    fixturedef.friction = fric;//0-1
    fixturedef.restitution = rest;//0-1
    fixturedef.filter.categoryBits = 0x0002;
    //fixturedef.filter.maskBits = 0x0002;
    fixturedef.filter.groupIndex = -2;
    
    body = box2d.world.createBody(bodydef);
    body.createFixture(fixturedef);
  }

  void disp() {
    fill(255);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, r*2, r*2);
    // Let's add a line so we can see the rotation
    //line(0, 0, r, 0);
    popMatrix();
  }
}
