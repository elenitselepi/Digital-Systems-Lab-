//FSM for the play of the message
//Author Tselepi Eleni 03272

module playdriver(big_clk,small_clk,reset,playbackEN,readdata,audDataPWM,read_address,flag_play,audEnPWM);

input big_clk,small_clk,reset;
input playbackEN; //The button to start playing the audio
input [31:0] readdata; //The Data output of the memory 
output audDataPWM; //The 1bit Data sent to the audio jack 
output [9:0] read_address; //the address that the play FSM controls 
output reg flag_play; //a flag when playing the message 
output audEnPWM; 
reg playbackEN_reg;
wire flag_finish,thirtytwo_enable;//finish the 5sec
wire [4:0] counter; //the counter of the thirtytwo counter used at the module shifter_play


reg NextState;
reg CurrentState;

parameter State_inactive=1'b0,
          State_play=1'b1;

//This is a flip flop with input the playen . It saves the previous state of the playen . It is "posedge button"
always@(posedge big_clk)
begin
    playbackEN_reg <= playbackEN; 
end


//the FF state registers sequential 
always@(posedge big_clk or posedge reset)
begin
  if(reset)
    CurrentState <= State_inactive;
  else
    CurrentState <= NextState;
end

//combinational logic for the nextState and the output 
always@(CurrentState or playbackEN or playbackEN_reg or flag_finish )
begin

  NextState=CurrentState;
  flag_play=1'b0;
  case(CurrentState)
    State_inactive: 
    begin
      if(playbackEN!=playbackEN_reg && playbackEN==1'b1)
        NextState=State_play;
    end
    State_play: 
    begin
      flag_play=1'b1; //start of the record 
      if(flag_finish) //5sec have passed 
        NextState=State_inactive;
    end

  endcase
  
end

assign audEnPWM = flag_play; //the enable output signal for the audio

counter_fivesec counter_fivesec_inst(big_clk,reset,flag_play,flag_finish); //Instantiation of the counter counting the 5 sec
shifter_play shifter_play_inst(small_clk,reset,readdata,flag_play,counter,audDataPWM); //instantiation of the serialiser
counter_thirtytwo counter_thirtytwo_inst(small_clk,reset,flag_play,thirtytwo_enable,counter);//Instantiation of the counter counting until 32 .
addresscounter_player addresscounter_player_inst(small_clk,reset,flag_play,thirtytwo_enable,read_address);//The module for the read_address 

endmodule