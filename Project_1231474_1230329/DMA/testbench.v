// Saifeddin Saleh 1231474
// Omar Shobaki 1230329 
module tb_dma;
reg clk;
reg rstn;
reg start;
reg [3:0] start_address;
reg [4:0] transfer_size;
wire done;
wire uart_re;
wire mem_we;
wire [3:0] mem_wr_addr;
wire [7:0] mem_wr_data;
wire [7:0] uart_data;
reg re;
reg [3:0] read_address;
wire [7:0] data_out;
integer i;
UART u(clk, rstn, uart_re, uart_data);
memory m(clk, rstn, mem_wr_addr, mem_wr_data, mem_we, read_address, data_out, re);
dma_controller d(clk, rstn, start, start_address, transfer_size, done, uart_re, uart_data, mem_we, mem_wr_addr, mem_wr_data);
always #5 clk = ~clk;
initial begin
    $dumpfile("dma.vcd");
    $dumpvars(0, tb_dma);
    clk = 0;
    rstn = 0;
    start = 0;
    start_address = 0;
    transfer_size = 0;
    re = 0;
    read_address = 0;
    #12 rstn = 1;
    @(posedge clk);
    start_address = 4'd0;
    transfer_size = 5'd16;
    start = 1;
    @(posedge clk);
    start = 0;
    @(posedge clk);
    while (done == 0) @(posedge clk);
    re = 1;
    for (i = 0; i < 16; i = i + 1) begin
        read_address = i;
        @(posedge clk);
        $display("mem[%0d]=0x%02x", i, data_out);
    end
    #20 $finish;
end
endmodule
