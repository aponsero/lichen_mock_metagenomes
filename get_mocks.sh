#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -d "$OUT" ]]; then
    echo "$OUT does not exist. Please provide the path to the folder to process. Job terminated."
    exit 1
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 02-produce mock comm
#

PROG="01-run-mock"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"

echo "launch run_mock.sh"
JOB_ID=`qsub $ARGS -v WORKER_DIR,FUNGI_PERCENT,ALGAE_PERCENT,BACT_PERCENT,VIR_PERCENT,NB_READS,SIZE_CONTIGS,OUT,STDERR_DIR,STDOUT_DIR -N run_mock -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NB_MOCK $SCRIPT_DIR/run_mock.sh`

if [ "${JOB_ID}x" != "x" ]; then
   echo Job: \"$JOB_ID\"
   PREV_JOB_ID=$JOB_ID  
else
   echo Problem submitting job. Job terminated
fi
