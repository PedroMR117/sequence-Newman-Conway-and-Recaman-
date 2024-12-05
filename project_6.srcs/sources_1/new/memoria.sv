`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2024 13:00:11
// Design Name: 
// Module Name: memoria
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


module memory_unit #(
    parameter N = 256,             // Tamaño de la memoria (256 espacios)
    parameter DATA_WIDTH = 11      // Ancho de cada dato (11 bits)
) (
    input logic clk,                     // Reloj
    input logic rst,                     // Reset
    input logic we,                      // Habilitación de escritura
    input logic re,                      // Habilitación de lectura
    input logic write2,                  // Condición para escritura 2 (recaman)
    input logic [7:0] addr,              // Dirección de memoria
    input logic [DATA_WIDTH-1:0] data_in, // Datos de entrada 10 bits
    output logic [DATA_WIDTH-1:0] data_out, // Datos de salida 10 bits
    output logic ready,                   // Señal de listo
    output logic data_exists              // Indica si el dato ya existe
);

    // arreglo para generar la memoria
    logic [DATA_WIDTH-1:0] mem [0:N-1];

    // Señal para verificar la existencia de duplicidad de datos
    logic found_comb;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < N; i++) begin
                mem[i] <= 0;  // Inicializar toda la memoria en 0
            end
            data_out <= 0;
            ready <= 0;
            data_exists <= 0;
        end else begin
            ready <= 0;       // no listo
            data_exists <= 0; // el dato no existe

            // Escritura
            if (we && !re) begin
                found_comb = 0;
                for (int i = 0; i <= addr; i++) begin
                    if (mem[i] == data_in && mem[i] != 0 && write2 == 0) begin
                        found_comb = 1;
                        break;
                    end
                end

                if (found_comb) begin
                    data_exists <= 1; // Dato ya existe
                end else if (addr < N-1) begin
                    mem[addr+1] <= data_in; // Escribir en una nueva posición
                end
                ready <= 1; // Señal lista tras completar escritura
            end

            // Lectura
            if (re && !we) begin
                if (addr < N-1) begin
                    data_out <= mem[addr]; // Leer de la dirección `addr`
                end else begin
                    data_out <= 0; // Lectura fuera de rango
                end
                ready <= 1; // Señal lista tras completar lectura
            end
        end
    end

endmodule

