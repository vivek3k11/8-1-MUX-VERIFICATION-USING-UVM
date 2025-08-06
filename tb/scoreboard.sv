class scoreboard extends uvm_scoreboard;

 `uvm_component_utils(scoreboard)
  uvm_tlm_analysis_fifo#(mux_xtn)wr_tport;
  uvm_tlm_analysis_fifo#(mux_xtn)rd_tport;
  mux_xtn xtn,xtn1;
  real cov;

covergroup mux_cov;
sel_cp :coverpoint xtn.sel{
           bins sel1to0={0,1};
	   bins sel2to3={2,3};
	   bins sel4to5={4,5};	  
	   bins sel6to7={6,7};
           }
in_cp :coverpoint xtn.in{
          bins arange={[0:100]};
	  bins arange1={[101:127]}; 
          }
sel_X_in: cross sel_cp,in_cp;
endgroup

function new(string name ="scoreboard",uvm_component parent);
 	super.new(name,parent);
        mux_cov=new();
endfunction

function void build_phase(uvm_phase phase);
  wr_tport=new("wr_tport",this);
  rd_tport=new("rd_tport",this);
endfunction

task run_phase(uvm_phase phase);
forever
begin
 //fork
   begin
     wr_tport.get(xtn);
     rf( xtn);
     xtn.print;
   end
   begin
    rd_tport.get(xtn1);
    xtn1.print;

   end 
 //join_any
    mux_cov.sample();
    cop(xtn,xtn1);
end
endtask

task rf( ref mux_xtn xtn);

  case(xtn.sel)
	3'b000 :xtn.out=xtn.in[7];
	3'b001 :xtn.out=xtn.in[6];
	3'b010 :xtn.out=xtn.in[5];
	3'b011 :xtn.out=xtn.in[4];
	3'b100 :xtn.out=xtn.in[3];
	3'b101 :xtn.out=xtn.in[2];
	3'b110 :xtn.out=xtn.in[1];
        3'b111 :xtn.out=xtn.in[0];
	default : xtn.out=1'bx;
  endcase
 endtask

task cop(mux_xtn xtn ,mux_xtn xtn1);
  if(xtn.out==xtn1.out)
    `uvm_info(get_type_name(),"DATA matched",UVM_MEDIUM)
  else
    `uvm_info(get_type_name(),"data mismatched",UVM_MEDIUM)
endtask

function void extract_phase(uvm_phase phase);
  cov=mux_cov.get_coverage();
endfunction
   
function void report_phase(uvm_phase phase);
  `uvm_info(get_type_name(),$sformatf("              MUX COVERAGE IS :---- ---- ---= %f",cov),UVM_MEDIUM)
endfunction

endclass
