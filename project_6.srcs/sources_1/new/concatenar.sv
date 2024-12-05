`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 10:06:25
// Design Name: 
// Module Name: concatenar
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


module concat_6bits (
    input logic done1,  
    input logic done2,  // entran las señales done de los registros para
    input logic done3,  //concatenarlas
    input logic done4,  
    input logic done5,  
    input logic done6,  
    output logic [5:0] out  // Salida de 6 bits
);

    always_comb begin
        out = {done6, done5, done4, done3, done2, done1};  //concatena las señales
    end

endmodule

