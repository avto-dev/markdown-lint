#!/bin/bash
shopt -s globstar

RUN_ARGS="";

if [ "$INPUT_RULES" != "" ]; then
  RUN_ARGS="$RUN_ARGS --rules $INPUT_RULES";
fi;

if [ "$INPUT_CONFIG" != "" ]; then
  RUN_ARGS="$RUN_ARGS --config $INPUT_CONFIG";
fi;

if [ "$INPUT_FIX" = "true" ]; then
  RUN_ARGS="$RUN_ARGS --fix";
fi;

if [ "$INPUT_OUTPUT" != "" ]; then
  RUN_ARGS="$RUN_ARGS --output $INPUT_OUTPUT";
fi;

if [ "$INPUT_IGNORE" != "" ]; then
  RUN_ARGS="$RUN_ARGS --ignore $INPUT_IGNORE";
fi;

# Do not quote "$@" as Github Actions passes each argument as a single arg.
# So 'args: --fix foo bar.md'  would be treated as a single string and not be parsed by markdownlint
exec /usr/local/bin/markdownlint $RUN_ARGS $@
