The flow was implemented using Cadence tools for the updated SAMM (Systolic Array Matrix Multiplier) design. The design is fully synchronous and has no CDCs. The block diagram is shown below.

<img width="1920" height="1080" alt="SAMM block diagram" src="https://github.com/user-attachments/assets/9893c16b-10b9-445f-b1f2-550d54576953" />
The FIFO buffers are synchronous FIFOs (depth = 8) that outputs zero when read enable is deasserted. 
(See report)

File organisation:
  - Server folders:
    > Contains the project directories for:
          1. NCSim functional verification and coverage metrics
          2. RTL to GDS flow using Genus -> Modus -> Innovus
    > ZIP file format
  
  - NCSim design & tb files:
      > Contains the design files, memory files (.mem) and testbench files for the top module.
      > The memory is part of the top module here.
  
  - RTL to layout flow files:
      > Contains Genus, Modus and Innovus reports along with design files used in the netlist.
      > Memory module not a part of this (not synthesized).
      > Done using a 90nm technology library.
