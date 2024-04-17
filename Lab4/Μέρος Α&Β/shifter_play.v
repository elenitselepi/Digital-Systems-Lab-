//Module serialiser for the playback FSM . It takes the 32 bit message and makes it 1 bit . When the counter that counts
//until 32 is at start then tmp gets the new 32bits to shift .
//Author Tselepi Eleni 

module shifter_play(clk,reset,SI,flag_play,counter,PO);

input clk,reset,flag_play;
input [31:0] SI; //the 32bit input 
input [4:0]counter; 
output reg PO; //The 1bit data 
reg [31:0] tmp;

always@(posedge clk or posedge reset)
begin

    if(reset)
    begin
        tmp<='d0;
        PO<='d0;
    end
    else if(flag_play && counter=='d0) 
    begin
        tmp<=SI;
        PO<=tmp[0];
    end 
    else 
    begin
        tmp<={1'b0,tmp[31:1]};
        PO<=tmp[0];
    end
end

endmodule