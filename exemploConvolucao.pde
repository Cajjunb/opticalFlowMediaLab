PImage frame1;
PImage frame2;
int frame1INT[][] ;
int frame2INT[][] ;
float fluxo[][][]    ;

void setup(){
    size(632,252);
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
    fluxo = estimador.estimarFluxo(frame1INT,frame2INT);
    print("\tTERMINANDO PROCESSAMENTO" + (millis() -t));        
    //PRINTANDO A REPRESENTACAO
    image(frame2,0,0);
    image(frame1,316,0);
     for(int i = 0; i < frame2.height; i+=4){
         for(int j = 0; j < frame2.width; j+=4){
             int numeroMedia = 0;
             int valorU      = 0;
             int valorV      = 0;
             //Calculando a media em geral perto
             if(i - 1 > 0){
                 ++numeroMedia;
                 valorU += fluxo[i-1][j][0];
                 valorV += fluxo[i-1][j][1];
             }
             if(i + 1 < frame2.width){
                 ++numeroMedia;
                 valorU += fluxo[i+1][j][0];
                 valorV += fluxo[i+1][j][1];
             }
             if(j - 1 > 0){
                 ++numeroMedia;
                 valorU += fluxo[i][j-1][0];
                 valorV += fluxo[i][j-1][1];
             }
             if(j + 1 < frame2.height){
                 ++numeroMedia;
                 valorU += fluxo[i][j+1][0];
                 valorV += fluxo[i][j+1][1];
             }
             //CALCULANDO MEDIA
             valorU /= numeroMedia;
             valorV /= numeroMedia;
             if(valorV >= 0){
                 print("CiMa\t");
             }else{
                 print("Baixo\t");
             }
         }
     }
}