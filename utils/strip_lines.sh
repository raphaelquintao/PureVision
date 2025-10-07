#!/bin/bash

$@ 2> >(sed 's/^$/\v/g' | tr -d '\n' | tr '\v' '\n' >&2)