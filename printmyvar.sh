#!/bin/bash
#

if cd /flooble; then
    if touch foo; then 
        echo "made foo"
    else
        echo failed to make foo
        exit 1
    fi
else
    echo failed to cd to flooble
    exit 1
fi

if [ -v myvar ]; then
    echo "There is no variable named myvar"
    exit 1
fi

[ -n "$myvar" ] && echo "myvar has '$myvar' in it." || echo "myvar has nothing in it."


