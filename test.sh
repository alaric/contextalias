#!/bin/zsh

if [[ ! -d $1 ]]; then
    echo "Directory '$1' does not exist."
    exit 1;
fi

CURR_WD=`pwd`
export TEST_DIR=`realpath $1`

alias aliasa="echo 'a' >>$TEST_DIR/results.txt"
source contextalias.zsh

cd $1
rm -f results.txt
touch results.txt

aliasa

cd append_b
aliasa
cd ../append_c/dummy
aliasa
cd ../..
aliasa
cd blank
aliasa
cd ..
cd append_b/append_e
aliasa
aliasb
cd ../..

# Check the results
diff -u results.txt expected.txt 2>&1 1>/dev/null
if (( $? != 0 )); then
    echo "Bad result"
    exit 1
fi

rm results.txt
cd $CURR_WD
echo "All OK"

