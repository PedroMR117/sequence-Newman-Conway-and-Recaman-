`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2024 15:08:06
// Design Name: 
// Module Name: mux1x2
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


module mux1x2 (
    input logic signed [10:0] data_in,      //datos provenientes de la memoria
    input logic sel,                        //selector de la saida 
    output logic signed [10:0] data_out1,   //salida hacia el modulo de algoritmos
    output logic signed [10:0] data_out2    //salida para mostrar datos en el display
);

    always_comb begin
        if (sel) begin
            data_out1 = data_in;            //datos para el modulo algoritmos
            data_out2 = 0;                  //salida para el display en 0
        end else begin
            data_out1 = 0;
            data_out2 = data_in;
        end
    end

endmodule