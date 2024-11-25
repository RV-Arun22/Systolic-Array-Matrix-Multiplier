`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2024 18:12:49
// Design Name: 
// Module Name: SA_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Brings the inputs to the systolic array
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SA_control(
    output reg [7:0] A1,A2,A3,A4,A5,A6,A7,A8,
    output reg [7:0] B1,B2,B3,B4,B5,B6,B7,B8,
    input[4:0] count
    //input [1:0] select              //ROM file select flag
    );
//input memory block 
    reg [7:0] memory [0:127];
    initial 
        begin
            $display("Loading ROM");
            $readmemh("input_mem.mem", memory);
        end
//control block for 8x8 systolic        
always @ (count)
    begin
   case (count) //Case for A1 and B1
  'd1 : begin A1 <= memory[0]; B1 <= memory[64]; end 
  'd2 : begin A1 <= memory[1]; B1 <= memory[72]; end
  'd3 : begin A1 <= memory[2]; B1 <= memory[80]; end
  'd4 : begin A1 <= memory[3]; B1 <= memory[88]; end
  'd5 : begin A1 <= memory[4]; B1 <= memory[96]; end
  'd6 : begin A1 <= memory[5]; B1 <= memory[104]; end
  'd7 : begin A1 <= memory[6]; B1 <= memory[112]; end
  'd8 : begin A1 <= memory[7]; B1 <= memory[120]; end
  default : begin A1 <= 'b0; B1 <= 'b0; end
endcase

case (count) //Case for A2 and B2
  'd2 : begin A2 <= memory[8]; B2 <= memory[65]; end 
  'd3 : begin A2 <= memory[9]; B2 <= memory[73]; end
  'd4 : begin A2 <= memory[10]; B2 <= memory[81]; end
  'd5 : begin A2 <= memory[11]; B2 <= memory[89]; end
  'd6 : begin A2 <= memory[12]; B2 <= memory[97]; end
  'd7 : begin A2 <= memory[13]; B2 <= memory[105]; end
  'd8 : begin A2 <= memory[14]; B2 <= memory[113]; end
  'd9 : begin A2 <= memory[15]; B2 <= memory[121]; end
  default : begin A2 <= 'b0; B2 <= 'b0; end
endcase

case (count) //Case for A3 and B3
  'd3 : begin A3 <= memory[16]; B3 <= memory[66]; end 
  'd4 : begin A3 <= memory[17]; B3 <= memory[74]; end
  'd5 : begin A3 <= memory[18]; B3 <= memory[82]; end
  'd6 : begin A3 <= memory[19]; B3 <= memory[90]; end
  'd7 : begin A3 <= memory[20]; B3 <= memory[98]; end
  'd8 : begin A3 <= memory[21]; B3 <= memory[106]; end
  'd9 : begin A3 <= memory[21]; B3 <= memory[114]; end
  'd10 : begin A3 <= memory[23]; B3 <= memory[122]; end
  default : begin A3 <= 'b0; B3 <= 'b0; end
endcase

case (count) //Case for A4 and B4
  'd4 : begin A4 <= memory[24]; B4 <= memory[67]; end 
  'd5 : begin A4 <= memory[25]; B4 <= memory[75]; end
  'd6 : begin A4 <= memory[26]; B4 <= memory[83]; end
  'd7 : begin A4 <= memory[27]; B4 <= memory[91]; end
  'd8 : begin A4 <= memory[28]; B4 <= memory[99]; end
  'd9 : begin A4 <= memory[29]; B4 <= memory[107]; end
  'd10 : begin A4 <= memory[30]; B4 <= memory[115]; end
  'd11 : begin A4 <= memory[31]; B4 <= memory[123]; end
  default : begin A4 <= 'b0; B4 <= 'b0; end
endcase

case (count) //Case for A5 and B5
  'd5 : begin A5 <= memory[32]; B5 <= memory[68]; end 
  'd6 : begin A5 <= memory[33]; B5 <= memory[76]; end
  'd7 : begin A5 <= memory[34]; B5 <= memory[84]; end
  'd8 : begin A5 <= memory[35]; B5 <= memory[92]; end
  'd9 : begin A5 <= memory[36]; B5 <= memory[100]; end
  'd10 : begin A5 <= memory[37]; B5 <= memory[108]; end
  'd11 : begin A5 <= memory[38]; B5 <= memory[116]; end
  'd12 : begin A5 <= memory[39]; B5 <= memory[124]; end
  default : begin A5 <= 'b0; B5 <= 'b0; end
endcase

case (count) //Case for A6 and B6
  'd6 : begin A6 <= memory[40]; B6 <= memory[69]; end 
  'd7 : begin A6 <= memory[41]; B6 <= memory[77]; end
  'd8 : begin A6 <= memory[42]; B6 <= memory[85]; end
  'd9 : begin A6 <= memory[43]; B6 <= memory[93]; end
  'd10 : begin A6 <= memory[44]; B6 <= memory[101]; end
  'd11 : begin A6 <= memory[45]; B6 <= memory[109]; end
  'd12 : begin A6 <= memory[46]; B6 <= memory[117]; end
  'd13 : begin A6 <= memory[47]; B6 <= memory[125]; end
  default : begin A6 <= 'b0; B6 <= 'b0; end
endcase

case (count) //Case for A7 and B7
  'd7 : begin A7 <= memory[48]; B7 <= memory[70]; end 
  'd8 : begin A7 <= memory[49]; B7 <= memory[78]; end
  'd9 : begin A7 <= memory[50]; B7 <= memory[86]; end
  'd10 : begin A7 <= memory[51]; B7 <= memory[94]; end
  'd11 : begin A7 <= memory[52]; B7 <= memory[102]; end
  'd12 : begin A7 <= memory[53]; B7 <= memory[110]; end
  'd13 : begin A7 <= memory[54]; B7 <= memory[118]; end
  'd14 : begin A7 <= memory[55]; B7 <= memory[126]; end
  default : begin A7 <= 'b0; B7 <= 'b0; end
endcase


case (count) //Case for A8 and B8
  'd8 : begin A8 <= memory[56]; B8 <= memory[71]; end 
  'd9 : begin A8 <= memory[57]; B8 <= memory[79]; end
  'd10 : begin A8 <= memory[58]; B8 <= memory[87]; end
  'd11 : begin A8 <= memory[59]; B8 <= memory[95]; end
  'd12 : begin A8 <= memory[60]; B8 <= memory[103]; end
  'd13 : begin A8 <= memory[61]; B8 <= memory[111]; end
  'd14 : begin A8 <= memory[62]; B8 <= memory[119]; end
  'd15 : begin A8 <= memory[63]; B8 <= memory[127]; end
  default : begin A8 <= 'b0; B8 <= 'b0; end
endcase

end

endmodule
