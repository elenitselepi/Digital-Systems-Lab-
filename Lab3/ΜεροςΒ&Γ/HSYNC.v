//Module for the FSM of the HSYNC for 640x480 and refresh rate 60Hz
//Author Tselepi Eleni 

`include "times_hsync.vh" 

module HSYNC(clk,reset,flagR,flag_D,HSYNC_signal);

input clk,reset;
input flagR;//flag when the vsync is at state R  
output reg HSYNC_signal; //VGA_HSYNC
output reg flag_D; //output flag when hsync fsm is at state D 

reg [1:0] NextState;
reg [1:0] CurrentState;

wire enable_state; //the output of the counter in order to change state 
parameter State_B=2'b00,
          State_C=2'b01,
          State_D=2'b10,
          State_E=2'b11;

//the FF state registers sequential 
always@(posedge clk or posedge reset)
begin
  if(reset)
    CurrentState <= State_B;
  else
    CurrentState <= NextState;
end

//combinational logic for the nextState and the output 
always@(CurrentState or enable_state )
begin

  NextState=CurrentState;
  case(CurrentState)
    State_B: //HSYNC Pulse Width
    begin
      HSYNC_signal=1'b0;
      flag_D=1'b0;
      if(enable_state)
        NextState=State_C;
    end
    State_C: //Back Porch
    begin
      HSYNC_signal=1'b1;
      flag_D=1'b0;
      if(enable_state)
        NextState=State_D;
    end
    State_D: //Display Time
    begin
      HSYNC_signal=1'b1;
      flag_D=1'b1;
      if(enable_state)
        NextState=State_E;
    end
    State_E: //Front Porch
    begin
      HSYNC_signal=1'b1;
      flag_D=1'b0;
      if(enable_state)
        NextState=State_B;
    end
  endcase

end


counter_hsync counter_hsync_inst(clk,reset,flagR,enable_state); //instantion of the counter counting the cycles for changing state  


endmodule