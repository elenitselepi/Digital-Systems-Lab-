//Counter module counting the cycles for each state of the HSYNC FSM
//Author Tselepi Eleni

`include "times_hsync.vh" 

module counter_hsync (clk,reset,flagR,enable_state);

input clk,reset,flagR;
output reg enable_state;//the enable signal in order fsm change state 
reg [11:0] hsync_counter; //2^12=4096 1 line is 3200 cycles

//counter
always@(posedge clk or posedge reset)
begin

  if(reset)
  begin
    hsync_counter<='d0;
  end
  else if (flagR)
  begin
    hsync_counter<=(hsync_counter==`A-1)?'d0:hsync_counter+1;
  end

end

//combinational always block checking when to change state, with enable_state being 1 only when cycles of each state passes
always@(hsync_counter)
begin
  if(hsync_counter == `B-1 ) 
    enable_state=1'b1; //nextstate is C
  else if(hsync_counter == (`B +`C) - 1)
    enable_state=1'b1; //nextstate is D
  else if(hsync_counter == (`B +`C +`D)-1 ) //nextstate is E 
    enable_state=1'b1;
  else if (hsync_counter == (`B+`C+`D+`E)-1) //nextstate is B 
    enable_state=1'b1;
  else
    enable_state=1'b0;

end

endmodule