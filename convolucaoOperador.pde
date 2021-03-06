class convolucaoOperador{
  private int derivateX[][] =  {{-1,1},{-1,1}};
  private int derivateY[][] =  {{-1,-1},{1,1}};
  private int derivateXOtimizadoCol[]=  {-1,-1};
  private int derivateXOtimizadoLin[]=  {1,-1};
  private int derivateYOtimizadoCol[]=  {-1,-1};
  private int derivateYOtimizadoLin[]=  {1,-1};


  private int derivateT1[][] =  {{-1,-1},{-1,-1}};
  private int derivateT2[][] =  {{1,1},{1,1}};
  private int derivateOtimizadoT1Col[] =  {-1,-1};
  private int derivateOtimizadoT1Lin[] =  {1,1};
  
  public  int out[][] ;
  private float media[][] = {{1/12, 1/6, 1/12},{1/6, 0, 1/6},{1/12, 1/6, 1/12}};
  public float  outVetor [][][] ;
  
  
  private int  kCols = 2;
  private int  kRows = 2;
  private int  mediaCols = 3;
  private int  mediaRows = 3;
  private int  mediaCenterX = mediaCols/2;
  private int  mediaCenterY = mediaRows/2;
  private int  cols     ;
  private int  rows     ;
  
  // find center position of derivateX (half of derivateX size)
  int kCenterX = kCols / 2;
  int kCenterY = kRows / 2;
  
  
  convolucaoOperador(){
    
  }
  
  
  int[][] derivarX(int in[][]){
      this.rows = in.length;
      this.cols = in[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in[ii][jj] * derivateX[mm][nn];  
                  }
              }
          }
      }
      
      return this.out;
    }

  int[][] derivarX(int in1[][],int in2[][]){
      this.rows = in1.length;
      this.cols = in1[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in1[ii][jj] *0.25* derivateX[mm][nn] + in2[ii][jj] *0.25* derivateX[mm][nn];  
                  }
              }
          }
      }      
      return this.out;
    }

  int[][] derivarXOtimizado(int in1[][],int in2[][]){
      this.rows = in1.length;
      this.cols = in1[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  // index of input signal, used for checking boundary
                  int ii = i + (m - kCenterY);
                  int jj = j + (1 - kCenterX);
                  // ignore input samples which are out of bound
                  if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                      out[i][j] += in1[ii][jj] *1* derivateXOtimizadoCol[mm] + in2[ii][jj] *1* derivateXOtimizadoCol[mm];  
              }
          }
      }
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int n=0; n < kCols; ++n) // derivateX columns
              {
                  int nn = kCols - 1 - n;  // column index of flipped derivateX
                  // index of input signal, used for checking boundary
                  int ii = i + (1 - kCenterY);
                  int jj = j + (n - kCenterX);
                  // ignore input samples which are out of bound
                  if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                      out[i][j] += in1[ii][jj] *0.25* derivateXOtimizadoLin[nn] + in2[ii][jj] *0.25* derivateXOtimizadoLin[nn];  
              }
          }
      }
      return this.out;
    }
    
    int[][] derivarXTeste(int in1[][],int in2[][],int kernelLin[],int kernelCol[]){
      int rows = in1.length;
      int cols = in1[0].length;
      int aux[][] = new int[rows][cols];
      int kCenterYLocal = kernelLin.length/2;
      int kCenterXLocal = kernelCol.length/2;
      int kRows = kernelLin.length;
      int kCols = kernelCol.length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < 1; ++n) // derivateX columns
                  {
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterYLocal);
                      int jj = j + (1 - kCenterXLocal);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          aux[i][j] += in1[ii][jj] *1* kernelLin[mm] + in2[ii][jj] *0* kernelLin[mm];
                  }
              }    
          }
      }
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int m=0; m < 1; ++m)     // derivateX rows
              {
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (1 - kCenterYLocal);
                      int jj = j + (n - kCenterXLocal);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += aux[ii][jj] * kernelCol[nn] + in2[ii][jj] *0* kernelCol[nn];  
                  }
              }
          }
      }
      return this.out;
    }
    
    int[][] derivarYOtimizado(int in1[][],int in2[][]){
      this.rows = in1.length;
      this.cols = in1[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  // index of input signal, used for checking boundary
                  int ii = i + (m - kCenterY);
                  int jj = j + (0 - kCenterX);
                  // ignore input samples which are out of bound
                  if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                      out[i][j] += in1[ii][jj] *1* derivateYOtimizadoCol[mm] + in2[ii][jj] *1* derivateYOtimizadoCol[mm];  
              }
          }
      }
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int n=0; n < kCols; ++n) // derivateX columns
              {
                  int nn = kCols - 1 - n;  // column index of flipped derivateX
                  // index of input signal, used for checking boundary
                  int ii = i + (0 - kCenterY);
                  int jj = j + (n - kCenterX);
                  // ignore input samples which are out of bound
                  if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                      out[i][j] += in1[ii][jj] *0.25* derivateYOtimizadoLin[nn] + in2[ii][jj] *0.25* derivateYOtimizadoLin[nn];  
              }
          }
      }
      return this.out;
    }



    int[][] derivarY(int in[][]){
      // Instanciando a matrix inteira de output
      this.rows = in.length;
      this.cols = in[0].length;
      this.out  = new int[rows][cols]; 
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in[ii][jj] * derivateY[mm][nn];  
                  }
              }
          }
      }      
      return this.out;
    }


  int[][] derivarY(int in1[][],int in2[][]){
      this.rows = in1.length;
      this.cols = in1[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in1[ii][jj] * 0.25*derivateY[mm][nn] + in2[ii][jj] * 0.25*derivateY[mm][nn];  
                  }
              }
          }
      }      
      return this.out;
    }

    
    int[][] derivarT1(int in[][]){
      this.rows = in.length;
      this.cols = in[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in[ii][jj] * derivateT1[mm][nn];  
                  }
              }
          }
      }
      
      return this.out;
    }
    
    int[][] derivarT2(int in[][]){
      this.rows = in.length;
      this.cols = in[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in[ii][jj] * derivateT2[mm][nn];  
                  }
              }
          }
      }     
      return this.out;
    }
    int[][] derivarT1T2(int in1[][],int in2[][]){
      this.rows = in1.length;
      this.cols = in1[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  { //<>//
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in1[ii][jj] * 0.25* derivateT1[mm][nn] + in2[ii][jj] * 0.25 * derivateT2[mm][nn];  
                  }
              }
          }
      }  
      return this.out;
    }
    
    

    int[][] derivarT1T2Otimizado(int in1[][],int in2[][]){
      this.rows = in1.length;
      this.cols = in1[0].length;
      this.out  = new int[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  // index of input signal, used for checking boundary
                  int ii = i + (m - kCenterY);
                  int jj = j + (0 - kCenterX);
                  // ignore input samples which are out of bound
                  if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                      out[i][j] += in1[ii][jj] * 1* derivateOtimizadoT1Col[mm] + in2[ii][jj] * 1 * derivateOtimizadoT1Col[mm];  
              }
          }
      }
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              out[i][j] = 0;
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  for(int n=0; n < kCols; ++n) // derivateX columns
                  {
                      int nn = kCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - kCenterY);
                      int jj = j + (n - kCenterX);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                          out[i][j] += in1[ii][jj] * 0.25* (-1)*derivateOtimizadoT1Lin[nn] + in2[ii][jj] * 0.25 * (-1)*derivateOtimizadoT1Lin[nn];  
                  }
              }
          }
      }
      return this.out;
    }
    
    
 
    float[][][] calcularMediaVetor(float in1[][][]){
      this.rows = in1.length;
      this.cols = in1[0].length;
      this.outVetor  = new float[rows][cols][2];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              for(int m=0; m < mediaRows; ++m)     // derivateX rows
              {
                  int mm = mediaRows - 1 - m;      // row index of flipped derivateX
                  for(int n=0; n < mediaCols; ++n) // derivateX columns
                  {
                      int nn = mediaCols - 1 - n;  // column index of flipped derivateX
                      // index of input signal, used for checking boundary
                      int ii = i + (m - mediaCenterY); //<>//
                      int jj = j + (n - mediaCenterX); //<>//
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols ){
                          outVetor[i][j][0] += in1[ii][jj][0] *  media[mm][nn] ;  
                          outVetor[i][j][1] += in1[ii][jj][1] *  media[mm][nn] ;  
                      }
                  }
              }
          }
      }
      return this.outVetor;
    }    
}