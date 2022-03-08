
`define DRIV_IF vif.DRIVER.driver_cb
class driver;
  
  transaction trans;
  int no_of_trans;

  virtual dut_if vif; 

  mailbox gen2driv;
  mailbox drv2scb;

  function new(virtual dut_if vif, mailbox gen2driv,mailbox drv2scb);
    this.gen2driv = gen2driv;
    this.drv2scb = drv2scb;
    this.vif   = vif;
  endfunction
   
   task drive();
     gen2driv.get(trans);
     $display($time ,"Enter into the driver ");
             
        `DRIV_IF.haddr  <= trans.haddr;
        `DRIV_IF.hwrite <= trans.hwrite;
        `DRIV_IF.htrans <= trans.htrans;        
        `DRIV_IF.hsize  <= trans.hsize;
        `DRIV_IF.hburst <= trans.hburst;
        `DRIV_IF.error  <= 1'b0; 
        `DRIV_IF.hwrite <= trans.hwrite;
        `DRIV_IF.hsel   <= 1'b1;
        `DRIV_IF.hprot  <= trans.hprot;
        @(`DRIV_IF);
        `DRIV_IF.hwdata <= trans.hwdata;
          drv2scb.put(trans);
       $display("%d:\t-----------------------------------------",no_of_trans);
    no_of_trans++;

  endtask : drive
  
endclass
