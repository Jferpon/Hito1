#!/bin/bash

# Suma de ejemplo
RESULTADO=$((2 + 3))

echo "Probando suma: 2 + 3 = $RESULTADO"

# Condición intencionalmente incorrecta
if [ "$RESULTADO" -eq 6 ]; then
    echo "TEST OK"
    exit 0
else
    echo "TEST FAIL"
    exit 1
fi

