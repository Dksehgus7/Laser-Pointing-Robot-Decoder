// with two channels, there are four possible states, each state transition will increase or decease the counter to determine
// the position of the motor ie. how many degrees it has turned, and which direction the motor is turning in

// clockwise: {a,b} = 00 -> 10 -> 11 -> 01                DIRECTION OUTPUT = 1
// counterclockwise: {a,b} = 00 -> 01 -> 11 -> 10         DIRECTION OUTPUT = 0

// motor has 12 turns per rotation, gearbox ratio 1:34 --> i need to do math on how many counts to expect for one rotation
// --> 360 * 34 = 12240? --> 0.0294 degrees? 48960 for 4x sample rate?

module decoder_fsm (input logic clk, rst, a, b, 
                    output logic [31:0] turn_count, resolution, degrees, output logic direction);
reg [31:0] max = 32'd48960;

reg [31:0] counter = 32'b0;
assign turn_count = counter;
assign resolution = counter/32'd4;
assign degrees = counter/32'd136;

logic [1:0] state;
logic [1:0] next_state;
logic dir;

always_ff @(posedge clk) begin
    next_state <= {a,b};
    if (~rst) begin
        counter <= 32'b0;
        state <= 2'b00;
        dir <= 0;
    end
    else begin
        case (state) 
        2'b00: begin
            if (next_state == 2'b10) begin
                if (counter + 32'b1 >= max) begin
                    counter <= 32'b0;
                end
                else begin
                    counter <= counter + 32'b1;
                end
                dir <= 1;
                state <= next_state;
            end
            else if (next_state == 2'b01) begin
                if (counter - 32'b1 <= 0) begin
                    counter <= 32'd48959;
                end
                else begin
                    counter <= counter - 32'b1;
                end
                dir <= 0;
                state <= next_state;
            end
            else begin
                dir <= dir;
                state <= state;
            end
        end
        2'b01: begin
            if (next_state == 2'b00) begin
                if (counter + 32'b1 >= max) begin
                    counter <= 32'b0;
                end
                else begin
                    counter <= counter + 32'b1;
                end
                dir <= 1;
                state <= next_state;
            end
            else if (next_state == 2'b11) begin
                if (counter - 32'b1 <= 0) begin
                    counter <= 32'd48959;
                end
                else begin
                    counter <= counter - 32'b1;
                end
                dir <= 0;
                state <= next_state;
            end
            else begin
                dir <= dir;
                state <= state;
            end
        end
        2'b10: begin
            if (next_state == 2'b11) begin
                if (counter + 32'b1 >= max) begin
                    counter <= 32'b0;
                end
                else begin
                    counter <= counter + 32'b1;
                end
                dir <= 1;
                state <= next_state;
            end
            else if (next_state == 2'b00) begin
                if (counter - 32'b1 <= 0) begin
                    counter <= 32'd48959;
                end
                else begin
                    counter <= counter - 32'b1;
                end
                dir <= 0;
                state <= next_state;
            end
            else begin
                dir <= dir;
                state <= state;
            end
        end
        2'b11: begin
            if (next_state == 2'b01) begin
                if (counter + 32'b1 >= max) begin
                    counter <= 32'b0;
                end
                else begin
                    counter <= counter + 32'b1;
                end
                dir <= 1;
                state <= next_state;
            end
            else if (next_state == 2'b10) begin
                if (counter - 32'b1 <= 0) begin
                    counter <= 32'd48959;
                end
                else begin
                    counter <= counter - 32'b1;
                end
                dir <= 0;
                state <= next_state;
            end
            else begin
                dir <= dir;
                state <= state;
            end
        end
        default: state <= 2'b00;
        endcase
    end
end

endmodule
