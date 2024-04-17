//The counter counting the cycles for the vsync signal with output when to change state  
//Author Tselepi Eleni 

`include "times_vsync.vh" 

module counter_vsync(clk,reset,enable_state);

input clk,reset;
output reg enable_state;
reg [20:0] vsync_counter; //2^21=2.097.152 1 frame is 1.667.200 cycles

always@(posedge clk or posedge reset)
begin

  if(reset)
  begin
    vsync_counter<='d0;
  end
  else
  begin
    vsync_counter<=(vsync_counter==`O-1)?'d0:vsync_counter+1;
  end

end

always@(vsync_counter)
begin
  if(vsync_counter == `P-1 ) 
  begin
    enable_state=1'b1; //nextstate is Q
  end
  else if(vsync_counter == (`P +`Q) - 1)
  begin
    enable_state=1'b1; //nextstate is R
  end
  else if(vsync_counter == (`P +`Q +`R)-1 ) //nextstate is S
    enable_state=1'b1;
  else if (vsync_counter == (`P+`Q+`R+`S)-1) //nextstate is P
    enable_state=1'b1;
  else
    enable_state=1'b0;

end

endmodule
