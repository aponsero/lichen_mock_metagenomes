#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=2:mem=8gb 
#PBS -l walltime=05:00:00
#PBS -M aponsero@email.arizona.edu
#PBS -m bea

module load python
source activate anvio5

RUN="$WORKER_DIR/randomize.py"
HOST=`hostname`
LOG="$STDOUT_DIR/${HOST}.log"
ERRORLOG="$STDERR_DIR/${HOST}.log"

if [ ! -f "$LOG" ] ; then
    touch "$LOG"
fi
echo "Started `date`">>"$LOG"
echo "Host `hostname`">>"$LOG"

C_MOCK="$OUT/mock_${PBS_ARRAY_INDEX}"
mkdir $C_MOCK


##################################################
#split randomly dataset fungi
FILE="$OUT/fungi_grind_${SIZE_CONTIGS}pb/all_fungi_${SIZE_CONTIGS}.fasta"
MAX=$(grep ">" $FILE |wc -l)
let "NB1= $FUNGI_PERCENT * $NB_READS"
let "SPLIT= $NB1/100"
# size of the output files
OUTFILE="$C_MOCK/fungi_${FUNGI_PERCENT}.fasta"

python $RUN -f $FILE -o $OUTFILE -s $SPLIT -m $MAX

##################################################
#split randomly dataset bact
FILE="$OUT/bact_grind_${SIZE_CONTIGS}pb/all_bacteria_${SIZE_CONTIGS}.fasta"
MAX=$(grep ">" $FILE |wc -l)
let "NB1= $BACT_PERCENT * $NB_READS"
let "SPLIT= $NB1/100"
OUTFILE="$C_MOCK/bact_${BACT_PERCENT}.fasta"

python $RUN -f $FILE -o $OUTFILE -s $SPLIT -m $MAX

##################################################
#split randomly dataset algae
FILE="$OUT/algae_grind_${SIZE_CONTIGS}pb/all_algae_${SIZE_CONTIGS}.fasta"
MAX=$(grep ">" $FILE |wc -l)
let "NB1= $ALGAE_PERCENT * $NB_READS"
let "SPLIT= $NB1/100"
OUTFILE="$C_MOCK/algae_${FUNGI_PERCENT}.fasta"

python $RUN -f $FILE -o $OUTFILE -s $SPLIT -m $MAX

##################################################
#split randomly dataset viral
FILE="$OUT/viral_grind_${SIZE_CONTIGS}pb/all_viral_${SIZE_CONTIGS}.fasta"
MAX=$(grep ">" $FILE |wc -l)
let "NB1= $VIR_PERCENT * $NB_READS"
let "SPLIT= $NB1/100"
OUTFILE="$C_MOCK/viral_${FUNGI_PERCENT}.fasta"

python $RUN -f $FILE -o $OUTFILE -s $SPLIT -m $MAX

################################################
# merge the mock community
cd $C_MOCK
cat *.fasta > mock_${PBS_ARRAY_INDEX}.fa

echo "Finished `date`">>"$LOG"
