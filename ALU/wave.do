onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ALU_TB/clk_TB
add wave -noupdate /ALU_TB/rst_TB
add wave -noupdate /ALU_TB/ALU_FUN_TB
add wave -noupdate /ALU_TB/A_TB
add wave -noupdate /ALU_TB/B_TB
add wave -noupdate -color Gold /ALU_TB/ALU_OUT_TB
add wave -noupdate /ALU_TB/Arith_Flag_TB
add wave -noupdate /ALU_TB/Logic_Flag_TB
add wave -noupdate /ALU_TB/CMP_Flag_TB
add wave -noupdate /ALU_TB/Shift_Flag_TB
add wave -noupdate /ALU_TB/flags
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13425 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {70876 ns}
