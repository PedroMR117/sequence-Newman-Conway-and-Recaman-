`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2024 16:43:42
// Design Name: 
// Module Name: mux_contadores
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

module mux_contadores (
    input logic [7:0] addr_recaman,addr_newman, addr_slow, // addr que leera la memoria
    input logic [1:0] sel,          //selector del addr
    output logic [7:0] data_out
);

    always_comb begin
        case (sel)
            2'b00: data_out = addr_recaman; // addr generada por recaman
            2'b01: data_out = addr_newman; // addr generada por newman
            2'b10: data_out = addr_slow; // addr de lectura lento para mostrar la secuencia
                                            //en el display
            default:begin
            data_out = 0;
            end
        endcase
    end

endmodule

