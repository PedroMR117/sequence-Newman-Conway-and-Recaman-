`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2024 16:34:28
// Design Name: 
// Module Name: contador2
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

module contador #(
    parameter WIDTH = 8  // parametro para modificar el valor de contador de 8 bits
)(
    input logic clk,                    // Reloj
    input logic rst,                    // Reset
    input logic enable,                 // Habilitación del contador
    input logic  [WIDTH-1:0] N,   // Límite del conteo en 8 bits
    output logic [WIDTH-1:0] count, // Salida del valor del contador en 8 bits
    output logic n_max                   // Señal de desbordamiento
);

    // incremento del contador por ciclo de reloj
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;              // Inicializar el contador en 0
            n_max <= 1'b0;            // inicia en 0
        end else if (enable) begin
            if (count < N) begin       // Contar mientras no se desborde
                count <= count + 1;
                n_max <= 1'b0;         // indicar que no hay desborde
            end else begin
                n_max <= 1'b1;         // desborde
            end
        end
    end

endmodule

