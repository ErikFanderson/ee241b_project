// Automatically generated by PRGA's RTL generator
module cfg_mux3 (
    input wire [2:0] i,
    output reg [0:0] o,
    input wire [1:0] cfg_d
    );

    always @* begin
        o = 1'b0;
        case (cfg_d)    // synopsys infer_mux
            2'd0: o = i[0];
            2'd1: o = i[1];
            2'd2: o = i[2];
        endcase
    end

endmodule
