#!/bin/bash

#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l select=1:ncpus=2:mem=8gb 
#PBS -l walltime=05:00:00
#PBS -M aponsero@email.arizona.edu
#PBS -m bea

module load perl
RUN="$WORKER_DIR/grind.pl"
HOST=`hostname`
LOG="$STDOUT_DIR/${HOST}.log"
ERRORLOG="$STDERR_DIR/${HOST}.log"

if [ ! -f "$LOG" ] ; then
    touch "$LOG"
fi
echo "Started `date`">>"$LOG"
echo "Host `hostname`">>"$LOG"
##################################################
#define offsets
OFF1=0
let "OFF2 = $SIZE_CONTIGS / 3"
let "OFF3 = $OFF2 *2"

##################################################"
#Fungi grind
F_OUT_DIR="$OUT/fungi_grind_${SIZE_CONTIGS}pb"
mkdir $F_OUT_DIR

cd $FUNGI_DIR
for FILE in *.fna
do
    for OFF in OFF1 OFF2 OFF3
    do
        OUTFILE="$F_OUT_DIR/${SIZE_CONTIGS}_${OFF}_${FILE}"
        perl $RUN $FILE $SIZE_CONTIGS $OUTFILE $OFF
    done
done

cd $F_OUT_DIR
cat *.fna > all_fungi_${SIZE_CONTIGS}.fasta
##################################################"
#Algae grind
A_OUT_DIR="$OUT/algae_grind_${SIZE_CONTIGS}pb"
mkdir $A_OUT_DIR

cd $ALGAE_DIR
for FILE in *.fna
do
    for OFF in OFF1 OFF2 OFF3
    do
        OUTFILE="$A_OUT_DIR/${SIZE_CONTIGS}_${OFF}_${FILE}"
        perl $RUN $FILE $SIZE_CONTIGS $OUTFILE $OFF
    done
done

cd $A_OUT_DIR
cat *.fna > all_algae_${SIZE_CONTIGS}.fasta

##################################################
#Bacteria grind
B_OUT_DIR="$OUT/bact_grind_${SIZE_CONTIGS}pb"
mkdir $B_OUT_DIR

cd $BACT_DIR
for FILE in *.fna
do
    for OFF in OFF1 OFF2 OFF3
    do
        OUTFILE="$B_OUT_DIR/${SIZE_CONTIGS}_${OFF}_${FILE}"
        perl $RUN $FILE $SIZE_CONTIGS $OUTFILE $OFF
    done
done

cd $B_OUT_DIR
cat *.fna > all_bacteria_${SIZE_CONTIGS}.fasta

##################################################"
#Viral grind
V_OUT_DIR="$OUT/viral_grind_${SIZE_CONTIGS}pb"
mkdir $V_OUT_DIR

cd $VIR_DIR
for FILE in *.fna
do
    for OFF in OFF1 OFF2 OFF3
    do
        OUTFILE="$V_OUT_DIR/${SIZE_CONTIGS}_${OFF}_${FILE}"
        perl $RUN $FILE $SIZE_CONTIGS $OUTFILE $OFF
    done
done

cd $V_OUT_DIR
cat *.fna > all_viral_${SIZE_CONTIGS}.fasta

echo "Finished `date`">>"$LOG"
