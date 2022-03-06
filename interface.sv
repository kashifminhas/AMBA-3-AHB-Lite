
interface dut_if #(parameter ADD_width  = `AW,
                  			 DATA_width = `DW,
                  			 RESP_width = `RW)
                  (input bit clk,reset);


  logic                  hsel;
  logic [ADD_width-1:0]  haddr;
  logic [1:0]            htrans;
  logic                  hwrite;
  logic [2:0]            hsize;
  logic [2:0]            hburst;
  logic [3:0]            hprot;
  logic [DATA_width-1:0] hwdata;
  logic [DATA_width-1:0] hrdata;
  logic                  hready;
  logic [RESP_width-1:0] hresp;
  logic                  error;
  
  
//Master Clocking block - used for Drivers
  clocking driver_cb @ (posedge clk);
    output hsel, haddr, htrans, hwrite, hsize, hburst, hprot, hwdata, error;
  endclocking
    
//Monitor Clocking block - For sampling by monitor components
  clocking monitor_cb @ (posedge clk);
    input hrdata, hready, hresp; 
  endclocking
  

  modport DRIVER(clocking driver_cb, input clk, reset);
  modport MONITOR(clocking monitor_cb, input clk, reset);
endinterface