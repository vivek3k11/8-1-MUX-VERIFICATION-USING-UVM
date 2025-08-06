class wr_sequence extends uvm_sequence#(mux_xtn);
   `uvm_object_utils(wr_sequence)
    my_config cfg;
function new(string name="wr_sequence");
   super.new(name);
endfunction

task body();
  if(! uvm_config_db#(my_config)::get(null,get_full_name(),"my_config",cfg))
     `uvm_fatal("MY_CONFIG","config_not get")
endtask

endclass

//seq1
class seq1 extends wr_sequence;
  `uvm_object_utils(seq1)

function new(string name="seq1");
  super.new(name);
endfunction

task body();
  super.body();
  repeat(cfg.no_of_transections)
    begin
     req=mux_xtn::type_id::create("req");
     start_item(req);
     assert(req.randomize());
    finish_item(req);
  end
endtask

endclass

