`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 09:43:42
// Design Name: 
// Module Name: Newman_conway
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


module Newman_conway(
    input logic clk,            //señal de reloj
    input logic rst,            //señal de reset
    input logic [7:0] n,        //valor de n
    input logic [10:0] data_in, //datos de entrada de la memoria
    input logic [5:0] EN,       //señal de encendido de los registros
    input logic set,            //señal que setea el registro R6
    input logic [1:0] select,   //señal que indica el addr a escoger
    output logic mayor,         //señal que indica si n > 2
    output logic [5:0] DONE,    //señal que indica la escritura de los registros
    output logic [10:0] data_out,   //calculos del modulo
    output logic [7:0] addr         //addr a leer de la memoria
    );
    
    //variables intermedias 
    logic done1,done2,done3,done4,done5,done6;
    logic [10:0] reg3,reg4,resta,suma,addr2,addr3;
    logic [7:0] addr1,dec;
    
        // Instancia del módulo comparador 
    comparador_n2 com (
        .data_in(n), 
        .mayor(mayor)
    );

    // Instancia del módulo de decremento 
    decremento decr (
        .n(n), 
        .data_out(dec)
    ); 

    // Instancia del módulo de registro 8-bit
    registro8 res (
        .clk(clk), 
        .reset(rst), 
        .enable(EN[0]),
        .data_in(dec), 
        .data_out(addr1),
        .done(done1)
    );
    
    // Instancia del modulo de concatenar 6 bits
    
    concat_6bits con6 (
    .done1(done1),
    .done2(done2),
    .done3(done3),
    .done4(done4),
    .done5(done5),
    .done6(done6),
    .out(DONE)
    );
    
    // Instancia de los modulos de registros
     reg_unsigned R2(
        .clk(clk), 
        .reset(rst),
        .enable(EN[1]),
        .data_in(data_in), 
        .data_out(addr3),
        .done(done2)
    );
    
     reg_unsigned R3(
        .clk(clk), 
        .reset(rst),
        .enable(EN[2]),
        .data_in(data_in), 
        .data_out(reg3),
        .done(done3)
    );
    
     reg_unsigned R4(
        .clk(clk), 
        .reset(rst),
        .enable(EN[3]),
        .data_in(data_in), 
        .data_out(reg4),
        .done(done4)
    );
    
     reg_unsigned R5(
        .clk(clk), 
        .reset(rst),
        .enable(EN[4]),
        .data_in(resta), 
        .data_out(addr2),
        .done(done5)
    );
    
    // REGISTRO CON SET
    
       registro_set R6(
        .clk(clk), 
        .reset(rst),
        .enable(EN[5]),
        .data_in(suma), 
        .set(set),
        .data_out(data_out),
        .done(done6)
    );
    
        // Instancia del módulo de resta
    restador2 rest (
        .n(n), 
        .data_in(data_in),
        .data_out(resta)
    ); 
    
        // Instancia del módulo de suma
    sumador2 sum (
        .data_in1(reg3), 
        .data_in2(reg4),
        .data_out(suma)
    );
    
       // Instancia del módulo de mux3x1
        mux3x1 mux (
        .addr1(addr1), 
        .addr2(addr2),
        .addr3(addr3),
        .sel(select),
        .data_out(addr)
    ); 
     
    
    
endmodule
