`include "cfs_algn_test_pkg.sv"

module testbench();
  
  // Package Imports:
  import uvm_pkg::*;
  import cfs_algn_test_pkg::*;

  // Clock Generation:
  logic clk;
  
  initial clk = 0;
  always #(5ns) clk = ~clk;
  
  // Reset Generation:
  logic reset_n;
  
  initial begin
    reset_n = 1;
    #6ns; reset_n = 0;
    #30ns; reset_n = 1;
  end
  
  // Start UVM:
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    run_test("");
  end
  
  // DUT Instantiation:
  cfs_aligner dut (
    .clk(clk),
    .reset_n(reset_n)
  );
  
endmodule