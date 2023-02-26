open_project [pwd]/Automation/Automation_modules.xpr
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1	

set_property top [string trimright [lindex $argv 0]] [current_fileset]
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1

reset_run synth_1
launch_runs synth_1 -job 12
wait_on_run synth_1

set log_file [open "Automation/Automation_modules.runs/synth_1/runme.log" r]
set error_count_s 0

while {[gets $log_file line] != -1} {
  if {[regexp {ERROR:} $line]} {
  set error_count_s 1
  break
  }
}
close $log_file

if {$error_count_s !=1} {
set write_file [open "Synthesized_Reports/[string trimright [lindex $argv 0]]/Is_Synth.txt" w]
puts $write_file "YES"
close $write_file
open_run synth_1
report_power > Synthesized_Reports/[string trimright [lindex $argv 0]]/power.txt
report_timing > Synthesized_Reports/[string trimright [lindex $argv 0]]/timing.txt
report_utilization > Synthesized_Reports/[string trimright [lindex $argv 0]]/utilization.txt
}

if {$error_count_s !=0} {
set write_file [open "Synthesized_Reports/[string trimright [lindex $argv 0]]/Is_Synth.txt" w]
puts $write_file "NO"
close $write_file

set read_file [open "Automation/Automation_modules.runs/synth_1/runme.log" r]
set dest_file [open "Synthesized_Reports/[string trimright [lindex $argv 0]]/synth_error.txt" w]

while {[gets $read_file line] != -1} {
    puts $dest_file $line
}

close $read_file
close $dest_file
}

reset_run impl_1
launch_runs impl_1 -jobs 12
wait_on_run impl_1

set log_file [open "Automation/Automation_modules.runs/impl_1/runme.log" r]
set error_count_i 0

while {[gets $log_file line] != -1} {
  if {[regexp {ERROR:} $line]} {
  set error_count_i 1
  break
  }
}
close $log_file

if {$error_count_i !=1} {
set write_file [open "Implementation_Reports/[string trimright [lindex $argv 0]]/Is_Impl.txt" w]
puts $write_file "YES"
close $write_file
open_run impl_1
report_power > Implementation_Reports/[string trimright [lindex $argv 0]]/power.txt
report_timing > Implementation_Reports/[string trimright [lindex $argv 0]]/timing.txt
report_utilization > Implementation_Reports/[string trimright [lindex $argv 0]]/utilization.txt
}

if {$error_count_i !=0} {
set write_file [open "Implementation_Reports/[string trimright [lindex $argv 0]]/Is_Impl.txt" w]
puts $write_file "NO"
close $write_file

set read_file [open "Automation/Automation_modules.runs/impl_1/runme.log" r]
set dest_file [open "Implementation_Reports/[string trimright [lindex $argv 0]]/impl_error.txt" w]

while {[gets $read_file line] != -1} {
    puts $dest_file $line
}

close $read_file
close $dest_file
}

close_project
