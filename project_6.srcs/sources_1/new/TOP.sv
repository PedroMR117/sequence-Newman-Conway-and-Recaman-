`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 09:37:48
// Design Name: 
// Module Name: TOP
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


module TOP(
    input logic clk,            //señal de reloj
    input logic rst,            //señal de reset
    input logic go,             //señal de inicio de las secuencias
    input logic algoritmo,      //selector de secuencia
    input logic [7:0] n,        // N de la cual se quiere calcular la secuencia
    output logic [3:0] anodos,    // ANODOS DE LOS DISPLAYS
    output logic [6:0] a_to_g // SEGMENTOS DEL DISPLAY
    );
  
  //variables intermedias de instnaciacion
  logic [10:0] segmentos;
  
   // Instancia del módulo SubTop_module
    PROCESADOR_DIGITAL proce (
        .clk(clk),               
        .rst(rst),               
        .go(go),                 
        .algoritmo(algoritmo),   
        .n(n),                   
        .data_out(segmentos)      
    );
    
     // Instancia del modulo del display
    SEGMENTOS seg (
        .cclk(clk), 
        .clr(rst),
        .X(segmentos),
        .an(anodos),
        .a_to_g(a_to_g)
    );
    
endmodule
