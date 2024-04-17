//Module shifter for shifting the micDATA to a register used as a deserialiser
//Author Tselepi Eleni

module shifter(clk,SI,flag_record,PO);

input clk, SI , flag_record;
output [31:0] PO;
reg [31:0] tmp;

always@(posedge clk)
begin
    if(flag_record)
    begin
        tmp <= {SI,tmp[31:1]}; //right shift because of the least significant bit 
    end 
end

assign PO = tmp;

endmodule