// LPT NEMS instantiation
module cfg_mux4 (
    input wire [3:0] i,
    output reg [0:0] o,
    input wire [3:0] rows,
    input wire [3:0] cols,
    );

//instantiate sw's
    genvar j;
    generate for(j=0;j<3;j=j+1) begin: sw_id
        nem_sw sw (
            .D(i[j]),
            .S(o),
            .G(cols[j]),
            .B(rows[j])
        );
    end endgenerate 

endmodule
