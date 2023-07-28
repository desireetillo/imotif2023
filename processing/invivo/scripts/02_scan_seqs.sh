#!/bin/bash


# genome scan for iMotifs
## write swarm script
bash ./src/scan_motif_genome.sh

## submit swarm script
swarm -b 60 genome_scan.sw  --logdir logs -g 6  --merge-output


# scan ChIP sequences for iMotifs

for i in seq/*stab; do echo $i;
	sbatch ./src/scan_occurrence_chip.sh $i;
	sbatch ./src/scan_motif_chip.sh $i;
done
