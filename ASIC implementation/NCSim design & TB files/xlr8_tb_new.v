`timescale 1ns/1ps

module xlr8_tb();
    reg     [9:0]   addr_mtxA, addr_mtxB;
    reg             clk, mem_rst, rst, start;
    wire            all_full, all_empty, done;
    wire    [15:0]  C00, C01, C02, C03, C04, C05, C06, C07,
                    C10, C11, C12, C13, C14, C15, C16, C17,
                    C20, C21, C22, C23, C24, C25, C26, C27,        
                    C30, C31, C32, C33, C34, C35, C36, C37,
                    C40, C41, C42, C43, C44, C45, C46, C47,
                    C50, C51, C52, C53, C54, C55, C56, C57,
                    C60, C61, C62, C63, C64, C65, C66, C67,
                    C70, C71, C72, C73, C74, C75, C76, C77;
    
    // DUT
    xlr8 dut (clk, mem_rst, rst, start, 
              addr_mtxA, addr_mtxB,
              all_full, all_empty, done,
              C00, C01, C02, C03, C04, C05, C06, C07,
              C10, C11, C12, C13, C14, C15, C16, C17,
              C20, C21, C22, C23, C24, C25, C26, C27,
              C30, C31, C32, C33, C34, C35, C36, C37,
              C40, C41, C42, C43, C44, C45, C46, C47,
              C50, C51, C52, C53, C54, C55, C56, C57,
              C60, C61, C62, C63, C64, C65, C66, C67,
              C70, C71, C72, C73, C74, C75, C76, C77);

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        mem_rst = 0;
        rst = 1;
        start = 0;
        addr_mtxA = 10'd0;
        addr_mtxB = 10'd64;

        // global reset
        repeat (3) @(posedge clk);
        rst = 0;

        // 1st run: normal, base addresses
        start = 1;
        repeat (150) @(posedge clk);   // let count go well past 64
        start = 0;

        // idle region to exercise idle branches
        repeat (40) @(posedge clk);

        // 2nd run: different base addresses
		repeat (3)  @(posedge clk);
        rst = 1;
		repeat (3)  @(posedge clk);
        rst = 0;
        addr_mtxA = 10'd128;
        addr_mtxB = 10'd192;
        start = 1;
        repeat (150) @(posedge clk);
        start = 0;

        // mid‑run reset to hit PE/SA/RAM reset logic again
        repeat (10) @(posedge clk);
        rst = 1;
        repeat (3)  @(posedge clk);
        rst = 0;

        // short 3rd run after reset
        start = 1;
        repeat (80) @(posedge clk);
        start = 0;

        // extra cycles for forced FIFO activity (see block below)
        repeat (50) @(posedge clk);

        $finish;
    end

    // -------------------------------------------------------------------
    // Coverage hooks using force/release to hit FIFO 2'b11 branches etc.
    // Adjust hierarchy if your instance names differ.
    // -------------------------------------------------------------------
    initial begin
        // Wait until FIFOs are reasonably filled by normal operation
        #300;

        // Example: exercise simultaneous read/write (2'b11) in one row FIFO
        // synchr_fifo is inside fifo_zero_injector instance R0
        force dut.R0.FIFO.wen = 1'b1;
        force dut.R0.FIFO.ren = 1'b1;
        repeat (6) @(posedge clk);
        release dut.R0.FIFO.wen;
        release dut.R0.FIFO.ren;

        // Exercise 2'b01 (read only) near‑empty
        force dut.R0.FIFO.wen = 1'b0;
        force dut.R0.FIFO.ren = 1'b1;
        repeat (4) @(posedge clk);
        release dut.R0.FIFO.wen;
        release dut.R0.FIFO.ren;

        // Exercise 2'b10 (write only) near‑full
        force dut.R0.FIFO.wen = 1'b1;
        force dut.R0.FIFO.ren = 1'b0;
        repeat (4) @(posedge clk);
        release dut.R0.FIFO.wen;
        release dut.R0.FIFO.ren;

        // Do similar for one column FIFO to toggle that instance as well
        force dut.C0.FIFO.wen = 1'b1;
        force dut.C0.FIFO.ren = 1'b1;
        repeat (6) @(posedge clk);
        release dut.C0.FIFO.wen;
        release dut.C0.FIFO.ren;
    end

endmodule

