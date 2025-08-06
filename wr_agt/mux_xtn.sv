class mux_xtn extends uvm_sequence_item;
   `uvm_object_utils(mux_xtn)

function new(string name ="mux_xtn");
   super.new(name);
endfunction

rand  bit[7:0]in;
rand bit[2:0]sel;
bit out;
constraint ka{in dist {[0:15]:=1,[16:127]:=1};}
constraint ka1{sel dist {[1:0]:=4,[2:3]:=4,[4:5]:=4,[6:7]:=4};}

function void do_print(uvm_printer printer);
  printer.print_field("in",this.in,8,UVM_BIN);
  printer.print_field("sel",this.sel,3,UVM_BIN);
  printer.print_field("out",this.out,1,UVM_DEC);

endfunction


endclass
