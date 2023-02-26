create_project -force Automation [pwd]/Test -part xc7k325tffg900-2
set_property board_part xilinx.com:kc705:part0:1.5 [current_project]
update_compile_order -fileset sources_1

add_files -norecurse [pwd]/Modules/PGGen.v

add_files -norecurse [pwd]/Modules/top_PE_struct.v

add_files -norecurse [pwd]/Modules/top_mealy_0011.v

add_files -norecurse [pwd]/Modules/top_moore_0011.v

add_files -norecurse [pwd]/Modules/top_multiplier.v

add_files -norecurse [pwd]/Modules/top_CLA8.v

add_files -norecurse [pwd]/Modules/top_CLA16.v

add_files -norecurse [pwd]/Modules/top_CLA32.v

add_files -norecurse [pwd]/Modules/top_RCA.v

add_files -norecurse [pwd]/Modules/top_CLA64.v

add_files -norecurse [pwd]/Modules/top_PE_behav.v
add_files -norecurse [pwd]/Modules/PGGen.v

add_files -norecurse [pwd]/Modules/top_PE_struct.v

add_files -norecurse [pwd]/Modules/top_mealy_0011.v

add_files -norecurse [pwd]/Modules/top_moore_0011.v

add_files -norecurse [pwd]/Modules/top_multiplier.v

add_files -norecurse [pwd]/Modules/top_CLA8.v

add_files -norecurse [pwd]/Modules/top_CLA16.v

add_files -norecurse [pwd]/Modules/top_CLA32.v

add_files -norecurse [pwd]/Modules/top_RCA.v

add_files -norecurse [pwd]/Modules/top_CLA64.v

add_files -norecurse [pwd]/Modules/top_PE_behav.v
add_files -norecurse [pwd]/Modules/PGGen.v

add_files -norecurse [pwd]/Modules/top_PE_struct.v

add_files -norecurse [pwd]/Modules/top_mealy_0011.v

add_files -norecurse [pwd]/Modules/top_moore_0011.v

add_files -norecurse [pwd]/Modules/top_multiplier.v

add_files -norecurse [pwd]/Modules/top_CLA8.v

add_files -norecurse [pwd]/Modules/top_CLA16.v

add_files -norecurse [pwd]/Modules/top_CLA32.v

add_files -norecurse [pwd]/Modules/top_RCA.v

add_files -norecurse [pwd]/Modules/top_CLA64.v

add_files -norecurse [pwd]/Modules/top_PE_behav.v
add_files -norecurse [pwd]/Modules/PGGen.v
add_files -norecurse [pwd]/Modules/top_PE_struct.v
add_files -norecurse [pwd]/Modules/top_mealy_0011.v
add_files -norecurse [pwd]/Modules/top_moore_0011.v
add_files -norecurse [pwd]/Modules/top_multiplier.v
add_files -norecurse [pwd]/Modules/top_CLA8.v
add_files -norecurse [pwd]/Modules/top_CLA16.v
add_files -norecurse [pwd]/Modules/top_CLA32.v
add_files -norecurse [pwd]/Modules/top_RCA.v
add_files -norecurse [pwd]/Modules/top_CLA64.v
add_files -norecurse [pwd]/Modules/top_PE_behav.v

update_compile_order -fileset sources_1

close_project
