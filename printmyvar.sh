#!/bin/bash
#

[ -v myvar ]  || echo "There is no variable named myvar"
[ -v myvar ] || exit 1
[ -n "$myvar" ] && echo "myvar has '$myvar' in it." || echo "myvar has nothing in it."


