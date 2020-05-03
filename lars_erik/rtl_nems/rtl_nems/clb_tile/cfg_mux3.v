// LPT NEMS instantiation
module cfg_mux3 (
    input wire [2:0] i,
    output reg [0:0] o,
    input wire [2:0] rows,
    input wire [2:0] cols,
    );

    genvar j;
    generate for(j=0;j<2;j=j+1) begin: sw_id
        nem_sw sw (
            .D(i[j]),
            .S(o),
            .G(cols[j]),
            .B(rows[j])
            );
    end endgenerate
endmodule
