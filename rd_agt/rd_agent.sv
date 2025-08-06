class rd_agent extends uvm_agent;

 `uvm_component_utils(rd_agent)
  rd_monitor morh;
 //wr_driver drih;
 //wr_sequncer seqh;


function new(string name ="rd_agent",uvm_component parent);
 	super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);	
   super.build_phase(phase);
   morh=rd_monitor::type_id::create("morh",this);
//if(cfg.is_active)
//  begin
//     drih=wr_driver::type_id::create("drih",this);
//      seqh=wr_sequence::type_id::create("seqh",this);
//   end
 

endfunction

//function void connect_phase(uvm_phase phase);

//endfunction




endclass
