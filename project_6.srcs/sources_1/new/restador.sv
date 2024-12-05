`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:01:08
// Design Name: 
// Module Name: restador
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


module restador (
    input logic signed [10:0] data_in, //entrada de 11 bits con signo (n-1)
    input logic [7:0] n,                //n
    output logic signed [10:0] data_out  // (n-1) - n
);

    always_comb begin
        data_out = data_in - n; //(n-1) - n
    end

endmodule
