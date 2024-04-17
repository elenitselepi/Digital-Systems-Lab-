//module for the anti-bounce of the buttons 
//Author Tselepi Eleni 03272 

module antibounce(signal,clk,antibounce_signal);
input signal,clk;
output reg antibounce_signal;

wire q1,q2,q2_bar,new_clk;
reg [20:0]counter=0; //2^21=2.097.152 . for antibouncing we use 0.5sec=500_000_000ns/500ns(period)=1_000_000

FF FF1(clk,signal,q1); //instatiate the first flip flop
FF FF2(clk,q1,q2); //instatiate the second flip flop that has input the output of the fisrt flip flop

always@(posedge clk)
begin

if(q1==q2)//if the output of the first flip flop is the same as the output of the second increase the counter
    counter<=(counter>1_000_000)?0:counter+1;//if counter reaches 1_000_000 'reset' the counter and make it zero again else add one 
else
    counter<=0;
end

always@(posedge clk)
begin
    if(counter==1_000_000)//when counter reaches 1_000_000 antibounce signal is the q1
        antibounce_signal<=q1;
end

endmodule