//Saifeddin Saleh 1231474
//Omar Shobaki 1230329
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
