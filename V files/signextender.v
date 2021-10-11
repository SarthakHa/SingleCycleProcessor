module signextender(a, b);

input [15:0]a;
output [31:0]b;

reg [31:0]bcp;

always@(a,b) begin
		bcp[15:0] = a;
		bcp[31:16] = {16{a[15]}};
end

assign b = bcp;

endmodule