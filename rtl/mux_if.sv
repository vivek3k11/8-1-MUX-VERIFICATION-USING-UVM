interface mux_if;

logic [7:0]in;
logic [2:0]sel;
logic out;

modport MP_WR(output in,output sel);
modport MMP_WR(input in,input sel);
modport MP_RD(input out);



endinterface
