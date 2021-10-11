module thirtytwobitadder(ina, inb, outc);

input [31:0]ina, inb;

output [31:0]outc;

assign outc = ina + inb;

endmodule