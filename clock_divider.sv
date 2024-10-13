module clock_divider(input logic [31:0] divider, input logic base_clock, output logic clock);


logic [31:0] counter = 32'd0;

always_ff@(posedge base_clock) begin

  counter <= counter + 1;

  if(counter >= (divider/2)) begin
    clock <= ~clock;
    counter <= 32'b0;
  end

end

endmodule