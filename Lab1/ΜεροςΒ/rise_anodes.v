//Module for driving the anodes signals using a counter
//Author Tselepi Eleni 03272

`include "parameters.vh" 

module rise_anodes(clk,reset,an0,an1,an2,an3,char);

input clk,reset;
output an0,an1,an2,an3; //drive the anodes an0,an1,an2,an3
output[3:0] char;

reg an0,an1,an2,an3;
reg [3:0] char;
reg [3:0] counter; //4bit counter
wire [3:0]counter_next;

always @(posedge clk or posedge reset)    //sequencial asychronous reset
begin
  if(reset)
    counter <= 4'b1111;  //if reset begin again from the 1111 value
  else
    counter <= counter_next;
end

assign counter_next=(counter==4'b0000)?(4'b1111):(counter-1); //compinational logic 

always @(counter)  //compinational.It checks counter and changes the value of the anodes.The anodes are one when their value is 0 .
begin
    case(counter)
     4'b1111:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`zero; //the anode3 will have the character '0'
     end
     4'b1110:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b0; //an3 is on
        char=`zero;
     end
     4'b1101:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`zero;
     end
     4'b1100:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`one;  //the anode2 will have the character '1'
     end
     4'b1011:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`one;  
     end
     4'b1010:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b0; //an2 is on
        an3=1'b1;
        char=`one;  
     end
     4'b1001:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`one;  
     end
     4'b1000:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`two; //the anode1 will have the character '2'
     end
     4'b0111:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`two;
     end
     4'b0110:
     begin
        an0=1'b1;
        an1=1'b0; //an1 is on
        an2=1'b1;
        an3=1'b1;
        char=`two;
     end
     4'b0101:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`two;
     end
     4'b0100:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`three; //the anode0 will have the character '3'
     end
     4'b0011:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`three;
     end
     4'b0010:
     begin
        an0=1'b0; //an0 is on 
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`three;
     end
     4'b0001:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`three; 
     end
     4'b0000:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
        char=`zero;
     end
endcase
end

   
endmodule