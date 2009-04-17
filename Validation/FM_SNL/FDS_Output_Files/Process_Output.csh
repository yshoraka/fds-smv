#!/bin/csh -f
setenv SVNROOT ~/FDS-SMV
set PDIR=$SVNROOT/Utilities/Data_Processing
set WDIR=$SVNROOT/Validation/FM_SNL/FDS_Output_Files
set DDIR=$SVNROOT/Validation/FM_SNL/Current_Results
cd $DDIR
$PDIR/layer_height < $WDIR/FM_SNL_04_v5.input
$PDIR/layer_height < $WDIR/FM_SNL_05_v5.input
$PDIR/layer_height < $WDIR/FM_SNL_21_v5.input
cp FM_SNL*HGL.csv $WDIR
cp FM_SNL*devc.csv $WDIR
cd $WDIR


