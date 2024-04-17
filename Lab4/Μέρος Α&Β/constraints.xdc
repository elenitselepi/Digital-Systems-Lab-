## This file is a general .xdc for the Nexys A7-100T
### Clock Signal
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk -period 10.00 -waveform {0 5} [get_ports { clk }];

### Recording Pins
set_property -dict { PACKAGE_PIN J5 IOSTANDARD LVCMOS33 } [get_ports { micGenCLK }]; 
set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33 } [get_ports { micDataPDM }];
set_property -dict { PACKAGE_PIN F5 IOSTANDARD LVCMOS33 } [get_ports { micLRselPDM }];

##Audio Pins
set_property -dict { PACKAGE_PIN A11 IOSTANDARD LVCMOS33 } [get_ports { audDataPWM }]; 
set_property -dict { PACKAGE_PIN D12 IOSTANDARD LVCMOS33 } [get_ports { audEnPWM }]; 

### Button(s)
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports { reset }];
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports { recordEN }];
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports { playbackEN }];