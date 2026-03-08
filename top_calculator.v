module top_calculator(
    input clk,                // System clock from FPGA
    input reset,              // Asynchronous reset
    input S1, S2, S3,         // Push buttons for password
    input [3:0] a,            // Operand A
    input [3:0] b,            // Operand B
    input [1:0] m,            // Mode select

    output [7:0] y,           // Arithmetic result
    output active_led,        // Indicates calculator unlocked
    output error_led,         // Indicates wrong password
    output invalid_led        // Blinking LED for invalid operation
);

wire unlocked;                // Signal from FSM when correct password entered
wire error;                   // Error signal from FSM
wire invalid;                 // Invalid mode signal
wire blink_clk;               // Slow clock for LED blinking

// Instantiate lock FSM
lock_fsm FSM(
    .clk(clk),
    .reset(reset),
    .S1(S1),
    .S2(S2),
    .S3(S3),
    .unlocked(unlocked),
    .error(error)
);

// Arithmetic block
arithmetic_unit AU(
    .a(a),
    .b(b),
    .m(m),
    .enable(unlocked),
    .y(y),
    .invalid(invalid)
);

// Clock divider for blinking LED
clock_divider CD(
    .clk(clk),
    .reset(reset),
    .clk_out(blink_clk)
);

// Blink generator
blink_generator BG(
    .clk(blink_clk),
    .invalid(invalid),
    .blink_led(invalid_led)
);

// LED assignments
assign active_led = unlocked;     // Active LED when unlocked
assign error_led  = error;        // Error LED when wrong sequence

endmodule
