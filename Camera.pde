import processing.video.*;
// Importando biblioteca de video

// DECLARACAO DA CLASSE DE CAMERA QUE TRATA E FAZ INTERFACE COM OUTROS MODULOS
class cameraInput {
  //Camera Objeot
  Capture cameraPrincipal;
  //Camera Objeot
  PImage frameAnterior;
  IntList movimentoDetectado;
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
  
  int frame1INT[][] ;
  int frame2INT[][] ;
  float fluxo[][][]    ;

  // Construtor, incializa a camera e verifica se eh possivel ser utilizado
  cameraInput(exemploConvolucao ambiente){
      this.cameraPrincipal = new Capture(ambiente,320,240,30);
      this.cameraPrincipal.start();
      this.frameAnterior = createImage(this.cameraPrincipal.width, this.cameraPrincipal.height, RGB);
      this.frame1 = createImage(this.cameraPrincipal.width, this.cameraPrincipal.height, RGB);
      this.frame2 = createImage(this.cameraPrincipal.width, this.cameraPrincipal.height, RGB);
      this.movimentoDetectado = new IntList();
      //IMAGENS PARA SER COLOCADAS NA MOSTRA DO FLUXO
      setaUp = loadImage("setaUp.png");
      setaDown = loadImage("setaDown.png");
      setaLeft = loadImage("setaLeft.png");
      setaRight = loadImage("setaRight.png");
      setaUpLeft = loadImage("setaUpLeft.png");
      setaUpRight = loadImage("setaUpRight.png");
      setaDownLeft = loadImage("setaDownLeft.png");
      setaDownRight = loadImage("setaDownRight.png");
  }
  
  void calculaFluxo(){
    this.frame1.copy(this.cameraPrincipal,0,0,this.cameraPrincipal.width,this.cameraPrincipal.height,0,0,this.cameraPrincipal.width,this.cameraPrincipal.height);
    this.frame1.updatePixels();
    this.cameraPrincipal.read();
    delay(50);
    this.frame2.copy(this.cameraPrincipal,0,0,this.cameraPrincipal.width,this.cameraPrincipal.height,0,0,this.cameraPrincipal.width,this.cameraPrincipal.height);
    this.frame2.updatePixels();
    this.cameraPrincipal.read();
   
    this.frame1.filter(GRAY);    
    this.frame2.filter(GRAY);
    this.frame1.loadPixels();
    this.frame2.loadPixels();
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
    OpticalFlow estimador = new OpticalFlow(40,20);
    fluxo = estimador.estimarFluxo(frame1INT,frame2INT);
    print("\tTERMINANDO PROCESSAMENTO" + (millis() -t));        
  }
  
  //Mostra FLuxo
  void displayFluxo(){
    image(frame1,0,0);
    image(frame2,400,0);
    //PRINTANDO A REPRESENTACAO
     for(int i = 0; i < frame2.height; i+=1){
         for(int j = 0; j < frame2.width; j+=1){
             int numeroMedia = 0;
             float valorU      = 0;
             float valorV      = 0;
             //Calculando a media em geral perto
             /*if(i - 1 > 0){
                 ++numeroMedia;
                 valorU += fluxo[i-1][j][0];
                 valorV += fluxo[i-1][j][1];
             }
             if(i + 1 < frame2.height){
                 ++numeroMedia;
                 valorU += fluxo[i+1][j][0];
                 valorV += fluxo[i+1][j][1];
             }
             if(j - 1 > 0){
                 ++numeroMedia;
                 valorU += fluxo[i][j-1][0];
                 valorV += fluxo[i][j-1][1];
             }
             if(j + 1 < frame2.width){
                 ++numeroMedia;
                 valorU += fluxo[i][j+1][0];
                 valorV += fluxo[i][j+1][1];
             }*/
             //CALCULANDO MEDIA
             valorU = fluxo[i][j][0];
             valorV = fluxo[i][j][1];
             if(valorU != 0 && valorV != 0){
                 // Calculando o angulo para ser mostrado, levamos em conta se o numero passou de -1 e 1
                 float angulo = asin(valorU/sqrt(valorU*valorU+valorV*valorV));
                 if( angulo < 0)
                     angulo += 2*PI;
                 if(angulo > 0 && angulo <= 2*PI/8)
                     image(setaRight,j,i,1,1);
                 else if(angulo > 2*PI/8 && angulo <= 2*2*PI/8)
                     image(setaUpRight,j,i,1,1);
                 else if(angulo > 2*2*PI/8 && angulo <= 3*2*PI/8)
                     image(setaUp,j,i,1,1);
                 else if(angulo > 3*2*PI/8 && angulo <= 4*2*PI/8)
                     image(setaUpLeft,j,i,1,1);
                 else if(angulo > 4*2*PI/8 && angulo <= 5*2*PI/8)
                     image(setaLeft,j,i,1,1);
                 else if(angulo > 5*2*PI/8 && angulo <= 6*2*PI/8)
                     image(setaDownLeft,j,i,1,1);
                 else if(angulo > 6*2*PI/8 && angulo <= 7*2*PI/8)
                     image(setaDown,j,i,1,1);
                 else if(angulo > 7*2*PI/8 && angulo <= 2*PI)
                     image(setaDownRight,j,i,1,1);
             }
         }
     }
  }
  
