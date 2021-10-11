module singlecycleprocessor (clock, reset, debug, aluresult);

input clock, reset;

output [31:0]debug;
output [31:0] aluresult;
//output [31:0]debugtwo;
//output [31:0]debugthree;
//output [31:0]debugfour;
//assign debugfour = programcounter;

reg [31:0] programcounter; //PC

initial begin
	programcounter = {32'b0}; //Initial value of PC is 0
end

//Fetch Instruction
wire [31:0]c,b,a;
thirtytwobitadder firstAdder(programcounter, 32'd4, b);
mux pcmux(pcmuxinbot, b, branchingControl, c);
wire branchingControl = branch & zeroLine;

//Instruction Memory
wire [31:0]imOut;
instructionmemory im(programcounter, imOut);

//Primary Control
wire regDst, branch, memRead, memToReg, memWrite, ALUSrc, regWrite;
wire [1:0]ALUop;
primarycontrol control(imOut[31:26], regDst, branch, memRead, memToReg, ALUop, memWrite, ALUSrc, regWrite);

//sign-extension and adder
wire [31:0]extLine, extLineShifted, pcmuxinbot;
signextender signext(imOut[15:0], extLine);
assign extLineShifted = extLine << 2;
thirtytwobitadder secondAdder(b, extLineShifted, pcmuxinbot);

//registers
wire [4:0]fivebitmuxout;
fivebitmux wRmux(imOut[15:11], imOut[20:16], regDst, fivebitmuxout);
wire [31:0]regOutOne, regOutTwo;
registers regs(imOut[25:21],imOut[20:16],fivebitmuxout,writebackVal,regOutOne,regOutTwo,regWrite, clock, reset);

//ALU, connected mux, and alucontrol
wire [31:0]alumuxout, aluresult;

wire zeroLine;

wire [3:0]aluControlLine;

mux aluMux(extLine, regOutTwo, ALUSrc, alumuxout);

alu primaryalu(regOutOne, alumuxout, aluControlLine, aluresult, zeroLine);

alucontrol alucon(ALUop, imOut[5:0], aluControlLine);

//Data memory and output mux

wire [31:0] dataout, writebackVal;

datamemory data(aluresult, regOutTwo, dataout, memWrite, memRead, clock, reset, debug);

mux writebackmux(dataout, aluresult, memToReg, writebackVal);

always @ (posedge clock, posedge reset) begin
	
	if(reset == 1) begin
		programcounter <= 32'd0;
	end
	else begin
		programcounter <= c;
	end
end

endmodule