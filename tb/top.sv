module top;


import uvm_pkg::*;
import mux_pkg::*;
mux_if in0();
 mux_8x1 DUT(.in(in0.in),.sel(in0.sel),.out(in0.out));
 


initial
  begin
  `ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif

	uvm_config_db#(virtual mux_if)::set(null,"*","mux_if",in0);
	run_test();

end
endmodule
