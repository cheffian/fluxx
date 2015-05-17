#!/bin/bash -xve

# -e: above, means exit on any error

foodcritic .

rspec

false

kitchen test
