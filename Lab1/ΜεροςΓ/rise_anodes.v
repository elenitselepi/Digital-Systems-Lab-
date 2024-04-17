//this module is for driving tha anodes using a counter.
//Author Tselepi Eleni 03272 

module rise_anodes(clk,reset,counter,an0,an1,an2,an3);

input clk,reset; 
output [3:0]counter;//4bit counter
output an0,an1,an2,an3;

reg [3:0]counter=4'b1111;//initialise the counter to 4'b1111
reg an0,an1,an2,an3;
wire [3:0]counter_next;

always @(posedge clk or posedge reset)    //sequencial asychronous reset
begin
  if(reset)
    counter <= 4'b1111;  //if reset begin again from the 1111 value
  else
    counter <= counter_next;
end

assign counter_next=(counter==4'b0000)?(4'b1111):(counter-1); //compinational logic 

always @(counter) //compinational.It checks counter and changes the value of the anodes.The anodes are one when their value is 0 .
begin
    case(counter)
     4'b1111:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b1110:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b0; //an3 is on
     end
     4'b1101:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b1100:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b1011:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b1010:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b0; //an2 is on
        an3=1'b1;
     end
     4'b1001:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b1000:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b0111:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b0110:
     begin
        an0=1'b1;
        an1=1'b0; //an1 is on
        an2=1'b1;
        an3=1'b1;
     end
     4'b0101:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b0100:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b0011:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b0010:
     begin
        an0=1'b0; //an0 is on 
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b0001:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
     4'b0000:
     begin
        an0=1'b1;
        an1=1'b1;
        an2=1'b1;
        an3=1'b1;
     end
endcase
end


endmodule