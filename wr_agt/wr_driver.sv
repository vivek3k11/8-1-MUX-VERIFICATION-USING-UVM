class wr_driver extends uvm_driver#(mux_xtn);

 `uvm_component_utils(wr_driver)
  my_config cfg;
  virtual mux_if.MP_WR in1;

function new(string name ="wr_driver",uvm_component parent);
   super.new(name,parent);
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
  begin
    seq_item_port.get_next_item(req);
    send_to_dut(req);
    seq_item_port.item_done();
  end

endtask 
 task send_to_dut(mux_xtn h1);
  // h1.print();
   in1.in<=h1.in;
   in1.sel<=h1.sel;
  #2; 
 endtask

endclass
