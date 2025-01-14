# https://emkboruett.medium.com/installing-icarus-verilog-and-gtkwave-on-ubuntu-for-verilog-simulation-d6d31eee2096
# https://www.mankier.com/1/vvp

sudo apt update
sudo apt install iverilog
sudo apt install gtkwave


cat << EOF > multiplexer_2_1.v
module multiplexer_2_1(
  input a,
  input b,
  input select,
  output y
);

assign y = (select)?b:a;
endmodule
EOF

cat << "EOF" > multiplexer_2_1_tb.v
`timescale 1ns/100ps 
module multiplexer_2_1_tb;

 //inputs
 reg a, b, select;
 //outputs
 wire y;

 multiplexer_2_1 u0_DUT(
  .a(a),
  .b(b),
  .select(select),
  .y(y)
 );

 //initialize inputs

 initial begin
//simulation files dumped to the test_2_1mux file
  $dumpfile("test_2_1mux.vcd");
  $dumpvars(0,multiplexer_2_1_tb);
  a=1'b0;b=1'b0; select=1'b0;
  #5 a=1'b1; 
  #5 select = 1'b1;
  #5 b=1'b1;
  #5 a=1'b0;
  #5 $finish;
 end
endmodule
EOF

cat << EOF > run
[ -f /usr/lib/x86_64-linux-gnu/ivl/myhdl.vpi ] && echo == myHDL myhdl.vpi installed. || echo == myHDL myhdl.vpi not installed.

# myHDL setup example: ln -fs /mnt/d/docker_home/myhdl.00/myhdl/cosimulation/icarus/myhdl.vpi /usr/lib/x86_64-linux-gnu/ivl/myhdl.vpi

iverilog -o mux_wave_2_1 multiplexer_2_1.v multiplexer_2_1_tb.v
vvp mux_wave_2_1       ;# dumping VCD
vvp mux_wave_2_1 -lxt2 ;# dumping VCD and compressed into LXT2
vvp mux_wave_2_1 -none ;# dumping is suppressed
EOF

chmod u+x ./run
./run


