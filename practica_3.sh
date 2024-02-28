#!/bin/bash
#878417, Torres Garcia, Yago, T, 3, A
#870959, Pueyo Soria, Nicolas, T, 3, A

if [ $EUID -ne 0 ]; then
    echo "“Este script necesita privilegios de administracion"
fi