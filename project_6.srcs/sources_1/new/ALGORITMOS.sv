`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.12.2024 17:57:09
// Design Name: 
// Module Name: ALGORITMOS
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


module ALGORITMOS(
    input logic clk,                //señal de reloj
    input logic rst,                //señal de reset
    input logic select_sum_rest,    //señal para controlar mux del modulo recaman
    input logic set,                //señal que controla la salida de un registro del modulo newman
    input logic select_out_sequence, //señal para controlar la salida del modulo algoritmos
    input logic [7:0] n,            //contador que incrementa n 
    input logic [10:0] data_in,     //Datos provenientes de la memoria
    input logic [1:0] select_addr_newman, //señal que indica que addr seleccionar del modulo newman
    input logic [3:0] EN_RECAMAN,          //señales de encendido de los resgistros del recaman
    input logic [5:0] EN_NEWMAN,          //señales de encendido de los resgistros del newman
    output logic [10:0] data_out,          //señal de salida del modulo a la memoria 
    output logic [3:0] DONE_RECAMAN,        //señal que indicar la escritura de los registros del modulo recaman
    output logic [5:0] DONE_NEWMAN,          //señal que indicar la escritura de los registros del modulo newman
    output logic mayor_to_0,             //señal que indica si [a(n-1) - n] > 0 (recaman)
    output logic mayor_to_2,         //señal que indica si n > 2 (newman)
    output logic [7:0] addr_recaman, //señal que controla la direccion de memoria a leer proweniente del modulo recaman
    output logic [7:0] addr_newman //señal que controla la direccion de memoria a leer proweniente del modulo newman    
    );
    
    //variables intermedias para la instanciacion de modulo
    
    logic [10:0] data_out_recaman,data_out_newman;
    
    // Instancia del modulo que genera la secuencia de recaman
       recaman u_recaman (
        .clk(clk),  //
        .rst(rst),  //
        .n(n),  //
        .data_in(data_in), //
        .EN(EN_RECAMAN), //
        .select(select_sum_rest), //
        .mayor(mayor_to_0), //
        .data_out(data_out_recaman), //
        .addr(addr_recaman), //
        .DONE(DONE_RECAMAN) //
    );
    
     // Instancia del modulo que genera la secuencia de newman-conway
        Newman_conway newman (
        .clk(clk),  //
        .rst(rst), //
        .n(n), //
        .data_in(data_in), //
        .EN(EN_NEWMAN), //
        .set(set), //
        .select(select_addr_newman), //
        .mayor(mayor_to_2), //
        .data_out(data_out_newman), //
        .addr(addr_newman), //
        .DONE(DONE_NEWMAN) //
    );
    
        // Intsanciacion del modulo de mux datos de salida recaman/newman
        mux muxsec (
        .recaman(data_out_recaman), //
        .newman(data_out_newman),  //
        .sel_out_sequence(select_out_sequence), 
        .data_out(data_out) //
    );

    
endmodule
