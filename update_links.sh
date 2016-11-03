#!/bin/bash
for f in $(ls *.lua)
do
    ln $f $VREP_ROOT_DIR/$f
done
