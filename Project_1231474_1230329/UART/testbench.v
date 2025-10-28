//Saifeddin Saleh 1231474
//Omar Shobaki 1230329
module tb_UART;
reg clk,rstn,re;
wire[7:0] Data_out;
UART uart(.clk(clk),.rstn(rstn),.re(re),.Data_out(Data_out));
always #5 clk=~clk;
initial begin
 $dumpfile("uart.vcd");
 $dumpvars(0,tb_UART);
 clk=0;rstn=0;re=0;
 #12 rstn=1;
 @(posedge clk);
 repeat(16) begin
  @(posedge clk);re=1;
  @(posedge clk);re=0;
  $display("Data_out = 0x%0h",Data_out);
  @(posedge clk);
 end
 #10 $finish;
end
endmodule