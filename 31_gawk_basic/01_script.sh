#!/bin/bash

gawk -F: -f 01_script.gawk /etc/passwd
