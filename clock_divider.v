module clock_divider(
    input clk,        // 100 MHz clock from Basys3
    input reset,      // asynchronous reset
    output reg clk_out
);

// Counter to divide 100 MHz clock
reg [25:0] count;    // 26-bit counter can count up to ~67M

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        count <= 0;       // reset counter
        clk_out <= 0;     // reset output clock
    end
    else
    begin
        if(count == 49_999_999)   // 0.5 sec delay for 2 Hz blink
        begin
            clk_out <= ~clk_out;  // toggle slow clock
            count <= 0;           // restart counting
        end
        else
            count <= count + 1;   // increment counter
    end
end

endmodule
