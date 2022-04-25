module cronometro(clk, btn1, btn2, btn3, btn4, dist1, dist2, dist3, dist4);

input clk, btn1, btn2, btn3, btn4;
output [0:6] dist1, dist2, dist3, dist4;

reg [14:0] numero = 0;
reg [14:0] numMostrado = 0;

// 5000000 = 1 decimo de segundo
reg [0:30] i = 0;
parameter dec_segundo = 5000000;

reg [2:0] estado = 0;
wire [3:0] num0, num1, num2, num3;
parameter reseta = 0, conta = 1, pausa = 2, para = 3;
reg [1:0] contar = 0, pausar = 0, parar = 0;

// maquina de estados
always @(posedge clk) begin
	case(estado)
		reseta: begin
			contar <= 0;
			pausar <= 0;
			parar <= 0;
		end
		conta: begin
			contar <= 1;
			pausar <= 0;
			parar <= 0;
		end
		pausa: begin
			contar <= 1;
			pausar <= 1;
			parar <= 0;
		end
		para: begin
			contar <= 0;
			pausar <= 0;
			parar <= 1;
		end
	endcase
end

// maquina de estados 
always @(posedge clk) begin
	case(estado)
		reseta: begin
			if(!btn1) estado = conta;
		end
		conta: begin
			if(!btn2) estado = pausa;
			else if(!btn3) estado = para;
			else if(!btn4) estado = reseta;
		end
		pausa: begin
			if(!btn1) estado = conta;
		end
		para: begin
			if(!btn1) estado = conta;
		end
	endcase
end

// somador
always @(posedge clk) begin
	if(contar == 1) begin
		if(i == dec_segundo) begin
			if(numero < 10000) begin
				numero <= numero + 1;
			end
			else numero <= 0;
		end
		else i <= i + 1;
		
		// numMostrado e o numero que sera mostrado no display, ele so muda caso nao estiver pausado
		if(pausar != 1) begin
			numMostrado <= numero;
		end
	end
	else begin
		i <= 0;
	end
end

// display, cada decodificador e um dos display da FPGA
decodificador d1(.number(num0), .display(dist1));
decodificador d2(.number(num1), .display(dist2));
decodificador d3(.number(num2), .display(dist3));
decodificador d4(.number(num3), .display(dist4));

saidas sd(.num(numMostrado), .num0(num0), .num1(num1), .num2(num2), .num3(num3), .clk(clk));



endmodule