onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ALU_TOP_TB/CLK_TB
add wave -noupdate /ALU_TOP_TB/RST_TB
add wave -noupdate /ALU_TOP_TB/ALU_FUN_TB
add wave -noupdate /ALU_TOP_TB/A_TB
add wave -noupdate /ALU_TOP_TB/B_TB
add wave -noupdate /ALU_TOP_TB/Arith_OUT_TB
add wave -noupdate /ALU_TOP_TB/Carry_OUT_TB
add wave -noupdate -color {Medium Violet Red} /ALU_TOP_TB/Arith_Flag_TB
add wave -noupdate /ALU_TOP_TB/Logic_OUT_TB
add wave -noupdate -color {Cornflower Blue} /ALU_TOP_TB/Logic_Flag_TB
add wave -noupdate /ALU_TOP_TB/CMP_OUT_TB
add wave -noupdate -color Cyan /ALU_TOP_TB/CMP_Flag_TB
add wave -noupdate /ALU_TOP_TB/Shift_OUT_TB
add wave -noupdate -color Pink /ALU_TOP_TB/Shift_Flag_TB
add wave -noupdate /ALU_TOP_TB/Flags
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24 us} 0}
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 us} {108 us}
