module Memory_transmitter (clk, ren, wen, din, dout);
  input  clk;
  input  ren, wen;
  input [7:0] din;//the data input
  output [7:0] dout; //the 8bit output

  reg  [7:0] data;
  wire [7:0] dout;


  assign dout = ((wen==1'b0) && (ren==1'b1)) ? data : 8'bx;
  
  /* Write when write_enable(wen)=1 and read_enable(ren) is 0 */
   always @(posedge clk)
   begin
    if (wen == 1'b1 && ren==1'b0)
        data = din;
   end

endmodule

