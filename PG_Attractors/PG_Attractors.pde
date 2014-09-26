/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/103735*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */

//==========================================================
// sketch:  PG_Attractors.pde
// version: v1.0  2013-07-17   initial release
//          v1.1  2013-11-21   viewing changed and some improvements
// tags:    3D, attractor, iterator, array, vector, curve, Lorenz, Rössler
//----------------------------------------------------------
// key commands:
//  0 .. 9 select 
//  + / -  zoom
//  d / f  distance
//  q / w  thickness
//    a    axis on/off
//    c    curve on/off
//    r    reset
//    s    save picture
// <blanc> select next
//  <back> select previous 
//==========================================================

import java.util.Iterator;                   
import java.util.LinkedList;

Attractor attractor;
boolean showAxis = false;
boolean showCurve = true;
float thickness = 2.0;

public void setup() 
{
  size(1024, 1024, P3D);
  println (">>> PG_Attractors v1.1 <<<");
  frameRate(30);
  stroke(color(0, 0, 0, 33));
//  strokeCap(ROUND);
  smooth();
  attractor = new Attractor(startAttractor);
  attractor.createCurve();
}

public void draw() 
{
  background(255);
  pushMatrix();
    translate (width / 2.0, height / 2.0);
    rotateX(mouseY * 2*PI / height);
    rotateY(mouseX * 2*PI / width);
    pushMatrix();
      strokeWeight(thickness);
      attractor.advanceCurve();
//      if (showCurve)
        attractor.drawCurve();
//      else attractor.drawPoints();
    popMatrix();
    if (showAxis) drawAxis();
  popMatrix();
  textMode(SCREEN);   // v1.5.1
  fill(0);
  text (attractor.name, 10,25);
  text ("zDist="+zDist, 10,45);
  text ("scale="+nf(scf,0,2), 10,65);
}

void drawAxis()
{
  noLights();
  strokeWeight(2);
  axis ('x', color(255, 0, 0), new PVector(200, 0.0, 0.0));
  axis ('y', color(0, 255, 0), new PVector(0.0, 200, 0.0));
  axis ('z', color(0, 0, 255), new PVector(0.0, 0.0, 200));
  noStroke();
}

void axis (char axisName, color axisColor, PVector dir)
{
  stroke(axisColor);
  line (0, 0, 0, dir.x, dir.y, dir.z);
  stroke(lerpColor(axisColor, 0, 0.5));
  line (0, 0, 0, -dir.x, -dir.y, -dir.z);
  fill(axisColor);
  text (axisName, dir.x, dir.y, dir.z);
}

void keyPressed ()
{
  if ((key >= '0') && (key <= '9')) attractor.selectFunction(key-48);
  else if (keyCode==8) attractor.selectPrevious();
  else if (key == ' ') attractor.selectNext();
  else if (key == 'a') showAxis = !showAxis;             // axis on/off
//  else if (key == 'c') showCurve = !showCurve;
  else if (key == 'l') attractor.writeAttractorList();
  else if (key == 'r') attractor.sFunc.initParameters();
  else if (key == 's') attractor.savePicture();
  else if (key == 'q') thickness *= 0.98;
  else if (key == 'w') thickness *= 1.02;
  else if (key == 'f') zDist -= 1.0;
  else if (key == 'd') zDist += 1.0;
  else if (key == '-') scf *= 0.99;
  else if (key == '+') scf *= 1.01;
}

void mousePressed ()
{
  attractor.selectNext();
}

