module lock_fsm(
    input clk,
    input reset,
    input S1,
    input S2,
    input S3,
    output reg unlocked,
    output reg error
);

// FSM states
reg [2:0] state;

parameter IDLE   = 3'b000;
parameter ST1    = 3'b001;
parameter ST2    = 3'b010;
parameter UNLOCK = 3'b011;
parameter ERR    = 3'b100;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= IDLE;
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
            if(S3) state <= ST1;
            else if(S1 || S2) state <= ERR;
        end

        ST1:
        begin
            if(S1) state <= ST2;
            else if(S2 || S3) state <= ERR;
        end

        ST2:
        begin
            if(S2) state <= UNLOCK;
            else if(S1 || S3) state <= ERR;
        end

        UNLOCK:
        begin
            unlocked <= 1;     // calculator enabled
            state <= UNLOCK;
        end

        ERR:
        begin
            error <= 1;        // error state
            state <= ERR;
        end

        endcase
    end
end

endmodule
