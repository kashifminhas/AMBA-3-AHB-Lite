
`define MON_IF vif.MONITOR.monitor_cb
 class monitor;
   
  transaction trans;
  virtual dut_if vif;

  mailbox mon2scb;

  function new(virtual dut_if vif, mailbox mon2scb);
    this.mon2scb = mon2scb;
    this.vif = vif;
  endfunction
  
  task main();
    @(`MON_IF);
    trans = new();
    @(`MON_IF);
    trans.hrdata = `MON_IF.hrdata;
    trans.hready = `MON_IF.hready;
    trans.hresp  = `MON_IF.hresp;
    mon2scb.put(trans);
  endtask : main
endclass