module top_calculator(
    input CLK100MHZ,          // 100 MHz clock from Basys3
    input btnC,               // reset button
    input btnU,               // S1 button
    input btnL,               // S2 button
    input btnR,               // S3 button
    input [15:0] sw,          // switches
    output [15:0] LED         // LEDs
);

// Operand and mode selection from switches
wire [3:0] a = sw[3:0];      // operand A
wire [3:0] b = sw[7:4];      // operand B
wire [1:0] m = sw[9:8];      // mode select

wire [7:0] y;                // result
wire unlocked;               // calculator active signal
wire error;                  // error signal
wire invalid;                // invalid mode signal
wire blink_clk;              // slow clock
wire blink_led;              // blinking LED signal


// Password FSM
lock_fsm FSM(
    .clk(CLK100MHZ),
    .reset(btnC),
    .S1(btnU),
    .S2(btnL),
    .S3(btnR),
    .unlocked(unlocked),
    .error(error)
);


// Arithmetic unit
arithmetic_unit AU(
    .a(a),
    .b(b),
    .m(m),
    .enable(unlocked),
    .y(y),
    .invalid(invalid)
);


// Clock divider for blinking
clock_divider CD(
    .clk(CLK100MHZ),
    .reset(btnC),
    .clk_out(blink_clk)
);


// Blink generator
blink_generator BG(
    .clk(blink_clk),
    .invalid(invalid),
    .blink_led(blink_led)
);


// LED assignments
assign LED[0] = unlocked;        // active LED
assign LED[1] = error;           // error LED
assign LED[2] = blink_led;       // blinking LED
assign LED[10:3] = y;            // result display
assign LED[15:11] = 5'b00000;    // unused LEDs off

endmodule
