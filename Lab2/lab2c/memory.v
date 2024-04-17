//Memory module 

module Memory (clk, wen, din, dout);
  input  clk;
  input   wen;
  input [7:0] din;//the data input
  output [7:0] dout; //the 8bit output

  reg  [7:0] data;
  wire [7:0] dout;


  assign dout = wen==1'b0 ? data : 8'bx;
  
  /* Write only when wen==1*/
   always @(posedge clk)
   begin
    if (wen == 1'b1)
        data = din;
   end

endmodule