//module for making a flip flop 

module FF(clk,D,Q);
input clk,D; //inputs the clock and the d
output Q;

reg Q;

always@(posedge clk)
begin
  Q<=D;
end

endmodule
