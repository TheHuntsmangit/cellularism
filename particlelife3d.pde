int numTypes = 10;
float[][] strengths;
float[][] distances;
float minDist = 10;
float repulseStrength = -5.0;
int numParticles = 1500;
ArrayList<particle> swarm;
PVector worldDimensions;
PVector camera;
float lookRoty;
void setup(){
  surface.setResizable(true);
  size(1000,1000,P3D);
  worldDimensions = new PVector(1500,1500,1500);
  camera = new PVector(worldDimensions.x/2,worldDimensions.y/2,1500);
  colorMode(HSB,360,100,100);
  sphereDetail(6);//amound of polys in the sphere, keep low if you want frames 
  strengths = new float[numTypes][numTypes];
  distances = new float[numTypes][numTypes];
  setValues();
  swarm = new ArrayList<particle>();
  for(int i = 0; i < numParticles; i++){
    swarm.add(new particle());
  }
  noStroke();
}
void draw(){
  background(0);
  
  directionalLight(51, 102, 200,0.2,1,0.5);
  ambientLight(0,0,80);
  
  camera(camera.x,camera.y,camera.z,camera.x,camera.y,camera.z-200,0,1,0);
  rotateY(lookRoty);
  pushMatrix();
  noFill();
  stroke(255);
  strokeWeight(10);
  box(1500,1500,1500);
  noStroke();
  popMatrix();
  keypress();
  for(particle p: swarm){
    p.display();
    
  }
  for(particle p: swarm){
    p.applyforces();
  }
  for(particle p: swarm){
    p.updateLocations();
  }
    
}
void setValues(){
  for(int i = 0; i < numTypes;i++){
    for(int j = 0; j < numTypes; j++){
      strengths[i][j] = random(-1.0,1.0);
      distances[i][j] = random(20,150);
    }
  }
}
void mouseWheel(MouseEvent event){
  float e = event.getCount();
  camera.z += 20*e;
}
void keypress(){
  //movement
  if(!keyPressed){
    return;
  }
  if(key == 'w'||key == 'W'){
    camera.y -= 5;
  }
  if(key == 's'){
    camera.y += 5;
  }
  if(key == 'a'){
    camera.x -= 5;
  }
  if(key == 'd'){
    camera.x += 5;
  }
  //looking around
  if(key == '['){
    lookRoty += 0.01;
  }
  if(key == ']'){
    lookRoty -= 0.01;
  }
}
