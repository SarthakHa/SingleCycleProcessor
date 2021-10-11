module datamemory(inadd, wdata, outdata, memwrite, memread, clock, reset, m);

input clock, reset; //clock and reset lines

input memwrite, memread; //Inputs from the Primary Control
input [31:0]inadd; //incoming address from ALU
input [31:0]wdata; //Data to be written
output [31:0]outdata; //Data to be outputted to mux

wire [4:0]x = inadd >> 2;

reg [31:0]mem[31:0]; //The actual memory

//reg [31:0]outdatacp;

output [31:0]m; //debug

integer i = 0;
integer j = 0;

initial begin //Initialise block runs only once at the beginnning
	for (i = 0; i < 32; i = i + 1) begin
		mem[i] = 32'b0;
	end
	mem[2] <= 32'd20;
	mem[3] <= 32'd10;
	mem[0] <= 32'd250;
	mem[1] <= 32'd200;
	mem[4] <= 32'd300;
	mem[5] <= 32'd450;
end

always @(posedge reset, posedge clock) begin
	
	if (reset == 1'b1) begin
		for (j = 0; j < 32; j = j + 1) begin
			mem[j] <= 32'b0;
		end
		mem[2] <= 32'd20;
		mem[3] <= 32'd10;
		mem[0] <= 32'd250;
		mem[1] <= 32'd200;
		mem[4] <= 32'd300;
		mem[5] <= 32'd450;
	end
	else begin
		if (memwrite == 1) begin
			mem[x] <= wdata;
		end
	end
	
end

assign m = mem[6]; //debug

//assign outdata = outdatacp;
assign outdata = mem[x];

endmodule