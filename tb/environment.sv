
class environment;
  
  mailbox gen2driv;
  mailbox mon2scb;
  mailbox drv2scb;

  generator  G1;
  driver     D1;
  monitor    M1;
  scoreboard S1;
  
  virtual dut_if vif;

  function new(virtual dut_if vif);
    this.vif = vif;
    endfunction
  
    function void create();
    this.vif = vif;
    gen2driv = new();
    drv2scb =  new();
    mon2scb  = new();
    G1 = new(gen2driv);
    D1 = new(vif,gen2driv,drv2scb);
    M1 = new(vif,mon2scb);
    S1 = new(drv2scb,mon2scb);
    endfunction
  
   task random_wr;
        fork    
            G1.main();
            D1.drive();
            M1.main();
            S1.data_write();
        join
    endtask
  
     task random_rd;
        fork    
            G1.main();
            D1.drive();
            M1.main();
            S1.data_read();
        join
    endtask
  
  
  task write_sim_gen;
        fork    
            G1.write_w_gen();
            D1.drive();
            M1.main();
            S1.data_write();
        join
    endtask
  
     task read_sim_gen;
        fork    
            G1.read_w_gen();
            D1.drive();
            M1.main();
            S1.data_read();
        join
    endtask
  
  
      task write_INCR4;
        fork    
            G1.write_INCR4_gen();
            D1.drive();
            M1.main();
            S1.data_write();
        join
    endtask

    task read_INCR4;
       fork        
        G1.read_INCR4_gen();
        D1.drive();
        M1.main();
        S1.data_read();
       join
    endtask
  
        task write_INCR8;
        fork    
            G1.write_INCR8_gen();
            D1.drive();
            M1.main();
            S1.data_write();
        join
    endtask

    task read_INCR8;
       fork        
        G1.read_INCR8_gen();
        D1.drive();
        M1.main();
        S1.data_read();
       join
    endtask
  
        task write_INCR16;
        fork    
            G1.write_INCR16_gen();
            D1.drive();
            M1.main();
            S1.data_write();
        join
    endtask

    task read_INCR16;
       fork        
        G1.read_INCR16_gen();
        D1.drive();
        M1.main();
        S1.data_read();
       join
    endtask
  
    task write_UND_INCR;
        fork    
            G1.write_UND_INCR_gen();
            D1.drive();
            M1.main();
            S1.data_write();
        join
    endtask

    task read_UND_INCR;
       fork        
        G1.read_UND_INCR_gen();
        D1.drive();
        M1.main();
        S1.data_read();
       join
    endtask
  
    task write_WRAP4;
       fork        
        G1.write_WRAP4_gen();
        D1.drive();
        M1.main();
        S1.data_write();
       join
    endtask
  
  task read_WRAP4;
        fork    
            G1.read_WRAP4_gen();
            D1.drive();
            M1.main();
            S1.data_read();
        join
    endtask

      task write_WRAP8;
       fork        
        G1.write_WRAP8_gen();
        D1.drive();
        M1.main();
        S1.data_write();
       join
    endtask
  
  task read_WRAP8;
        fork    
            G1.read_WRAP8_gen();
            D1.drive();
            M1.main();
            S1.data_read();
        join
    endtask
  
      task write_WRAP16;
       fork        
        G1.write_WRAP16_gen();
        D1.drive();
        M1.main();
        S1.data_write();
       join
    endtask
  
  task read_WRAP16;
        fork    
            G1.read_WRAP16_gen();
            D1.drive();
            M1.main();
            S1.data_read();
        join
    endtask
  
endclass


