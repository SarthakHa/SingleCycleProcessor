module mux(a, b, control, out); //32 Bit Mux

input [31:0]a, b;
input control;
output [31:0]out;

reg [31:0]outcp;

always @(control,a,b)
begin

	if (control == 1) begin
		outcp = a;
	end
	else begin
		outcp = b;
	end

end

assign out = outcp;

endmodule