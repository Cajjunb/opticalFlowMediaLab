PImage frame1;
PImage frame2;
PImage setaUp;
PImage setaUpRight;
PImage setaUpLeft;  
PImage setaDown;
PImage setaDownRight;
PImage setaDownLeft; 
PImage setaLeft;
PImage setaRight;
float  fluxoCamera[][][];
float  fluxoDisplay[][][];

final int  linhasDisplay = 10;
final int  colunasDisplay = 10;


cameraInput camera;

void setup(){
    size(1280,480);
    camera = new cameraInput(this);
    setaUp = loadImage("setaUp.png");
    setaDown = loadImage("setaDown.png");
    setaLeft = loadImage("setaLeft.png");
    setaRight = loadImage("setaRight.png");
    setaUpLeft = loadImage("setaUpLeft.png");
    setaUpRight = loadImage("setaUpRight.png");
    setaDownLeft = loadImage("setaDownLeft.png");
    setaDownRight = loadImage("setaDownRight.png");
}


float [][][] conversaoResolucao(float fluxo[][][],int colunas, int  linhas){
    float fluxoDisplay[][][] = new float[linhas][colunas][2];
    for(int i = 0; i < linhas; ++i){
        for(int j = 0; j < colunas; ++j){
            fluxoDisplay[i][j][0] = 0;
            fluxoDisplay[i][j][1] = 0;        
        }
    }
    for(int i = 0; i < fluxo.length; ++i){
        for(int j = 0; j < fluxo[0].length; ++j){
            if(fluxo[i][j][0] != 0  && fluxo[i][j][1] != 0){
                int iAux = round(i*linhas/fluxo.length) ;
                int jAux = round(j*colunas/fluxo[0].length) ;
                //if(fluxoDisplay[iAux][jAux][0] <= fluxo[i][j][0]){
                    fluxoDisplay[iAux][jAux][0] =  fluxo[i][j][0] ;
                //}
                //if(fluxoDisplay[iAux][jAux][1] <= fluxo[i][j][1]){
                    fluxoDisplay[iAux][jAux][1] =  fluxo[i][j][1] ;
                //}
            }
        }
    }
    return fluxoDisplay;
}


void draw(){
    fluxoCamera = camera.calculaFluxo();
    fluxoDisplay = conversaoResolucao(fluxoCamera,colunasDisplay,linhasDisplay);
    for(int i = 0; i < linhasDisplay ; ++i){
        for(int j = 0; j < colunasDisplay; ++j){
            if(fluxoDisplay[i][j][0] != 0 && fluxoDisplay[i][j][1]  != 0){
                float angulo = asin(fluxoDisplay[i][j][0]/sqrt(fluxoDisplay[i][j][0]*fluxoDisplay[i][j][0]+fluxoDisplay[i][j][1]*fluxoDisplay[i][j][1]));  
                if( angulo < 0)
                    angulo += 2*PI;
                if(angulo > 0 && angulo <= 2*PI/8)
                   fill(#000000);
                else if(angulo > 2*PI/8 && angulo <= 2*2*PI/8)
                   fill(#CC0000);
                else if(angulo > 2*2*PI/8 && angulo <= 3*2*PI/8)
                   fill(#FF0000);
                else if(angulo > 3*2*PI/8 && angulo <= 4*2*PI/8)
                   fill(#FF6666);
                else if(angulo > 4*2*PI/8 && angulo <= 5*2*PI/8)
                   fill(#FFCCCC);
                else if(angulo > 5*2*PI/8 && angulo <= 6*2*PI/8)
                   fill(#FFFFCC);
                else if(angulo > 6*2*PI/8 && angulo <= 7*2*PI/8)
                   fill(#E5FFCC);
                else if(angulo > 7*2*PI/8 && angulo <= 2*PI)
                   fill(#CCFFFF);
            }else{
                fill(#ffffff);
            }
            rect(j*5,300+i*5,5,5);
        }
    }
    camera.displayFluxo();
}