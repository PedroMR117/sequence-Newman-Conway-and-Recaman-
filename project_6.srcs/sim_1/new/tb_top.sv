`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2024 14:09:16
// Design Name: 
// Module Name: tb_top
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


module tb_TOP;

    // Declaración de señales
    logic clk;
    logic rst;
    logic go;
    logic algoritmo;
    logic [7:0] n;
    logic [3:0] anodos;
    logic [6:0] a_to_g;

    // Instancia del módulo TOP
    TOP uut (
        .clk(clk),
        .rst(rst),
        .go(go),
        .algoritmo(algoritmo),
        .n(n),
        .anodos(anodos),
        .a_to_g(a_to_g)
    );

    // Señal interna para monitorear la entrada del display
    logic [10:0] secuencia;
    logic [7:0] n_set,count_n;
    
    // Vinculación de la señal interna para observar `data_out` desde `SubTop_module`
    assign secuencia = uut.proce.data_out;
    assign n_set = uut.proce.res.data_out;
    assign count_n = uut.proce.counter.data_out;
        
    // Generador de reloj
    always #5 clk = ~clk; // Periodo de 10 unidades de tiempo

    // Bloque inicial para simulación
    initial begin
        // Inicialización
        clk = 0;
        rst = 0;
        go = 0;
        n = 8'd40;
        algoritmo = 1;

        // Activar reset
        #10 rst = 1;
        #10 rst = 0;

        // Configuración inicial
        go = 1;       // Activar señal `go`
        
        
        #100 n = 8'd2;
        
        // Finalizar simulación
        $display("Simulación finalizada");
        $stop;
    end

endmodule


