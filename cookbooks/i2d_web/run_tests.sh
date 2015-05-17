#!/bin/bash -xve

# -e: above, means exit on any error

foodcritic -f any .

rspec

kitchen test
