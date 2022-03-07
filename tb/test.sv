//A program block that creates the environment and initiate the stimulus
program test(dut_if vif);

environment env;

initial 
begin
 env =new(vif);
 env.create();

 #20;
  
  env.G1.gen_counter = 10; 
  env.random_wr();
  env.random_rd();
  
    repeat(4)      
     begin 
      env.write_sim_gen();  
     end 

  repeat(5)       
    begin 
      env.read_sim_gen();    
    end 
    
  repeat(4)        
     begin 
      env.write_INCR4();    
     end 

  repeat(5)        
    begin 
      env.read_INCR4();    
    end 

    repeat(4)        
     begin 
      env.write_INCR4();    
     end 
  
  repeat(5)       
    begin 
      env.read_INCR4();    
    end
  
  repeat(8)         
     begin 
      env.write_INCR8();  
     end 

  repeat(9)        
    begin 
      env.read_INCR8();    
    end 
  
  repeat(16)        
     begin 
      env.write_INCR16();   
     end 

  repeat(17)         
    begin 
      env.read_INCR16();     
    end 
  
  repeat(env.G1.gen_counter)         
     begin 
      env.write_UND_INCR();    
     end 

  repeat(env.G1.gen_counter+1)      
    begin 
      env.read_UND_INCR();    
    end 
  
  repeat(4)        
     begin 
      env.write_WRAP4();  
     end 

  repeat(5)        
    begin 
      env.read_WRAP4();    
    end 
  
  repeat(8)         
     begin 
      env.write_WRAP8();    
     end 

  repeat(9)        
    begin 
      env.read_WRAP8();    
    end 
  
  repeat(16)        
     begin 
      env.write_WRAP16();     
     end 
  
  repeat(17)       
    begin 
      env.read_WRAP16();   
    end 
  
	$display($time, "WE ARE DONE .. GO HOME AND SLEEP!!! .. ACTUALLY NOT YET .. ");  
end

endprogram

