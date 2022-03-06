//Fields required to generate the stimulus are declared in the transaction class
class transaction;
 
  rand bit   [31:0] haddr;
  rand logic [1:0]  htrans;
  rand logic        hwrite;
  rand logic [2:0]  hsize;
  rand logic [2:0]  hburst;
  rand logic [3:0]  hprot;
  rand logic [31:0] hwdata;  
  logic      [31:0] hrdata;
  rand bit          hsel;
  logic             hready;
  logic             hresp;
  logic             error;

  constraint address {
      hsize == 3'b010;
      hprot == 4'b0001;
      hsel == 1;
         };
  constraint c_addr { 
      hsize == `H_SIZE_16 -> haddr[0] == '0;
      hsize == `H_SIZE_32 -> haddr[1:0] == '0;
    haddr inside{[0:1023]};
      solve hsize before haddr;
    }
               
endclass: transaction

