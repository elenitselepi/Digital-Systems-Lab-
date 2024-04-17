//Module for record interface
//Author Tselepi Eleni 03272

module recorddriver(big_clk,small_clk,reset,recordEN,micDataPDM ,micGenCLK, micLRselPDM,we,deserialised,address,flag_record);

input big_clk,small_clk,reset;
input recordEN,micDataPDM;
output micGenCLK, micLRselPDM;
output [31:0] deserialised; //the output wire of the shifter
output[9:0] address; //the address of the memory 
output reg flag_record;
output [3:0] we; //write enable 
wire thirtytwo_enable;
wire flag_finish; //when memory is full
wire [4:0]counter;//used for the thertytwoanable

reg recordEN_reg;//the output of the flip flop 

reg NextState;
reg CurrentState;

parameter State_inactive=1'b0,
          State_record=1'b1;
          

assign micGenCLK = small_clk; //2MHZ clk for the sampling of the microphone
assign micLRselPDM = 'd0; //positive edge 

//This is a flip flop with input the recorden . It saves the previous state of the recorden
always@(posedge big_clk)
begin
    recordEN_reg <= recordEN; 
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
always@(CurrentState or recordEN or recordEN_reg or flag_finish )
begin

  NextState=CurrentState;
  flag_record=1'b0;
  case(CurrentState)
    State_inactive: 
    begin
      if(recordEN!=recordEN_reg && recordEN==1'b1)
        NextState=State_record;
    end
    State_record: 
    begin
      flag_record=1'b1; //start of the record 
      if(flag_finish) // whole memory is stored stop recording
        NextState=State_inactive;
    end

  endcase
  
end

shifter sifter_inst(small_clk,micDataPDM,flag_record,deserialised); //instantiation of the desirialiser
counter_thirtytwo counter_thirtytwo_inst(small_clk,reset,flag_record,thirtytwo_enable,counter);//instantiation of the counter counting 32 cycles 2Mhz
address_counter address_counter_inst(small_clk,reset,flag_record,we,thirtytwo_enable,address,flag_finish);//instantiation of the module controlling the write_memory
write_enable write_enable_inst(small_clk,reset,thirtytwo_enable,flag_record,we); //instantiation of the write enable signal 

endmodule