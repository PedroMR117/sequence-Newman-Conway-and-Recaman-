`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2024 17:12:58
// Design Name: 
// Module Name: divisor_frecuencia
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


module Divisor_Frecuencia#(
    parameter integer DIV_FACTOR = 100000000 // parametro para indicar el factor de division
                                            // del reloj, esto para 1 segundo (mostrar resultados en el display)
)(
    input  logic clk_in,     // Reloj 
    input  logic reset,      // reset
    output logic clk_out     // reloj de salida 1s
);
    logic [$clog2(DIV_FACTOR)-1:0] counter; // calcula los bits necesrios para hacer la division
    always_ff @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;   //inicializar en 0
            clk_out <= 0;
        end else begin
            if (counter == (DIV_FACTOR / 2 - 1)) begin
                counter <= 0;
                clk_out <= ~clk_out; // Cambia el estado del reloj de salida
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule

