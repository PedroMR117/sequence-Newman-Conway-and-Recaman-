`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:10:14
// Design Name: 
// Module Name: Mux2x1
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

module mux2x1 (
    input logic signed [10:0] res1, res2,   //entrada de resta y suma
    input logic sel,                        //selector del resultado
    output logic signed [10:0] data_out     //salida 
);

    always_comb begin
        case (sel)
            1'b0: data_out = res1; //operacion de resta (n-1) - n
            1'b1: data_out = res2; //operacion de suma   (n-1) + n 
        endcase
    end

endmodule
