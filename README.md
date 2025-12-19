# Systolic-Array-Matrix-Multiplier
Implemented an 8x8 systolic array matrix multiplier. This repository contains various versions and implementations made during my M.E.
1. Folder "FPGA implementation":
     - contain files used in Vivado to implement the design on a Xilinx Zynq 7000 series FPGA board (xc7z020clg484-1).
2. Folder "SA synthesis using Genus"
     - Performed synthesis for only the SA module from the "FPGA implementation" design using Cadence Genus.
     - This was more of a 'playing around with the tool' by applying different constraints.

The above implementations were based on the old design, the one used in the FPGA project. Since that design was not at all practical, I modified it.
  
3. Folder "ASIC implementation": (NEW DESIGN)
     - modified the old rudimentary design with a new Verilog modelled memory, control unit and FIFO buffers.
     - attempted complete RTL to GDS flow for this new design. (Innovus tool exploration - didn't know how to fix errors, so left it at that)
     - contains files used in Cadence NCSim, Genus, Modus & Innovus.
