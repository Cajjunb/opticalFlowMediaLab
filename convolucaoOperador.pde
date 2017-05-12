class convolucaoOperador{
  private int derivateX[][] =  {{-1,1},{-1,1}};
  private int derivateY[][] =  {{-1,-1},{1,1}};
  private int derivateT1[][] =  {{-1,-1},{-1,-1}};
  private int derivateT2[][] =  {{1,1},{1,1}};
  private int out[][] ;
  
  private int  kCols = 2;
  private int  kRows = 2;
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


    int[][] derivarY(int in[][]){
      // Instanciando a matrix inteira de output
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
                          out[i][j] += in1[ii][jj] * 0.25* derivateT1[mm][nn] + in2[ii][jj] * 0.25 * derivateT2[mm][nn];   //<>//
                  }
              }
          }
      }
      
      return this.out;
    }
    
    
    
}