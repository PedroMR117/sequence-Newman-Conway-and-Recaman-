`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 09:47:54
// Design Name: 
// Module Name: comparador_n2
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


module comparador_n2 (
    input logic [7:0] data_in,       // Entrada de datos
    output logic mayor   // señal que indica si n es menor a 2 
                        //para logica dentro del modulo de control
);

    always_comb begin
        if (data_in <= 2) begin
            mayor = 1'b1; // n es menor a 2
        end else begin
            mayor = 1'b0; // n es mayor a 2
        end
    end

endmodule
