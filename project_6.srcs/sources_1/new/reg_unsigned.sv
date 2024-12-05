`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 11:16:03
// Design Name: 
// Module Name: reg_unsigned
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


module reg_unsigned (
    input logic clk,            //señal de reloj
    input logic reset,          //señal de reset
    input logic enable,         //habilitacion del registro
    input logic [10:0] data_in,  //salida de 11 bits para los calculos
    output logic [10:0] data_out,   //salida de 11 bits positiva
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
