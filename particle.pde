  float k = 0.05;
  float friction = 0.97;
class particle{
  PVector location;
  PVector velocity;
  int type;
  float hue;
  int size = 9;
  int mass = 1;
  float local_density = 0;
  
  particle(){
    location = new PVector(random(worldDimensions.x),
    random(worldDimensions.y),
    random(worldDimensions.z));
    velocity = new PVector(0,0,0);
    type = int (random(numTypes));
    hue = (360/numTypes)*type;
    
  }
  
  void applyforces(){
    PVector force = new PVector(0,0,0);
    PVector attract = new PVector(0,0,0);
    PVector repulse = new PVector(0,0,0);
    float dist;
    for(particle p : swarm){
      if(this != p){
        attract.set(p.location);
        attract.sub(location);
        
        repulse.set(attract);
        dist = attract.mag();
        if(p.type == type){
          local_density = 1.0f;
        }
        else{
          local_density += -(1.0f + dist/minDist)*0.01f;
        }
        if (attract.mag() > 0){
          float density_factor = 1.0f - min(max(0.0f, local_density - minDist), 2.0f);
          attract.mult(density_factor);
        }
        if(dist < distances[p.type][type]){
          attract.normalize();
          attract.mult(strengths[p.type][type]*k*map(dist,0,distances[p.type][type],1,0));
          force.add(attract);
        }
        if(dist < minDist){
          repulse.normalize();
          repulse.mult(repulseStrength*k*map(dist,0,minDist,1,0));
          force.add(repulse);
            
        }
      }
    }
    PVector acceleration = force.copy();
    acceleration.div(mass);
    velocity.add(acceleration);
  }
  
  void updateLocations(){
    location.add(velocity);
    location.x = (location.x + worldDimensions.x)%worldDimensions.x;
    location.y = (location.y + worldDimensions.y)%worldDimensions.y;
    location.z = (location.z + worldDimensions.z)%worldDimensions.z;
    //location.x = constrain(location.x, 0, worldDimensions.x);
    //location.y = constrain(location.y, 0, worldDimensions.y);
    //location.z = constrain(location.z, 0, worldDimensions.z);
    velocity.mult(friction);
  } 
  
  void display(){
    pushMatrix();
    translate(location.x-750,location.y-750,location.z-750);
    //fill(255,0,255);
    //text(local_density,(location.x-750)/100,(location.y-750)/100,(location.z-750)/100);
    //textMode(MODEL);
    fill(hue,255,255);
    sphere(size-3);
    fill(hue,100,100,50);
    sphere(size+3);
    popMatrix();
    
  }
}
