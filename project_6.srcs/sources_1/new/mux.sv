`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 14:31:59
// Design Name: 
// Module Name: mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux (
    input logic [10:0] recaman, newman, // entradas de las salidas de los modulos de los algoritmos
    input logic sel_out_sequence,   //selector de salida de la secuencia
    output logic [10:0] data_out    //salida de la secuencia
);

    always_comb begin
        case (sel_out_sequence)
            1'b0: data_out = recaman; // salida de recaman
            1'b1: data_out = newman; // salida de newman
        endcase
    end

endmodule

