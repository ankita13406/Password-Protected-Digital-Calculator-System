module blink_generator(
    input clk,
    input invalid,
    output reg blink_led
);

// toggle LED when invalid operation occurs
always @(posedge clk)
begin
    if(invalid)
        blink_led <= ~blink_led;
    else
        blink_led <= 0;
end

endmodule
