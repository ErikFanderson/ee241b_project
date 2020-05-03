// LPT NEMS instantiation
module cfg_mux2 (
    input wire [1:0] i,
    output reg [0:0] o,
    input wire [1:0] rows,
    input wire [1:0] cols,
    );

    nem_sw in0 (
        .D(i[0]),
        .S(o),
        .G(cols[0]),
        .B(rows[0])
        );

    nem_sw in1 (
        .D(i[1]),
        .S(o),
        .G(cols[1]),
        .B(rows[1])
        );

endmodule
