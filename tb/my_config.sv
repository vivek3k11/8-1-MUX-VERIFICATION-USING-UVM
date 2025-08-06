class my_config extends uvm_object;

 `uvm_object_utils(my_config)


 int no_wr_agent=1;
int no_rd_agent=1;
int no_of_transections=23;
int has_virtual_sequence=1;
int has_sb=1;
 virtual mux_if in;
uvm_active_passive_enum is_active=UVM_ACTIVE;


function new(string name="my_config");
	super.new(name);
endfunction


endclass
