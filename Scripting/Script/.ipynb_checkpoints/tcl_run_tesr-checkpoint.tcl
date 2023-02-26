open_project [pwd]/Automation/Automation_modules.xpr
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1	

set_property top [string trimright [lindex $argv 0]] [current_fileset]
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1

reset_run synth_1
launch_runs synth_1 -jobs 12

set x 0
while {$x !=1 } {
	if {[catch {open_run synth_1}]} { 
		set x 0 
		continue } \
	else { set x 1 
    report_power > Synthesized_Reports/[string trimright [lindex $argv 0]]/power.txt
    report_timing > Synthesized_Reports/[string trimright [lindex $argv 0]]/timing.txt
    report_utilization > Synthesized_Reports/[string trimright [lindex $argv 0]]/utilization.txt}
}

reset_run impl_1
launch_runs impl_1 -jobs 12


set x 0
while {$x !=1 } {
	if {[catch {open_run impl_1}]} { 
		set x 0 
        break
        } \
	else { set x 1 
    report_power > Implementation_Reports/[string trimright [lindex $argv 0]]/power.txt
    report_timing > Implementation_Reports/[string trimright [lindex $argv 0]]/timing.txt
    report_utilization > Implementation_Reports/[string trimright [lindex $argv 0]]/utilization.txt
    }
}

# report_power > Implementation_Reports/[string trimright [lindex $argv 0]]/power_2.txt
# report_timing > Implementation_Reports/[string trimright [lindex $argv 0]]/timing_2.txt
# report_utilization > Implementation_Reports/[string trimright [lindex $argv 0]]/utilization_2.txt

close_project
