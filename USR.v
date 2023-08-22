D FLIPFLOP
module d_flipflop(q,rst,d,clk);
input clk,d,rst;
output reg q;
always @(posedge clk)
begin
if (rst == 1 )
q=0;
else
q=d;
end
endmodule


4 × 1 MUX
module mux_4x1(out,s,in3, in2, in1, in0);
input in0, in1, in2, in3;
input [1:0] s;
output out;
//s1 s0
//0 0 - in0 feedback input of the same dff
//0 1 - in1 get right shift data from left input
//1 0 - in2 get left shft data from right input

//1 1 - in3 get 4bit parallel inputs
assign out = s[1] ? (s[0] ? in3 : in2) : (s[0] ? in1 : in0);
endmodule

One-bit Shift register
module onebit_uni(clk,rst,o ,s,x,y,z,w);
input x,y,z,w;
input [1:0] s;
wire o1;
//Inputs and Outputs for D flipflop in one bit module
input clk,rst;
output o; //1 bit output
mux_4x1 f1b(o1, s, x, y, z, w);
d_flipflop d1b(clk,rst,o1,o);
endmodule
Universal Shift register
module univShiftReg(clk, rst, l, r, s, d, q);
input clk,rst,l,r;
input [3:0] d; // 4 bit Inputs
input [1:0] s; // 2 bit selection lines for 4x1 mux
output [3:0] q; // 4 bit Outputs
o1bituniv b0(clk, rst, q[0], s, d[0], q[1], r, q[0]);
o1bituniv b1(clk, rst, q[1], s, d[1], q[2], q[0], q[1]);
o1bituniv b2(clk, rst, q[2], s, d[2], q[3], q[1], q[2]);
o1bituniv b3(clk, rst, q[3], s, d[3], l, q[2], q[3]);
endmodule
