
`include "amba_ahb_defines.v"
`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

module testbench_top;
  
logic clk,reset;

always
begin
	forever begin
		#5 clk = ~clk;	
	end
end  	
  
initial begin
    clk = 1;
	reset = 0;
	#10;
	reset = 1;
    #3000;
    $stop; 
end

  dut_if vif(clk,reset);
  
  test t1(vif);
  
  amba_ahb_slave DUT (
              .hclk(vif.clk),
              .hresetn(vif.reset),
              .hsel(vif.hsel),
              .haddr(vif.haddr),
              .htrans(vif.htrans),
              .hwrite(vif.hwrite),
              .hsize(vif.hsize),
              .hburst(vif.hburst),
              .hprot(vif.hprot),
              .hwdata(vif.hwdata),
              .hrdata(vif.hrdata),
              .hready(vif.hready),
              .hresp(vif.hresp),
              .error('0)
                    );
  
  
  initial begin
  $dumpfile("dump.vcd"); 
  $dumpvars;
  end

  covergroup cover_burst @(posedge clk);
    option.per_instance =  1;
    option.goal         =  40;
    option.weight       =  20;
    option.at_least     =  1;
    coverpoint vif.hburst {
      bins SINGLE   = {3'b000};
      bins INCR     = {3'b001};
      bins WRAP4    = {3'b010};
      bins INCR4    = {3'b011};
      bins WRAP8    = {3'b100};
      bins INCR8    = {3'b101};
      bins WRAP16   = {3'b110};
      bins INCR16   = {3'b111};
    }
  endgroup
	
  covergroup cover_size @(posedge clk);
    coverpoint vif.hsize {
      bins Word              = {3'b010};
    }
  endgroup

  
  covergroup cover_trans @(posedge clk);
    option.per_instance = 1;
    option.goal         = 40;
    option.weight       = 20;
    option.at_least     =  1;
    coverpoint vif.htrans {
      bins trans_idle_idle   = (2'b00  => 2'b00);
      bins trans_idle_busy   = (2'b00  => 2'b01);
      bins trans_busy_nonseq = (2'b01  => 2'b10 );
      bins trans_nonseq_seq  = (2'b10  => 2'b11 );
      bins trans_nonseq_busy = (2'b10  => 2'b01);
      bins trans_nonseq_idle = (2'b10 => 2'b00);
      bins trans_nonseq_nonseq  = (2'b10 => 2'b10);		
      bins trans_seq_nonseq  = (2'b11 => 2'b10);			
    }
  endgroup

 
  covergroup cover_address @(posedge clk);
    option.per_instance = 1;
    coverpoint vif.haddr {
      bins zero = {[0:8]};
      bins low[4] = {[8:16]};
      bins med[4] = {[16:64]};
      bins high[4] = {[64:256]};
      bins misc = default;
    }
  endgroup

  
  covergroup cross_cover_HBURST_HSIZE @(posedge clk);
    option.per_instance = 1;
    coverpoint vif.hburst {
      bins SINGLE   = {3'b000};
      bins INCR     = {3'b001};
      bins WRAP4    = {3'b010};
      bins INCR4    = {3'b011};
      bins WRAP8    = {3'b100};
      bins INCR8    = {3'b101};
      bins WRAP16   = {3'b110};
      bins INCR16   = {3'b111};
    }
    coverpoint vif.hsize {
      bins Word              = {3'b010};
    }
    cross vif.hburst, vif.hsize;
  endgroup

  cover_burst cg1;
  cover_size cg2;
  cover_trans cg3;
  cover_address cg4;
  cross_cover_HBURST_HSIZE cg5;
  
  initial
    begin
    cg1 =new();
    cg2 = new();
    cg3 = new();
    cg4 = new();
    cg5 = new();
    end

endmodule