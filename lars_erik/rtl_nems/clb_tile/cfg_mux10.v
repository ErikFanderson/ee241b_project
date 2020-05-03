// LPT NEMS instantiation
module cfg_mux10 (
    input wire [9:0] i,
    output reg [0:0] o,
    input wire [9:0] rows,
    input wire [9:0] cols,
    );

//instantiate sw's
    genvar j;
    generate for(j=0;j<9;j=j+1) begin : nems_gen 
        nem_sw sw (
            .D(i[j]),
            .S(o),
            .G(cols[j]),
            .B(rows[j])
        );
    end endgenerate 

endmodule
