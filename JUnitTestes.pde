
public class TestJunit {
  
   int matrizOuput[][] = {{-13,-20,-17},{-18,-24,-18},{13,20,17}};
   int matrizInput[][] = {{1,2,3},{4,5,6},{7,8,9}};
   int matrizZero[][]  = {{0,0,0},{0,0,0},{0,0,0}};
   int kernelLin[]   = {1,0,-1};
   int kernelCol[]   = {1,2,1};


   //Test
   public void testConvolucao() {
       convolucaoOperador operador = new convolucaoOperador();
       int output[][] = operador.derivarXTeste(matrizInput,matrizZero,kernelLin,kernelCol);
       for(int i =0; i <matrizInput.length;++i){
           for(int j = 0; j < matrizInput[0].length; ++j)
               print("\t"+output[i][j]);
           print("\n");
       }
               
   }
}