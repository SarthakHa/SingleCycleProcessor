module alu(ina, inb, incontrol, out, zero);

input [31:0] ina, inb; //two input values to perform arithmetic on

input [3:0] incontrol; //dictates what kind of operation is to be performed

output [31:0] out; //32 bit output

output zero; //set to 1 when output of ALU is 0

reg [31:0]slt;
reg [31:0]outcp;

always @ (*) begin
	slt <= ina - inb;
end

always @ (ina, inb, incontrol) begin

	case (incontrol)
		4'b0000: outcp <= ina & inb; //AND
		4'b0001: outcp <= ina | inb; //OR
		4'b0010: outcp <= ina + inb; //addition
		4'b0110: outcp <= ina - inb; //subtraction
		4'b0111: outcp <= {31'b0, slt[31]}; //set-on-less-than
		default: outcp <= ina + inb;
	endcase

end

assign out = outcp;
assign zero = ~(|out);

endmodule