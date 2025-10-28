// Saifeddin Saleh 1231474 
// Omar Shobaki 1230329
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
