#!/bin/bash

OUT="/home/data/results"
dataFile=ABSOLUTE/PATH/TO/DATA/FILE #/home/data/zscores.tsv

RESUME=''
if [ -f "$OUT/cmonkey_run.db" ] && [ "$1" != "--rerun" ]; then
	RESUME="--resume"
fi

logfile="logfile_cmonkey_out_ADphase2_$(date +%Y-%m-%d_%H:%M).txt"

num_cores=$(expr $(grep -c ^processor /proc/cpuinfo) - 1) 

FLAGS="--organism hsa \
       --string /home/data/9606.txt \
       --rsat_organism Homo_sapiens \
       --rsat_dir /home/data/myRSATinfoHomo_sapiens \
       --nooperons \
       --num_cores $num_cores \
       --out ${OUT} \
       --use_BSCM \
       --verbose ${RESUME} \
       ${dataFile}"

echo -e '\n\n\n\n\n\n\n\' | tee -a ${logfile}
echo -e $(date) | tee -a ${logfile}
echo -e $FLAGS | tee -a ${logfile}
bin/cmonkey2.sh $FLAGS | tee -a ${logfile}
