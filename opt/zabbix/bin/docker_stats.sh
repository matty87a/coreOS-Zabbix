#!/bin/bash
readarray array <<< "$(docker system df --format '{{.Type}} {{.Active}} {{.Size}} {{.Reclaimable}}')";

#Active
ACT_IMG=$(echo ${array[0]} | awk '{print $(NF-3)}')
ACT_CON=$(echo ${array[1]} | awk '{print $(NF-3)}')
ACT_VOL=$(echo ${array[2]} | awk '{print $(NF-3)}')

#Sizes
SIZE_IMG=$(humanfriendly --parse-size=$(echo ${array[0]} | awk '{print $(NF-2)}'))
SIZE_CON=$(humanfriendly --parse-size=$(echo ${array[1]} | awk '{print $(NF-2)}'))
SIZE_VOL=$(humanfriendly --parse-size=$(echo ${array[2]} | awk '{print $(NF-2)}'))

#Reclaimable
REC_IMG=$(humanfriendly --parse-size=$(echo ${array[0]} | awk '{print $(NF-1)}'))
REC_CON=$(humanfriendly --parse-size=$(echo ${array[1]} | awk '{print $(NF-1)}'))
REC_VOL=$(humanfriendly --parse-size=$(echo ${array[2]} | awk '{print $(NF-1)}'))

#Percentages
PCT_IMG=$((echo ${array[0]} | awk '{print $NF}') |  sed 's/[^.0-9][^.0-9]*//g')
PCT_CON=$((echo ${array[1]} | awk '{print $NF}') |  sed 's/[^.0-9][^.0-9]*//g')
PCT_VOL=$((echo ${array[2]} | awk '{print $NF}') |  sed 's/[^.0-9][^.0-9]*//g')

cat <<EOF > /tmp/zab.val
Checked: $(date +%s)

# Images
IMGACT: $ACT_IMG
IMGSIZE: $SIZE_IMG
IMGREC: $REC_IMG
IMGPCT: $PCT_IMG

# Containers
CONACT: $ACT_CON
CONSIZE: $SIZE_CON
CONREC: $REC_CON
CONPCT: $PCT_CON

# Volumes
VOLACT: $ACT_VOL
VOLSIZE: $SIZE_VOL
VOLREC: $REC_VOL
VOLPCT: $PCT_VOL

EOF
