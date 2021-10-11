module alucontrol(inaluop, infunct, outalu);

input [1:0]inaluop;
input [5:0]infunct;

output [3:0]outalu;

reg [3:0] outalucp;
	
always @ (inaluop, infunct) begin
	case(inaluop)
		2'b00: outalucp <= {4'b0010};
		2'b01: outalucp <= {4'b0110};
		2'b10:
			case(infunct)
				6'b100000: outalucp <= {4'b0010};
				6'b100010: outalucp <= {4'b0110};
				6'b100100: outalucp <= {4'b0000};
				6'b100101: outalucp <= {4'b0001};
				6'b101010: outalucp <= {4'b0111};
				default: outalucp <= {4'b0010};
			endcase
		default: outalucp <= {4'b0010};
	endcase
end

assign outalu = outalucp;

endmodule