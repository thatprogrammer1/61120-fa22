#!/bin/bash
# USAGE: ./run-tests.sh <path to mitscriptc> <path to mitscript> <path to results>
# e.g. running from VM folder
# >>>  ../tests/a3/run-bytecode-tests.sh ./mitscript out.txt

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT=$SCRIPT_DIR/..

TIMEOUT=10

INTERPRETER=$1
RESULTS=$2
echo "" > $RESULTS

# Note bash methods have their own parameters internally ($1 $2 etc)

run_interp_tests(){
TOTAL=0
COUNT=0

if [ ! -d $ROOT/$1 ]; then
    return
fi

for filename in $ROOT/$1/*.mit; do
    if [ ! -f ${filename}bc ]; then
        continue
    fi
    rm -f tmp.out tmp.err
    if test -f $filename.in; then
        $(timeout $TIMEOUT $INTERPRETER -b ${filename}bc < $filename.in > tmp.out 2> tmp.err)
    else
        $(timeout $TIMEOUT $INTERPRETER -b ${filename}bc > tmp.out 2> tmp.err)
    fi
    CODE=$?
    if [[ $filename =~ $ROOT/$1/bad[0-9]*.mit && $CODE != 0 ]]; then
        COUNT=$((COUNT+1))
    elif [[ $(cat $ROOT/$1/$(basename $filename).out) =~ [A-Z][A-Za-z]+Exception ]]; then
        # Used to be *"${BASH_REMATCH[0]}"*, but this was relaxed
        if [[ $(cat tmp.err tmp.out) == *"Exception"* ]]; then
            COUNT=$((COUNT+1))
        else
            echo "Fail Exception: $(basename $filename) (exit code $CODE)" >> $RESULTS
        fi
    else
        if diff tmp.out $ROOT/$1/$(basename $filename).out >> $RESULTS; then
            COUNT=$((COUNT+1))
        else
            echo "Fail: $(basename $filename) (exit code $CODE)" >> $RESULTS
        fi
    fi
    TOTAL=$((TOTAL+1))
    rm -f tmp.out tmp.err
done
echo "Done" >> $RESULTS
}

run_interp_tests a3/public/mit
echo "Passed $COUNT out of $TOTAL tests when testing just bytecode interpreter on public a3"
run_interp_tests a3/private
echo "Passed $COUNT out of $TOTAL tests when testing just bytecode interpreter on private a3"


run_bad_tests(){

TOTAL=0
COUNT=0

if [ ! -d $ROOT/a3/$1 ]; then
    return
fi

for filename in $ROOT/a3/$1/*mitbc; do
    rm -f tmp.out tmp.err
    timeout 5 $INTERPRETER -b $filename > tmp.out 2> tmp.err
    CODE=$?
    [[ $(cat $filename.out) =~ [A-Z][A-Za-z]+Exception ]]
    if [[ $(cat tmp.err tmp.out) == *"Exception"* ]]; then
        COUNT=$((COUNT+1))
    else
        echo "Expected ${BASH_REMATCH[0]} got $(cat tmp.err tmp.out)"
        echo "Fail Exception: $(basename $filename) (exit code $CODE)" >> $RESULTS
    fi
    TOTAL=$((TOTAL+1))
    rm -f tmp.out tmp.err
done
echo "Done" >> $RESULTS
}

run_bad_tests public/mitbc
echo "Passed $COUNT out of $TOTAL public bad bytecode tests"
run_bad_tests private/badbytecode
echo "Passed $COUNT out of $TOTAL private bad bytecode tests"

