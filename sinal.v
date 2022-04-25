module sinal(clk, btn, light, dis0, dis1);

input clk, btn;
reg pressed = 0;
reg [0:30] i = 0;
parameter segundo = 50000000;
reg [3:0] number = 0;

parameter pare = 0, siga = 1;
reg state = 0, next_state = 0;
output light;
assign light = state;

always @ (negedge clk) begin
	case(state)
		pare: begin
			if(!btn) pressed <= 1;
			if(number == 5 || (btn & pressed)) begin
				next_state <= siga;
				pressed <= 0;
			end
		end
		siga: begin
			pressed <= 0;
			if(number == 5) begin
				next_state <= pare;
			end
		end
	endcase
end

always @ (posedge clk) begin
	if(state == next_state) begin
		if(i == segundo) begin
			number <= number +1;
			i <= 0;
		end
		else i <= i +1;
	end
	else begin
		state <= next_state;
		i <= 0;
		number <= 0;
	end
end

output [0:6] dis0, dis1;
reg [3:0] num0, num1;

always @ (number) begin
	num0 <= number % 10;
	num1 <= number / 10;
end

decodificador(.number(num0), .display(dis0));
decodificador dec(num1, dis1);

//////

endmodule