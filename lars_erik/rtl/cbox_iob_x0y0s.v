// Automatically generated by PRGA's RTL generator
module cbox_iob_x0y0s (
    output wire [0:0] blkp_iob_x0y0_0_outpad,
    input wire [19:0] cbi_L1_x0v1e,
    input wire [19:0] cbi_L1_x0v1w,
    output wire [0:0] blkp_iob_x0y0_1_outpad,
    output wire [0:0] blkp_iob_x0y0_2_outpad,
    output wire [0:0] blkp_iob_x0y0_3_outpad,
    output wire [0:0] blkp_iob_x0y0_4_outpad,
    output wire [0:0] blkp_iob_x0y0_5_outpad,
    output wire [0:0] blkp_iob_x0y0_6_outpad,
    output wire [0:0] blkp_iob_x0y0_7_outpad,
    output wire [0:0] blkp_iob_x0y0_8_outpad,
    output wire [0:0] blkp_iob_x0y0_9_outpad,
    input wire [0:0] blkp_iob_x0y0_0_inpad,
    output wire [19:0] cbo_L1_x0v1e,
    output wire [19:0] cbo_L1_x0v1w,
    input wire [0:0] blkp_iob_x0y0_1_inpad,
    input wire [0:0] blkp_iob_x0y0_2_inpad,
    input wire [0:0] blkp_iob_x0y0_3_inpad,
    input wire [0:0] blkp_iob_x0y0_4_inpad,
    input wire [0:0] blkp_iob_x0y0_5_inpad,
    input wire [0:0] blkp_iob_x0y0_6_inpad,
    input wire [0:0] blkp_iob_x0y0_7_inpad,
    input wire [0:0] blkp_iob_x0y0_8_inpad,
    input wire [0:0] blkp_iob_x0y0_9_inpad,
    input wire [39:0] cfg_d
    );
    
    wire [0:0] sw_blkp_iob_x0y0_0_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_1_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_2_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_3_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_4_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_5_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_6_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_7_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_8_outpad_0__o;
    wire [0:0] sw_blkp_iob_x0y0_9_outpad_0__o;
    
    cfg_mux10 sw_blkp_iob_x0y0_0_outpad_0 (
        .i({cbi_L1_x0v1w[8], cbi_L1_x0v1e[8], cbi_L1_x0v1w[6], cbi_L1_x0v1e[6], cbi_L1_x0v1w[4], cbi_L1_x0v1e[4], cbi_L1_x0v1w[2], cbi_L1_x0v1e[2], cbi_L1_x0v1w[0], cbi_L1_x0v1e[0]}),
        .o(sw_blkp_iob_x0y0_0_outpad_0__o),
        .cfg_d(cfg_d[3:0])
        );
    cfg_mux10 sw_blkp_iob_x0y0_1_outpad_0 (
        .i({cbi_L1_x0v1w[12], cbi_L1_x0v1e[12], cbi_L1_x0v1w[10], cbi_L1_x0v1e[10], cbi_L1_x0v1w[8], cbi_L1_x0v1e[8], cbi_L1_x0v1w[6], cbi_L1_x0v1e[6], cbi_L1_x0v1w[4], cbi_L1_x0v1e[4]}),
        .o(sw_blkp_iob_x0y0_1_outpad_0__o),
        .cfg_d(cfg_d[7:4])
        );
    cfg_mux10 sw_blkp_iob_x0y0_2_outpad_0 (
        .i({cbi_L1_x0v1w[16], cbi_L1_x0v1e[16], cbi_L1_x0v1w[14], cbi_L1_x0v1e[14], cbi_L1_x0v1w[12], cbi_L1_x0v1e[12], cbi_L1_x0v1w[10], cbi_L1_x0v1e[10], cbi_L1_x0v1w[8], cbi_L1_x0v1e[8]}),
        .o(sw_blkp_iob_x0y0_2_outpad_0__o),
        .cfg_d(cfg_d[11:8])
        );
    cfg_mux10 sw_blkp_iob_x0y0_3_outpad_0 (
        .i({cbi_L1_x0v1w[1], cbi_L1_x0v1e[1], cbi_L1_x0v1w[18], cbi_L1_x0v1e[18], cbi_L1_x0v1w[16], cbi_L1_x0v1e[16], cbi_L1_x0v1w[14], cbi_L1_x0v1e[14], cbi_L1_x0v1w[12], cbi_L1_x0v1e[12]}),
        .o(sw_blkp_iob_x0y0_3_outpad_0__o),
        .cfg_d(cfg_d[15:12])
        );
    cfg_mux10 sw_blkp_iob_x0y0_4_outpad_0 (
        .i({cbi_L1_x0v1w[5], cbi_L1_x0v1e[5], cbi_L1_x0v1w[3], cbi_L1_x0v1e[3], cbi_L1_x0v1w[1], cbi_L1_x0v1e[1], cbi_L1_x0v1w[18], cbi_L1_x0v1e[18], cbi_L1_x0v1w[16], cbi_L1_x0v1e[16]}),
        .o(sw_blkp_iob_x0y0_4_outpad_0__o),
        .cfg_d(cfg_d[19:16])
        );
    cfg_mux10 sw_blkp_iob_x0y0_5_outpad_0 (
        .i({cbi_L1_x0v1w[9], cbi_L1_x0v1e[9], cbi_L1_x0v1w[7], cbi_L1_x0v1e[7], cbi_L1_x0v1w[5], cbi_L1_x0v1e[5], cbi_L1_x0v1w[3], cbi_L1_x0v1e[3], cbi_L1_x0v1w[1], cbi_L1_x0v1e[1]}),
        .o(sw_blkp_iob_x0y0_5_outpad_0__o),
        .cfg_d(cfg_d[23:20])
        );
    cfg_mux10 sw_blkp_iob_x0y0_6_outpad_0 (
        .i({cbi_L1_x0v1w[13], cbi_L1_x0v1e[13], cbi_L1_x0v1w[11], cbi_L1_x0v1e[11], cbi_L1_x0v1w[9], cbi_L1_x0v1e[9], cbi_L1_x0v1w[7], cbi_L1_x0v1e[7], cbi_L1_x0v1w[5], cbi_L1_x0v1e[5]}),
        .o(sw_blkp_iob_x0y0_6_outpad_0__o),
        .cfg_d(cfg_d[27:24])
        );
    cfg_mux10 sw_blkp_iob_x0y0_7_outpad_0 (
        .i({cbi_L1_x0v1w[17], cbi_L1_x0v1e[17], cbi_L1_x0v1w[15], cbi_L1_x0v1e[15], cbi_L1_x0v1w[13], cbi_L1_x0v1e[13], cbi_L1_x0v1w[11], cbi_L1_x0v1e[11], cbi_L1_x0v1w[9], cbi_L1_x0v1e[9]}),
        .o(sw_blkp_iob_x0y0_7_outpad_0__o),
        .cfg_d(cfg_d[31:28])
        );
    cfg_mux10 sw_blkp_iob_x0y0_8_outpad_0 (
        .i({cbi_L1_x0v1w[2], cbi_L1_x0v1e[2], cbi_L1_x0v1w[19], cbi_L1_x0v1e[19], cbi_L1_x0v1w[17], cbi_L1_x0v1e[17], cbi_L1_x0v1w[15], cbi_L1_x0v1e[15], cbi_L1_x0v1w[13], cbi_L1_x0v1e[13]}),
        .o(sw_blkp_iob_x0y0_8_outpad_0__o),
        .cfg_d(cfg_d[35:32])
        );
    cfg_mux10 sw_blkp_iob_x0y0_9_outpad_0 (
        .i({cbi_L1_x0v1w[6], cbi_L1_x0v1e[6], cbi_L1_x0v1w[4], cbi_L1_x0v1e[4], cbi_L1_x0v1w[2], cbi_L1_x0v1e[2], cbi_L1_x0v1w[19], cbi_L1_x0v1e[19], cbi_L1_x0v1w[17], cbi_L1_x0v1e[17]}),
        .o(sw_blkp_iob_x0y0_9_outpad_0__o),
        .cfg_d(cfg_d[39:36])
        );
    
    assign blkp_iob_x0y0_0_outpad = sw_blkp_iob_x0y0_0_outpad_0__o;
    assign blkp_iob_x0y0_1_outpad = sw_blkp_iob_x0y0_1_outpad_0__o;
    assign blkp_iob_x0y0_2_outpad = sw_blkp_iob_x0y0_2_outpad_0__o;
    assign blkp_iob_x0y0_3_outpad = sw_blkp_iob_x0y0_3_outpad_0__o;
    assign blkp_iob_x0y0_4_outpad = sw_blkp_iob_x0y0_4_outpad_0__o;
    assign blkp_iob_x0y0_5_outpad = sw_blkp_iob_x0y0_5_outpad_0__o;
    assign blkp_iob_x0y0_6_outpad = sw_blkp_iob_x0y0_6_outpad_0__o;
    assign blkp_iob_x0y0_7_outpad = sw_blkp_iob_x0y0_7_outpad_0__o;
    assign blkp_iob_x0y0_8_outpad = sw_blkp_iob_x0y0_8_outpad_0__o;
    assign blkp_iob_x0y0_9_outpad = sw_blkp_iob_x0y0_9_outpad_0__o;
    assign cbo_L1_x0v1e = {blkp_iob_x0y0_9_inpad, blkp_iob_x0y0_7_inpad, blkp_iob_x0y0_5_inpad, blkp_iob_x0y0_3_inpad, blkp_iob_x0y0_1_inpad, blkp_iob_x0y0_9_inpad, blkp_iob_x0y0_7_inpad, blkp_iob_x0y0_5_inpad, blkp_iob_x0y0_3_inpad, blkp_iob_x0y0_1_inpad, blkp_iob_x0y0_8_inpad, blkp_iob_x0y0_6_inpad, blkp_iob_x0y0_4_inpad, blkp_iob_x0y0_2_inpad, blkp_iob_x0y0_0_inpad, blkp_iob_x0y0_8_inpad, blkp_iob_x0y0_6_inpad, blkp_iob_x0y0_4_inpad, blkp_iob_x0y0_2_inpad, blkp_iob_x0y0_0_inpad};
    assign cbo_L1_x0v1w = {blkp_iob_x0y0_9_inpad, blkp_iob_x0y0_7_inpad, blkp_iob_x0y0_5_inpad, blkp_iob_x0y0_3_inpad, blkp_iob_x0y0_1_inpad, blkp_iob_x0y0_9_inpad, blkp_iob_x0y0_7_inpad, blkp_iob_x0y0_5_inpad, blkp_iob_x0y0_3_inpad, blkp_iob_x0y0_1_inpad, blkp_iob_x0y0_8_inpad, blkp_iob_x0y0_6_inpad, blkp_iob_x0y0_4_inpad, blkp_iob_x0y0_2_inpad, blkp_iob_x0y0_0_inpad, blkp_iob_x0y0_8_inpad, blkp_iob_x0y0_6_inpad, blkp_iob_x0y0_4_inpad, blkp_iob_x0y0_2_inpad, blkp_iob_x0y0_0_inpad};

endmodule
