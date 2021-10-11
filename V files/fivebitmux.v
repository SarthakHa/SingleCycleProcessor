module fivebitmux(a, b, control, out); //5 bit mux

input [4:0] a,b;
input control;
output [4:0]out;

reg [4:0] outcp;

always@(a,b,control) begin
	if (control == 1) begin
		outcp = a;
	end
	else begin
		outcp = b;
	end
end

assign out = outcp;

endmodule