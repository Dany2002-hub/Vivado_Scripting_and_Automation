create_project -force Automation_modules [pwd]/Automation -part xc7a35tcpg236-1
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
update_compile_order -fileset sources_1

add_files -norecurse [pwd]/Modules/top_Memory_RW.sv
add_files -norecurse [pwd]/Modules/PGGen.v
add_files -norecurse [pwd]/Modules/top_fifo.sv
add_files -norecurse [pwd]/Modules/top_PE_struct.v
add_files -norecurse [pwd]/Modules/top_mealy_0011.v
add_files -norecurse [pwd]/Modules/top_moore_0011.v
add_files -norecurse [pwd]/Modules/top_multiplier.v
add_files -norecurse [pwd]/Modules/top_CLA8.v
add_files -norecurse [pwd]/Modules/top_CLA16.v
add_files -norecurse [pwd]/Modules/top_CLA32.v
add_files -norecurse [pwd]/Modules/top_RCA.v
add_files -norecurse [pwd]/Modules/top_CLA64.v
add_files -norecurse [pwd]/Modules/top_trafficsignal.sv
add_files -norecurse [pwd]/Modules/top_pipelined_conv.sv
add_files -norecurse [pwd]/Modules/top_PE_behav.v

update_compile_order -fileset sources_1

close_project
