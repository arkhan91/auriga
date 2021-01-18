#!/usr/bin/perl

$sdc_files = "./syn_28/dbs/syn_opt/*.sdc";

system("touch $0");

system("rm -f dbs/syn_opt/*.fix.sdc");

local $/;

open (LOG, ">$0.log") || die $!;

foreach $sdc_file (glob $sdc_files) {
  print LOG "$sdc_file\n";
  ($base = $sdc_file) =~ s/\.sdc$//;
  open(SDC, "<$base.sdc") || die $!;
  $sdc = <SDC>;
  close(SDC);
  $sdc =~ s/(set_driving_cell.*?)-library .*? /$1/g;
  $sdc =~ s/(set_wire_load_selection_group.*?\n)/# $1/g;
  $sdc =~ s/(set_min_transition.*?\n)/# $1/g;
  $sdc =~ s/(set_timing_derate.*?\n)/# $1/g;
  $sdc =~ s/(set_dont_use.*?\n)/# $1/g;
  open(SDC, ">$base.fix.sdc") || die $!;
  print SDC $sdc;
  close(SDC);
}

close(LOG);
