PImage frame1;
PImage frame2;

void setup(){
    frame1 = loadImage("yos9.tif");
    frame2 = loadImage("yos10.tif");
    frame1.filter(GRAY);
    frame1.loadPixels();
    frame2.filter(GRAY);
    frame2.loadPixels();
    
     for(int i = 0; i < frame1.height; ++i)
         for(int j = 0; j < frame1.width; ++j){
             
         }
}