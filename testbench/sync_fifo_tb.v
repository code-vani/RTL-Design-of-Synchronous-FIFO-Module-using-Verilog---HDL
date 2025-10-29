`timescale 1ns / 1ps
// ==========================================================
// Testbench for Synchronous FIFO
// ==========================================================
// Description: Verifies write, read, overflow, underflow, and
// simultaneous read/write operations of the FIFO.
// ==========================================================

module tb_sync_fifo;

  // --- Parameters ---
  parameter Depth = 8;
  parameter Width = 16;

  // --- Inputs ---
  reg clk;
  reg reset;
  reg w_enb;
  reg r_enb;
  reg [Width-1:0] din;

  // --- Outputs ---
  wire [Width-1:0] dout;
  wire full;
  wire empty;

  // --- Instantiate DUT (Device Under Test) ---
  sync_fifo #(
    .Depth(Depth),
    .Width(Width)
  ) DUT (
    .clk(clk),
    .reset(reset),
    .w_enb(w_enb),
    .r_enb(r_enb),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );

  // --- Clock Generation ---
  initial clk = 0;
  always #5 clk = ~clk; // 10ns clock period (100 MHz)

  // --- VCD File for Waveform ---
  initial begin
    $dumpfile("fifo_wave.vcd");
    $dumpvars(0, tb_sync_fifo);
  end

  // --- Test Sequence ---
  initial begin
    $display("========== Starting FIFO Testbench ==========");
    $monitor("T=%0t | clk=%b | rst=%b | w_enb=%b | r_enb=%b | din=%h | dout=%h | full=%b | empty=%b",
             $time, clk, reset, w_enb, r_enb, din, dout, full, empty);

    // Step 1: Reset FIFO
    reset = 1;
    w_enb = 0;
    r_enb = 0;
    din = 0;
    #15 reset = 0;

    // Step 2: Write until full
    $display("\n--- Write Operation ---");
    repeat (Depth) begin
      @(posedge clk);
      w_enb = 1;
      din = $random;
    end
    @(posedge clk);
    w_enb = 0;

    // Step 3: Overflow Test
    $display("\n--- Overflow Condition ---");
    @(posedge clk);
    w_enb = 1; din = $random;
    @(posedge clk);
    w_enb = 0;

    // Step 4: Read until empty
    $display("\n--- Read Operation ---");
    repeat (Depth) begin
      @(posedge clk);
      r_enb = 1;
    end
    @(posedge clk);
    r_enb = 0;

    // Step 5: Underflow Test
    $display("\n--- Underflow Condition ---");
    @(posedge clk);
    r_enb = 1;
    @(posedge clk);
    r_enb = 0;

    // Step 6: Simultaneous Read/Write
    $display("\n--- Simultaneous Read/Write ---");
    repeat (4) begin
      @(posedge clk);
      w_enb = 1; r_enb = 1; din = $random;
    end
    w_enb = 0; r_enb = 0;

    // Step 7: Alternating R/W Test
    $display("\n--- Alternating Read/Write ---");
    repeat (Depth) begin
      @(posedge clk);
      w_enb = 1; din = $random; r_enb = 0;
      @(posedge clk);
      w_enb = 0; r_enb = 1;
    end

    $display("\n========== Testbench Completed ==========");
    #50 $finish;
  end

endmodule
