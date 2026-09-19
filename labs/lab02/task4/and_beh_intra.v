module and_beh_intra (input a, input b, output reg y);
  always @(a or b)
    y = #5 a & b;      // reads a and b NOW, assigns after 5
endmodule