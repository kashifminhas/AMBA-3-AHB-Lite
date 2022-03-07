//Gets the packet from monitor, generates the expected result and compares with the actual result received from the Monitor

class scoreboard;

transaction pkt1, pkt2;            
int a_array[*]; 
  
mailbox drv2scb;        
mailbox mon2scb;        
logic [11:0] temp_addr;     
logic [11:0] mem_tb [4096];
  
  function new(mailbox drv2scb, mailbox mon2scb); 
    
    $display("scoreboard function");
    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;

endfunction

task data_write();
  
    $display("scoreboard check...");
    
    drv2scb.get(pkt1);     
    mon2scb.get(pkt2);     
   
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin   
        temp_addr = pkt1.haddr[11:0];
    end
    
    else 
    begin
        temp_addr =  temp_addr +4; 
    end

     a_array[pkt1.haddr] = pkt1.haddr;
    {mem_tb[temp_addr[11:0]], mem_tb[temp_addr[11:0] + 1], mem_tb[temp_addr[11:0] +2], mem_tb[temp_addr[11:0] +3]} = pkt1.hwdata;
    
    $display("HADDR from input packet \t %h", temp_addr);
    
    $display("HWDATA FROM input packet \t %h", pkt1.hwdata);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[11:0]], mem_tb[temp_addr[11:0] + 1], mem_tb[temp_addr[11:0] +2], mem_tb[temp_addr[11:0] +3]} );
    

    // assertion to check if data is written correctly 
    assert (pkt1.hwdata == {mem_tb[temp_addr[11:0]], mem_tb[temp_addr[11:0] + 1], mem_tb[temp_addr[11:0] +2], mem_tb[temp_addr[11:0] +3]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
endtask

task data_read();

    $display("Scoreboard read ");
  
    drv2scb.get(pkt1);
    mon2scb.get(pkt2);
  if(a_array.exists(pkt1.haddr)) begin
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin    
        temp_addr = pkt1.haddr[11:0];
    end
    else 
    begin
        temp_addr =  temp_addr +4;
    end

    $display("temp address = %h", temp_addr);

  $display("Read data from DUT %h", pkt2.hrdata);

    $display("DATA from TB memory %h", {mem_tb[temp_addr], mem_tb[temp_addr + 1], mem_tb[temp_addr +2], mem_tb[temp_addr +3] } );
	

    // assertion to check and read the data from the memory 
    assert (pkt2.hrdata == {mem_tb[temp_addr[11:0]], mem_tb[temp_addr[11:0] + 1], mem_tb[temp_addr[11:0] +2], mem_tb[temp_addr[11:0] +3]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");

    
$display("");
   end
endtask
  
endclass
