`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Arun
// 
// Create Date: 24.11.2024 19:07:53
// Design Name: 
// Module Name: Accelerator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top module of the accelerator
// 
// Dependencies: SA, counter, SA_control
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: parameter N given in SA module and this top module "accelerator"
// 
//////////////////////////////////////////////////////////////////////////////////


module Accelerator #(parameter N = 8)   //array size
    (
     output [15:0] C00, C01, C02, C03, C04, C05, C06, C07,
           C10, C11, C12, C13, C14, C15, C16, C17,
           C20, C21, C22, C23, C24, C25, C26, C27,
           C30, C31, C32, C33, C34, C35, C36, C37,
           C40, C41, C42, C43, C44, C45, C46, C47,
           C50, C51, C52, C53, C54, C55, C56, C57,
           C60, C61, C62, C63, C64, C65, C66, C67,
           C70, C71, C72, C73, C74, C75, C76, C77,
     input m_clk, rst                                   //FPGA master clock, push button rst
    );
    wire [7:0] A0,A1,A2,A3,A4,A5,A6,A7;     //west side inputs
    wire [7:0] B0,B1,B2,B3,B4,B5,B6,B7;     //north side inputs
    //wire [15:0] c [0:N][0:N];             //output matrix wires
    //wire clk1, clk2;                      //normal and skew clocks
    wire [4:0] count;                       //count variable
    reg stop;                              //stop multiplication flag
    
    //clk_wiz_0 clock_generator (clk1, clk2, rst, , m_clk);
    assign clk = m_clk & (~stop);
    SA multiplier  (C00, C01, C02, C03, C04, C05, C06, C07,
                    C10, C11, C12, C13, C14, C15, C16, C17,
                    C20, C21, C22, C23, C24, C25, C26, C27,
                    C30, C31, C32, C33, C34, C35, C36, C37,
                    C40, C41, C42, C43, C44, C45, C46, C47,
                    C50, C51, C52, C53, C54, C55, C56, C57,
                    C60, C61, C62, C63, C64, C65, C66, C67,
                    C70, C71, C72, C73, C74, C75, C76, C77,            //outputs
                    A0,A1,A2,A3,A4,A5,A6,A7,                             
                    B0,B1,B2,B3,B4,B5,B6,B7,
                    clk, rst);
     SA_control ctrl (A0,A1,A2,A3,A4,A5,A6,A7,
                      B0,B1,B2,B3,B4,B5,B6,B7,
                      count);
     counter global_count (count, clk, rst);
     
     always @ (posedge m_clk)
        begin
            if (rst)
                stop <= 1'b0;
            else if (count > 25)
                stop <=1'b1;
        end
             
endmodule

module counter (                                //global clk cycle count keeper
    output reg [4:0] count,
    input clk, rst
    );
    always @ (posedge clk)
        begin
            if (rst)
                begin
                    count <= 7'd0;
                end
//            if (count > 25)
//                begin
//                    stop <= 1'b1;
//                    count <= 1'b0;
//                end
            else    
                count <= count + 1'd1;    
        end
endmodule
