// tb.v
module tb;

  reg  [1:0] A, B;
  wire       GT, LT, EQ;

  integer i, j;
  integer errors;

  comp2 DUT (
    .A  (A),
    .B  (B),
    .GT (GT),
    .LT (LT),
    .EQ (EQ)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        A = i;
        B = j;
        #5;
        // !== also catches x/z on the outputs
        if (GT !== (A > B) || LT !== (A < B) || EQ !== (A == B)) begin
          errors = errors + 1;
          $display("FAIL t=%0t A=%b B=%b | got GT=%b LT=%b EQ=%b | expected GT=%b LT=%b EQ=%b",
                   $time, A, B, GT, LT, EQ, (A > B), (A < B), (A == B));
        end
      end
    end

    if (errors == 0)
      $display("PASS: all 16 combinations correct");
    else
      $display("FAILED: %0d of 16 combinations wrong", errors);
    $finish;
  end

endmodule