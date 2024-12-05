`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 10:34:42
// Design Name: 
// Module Name: sumador2
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


module sumador2 (
    input logic [10:0] data_in1,  //p(p(n-1)) 
    input logic [10:0] data_in2, //p(n-p(n-1))
    output logic [10:0] data_out
);

    always_comb begin
        data_out = data_in1 + data_in2; //p(p(n-1)) + p(n-p(n-1))
    end

endmodule