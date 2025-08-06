
class test extends uvm_test;

 `uvm_component_utils(test)
  my_env envh;
  int no_wr_agent=1;
  int no_rd_agent=1;
  int no_of_transections=50;
  int has_sb=1;
  my_config cfg;


function new(string name ="test",uvm_component parent);
   super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
   cfg=my_config::type_id::create("cfg");
   if(!uvm_config_db#(virtual mux_if)::get(this,"","mux_if",cfg.in))
	`uvm_fatal("TEST_CONFIG","confi faill")

    cfg.no_wr_agent=no_wr_agent;
    cfg.no_rd_agent=no_rd_agent;
    cfg.no_of_transections=no_of_transections;
    cfg.has_sb=has_sb;
    uvm_config_db#(my_config)::set(this,"*","my_config",cfg);
	
    super.build_phase(phase);
    envh=my_env::type_id::create("envh",this);
endfunction


function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction 



endclass


class mux_test1 extends test;
 `uvm_component_utils(mux_test1)
   seq1 h1;
function new(string name="mux_test1",uvm_component  parent);
  super.new(name,parent);
endfunction
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  h1=seq1::type_id::create("seq1");
  h1.start(envh.wr_agth.seqh);
  phase.drop_objection(this);

endtask

endclass
