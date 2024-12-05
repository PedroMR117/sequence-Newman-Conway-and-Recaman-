`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2024 18:01:48
// Design Name: 
// Module Name: registro1
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


module registro1 (
    input logic clk,        //reloj
    input logic reset,      //reset
    input logic enable,     //habilitacion del registro
    input logic  signed [10:0] data_in, // entradas de 11 bits con signo
    output logic signed [10:0] data_out, //
    output logic done  // Señal para indicar almacenamiento exitoso
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;
            done <= 0;  // Inicializa la señal a 0
        end else if (enable) begin
            data_out <= data_in;  // Actualiza data_out con data_in
            done <= 1;      // Señal activa por un ciclo
        end else begin
            done <= 0;      // Desactiva la señal si no hay almacenamiento
        end
    end
endmodule

