module saidas(num, num0, num1, num2, num3, clk);
	
	input clk;
	input [14:0] num;
	output [3:0] num0, num1, num2, num3;	
	
	//cada num e um digito especifico do numero
	assign num0 = num % 10;
	assign num1 = (num / 10) % 10;
	assign num2 = (num / 100) % 10;
	assign num3 = (num / 1000) % 10;
	
endmodule