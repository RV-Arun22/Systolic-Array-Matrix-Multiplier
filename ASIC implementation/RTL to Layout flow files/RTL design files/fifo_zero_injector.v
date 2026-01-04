`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2025 13:39:21
// Design Name: 
// Module Name: fifo_zero_injector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Acts like input buffer for the systolic array.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_zero_injector #(parameter WIDTH = 8)(
    input               clk, rst,
    input [(WIDTH-1):0] data_in,
    input               wen, ren,                 //write and read enable signals
    output[(WIDTH-1):0] data_out,
    output              full, empty
    );
    wire [(WIDTH-1):0] fifo_out;
    
    assign data_out = ren? fifo_out : 8'd0;
    
    synchr_fifo FIFO (clk, rst, data_in, wen, ren, fifo_out, full, empty);    
endmodule
