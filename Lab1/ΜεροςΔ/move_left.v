//This module includes the 23bit counter we use to move the message one position left.
//Author Tselepi Eleni 03272

module move_left(clk,reset,enable);

input clk,reset;
output enable; //when time passes the enable signal=1.

reg [22:0] twentythreeBitCounter; //the counter for the 1sec
reg enable=1'b0; //initialize the enable signal as 0 

always@(posedge clk or posedge reset)
begin
   if(reset)
   begin
    twentythreeBitCounter<=15; //23'b111_1111_1111_1111_1111_1111
   end
   else
   begin
     twentythreeBitCounter<=(twentythreeBitCounter==0)?15:(twentythreeBitCounter-1);
   end
end

always@(twentythreeBitCounter)
begin

if(twentythreeBitCounter==0) //when 23bit_counter reaches the 0 1,67sec have passed and enable is 1 in order to move the message
    enable=1;
else
    enable=0;

end 

endmodule