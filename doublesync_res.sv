module doublesync_res(input logic [13:0] indata, input logic clk, reset, output logic [13:0] outdata);

reg [13:0] reg1 = 14'b0;
reg [13:0] reg2 = 14'b0;

always @(posedge clk or negedge reset)
begin
	 if (!reset)
	 begin
	 	reg1 <= 14'b0;
		reg2 <= 14'b0;
	 end else 
	 begin
	 	reg1 <= indata;
		reg2 <= reg1;
	 end
end

assign outdata = reg2;

endmodule
