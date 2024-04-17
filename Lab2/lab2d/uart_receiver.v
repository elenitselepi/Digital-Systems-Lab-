//Receiver module . The receiver samples x16 times more than the transmitter in the middle of the sent data
//Author Tselepi Eleni

module uart_receiver(reset,clk,Rx_DATA,baud_select,Rx_EN,RxD,Rx_FERROR,Rx_PERROR,Rx_VALID);

input reset,clk;
input [2:0] baud_select;
input Rx_EN; //the receiver is on
input RxD; //the input sent from the system or the transmitter

output reg [7:0] Rx_DATA; //output data given 
output reg Rx_FERROR; //Framing error when 1 
output reg Rx_PERROR; //parity error when 1 
output reg  Rx_VALID; //Rx_DATA is valid 

wire Rx_sample_ENABLE; //the output of the baud controller

reg [3:0] CurrentState;
reg [3:0] NextState;
reg FF_RxD ,final_RxD; //2 regs used for sycronize the RxD.
reg parity; //register keeping the parity we count
reg reg_enable_sixteen , reg_enable_twentyfour; //the enable after the flip flop
reg flag_startbit,flag_data,flag_afterdata; //flags showing in which state the fsm is
wire enable_sixteen,enable_twentyfour; //when counting has finished enable is one 
wire [7:0] shift_reg; //help register that keeps the shifting
wire [7:0] reg_DATA;//keep the Rx_DATA until the next Rx_DATA
wire [3:0] sixteen_counter;//the counter used in the module sixteen_counter 

parameter State_beforeStart=4'b0000,
          State_start=4'b0001,
          State_firstdata=4'b0010,
          State_seconddata=4'b0011,
          State_thirddata=4'b0100,
          State_fourthdata=4'b0101,
          State_fifthdata=4'b0110,
          State_sixdata=4'b0111,
          State_sevendata=4'b1000,
          State_eightdata=4'b1001,  
          State_parity=4'b1010,
          State_wrong_parity=4'b1011,
          State_stop=4'b1100,
          State_wrong_stop=4'b1101,
          State_send_data=4'b1110;


//sychronize the input RxD with 2 Flip Flops to avoid metastability
always@(posedge clk)
begin
  FF_RxD <= RxD;
  final_RxD <=FF_RxD;
end

//sequential always block counting the CurrentState of the FSM 
always@(posedge clk or posedge reset)
begin
  if(reset)
    CurrentState <= State_beforeStart;
  else
    CurrentState <= NextState;
end

//Combinational always block counting the output and the NextState of the FSM 
always@(CurrentState or Rx_EN or enable_twentyfour or reg_enable_twentyfour or enable_sixteen or reg_enable_sixteen or final_RxD or reg_DATA or shift_reg or sixteen_counter)
begin
  NextState=CurrentState;
  Rx_FERROR = 1'b0;
  Rx_PERROR = 1'b0;
  Rx_VALID = 1'b0;
  Rx_DATA=reg_DATA;
  flag_startbit='d0; //the flag of the
  flag_data='d0;
  flag_afterdata='d0;
  parity=shift_reg[0]^shift_reg[1]^shift_reg[2]^shift_reg[3]^shift_reg[4]^shift_reg[5]^shift_reg[6]^shift_reg[7];

  case(CurrentState)
  
    State_beforeStart:
    begin
    
      if( Rx_EN && final_RxD==1'b0 ) //if Receiver is on and Startbit has been sent then go to State_start
      begin
        NextState=State_start;
      end
    end
    
    State_start:  
    begin
      
      flag_startbit=1'b1; //start the 24counter
      if(reg_enable_twentyfour!=enable_twentyfour && enable_twentyfour==1'b1) //this checks the "posedge" of mine signal enable coming from the counter
      begin
        NextState=State_firstdata;
      end
    end
    State_firstdata:
    begin
      
      flag_data=1'b1; //the start for the 16counter
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_seconddata;

    end
    State_seconddata:
    begin
   
      flag_data=1'b1;
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_thirddata;

    end
    State_thirddata:
    begin
    
      flag_data=1'b1;
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_fourthdata;
    end
    State_fourthdata:
    begin
        
      flag_data=1'b1;
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_fifthdata;
    end
    State_fifthdata:
    begin
         
      flag_data=1'b1;
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_sixdata;
    end
    State_sixdata:
    begin
        
      flag_data=1'b1;
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_sevendata;
    end
    State_sevendata:
    begin
   
      flag_data=1'b1;
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_eightdata;
    end
    State_eightdata:
    begin
  
      flag_data=1'b1;
      if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
        NextState=State_parity;
    end
    State_parity:
    begin
      
      flag_afterdata=1'b1;
      if(final_RxD!=parity && sixteen_counter=='d0 && flag_afterdata)   //we have parity error
      begin
        NextState=State_wrong_parity; //this is moore that why there is a state wrong_parity
      end
      else
      begin
        if(reg_enable_sixteen!=enable_sixteen && enable_sixteen==1'b1)
          NextState=State_stop;
      end

    end
    State_wrong_parity:  //the state for making Rx_Perror=1
    begin
    
      Rx_PERROR=1'b1;
      NextState=State_beforeStart; //start from the beggining
    end
    State_stop:
    begin    
      if(final_RxD!=1'b1) //stop signal has not come
        NextState=State_wrong_stop;
      else
      begin
        NextState=State_send_data;
      end
      
    end
    State_wrong_stop:    //the state fro making Rx_Ferror=1
    begin
    
       Rx_FERROR=1'b1;
       NextState=State_beforeStart; 
    end
    
    State_send_data: //make valid 1 and Rx_DATA has the shifted bits that have been sampled
    begin
    
        Rx_VALID=1'b1;
        Rx_DATA=shift_reg;
        NextState=State_beforeStart;
    
    end

    default:
    begin
      Rx_DATA=8'bx;
      NextState=State_beforeStart;
    end

  endcase
end

//flip flop keeping the previous state of the siganl enable_twentyfour
always@(posedge clk)
begin
    reg_enable_twentyfour <= enable_twentyfour;
end

//flip flop keeping the previous state of the siganl enable_sixteen
always@(posedge clk)
begin
    reg_enable_sixteen <= enable_sixteen;
end

sixteen_counter sixteen_counter_inst(clk,reset,Rx_sample_ENABLE,flag_data,flag_afterdata,enable_sixteen,sixteen_counter); //instantiation of the 16 counter

twentyfour_counter twentyfour_counter_inst(clk,reset,Rx_sample_ENABLE,flag_startbit,enable_twentyfour); //instantiation of the 24four counter

Memory Memory_inst(clk,Rx_VALID,Rx_DATA,reg_DATA); //instantiaton of the memory for keeping the Rx_DATA until the next Valid=1

shifter shifter_inst(clk,final_RxD,sixteen_counter,Rx_sample_ENABLE,flag_data,shift_reg); //shifter instantiaton

baud_controller baud_controller_rx_inst(reset,clk,baud_select,Rx_sample_ENABLE); //baud controller instantiation


endmodule