`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2024 21:00:48
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
    wire [15:0] C00, C01, C02, C03, C04, C05, C06, C07,
           C10, C11, C12, C13, C14, C15, C16, C17,
           C20, C21, C22, C23, C24, C25, C26, C27,
           C30, C31, C32, C33, C34, C35, C36, C37,
           C40, C41, C42, C43, C44, C45, C46, C47,
           C50, C51, C52, C53, C54, C55, C56, C57,
           C60, C61, C62, C63, C64, C65, C66, C67,
           C70, C71, C72, C73, C74, C75, C76, C77;
     //wire clk1, clk2;
     reg m_clk, rst;
     
     always #5 m_clk = ~m_clk;
    
     Accelerator xlr8 (C00, C01, C02, C03, C04, C05, C06, C07,
           C10, C11, C12, C13, C14, C15, C16, C17,
           C20, C21, C22, C23, C24, C25, C26, C27,
           C30, C31, C32, C33, C34, C35, C36, C37,
           C40, C41, C42, C43, C44, C45, C46, C47,
           C50, C51, C52, C53, C54, C55, C56, C57,
           C60, C61, C62, C63, C64, C65, C66, C67,
           C70, C71, C72, C73, C74, C75, C76, C77,m_clk, rst);
           
     initial 
        begin
            m_clk = 1'b0; rst = 1'b1;
            #32 rst = 1'b0;
            #350 rst = 1'b1;
            #100 rst = 1'b0;
            #100 $finish;
        end
    
//    integer file = 0;
//    integer i = 0;
 
//    initial 
//        begin
//            file = $fopen("C:/Users/rvaru/Desktop/Projects/Vivado_Projects/Systolic_array_multiplier/Systolic_array_multiplier.srcs/sim_1/imports/Desktop/output_mem.coe.txt", "w"); ///location, type of operation
 
//            for(i = 0; i<= 25 ; i = i+1)
//                begin
//                    $fdisplay(file, "%x\t", C0i); /// file id, format spec, source of data %x, %b
//                end
//            $fclose(file);
//        end    
endmodule
