module arithmetic_unit(
    input [3:0] a,
    input [3:0] b,
    input [1:0] m,
    input enable,

    output reg [7:0] y,
    output reg invalid
);

always @(*)
begin
    if(enable == 0)
    begin
        y = 0;            // Disable arithmetic if locked
        invalid = 0;
    end

    else
    begin
        case(m)

        2'b01:
        begin
            y = a + b;    // Perform addition
            invalid = 0;
        end

        2'b10:
        begin
            y = a * b;    // Perform multiplication
            invalid = 0;
        end

        default:
        begin
            y = 0;        // No result for invalid mode
            invalid = 1;
        end

        endcase
    end
end

endmodule
