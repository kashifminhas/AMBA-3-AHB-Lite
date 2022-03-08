//A program block that creates the environment and initiate the stimulus
program test(dut_if vif);

environment env;

initial 
begin
 env =new(vif);
 env.create();
  
  env.G1.gen_counter = 500; 
      
    repeat(4)      
     begin 
      env.write_sim_gen();  
     end 
  #20;
  repeat(4)       
    begin 
      env.read_sim_gen();    
    end 
  
      repeat(4)      
     begin 
      env.write_sim_hw_gen();  
     end 
  #20;
  repeat(4)       
    begin 
      env.read_sim_hw_gen();    
    end 

        repeat(4)      
     begin 
      env.write_sim_by_gen();  
     end 
  #20;
  repeat(4)       
    begin 
      env.read_sim_by_gen();    
    end 
    
  repeat(4)        
     begin 
      env.write_INCR4();    
     end 
  #20;
  repeat(4)        
    begin 
      env.read_INCR4();    
    end 

  repeat(8)         
     begin 
      env.write_INCR8();  
     end 
  #20;
  repeat(8)        
    begin 
      env.read_INCR8();    
    end 

 
  repeat(16)        
     begin 
      env.write_INCR16();   
     end 
 #20;
  repeat(16)         
    begin 
      env.read_INCR16();     
    end 
 
 
  repeat(4)        
     begin 
      env.write_WRAP4();  
     end 
  #20;
  repeat(4)        
    begin 
      env.read_WRAP4();    
    end 

  
  repeat(8)         
     begin 
      env.write_WRAP8();    
     end 
  #20;
  repeat(8)        
    begin 
      env.read_WRAP8();    
    end 


  repeat(16)        
     begin 
      env.write_WRAP16();     
     end 
 #20;
  repeat(16)       
    begin 
      env.read_WRAP16();   
    end 
 

      repeat(env.G1.gen_counter)         
     begin 
      env.write_UND_INCR();    
     end 
 #20;
  repeat(env.G1.gen_counter+1)      
    begin 
      env.read_UND_INCR();    
    end 

  
    repeat(env.G1.gen_counter)begin
  env.random();
  end
  
	$display($time, "WE ARE DONE");  
end

endprogram

