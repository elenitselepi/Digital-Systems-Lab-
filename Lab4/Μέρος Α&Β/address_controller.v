//Module for controlling the address . If we are at the record FSM the address that goes to the memory is from record FSM else if we want to play the message the address if form  the play FSM
//Author Tselepi Eleni 

module address_controller(flag_record,flag_play,write_address,read_address,address);

input flag_record,flag_play;
input [9:0] write_address,read_address; //the address from  the FSMS
output reg [9:0] address; //the address that goes to the memory 

always@(flag_record or flag_play or write_address or read_address)
begin
  if(flag_record)
    address=write_address;
  else if(flag_play)
    address=read_address;
  else
    address='d0;
end


endmodule