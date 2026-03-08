module top_calculator(
    input CLK100MHZ,          // 100 MHz board clock
    input btnC,               // reset button
    input btnU,               // S1
    input btnL,               // S2
    input btnR,               // S3

    input [15:0] sw,          // switches

    output [15:0] LED         // board LEDs
);

// operands from switches
wire [3:0] a = sw[3:0];      // operand A
wire [3:0] b = sw[7:4];      // operand B
wire [1:0] m = sw[9:8];      // mode

wire [7:0] y;
wire unlocked;
wire error;
wire invalid;
wire blink_clk;


// FSM module
lock_fsm FSM(
    .clk(CLK100MHZ),
    .reset(btnC),
    .S1(btnU),
    .S2(btnL),
    .S3(btnR),
    .unlocked(unlocked),
    .error(error)
);


// arithmetic block
arithmetic_unit AU(
    .a(a),
    .b(b),
    .m(m),
    .enable(unlocked),
    .y(y),
    .invalid(invalid)
);


// clock divider for blinking
clock_divider CD(
    .clk(CLK100MHZ),
    .reset(btnC),
    .clk_out(blink_clk)
);


// blinking LED
blink_generator BG(
    .clk(blink_clk),
    .invalid(invalid),
    .blink_led(LED[2])
);


// LED assignments
assign LED[0] = unlocked;    // active LED
assign LED[1] = error;       // error LED
assign LED[10:3] = y;        // result display

endmodule
