module contador(num, estado, numout, numTotal, clk);

input clk;
input [2:0] estado;
input [14:0] num;
output reg [14:0] numout, numTotal;

// 5000000 = 1 decimo de segundo
reg [0:30] i = 0;
parameter dec_segundo = 5000000;
reg [14:0] numTemporario;

always @(posedge clk) begin
	numTemporario <= num;
	// if conta ou pausa
	if(estado == 1 || estado == 2) begin
		if(i == dec_segundo) begin
			if(numTemporario < 10000) begin
				numTemporario <= numTemporario + 1;
			end
			else begin
				numTemporario <= 0;
			end
			i <= 0;
		end
		else i <= i + 1;
		
		// if !pausa
		if(estado != 2) begin
			numout <= numTemporario;
		end
	end
	else i <= 0;
	
	// if reseta
	if(estado == 0) begin
		numTotal <= 0;
		numout <= 0;
	end else numTotal <= numTemporario;
end

endmodule