//common cathode 7-segment display.
module SevenSegmentDisplay (
    input wire [7:0] data_in,
    output reg [6:0] seg1_out,seg2_out,seg3_out
);

reg [8:0] result;
// 7-segment display decoder truth table for hexadecimal values
always @*
begin
result = ((data_in * 20'b10111111101100000100) >> 20) +100 ;

    case(result[3:0])
        8'h0: seg1_out = 7'b1000000; // 0
        8'h1: seg1_out = 7'b1111001; // 1
        8'h2: seg1_out = 7'b0100100; // 2
        8'h3: seg1_out = 7'b0110000; // 3
        8'h4: seg1_out = 7'b0011001; // 4
        8'h5: seg1_out = 7'b0010010; // 5
        8'h6: seg1_out = 7'b0000010; // 6
        8'h7: seg1_out = 7'b1111000; // 7
        8'h8: seg1_out = 7'b0000000; // 8
        8'h9: seg1_out = 7'b0010000; // 9
        8'ha: seg1_out = 7'b0001000; // A
        8'hb: seg1_out = 7'b0000011; // B
        8'hc: seg1_out = 7'b1000110; // C
        8'hd: seg1_out = 7'b0100001; // D
        8'he: seg1_out = 7'b0000110; // E
        8'hf: seg1_out = 7'b0001110; // F
        default: seg1_out = 7'b1111111; // Blank (if data_in is out of range)
    endcase 

        case(result[7:4])
        8'h0: seg2_out = 7'b1000000; // 0
        8'h1: seg2_out = 7'b1111001; // 1
        8'h2: seg2_out = 7'b0100100; // 2
        8'h3: seg2_out = 7'b0110000; // 3
        8'h4: seg2_out = 7'b0011001; // 4
        8'h5: seg2_out = 7'b0010010; // 5
        8'h6: seg2_out = 7'b0000010; // 6
        8'h7: seg2_out = 7'b1111000; // 7
        8'h8: seg2_out = 7'b0000000; // 8
        8'h9: seg2_out = 7'b0010000; // 9
        8'ha: seg2_out = 7'b0001000; // A
        8'hb: seg2_out = 7'b0000011; // B
        8'hc: seg2_out = 7'b1000110; // C
        8'hd: seg2_out = 7'b0100001; // D
        8'he: seg2_out = 7'b0000110; // E
        8'hf: seg2_out = 7'b0001110; // F
        default: seg2_out = 7'b1111111; // Blank (if data_in is out of range)
    endcase 

        case({3'b000,result[8]})
        8'h0: seg3_out = 7'b1000000; // 0
        8'h1: seg3_out = 7'b1111001; // 1
        default: seg1_out = 7'b1111111; // Blank (if data_in is out of range)
    endcase 
end

endmodule
