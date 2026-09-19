// tb.v
module tb;

  reg  [3:0] a,b;
  reg op;
  reg  [3:0] expected;
  
  wire [3:0] result;

  integer i,j,k,errors;

  alu DUT (.a(a), .b(b), .op(op), .result(result));

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
    // while a and b stay unchanged.
    for (i = 0; i < 16; i = i + 1)
      for (j = 0; j < 16; j = j + 1)
        for (k = 0; k < 2; k = k + 1) begin
          a = i; b = j; op = k;
          #5;
          expected = op ? (a - b) : (a + b);   // truncated to 4 bits
          if (result !== expected) begin
            errors = errors + 1;
            $display("FAIL t=%0t a=%0d b=%0d op=%b | got %0d expected %0d",
                     $time, a, b, op, result, expected);
          end
        end

    if (errors == 0) $display("PASS: all 512 cases correct");
    else             $display("FAILED: %0d of 512 cases wrong", errors);
    $finish;
  end

endmodule