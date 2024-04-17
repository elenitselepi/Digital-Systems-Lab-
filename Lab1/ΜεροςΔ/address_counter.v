//This module is the counter we use to watch the active address of the memory .
//Author Tselepi Eleni 03272  

module address_counter(clk,reset,button,address);

input clk,reset,button; //button is the sugnal coming from the move_left module that has a counter when time passes to send a signal enable 
output reg [3:0]address=4'b0000;//the active address of the memory showing which character from the memory you are reading

//the address counter only rises when the signal button from move_left comes .
always@(posedge clk or posedge reset )
begin
   if(reset)
    address <= 4'b0000;
   else if(button)
	 	address<=(address==4'b1111)?(4'b0000):(address+1);
end

endmodule