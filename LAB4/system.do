if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work my_components.vhd
vcom -93 -work work reg32.vhd
vcom -93 -work work processor.vhd
vcom -93 -work work system.vhd

vcom -93 -work work tb_system.vhd

vsim tb_system
add wave clk reset_n ifetch_out
add wave -radix hexadecimal mem_addr_out
add wave mem_read mem_write
add wave -radix hexadecimal data_from_procr data_to_procr

