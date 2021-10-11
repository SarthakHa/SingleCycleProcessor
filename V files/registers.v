module registers(regAdd1,regAdd2,wreg,wdata,out1,out2,regWrite, clock, reset);

input [4:0]regAdd1, regAdd2, wreg; //Address for 2 read regs and write to reg
input regWrite,clock; //Primary control signal to write or not //clock
input reset; //reset line
input [31:0]wdata; //Data to be written
output [31:0]out1,out2; //Output of 

//input [31:0]m; //debug
//output [31:0]m1; //debug

reg [31:0]mem[0:31];

integer i = 0;

initial begin //Initialise block runs only once at the beginnning
	for (i = 0; i < 32; i = i + 1) begin
		mem[i] = {32'b0};
	end
end

always@(posedge clock, posedge reset) begin
	//mem[3] <= m; //debug
	if (reset == 1'b1) begin
		for (i = 0; i < 32; i = i + 1) begin
			mem[i] <= 32'b0;
		end
	end
	else begin
		if (regWrite == 1'b1) begin
			mem[wreg] <= wdata;
		end
	end
end

assign out1 = mem[regAdd1];
assign out2 = mem[regAdd2];
//assign m1 = mem[5]; //debug

endmodule