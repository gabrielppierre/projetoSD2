module projeto(clk, btn1, btn2, btn3, btn4, dist1, dist2, dist3, dist4);

input clk, btn1, btn2, btn3, btn4;
output [0:6] dist1, dist2, dist3, dist4;

//Modulo principal
cronometro(clk, btn1, btn2, btn3, btn4, dist1, dist2, dist3, dist4);


endmodule