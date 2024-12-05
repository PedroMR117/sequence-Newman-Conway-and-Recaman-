`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:00:49
// Design Name: 
// Module Name: sumador
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


module sumador (
    input logic [10:0] data_in,  // a(n-1)
    input logic [7:0] n,        // n 
    output logic [10:0] data_out    // a(n-1) + n
);

    always_comb begin
        data_out = data_in + n; // a(n-1) + n
    end

endmodule

