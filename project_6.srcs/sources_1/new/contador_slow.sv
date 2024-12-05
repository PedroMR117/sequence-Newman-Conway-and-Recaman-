`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2024 18:26:35
// Design Name: 
// Module Name: contador_slow
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


module contador_slow #(
    parameter WIDTH = 8  // parametro para modificar el valor de contador de 8 bits
)(
    input logic clk,                    // Reloj
    input logic rst,                    // Reset
    input logic enable,                 // Habilitación del contador
    input logic secuencia,              //variable para modificar el limite del contador en funcion de la secuencia
    input logic  [WIDTH-1:0] N,   // limite 8 bits
    output logic [WIDTH-1:0] count, // Salida 8 bits 
    output logic n_max                   // desborde
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;              // Inicializar el contador en 0
        n_max <= 1'b0;           // Indicar que no se ha alcanzado el máximo
    end else if (enable) begin
        if (secuencia) begin
            // Contar según la lógica de newman
            if (count < N) begin
                count <= count+1; // Contador decrementa en modo secuencia
                n_max <= 1'b0;      // Máximo no alcanzado
            end else begin
                n_max <= 1'b1;      // Indicar que se alcanzó el límite 
            end
        end else begin
            // Contar segun la logica de recaman
            if (count < N-1) begin
                count <= count + 1; // Contador incrementa normalmente
                n_max <= 1'b0;      // Máximo no alcanzado
            end else begin
                n_max <= 1'b1;      // Indicar que se alcanzó el límite
            end
        end
    end
end
endmodule