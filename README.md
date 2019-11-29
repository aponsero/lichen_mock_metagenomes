# lichen_mock_metagenomes
Pipeline to generate mock contig lichen metagenomes. Parralelized for a HPC use

This pipeline grind complete metagenomes into custom contig size (./grind.sh) then subset these sequences into chose proportions to mimic a lichen metagenome (./get_mocks.sh).

## Requirements

### Perl 5.010
This pipeline requires perl 5.010 and the package [Bioperl](https://bioperl.org/index.html) installed 
### Python3
This pipeline requires python 3 and the following packages :
  - argparse
  - itertools
  - Biopython
  - random

## Quick start

### Edit scripts/config.sh file

please modify the

  - FUNGI_DIR= path to directory containing the fungi genomes
  - ALGAE_DIR= path to directory containing the algae genomes
  - BACT_DIR= path to directory containing the prokaryotic genomes
  - VIR_DIR=path to directory containing the viral genomes

  - FUNGI_PERCENT= % of fungi contig in the final mock community
  - ALGAE_PERCENT= % of algae contig in the final mock community
  - BACT_PERCENT= % of prokaryotic contig in the final mock community
  - VIR_PERCENT= % of viral contig in the final mock community
  - NB_READS=number of sequences in the final mock community
  - NB_MOCK=number of required mock communities
  - SIZE_CONTIGS=size in bp of the sequences in the mock communities

  - OUT= path to output directory
  - MAIL_USER = indicate here your arizona.edu email
  - GROUP = indicate here your group affiliation

You can also modify

  - BIN = change for your own bin directory.
  - MAIL_TYPE = change the mail type option. By default set to "bea".
  - QUEUE = change the submission queue. By default set to "standard".
  
  ### Run pipeline
  
  Run 
  ```bash
  ./grind.sh
  ```
  This command will place one job in queue. Once the job is completed, run:
   ```bash
  ./get_mocks.sh
  ```
   This command will place one job in queue. 
