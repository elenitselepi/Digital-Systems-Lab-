//Module for the FSM of the VSYNC for 640x480 and refresh rate 60Hz
//Author Tselepi Eleni 

module VSYNC(clk,reset,flagR,VSYNC_signal);

input clk,reset; 
output reg VSYNC_signal; //one bit signal for VGA_VSYNC  
output reg flagR;//output flag when we are at state R 


reg [1:0] NextState;
reg [1:0] CurrentState;
wire enable_state; //the output of the counter in order to change state 
parameter State_P=2'b00,
          State_Q=2'b01,
          State_R=2'b10,
          State_S=2'b11;

//the FF state registers sequential 
always@(posedge clk or posedge reset)
begin
  if(reset)
    CurrentState <= State_P;
  else
    CurrentState <= NextState;
end

//combinational logic for the nextState and the output 
always@(CurrentState or enable_state)
begin

  NextState=CurrentState;
  case(CurrentState)
    State_P: //VSYNC Pulse Width
    begin
      VSYNC_signal=1'b0;
      flagR=1'b0;
      if(enable_state)
        NextState=State_Q;
    end
    State_Q: //Back Porch
    begin
      VSYNC_signal=1'b1;
      flagR=1'b0;
      if(enable_state)
        NextState=State_R;
    end
    State_R: //Active Video Time
    begin
      VSYNC_signal=1'b1;
      flagR=1'b1;
      if(enable_state)
        NextState=State_S;
    end
    State_S: //Front Porch
    begin
      VSYNC_signal=1'b1;
      flagR=1'b0;
      if(enable_state)
        NextState=State_P;
    end
  endcase

end


counter_vsync counter_vsync_inst(clk,reset,enable_state); //instantiation of the counter counting cycles for changing the State of the FSM vsync


endmodule