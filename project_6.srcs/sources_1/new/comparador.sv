`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:24:07
// Design Name: 
// Module Name: comparador
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


module comparador (
    input logic signed [10:0] data_in,       // a(n-1) - n
    output logic mayor   // Señal de salida de 1 bit
);

    always_comb begin
        if (data_in > 0) begin
            mayor = 1'b1; // Verdadero si a(n-1) - n es mayor que 0
        end else begin
            mayor = 1'b0; // Falso si a(n-1) - n es 0 o menor
        end
    end

endmodule

