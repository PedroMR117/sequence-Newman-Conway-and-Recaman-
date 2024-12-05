`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 11:46:27
// Design Name: 
// Module Name: concat_4bits
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


module concat_4bits (
    input logic done1,  // Entradas de los done
    input logic done2,  // de los registros del modulo recaman
    input logic done3,  
    input logic done4,  
    output logic [3:0] out  // Salida de 4 bits
);

    always_comb begin
        out[0] = done1; 
        out[1] = done2;  
        out[2] = done3; 
        out[3] = done4; 
    end

endmodule
