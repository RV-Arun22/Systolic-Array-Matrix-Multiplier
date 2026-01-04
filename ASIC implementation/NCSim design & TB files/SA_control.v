`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2025 00:17:27
// Design Name: New SA_control
// Module Name: SA_control
// Project Name: SAMM
// Target Devices: 
// Tool Versions: 
// Description: Module that controls loading of input values from memory to the buffers (FIFOs)
//  present in the SA module.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SA_control(
    input             clk, rst, start,
    //input [2:0] m, n, p, q, //Input matrix dimensions
    input       [7:0] count,
    input       [9:0] addr_mtxA, addr_mtxB,                 //Input matrices' starting addresses
    input       [7:0] emptyR, emptyC, fullR, fullC,         //FIFO empty and full signals 
    output reg  [7:0] wen_row, wen_col, ren_row, ren_col,   //FIFO WEN & REN signals
    output reg  [9:0] ad1, ad2,                             //Address to memory
    output            all_full, all_empty, done             //dummy logic outputs to avoid 'no connection' error in genus & DONE signal
    );
    //parameter S0 = 'd0, S1 = 'd1, S2 = 'd2;   
    //reg [1:0] stateA, nxtA, stateB, nxtB;
    //reg [9:0] addrA, addrB;
    
    reg [4:0] state, nxt;
    
    assign all_full = (&fullR) | (&fullC);
    assign all_empty = (&emptyR) | (&emptyC);
    assign done = (state == 5'd26);
    
    always @ (posedge clk)      //address control
        begin
            if(rst == 1'b1)
                begin
                    ad1 <= 'd0;
                    ad2 <= 'd0;
                end
            else if (start == 1'b1)
                begin
                    ad1 <= addr_mtxA + count;
                    ad2 <= addr_mtxB + count;
                end
            else
                begin
                    ad1 <= ad1;
                    ad2 <= ad2;
                end   
        end
    
    //FSM
    always @ (posedge clk)
        begin
            if (rst == 1'b1)
                state <= 'd0;
            else if (start == 1'b1)
                state <= nxt;
            else
                state <= state;
        end
        
    always @ (*)    //outputs
        begin
            case(state)
                'd0:begin
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd1:begin
                    wen_row = 8'd1;
                    wen_col = 8'd1;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd2:begin
                    wen_row = 8'd2;
                    wen_col = 8'd2;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd3:begin
                    wen_row = 8'd4;
                    wen_col = 8'd4;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd4:begin
                    wen_row = 8'd8;
                    wen_col = 8'd8;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd5:begin
                    wen_row = 8'd16;
                    wen_col = 8'd16;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd6:begin
                    wen_row = 8'd32;
                    wen_col = 8'd32;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd7:begin
                    wen_row = 8'd64;
                    wen_col = 8'd64;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd8:begin
                    wen_row = 8'd128;
                    wen_col = 8'd128;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
                'd9:begin//rc0 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0000_0001;
                    ren_col = 8'b0000_0001;
                    end
                'd10:begin//rc1 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0000_0011;
                    ren_col = 8'b0000_0011;
                    end
                'd11:begin//rc2 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0000_0111;
                    ren_col = 8'b0000_0111;
                    end
                'd12:begin//rc3 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0000_1111;
                    ren_col = 8'b0000_1111;
                    end
                'd13:begin//rc4 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0001_1111;
                    ren_col = 8'b0001_1111;
                    end
                'd14:begin//rc5 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0011_1111;
                    ren_col = 8'b0011_1111;
                    end
                'd15:begin//rc6 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0111_1111;
                    ren_col = 8'b0111_1111;
                    end
                'd16:begin//rc7 on
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1111_1111;
                    ren_col = 8'b1111_1111;
                    end
                'd17:begin//hold state 17, idle state
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1111_1111;
                    ren_col = 8'b1111_1111;
                    end
                'd19:begin//rc0 off
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1111_1110;
                    ren_col = 8'b1111_1110;
                    end
                'd20:begin//rc1 off
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1111_1100;
                    ren_col = 8'b1111_1100;
                    end
                'd21:begin//rc2 off
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1111_1000;
                    ren_col = 8'b1111_1000;
                    end
                'd22:begin//rc3 off
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1111_0000;
                    ren_col = 8'b1111_0000;
                    end
                'd23:begin//rc4 off
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1110_0000;
                    ren_col = 8'b1110_0000;
                    end
                'd24:begin//rc5 off
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1100_0000;
                    ren_col = 8'b1100_0000;
                    end
                'd25:begin//rc6 off
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b1000_0000;
                    ren_col = 8'b1000_0000;
                    end
                'd26:begin//all off, done state
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'b0000_0000;
                    ren_col = 8'b0000_0000;
                    end
                
                default:begin
                    wen_row = 8'd0;
                    wen_col = 8'd0;
                    ren_row = 8'd0;
                    ren_col = 8'd0;
                    end
            endcase
        end
        
    always @ (*)    //nxt state logic
        begin
            case(state)
                'd0: begin
                        if (start == 1'b1) nxt = 'd1; 
                        else nxt = 'd0; 
                     end
                'd1: begin
                        if (count < 'd8)    
                            begin
                                nxt = 'd1;   
                            end
                        else    
                            nxt = 'd2;
                     end       
                'd2: begin
                        if(count < 'd16)   
                            nxt = 'd2;
                        else nxt = 'd3;
                     end
                'd3: begin
                        if(count < 'd24)  
                            nxt = 'd3;
                        else nxt = 'd4;
                     end
                'd4: begin
                        if(count < 'd32) 
                            nxt = 'd4;
                        else nxt = 'd5;
                     end
                'd5: begin
                        if(count < 'd40)  
                            nxt = 'd5;
                        else nxt = 'd6;
                     end 
                'd6: begin
                        if(count < 'd48)   
                            nxt = 'd6;
                        else nxt = 'd7;
                     end
                'd7: begin
                        if(count < 'd56) 
                            nxt = 'd7;
                        else nxt = 'd8;
                     end
                'd8: begin
                        if(count < 'd64)  
                            nxt = 'd8;
                        else nxt = 'd9;
                     end
                'd9: nxt = 'd10;//rc0 on in this state; off wen, on ren
                'd10: nxt = 'd11;//rc1 on in this state..
                'd11: nxt = 'd12;//rc2 on
                'd12: nxt = 'd13;//rc3 on
                'd13: nxt = 'd14;//rc4 on
                'd14: nxt = 'd15;//rc5 on
                'd15: nxt = 'd16;//rc6 on
                'd16: nxt = 'd17;//rc7 on
                //'d17: nxt = 'd18;//idle cycle, needed to latch last input.
                'd17: //turning off read enables.
                      begin
                        if((emptyR[0] | emptyC[0]) == 1'b1)
                            nxt = 'd19;//begin off sequence, rc0 off
                        else
                            nxt = 'd17;
                      end
                'd19: nxt = 'd20;//rc1 off
                'd20: nxt = 'd21;//rc2 off
                'd21: nxt = 'd22;//rc3 off
                'd22: nxt = 'd23;//rc4 off
                'd23: nxt = 'd24;//rc5 off
                'd24: nxt = 'd25;//rc6 off
                'd25: nxt = 'd26;//rc7 off => all off now.        
           endcase
        end
           
endmodule
