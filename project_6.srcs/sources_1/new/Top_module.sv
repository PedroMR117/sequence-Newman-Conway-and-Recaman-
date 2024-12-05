`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2024 12:34:07
// Design Name: 
// Module Name: Top_module
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


module PROCESADOR_DIGITAL(
    input logic clk,               //señal de reloj 
    input logic rst,                //señal de reset
    input logic go,                 //señal de go (inicia las secuencias)
    input logic algoritmo,          //selecciona el algoritmo
    input logic [7:0] n,            //indica valor de n
    output logic [10:0] data_out    //salida al display
);

// Variables intermedias
    logic write2,clk2,select_out,set,select_out_sequence,set_n;
    logic select_sum_rest, mayor_to_0,mayor_to_2, enable, paro, enable2, paro2;
    logic we,re,ready,data_exist;
    logic [1:0] select_counter, select_addr_newman;
    logic [7:0] count, addr_recaman,addr_newman,count2, addr_select, VALUE_N;
    logic [10:0] memory_out,DATA_TO_MEMORY,DATA_TO_ALGORITMS;
    logic [3:0] DONE_RECAMAN,EN_RECAMAN;
    logic [5:0] DONE_NEWMAN,EN_NEWMAN;
 
    //instnacia del modulo de algoritmos
    
    ALGORITMOS u_algoritmos (
    .clk(clk),                     
    .rst(rst),                     
    .select_sum_rest(select_sum_rest),        
    .set(set),                     
    .select_out_sequence(select_out_sequence),     
    .n(count),                      
    .data_in(DATA_TO_ALGORITMS),                
    .select_addr_newman(select_addr_newman),      
    .EN_RECAMAN(EN_RECAMAN),              
    .EN_NEWMAN(EN_NEWMAN),              
    .data_out(DATA_TO_MEMORY),                
    .DONE_RECAMAN(DONE_RECAMAN),            
    .DONE_NEWMAN(DONE_NEWMAN),             
    .mayor_to_0(mayor_to_0),              
    .mayor_to_2(mayor_to_2),              
    .addr_recaman(addr_recaman),  
    .addr_newman(addr_newman)              
);

     //instancia de un registro que almacena n
     
        registro8 res (
        .clk(clk), 
        .reset(rst), 
        .enable(set_n),
        .data_in(n), 
        .data_out(VALUE_N),
        .done()
    );
    
    // Instancia del contador
    contador u_contador (
        .clk(clk),      //
        .rst(rst),      //
        .enable(enable),
        .n_max(paro),
        .N(VALUE_N),           //
        .count(count)    //
    );
    
        // Instancia del contador lento
    contador_slow slow (
        .clk(clk2),     //
        .rst(rst),      //
        .enable(enable2),
        .secuencia(select_out_sequence),
        .n_max(paro2),
        .N(VALUE_N),           //
        .count(count2)    //
    );

       // Instancia del divisor de frecuencia
    Divisor_Frecuencia u_frec (
        .clk_in(clk),   //
        .reset(rst),    //
        .clk_out(clk2)  //
    );
    
    // Instancia de la memoria
    memory_unit u_memory_unit (
        .clk(clk),      //
        .rst(rst),     //
        .we(we),        
        .re(re),
        .write2(write2),
        .addr(addr_select),     //
        .data_in(DATA_TO_MEMORY),    //
        .data_out(memory_out),      //
        .ready(ready),              
        .data_exists(data_exist)
    );
    
      // Instancia del módulo de control
    control u_control (
        .clk(clk), //
        .rst(rst), //
        .go(go), //
        .algoritmo(algoritmo), //
        .data_exist(data_exist),
        .ready(ready), //
        .set_n(set_n),
        .n_max(paro), //
        .n_max2(paro2), //
        .we(we), //
        .re(re), //
        .EN1(EN_RECAMAN), //
        .EN2(EN_NEWMAN), //
        .select(select_sum_rest), //
        .mayor(mayor_to_0), //
        .mayor_2(mayor_to_2), //
        .write2(write2), //
        .enable(enable), //
        .enable2(enable2), //
        .DONE1(DONE_RECAMAN),
        .DONE2(DONE_NEWMAN),
        .set(set),
        .select_out(select_out),
        .select_addr_newman(select_addr_newman),
        .select_counter(select_counter),
        .select_out_sequence(select_out_sequence)
    );
        //instanciacion de mux1x2 (salidas)
         mux1x2 out1_2 (
        .data_in(memory_out), 
        .sel(select_out),
        .data_out1(DATA_TO_ALGORITMS),
        .data_out2(data_out)
    );
            
        //instancia de contadores
        mux_contadores counter(
        .addr_recaman(addr_recaman),
        .addr_newman(addr_newman),
        .addr_slow(count2), 
        .sel(select_counter),
        .data_out(addr_select)
    );
   

endmodule
