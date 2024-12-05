`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 21:30:51
// Design Name: 
// Module Name: tb_control
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

module tb_control;

    // Señales de entrada
    logic clk;
    logic rst;
    logic go;
    logic mayor;
    logic data_exist;
    logic ready;
    logic desborde;

    // Señales de salida
    logic we;
    logic re;
    logic en1;
    logic en2;
    logic en3;
    logic en4;
    logic select;
    logic enable;

    // Instancia del DUT (Device Under Test)
    control uut (
        .clk(clk),
        .rst(rst),
        .go(go),
        .mayor(mayor),
        .data_exist(data_exist),
        .ready(ready),
        .desborde(desborde),
        .we(we),
        .re(re),
        .en1(en1),
        .en2(en2),
        .en3(en3),
        .en4(en4),
        .select(select),
        .enable(enable)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    // Bloque inicial de prueba
    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        go = 0;
        mayor = 0;
        data_exist = 0;
        ready = 0;
        desborde = 0;

        // Reset activo
        #10 rst = 0;

        // Prueba 1: Estado INICIO -> INCREMENTO
        #10 go = 1;  // Activar señal `go`
        #10;
        assert(enable == 1) else $fatal("Error: Enable no se activa en INCREMENTO");

        // Prueba 2: INCREMENTO -> DECREMENTO -> ACT_REG1
        #10; // Transición a DECREMENTO
        assert(enable == 0) else $fatal("Error: Enable no se desactiva en DECREMENTO");
        #10; // Transición a ACT_REG1
        assert(en1 == 1) else $fatal("Error: en1 no se activa en ACT_REG1");

        // Prueba 3: LECTURA -> RESTA
        #10 ready = 1; // Simular lectura lista
        #10;
        assert(re == 0) else $fatal("Error: re no está en 0 después de LECTURA");
        #10;
        assert(en1 == 0) else $fatal("Error: en1 no se desactiva en RESTA");

        // Prueba 4: ACT_REG2 -> SUMA -> ACT_REG3
        #10 mayor = 1; // Simular condición de "mayor"
        #10;
        assert(en2 == 1) else $fatal("Error: en2 no se activa en ACT_REG2");
        #10;
        assert(en3 == 1) else $fatal("Error: en3 no se activa en ACT_REG3");

        // Prueba 5: MUX_SELECT -> ACT_REG4 -> COMPROBAR_EXIST
        #10;
        assert(select == 1) else $fatal("Error: select no se activa en MUX_SELECT");
        #10;
        assert(en4 == 1) else $fatal("Error: en4 no se activa en ACT_REG4");

        // Prueba 6: FOUND -> ESCRITURA
        #10 data_exist = 1; // Simular que el dato existe
        #10;
        assert(enable == 1) else $fatal("Error: enable no se activa en FOUND");
        #10 ready = 0; // Preparar para escritura
        #10;
        assert(we == 1) else $fatal("Error: we no se activa en ESCRITURA");

        // Prueba 7: DESBORDE -> FINISH
        #10 desborde = 1;
        #10;
        assert(we == 0 && en1 == 0 && en2 == 0) else $fatal("Error: No se desactiva correctamente en DESBORDE");

        // Fin de la simulación
        $display("Test completado correctamente");
        $finish;
    end

endmodule


