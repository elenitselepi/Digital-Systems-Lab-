//This file takes as input the characters we want to present and as output makes the 7segment signals
//Author Tselepi Eleni 03272 

`include "parameters.vh" 

module LEDdecoder(char,LED);
input [3:0] char; //4bit character
output [6:0] LED; //the 7segment signals CA,CB,....CG

reg [6:0] LED;

always@(char)
begin
    case(char)
    `zero: LED=7'b0000001; //'0'
    `one: LED=7'b1001111; //'1'
    `two: LED=7'b0010010; //'2'
    `three: LED=7'b0000110; //'3'
    `four: LED=7'b1001100; //'4'
    `five: LED=7'b0100100; //'5'
    `six: LED=7'b0100000; //'6'
    `seven: LED=7'b0001111; //'7'
    `eight: LED=7'b0000000; //'8'
    `nine: LED=7'b0000100; //'9'
    `a: LED=7'b0000010; //'a'
    `b: LED=7'b1100000; //'b'
    `c: LED=7'b1110010; //'c'
    `d: LED=7'b1000010; //'d'
    `e: LED=7'b0010000; //'e'
    `F: LED=7'b0111000; //'F'
    default: LED=7'bx; //the default value is x
    endcase

end

endmodule