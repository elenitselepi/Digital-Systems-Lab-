//Baud control file sending sample enable when thw counter has count the number of cucles needed for the sampling.
//Author Tselepi Eleni 03272


module baud_controller(reset,clk,baud_select,sample_ENABLE);

input reset,clk;
input [2:0] baud_select;
output reg sample_ENABLE;

reg [14:0] cycles; //15bit 2^15=32.768
reg [14:0] counter=0;

always@(baud_select) //the cycles are calculated 1/16 x baud_rate x 10 (the period)
begin
  case(baud_select)
  3'b000:
    cycles=20833;
  3'b001:
    cycles=5208;
  3'b010:
    cycles=1302;
  3'b011:
    cycles=651;
  3'b100:
    cycles=325;
  3'b101:
    cycles=162;
  3'b110:
    cycles=108;
  3'b111:
    cycles=54;
  endcase
end

//counter counting the cycles for the baud rate selected 
always@(posedge clk or posedge reset)
begin
  if(reset)
  begin
    counter<=0;
  end
  else
  begin
    counter<=(counter>cycles)?0:counter+1;
  end

end

//when counter == cycles -1 then a sugnal sample_Enable is one 
always@(counter or cycles)
begin
  if(counter==(cycles-1))
    sample_ENABLE=1'b1;
  else
    sample_ENABLE=1'b0;
end


endmodule