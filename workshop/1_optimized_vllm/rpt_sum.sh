LOG=$1
LOG_sum=$2

Req=$(grep -E "Successful requests" ${LOG})
ttftLat=$(grep -E "Median TTFT" ${LOG})
tpotLat=$(grep -E "Median TPOT" ${LOG})
e2eLat=$(grep -E "Median E2EL" ${LOG})
totTh=$(grep -E "Total Token throughput" ${LOG})

Req_sp=(${Req//:/ })
ttftLat_sp=(${ttftLat//:/ })
tpotLat_sp=(${tpotLat//:/ })
e2eLat_sp=(${e2eLat//:/ })
totTh_sp=(${totTh//:/ })

Req_sp_val=${Req_sp[2]}
ttftLat_val=${ttftLat_sp[3]}
tpotLat_val=${tpotLat_sp[3]}
e2eLat_val=${e2eLat_sp[3]}
totTh_val=${totTh_sp[4]}

printf $3,              2>&1 | tee -a ${LOG_sum}
printf $Req_sp_val,     2>&1 | tee -a ${LOG_sum}
printf $ttftLat_val,    2>&1 | tee -a ${LOG_sum}
printf $tpotLat_val,    2>&1 | tee -a ${LOG_sum}
printf $e2eLat_val,     2>&1 | tee -a ${LOG_sum}
printf $totTh_val       2>&1 | tee -a ${LOG_sum}
printf "\n"             2>&1 | tee -a ${LOG_sum}
