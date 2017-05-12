convolucaoOperador operador;

void setup(){
    int input[][] = {{1,0,0}};
    int output1[][], output2[][] ;
    operador = new convolucaoOperador();
    output1  = operador.derivarX(input);
    output1  = operador.derivarX(output1);
    output2 = operador.derivarY(input);
    output2  = operador.derivarX(output2);
    
    for(int i = 0; i < output1.length; ++i){
        for(int j = 0; j < output1[0].length; ++j)
            print(output1[i][j]+"\t");
        print("\n");
    }
    print("\n");
    for(int i = 0; i < output2.length; ++i){
        for(int j = 0; j < output2[0].length; ++j)
            print(output2[i][j]+"\t");
        print("\n");
    }
}