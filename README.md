# DDCO-4-bit-register
A 4-bit register designed using 4 D-flip flops and  4 4:1 multiplexers with mode selection input s0 and s1

## To Rum
go to the project directory
  ```zsh
    iverilog -o test lib_main.v proj.v tb_project.v
    
    vvp test
    
    gtkwave proj.vcd
  ```


open the vcd file in armsimulator to test for different inputs.
