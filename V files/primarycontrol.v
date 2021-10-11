module primarycontrol (in, regdst, branch, memread, memtoreg, aluop, memwrite, alusrc, regwrite);

input [5:0]in;

output regdst, branch, memread, memtoreg, memwrite, alusrc, regwrite;

output [1:0]aluop;

reg [8:0]state;

always @ (*) begin

	case (in)
		6'b000000: //R-format
			state <= {9'b100100010};
		6'b100011: //lw
			state <= {9'b011110000};
		6'b101011: //sw
			state <= {9'b010001000};
		6'b000100: //beq
			state <= {9'b000000101};
	endcase
end

assign aluop = state[1:0];
assign branch = state[2];
assign memwrite = state[3];
assign memread = state[4];
assign regwrite = state[5];
assign memtoreg = state[6];
assign alusrc = state[7];
assign regdst = state[8];

endmodule