PImage frame1;
PImage frame2;
PImage setaUp;
PImage setaDown;
PImage setaLeft;
PImage setaRight;


cameraInput camera;

void setup(){
    size(1280,480);
    camera = new cameraInput(this);
}


void draw(){
    camera.calculaFluxo();
    camera.displayFluxo();
}