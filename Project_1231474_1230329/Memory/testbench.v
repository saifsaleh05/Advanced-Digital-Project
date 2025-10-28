// Saifeddin Saleh 1231474 
// Omar Shobaki 1230329
module tb_memory;
reg clk,rstn,we,re;
reg [7:0]data_in;
reg [3:0]write_address,read_address;
wire[7:0]data_out;
memory m(clk,rstn,write_address,data_in,we,read_address,data_out,re);
always #5 clk=~clk;
initial begin
 $dumpfile("mem.vcd");
 $dumpvars(0,tb_memory);
 clk=0;rstn=0;we=0;re=0;
 #10 rstn=1;
 we=1;
 write_address=0;
 data_in=8'hA1;#10;
 write_address=1;
 data_in=8'hB2;#10;
 write_address=2;
 data_in=8'hC3;#10;
 we=0;re=1;
 read_address=0;#10;
 $display("addr0=%h",data_out);
 read_address=1;#10;
 $display("addr1=%h",data_out);
 read_address=2;#10;
 $display("addr2=%h",data_out);
 #10 $finish;
end
endmodule
