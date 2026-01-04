`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Arun
// 
// Create Date: 06.07.2025 00:19:01
// Design Name: Counter 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Counter for data loading & control synchronization
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module global_counter(
    input            clk, rst,
    output reg [7:0] count 
    );
    
    always @ (posedge clk)
        begin
            if(rst == 1'b1)
                count <= 'd0;
            else    
                count <= count + 1;
        end
endmodule
