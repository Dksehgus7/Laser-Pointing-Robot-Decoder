module hex_decoder(input logic [3:0] hex_code, output logic [6:0] hex_number);
    always_comb begin
        case(hex_code)
            4'd0: hex_number = 7'b1000000;
            4'd1: hex_number = 7'b1111001;
            4'd2: hex_number = 7'b0100100;
            4'd3: hex_number = 7'b0110000;
            4'd4: hex_number = 7'b0011001;
            4'd5: hex_number = 7'b0010010;
            4'd6: hex_number = 7'b0000010;
            4'd7: hex_number = 7'b1111000;
            4'd8: hex_number = 7'b0000000;
            4'd9: hex_number = 7'b0011000;
            default: hex_number = 7'b1111111;
        endcase
    end
endmodule