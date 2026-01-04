`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Arun
// 
// Create Date: 05.07.2025 17:58:14
// Design Name: Custom two port RAM
// Module Name: two_port_RAM
// Project Name: SAMM
// Target Devices: 
// Tool Versions: 
// Description: Each port supports both read and write, although not at the same time due to same address line.
//              Reads are combinational and writes are at clk edge.
//              CURRENTLY ONLY READING FROM MEMORY SO NO 'OP' FIELD SPECIFIED.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module two_port_RAM(
    input               clk, rst, //WEN1, WEN2,   //write enable signals
    input       [9:0]   ad1, ad2,               //10-bit address lines, 1024 locations
    //input       [7:0]   wd1, wd2,               //8-bit data write in
    output reg  [7:0]   rd1, rd2               //8-bit data read out 
    );
    
    integer i;
    reg [7:0] mem [0:1023];
    
    initial 
        begin
            for(i = 0; i<1024; i=i+1)
                mem[i] = 'd0;   
            $readmemh("inputs1.mem", mem);
        end
    
    // always @ (posedge clk)
    //     begin
    //         if (rst == 1'b1)
    //             begin   
    //                 for(i = 0; i<1024; i=i+1)
    //                     mem[i] = 'd0;
    //             end
    //         else
    //             begin
    //                 if (WEN1 == 1'b1)
    //                     mem[ad1] <= wd1;
    //                 if (WEN2 ==1'b1)
    //                     mem[ad2] <= wd2;
    //             end
    //     end    
    
    always @ (*)
        begin
            rd1 = mem[ad1];
            rd2 = mem[ad2];
        end
endmodule
