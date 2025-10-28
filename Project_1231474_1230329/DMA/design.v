// Saifeddin Saleh 1231474
// Omar Shobaki 1230329 
module dma_controller(clk,rstn,start,start_address,transfer_size,done,uart_re,uart_data,mem_we,mem_wr_addr,mem_wr_data);
input clk,rstn,start;
input [3:0]start_address;
input [4:0]transfer_size;
input [7:0]uart_data;
output reg done,uart_re,mem_we;
output reg [3:0]mem_wr_addr;
output reg [7:0]mem_wr_data;
reg [1:0]state,next_state;
reg [4:0]bytes_left;
reg [3:0]addr_ptr;
localparam IDLE=2'b00,READ_UART=2'b01,WRITE_MEM=2'b10;
always@(posedge clk or negedge rstn)begin
 if(!rstn)state<=IDLE;else state<=next_state;
end
always@(posedge clk or negedge rstn)begin
 if(!rstn)begin
  uart_re<=0;
  mem_we<=0;
  done<=0;
  bytes_left<=0;
  addr_ptr<=0;
  mem_wr_addr<=0;
  mem_wr_data<=0;
  next_state<=IDLE;
 end else begin
  uart_re<=0;
  mem_we<=0;
  done<=0;
  case(state)
   IDLE:begin
    if(start)begin 
      bytes_left<=transfer_size;
      addr_ptr<=start_address;
      next_state<=READ_UART;
    end 
     else next_state<=IDLE;
   end
   READ_UART:begin
    uart_re<=1;
    next_state<=WRITE_MEM;
   end
   WRITE_MEM:begin
    mem_we<=1;
    mem_wr_addr<=addr_ptr;
    mem_wr_data<=uart_data;
    addr_ptr<=addr_ptr+1;
    bytes_left<=bytes_left-1;
    if(bytes_left==1)begin 
     done<=1;
     next_state<=IDLE;
    end 
     else next_state<=READ_UART;
   end
   default:next_state<=IDLE;
  endcase
 end
end
endmodule
module memory(clk, rstn, write_address, data_in, we, read_address, data_out, re);
  input clk, rstn, we, re;
  input [7:0] data_in;
  input [3:0]  write_address, read_address;
  output reg [7:0] data_out;
  reg [7:0] memor [15:0];
  always @(posedge clk or negedge rstn)begin
    if(~rstn) begin
      data_out <= 8'b0;
    end
    else begin 
      if(we) memor[write_address] <= data_in; 
    if(re) data_out <= memor[read_address]; 
    	end
	end
endmodule
module UART(clk, rstn, re, Data_out);
  input clk, rstn, re;
  output reg [7:0] Data_out;
  reg [7:0] buffer [15:0];      
  reg [3:0] index;           
  reg re_delay;
  always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      index <= 0;
      Data_out <= 0;
      re_delay <= 0;
      buffer[0] <= 8'hA1; 
      buffer[1] <= 8'hB2; 
      buffer[2] <= 8'hC3; 
      buffer[3] <= 8'hD4;
      buffer[4] <= 8'hE5; 
      buffer[5] <= 8'hF6; 
      buffer[6] <= 8'h07; 
      buffer[7] <= 8'h18;
      buffer[8] <= 8'h29; 
      buffer[9] <= 8'h3A; 
      buffer[10] <= 8'h4B; 
      buffer[11] <= 8'h5C;
      buffer[12] <= 8'h6D; 
      buffer[13] <= 8'h7E; 
      buffer[14] <= 8'h8F; 
      buffer[15] <= 8'h90;
    end 
    else begin
      re_delay <= re; 
      if (re_delay) begin
        Data_out <= buffer[index];
        index <= index+1;
      end
    end
  end
endmodule

