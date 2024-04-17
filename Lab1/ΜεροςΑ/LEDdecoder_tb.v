//Testbench file for testing the LEDdecoder file . Per 20ns it changes the input character and it monitors all the outputs 
//Author Tselepi Eleni 03272

`timescale 1ns/1ps
`include "parameters.vh"

module LEDdecoder_tb;

reg [3:0] char;
wire [6:0] LED;


LEDdecoder LEDdecoder_inst(char,LED);  //instantiate LEDdecoder

//Change all possible 16 values input can takes
initial 
  begin
    $monitor("time %d ns: for char = %b the LED is %b",$time,char,LED); //Monitor the results 
    #20 char = `zero ;
    #20 char = `one ;
    #20 char = `two ;
    #20 char = `three ;
    #20 char = `four ;
    #20 char = `five;
    #20 char = `six ;
    #20 char = `seven ;
    #20 char = `eight ;
    #20 char = `nine ;
    #20 char = `a ;
    #20 char = `b ;
    #20 char = `c ;
    #20 char = `d ;
    #20 char = `e ;
    #20 char = `F ;
  end 
 

endmodule





    
        

