//Testbench for checking the vram

`timescale 1ns/1ps
`define clock_period 10

module vram_tb;

reg clk,reset;
reg [13:0] address;
wire [2:0]colours;
reg enable=1'b1;

vram vram_inst(clk,reset,enable,address,colours);

initial
begin

  clk=1'b0;
  reset=1'b0;

  #(2*`clock_period) reset=1'b1;
  #(2*`clock_period) reset =1'b0;

//first line 1st bit 
  address=14'b0000000_0000001;
  #200 if(colours==3'b111)
    $display("PASS");
  else
    $display("NOT PASS");
    
    
//third line first bit, first red line 
  #1000 address=14'b0000010_0000000;
  #10 if(colours==3'b100)
    $display(" Red PASS");
  else
    $display("NOT PASS");
    
        
//last line of red 
  #1000 address=14'b0010111_0000000;
  #10 if(colours==3'b100)
    $display(" Red PASS");
  else
    $display("NOT PASS");
       
//last blue line 
  #1000 address=14'b1000111_0000000;
  #10 if(colours==3'b001)
    $display(" Blue PASS");
  else
    $display("NOT PASS");
      
//1st multycolour line with black  
  #1000 address=14'b1001011_0000000;
  #10 if(colours==3'b000)
    $display(" black PASS");
  else
    $display("NOT PASS");
  
  //2 bit of the line   
  #1000 address=14'b1001011_0000010;
  #10 if(colours==3'b100)
    $display(" Red PASS");
  else
    $display("NOT PASS");
   //third bit of the line 
  #1000 address=14'b1001011_0000011;
  #10 if(colours==3'b100)
    $display(" Red PASS");
  else
    $display("NOT PASS");
    
  //fourth bit of the line 
  #1000 address=14'b1001011_0000100;
  #10 if(colours==3'b010)
    $display(" green PASS");
  else
    $display("NOT PASS");
    
  //fifth bit of the line 
  #1000 address=14'b1001011_0000101;
  #10 if(colours==3'b010)
    $display(" green PASS");
  else
    $display("NOT PASS");
    //6 bit of the line the firts blue 
  #1000 address=14'b1001011_0000110;
  #10 if(colours==3'b001)
    $display(" blue PASS");
  else
    $display("NOT PASS");
    
    
    //firt multicolour line with white 76 line  1st bit of white 
  #1000 address=14'b1001100_0000000;
  #10 if(colours==3'b111)
    $display(" white PASS");
  else
    $display("NOT PASS");
    
 //firt multicolour line with white 76 line  red bits
  #1000 address=14'b1001100_0000010;
  #10 if(colours==3'b100)
    $display(" red PASS");
  else
    $display("NOT PASS");
    
    
 //firt multicolour line with white 76 line  
  #1000 address=14'b1001100_0000100;
  #10 if(colours==3'b010)
    $display(" green PASS");
  else
    $display("NOT PASS");
    
 //firt multicolour line with white 76 line  
  #1000 address=14'b1001100_0000110;
  #10 if(colours==3'b001)
    $display(" blue PASS");
  else
    $display("NOT PASS");

end


always
  #(`clock_period/2)clk = ~clk;



endmodule