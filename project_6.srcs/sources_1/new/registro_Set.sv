`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 10:25:16
// Design Name: 
// Module Name: registro_Set
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


module registro_set (
    input logic clk,                     // Reloj
    input logic reset,                   // Reset
    input logic enable,                  // Habilitación de escritura
    input logic set,                     // Señal de set
    input logic  [10:0] data_in,   // Datos de entrada
    output logic [10:0] data_out, // Datos de salida
    output logic done                    // Señal de operación completada
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;   // Reiniciar el registro
            done <= 0;       // Desactivar la señal done
        end else if (set) begin
            data_out <= 1;         // Forzar el valor de salia a 1 si se activa set
            done <= 1;             
        end else if (enable) begin
            data_out <= data_in;  // Almacenar datos si enable está activo
            done <= 1;             // Señal de almacenamiento exitoso
        end else begin
            done <= 0;             // Desactivar la señal si no se realiza almacenamiento
        end
    end
endmodule

