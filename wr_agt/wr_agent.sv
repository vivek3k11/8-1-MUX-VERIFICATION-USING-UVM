class wr_agent extends uvm_agent;

 `uvm_component_utils(wr_agent)
  wr_monitor morh;
  wr_driver drh;
  wr_sequencer seqh;
  my_config cfg;

function new(string name ="wr_agent",uvm_component parent);
   super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);	
 super.build_phase(phase);
 if(!uvm_config_db#(my_config)::get(this,"","my_config",cfg))
   `uvm_fatal("MY_CONFIG","config data not get")

 morh=wr_monitor::type_id::create("morh",this);
if(cfg.is_active)
   begin
      drh=wr_driver::type_id::create("drh",this);
      seqh=wr_sequencer::type_id::create("seqh",this);
   end
endfunction

function void connect_phase(uvm_phase phase);
   drh.seq_item_port.connect(seqh.seq_item_export);
endfunction

endclass
