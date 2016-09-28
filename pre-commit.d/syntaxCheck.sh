#!/bin/bash

echo ""
echo "--------------------------Error Checking--------------------------"
echo ""

syntaxChecking(){
    ROOT_DIR=""
    LIST=$(git diff-index --cached --name-only --diff-filter=ACMR HEAD)
    ERRORS_BUFFER=""
    for file in $LIST
    do
        EXTENSION=$(echo "$file" | grep ".php$")
        if [ "$EXTENSION" != "" ]; then
            ERRORS=$(php -l "$ROOT_DIR$file" 2>&1 | grep "Parse error")
            if [ "$ERRORS" != "" ]; then
                if [ "$ERRORS_BUFFER" != "" ]; then
                    ERRORS_BUFFER="$ERRORS_BUFFER\n$ERRORS"
                else
                    ERRORS_BUFFER="$ERRORS"
                fi
                echo "Syntax errors found in file: $file "
            fi

            # Check for xdebug statments
            ERRORS=$(grep -nH xdebug_ "$ROOT_DIR$file" | \
                     sed -e 's/^/Found XDebug Statment : /')
            if [ "$ERRORS" != "" ]; then
                if [ "$ERRORS_BUFFER" != "" ]; then
                    ERRORS_BUFFER="$ERRORS_BUFFER\n$ERRORS"
                else
                    ERRORS_BUFFER="$ERRORS"
                fi
            fi
        fi
    done
    if [ "$ERRORS_BUFFER" != "" ]; then
        echo
        echo "Found PHP parse errors: "
        echo -e $ERRORS_BUFFER
        echo
        echo "PHP parse errors found. Fix errors and commit again."
        return 1
    else
        echo "No PHP parse errors found. Committed successfully."
        return 0
    fi
}