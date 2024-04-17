//This module has everything for the characters we change.First save them in memory and then send to the decoder
//Author Tselepi Eleni 03272

`include "parameters.vh" 

module drive_char(clk,anodes_counter,address,char);

input clk;
input [3:0]anodes_counter; //the counter that is coming from the rise_anodes module fro counting which anode will be on 
input [3:0] address; //the active memory address that is coming drom the address_counter module
output reg [3:0]char;

wire[3:0]address_an3,address_an2,address_an1,address_an0;//use 4 new addresses in order to read diffent memory for each anode
reg [3:0] message [0:15]; //the 16 characters message 

always@(posedge clk) //initialize the memory 
begin
    message[4'b0000]<=`zero;
    message[4'b0001]<=`one;
    message[4'b0010]<=`two;
    message[4'b0011]<=`three;
    message[4'b0100]<=`four;
    message[4'b0101]<=`five;
    message[4'b0110]<=`six;
    message[4'b0111]<=`seven;
    message[4'b1000]<=`eight;
    message[4'b1001]<=`nine;
    message[4'b1010]<=`a;
    message[4'b1011]<=`b;
    message[4'b1100]<=`c;
    message[4'b1101]<=`d;
    message[4'b1110]<=`e;
    message[4'b1111]<=`F;
end

//this always blocks checks which anode is on in order to drive the right character from the memory.We should drive the char 2 cycles before one anode is on and one cycle after .
always @(anodes_counter or address_an3 or address_an2 or address_an1 or address_an0)  
begin
    case(anodes_counter)
     4'b1111:
        char=message[address_an3];//an3
     4'b1110:
        char=message[address_an3];
     4'b1101:
        char=message[address_an3];
     4'b1100:
        char=message[address_an2];//an2
     4'b1011:
        char=message[address_an2];
     4'b1010:
        char=message[address_an2]; 
     4'b1001:
        char=message[address_an2]; 
     4'b1000:
        char=message[address_an1];//an1
     4'b0111:
        char=message[address_an1];
     4'b0110:
        char=message[address_an1];
     4'b0101:
        char=message[address_an1];
     4'b0100:
        char=message[address_an0];//an0
     4'b0011:
        char=message[address_an0];
     4'b0010:
        char=message[address_an0];
     4'b0001:
        char=message[address_an0];
     4'b0000:
        char=message[address_an3];//an3
endcase
end

//the address the anodes are going to look are some positions after the address.if it surpass the value 15 and is out of bounds of the message area substracte the position that is going to look - 16 all posible positions of the array in order to start from the beggining 
assign address_an3=address; //has the same value as the address.
assign address_an2=(address+4'b0001 > 4'b1111)?((address+4'b0001)-5'b10000):(address+1);//the address the anode 2 is going to look is 1 position after the address.
assign address_an1=(address+4'b0010>4'b1111)?((address+4'b0010)-5'b10000):(address+4'b0010); //the address the anode 1 is going to look is 2 positions after the address.
assign address_an0=(address+4'b0011>4'b1111)?((address+4'b0011)-5'b10000):(address+4'b0011); //the address the anode 0 is going to look is 3 positions after the address.

endmodule