module and_beh_before (input a, input b, output reg y);
  always @(a or b)
    #5 y = a & b;      // waits 5, THEN reads a and b
endmodule