This folder contains design and testbench files from the Xilinx Vivado project. Design was implemented on Zynq 7000 FPGA board (Zedboard).
It is a pretty basic design:
- RTL folder
    - PE.v -         The basic processing element of the systolic array, basically a MAC unit.
    - SA.v -         Parametric systolic array block, uses generate block to make an N x N systolic array.
    - SA_control.v - Responsible for providing inputs to the systolic array in a timely fashion to perform correct matrix multiplication. This logic
                     is hardcoded for the 8 x 8 SA.
                     Contains:
                      - ROM (.mem file) - Used to store the 128 8-bit elements of the two input matrices.
                      - Multiplexers - 8 for per-row element selection and 8 for per-column element selection to feed the SA.
                      - Counter - A basic counter whose outputs act as select lines to the multiplexers; dictates which element goes into the SA at what clock cycle.
    - Accelerator.v - The accelerator top module containing the above 3 modules instantiated in it.
    - top_module.v  - The FPGA design top module with the VIO (Vivado IP) instantiated so that outputs can be observed.

- Testbench folder
    - tb.v - The testbench for basic functional verification of the 'Accelerator.v'. Just provides reset and clock signals to the 'Accelerator.v'
             as the inputs are already present inside.
