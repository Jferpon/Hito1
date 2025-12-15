#!/bin/bash

# Valores a probar
A=2
B=3

# Suma
RESULTADO=$((A + B))

echo "Probando suma: $A + $B = $RESULTADO"

# Test
if [ "$RESULTADO" -eq  6 ]; then
    echo "TEST OK"
    exit 0
else
    echo "TEST FAIL"
    exit 1
fi
