
public class TestJunit {
  
   int matrizOuput[][] = {{-13,-20,-17},{-18,-24,-18},{13,20,17}};
   int matrizInput[][] = {{1,2,3},{4,5,6},{7,8,9}};
   int matrizZero[][]  = {{0,0,0},{0,0,0},{0,0,0}};
   int matrizKernel[][] = {{-1,-2,-1},{0,0,0},{1,2,1}};
   int kernelLin[]   = {-1,0,1};
   int kernelCol[]   = {1,2,1};
    
     
    int[][] derivarXTeste(int in1[][],int kernel[][]){
      int rows = in1.length;
      int cols = in1[0].length;
      int aux[][] = new int[rows][cols];
      int kCenterYLocal = kernel.length/2;
      int kCenterXLocal = kernel[0].length/2;
      int kRows = kernel.length;
      int kCols = kernel[0].length;
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
                      int ii = i + (m - kCenterYLocal);
                      int jj = j + (n - kCenterXLocal);
                      // ignore input samples which are out of bound
                      if( ii >= 0 && ii < rows && jj >= 0 && jj < cols ){
                          aux[i][j] += in1[ii][jj] * kernel[mm][nn];  
                      }
                  }
              }
          }
      }
      
      return aux;
    }

   //Test
   public void testConvolucao() {
       convolucaoOperador operador = new convolucaoOperador();
       int output1[][] = operador.derivarXTeste(matrizInput,matrizZero,kernelLin,kernelCol);
       int output2[][] = derivarXTeste(matrizInput,matrizKernel);
       print("\n");
       for(int i =0; i <matrizInput.length;++i){
           for(int j = 0; j < matrizInput[0].length; ++j){
               print("\t"+output1[i][j]);
           }
           print("\n");
       }
       print("\n");
       for(int i =0; i <matrizInput.length;++i){
           for(int j = 0; j < matrizInput[0].length; ++j){
               print("\t"+output2[i][j]);
           }
           print("\n");
       }
               
   }
}