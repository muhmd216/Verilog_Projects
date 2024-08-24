vlib work
vlog -f sourcefile.txt
vsim -voptargs=+accs work.ALU_TOP_TB
add wave *
run -all   