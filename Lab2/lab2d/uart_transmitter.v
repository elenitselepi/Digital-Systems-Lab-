//Transmitter module . The transmitter sends every bit when 16 times sample_enable have passed
//Author Tselepi Eleni 03272

module uart_transmitter(reset,clk,Tx_DATA,baud_select,Tx_WR,Tx_EN,TxD,Tx_BUSY);

input reset,clk;
input [7:0] Tx_DATA; //the 8bit symbol
input [2:0] baud_select; //select the baud_rate
input Tx_EN; //the transmitter is on 
input Tx_WR; //give TxDATA to the transmitter

output reg TxD; //1bit output 
output reg Tx_BUSY = 0; // when it is 1 you cant write to Tx_Data

wire Tx_sample_ENABLE;
reg [3:0] CurrentState;
reg [3:0] NextState;
reg [3:0] counter=4'b0000; //the counter for the 16 times 
wire enable ;//the signal that have past the 16 times of tx_sample_enable
wire [7:0] reg_data; //help buffer for storing the Tx_Data  
reg wen,ren,reg_enable; //the write enable and read enable for the memory module
reg parity;

parameter State_beforeStart=4'b0000,
          State_write_mem=4'b0001,
          State_start=4'b0010,
          State_firstdata=4'b0011,
          State_seconddata=4'b0100,
          State_thirddata=4'b0101,
          State_fourthdata=4'b0110,
          State_fifthdata=4'b0111,
          State_sixdata=4'b1000,
          State_sevendata=4'b1001,
          State_eightdata=4'b1010,  
          State_parity=4'b1011,
          State_stop=4'b1100,
          State_X=4'b1101;


//the FF state registers sequential 
always@(posedge clk or posedge reset)
begin
  if(reset)
    CurrentState <= State_beforeStart;
  else
    CurrentState <= NextState;
end


//combinational logic for the nextState and the output
always@(CurrentState or Tx_EN or Tx_WR or enable or reg_enable or reg_data)
begin

  NextState=CurrentState;
  ren=1'b1; //always read from the memory 
  wen=1'b0; //write only when Tx_WR 
  Tx_BUSY=1'b0;
  TxD=1'b1; //when nothing is sending then the channel is 1
  parity = reg_data[0]^reg_data[1]^reg_data[2]^reg_data[3]^reg_data[4]^reg_data[5]^reg_data[6]^reg_data[7];

  case(CurrentState)
    State_beforeStart:
    begin
      Tx_BUSY=1'b0;
      if(Tx_EN && Tx_WR)
      begin
        NextState=State_write_mem;
       end
    end
    State_write_mem:
    begin
    
      ren=1'b0; //in order to write to the memory read must be zero 
      wen=1'b1; //write to the memory
      NextState=State_start;
    end
    
    State_start:
    begin
      Tx_BUSY=1'b1; //starting the transmittion busy=1
      TxD=1'b0; //starting bit is zero 
      if(reg_enable!=enable && enable==1'b1)  //this is for making mine signal "posedge"
        NextState=State_firstdata;

    end
    State_firstdata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[0]; //send the least significant bit first 
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_seconddata;
    end
    
    State_seconddata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[1]; //send the 8bit data
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_thirddata;
    end
    
    State_thirddata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[2]; //send the 8bit data
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_fourthdata;
    end
    
    State_fourthdata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[3]; //send the 8bit data
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_fifthdata;
    end
    
    State_fifthdata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[4]; //send the 8bit data
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_sixdata;
    end
    
    State_sixdata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[5]; //send the 8bit data
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_sevendata;
    end
    
    State_sevendata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[6]; //send the 8bit data
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_eightdata;
    end
    
    State_eightdata:
    begin
      ren=1'b1;
      Tx_BUSY=1'b1;
      TxD=reg_data[7]; //send the 8bit data
      if(reg_enable!=enable && enable==1'b1) //posedge enable 
        NextState=State_parity;
    end
    
    State_parity: 
    begin
      TxD=parity; //send parity bit
      Tx_BUSY=1'b1;
      if(reg_enable!=enable && enable==1'b1)
      begin
        NextState=State_stop;
      end
    end
    
    State_stop:
    begin
      Tx_BUSY=1'b1; 
      TxD=1'b1; //send stop bit=1
      if(reg_enable!=enable && enable==1'b1)
      begin
        NextState=State_beforeStart;
      end
    end
    default:
    begin
      TxD=1'bx;
      NextState=State_beforeStart;

    end

  endcase
  
end


//flip flop keeping the previous state of the enable
always@(posedge clk)
begin
    reg_enable <= enable;
end

//instantiation for the counter
counter counter_inst(clk,reset,Tx_sample_ENABLE,Tx_BUSY,enable);

//instatiation of the baud controller
baud_controller baud_controller_inst(reset,clk,baud_select,Tx_sample_ENABLE);

//instatiation for the memory for keeping the Tx_DATA in reg_data
Memory_transmitter Memory_transmitter_inst(clk,ren,wen,Tx_DATA,reg_data);


endmodule