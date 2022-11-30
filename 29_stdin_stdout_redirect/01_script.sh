#!/bin/bash

# Testing Error and data Redirecting
touch goodtest
ls -alh goodtest badtest1 badtest2 badtest3 2> error.txt 1> result.txt
