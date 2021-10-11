module instructionmemory(inadd, outinstruc);

input [31:0]inadd; //, m; //debug

//output[4:0] debug;
//assign debug = x;

output [31:0]outinstruc;

reg [31:0]mem[0:31]; //instruction memory

integer i = 0;

initial begin //Initialise block runs only once at the beginnning
	for (i = 0; i < 32; i = i + 1) begin
		mem[i] = {32'b0};
	end
end

//input [31:0]m;

always @ (*) begin //debug
	mem[0] = 32'h24040000;
	mem[1] = 32'h8c900000;
	mem[2] = 32'h8c910004;
	mem[3] = 32'h8c920010;
	mem[4] = 32'h8c930014;
	mem[5] = 32'h8c850008;
	mem[6] = 32'h8c86000c;
	mem[7] = 32'h00c5402a;
	mem[8] = 32'h11000003;
	mem[9] = 32'h02324820;
	mem[10] = 32'h01304822;
	mem[11] = 32'h10000003;
	mem[12] = 32'h02114820;
	mem[13] = 32'h02535022;
	mem[14] = 32'h012a4820;
	mem[15] = 32'hac890018;
end //debug

wire [4:0]x = inadd >> 2;

assign outinstruc = mem[x];

endmodule