#!/bin/bash
for f in $(ls *.lua)
do
    if [ -a $VREP_ROOT_DIR/$f ]
    then
	rm $VREP_ROOT_DIR/$f
    fi
    
    ln $f $VREP_ROOT_DIR/$f
done
