module blink_generator(
    input clk,
    input invalid,

    output reg blink_led
);

// Toggle LED for blinking
always @(posedge clk)
begin
    if(invalid)
        blink_led <= ~blink_led;  // Blink when invalid operation
    else
        blink_led <= 0;           // LED OFF otherwise
end

endmodule
