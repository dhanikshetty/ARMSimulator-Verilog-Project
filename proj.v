module mux4x4 (input wire i1,i2,i3,i4, input wire j0, j1, output wire o);
	wire  t0, t1;
	mux2 mux2_0 (i1, i2, j1, t0);
	mux2 mux2_1 (i3, i4, j1, t1);
	mux2 mux2_2 (t0, t1, j0, o);
endmodule

module left_shifter(input wire [0:3]a,input wire [0:1]s,output wire [0:3]b);
	wire [0:3]w;
	wire f;
	assign f=1'b0;
	mux2 m1(a[3],f,s[0],w[3]);
	mux2 m2(a[2],f,s[0],w[2]);
	mux2 m3(a[1],a[3],s[0],w[1]);
	mux2 m4(a[0],a[2],s[0],w[0]);
	mux2 m5(w[3],f,s[1],b[3]);
	mux2 m6(w[2],w[3],s[1],b[2]);
	mux2 m7(w[1],w[2],s[1],b[1]);
	mux2 m8(w[0],w[1],s[1],b[0]);
endmodule

module right_shifter(input wire [0:3]a,input wire [0:1]s,output wire [0:3]b);
	wire w[0:3];
	wire f;
	assign f=1'b0;
	mux2 m1(a[3],a[1],s[0],w[3]);
	mux2 m2(a[2],a[0],s[0],w[2]);
	mux2 m3(a[1],f,s[0],w[1]);
	mux2 m4(a[0],f,s[0],w[0]);
	mux2 m5(w[3],a[2],s[1],b[3]);
	mux2 m6(w[2],a[1],s[1],b[2]);
	mux2 m7(w[1],a[0],s[1],b[1]);
	mux2 m8(w[0],f,s[1],b[0]);
endmodule

module compliment(input wire [0:3]a,output wire [0:3]b);
	not(b[0],a[0]);
	not(b[1],a[1]);
	not(b[2],a[2]);
	not(b[3],a[3]);
endmodule

module register(input wire clk,reset,load,input wire [0:3]in,output wire [0:3]out);
	dfrl m1(clk,reset,load,in[0],out[0]);
	dfrl m2(clk,reset,load,in[1],out[1]);
	dfrl m3(clk,reset,load,in[2],out[2]);
	dfrl m4(clk,reset,load,in[3],out[3]);
endmodule

module process(input wire [0:3]a,input wire [0:1]s,input wire [0:1]s1,output wire [0:3]b);
	wire [0:3]x;wire [0:3]y;wire [0:3]z;
	left_shifter m11(a,s1,x);
	right_shifter m12(a,s1,y);
	compliment m13(a,z);
	mux4x4 m1(a[0],z[0],y[0],x[0],s[0],s[1],b[0]); //here b0,b1,b2,b3 is the out which comes in the gtkwave
	mux4x4 m2(a[1],z[1],y[1],x[1],s[0],s[1],b[1]);
	mux4x4 m3(a[2],z[2],y[2],x[2],s[0],s[1],b[2]);
	mux4x4 m4(a[3],z[3],y[3],x[3],s[0],s[1],b[3]);
endmodule

module ddco_project(input wire clk,reset,load,input wire [0:3]in,input wire [0:1]ch,input wire [0:1]sh,input wire rg,output wire [0:3]out);
	wire [0:3]x;wire [0:3]y;
	mux2 m1(in[0],out[0],rg,x[0]);
	mux2 m2(in[1],out[1],rg,x[1]);
	mux2 m3(in[2],out[2],rg,x[2]);
	mux2 m4(in[3],out[3],rg,x[3]);
	register m6(clk,reset,load,x,y);
	process m5(y,ch,sh,out);
endmodule