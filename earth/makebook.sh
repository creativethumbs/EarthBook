#!/bin/bash

# clear files
rm imgs/*

python getimgs.py

rm imgs/.DS_Store

echo "creating book....." 

processing-java --sketch="$(pwd)"/earthbook --run


