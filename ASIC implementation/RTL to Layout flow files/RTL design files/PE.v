`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2025 17:35:42
// Design Name: 
// Module Name: PE
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The basic systolic array unit. Basically a MAC unit, but it also forwards current
//  input to the next PEs (to the right & bottom).
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: don't mind the non-standard port declaration!
// 
//////////////////////////////////////////////////////////////////////////////////


module PE #(parameter WIDTH = 8)(               //Input bit width
    output reg [WIDTH-1:0]      a_out,
    output reg [WIDTH-1:0]      b_out,
    output reg [2*WIDTH-1:0]    c,              //PE final output
    input      [WIDTH-1:0]      a_in,
    input      [WIDTH-1:0]      b_in,
    input                       clk , rst
    );
   
    always @ (posedge clk) 
        begin
            if (rst == 1'b1)
                begin
                    c <= 16'd0 ;
                    a_out <= 8'd0 ;
                    b_out <= 8'd0 ;
                end
            else  
                begin
                    c <= (a_in * b_in) + c ;
                    a_out <= a_in;
                    b_out <= b_in; 
                    $display("%d %d %d",a_in , b_in , c) ;
                end
        end  
endmodule