`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:01:38
// Design Name: 
// Module Name: registro
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


module registro8 (
    input logic clk,        //reloj
    input logic reset,      //reset
    input logic enable,     //habilitador del registro
    input logic [7:0] data_in,  //entrada del registro
    output logic [7:0] data_out,    //salida del registro
    output logic done  // Señal para indicar almacenamiento exitoso
);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 0;      // Inicializa el dato de salida
        done <= 0;          // Inicializa la señal done
    end else if (enable) begin
        if (data_in >= 0) begin
            data_out <= data_in;  // Actualiza el valor del dato
            done <= 1;           // Activa done por un ciclo
        end else begin
            done <= 1;           // Señal activa temporalmente para datos no válidos
        end
    end else begin
        done <= 0;              // Desactiva done en todos los demás casos
    end
end
endmodule 