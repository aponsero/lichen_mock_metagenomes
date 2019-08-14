export CWD=$PWD
# where the original genomes are stored
export FUNGI_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/mock_lichen/fungi"
export ALGAE_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/mock_lichen/algae"
export BACT_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/mock_lichen/Nostoc"
export VIR_DIR="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/mock_lichen/cyanophages/viral_genomes"
# parameters for the mock community creation
export FUNGI_PERCENT=79
export ALGAE_PERCENT=10
export BACT_PERCENT=10
export VIR_PERCENT=1
export NB_READS=1000
export NB_MOCK=2
export SIZE_CONTIGS=5000
# output directory
export OUT="/rsgrps/bhurwitz/alise/my_data/Nostoc_project/mock_lichen/mock_metagenomes/test1"
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