  // Funcao que guarda o frame para ser calculado a diferenca depois
  void capturaFrame(){
    //this.frameAnterior = createImage(this.cameraPrincipal.width, this.cameraPrincipal.height, RGB);
  }
  // pega o pixel de movimento detectado tratado como fila
  int getPixelDetectado(){
    int retorno;  
    if(this.movimentoDetectado.size() > 0 ){
      retorno = this.movimentoDetectado.get(0);
      this.movimentoDetectado.remove(0);
    }
    else{
      retorno = -1;
    }
    return retorno;
  }


// Funcao que verifica se esta funcionando e desenha o conteudo na tela
  boolean cameraMovimento(){
    // Componentes da Imagem em rgb do frame atual e o anterior
    int  pixelsDiferentes = 0;
    float r1; 
    float g1; 
    float b1;
    float r2; 
    float g2; 
    float b2;
    color atual;      
    color anterior; 
    float diferenca;
    boolean movimentoDetectado = false;
    
    // Carregando pixels
    loadPixels();
    this.cameraPrincipal.loadPixels();
    this.frameAnterior.loadPixels();
    //Senao carregar fica com a imagem preta
    for(int i = 0; i < this.cameraPrincipal.width; i++){
      for(int j = 0; j < this.cameraPrincipal.height; j++){
        int loc = i + j * this.cameraPrincipal.width;
        atual = this.cameraPrincipal.pixels[loc];
        anterior = this.frameAnterior.pixels[loc];
        r1 = red(atual); 
        g1 = green(atual); 
        b1 = blue(atual);
        r2 = red(anterior); 
        g2 = green(anterior); 
        b2 = blue(anterior);         
        diferenca = dist(r1,g1,b1,r2,g2,b2);
        if(diferenca > 300){
          //print("\tLOC =",loc,"\n");
          if(pixelsDiferentes == 1000 ){
            movimentoDetectado = true;
            this.movimentoDetectado.append(loc);
            break;  
          }else{
            pixelsDiferentes++;
          }
        }
      }
    }
    if (movimentoDetectado)
      return true;
    else
      return false;
  }
  
  // funcao que faz o output da camera e guarda o frames para o tracking da camera
  void desenhaCamera(){
    if (this.cameraPrincipal.available() == true) {  
      this.frameAnterior.copy(this.cameraPrincipal,0,0,this.cameraPrincipal.width,this.cameraPrincipal.height,0,0,this.cameraPrincipal.width,this.cameraPrincipal.height);
      this.frameAnterior.updatePixels();
      delay(500);
      this.cameraPrincipal.read();
    }
    image(this.cameraPrincipal,200 , 0);
    image(this.frameAnterior,0,0);
  }
}