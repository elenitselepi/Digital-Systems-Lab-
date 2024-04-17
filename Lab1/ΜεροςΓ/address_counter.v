//This module is the counter we use to watch the active address of the memory .
//Author Tselepi Eleni 03272  

module address_counter(clk,reset,button,address);

input clk,reset,button; //button is the signal from the  M17 button 
output reg [3:0]address=4'b0000; //the active address of the memory showing which character from the memory you are reading

reg button_reg; //the output of the flip flop 

//This is a flip flop with input the button . It saves the previous state of the button
always@(posedge clk)
begin

    button_reg <= button; 

end

//The counter only rises when we push the button . It checks if button is 1 for one time .
always@(posedge clk or posedge reset )
begin
   if(reset)
    address <= 4'b0000;
   else if(button!=button_reg && button==1'b1) begin
	 	address<=(address==4'b1111)?(4'b0000):(address+1);
   end
	 	
end

endmodule