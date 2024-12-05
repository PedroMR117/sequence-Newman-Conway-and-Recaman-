`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 19:45:26
// Design Name: 
// Module Name: tb_display
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


module tb_SEGMENTOS;

    // Declaración de señales de prueba
    logic cclk;
    logic clr;
    logic [15:0] X;
    logic [3:0] an;
    logic [6:0] a_to_g;

    // Variables internas del módulo (para monitoreo)
    logic [1:0] count;
    logic [3:0] digit[3:0];
    logic [3:0] current_digit;
    logic clk190;
    logic [7:0] count_1;

    // Instancia del módulo a probar
    SEGMENTOS uut (
        .cclk(cclk),
        .clr(clr),
        .X(X),
        .an(an),
        .a_to_g(a_to_g)
    );

    // Conexión de variables internas
    assign count = uut.count;
    assign digit[0] = uut.digit[0];
    assign digit[1] = uut.digit[1];
    assign digit[2] = uut.digit[2];
    assign digit[3] = uut.digit[3];
    assign current_digit = uut.digit[uut.count];
    assign clk190 = uut.clk190;
    assign count_1 = uut.count_1;

    // Generador de reloj
    always #5 cclk = ~cclk;

    // Simulación
    initial begin
        // Inicialización
        cclk = 0;
        clr = 1;  // Activar reset
        X = 16'b0;

        // Liberar reset
        #10 clr = 0;

        // Caso de prueba: X = 4567
        X = 16'd4567;
        #500;

        // Finalizar simulación
        $display("Simulación finalizada");
        $stop;
    end

    // Monitoreo de todas las señales
    initial begin
        $monitor("Tiempo=%0t | X=%0d | an=%b | a_to_g=%b | clk190=%b | count=%0d | digit[0]=%0d | digit[1]=%0d | digit[2]=%0d | digit[3]=%0d | current_digit=%0d | count_1=%0d", 
                 $time, X, an, a_to_g, clk190, count, digit[0], digit[1], digit[2], digit[3], current_digit, count_1);
    end

endmodule

