#!/bin/csh -f
setenv SVNROOT ~/FDS-SMV
set PDIR=$SVNROOT/Utilities/Data_Processing
set WDIR=$SVNROOT/Validation/Steckler_Compartment/FDS_Output_Files
set DDIR=$SVNROOT/Validation/Steckler_Compartment/Current_Results
cd $DDIR
$PDIR/fds2ascii $WDIR/Steckler_010_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_011_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_012_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_013_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_014_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_016_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_017_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_018_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_019_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_020_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_021_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_022_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_023_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_030_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_041_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_114_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_116_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_122_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_144_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_160_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_161_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_162_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_163_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_164_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_165_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_166_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_167_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_210_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_212_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_220_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_221_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_224_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_240_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_242_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_310_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_324_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_410_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_510_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_512_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_513_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_514_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_517_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_520_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_521_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_522_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_524_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_540_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_541_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_542_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_544_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_610_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_612_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_622_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_710_fds2ascii.input
$PDIR/fds2ascii $WDIR/Steckler_810_fds2ascii.input
cp Steck*fds2ascii.csv $WDIR
cd $WDIR

