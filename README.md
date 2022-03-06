# AMBA-3-AHB-Lite
System Verilog Test-bench for verification of AMBA 3 AHB-Lite
# TestBench Architecture:
![env](https://user-images.githubusercontent.com/75377950/156923627-68e2f179-047c-4ed1-aed3-170ec8d78150.PNG)
# TestBench Components:
1. Transaction Class 

2. Generator Class 

3. Interface 

4. Driver Class 

5. Monitor Class 

6. Scoreboard Class 

7. Environment Class 

8. Test 

9. TestBench Top 
# Transaction Class:
1. Fields required to generate the stimulus are declared in the transaction class. 

2. Transaction class can also be used as a placeholder for the activity monitored by the monitor on DUT signals. 

3. So, the first step is to declare the Fields in the transaction class.
# Generator Class:
1. Generating the stimulus by randomizing the transaction class.
2. Sending the randomized class to driver.
# Interface:
1. Interface will group the signals, specifies the direction (Modport) and Synchronize the signals(Clocking Block).
# Driver Class:
1. receive the stimulus generated from the generator and drive to DUT by assigning transaction class values to interface signals.
# Monitor Class:
1. Samples the interface signals and converts the signal level activity to the transaction level.
2. Send the sampled transaction to Scoreboard via Mailbox.
# Scoreboard Class:
1. Scoreboard receives the sampled packet from monitor and compares the results.
# Environment:
1. Environment is container class contains Mailbox, Generator, Driver, Monitor and Scoreboard.
# Test:
1. Creating the environment.
2. Configuring the testbench i.e, setting the type and number of transactions to be generated.
3. Initiating the stimulus driving.
# TestBench Top:
1. This is the topmost file, which connects the DUT and TestBench.
2. TestBench top consists of DUT, Test and Interface instances.
3. The interface connects the DUT and TestBench.
# Supported Simulators & Tools:
1. Aldec Riviera Pro 2020.04
2. Cadence Xcelium 20.09
3. Mentor Questa 2021.3
4. Synopsys VCS 2020.03
# Supported Tests:
1. Single Burst
2. Increment Burst of Undefined Length
3. INCR & WRAP Tests (4,8,16 Beats)
# How to run tests:
1. Just press the run button this will executes all test included in the test bench.
////////////////////////////////////////////////////////////ENJOY///////////////////////////////////////////////////////////////////////////
