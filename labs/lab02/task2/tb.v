// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
   localparam WIDTH = 8;
   localparam DEPTH = 4;

   reg  [$clog2(DEPTH)-1:0] sel;
   wire [WIDTH-1:0] dout;

   integer i;
  // TODO: instantiate DUT here
   lut #(.WIDTH(WIDTH), .DEPTH(DEPTH)) DUT (
    .sel  (sel),
    .dout (dout)
  );
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations
    #1;
    for (i=0;i<DEPTH;i=i+1) begin
      sel = i;
      #5;
  end
  $finish;
  end

  initial
    $monitor($time, " sel=%b | dout=%b", sel, dout); // change as required

endmodule
