`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 10:43:05
// Design Name: 
// Module Name: mux3x1
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


module mux3x1 (
    input logic [7:0] addr1,        // addr de lectura 1
    input logic [7:0] addr2,      // addr de lectura 2
    input logic [7:0] addr3,      // addr de lectura 3
    input logic [1:0] sel,         // Señal de selección para la salida de addr
    output logic [7:0] data_out    // addr para la memoria
);

    always_comb begin
        case (sel)
            2'b00: data_out = addr1;        // Selección de la primera entrada (N-1)
            2'b01: data_out = addr2;   // Selección de la segunda entrada P(N-P(N-1)))
            2'b10: data_out = addr3;  // Selección de la tercera entrada (P(n-1))
            default: data_out = 8'b0;      // Si la selección no es válida, salida por defecto
        endcase
    end

endmodule

