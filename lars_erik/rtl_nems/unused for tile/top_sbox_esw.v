// Automatically generated by PRGA's RTL generator
module top_sbox_esw (
    output wire [19:0] sgmt_L1_x1y0e,
    input wire [19:0] sbir_L1_x1y0w,
    output wire [19:0] sgmt_L1_x0y0s,
    input wire [19:0] sbir_L1_x0y0n,
    output wire [19:0] sgmt_L1_x0y0w,
    input wire [19:0] sbir_L1_x0y0e,
    input wire [19:0] sbic_L1_x0y0s,
    input wire [19:0] sbic_L1_x0y0w,
    input wire [19:0] sbic_L1_x1y0e,
    input wire [117:0] cfg_d
    );
    
    wire [0:0] sw_sgmt_L1_x1y0e_0__o;
    wire [0:0] sw_sgmt_L1_x1y0e_1__o;
    wire [0:0] sw_sgmt_L1_x1y0e_2__o;
    wire [0:0] sw_sgmt_L1_x1y0e_3__o;
    wire [0:0] sw_sgmt_L1_x1y0e_4__o;
    wire [0:0] sw_sgmt_L1_x1y0e_5__o;
    wire [0:0] sw_sgmt_L1_x1y0e_6__o;
    wire [0:0] sw_sgmt_L1_x1y0e_7__o;
    wire [0:0] sw_sgmt_L1_x1y0e_8__o;
    wire [0:0] sw_sgmt_L1_x1y0e_9__o;
    wire [0:0] sw_sgmt_L1_x1y0e_10__o;
    wire [0:0] sw_sgmt_L1_x1y0e_11__o;
    wire [0:0] sw_sgmt_L1_x1y0e_12__o;
    wire [0:0] sw_sgmt_L1_x1y0e_13__o;
    wire [0:0] sw_sgmt_L1_x1y0e_14__o;
    wire [0:0] sw_sgmt_L1_x1y0e_15__o;
    wire [0:0] sw_sgmt_L1_x1y0e_16__o;
    wire [0:0] sw_sgmt_L1_x1y0e_17__o;
    wire [0:0] sw_sgmt_L1_x1y0e_18__o;
    wire [0:0] sw_sgmt_L1_x1y0e_19__o;
    wire [0:0] sw_sgmt_L1_x0y0s_0__o;
    wire [0:0] sw_sgmt_L1_x0y0s_1__o;
    wire [0:0] sw_sgmt_L1_x0y0s_2__o;
    wire [0:0] sw_sgmt_L1_x0y0s_3__o;
    wire [0:0] sw_sgmt_L1_x0y0s_4__o;
    wire [0:0] sw_sgmt_L1_x0y0s_5__o;
    wire [0:0] sw_sgmt_L1_x0y0s_6__o;
    wire [0:0] sw_sgmt_L1_x0y0s_7__o;
    wire [0:0] sw_sgmt_L1_x0y0s_8__o;
    wire [0:0] sw_sgmt_L1_x0y0s_9__o;
    wire [0:0] sw_sgmt_L1_x0y0s_10__o;
    wire [0:0] sw_sgmt_L1_x0y0s_11__o;
    wire [0:0] sw_sgmt_L1_x0y0s_12__o;
    wire [0:0] sw_sgmt_L1_x0y0s_13__o;
    wire [0:0] sw_sgmt_L1_x0y0s_14__o;
    wire [0:0] sw_sgmt_L1_x0y0s_15__o;
    wire [0:0] sw_sgmt_L1_x0y0s_16__o;
    wire [0:0] sw_sgmt_L1_x0y0s_17__o;
    wire [0:0] sw_sgmt_L1_x0y0s_18__o;
    wire [0:0] sw_sgmt_L1_x0y0s_19__o;
    wire [0:0] sw_sgmt_L1_x0y0w_0__o;
    wire [0:0] sw_sgmt_L1_x0y0w_1__o;
    wire [0:0] sw_sgmt_L1_x0y0w_2__o;
    wire [0:0] sw_sgmt_L1_x0y0w_3__o;
    wire [0:0] sw_sgmt_L1_x0y0w_4__o;
    wire [0:0] sw_sgmt_L1_x0y0w_5__o;
    wire [0:0] sw_sgmt_L1_x0y0w_6__o;
    wire [0:0] sw_sgmt_L1_x0y0w_7__o;
    wire [0:0] sw_sgmt_L1_x0y0w_8__o;
    wire [0:0] sw_sgmt_L1_x0y0w_9__o;
    wire [0:0] sw_sgmt_L1_x0y0w_10__o;
    wire [0:0] sw_sgmt_L1_x0y0w_11__o;
    wire [0:0] sw_sgmt_L1_x0y0w_12__o;
    wire [0:0] sw_sgmt_L1_x0y0w_13__o;
    wire [0:0] sw_sgmt_L1_x0y0w_14__o;
    wire [0:0] sw_sgmt_L1_x0y0w_15__o;
    wire [0:0] sw_sgmt_L1_x0y0w_16__o;
    wire [0:0] sw_sgmt_L1_x0y0w_17__o;
    wire [0:0] sw_sgmt_L1_x0y0w_18__o;
    wire [0:0] sw_sgmt_L1_x0y0w_19__o;
    
    cfg_mux2 sw_sgmt_L1_x1y0e_0 (
        .i({sbic_L1_x1y0e[0], sbir_L1_x0y0e[0]}),
        .o(sw_sgmt_L1_x1y0e_0__o),
        .cfg_d(cfg_d[0])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_1 (
        .i({sbic_L1_x1y0e[1], sbir_L1_x0y0n[3], sbir_L1_x0y0e[1]}),
        .o(sw_sgmt_L1_x1y0e_1__o),
        .cfg_d(cfg_d[2:1])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_2 (
        .i({sbic_L1_x1y0e[2], sbir_L1_x0y0n[4], sbir_L1_x0y0e[2]}),
        .o(sw_sgmt_L1_x1y0e_2__o),
        .cfg_d(cfg_d[4:3])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_3 (
        .i({sbic_L1_x1y0e[3], sbir_L1_x0y0n[5], sbir_L1_x0y0e[3]}),
        .o(sw_sgmt_L1_x1y0e_3__o),
        .cfg_d(cfg_d[6:5])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_4 (
        .i({sbic_L1_x1y0e[4], sbir_L1_x0y0n[6], sbir_L1_x0y0e[4]}),
        .o(sw_sgmt_L1_x1y0e_4__o),
        .cfg_d(cfg_d[8:7])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_5 (
        .i({sbic_L1_x1y0e[5], sbir_L1_x0y0n[7], sbir_L1_x0y0e[5]}),
        .o(sw_sgmt_L1_x1y0e_5__o),
        .cfg_d(cfg_d[10:9])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_6 (
        .i({sbic_L1_x1y0e[6], sbir_L1_x0y0n[8], sbir_L1_x0y0e[6]}),
        .o(sw_sgmt_L1_x1y0e_6__o),
        .cfg_d(cfg_d[12:11])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_7 (
        .i({sbic_L1_x1y0e[7], sbir_L1_x0y0n[9], sbir_L1_x0y0e[7]}),
        .o(sw_sgmt_L1_x1y0e_7__o),
        .cfg_d(cfg_d[14:13])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_8 (
        .i({sbic_L1_x1y0e[8], sbir_L1_x0y0n[10], sbir_L1_x0y0e[8]}),
        .o(sw_sgmt_L1_x1y0e_8__o),
        .cfg_d(cfg_d[16:15])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_9 (
        .i({sbic_L1_x1y0e[9], sbir_L1_x0y0n[11], sbir_L1_x0y0e[9]}),
        .o(sw_sgmt_L1_x1y0e_9__o),
        .cfg_d(cfg_d[18:17])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_10 (
        .i({sbic_L1_x1y0e[10], sbir_L1_x0y0n[12], sbir_L1_x0y0e[10]}),
        .o(sw_sgmt_L1_x1y0e_10__o),
        .cfg_d(cfg_d[20:19])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_11 (
        .i({sbic_L1_x1y0e[11], sbir_L1_x0y0n[13], sbir_L1_x0y0e[11]}),
        .o(sw_sgmt_L1_x1y0e_11__o),
        .cfg_d(cfg_d[22:21])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_12 (
        .i({sbic_L1_x1y0e[12], sbir_L1_x0y0n[14], sbir_L1_x0y0e[12]}),
        .o(sw_sgmt_L1_x1y0e_12__o),
        .cfg_d(cfg_d[24:23])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_13 (
        .i({sbic_L1_x1y0e[13], sbir_L1_x0y0n[15], sbir_L1_x0y0e[13]}),
        .o(sw_sgmt_L1_x1y0e_13__o),
        .cfg_d(cfg_d[26:25])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_14 (
        .i({sbic_L1_x1y0e[14], sbir_L1_x0y0n[16], sbir_L1_x0y0e[14]}),
        .o(sw_sgmt_L1_x1y0e_14__o),
        .cfg_d(cfg_d[28:27])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_15 (
        .i({sbic_L1_x1y0e[15], sbir_L1_x0y0n[17], sbir_L1_x0y0e[15]}),
        .o(sw_sgmt_L1_x1y0e_15__o),
        .cfg_d(cfg_d[30:29])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_16 (
        .i({sbic_L1_x1y0e[16], sbir_L1_x0y0n[18], sbir_L1_x0y0e[16]}),
        .o(sw_sgmt_L1_x1y0e_16__o),
        .cfg_d(cfg_d[32:31])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_17 (
        .i({sbic_L1_x1y0e[17], sbir_L1_x0y0n[19], sbir_L1_x0y0e[17]}),
        .o(sw_sgmt_L1_x1y0e_17__o),
        .cfg_d(cfg_d[34:33])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_18 (
        .i({sbic_L1_x1y0e[18], sbir_L1_x0y0n[0], sbir_L1_x0y0e[18]}),
        .o(sw_sgmt_L1_x1y0e_18__o),
        .cfg_d(cfg_d[36:35])
        );
    cfg_mux3 sw_sgmt_L1_x1y0e_19 (
        .i({sbic_L1_x1y0e[19], sbir_L1_x0y0n[1], sbir_L1_x0y0e[19]}),
        .o(sw_sgmt_L1_x1y0e_19__o),
        .cfg_d(cfg_d[38:37])
        );
    cfg_mux2 sw_sgmt_L1_x0y0s_0 (
        .i({sbic_L1_x0y0s[0], sbir_L1_x0y0e[19]}),
        .o(sw_sgmt_L1_x0y0s_0__o),
        .cfg_d(cfg_d[39])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_1 (
        .i({sbic_L1_x0y0s[1], sbir_L1_x1y0w[3], sbir_L1_x0y0e[0]}),
        .o(sw_sgmt_L1_x0y0s_1__o),
        .cfg_d(cfg_d[41:40])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_2 (
        .i({sbic_L1_x0y0s[2], sbir_L1_x1y0w[4], sbir_L1_x0y0e[1]}),
        .o(sw_sgmt_L1_x0y0s_2__o),
        .cfg_d(cfg_d[43:42])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_3 (
        .i({sbic_L1_x0y0s[3], sbir_L1_x1y0w[5], sbir_L1_x0y0e[2]}),
        .o(sw_sgmt_L1_x0y0s_3__o),
        .cfg_d(cfg_d[45:44])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_4 (
        .i({sbic_L1_x0y0s[4], sbir_L1_x1y0w[6], sbir_L1_x0y0e[3]}),
        .o(sw_sgmt_L1_x0y0s_4__o),
        .cfg_d(cfg_d[47:46])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_5 (
        .i({sbic_L1_x0y0s[5], sbir_L1_x1y0w[7], sbir_L1_x0y0e[4]}),
        .o(sw_sgmt_L1_x0y0s_5__o),
        .cfg_d(cfg_d[49:48])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_6 (
        .i({sbic_L1_x0y0s[6], sbir_L1_x1y0w[8], sbir_L1_x0y0e[5]}),
        .o(sw_sgmt_L1_x0y0s_6__o),
        .cfg_d(cfg_d[51:50])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_7 (
        .i({sbic_L1_x0y0s[7], sbir_L1_x1y0w[9], sbir_L1_x0y0e[6]}),
        .o(sw_sgmt_L1_x0y0s_7__o),
        .cfg_d(cfg_d[53:52])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_8 (
        .i({sbic_L1_x0y0s[8], sbir_L1_x1y0w[10], sbir_L1_x0y0e[7]}),
        .o(sw_sgmt_L1_x0y0s_8__o),
        .cfg_d(cfg_d[55:54])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_9 (
        .i({sbic_L1_x0y0s[9], sbir_L1_x1y0w[11], sbir_L1_x0y0e[8]}),
        .o(sw_sgmt_L1_x0y0s_9__o),
        .cfg_d(cfg_d[57:56])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_10 (
        .i({sbic_L1_x0y0s[10], sbir_L1_x1y0w[12], sbir_L1_x0y0e[9]}),
        .o(sw_sgmt_L1_x0y0s_10__o),
        .cfg_d(cfg_d[59:58])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_11 (
        .i({sbic_L1_x0y0s[11], sbir_L1_x1y0w[13], sbir_L1_x0y0e[10]}),
        .o(sw_sgmt_L1_x0y0s_11__o),
        .cfg_d(cfg_d[61:60])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_12 (
        .i({sbic_L1_x0y0s[12], sbir_L1_x1y0w[14], sbir_L1_x0y0e[11]}),
        .o(sw_sgmt_L1_x0y0s_12__o),
        .cfg_d(cfg_d[63:62])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_13 (
        .i({sbic_L1_x0y0s[13], sbir_L1_x1y0w[15], sbir_L1_x0y0e[12]}),
        .o(sw_sgmt_L1_x0y0s_13__o),
        .cfg_d(cfg_d[65:64])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_14 (
        .i({sbic_L1_x0y0s[14], sbir_L1_x1y0w[16], sbir_L1_x0y0e[13]}),
        .o(sw_sgmt_L1_x0y0s_14__o),
        .cfg_d(cfg_d[67:66])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_15 (
        .i({sbic_L1_x0y0s[15], sbir_L1_x1y0w[17], sbir_L1_x0y0e[14]}),
        .o(sw_sgmt_L1_x0y0s_15__o),
        .cfg_d(cfg_d[69:68])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_16 (
        .i({sbic_L1_x0y0s[16], sbir_L1_x1y0w[18], sbir_L1_x0y0e[15]}),
        .o(sw_sgmt_L1_x0y0s_16__o),
        .cfg_d(cfg_d[71:70])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_17 (
        .i({sbic_L1_x0y0s[17], sbir_L1_x1y0w[19], sbir_L1_x0y0e[16]}),
        .o(sw_sgmt_L1_x0y0s_17__o),
        .cfg_d(cfg_d[73:72])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_18 (
        .i({sbic_L1_x0y0s[18], sbir_L1_x1y0w[0], sbir_L1_x0y0e[17]}),
        .o(sw_sgmt_L1_x0y0s_18__o),
        .cfg_d(cfg_d[75:74])
        );
    cfg_mux3 sw_sgmt_L1_x0y0s_19 (
        .i({sbic_L1_x0y0s[19], sbir_L1_x1y0w[1], sbir_L1_x0y0e[18]}),
        .o(sw_sgmt_L1_x0y0s_19__o),
        .cfg_d(cfg_d[77:76])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_0 (
        .i({sbic_L1_x0y0w[0], sbir_L1_x0y0n[19], sbir_L1_x1y0w[0]}),
        .o(sw_sgmt_L1_x0y0w_0__o),
        .cfg_d(cfg_d[79:78])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_1 (
        .i({sbic_L1_x0y0w[1], sbir_L1_x0y0n[0], sbir_L1_x1y0w[1]}),
        .o(sw_sgmt_L1_x0y0w_1__o),
        .cfg_d(cfg_d[81:80])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_2 (
        .i({sbic_L1_x0y0w[2], sbir_L1_x0y0n[1], sbir_L1_x1y0w[2]}),
        .o(sw_sgmt_L1_x0y0w_2__o),
        .cfg_d(cfg_d[83:82])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_3 (
        .i({sbic_L1_x0y0w[3], sbir_L1_x0y0n[2], sbir_L1_x1y0w[3]}),
        .o(sw_sgmt_L1_x0y0w_3__o),
        .cfg_d(cfg_d[85:84])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_4 (
        .i({sbic_L1_x0y0w[4], sbir_L1_x0y0n[3], sbir_L1_x1y0w[4]}),
        .o(sw_sgmt_L1_x0y0w_4__o),
        .cfg_d(cfg_d[87:86])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_5 (
        .i({sbic_L1_x0y0w[5], sbir_L1_x0y0n[4], sbir_L1_x1y0w[5]}),
        .o(sw_sgmt_L1_x0y0w_5__o),
        .cfg_d(cfg_d[89:88])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_6 (
        .i({sbic_L1_x0y0w[6], sbir_L1_x0y0n[5], sbir_L1_x1y0w[6]}),
        .o(sw_sgmt_L1_x0y0w_6__o),
        .cfg_d(cfg_d[91:90])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_7 (
        .i({sbic_L1_x0y0w[7], sbir_L1_x0y0n[6], sbir_L1_x1y0w[7]}),
        .o(sw_sgmt_L1_x0y0w_7__o),
        .cfg_d(cfg_d[93:92])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_8 (
        .i({sbic_L1_x0y0w[8], sbir_L1_x0y0n[7], sbir_L1_x1y0w[8]}),
        .o(sw_sgmt_L1_x0y0w_8__o),
        .cfg_d(cfg_d[95:94])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_9 (
        .i({sbic_L1_x0y0w[9], sbir_L1_x0y0n[8], sbir_L1_x1y0w[9]}),
        .o(sw_sgmt_L1_x0y0w_9__o),
        .cfg_d(cfg_d[97:96])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_10 (
        .i({sbic_L1_x0y0w[10], sbir_L1_x0y0n[9], sbir_L1_x1y0w[10]}),
        .o(sw_sgmt_L1_x0y0w_10__o),
        .cfg_d(cfg_d[99:98])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_11 (
        .i({sbic_L1_x0y0w[11], sbir_L1_x0y0n[10], sbir_L1_x1y0w[11]}),
        .o(sw_sgmt_L1_x0y0w_11__o),
        .cfg_d(cfg_d[101:100])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_12 (
        .i({sbic_L1_x0y0w[12], sbir_L1_x0y0n[11], sbir_L1_x1y0w[12]}),
        .o(sw_sgmt_L1_x0y0w_12__o),
        .cfg_d(cfg_d[103:102])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_13 (
        .i({sbic_L1_x0y0w[13], sbir_L1_x0y0n[12], sbir_L1_x1y0w[13]}),
        .o(sw_sgmt_L1_x0y0w_13__o),
        .cfg_d(cfg_d[105:104])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_14 (
        .i({sbic_L1_x0y0w[14], sbir_L1_x0y0n[13], sbir_L1_x1y0w[14]}),
        .o(sw_sgmt_L1_x0y0w_14__o),
        .cfg_d(cfg_d[107:106])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_15 (
        .i({sbic_L1_x0y0w[15], sbir_L1_x0y0n[14], sbir_L1_x1y0w[15]}),
        .o(sw_sgmt_L1_x0y0w_15__o),
        .cfg_d(cfg_d[109:108])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_16 (
        .i({sbic_L1_x0y0w[16], sbir_L1_x0y0n[15], sbir_L1_x1y0w[16]}),
        .o(sw_sgmt_L1_x0y0w_16__o),
        .cfg_d(cfg_d[111:110])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_17 (
        .i({sbic_L1_x0y0w[17], sbir_L1_x0y0n[16], sbir_L1_x1y0w[17]}),
        .o(sw_sgmt_L1_x0y0w_17__o),
        .cfg_d(cfg_d[113:112])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_18 (
        .i({sbic_L1_x0y0w[18], sbir_L1_x0y0n[17], sbir_L1_x1y0w[18]}),
        .o(sw_sgmt_L1_x0y0w_18__o),
        .cfg_d(cfg_d[115:114])
        );
    cfg_mux3 sw_sgmt_L1_x0y0w_19 (
        .i({sbic_L1_x0y0w[19], sbir_L1_x0y0n[18], sbir_L1_x1y0w[19]}),
        .o(sw_sgmt_L1_x0y0w_19__o),
        .cfg_d(cfg_d[117:116])
        );
    
    assign sgmt_L1_x1y0e = {sw_sgmt_L1_x1y0e_19__o, sw_sgmt_L1_x1y0e_18__o, sw_sgmt_L1_x1y0e_17__o, sw_sgmt_L1_x1y0e_16__o, sw_sgmt_L1_x1y0e_15__o, sw_sgmt_L1_x1y0e_14__o, sw_sgmt_L1_x1y0e_13__o, sw_sgmt_L1_x1y0e_12__o, sw_sgmt_L1_x1y0e_11__o, sw_sgmt_L1_x1y0e_10__o, sw_sgmt_L1_x1y0e_9__o, sw_sgmt_L1_x1y0e_8__o, sw_sgmt_L1_x1y0e_7__o, sw_sgmt_L1_x1y0e_6__o, sw_sgmt_L1_x1y0e_5__o, sw_sgmt_L1_x1y0e_4__o, sw_sgmt_L1_x1y0e_3__o, sw_sgmt_L1_x1y0e_2__o, sw_sgmt_L1_x1y0e_1__o, sw_sgmt_L1_x1y0e_0__o};
    assign sgmt_L1_x0y0s = {sw_sgmt_L1_x0y0s_19__o, sw_sgmt_L1_x0y0s_18__o, sw_sgmt_L1_x0y0s_17__o, sw_sgmt_L1_x0y0s_16__o, sw_sgmt_L1_x0y0s_15__o, sw_sgmt_L1_x0y0s_14__o, sw_sgmt_L1_x0y0s_13__o, sw_sgmt_L1_x0y0s_12__o, sw_sgmt_L1_x0y0s_11__o, sw_sgmt_L1_x0y0s_10__o, sw_sgmt_L1_x0y0s_9__o, sw_sgmt_L1_x0y0s_8__o, sw_sgmt_L1_x0y0s_7__o, sw_sgmt_L1_x0y0s_6__o, sw_sgmt_L1_x0y0s_5__o, sw_sgmt_L1_x0y0s_4__o, sw_sgmt_L1_x0y0s_3__o, sw_sgmt_L1_x0y0s_2__o, sw_sgmt_L1_x0y0s_1__o, sw_sgmt_L1_x0y0s_0__o};
    assign sgmt_L1_x0y0w = {sw_sgmt_L1_x0y0w_19__o, sw_sgmt_L1_x0y0w_18__o, sw_sgmt_L1_x0y0w_17__o, sw_sgmt_L1_x0y0w_16__o, sw_sgmt_L1_x0y0w_15__o, sw_sgmt_L1_x0y0w_14__o, sw_sgmt_L1_x0y0w_13__o, sw_sgmt_L1_x0y0w_12__o, sw_sgmt_L1_x0y0w_11__o, sw_sgmt_L1_x0y0w_10__o, sw_sgmt_L1_x0y0w_9__o, sw_sgmt_L1_x0y0w_8__o, sw_sgmt_L1_x0y0w_7__o, sw_sgmt_L1_x0y0w_6__o, sw_sgmt_L1_x0y0w_5__o, sw_sgmt_L1_x0y0w_4__o, sw_sgmt_L1_x0y0w_3__o, sw_sgmt_L1_x0y0w_2__o, sw_sgmt_L1_x0y0w_1__o, sw_sgmt_L1_x0y0w_0__o};

endmodule
