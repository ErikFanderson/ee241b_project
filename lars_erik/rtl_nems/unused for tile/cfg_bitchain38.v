// Automatically generated by PRGA's RTL generator
module cfg_bitchain38 (
    input wire [0:0] cfg_clk,
    input wire [0:0] cfg_e,
    input wire [0:0] cfg_we,
    input wire [0:0] cfg_i,
    output reg [0:0] cfg_o,
    output reg [37:0] cfg_d
    );

    // combinational outputs
    always @* begin
        cfg_o = cfg_d[37];
    end

    always @(posedge cfg_clk) begin
        if (cfg_e && cfg_we) begin
            cfg_d <= {cfg_d, cfg_i};
        end
    end

endmodule
