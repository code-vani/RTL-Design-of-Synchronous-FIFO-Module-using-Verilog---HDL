`timescale 1ns / 1ps
// ==========================================================
// Testbench for Synchronous FIFO
// ==========================================================
// Description: Verifies all operations of the FIFO including
// write, read, overflow, underflow, and simultaneous operations.
// ==========================================================

module sync_fifo_tb;

  parameter Depth = 8;
  parameter Width = 16;

  // Inputs
  reg clk;
  reg reset;
  reg w_enb;
  reg r_enb;
  reg [Width-1:0] din;

  // Outputs
  wire [Width-1:0] dout;
  wire full;
  wire empty;

  // Instantiate FIFO
  sync_fifo #(Depth, Width) DUT (
    .clk(clk),
    .reset(reset),
    .w_enb(w_enb),
    .r_enb(r_enb),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk; // 100 MHz clock

  // VCD file for GTKWave
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, sync_fifo_tb);
  end

  // Testbench behavior
  initial begin
    $display("==== Starting FIFO Testbench ====");
    $monitor("T=%0t | clk=%b reset=%b w_enb=%b r_enb=%b din=%h dout=%h full=%b empty=%b",
             $time, clk, reset, w_enb, r_enb, din, dout, full, empty);

    // Step 1: Reset
    reset = 1;
    w_enb = 0;
    r_enb = 0;
    din = 0;
    #15 reset = 0;

    // Step 2: Write until FIFO full
    $display("\n--- Write Test ---");
    repeat (Depth) begin
      @(posedge clk);
      w_enb = 1;
      din = $random;
    end
    @(posedge clk); w_enb = 0;

    // Step 3: Overflow test
    $display("\n--- Overflow Test ---");
    repeat (2) begin
      @(posedge clk);
      w_enb = 1; din = $random;
    end
    w_enb = 0;

    // Step 4: Read all data
    $display("\n--- Read Test ---");
    repeat (Depth) begin
      @(posedge clk);
      r_enb = 1;
    end
    @(posedge clk); r_enb = 0;

    // Step 5: Underflow test
    $display("\n--- Underflow Test ---");
    repeat (2) begin
      @(posedge clk);
      r_enb = 1;
    end
    r_enb = 0;

    // Step 6: Simultaneous read & write
    $display("\n--- Simultaneous Read/Write Test ---");
    repeat (4) begin
      @(posedge clk);
      w_enb = 1; r_enb = 1; din = $random;
    end
    w_enb = 0; r_enb = 0;

    // Step 7: Alternating R/W
    $display("\n--- Alternating Read/Write Test ---");
    repeat (Depth) begin
      @(posedge clk);
      w_enb = 1; r_enb = 0; din = $random;
      @(posedge clk);
      w_enb = 0; r_enb = 1;
    end

    $display("\n==== Testbench Completed ====");
    #50 $finish;
  end

endmodule
