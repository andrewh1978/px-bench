#!/usr/bin/env bash
set -a

# read the control file
source control.env

#iterate throught the block sizes and rw settings
for b in ${blocksize_list}
do
    for rw in ${readwrite_list}
    do
        blocksize=$b
        readwrite=$rw

        date=$(date +%s)
        this_job_workdir=${runfiles_dir}/$b-$rw-$date
        echo
        echo "===================="
        echo "Storing runfiles in mkdir -p ${this_job_workdir}"
        mkdir -p ${this_job_workdir}
        
        echo "Creating jobfile for blocksize $b, io profile $rw"
        envsubst < templates/jobfiles/main.fio.tmpl > ${this_job_workdir}/$b-$rw.fio

        #if this isn't a read-write mixed workload, delete the rwmix options just for clarity
        if [[ " ${mixed_workloads[@]} " =~ " ${rw} " ]]; then
            echo "Mixed workload, continuing"
        else
            echo "Not a mixed workload, removing mixed workload parameters"
            sed -i '/rwmix/d' ${this_job_workdir}/$b-$rw.fio
        fi
        #clean up comment lines
        sed -i '/##/d' ${this_job_workdir}/$b-$rw.fio

        echo "wrote ${this_job_workdir}/$b-$rw.fio"
        
        echo "Starting run $b-$rw"
        # Make your config map from the above file and launch it here.
        echo "I'm pretending I'm running something"
        sleep 2 # pretending to do work just for testing. Remove me later   
        echo "Finished run $b-$rw"
        echo
    done
done

