onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /LFSR_TB/CLK_TB
add wave -noupdate -color Gold /LFSR_TB/RST_TB
add wave -noupdate -color Blue /LFSR_TB/Enable_TB
add wave -noupdate /LFSR_TB/Seed_TB
add wave -noupdate /LFSR_TB/DUT/LFSR
add wave -noupdate -color {Dark Orchid} /LFSR_TB/OUT_Enable_TB
add wave -noupdate /LFSR_TB/OUT_TB
add wave -noupdate /LFSR_TB/Valid_TB
add wave -noupdate /LFSR_TB/check_out/Respo
add wave -noupdate /LFSR_TB/check_out/expec_out
add wave -noupdate /LFSR_TB/N
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {225000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 90
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
configure wave -timelineunits ps
update
WaveRestoreZoom {175736 ps} {335505 ps}
