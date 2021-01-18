#!/bin/csh

set chn_len = 28

foreach design ( au) #top level entitiy of the module for syn.
	foreach freq ( 1000)  #target frq in MHz

		rm -rf ./syn_{$design}_{$chn_len}chn_${freq}MHz
		mkdir ./syn_{$design}_{$chn_len}chn_${freq}MHz
		mkdir ./syn_{$design}_{$chn_len}chn_${freq}MHz/scripts
		cp ./scripts/constraints.func.sdc ./syn_{$design}_{$chn_len}chn_${freq}MHz/scripts/constraints.func.sdc
		cd ./syn_{$design}_{$chn_len}chn_${freq}MHz

		set period = `echo $freq | awk '{printf "%.2f", 1/$1 * 1000000}'`
		echo $freq : $period

		cadence nocom 18.14.000 genus  -wait 60 -overwrite -common_ui -file ../1_map.gen -e "set period $period; set chn_len $chn_len; set design $design;"
		cd ..
	end
end
