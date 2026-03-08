module lock_fsm(
    input clk,
    input reset,
    input S1, S2, S3,

    output reg unlocked,
    output reg error
);

// State encoding
reg [2:0] state;

parameter IDLE  = 3'b000;
parameter ST1   = 3'b001;
parameter ST2   = 3'b010;
parameter ST3   = 3'b011;
parameter UNLOCK= 3'b100;
parameter ERR   = 3'b101;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= IDLE;        // Reset system to initial state
        unlocked <= 0;
        error <= 0;
    end
    else
    begin
        case(state)

        IDLE:
        begin
            unlocked <= 0;
            error <= 0;
            if(S3) state <= ST1;     // First correct button
            else if(S1 | S2) state <= ERR;
        end

        ST1:
        begin
            if(S1) state <= ST2;     // Second correct button
            else if(S2 | S3) state <= ERR;
        end

        ST2:
        begin
            if(S2) state <= UNLOCK;  // Final correct button
            else if(S1 | S3) state <= ERR;
        end

        UNLOCK:
        begin
            unlocked <= 1;           // Calculator enabled
        end

        ERR:
        begin
            error <= 1;              // Wrong sequence detected
        end

        endcase
    end
end

endmodule
