PImage frame1;
PImage frame2;
int frame1INT[][] ;
int frame2INT[][] ;
int flow[][][]    ;

void setup(){
    frame1 = loadImage("yos9BMP.bmp");
    frame2 = loadImage("yos10BMP.bmp");
    frame1.filter(GRAY);
    frame1.loadPixels();
    frame2.filter(GRAY);
    frame2.loadPixels();
    frame1INT = new int[frame1.height][frame1.width];
    frame2INT = new int[frame2.height][frame2.width];
    for(int i = 0; i < frame1.height; ++i){
         for(int j = 0; j < frame1.width; ++j){
             int loc = i*frame1.width+ j;
             int c = frame1.pixels[loc]; 
             int r = (c&0x00FF0000)>>16;
             int g = (c&0x0000FF00)>>16;
             int b = (c&0x00FF00FF)>>16;
             frame1INT[i][j] = r+g+b/3;
             c = frame2.pixels[loc]; 
             r = (c&0x00FF0000)>>16;
             g = (c&0x0000FF00)>>16;
             b = (c&0x00FF00FF)>>16;
             frame2INT[i][j] = r+g+b/3;
         }
    }
    int t = millis();
    print("\tCOMECANDO PROCESSAMENTO \n" );
    OpticalFlow estimador = new OpticalFlow(1,5);
    flow = estimador.estimarFluxo(frame1INT,frame2INT);
    print("\tTERMINANDO PROCESSAMENTO" + (millis() -t));        
    
}