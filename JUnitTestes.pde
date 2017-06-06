
public class TestJunit {
  
   int matrizOuput[][] = {{-13,-20,-17},{-18,-24,-18},{13,20,17}};
   int matrizInput[][] = {{1,2,3},{4,5,6},{7,8,9}};
   int matrizZero[][]  = {{0,0,0},{0,0,0},{0,0,0}};
   int matrizKernel[][] = {{-1,-2,-1},{0,0,0},{1,2,1}};
   int kernelLin[]   = {-1,0,1};
   int kernelCol[]   = {1,2,1};
    
     
float[][] derivarXTeste(int in1[][],int kernelLin[],int kernelCol[]){
      int rows = in1.length;
      int cols = in1[0].length;
      int kCenterYLocal = kernelLin.length/2;
      int kCenterXLocal = kernelCol.length/2;
      int kRows = kernelLin.length;
      int kCols = kernelCol.length;
      float aux1[][] = new float[rows][cols];
      float aux2[][] = new float[rows][cols];
      float outFloat[][]  = new float[rows][cols];
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              aux1[i][j] = 0;
              aux2[i][j] = 0;
              for(int m=0; m < kRows; ++m)     // derivateX rows
              {
                  int mm = kRows - 1 - m;      // row index of flipped derivateX
                  // index of input signal, used for checking boundary
                  int ii = i + (m - kCenterYLocal);
                  int jj = j + (1 - kCenterXLocal);
                  // ignore input samples which are out of bound
                  if( ii >= 0 && ii < rows && jj >= 0 && jj < cols ){
                       aux1[i][j] += in1[ii][jj] * 0.25 * kernelLin[mm] ;
                       aux2[i][j] += in1[ii][jj] * 0.25 * kernelLin[mm] ;
                  }
              }
          }
      }
      for(int i=0; i < rows; ++i)              // rows
      {
          for(int j=0; j < cols; ++j)          // columns
          {
              outFloat[i][j] = 0;
              for(int n=0; n < kCols; ++n) // derivateX columns
              {
                  int nn = kCols - 1 - n;  // column index of flipped derivateX
                  // index of input signal, used for checking boundary
                  int ii = i + (1 - kCenterYLocal);
                  int jj = j + (n - kCenterXLocal);
                  // ignore input samples which are out of bound
                  if( ii >= 0 && ii < rows && jj >= 0 && jj < cols )
                      outFloat[i][j] += aux1[ii][jj] * kernelCol[nn] + aux2[ii][jj] *kernelCol[nn]; 
              }
          }
      }
      return outFloat;
    }

   //Test
   public void testConvolucao() {
       float output1[][] = derivarXTeste(matrizInput,kernelLin,kernelCol);
       print("\n");
       for(int i =0; i <matrizInput.length;++i){
           for(int j = 0; j < matrizInput[0].length; ++j){
               print("\t"+output1[i][j]);
           }
           print("\n");
       }               
   }
}