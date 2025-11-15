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
  initial begin
    apb_if.reset_n = 1;
    #6ns; apb_if.reset_n = 0;
    #30ns; apb_if.reset_n = 1;
  end

  // Instance of APB Interface:
  cfs_apb_if apb_if(.pclk(clk));
  
  // Start UVM:
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    run_test("");
  end
  
  // DUT Instantiation:
  cfs_aligner dut (
    .clk(clk),
    .reset_n(apb_if.reset_n),

    .paddr(apb_if.paddr),
    .pwrite(apb_if.pwrite),
    .psel(apb_if.psel),
    .penable(apb_if.penable),
    .pwdata(apb_if.pwdata),
    .pready(apb_if.pready),
    .prdata(apb_if.prdata),
    .pslverr(apb_if.pslverr)
  );
  
endmodule