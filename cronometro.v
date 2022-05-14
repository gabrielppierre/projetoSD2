module cronometro(clk, btn1, btn2, btn3, btn4, dist1, dist2, dist3, dist4);

input clk, btn1, btn2, btn3, btn4;
// bt1 = contar
// btn2 = pausar
// btn3 = parar
// btn4 = reset

output [0:6] dist1, dist2, dist3, dist4;

wire [14:0] numero;
wire [14:0] numMostrado;

reg [2:0] estado = 0;
reg [3:0] num0, num1, num2, num3;
parameter reseta = 0, conta = 1, pausa = 2, para = 3;
reg [1:0] contar = 0, pausar = 0, parar = 0;

// maquina de estados
always @(negedge clk) begin
	if(estado == conta || estado == pausa) begin
		if(i + 1 == dec_segundo) begin
			if(numero < 10000) begin
				numero <= numero + 1;
			end
			else nummero <= 0;
			i <= 0;
		end
		else i <= i + 1;
	end
	else begin 
		i <= 0;
	end

	if(estado != pausa) begin
		numMostrado <= numero;
	end

	if(estado == reseta) begin
		numero <= 0000;
		numMostrado <= 0000;
	end
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
			if(!btn3) estado = para;
			if(!btn4) estado = reseta;
		end
		para: begin
			if(!btn1) estado = conta;
			if(!btn4) estado = reseta;
		end
	endcase
end

//digitos
always @(numMostrado) begin
	num0 <= numMostrado % 10;
	num1 <= (numMostrado / 10) % 10;
	num2 <= (numMostrado / 100) % 10;
	num3 <= (numMostrado / 1000) % 10;
end

// display, cada decodificador e um dos display da FPGA
decodificador d1(.number(num0), .display(dist1));
decodificador d2(.number(num1), .display(dist2));
decodificador d3(.number(num2), .display(dist3));
decodificador d4(.number(num3), .display(dist4));


endmodule