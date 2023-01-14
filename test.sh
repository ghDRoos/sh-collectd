#!/usr/bin/env bash
###################

function obists_to_epoch() {
    # Hardcoded 21st century
    D="20${1%?}"
    date -d "${D:0:8} ${D:8:2}:${D:10:2}:${D:12:2}" +%s
}

function sanitize_number() {
    echo "$1" | bc | awk '{printf "%.3f", $0}'
}

function parse_obis() {
    case "$1" in
        "1-3:0.2.8")
            # Sample: 1-3:0.2.8(50)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Version: %s\n" "${OBISVAL:-ERR}"
            ;;
        "0-0:1.0.0")
            # Sample: 0-0:1.0.0(230112193527W)
            #    Timestamp: YYMMDDhhmmssX
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Timestamp (YYMMDDhhmmssX): %s\n" "`obists_to_epoch ${OBISVAL}`"
            ;;
        "0-0:96.1.1")
            # Sample: 0-0:96.1.1(4530303533303037373734393233363230)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Equipment ID: %s\n" "${OBISVAL:-ERR}"
            ;;
        "1-0:1.8.1")
            # Sample: 1-0:1.8.1(002876.122*kWh)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Used (low tariff): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "1-0:1.8.2")
            # Sample: 1-0:1.8.2(003205.411*kWh)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Used (normal tariff): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "1-0:2.8.1")
            # Sample: 1-0:2.8.1(000000.000*kWh)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Delivered (low tariff): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "1-0:2.8.2")
            # Sample: 1-0:2.8.2(000000.000*kWh)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Delivered (normal tariff): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "0-0:96.14.0")
            # Sample: 0-0:96.14.0(0002)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Delivered (normal tariff): %s\n" "$((10#${OBISVAL:-0}))"
            ;;
        "1-0:1.7.0")
            # Sample: 1-0:1.7.0(01.366*kW)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Power delivered (+P): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "1-0:2.7.0")
            # Sample: 1-0:2.7.0(00.000*kW)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Power received (-P): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "0-0:96.7.21")
            # Sample: 0-0:96.7.21(00007)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Power failures: %s\n" "$((10#${OBISVAL:-0}))"
            ;;
        "0-0:96.7.9")
            # Sample: 0-0:96.7.9(00004)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Long power failures: %s\n" "$((10#${OBISVAL:-0}))"
            ;;
        "1-0:99.97.0")
            # Sample: 1-0:99.97.0(2)(0-0:96.7.19)(201130121057W)(0000000376*s)(220902151405S)(0000000242*s)
            return
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1,/g'  )
            printf "Power failure eventlog: %s\n" "NA"
            ;;
        "1-0:32.32.0")
            # Sample: 1-0:32.32.0(00011)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Voltage sags L1: %s\n" "$((10#${OBISVAL:-0}))"
            ;;
        "1-0:32.36.0")
            # Sample: 1-0:32.36.0(00011)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Voltage swells L1: %s\n" "$((10#${OBISVAL:-0}))"
            ;;
        "0-0:96.13.0")
            # Sample: 0-0:96.13.0()
            return
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Message: %s\n" "NA"
            ;;
        "1-0:32.7.0")
            # Sample: 1-0:32.7.0(227.0*V)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Instantaneous voltage L1: %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "1-0:31.7.0")
            # Sample: 1-0:31.7.0(006*A)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Instantaneous current L1: %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "1-0:21.7.0")
            # Sample: 1-0:21.7.0(01.375*kW)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Instantaneous power L1 (+P): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "1-0:22.7.0")
            # Sample: 1-0:22.7.0(01.375*kW)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Instantaneous power L1 (-P): %s\n" "`sanitize_number \"${OBISVAL%\**}\"`"
            ;;
        "0-0:96.13.0")
            # Sample: 0-0:96.13.0()
            return
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Message: %s\n" "NA"
            ;;
        "0-0:96.13.1")
            # Sample: 0-0:96.13.1()
            return
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Message: %s\n" "NA"
            ;;
        *":24.1.0")
            # Sample: 0-1:24.1.0(004)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Device-Type: %s\n" "$((10#${OBISVAL:-0}))"
            ;;
        *":96.1.0")
            # Sample: 0-1:96.1.0(724172152D2C340C)
            return
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g'  )
            printf "Equipment identifier: %s\n" "${OBISVAL:-ERR}"
            ;;
        *":24.2.1")
            # Sample: 0-1:24.2.1(230112201317W)(13.778*GJ)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1,/g'  )
            while IFS=, read -r OBISTS OBIS5M dummy ; do
                printf "Last 5M timestamp: %s\n" "`obists_to_epoch \"${OBISTS}\"`"
                printf "Last 5M value: %s\n" "`sanitize_number \"${OBIS5M%\**}\"`"
            done < <( echo $OBISVAL)
            ;;
        *)
            OBISVAL=$( echo $2 | sed -e 's/[^()]*(\([^)]*\))[^()]*/\1/g' )
            printf "  Miss) %s: %s\n" "$1" "${OBISVAL}"
            ;;
    esac
}

HOSTNAME="${COLLECTD_HOSTNAME:-`hostname -f`}"
INTERVAL="${COLLECTD_INTERVAL:-30}"
let TIMEOUT=$(( INTERVAL / 2 ))

SERHOST=${1:-smartpiw.iot.lan}
SERPORT=${2:-2000}

printf "Connecting to %s:%s.\n Interval %d\n\n" "${SERHOST}" "${SERPORT}" "${TIMEOUT}"

while IFS= read -r line; do
    case $line in
        /*)
            DSMRINFO=${line#/*}
            DSMRVERS=${DSMRINFO##*\\}
            DSMRTYPE=${DSMRINFO%\\*}
            if [ "${DSMRTYPE}" == "${DSMRVERS}" ]; then
                DSMRVERS=""
            fi
            ;;
        !*)
            CHKSUM=${line#!*}
            break
            ;;
        [0-9]*)
            DSMROBIS="${line%%(*}"
            DSMRVALUE="${line##$DSMROBIS}"
            DSMRVALUE="${DSMRVALUE//[$'\t\r\n ']}"
            #echo "Line: $line"
            #printf ".. OBIS(%s)\n" "${DSMROBIS}"
            #printf ".. VAL(%s)\n" "${DSMRVALUE}"
            parse_obis "$DSMROBIS" "$DSMRVALUE" 
            ;;
        *)
            echo "Skip: $line"
            ;;
    esac
done < <( timeout ${TIMEOUT} nc ${SERHOST} ${SERPORT} )

#printf "\nType: %s\nVersion: %s\n" "${DSMRTYPE}" "${DSMRVERS}"
#printf "Checksum: %s\n" "${CHKSUM}"
