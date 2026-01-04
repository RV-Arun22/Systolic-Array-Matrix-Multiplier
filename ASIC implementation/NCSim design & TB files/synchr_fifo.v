`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Arun
// 
// Create Date: 05.07.2025 13:41:41
// Design Name: 
// Module Name: synchr_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Synchronous FIFO module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Count based full & empty assertion
// 
//////////////////////////////////////////////////////////////////////////////////


module synchr_fifo #(parameter WIDTH = 8, DEPTH = 8)(
    input                       clk, rst,
    input       [WIDTH-1:0]     data_in,
    input                       wen, ren,                 //write and read enable signals
    output reg  [WIDTH-1:0]     data_out,
    output                      full, empty
    );
    
    reg [WIDTH-1:0] fifo [(DEPTH-1):0];
    reg [2:0] wptr, rptr;                   //write and read pointers for a FIFO of depth 8
    reg [3:0] count;
    integer i;
    initial 
        begin
            for(i = 0; i<DEPTH; i=i+1)
                fifo[i] = 'd0;
        end
    
    assign full = (count == DEPTH);
    assign empty = (count == 0);
    
    always @ (posedge clk)
        begin
            if (rst ==1'b1)
                begin
                    wptr <= 'b0;
                    rptr <= 'b0;
                    count <= 0;
                    data_out <= 'd0;
                end
            else
                begin
                    case ({wen, ren})
                        2'b01: begin
                                   if(!empty)
                                       begin
                                           data_out <= fifo[rptr];
                                           rptr <= rptr + 1'b1;        
                                           count <= count - 1;
                                       end
                               end 
                        2'b10: begin
                                   if(!full)
                                       begin
                                           fifo[wptr] <= data_in;
                                           wptr <= wptr + 1'b1;
                                           count <= count + 1;
                                       end
                               end
                        2'b11: begin
                                   fifo[wptr] <= data_in;
                                   if(!full) begin
                                    wptr <= wptr + 1'b1;
                                    count <= count + 1'b1;
                                   end
                                   else if(!empty) begin
                                    data_out <= fifo[rptr];
                                    rptr <= rptr + 1'b1;
                                    count <= count - 1'b1;
                                   end
                               end
                        2'b00: count <= count;
                    endcase    
                end
        end
endmodule

  //***********************old**************************************
//    always @ (posedge clk)        //write always block
//        begin   
//            if (rst ==1'b1)
//                begin
//                    wptr <= 'b0;
//                    count <= 0;
//                end
//            else if (wen && !full)
//                begin
//                    fifo[wptr] <= data_in;
//                    wptr <= wptr + 1'b1;        //count not updated here as a simultaneous read could occur
//                end
//        end
                
//    always @ (posedge clk)      //read always block
//        begin   
//            if (rst ==1'b1)
//                begin
//                    rptr <= 'b0;
//                    count <= 0;
//                end
//            else if (ren && !empty)
//                begin
//                    data_out <= fifo[rptr];
//                    rptr <= rptr + 1'b1;        //count not updated here as a simultaneous read could occur
//                end
//        end
        
//    always @ (posedge clk)      //count updation always block
//        begin
//            if (rst == 1'b1)
//                count <= 0;
//            else 
//                begin
//                    case ({wen, ren})
//                        2'b01: if(!empty) count <= count - 1'b1;        //data is read, count decreases
//                        2'b10: if(!full) count <= count + 1'b1;         //data is written, count increases
//                        default: count <= count;                        //no update of count if 2'b11 and 2'b00
//                    endcase
//                end
//        end        