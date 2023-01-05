import shiffman.box2d.*; //<>// //<>// //<>// //<>// //<>// //<>//
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.apache.commons.math3.linear.*;
import java.util.Arrays;
import java.util.Comparator;
//v.1
Box2DProcessing box2d;
Floor f;
//GenesGenerator gg;
//Creature c1;
//Creature c2;
//Graph g;
CreatureEvolver ce;
void setup() {
  size(1000, 1000);
  //randomSeed(7);
  Manager m = new Manager();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  f = new Floor(610, 1000, 100);
  ce = new CreatureEvolver(20, 200, 5, 10);
  /*
  c1 = m.createRandomCreature(5);
  c2 = m.cloneCreature(c1);
  */
  noLoop();
}

void mouseClicked() {
  loop();
}

void draw() {
  background(255);
  
  //c1.step();
  //c2.step();
  //box2d.step();
  //c1.display();
  //c2.display();
  ce.runSim(); 
  f.disp();
}
