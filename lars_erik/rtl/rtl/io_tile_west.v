// Automatically generated by PRGA's RTL generator
module io_tile_west (
    input wire [19:0] arr_L4_x0y0n,
    input wire [19:0] arr_L4_x0y0s,
    output wire [19:0] arc_L4_x0y0n,
    output wire [19:0] arc_L4_x0y0s,
    input wire [0:0] ext_iob_x0y0_0_exti,
    output wire [0:0] ext_iob_x0y0_0_exto,
    output wire [0:0] ext_iob_x0y0_0_extoe,
    input wire [0:0] clk,
    input wire [0:0] ext_iob_x0y0_1_exti,
    output wire [0:0] ext_iob_x0y0_1_exto,
    output wire [0:0] ext_iob_x0y0_1_extoe,
    input wire [0:0] ext_iob_x0y0_2_exti,
    output wire [0:0] ext_iob_x0y0_2_exto,
    output wire [0:0] ext_iob_x0y0_2_extoe,
    input wire [0:0] ext_iob_x0y0_3_exti,
    output wire [0:0] ext_iob_x0y0_3_exto,
    output wire [0:0] ext_iob_x0y0_3_extoe,
    input wire [0:0] ext_iob_x0y0_4_exti,
    output wire [0:0] ext_iob_x0y0_4_exto,
    output wire [0:0] ext_iob_x0y0_4_extoe,
    input wire [0:0] ext_iob_x0y0_5_exti,
    output wire [0:0] ext_iob_x0y0_5_exto,
    output wire [0:0] ext_iob_x0y0_5_extoe,
    input wire [0:0] ext_iob_x0y0_6_exti,
    output wire [0:0] ext_iob_x0y0_6_exto,
    output wire [0:0] ext_iob_x0y0_6_extoe,
    input wire [0:0] ext_iob_x0y0_7_exti,
    output wire [0:0] ext_iob_x0y0_7_exto,
    output wire [0:0] ext_iob_x0y0_7_extoe,
    input wire [0:0] ext_iob_x0y0_8_exti,
    output wire [0:0] ext_iob_x0y0_8_exto,
    output wire [0:0] ext_iob_x0y0_8_extoe,
    input wire [0:0] ext_iob_x0y0_9_exti,
    output wire [0:0] ext_iob_x0y0_9_exto,
    output wire [0:0] ext_iob_x0y0_9_extoe,
    input wire [69:0] cfg_d
    );
    
    wire [0:0] blkinst_0__exto;
    wire [0:0] blkinst_0__extoe;
    wire [0:0] blkinst_0__inpad;
    wire [0:0] blkinst_1__exto;
    wire [0:0] blkinst_1__extoe;
    wire [0:0] blkinst_1__inpad;
    wire [0:0] blkinst_2__exto;
    wire [0:0] blkinst_2__extoe;
    wire [0:0] blkinst_2__inpad;
    wire [0:0] blkinst_3__exto;
    wire [0:0] blkinst_3__extoe;
    wire [0:0] blkinst_3__inpad;
    wire [0:0] blkinst_4__exto;
    wire [0:0] blkinst_4__extoe;
    wire [0:0] blkinst_4__inpad;
    wire [0:0] blkinst_5__exto;
    wire [0:0] blkinst_5__extoe;
    wire [0:0] blkinst_5__inpad;
    wire [0:0] blkinst_6__exto;
    wire [0:0] blkinst_6__extoe;
    wire [0:0] blkinst_6__inpad;
    wire [0:0] blkinst_7__exto;
    wire [0:0] blkinst_7__extoe;
    wire [0:0] blkinst_7__inpad;
    wire [0:0] blkinst_8__exto;
    wire [0:0] blkinst_8__extoe;
    wire [0:0] blkinst_8__inpad;
    wire [0:0] blkinst_9__exto;
    wire [0:0] blkinst_9__extoe;
    wire [0:0] blkinst_9__inpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_0_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_1_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_2_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_3_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_4_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_5_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_6_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_7_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_8_outpad;
    wire [0:0] cbinst_x0y0e__blkp_iob_x0y0_9_outpad;
    wire [19:0] cbinst_x0y0e__cbo_L4_x0y0n;
    wire [19:0] cbinst_x0y0e__cbo_L4_x0y0s;
    
    iob blkinst_0 (
        .exti(ext_iob_x0y0_0_exti),
        .exto(blkinst_0__exto),
        .extoe(blkinst_0__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_0_outpad),
        .inpad(blkinst_0__inpad),
        .cfg_d(cfg_d[2:0])
        );
    iob blkinst_1 (
        .exti(ext_iob_x0y0_1_exti),
        .exto(blkinst_1__exto),
        .extoe(blkinst_1__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_1_outpad),
        .inpad(blkinst_1__inpad),
        .cfg_d(cfg_d[5:3])
        );
    iob blkinst_2 (
        .exti(ext_iob_x0y0_2_exti),
        .exto(blkinst_2__exto),
        .extoe(blkinst_2__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_2_outpad),
        .inpad(blkinst_2__inpad),
        .cfg_d(cfg_d[8:6])
        );
    iob blkinst_3 (
        .exti(ext_iob_x0y0_3_exti),
        .exto(blkinst_3__exto),
        .extoe(blkinst_3__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_3_outpad),
        .inpad(blkinst_3__inpad),
        .cfg_d(cfg_d[11:9])
        );
    iob blkinst_4 (
        .exti(ext_iob_x0y0_4_exti),
        .exto(blkinst_4__exto),
        .extoe(blkinst_4__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_4_outpad),
        .inpad(blkinst_4__inpad),
        .cfg_d(cfg_d[14:12])
        );
    iob blkinst_5 (
        .exti(ext_iob_x0y0_5_exti),
        .exto(blkinst_5__exto),
        .extoe(blkinst_5__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_5_outpad),
        .inpad(blkinst_5__inpad),
        .cfg_d(cfg_d[17:15])
        );
    iob blkinst_6 (
        .exti(ext_iob_x0y0_6_exti),
        .exto(blkinst_6__exto),
        .extoe(blkinst_6__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_6_outpad),
        .inpad(blkinst_6__inpad),
        .cfg_d(cfg_d[20:18])
        );
    iob blkinst_7 (
        .exti(ext_iob_x0y0_7_exti),
        .exto(blkinst_7__exto),
        .extoe(blkinst_7__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_7_outpad),
        .inpad(blkinst_7__inpad),
        .cfg_d(cfg_d[23:21])
        );
    iob blkinst_8 (
        .exti(ext_iob_x0y0_8_exti),
        .exto(blkinst_8__exto),
        .extoe(blkinst_8__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_8_outpad),
        .inpad(blkinst_8__inpad),
        .cfg_d(cfg_d[26:24])
        );
    iob blkinst_9 (
        .exti(ext_iob_x0y0_9_exti),
        .exto(blkinst_9__exto),
        .extoe(blkinst_9__extoe),
        .clk(clk),
        .outpad(cbinst_x0y0e__blkp_iob_x0y0_9_outpad),
        .inpad(blkinst_9__inpad),
        .cfg_d(cfg_d[29:27])
        );
    cbox_iob_x0y0e cbinst_x0y0e (
        .blkp_iob_x0y0_0_outpad(cbinst_x0y0e__blkp_iob_x0y0_0_outpad),
        .cbi_L4_x0y0n(arr_L4_x0y0n),
        .cbi_L4_x0y0s(arr_L4_x0y0s),
        .blkp_iob_x0y0_1_outpad(cbinst_x0y0e__blkp_iob_x0y0_1_outpad),
        .blkp_iob_x0y0_2_outpad(cbinst_x0y0e__blkp_iob_x0y0_2_outpad),
        .blkp_iob_x0y0_3_outpad(cbinst_x0y0e__blkp_iob_x0y0_3_outpad),
        .blkp_iob_x0y0_4_outpad(cbinst_x0y0e__blkp_iob_x0y0_4_outpad),
        .blkp_iob_x0y0_5_outpad(cbinst_x0y0e__blkp_iob_x0y0_5_outpad),
        .blkp_iob_x0y0_6_outpad(cbinst_x0y0e__blkp_iob_x0y0_6_outpad),
        .blkp_iob_x0y0_7_outpad(cbinst_x0y0e__blkp_iob_x0y0_7_outpad),
        .blkp_iob_x0y0_8_outpad(cbinst_x0y0e__blkp_iob_x0y0_8_outpad),
        .blkp_iob_x0y0_9_outpad(cbinst_x0y0e__blkp_iob_x0y0_9_outpad),
        .blkp_iob_x0y0_0_inpad(blkinst_0__inpad),
        .cbo_L4_x0y0n(cbinst_x0y0e__cbo_L4_x0y0n),
        .cbo_L4_x0y0s(cbinst_x0y0e__cbo_L4_x0y0s),
        .blkp_iob_x0y0_1_inpad(blkinst_1__inpad),
        .blkp_iob_x0y0_2_inpad(blkinst_2__inpad),
        .blkp_iob_x0y0_3_inpad(blkinst_3__inpad),
        .blkp_iob_x0y0_4_inpad(blkinst_4__inpad),
        .blkp_iob_x0y0_5_inpad(blkinst_5__inpad),
        .blkp_iob_x0y0_6_inpad(blkinst_6__inpad),
        .blkp_iob_x0y0_7_inpad(blkinst_7__inpad),
        .blkp_iob_x0y0_8_inpad(blkinst_8__inpad),
        .blkp_iob_x0y0_9_inpad(blkinst_9__inpad),
        .cfg_d(cfg_d[69:30])
        );
    
    assign arc_L4_x0y0n = cbinst_x0y0e__cbo_L4_x0y0n;
    assign arc_L4_x0y0s = cbinst_x0y0e__cbo_L4_x0y0s;
    assign ext_iob_x0y0_0_exto = blkinst_0__exto;
    assign ext_iob_x0y0_0_extoe = blkinst_0__extoe;
    assign ext_iob_x0y0_1_exto = blkinst_1__exto;
    assign ext_iob_x0y0_1_extoe = blkinst_1__extoe;
    assign ext_iob_x0y0_2_exto = blkinst_2__exto;
    assign ext_iob_x0y0_2_extoe = blkinst_2__extoe;
    assign ext_iob_x0y0_3_exto = blkinst_3__exto;
    assign ext_iob_x0y0_3_extoe = blkinst_3__extoe;
    assign ext_iob_x0y0_4_exto = blkinst_4__exto;
    assign ext_iob_x0y0_4_extoe = blkinst_4__extoe;
    assign ext_iob_x0y0_5_exto = blkinst_5__exto;
    assign ext_iob_x0y0_5_extoe = blkinst_5__extoe;
    assign ext_iob_x0y0_6_exto = blkinst_6__exto;
    assign ext_iob_x0y0_6_extoe = blkinst_6__extoe;
    assign ext_iob_x0y0_7_exto = blkinst_7__exto;
    assign ext_iob_x0y0_7_extoe = blkinst_7__extoe;
    assign ext_iob_x0y0_8_exto = blkinst_8__exto;
    assign ext_iob_x0y0_8_extoe = blkinst_8__extoe;
    assign ext_iob_x0y0_9_exto = blkinst_9__exto;
    assign ext_iob_x0y0_9_extoe = blkinst_9__extoe;

endmodule
