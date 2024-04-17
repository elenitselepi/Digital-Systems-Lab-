//Top Level module from connecting transmitter with receiver

module uart(reset,clk,Tx_DATA,baud_select,Tx_WR,Tx_EN,Rx_EN,Rx_DATA,Rx_FERROR,Rx_PERROR,Rx_VALID,TxD,Tx_BUSY);

input clk,reset;
input [2:0] baud_select;
input [7:0] Tx_DATA;
input Tx_EN,Tx_WR,Rx_EN;

output TxD,Tx_BUSY,Rx_PERROR,Rx_FERROR,Rx_VALID;

output [7:0] Rx_DATA;


//instantiation of the transmitter
uart_transmitter uart_transmitter_inst(reset,clk,Tx_DATA,baud_select,Tx_WR,Tx_EN,TxD,Tx_BUSY);

//instantiation of the receiver
uart_receiver uart_receiver_inst(reset,clk,Rx_DATA,baud_select,Rx_EN,TxD,Rx_FERROR,Rx_PERROR,Rx_VALID);


endmodule