`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:00:28
// Design Name: 
// Module Name: recaman
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


module recaman(
    input logic clk,        //señal de reloj
    input logic rst,        //señal de reset
    input logic [7:0] n,    // valor de n
    input logic [10:0] data_in, //datos provenientes de la memoria
    input logic select,         //selector del mux para salida de suma o resta segun el algoritmo
    input logic [3:0] EN,       //señal que controla el encendido de los registros 
    output logic mayor,         //señal que indica si a(n) > 0
    output logic [3:0] DONE,        //señal que indica la escritura de los registros
    output logic [10:0] data_out,   //señal de los calculos
    output logic [7:0] addr         //addr a leer por la memoria
);

    // Variables intermedias
    logic [7:0] dec;
    logic [10:0] resta, reg2, reg3, mux1, suma;
    logic done1,done2,done3,done4;

    // Instancia del módulo comparador 
    comparador com (
        .data_in(resta), 
        .mayor(mayor)
    );

    // Instancia del módulo de decremento 
    decremento decr (
        .n(n), 
        .data_out(dec)
    ); 

    // Instancia del módulo de resta
    restador rest (
        .n(n), 
        .data_in(data_in),
        .data_out(resta)
    ); 

    // Instancia del módulo de mux 
    mux2x1 mux (
        .res1(reg2),
        .res2(reg3), 
        .sel(select),
        .data_out(mux1)
    );

    // Instancia del módulo de suma
    sumador sum (
        .n(n), 
        .data_in(data_in),
        .data_out(suma)
    ); 

    // Instancia del módulo de registro 8-bit
    registro8 res (
        .clk(clk), 
        .reset(rst), 
        .enable(EN[0]),
        .data_in(dec), 
        .data_out(addr),
        .done(done1)
    );

    // Instancia del módulo de registro para resta
    registro1 U1 (
        .clk(clk), 
        .reset(rst),
        .enable(EN[1]),
        .data_in(resta), 
        .data_out(reg2),
        .done(done2)
    );

    // Instancia del módulo de registro para suma
    registro1 U2 (
        .clk(clk), 
        .reset(rst),
        .enable(EN[2]),
        .data_in(suma), 
        .data_out(reg3),
        .done(done3)
    );

    // Instancia del módulo de registro para mux
    registro1 U3 (
        .clk(clk), 
        .reset(rst),
        .enable(EN[3]),
        .data_in(mux1), 
        .data_out(data_out),
        .done(done4)
    );
    
      // Instancia del modulo de concatenar 4 bits
    
    concat_4bits bits(
    .done1(done1),
    .done2(done2),
    .done3(done3),
    .done4(done4),
    .out(DONE)
    );

endmodule
