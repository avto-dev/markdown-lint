#!/bin/bash
shopt -s globstar

RUN_ARGS="";

if [ ! -z $INPUT_RULES ] && [ "$INPUT_RULES" != "" ]; then
  RUN_ARGS="$RUN_ARGS --rules $INPUT_RULES";
fi;

if [ ! -z $INPUT_CONFIG ] && [ "$INPUT_CONFIG" != "" ]; then
  RUN_ARGS="$RUN_ARGS --config $INPUT_CONFIG";
fi;

if [ ! -z $INPUT_FIX ] && [ "$INPUT_FIX" = "true" ]; then
  RUN_ARGS="$RUN_ARGS --fix";
fi;

if [ ! -z $INPUT_OUTPUT ] && [ "$INPUT_OUTPUT" != "" ]; then
  RUN_ARGS="$RUN_ARGS --output $INPUT_OUTPUT";
fi;

if [ ! -z $INPUT_IGNORE ] && [ "$INPUT_IGNORE" != "" ]; then
  RUN_ARGS="$RUN_ARGS --ignore $INPUT_IGNORE";
fi;

exec /usr/local/bin/markdownlint $RUN_ARGS $@
