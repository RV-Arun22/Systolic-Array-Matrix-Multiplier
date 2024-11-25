`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Myself
// 
// Create Date: 23.11.2024 21:37:43
// Design Name: 
// Module Name: SA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Systolic array implementation for 8-bit matrix multiplication.
//              Array size is parametrized, but not data width. It is set to 8 bits.
// 
// Dependencies: PE
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Assignments have been done because Verilog 2001 doesn't support 
//                      2D declaration. System verilog does.
// 
//////////////////////////////////////////////////////////////////////////////////
module SA #(parameter N = 8)                                //Systolic array size
    (
    output [15:0] C00, C01, C02, C03, C04, C05, C06, C07,
           C10, C11, C12, C13, C14, C15, C16, C17,
           C20, C21, C22, C23, C24, C25, C26, C27,
           C30, C31, C32, C33, C34, C35, C36, C37,
           C40, C41, C42, C43, C44, C45, C46, C47,
           C50, C51, C52, C53, C54, C55, C56, C57,
           C60, C61, C62, C63, C64, C65, C66, C67,
           C70, C71, C72, C73, C74, C75, C76, C77,
    input [7:0] A0,A1,A2,A3,A4,A5,A6,A7,
    input [7:0] B0,B1,B2,B3,B4,B5,B6,B7,                    //8 row A & 8 column B inputs
    input clk, rst
    );
    
    wire [7:0] a_pe [0:N-1][0:N-1];                         //PE interconnects
    wire [7:0] b_pe [0:N-1][0:N-1];
    wire [15:0] c [0:N-1][0:N-1];
    
    
    //Input assignment block 
    assign a_pe[0][0] = rst ? 7'd0 : A0;    //1st column west side input assignment
    assign a_pe[1][0] = rst ? 7'd0 : A1;
    assign a_pe[2][0] = rst ? 7'd0 : A2;
    assign a_pe[3][0] = rst ? 7'd0 : A3;
    assign a_pe[4][0] = rst ? 7'd0 : A4;
    assign a_pe[5][0] = rst ? 7'd0 : A5;
    assign a_pe[6][0] = rst ? 7'd0 : A6;
    assign a_pe[7][0] = rst ? 7'd0 : A7;
    assign b_pe[0][0] = rst ? 7'd0 : B0;    //1st row north side input assignment
    assign b_pe[0][1] = rst ? 7'd0 : B1;
    assign b_pe[0][2] = rst ? 7'd0 : B2;
    assign b_pe[0][3] = rst ? 7'd0 : B3;
    assign b_pe[0][4] = rst ? 7'd0 : B4;
    assign b_pe[0][5] = rst ? 7'd0 : B5;
    assign b_pe[0][6] = rst ? 7'd0 : B6;
    assign b_pe[0][7] = rst ? 7'd0 : B7;
             
    
    //Output pins assignments         
    assign C00 = c[0][0];
    assign C01 = c[0][1];
    assign C02 = c[0][2];
    assign C03 = c[0][3];
    assign C04 = c[0][4];
    assign C05 = c[0][5];
    assign C06 = c[0][6];
    assign C07 = c[0][7];
    assign C10 = c[1][0];
    assign C11 = c[1][1];
    assign C12 = c[1][2];
    assign C13 = c[1][3];
    assign C14 = c[1][4];
    assign C15 = c[1][5];
    assign C16 = c[1][6];
    assign C17 = c[1][7];
    assign C20 = c[2][0];
    assign C21 = c[2][1];
    assign C22 = c[2][2];
    assign C23 = c[2][3];
    assign C24 = c[2][4];
    assign C25 = c[2][5];
    assign C26 = c[2][6];
    assign C27 = c[2][7];
    assign C30 = c[3][0];
    assign C31 = c[3][1];
    assign C32 = c[3][2];
    assign C33 = c[3][3];
    assign C34 = c[3][4];
    assign C35 = c[3][5];
    assign C36 = c[3][6];
    assign C37 = c[3][7];
    assign C40 = c[4][0];
    assign C41 = c[4][1];
    assign C42 = c[4][2];
    assign C43 = c[4][3];
    assign C44 = c[4][4];
    assign C45 = c[4][5];
    assign C46 = c[4][6];
    assign C47 = c[4][7];
    assign C50 = c[5][0];
    assign C51 = c[5][1];
    assign C52 = c[5][2];
    assign C53 = c[5][3];
    assign C54 = c[5][4];
    assign C55 = c[5][5];
    assign C56 = c[5][6];
    assign C57 = c[5][7];
    assign C60 = c[6][0]; 
    assign C61 = c[6][1];
    assign C62 = c[6][2];
    assign C63 = c[6][3];
    assign C64 = c[6][4];
    assign C65 = c[6][5];
    assign C66 = c[6][6];
    assign C67 = c[6][7];
    assign C70 = c[7][0];
    assign C71 = c[7][1];
    assign C72 = c[7][2];
    assign C73 = c[7][3];
    assign C74 = c[7][4];
    assign C75 = c[7][5];
    assign C76 = c[7][6];
    assign C77 = c[7][7];
       
  //SA generate block 
    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) 
            begin: PE_ROW
            for (j = 0; j < N; j = j + 1) 
                begin: PE_COL
                //$display("%d %d %d %d",i , j ,a_pe[i][j+1], b_pe[i+1][j]) ;
                PE PE_inst (a_pe[i][j+1], b_pe[i+1][j],     //a & b outputs
                            c[i][j],                        //individual PE output
                            a_pe[i][j], b_pe[i][j],         //a & b inputs 
                            clk , rst);
                
            end
        end
    endgenerate
       
endmodule
