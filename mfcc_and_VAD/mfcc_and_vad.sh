#!/bin/bash

. path.sh
. cmd.sh
train=$1
adapt=$2
enroll=$3
test=$4
mfccdir=mfcc
vaddir=vad

for name in train adapt enroll test ; do
    steps/make_mfcc.sh --write-utt2num-frames true --mfcc-config conf/mfcc.conf --nj 20  \
      data/${name} exp/make_mfcc $mfccdir
    utils/fix_data_dir.sh data/${name}
    sid/compute_vad_decision.sh --nj 20 --cmd "$train_cmd" \
      data/${name} exp/make_vad $vaddir
    utils/fix_data_dir.sh data/${name}
echo "the feature extraction and VAD process have been done! 
