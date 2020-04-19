#!/usr/bin/env bash 

# Set PYTHONPATH accordingly
if [ -z "$PYTHONPATH" ]
then
    export PYTHONPATH=$PWD/prga.py
else
    export PYTHONPATH=$PWD/prga.py:$PYTHONPATH
fi

# Toolbox 
cd toolbox; source sourceme.sh; cd ..
