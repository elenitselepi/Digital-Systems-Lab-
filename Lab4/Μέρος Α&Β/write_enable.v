//Module for controlling the write enable signal. I made this module because i wanted (we) be sequential in order to be 
// equal to 4'b1111 at the time write_address is 0,32,... etc 
//Author Tselepi Eleni

module write_enable(clk,reset,thirtytwo_enable,flag_record,we);

input clk,reset,thirtytwo_enable,flag_record;
output reg [3:0] we;

always @(posedge clk or posedge reset)
begin

  if(reset)
    we<='d0;
  else if(thirtytwo_enable && flag_record) //when 32 cycles have passed we=4'b1111;
    we<=4'b1111;
  else
    we<='d0;

end

endmodule