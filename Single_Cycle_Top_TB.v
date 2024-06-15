//

module Single_Cycle_Top_TB();
    reg clk=1'b1 , rst ;

    Single_Cycle_Top Single_Cycle_Top(
        .clk(clk),
        .rst(rst)
    );

    initial begin
      $dumpfile("Single Cycle .vcd");
      $dumpvars(0);
    end

    always 
    initial
    clk=~clk;
    #50;
    end

    initial begin
      rst = 1'b0;
      #50;

      rst =1'b1;
      #500;
      $finish;
    end

endmodule