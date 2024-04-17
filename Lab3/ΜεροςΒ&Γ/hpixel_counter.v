//Module for hpixel_counter.Hpixel increases when signal twenty_enable has came .
//Hpixel changes per 20 cycles
//Author Tselepi Eleni 

module hpixel_counter(clk,reset,twenty_enable,HPIXEL);

input clk,reset;
input twenty_enable;

output reg [6:0] HPIXEL; //7bit wire for the 128 horizontal position of the memory

always@(posedge clk or posedge reset)
begin

  if(reset)
  begin
    HPIXEL<='d0;
  end
  else if (twenty_enable)
  begin
    HPIXEL<=(HPIXEL=='d128)?'d0:HPIXEL+1;
  end
  else
  begin
    HPIXEL<=(HPIXEL=='d128)?'d0:HPIXEL;
  end

end



endmodule