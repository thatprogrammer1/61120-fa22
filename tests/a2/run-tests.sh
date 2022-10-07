#!/bin/bash
# USAGE: ./run-tests.sh [public|private] <path to mitscript>
TESTS=$1
INTERPRETER=$2 # don't forget a ./ preceeding your interp e.g. ./mitscript
TIMEOUT=60

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

TOTAL=0
COUNT=0

PTOTAL=0
PCOUNT=0

for filename in $SCRIPT_DIR/$TESTS/*.mit; do
    if [[ $filename == *bad*.mit ]]; then
        echo $filename
        OUT=$(timeout $TIMEOUT $INTERPRETER $filename 2>&1)
        CODE=$?
        if [[ $CODE -ne 0 ]]; then
            COUNT=$((COUNT+1))
        else
            echo "Fail: $(basename $filename) (exit code $CODE) (OUT: $OUT)"
        fi
        TOTAL=$((TOTAL+1))
        continue
    fi
    echo $filename
    if test -f $filename.in; then
        timeout $TIMEOUT $INTERPRETER $filename < $filename.in > tmp1.out 2> tmp1.err
    else
        timeout $TIMEOUT $INTERPRETER $filename > tmp1.out 2> tmp1.err
    fi
    CODE=$?
    if [[ $(cat $SCRIPT_DIR/$TESTS/$(basename $filename).out) =~ [A-Z][A-Za-z]+Exception ]]; then
        if [[ $(cat tmp1.err tmp1.out) = *"${BASH_REMATCH[0]}"* ]]; then
            PCOUNT=$((PCOUNT+1))
            COUNT=$((COUNT+1))
        else
						cat tmp1.out tmp1.err
            echo "Fail Exception: $(basename $filename) (exit code $CODE)"
        fi
    else
        if diff tmp1.out $SCRIPT_DIR/$TESTS/$(basename $filename).out; then
            PCOUNT=$((PCOUNT+1))
            COUNT=$((COUNT+1))
        else
						cat tmp1.out tmp1.err
            echo "Fail: $(basename $filename) (exit code $CODE)"
        fi
    fi
    TOTAL=$((TOTAL+1))
    PTOTAL=$((PTOTAL+1))
    rm -f tmp1.out tmp1.err
done

echo "Passed $COUNT out of $TOTAL tests"