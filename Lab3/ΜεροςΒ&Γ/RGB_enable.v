//Module for deciding the output of the colours . When fsms are not at state D or R then VGA_RED,VGA_GREEN,VGA_BLUE are off at zero 
//Author Tselepi Eleni 

module RGB_enable(flagR,flag_D,colours,RGB);

input flagR,flag_D;
input[2:0]colours; //the colours from memory 
output reg [2:0]RGB; //the output colours 

always@(flag_D or flagR or colours)
begin

  if(flag_D && flagR) //when you are in D R then vga_Red,vga_green,vga_blue from memory
    RGB=colours;
  else
    RGB=3'b000; //else 0 

end

endmodule