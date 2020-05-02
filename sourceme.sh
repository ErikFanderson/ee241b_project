#!/usr/bin/env bash 

export PRJPATH=$PWD

# Set PYTHONPATH accordingly
if [ -z "$PYTHONPATH" ]
then
    export PYTHONPATH=$PWD/prga.py
else
    export PYTHONPATH=$PWD/prga.py:$PYTHONPATH
fi

# Toolbox 
cd toolbox; source sourceme.sh; cd $PRJPATH 

# ASAP7 stuff
export HAMMER_HOME=$PWD/hammer
source $HAMMER_HOME/sourceme.sh

# Add liberate to path
export ALTOSHOME=/tools/cadence/LIBERATE/LIBERATE181/
export PATH=$ALTOSHOME/bin:$PATH
