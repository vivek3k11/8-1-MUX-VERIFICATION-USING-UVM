class wr_monitor extends uvm_monitor;

 `uvm_component_utils(wr_monitor)
  my_config cfg;
  virtual mux_if.MMP_WR in1;
  mux_xtn xtn1;
  uvm_analysis_port#(mux_xtn)wr_port;
function new(string name ="wr_monitor",uvm_component parent);
    super.new(name,parent);
    wr_port=new("wr_port",this);
endfunction

function void build_phase(uvm_phase phase);
  if(!uvm_config_db#(my_config)::get(this,"","my_config",cfg))
    `uvm_fatal("MY_CONFIG","config data not get")
 endfunction

function void connect_phase(uvm_phase phase);
   in1=cfg.in;
endfunction

task run_phase(uvm_phase phase);
 forever
  collect_data;
endtask 

task collect_data;
  xtn1=mux_xtn::type_id::create("xtn1");
  xtn1.in=in1.in;
  xtn1.sel=in1.sel;
 // xtn1.print;
  wr_port.write(xtn1);
  #2;
endtask

endclass
