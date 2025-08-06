class my_env extends uvm_env;

 `uvm_component_utils(my_env)
 wr_agent wr_agth;
 rd_agent rd_agth;
 scoreboard sb;
 my_config cfg;
  
function new(string name ="my_env",uvm_component parent);
   super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);	
	super.build_phase(phase);
  if(! uvm_config_db#(my_config)::get(this,"","my_config",cfg))
     `uvm_fatal("MY_CONFIG","config_not get")
  
  wr_agth =wr_agent::type_id::create("wr_agth",this);
  rd_agth =rd_agent::type_id::create("rd_agth",this);
  
  if(cfg.has_sb)
     sb=scoreboard::type_id::create("sb",this);

endfunction
function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  wr_agth.morh.wr_port.connect(sb.wr_tport.analysis_export);
  rd_agth.morh.rd_port.connect(sb.rd_tport.analysis_export);

endfunction

endclass
