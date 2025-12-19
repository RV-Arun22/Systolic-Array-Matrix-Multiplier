`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BITS Pilani
// Engineer: Arun
// 
// Create Date: 16.11.2024 13:32:45
// Design Name: 
// Module Name: PE
// Project Name: Systolic array matrix multiplier
// Target Devices: Zynq 7000
// Tool Versions: 
// Description: Processing element module of SA
// 
// Dependencies: MAC
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: put a mux to enable output writing to memory only after multiplication is over
// 
//////////////////////////////////////////////////////////////////////////////////

module PE(
    output reg [7:0] a_out,
    output reg [7:0] b_out,
    output reg [15:0] c,             //PE final output
    input [7:0] a_in,
    input [7:0] b_in,
    input clk , rst
    );
    //reg [7:0] a1, a2, b1, b2;             //holds 'a' & 'b' values for MAC and push to next stage
    //wire [7:0] a_mac, b_mac;    //sends a & b reg values to MAC
    
    
    always @ (posedge clk)             //clk1 input trigger
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
        
    //multiplier_wrapper M1 (a, b, clk2, mul_out);   //mul IP
    //assign mul_out = a1 * b1;  
         
    /*always @ (posedge clk2)              //must be clk dependent otherwise result won't accumulate if mul and acc stay the same
        begin 
            acc = mul_out + acc;        //addition
            a2 <= a1;       //pass i/p to right side PE
            b2 <= b1;       //pass i/p to PE below
        end
    */
    // assign a_out = a_in;
    // assign b_out = b_in;    
    // assign c = acc;
    //assign mul = mul_out;   //testbench wire for mul o/p
     
    //MAC M1 (c, a_out, b_out, clk, rst); 
     
    
endmodule
