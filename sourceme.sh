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
cd vlsi; source sourceme.sh; cd $PRJPATH

export PDK_DIR="/home/ff/ee241/spring20-labs/asap7PDK_r1p5"
