#!/bin/csh -f
setenv SVNROOT ~/FDS-SMV
set DDIR=$SVNROOT/Validation/UL_NFPRF/Current_Results
set WDIR=$SVNROOT/Validation/UL_NFPRF/FDS_Output_Files
cp $DDIR/UL*devc.csv $WDIR

