`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2025 17:09:23
// Design Name: 
// Module Name: xlr8_tb
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


module xlr8_tb();
    reg     [9:0]   addr_mtxA, addr_mtxB;
    reg             clk, mem_rst, rst, start;
    wire            all_full, all_empty, done;
    wire    [15:0]  C00, C01, C02, C03, C04, C05, C06, C07,
                    C10, C11, C12, C13, C14, C15, C16, C17,
                    C20, C21, C22, C23, C24, C25, C26, C27,        
                    C30, C31, C32, C33, C34, C35, C36, C37,
                    C40, C41, C42, C43, C44, C45, C46, C47,
                    C50, C51, C52, C53, C54, C55, C56, C57,
                    C60, C61, C62, C63, C64, C65, C66, C67,
                    C70, C71, C72, C73, C74, C75, C76, C77;
    
    xlr8 test_ld_tb (clk, mem_rst, rst, start, 
                     addr_mtxA, addr_mtxB,
                     all_full, all_empty, done,
                     C00, C01, C02, C03, C04, C05, C06, C07,
                     C10, C11, C12, C13, C14, C15, C16, C17,
                     C20, C21, C22, C23, C24, C25, C26, C27,
                     C30, C31, C32, C33, C34, C35, C36, C37,
                     C40, C41, C42, C43, C44, C45, C46, C47,
                     C50, C51, C52, C53, C54, C55, C56, C57,
                     C60, C61, C62, C63, C64, C65, C66, C67,
                     C70, C71, C72, C73, C74, C75, C76, C77
                     );
    
    always #5 clk = ~clk; //100Mz clock
    
    initial 
        begin
            clk = 0; 
            @(posedge clk);
            mem_rst = 0; rst = 1; start = 0; addr_mtxA = 'd0; addr_mtxB = 'd64;
            @(posedge clk);
            rst = 0; start = 1;
            #900 $finish;
        end
    
endmodule