`default_nettype none
module clb_tile (
    input wire [19:0] arr_L1_x0y0e,
    input wire [19:0] arr_L1_x0y0w,
    output wire [19:0] arc_L1_x0y0n,
    output wire [19:0] arc_L1_x0y0s,
    input wire [19:0] arr_L1_x0v1e,
    input wire [19:0] arr_L1_x0v1w,
    output wire [19:0] arc_L1_x0v1e,
    output wire [19:0] arc_L1_x0v1w,
    input wire [19:0] arr_L1_u1y0n,
    input wire [19:0] arr_L1_u1y0s,
    input wire clk,
`ifdef LARS_ERIK 
    input wire cfg_clk,
    input wire cfg_scan_en,
    input wire cfg_lut_we,
    input wire cfg_scan_in,
    output wire cfg_scan_out
`else
    input wire cfg_clk,
    input wire [0:0] cfg_e,
    input wire [0:0] cfg_we,
    input wire [0:0] cfg_i,
    output wire [0:0] cfg_o
`endif
    );
    
    wire [0:0] blkinst__cout;
    wire [0:0] blkinst__oa0;
    wire [0:0] blkinst__ob0;
    wire [0:0] blkinst__q0;
    wire [0:0] blkinst__oa1;
    wire [0:0] blkinst__ob1;
    wire [0:0] blkinst__q1;
    wire [0:0] blkinst__oa2;
    wire [0:0] blkinst__ob2;
    wire [0:0] blkinst__q2;
    wire [0:0] blkinst__oa3;
    wire [0:0] blkinst__ob3;
    wire [0:0] blkinst__q3;
    wire [0:0] blkinst__oa4;
    wire [0:0] blkinst__ob4;
    wire [0:0] blkinst__q4;
    wire [0:0] blkinst__oa5;
    wire [0:0] blkinst__ob5;
    wire [0:0] blkinst__q5;
    wire [0:0] blkinst__oa6;
    wire [0:0] blkinst__ob6;
    wire [0:0] blkinst__q6;
    wire [0:0] blkinst__oa7;
    wire [0:0] blkinst__ob7;
    wire [0:0] blkinst__q7;
    wire [0:0] blkinst__oa8;
    wire [0:0] blkinst__ob8;
    wire [0:0] blkinst__q8;
    wire [0:0] blkinst__oa9;
    wire [0:0] blkinst__ob9;
    wire [0:0] blkinst__q9;
    wire [0:0] blkinst__cfg_o;
    wire [0:0] cbinst_x0y0s__blkp_clb_x0y0_ce;
    wire [0:0] cbinst_x0y0s__blkp_clb_x0y0_sr;
    wire [19:0] cbinst_x0y0s__cbo_L1_x0v1e;
    wire [19:0] cbinst_x0y0s__cbo_L1_x0v1w;
    wire [0:0] cbinst_x0y0n__blkp_clb_x0y0_cin;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia0;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib0;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia1;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib1;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia2;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib2;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia3;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib3;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia4;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib4;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia5;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib5;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia6;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib6;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia7;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib7;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia8;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib8;
    wire [5:0] cbinst_x0y0w__blkp_clb_x0y0_ia9;
    wire [0:0] cbinst_x0y0w__blkp_clb_x0y0_ib9;
    wire [19:0] cbinst_x0y0e__cbo_L1_x0y0n;
    wire [19:0] cbinst_x0y0e__cbo_L1_x0y0s;
    wire [0:0] cfg_chain_cbinst_x0y0s__cfg_o;
    wire [7:0] cfg_chain_cbinst_x0y0s__cfg_d;
    wire [0:0] cfg_chain_cbinst_x0y0n__cfg_o;
    wire [3:0] cfg_chain_cbinst_x0y0n__cfg_d;
    wire [0:0] cfg_chain_cbinst_x0y0w__cfg_o;
    wire [279:0] cfg_chain_cbinst_x0y0w__cfg_d;
    wire [0:0] cfg_chain_cbinst_x0y0e__cfg_o;
    wire [75:0] cfg_chain_cbinst_x0y0e__cfg_d;
    
    clb blkinst (
        .clk(clk),
        .ce(cbinst_x0y0s__blkp_clb_x0y0_ce),
        .sr(cbinst_x0y0s__blkp_clb_x0y0_sr),
        .cin(cbinst_x0y0n__blkp_clb_x0y0_cin),
        .cout(blkinst__cout),
        .ia0(cbinst_x0y0w__blkp_clb_x0y0_ia0),
        .ib0(cbinst_x0y0w__blkp_clb_x0y0_ib0),
        .oa0(blkinst__oa0),
        .ob0(blkinst__ob0),
        .q0(blkinst__q0),
        .ia1(cbinst_x0y0w__blkp_clb_x0y0_ia1),
        .ib1(cbinst_x0y0w__blkp_clb_x0y0_ib1),
        .oa1(blkinst__oa1),
        .ob1(blkinst__ob1),
        .q1(blkinst__q1),
        .ia2(cbinst_x0y0w__blkp_clb_x0y0_ia2),
        .ib2(cbinst_x0y0w__blkp_clb_x0y0_ib2),
        .oa2(blkinst__oa2),
        .ob2(blkinst__ob2),
        .q2(blkinst__q2),
        .ia3(cbinst_x0y0w__blkp_clb_x0y0_ia3),
        .ib3(cbinst_x0y0w__blkp_clb_x0y0_ib3),
        .oa3(blkinst__oa3),
        .ob3(blkinst__ob3),
        .q3(blkinst__q3),
        .ia4(cbinst_x0y0w__blkp_clb_x0y0_ia4),
        .ib4(cbinst_x0y0w__blkp_clb_x0y0_ib4),
        .oa4(blkinst__oa4),
        .ob4(blkinst__ob4),
        .q4(blkinst__q4),
        .ia5(cbinst_x0y0w__blkp_clb_x0y0_ia5),
        .ib5(cbinst_x0y0w__blkp_clb_x0y0_ib5),
        .oa5(blkinst__oa5),
        .ob5(blkinst__ob5),
        .q5(blkinst__q5),
        .ia6(cbinst_x0y0w__blkp_clb_x0y0_ia6),
        .ib6(cbinst_x0y0w__blkp_clb_x0y0_ib6),
        .oa6(blkinst__oa6),
        .ob6(blkinst__ob6),
        .q6(blkinst__q6),
        .ia7(cbinst_x0y0w__blkp_clb_x0y0_ia7),
        .ib7(cbinst_x0y0w__blkp_clb_x0y0_ib7),
        .oa7(blkinst__oa7),
        .ob7(blkinst__ob7),
        .q7(blkinst__q7),
        .ia8(cbinst_x0y0w__blkp_clb_x0y0_ia8),
        .ib8(cbinst_x0y0w__blkp_clb_x0y0_ib8),
        .oa8(blkinst__oa8),
        .ob8(blkinst__ob8),
        .q8(blkinst__q8),
        .ia9(cbinst_x0y0w__blkp_clb_x0y0_ia9),
        .ib9(cbinst_x0y0w__blkp_clb_x0y0_ib9),
        .oa9(blkinst__oa9),
        .ob9(blkinst__ob9),
        .q9(blkinst__q9),
`ifdef LARS_ERIK
        .cfg_clk(cfg_clk),
        .cfg_e(cfg_scan_en),
        .cfg_we(cfg_lut_we),
        .cfg_i(cfg_scan_in),
`else
        .cfg_clk(cfg_clk),
        .cfg_e(cfg_e),
        .cfg_we(cfg_we),
        .cfg_i(cfg_i),
`endif
        .cfg_o(blkinst__cfg_o)
        );
    cbox_clb_x0y0s cbinst_x0y0s (
        .blkp_clb_x0y0_ce(cbinst_x0y0s__blkp_clb_x0y0_ce),
        .cbi_L1_x0v1e(arr_L1_x0v1e),
        .cbi_L1_x0v1w(arr_L1_x0v1w),
        .blkp_clb_x0y0_sr(cbinst_x0y0s__blkp_clb_x0y0_sr),
        .blkp_clb_x0y0_cout(blkinst__cout),
        .cbo_L1_x0v1e(cbinst_x0y0s__cbo_L1_x0v1e),
        .cbo_L1_x0v1w(cbinst_x0y0s__cbo_L1_x0v1w),
        .cfg_d(cfg_chain_cbinst_x0y0s__cfg_d)
        );
    cbox_clb_x0y0n cbinst_x0y0n (
        .blkp_clb_x0y0_cin(cbinst_x0y0n__blkp_clb_x0y0_cin),
        .cbi_L1_x0y0e(arr_L1_x0y0e),
        .cbi_L1_x0y0w(arr_L1_x0y0w),
        .cfg_d(cfg_chain_cbinst_x0y0n__cfg_d)
        );
    cbox_clb_x0y0w cbinst_x0y0w (
        .blkp_clb_x0y0_ia0(cbinst_x0y0w__blkp_clb_x0y0_ia0),
        .cbi_L1_u1y0n(arr_L1_u1y0n),
        .cbi_L1_u1y0s(arr_L1_u1y0s),
        .blkp_clb_x0y0_ib0(cbinst_x0y0w__blkp_clb_x0y0_ib0),
        .blkp_clb_x0y0_ia1(cbinst_x0y0w__blkp_clb_x0y0_ia1),
        .blkp_clb_x0y0_ib1(cbinst_x0y0w__blkp_clb_x0y0_ib1),
        .blkp_clb_x0y0_ia2(cbinst_x0y0w__blkp_clb_x0y0_ia2),
        .blkp_clb_x0y0_ib2(cbinst_x0y0w__blkp_clb_x0y0_ib2),
        .blkp_clb_x0y0_ia3(cbinst_x0y0w__blkp_clb_x0y0_ia3),
        .blkp_clb_x0y0_ib3(cbinst_x0y0w__blkp_clb_x0y0_ib3),
        .blkp_clb_x0y0_ia4(cbinst_x0y0w__blkp_clb_x0y0_ia4),
        .blkp_clb_x0y0_ib4(cbinst_x0y0w__blkp_clb_x0y0_ib4),
        .blkp_clb_x0y0_ia5(cbinst_x0y0w__blkp_clb_x0y0_ia5),
        .blkp_clb_x0y0_ib5(cbinst_x0y0w__blkp_clb_x0y0_ib5),
        .blkp_clb_x0y0_ia6(cbinst_x0y0w__blkp_clb_x0y0_ia6),
        .blkp_clb_x0y0_ib6(cbinst_x0y0w__blkp_clb_x0y0_ib6),
        .blkp_clb_x0y0_ia7(cbinst_x0y0w__blkp_clb_x0y0_ia7),
        .blkp_clb_x0y0_ib7(cbinst_x0y0w__blkp_clb_x0y0_ib7),
        .blkp_clb_x0y0_ia8(cbinst_x0y0w__blkp_clb_x0y0_ia8),
        .blkp_clb_x0y0_ib8(cbinst_x0y0w__blkp_clb_x0y0_ib8),
        .blkp_clb_x0y0_ia9(cbinst_x0y0w__blkp_clb_x0y0_ia9),
        .blkp_clb_x0y0_ib9(cbinst_x0y0w__blkp_clb_x0y0_ib9),
        .cfg_d(cfg_chain_cbinst_x0y0w__cfg_d)
        );
    cbox_clb_x0y0e cbinst_x0y0e (
        .blkp_clb_x0y0_oa0(blkinst__oa0),
        .cbo_L1_x0y0n(cbinst_x0y0e__cbo_L1_x0y0n),
        .cbo_L1_x0y0s(cbinst_x0y0e__cbo_L1_x0y0s),
        .blkp_clb_x0y0_ob0(blkinst__ob0),
        .blkp_clb_x0y0_q0(blkinst__q0),
        .blkp_clb_x0y0_oa1(blkinst__oa1),
        .blkp_clb_x0y0_ob1(blkinst__ob1),
        .blkp_clb_x0y0_q1(blkinst__q1),
        .blkp_clb_x0y0_oa2(blkinst__oa2),
        .blkp_clb_x0y0_ob2(blkinst__ob2),
        .blkp_clb_x0y0_q2(blkinst__q2),
        .blkp_clb_x0y0_oa3(blkinst__oa3),
        .blkp_clb_x0y0_ob3(blkinst__ob3),
        .blkp_clb_x0y0_q3(blkinst__q3),
        .blkp_clb_x0y0_oa4(blkinst__oa4),
        .blkp_clb_x0y0_ob4(blkinst__ob4),
        .blkp_clb_x0y0_q4(blkinst__q4),
        .blkp_clb_x0y0_oa5(blkinst__oa5),
        .blkp_clb_x0y0_ob5(blkinst__ob5),
        .blkp_clb_x0y0_q5(blkinst__q5),
        .blkp_clb_x0y0_oa6(blkinst__oa6),
        .blkp_clb_x0y0_ob6(blkinst__ob6),
        .blkp_clb_x0y0_q6(blkinst__q6),
        .blkp_clb_x0y0_oa7(blkinst__oa7),
        .blkp_clb_x0y0_ob7(blkinst__ob7),
        .blkp_clb_x0y0_q7(blkinst__q7),
        .blkp_clb_x0y0_oa8(blkinst__oa8),
        .blkp_clb_x0y0_ob8(blkinst__ob8),
        .blkp_clb_x0y0_q8(blkinst__q8),
        .blkp_clb_x0y0_oa9(blkinst__oa9),
        .blkp_clb_x0y0_ob9(blkinst__ob9),
        .blkp_clb_x0y0_q9(blkinst__q9),
        .cfg_d(cfg_chain_cbinst_x0y0e__cfg_d)
        );
    
`ifdef LARS_ERIK    
    //Instantiate SRAM control shift registers
    reg [38:0] sram_input_cfg;
    wire [31:0] sram_rd_data;

    always @(posedge cfg_clk) begin
        if (cfg_scan_en) begin
            sram_input_cfg <= {sram_input_cfg[37:0], blkinst__cfg_o};
        end
    end
    
    assign cfg_scan_out = sram_input_cfg[38];
    
    // Fake Memory - i.e. flop array
    reg [31:0] flop_array [15:0];
    reg [31:0] output_flop_array;

    // Write
    always @(posedge cfg_clk) begin
        if (~sram_input_cfg[4] && ~sram_input_cfg[6]) begin
            flop_array[sram_input_cfg[3:0]] <= sram_input_cfg[38:7];
        end
    end
    
    // Read 
    always @(posedge cfg_clk) begin
        if (~sram_input_cfg[4] && sram_input_cfg[6]) begin
            output_flop_array <= flop_array[sram_input_cfg[3:0]];
        end
    end

    assign sram_rd_data = output_flop_array;

    //// Instantiate SRAM (2RW - 16x32) - Just don't use 1 port...
    //SRAM2RW16x32 sram_input_cfg (
    //    .CE1(cfg_clk),      // clk 
    //    .A1(sram_input_cfg[3:0]), // address 
    //    .WEB1(sram_input_cfg[4]), // write enable bar 
    //    .OEB1(sram_input_cfg[5]), // output enable bar 
    //    .CSB1(sram_input_cfg[6]), // chip select bar 
    //    .I1(sram_input_cfg[38:7]),// input 
    //    .O1(sram_rd_data),  // output 
    //    
    //    // Leave second port disconnected (Needed 16x32 1RW but only had 2RW)
    //    .A2(),
    //    .CE2(),
    //    .WEB2(),
    //    .OEB2(),
    //    .CSB2(),
    //    .I2(),
    //    .O2()
    //);
    
    // Instantiate registers for statically configuring muxes and luts
    reg [31:0] sram_output_cfg [15:0];

    always @(posedge cfg_clk) begin
        if (~sram_input_cfg[4]) begin
            sram_output_cfg[sram_input_cfg[3:0]] <= sram_rd_data;
        end
    end
    
    // Wiring from registers to __cfg_d
    assign cfg_chain_cbinst_x0y0s__cfg_d = sram_output_cfg[0][7:0]; // 8 bits
    
    assign cfg_chain_cbinst_x0y0n__cfg_d = sram_output_cfg[0][11:8]; // 4 bits
    
    assign cfg_chain_cbinst_x0y0w__cfg_d[31:0] = sram_output_cfg[1]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[63:32] = sram_output_cfg[2]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[95:64] = sram_output_cfg[3]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[127:96] = sram_output_cfg[4]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[159:128] = sram_output_cfg[5]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[191:160] = sram_output_cfg[6]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[223:192] = sram_output_cfg[7]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[255:224] = sram_output_cfg[8]; // 280 bits
    assign cfg_chain_cbinst_x0y0w__cfg_d[279:256] = sram_output_cfg[9][23:0]; // 280 bits
    
    assign cfg_chain_cbinst_x0y0e__cfg_d[31:0] = sram_output_cfg[10]; // 76 bits
    assign cfg_chain_cbinst_x0y0e__cfg_d[63:32] = sram_output_cfg[11]; // 76 bits
    assign cfg_chain_cbinst_x0y0e__cfg_d[75:64] = sram_output_cfg[12][11:0]; // 76 bits
`else
    cfg_bitchain8 cfg_chain_cbinst_x0y0s (
        .cfg_clk(cfg_clk),
        .cfg_e(cfg_e),
        .cfg_we(cfg_we),
        .cfg_i(blkinst__cfg_o),
        .cfg_o(cfg_chain_cbinst_x0y0s__cfg_o),
        .cfg_d(cfg_chain_cbinst_x0y0s__cfg_d)
        );
    cfg_bitchain4 cfg_chain_cbinst_x0y0n (
        .cfg_clk(cfg_clk),
        .cfg_e(cfg_e),
        .cfg_we(cfg_we),
        .cfg_i(cfg_chain_cbinst_x0y0s__cfg_o),
        .cfg_o(cfg_chain_cbinst_x0y0n__cfg_o),
        .cfg_d(cfg_chain_cbinst_x0y0n__cfg_d)
        );
    cfg_bitchain280 cfg_chain_cbinst_x0y0w (
        .cfg_clk(cfg_clk),
        .cfg_e(cfg_e),
        .cfg_we(cfg_we),
        .cfg_i(cfg_chain_cbinst_x0y0n__cfg_o),
        .cfg_o(cfg_chain_cbinst_x0y0w__cfg_o),
        .cfg_d(cfg_chain_cbinst_x0y0w__cfg_d)
        );
    cfg_bitchain76 cfg_chain_cbinst_x0y0e (
        .cfg_clk(cfg_clk),
        .cfg_e(cfg_e),
        .cfg_we(cfg_we),
        .cfg_i(cfg_chain_cbinst_x0y0w__cfg_o),
        .cfg_o(cfg_chain_cbinst_x0y0e__cfg_o),
        .cfg_d(cfg_chain_cbinst_x0y0e__cfg_d)
        );
    
    assign cfg_o = cfg_chain_cbinst_x0y0e__cfg_o;
`endif    
    
    assign arc_L1_x0y0n = cbinst_x0y0e__cbo_L1_x0y0n;
    assign arc_L1_x0y0s = cbinst_x0y0e__cbo_L1_x0y0s;
    assign arc_L1_x0v1e = cbinst_x0y0s__cbo_L1_x0v1e;
    assign arc_L1_x0v1w = cbinst_x0y0s__cbo_L1_x0v1w;

endmodule
`default_nettype wire 
