`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Arun
// 
// Create Date: 05.07.2025 23:06:44
// Design Name: Top module
// Module Name: xlr8
// Project Name: SAMM
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

`include "counter.v"
`include "two_port_RAM.v"
`include "synchr_fifo.v"
`include "fifo_zero_injector.v"
`include "SA.v"
`include "PE.v"
`include "SA_control.v"

module xlr8(
    input         clk, mem_rst, rst, start,
    input  [9:0]  addr_mtxA, addr_mtxB,                     //Input matrices' starting addresses
    output        all_full, all_empty, done,                //dummy logic outputs & DONE signal
    output [15:0] C00, C01, C02, C03, C04, C05, C06, C07,   //Output values for TB
                  C10, C11, C12, C13, C14, C15, C16, C17,
                  C20, C21, C22, C23, C24, C25, C26, C27,
                  C30, C31, C32, C33, C34, C35, C36, C37,
                  C40, C41, C42, C43, C44, C45, C46, C47,
                  C50, C51, C52, C53, C54, C55, C56, C57,
                  C60, C61, C62, C63, C64, C65, C66, C67,
                  C70, C71, C72, C73, C74, C75, C76, C77
    );
    wire [7:0] count;
    wire [7:0] A0,A1,A2,A3,A4,A5,A6,A7;             // 8 rows; 'A' data inputs
    wire [7:0] B0,B1,B2,B3,B4,B5,B6,B7;             // 8 columns; 'B' data inputs
    wire [7:0] rd1, rd2/*, wd1, wd2*/;                  //read and write data lines from the two memory ports
    wire [7:0] wen_row, wen_col, ren_row, ren_col;  //WEN & REN for row and col FIFOs
    wire [7:0] emptyR, emptyC, fullR, fullC;        //FIFO empty and full signals   
    wire [9:0] ad1, ad2;                            //Address lines to 2-port memory
    //wire       WEN1, WEN2;                          //Write Enable signals for 2-port memory

//**Currently unused signals below, defined as a single multibit wire above already**
    // //FIFO Write Enable Signals
    // wire wenR0, wenR1, wenR2, wenR3, wenR4, wenR5, wenR6, wenR7;
    // wire wenC0, wenC1, wenC2, wenC3, wenC4, wenC5, wenC6, wenC7;
    // //FIFO Read Enable Signals
    // wire renR0, renR1, renR2, renR3, renR4, renR5, renR6, renR7;
    // wire renC0, renC1, renC2, renC3, renC4, renC5, renC6, renC7;
    
    // assign {wenR7, wenR6, wenR5, wenR4, wenR3, wenR2, wenR1, wenR0} = wen_row;
    // assign {wenC7, wenC6, wenC5, wenC4, wenC3, wenC2, wenC1, wenC0} = wen_col;
    // assign {renR7, renR6, renR5, renR4, renR3, renR2, renR1, renR0} = ren_row;
    // assign {renC7, renC6, renC5, renC4, renC3, renC2, renC1, renC0} = ren_col;
    
    //assign {emptyR7, emptyR6, emptyR5, emptyR4, emptyR3, emptyR2, emptyR1, emptyR0} = emptyR;
    //assign {emptyC7, emptyC6, emptyC5, emptyC4, emptyC3, emptyC2, emptyC1, emptyC0} = emptyC;
    //assign {fullR7, fullR6, fullR5, fullR4, fullR3, fullR2, fullR1, fullR0} = fullR;
    //assign {fullC7, fullC6, fullC5, fullC4, fullC3, fullC2, fullC1, fullC0} = fullC;
//**************************************************************************************************************  
    two_port_RAM RAM (clk, mem_rst, //WEN1, WEN2, 
                      ad1, ad2, //wd1, wd2, 
                      rd1, rd2);
    //Row FIFO buffers
    fifo_zero_injector R0 (clk, rst, rd1, wen_row[0], ren_row[0], A0, fullR[0], emptyR[0]);
    fifo_zero_injector R1 (clk, rst, rd1, wen_row[1], ren_row[1], A1, fullR[1], emptyR[1]);
    fifo_zero_injector R2 (clk, rst, rd1, wen_row[2], ren_row[2], A2, fullR[2], emptyR[2]);
    fifo_zero_injector R3 (clk, rst, rd1, wen_row[3], ren_row[3], A3, fullR[3], emptyR[3]);
    fifo_zero_injector R4 (clk, rst, rd1, wen_row[4], ren_row[4], A4, fullR[4], emptyR[4]);
    fifo_zero_injector R5 (clk, rst, rd1, wen_row[5], ren_row[5], A5, fullR[5], emptyR[5]);
    fifo_zero_injector R6 (clk, rst, rd1, wen_row[6], ren_row[6], A6, fullR[6], emptyR[6]);
    fifo_zero_injector R7 (clk, rst, rd1, wen_row[7], ren_row[7], A7, fullR[7], emptyR[7]);

    //Column FIFO buffers
    fifo_zero_injector C0 (clk, rst, rd2, wen_col[0], ren_col[0], B0, fullC[0], emptyC[0]);
    fifo_zero_injector C1 (clk, rst, rd2, wen_col[1], ren_col[1], B1, fullC[1], emptyC[1]);
    fifo_zero_injector C2 (clk, rst, rd2, wen_col[2], ren_col[2], B2, fullC[2], emptyC[2]);
    fifo_zero_injector C3 (clk, rst, rd2, wen_col[3], ren_col[3], B3, fullC[3], emptyC[3]);
    fifo_zero_injector C4 (clk, rst, rd2, wen_col[4], ren_col[4], B4, fullC[4], emptyC[4]);
    fifo_zero_injector C5 (clk, rst, rd2, wen_col[5], ren_col[5], B5, fullC[5], emptyC[5]);
    fifo_zero_injector C6 (clk, rst, rd2, wen_col[6], ren_col[6], B6, fullC[6], emptyC[6]);
    fifo_zero_injector C7 (clk, rst, rd2, wen_col[7], ren_col[7], B7, fullC[7], emptyC[7]);
    
    SA_control ctrl(
        clk, rst, start,  
        //input [2:0] m, n, p, q,               //Input matrix dimensions
        count,
        addr_mtxA, addr_mtxB,                   //Input matrices' starting addresses
        emptyR, emptyC, fullR, fullC,
        wen_row, wen_col, ren_row, ren_col,
        ad1, ad2,
        all_full, all_empty, done               //dummy logic outputs & DONE signal
        );
    
    SA multiplier  (C00, C01, C02, C03, C04, C05, C06, C07,     //outputs
                    C10, C11, C12, C13, C14, C15, C16, C17,
                    C20, C21, C22, C23, C24, C25, C26, C27,
                    C30, C31, C32, C33, C34, C35, C36, C37,
                    C40, C41, C42, C43, C44, C45, C46, C47,
                    C50, C51, C52, C53, C54, C55, C56, C57,
                    C60, C61, C62, C63, C64, C65, C66, C67,
                    C70, C71, C72, C73, C74, C75, C76, C77,            
                    A0,A1,A2,A3,A4,A5,A6,A7,                             
                    B0,B1,B2,B3,B4,B5,B6,B7,
                    ~clk, rst);
                    
    global_counter counts (clk, rst, start, count);
    
endmodule
