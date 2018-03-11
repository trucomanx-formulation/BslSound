#!/bin/bash

latex yfuncs
dvips yfuncs.dvi -o yfuncs.eps
./clean.sh
