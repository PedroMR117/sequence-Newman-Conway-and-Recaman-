`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:01:22
// Design Name: 
// Module Name: decremento
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


module decremento (
    input logic [7:0] n,        // entrada de n
    output logic signed [8:0] data_out  //salida con signo para evitar errores
);

    always_comb begin
        data_out = n - 1'b1;    // n-1 para calculo de los algoritmos
    end

endmodule

