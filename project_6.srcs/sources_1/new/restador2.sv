`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 10:31:33
// Design Name: 
// Module Name: restador2
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


module restador2 (
    input logic [10:0] data_in,     // p(n-1)
    input logic [7:0] n,          //valor de n
    output logic [10:0] data_out //n - p(n-1)
);

    always_comb begin
        data_out = n - data_in; // n - p(n-1)
    end

endmodule
