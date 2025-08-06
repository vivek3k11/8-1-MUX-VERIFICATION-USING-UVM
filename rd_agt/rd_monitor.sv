class rd_monitor extends uvm_monitor;

 `uvm_component_utils(rd_monitor)
  my_config cfg;
  virtual mux_if.MP_RD in;
  mux_xtn xtn;
  uvm_analysis_port#(mux_xtn)rd_port;

function new(string name ="rd_monitor",uvm_component parent);
   super.new(name,parent);
   rd_port=new("rd_port",this);
endfunction

function void build_phase(uvm_phase phase);
  if(!uvm_config_db#(my_config)::get(this,"","my_config",cfg))
   `uvm_fatal("MY_CONFIG","config data not get")
endfunction

function void connect_phase(uvm_phase phase);
  in=cfg.in;
endfunction

task run_phase(uvm_phase phase);
 forever
  collect_data;
endtask 
 
task collect_data;
 xtn=mux_xtn::type_id::create("xtn");

 xtn.out=in.out;
 //xtn.print;
 rd_port.write(xtn);
 #2;
endtask


endclass
