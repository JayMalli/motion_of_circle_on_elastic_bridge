import toxi.physics2d.constraints.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.*;

import toxi.geom.*;

import java.util.List;

//Number of particles for string
int string_res=100;

//Number of particles for ball
int ball_res=60;
//Ball radius
int ball_radius=80;

// squared snap distance for mouse selection
float snap_dist=20*20;

VerletPhysics2D physics;
VerletParticle2D selectedparticles;

void setup()
{
  size(1024,720,P3D);
  initPhysics();
}

void draw()
{
   // 1st update
  physics.update();
  // then drawing
  background(224);
  // draw all springs
  stroke(255,0,255);
  for(VerletSpring2D s : physics.springs)
  {
    line(s.a.x,s.a.y,s.b.x,s.b.y);
  }
   // show all particles
   fill(0);
   noStroke();
  for(VerletParticle2D p : physics.particles)
  {
    ellipse(p.x,p.y,5,5);
  }
   // highlight selected particle (if there is one currently)
   if(selectedparticles!=null)
   {
     fill(255,0,255);
     ellipse(selectedparticles.x,selectedparticles.y,20,20);
   }
     
}


void mousePressed()
{
   // find particle under mouse
   Vec2D mousepos=new Vec2D(mouseX,mouseY);
   for(int i=1;i<physics.particles.size()-1;i++)
   {
     VerletParticle2D p=physics.particles.get(i);
     // using distanceToSquared() is faster than distanceTo()
     if(mousepos.distanceToSquared(p)<snap_dist)
     {
        // lock it and store for further reference
        selectedparticles=p.lock();
        // force quit the loop
      break;
 
     }
     
   }
  
} 

void mouseDragged()
{
  if(selectedparticles!=null)
  {
    selectedparticles.set(mouseX,mouseY);
  }
}

void mouseReleased()
{
   // unlock the selected particle
  if(selectedparticles!=null)
  {
    selectedparticles.unlock();
    selectedparticles=null;
  }
}

void keyPressed()
{
  //Reset the sketch
  if(key=='r')
  {
    initPhysics();
  }
}
