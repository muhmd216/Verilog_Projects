onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Up_Dn_Counter_TB/CLK_TB
add wave -noupdate /Up_Dn_Counter_TB/RST_TB
add wave -noupdate /Up_Dn_Counter_TB/IN_TB
add wave -noupdate -color Yellow /Up_Dn_Counter_TB/Load_TB
add wave -noupdate -color Cyan /Up_Dn_Counter_TB/Up_TB
add wave -noupdate -color Violet /Up_Dn_Counter_TB/Down_TB
add wave -noupdate -radix decimal /Up_Dn_Counter_TB/Counter_TB
add wave -noupdate /Up_Dn_Counter_TB/High_TB
add wave -noupdate /Up_Dn_Counter_TB/Low_TB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10030 ns} 0}
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
WaveRestoreZoom {0 ns} {147 us}
