
cameraInput camera;

void setup(){
    size(1280,480);
    camera = new cameraInput(this);
}

void draw(){
    camera.calculaFluxo();
    camera.displayFluxo();
}