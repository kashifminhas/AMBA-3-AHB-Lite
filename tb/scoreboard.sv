//Gets the packet from monitor, generates the expected result and compares with the actual result received from the Monitor

class scoreboard;

  transaction pkt1, pkt2;            
  int a_array[*]; 
  
  mailbox drv2scb;        
  mailbox mon2scb; 
  
  logic [31:0] temp_addr;     
  logic [31:0] mem_tb [4096];
  
  function new(mailbox drv2scb, mailbox mon2scb); 
    
    $display("scoreboard function");
    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;

  endfunction

  task data_write();
  
    $display("scoreboard check...");
    
    drv2scb.get(pkt1);     
    mon2scb.get(pkt2);  
   
    if(pkt1.hsize == 3'b010)/////////////////////////Word
      begin
   
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin   
        temp_addr = pkt1.haddr[31:0];
    end
    
    else 
    begin
        temp_addr =  temp_addr +4; 
    end

     a_array[pkt1.haddr] = pkt1.haddr;
    {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1], mem_tb[temp_addr[31:0] +2], mem_tb[temp_addr[31:0] +3]} = pkt1.hwdata;
    
    $display("HADDR from input packet \t %h", pkt1.haddr);
    
    $display("HWDATA FROM input packet \t %h", pkt1.hwdata);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1], mem_tb[temp_addr[31:0] +2], mem_tb[temp_addr[31:0] +3]} );
    

    // assertion to check if data is written correctly 
    assert (pkt1.hwdata == {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1], mem_tb[temp_addr[31:0] +2], mem_tb[temp_addr[31:0] +3]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
      end
 /////////////////////////////////////////////////////////////////////////   
    else if(pkt1.hsize == 3'b001)///////Half Word
      begin
   
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin   
        temp_addr = pkt1.haddr[31:0];
    end
    
    else 
    begin
        temp_addr =  temp_addr +2; 
    end
    
     a_array[pkt1.haddr] = pkt1.haddr;
        if(pkt1.haddr[1]==0)begin
          {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]} = pkt1.hwdata[15:0];
    $display("HADDR from input packet \t %h", pkt1.haddr);
    
    $display("HWDATA FROM input packet \t %h", pkt1.hwdata[15:0]);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]} );
          // assertion to check if data is written correctly 
          assert (pkt1.hwdata[15:0] == {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
        end
          else begin
          {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]} = pkt1.hwdata[31:16]; 
    
    $display("HADDR from input packet \t %h", pkt1.haddr);
    
    $display("HWDATA FROM input packet \t %h", pkt1.hwdata[31:16]);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]} );
                   // assertion to check if data is written correctly 
            assert (pkt1.hwdata[31:16] == {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
          end
      end
        /////////////////////////////////////////////
    
    else if(pkt1.hsize == 3'b000)//////Byte
      begin
   
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin   
        temp_addr = pkt1.haddr[31:0];
    end
    
    else 
    begin
        temp_addr =  temp_addr +1; 
    end
    
     a_array[pkt1.haddr] = pkt1.haddr;
        if(pkt1.haddr[1:0]==0)begin
          {mem_tb[temp_addr[31:0]]} = pkt1.hwdata[7:0];
    $display("HADDR from input packet \t %h", pkt1.haddr);
    
          $display("HWDATA FROM input packet \t %h", pkt1.hwdata[7:0]);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[31:0]]} );
          // assertion to check if data is written correctly 
          assert (pkt1.hwdata[7:0] == {mem_tb[temp_addr[31:0]]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
        end
        else if(pkt1.haddr[1:0]==1) begin
          {mem_tb[temp_addr[31:0]]} = pkt1.hwdata[15:8]; 
    
    $display("HADDR from input packet \t %h", pkt1.haddr);
    
    $display("HWDATA FROM input packet \t %h", pkt1.hwdata[15:8]);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[31:0]]});
                   // assertion to check if data is written correctly 
            assert (pkt1.hwdata[15:8] == {mem_tb[temp_addr[31:0]]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
          end
        else if(pkt1.haddr[1:0]==2) begin
          {mem_tb[temp_addr[31:0]]} = pkt1.hwdata[23:16]; 
    
    $display("HADDR from input packet \t %h", pkt1.haddr);
    
    $display("HWDATA FROM input packet \t %h", pkt1.hwdata[23:16]);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[31:0]]});
                   // assertion to check if data is written correctly 
            assert (pkt1.hwdata[23:16] == {mem_tb[temp_addr[31:0]]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
          end
        else if(pkt1.haddr[1:0]==3) begin
          {mem_tb[temp_addr[31:0]]} = pkt1.hwdata[31:24]; 
    
    $display("HADDR from input packet \t %h", pkt1.haddr);
    
    $display("HWDATA FROM input packet \t %h", pkt1.hwdata[31:24]);
    
    $display(" Data in the memory %h" , {mem_tb[temp_addr[31:0]]});
                   // assertion to check if data is written correctly 
            assert (pkt1.hwdata[31:24] == {mem_tb[temp_addr[31:0]]})
      $display("Data has been written successfully");	
	else  
		$error("Data failed to write");

$display("");
          end
               
      end
    ///////////////////////////////////////
  endtask

  task data_read();

    $display("Scoreboard read ");
  
    drv2scb.get(pkt1);
    mon2scb.get(pkt2);
  
    if(pkt1.hsize == 3'b010)//////////////////////////WORD
      begin
  if(a_array.exists(pkt1.haddr)) begin
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin    
        temp_addr = pkt1.haddr[31:0];
    end
    else 
    begin
        temp_addr =  temp_addr +4;
    end

    $display("temp address = %h", pkt1.haddr);

  $display("Read data from DUT %h", pkt2.hrdata);

    $display("DATA from TB memory %h", {mem_tb[temp_addr], mem_tb[temp_addr + 1], mem_tb[temp_addr +2], mem_tb[temp_addr +3] } );
	

    // assertion to check and read the data from the memory 
    assert (pkt2.hrdata == {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1], mem_tb[temp_addr[31:0] +2], mem_tb[temp_addr[31:0] +3]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");

    
$display("");
   end
      end
    
    
    
    
    else if(pkt1.hsize == 3'b001)//////////////////////////HALF WORD
      begin
  if(a_array.exists(pkt1.haddr)) begin
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin    
        temp_addr = pkt1.haddr[31:0];
    end
    else 
    begin
        temp_addr =  temp_addr +2;
    end
    
    if(pkt1.haddr[1]==0)
      begin

    $display("temp address = %h", pkt1.haddr);

        $display("Read data from DUT %h", pkt2.hrdata[15:0]);

    $display("DATA from TB memory %h", {mem_tb[temp_addr], mem_tb[temp_addr + 1]} );
	

    // assertion to check and read the data from the memory 
        assert (pkt2.hrdata[15:0] == {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");

    
$display("");
   end
    else
      begin
            $display("temp address = %h", pkt1.haddr);

        $display("Read data from DUT %h", pkt2.hrdata[31:16]);

    $display("DATA from TB memory %h", {mem_tb[temp_addr], mem_tb[temp_addr + 1]} );
	

    // assertion to check and read the data from the memory 
        assert (pkt2.hrdata[31:16] == {mem_tb[temp_addr[31:0]], mem_tb[temp_addr[31:0] + 1]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");
      end 
      end
      end  
        
        
        
        
    else if(pkt1.hsize == 3'b000)//////////////////////////BYTE
      begin
  if(a_array.exists(pkt1.haddr)) begin
    if (pkt1.htrans == 2'b10 || pkt1.htrans == 2'b00)
    begin    
        temp_addr = pkt1.haddr[31:0];
    end
    else 
    begin
        temp_addr =  temp_addr +1;
    end
    
    if(pkt1.haddr[1:0]==0)
      begin

    $display("temp address = %h", pkt1.haddr);

        $display("Read data from DUT %h", pkt2.hrdata[7:0]);

    $display("DATA from TB memory %h", {mem_tb[temp_addr]});
	

    // assertion to check and read the data from the memory 
        assert (pkt2.hrdata[7:0] == {mem_tb[temp_addr[31:0]]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");

    
$display("");
   end
    else if(pkt1.haddr[1:0]==1)
      begin
            $display("temp address = %h", pkt1.haddr);

        $display("Read data from DUT %h", pkt2.hrdata[15:8]);

    $display("DATA from TB memory %h", {mem_tb[temp_addr]} );
	

    // assertion to check and read the data from the memory 
        assert (pkt2.hrdata[15:8] == {mem_tb[temp_addr[31:0]]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");
       $display("");
   end 
    
    else if(pkt1.haddr[1:0]==2)
      begin
            $display("temp address = %h", pkt1.haddr);

        $display("Read data from DUT %h", pkt2.hrdata[23:16]);

    $display("DATA from TB memory %h", {mem_tb[temp_addr]} );
	

    // assertion to check and read the data from the memory 
        assert (pkt2.hrdata[23:16] == {mem_tb[temp_addr[31:0]]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");
       $display("");
   end 
    
    else if(pkt1.haddr[1:0]==3)
      begin
            $display("temp address = %h", pkt1.haddr);

        $display("Read data from DUT %h", pkt2.hrdata[31:24]);

    $display("DATA from TB memory %h", {mem_tb[temp_addr]} );
	

    // assertion to check and read the data from the memory 
        assert (pkt2.hrdata[31:24] == {mem_tb[temp_addr[31:0]]})
 		$display("Data read successfully and it matches");
	else
		$error("Data reading failed");
       $display("");
   end
      end 
      end
  endtask
  
endclass
