`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 18:55:02
// Design Name: 
// Module Name: display
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


module SEGMENTOS(
    input logic cclk,         // ENTRADA DE RELOJ
    input logic clr,          // SEÑAL DE RESET
    input logic [10:0] X,     // DATOS DE ENTRADA (BINARIO)

    output logic [3:0] an,    // ANODOS DE LOS DISPLAYS
    output logic [6:0] a_to_g // SEGMENTOS DEL DISPLAY
);

    // VARIABLES INTERMEDIAS
    logic [3:0] digit[3:0];   // memoria para almacenar los datos decimales de conversion binario natural a BCD
    logic [1:0] count;        // Contador para multiplexación de los anodos
    logic clk190;             // Reloj reducido
    logic [17:0] count_1;      // Contador para divisor de frecuencia para una frecuencia de 190 hz

    // Divisor de frecuencia
    always_ff @(posedge cclk or posedge clr) begin
        if (clr) begin
            count_1 <= 0;
            clk190 <= 0;
        end else begin
            count_1 <= count_1 + 1;
            clk190 <= count_1[17];  // clk190 190hz
        end
    end

    // Contador de multiplexación
    always_ff @(posedge clk190 or posedge clr) begin
        if (clr)
            count <= 2'b00;
        else
            count <= count + 1;
    end

    // Conversión DECIMAL a BCD
    always_comb begin
        integer DECIMAL;   //variable temporal para 
        DECIMAL = X; // Copiar el valor de entrada
        digit[0] = DECIMAL % 10;  // obtiene el reciduo de la division sobre 10 y lo almacena en memoria
        DECIMAL = DECIMAL / 10;   // actualiza la variable DECIMAL a entero para la proxima iteracion
        digit[1] = DECIMAL % 10;
        DECIMAL = DECIMAL / 10;
        digit[2] = DECIMAL % 10;
        DECIMAL = DECIMAL / 10;
        digit[3] = DECIMAL % 10; 
    end

    // Binario de 4 bits a 7 segmentos
    always_comb begin
        case (digit[count])
            4'b0000: a_to_g <= 7'b0000001; // 0
            4'b0001: a_to_g <= 7'b1001111; // 1
            4'b0010: a_to_g <= 7'b0010010; // 2
            4'b0011: a_to_g <= 7'b0000110; // 3
            4'b0100: a_to_g <= 7'b1001100; // 4
            4'b0101: a_to_g <= 7'b0100100; // 5
            4'b0110: a_to_g <= 7'b0100000; // 6
            4'b0111: a_to_g <= 7'b0001111; // 7
            4'b1000: a_to_g <= 7'b0000000; // 8
            4'b1001: a_to_g <= 7'b0000100; // 9
            default: a_to_g <= 7'b1111111; // Apagado
        endcase
    end

    // Control de los ánodos para multiplexación
    always_comb begin
        // Por defecto, apagar todos los displays
        an = 4'b1111;
        case (count)
        2'b00: an[0] = 1'b0; // Siempre encender el menos significativo
        2'b01: an[1] = (X >= 10) ? 1'b0 : 1'b1;  // Encender si X tiene al menos 2 dígitos
        2'b10: an[2] = (X >= 100) ? 1'b0 : 1'b1; // Encender si X tiene al menos 3 dígitos
        2'b11: an[3] = (X >= 1000) ? 1'b0 : 1'b1; // Encender si X tiene 4 dígitos
        default: an = 4'b1111;
    endcase
    
    end

endmodule