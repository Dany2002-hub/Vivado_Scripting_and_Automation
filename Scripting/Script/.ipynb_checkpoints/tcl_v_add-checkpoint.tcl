create_project -force Automation [pwd]/Test -part xc7k325tffg900-2
set_property board_part xilinx.com:kc705:part0:1.5 [current_project]
update_compile_order -fileset sources_1

update_compile_order -fileset sources_1

close_project
