#!/bin/bash
#878417, Torres Garcia, Yago, T, 3, A
#870959, Pueyo Soria, Nicolas, T, 3, A

if [ $# -ne 2 ]; then
    echo "Numero incorrecto de parametros"
else

    if [ $EUID -ne 0 ]; then
        echo "Este script necesita privilegios de administracion"
        return
    else
        echo "ole, tienes permisos"
        while IFS=, read -r username passwd nombrecompleto; do
            if [ grep $username /etc/passwd ];then
                echo "existes"
            else
            useradd -c $nombrecompleto -p $passwd -m -K PASS_MAX_DAYS=30 $username
            echo "$nombrecompleto ha sido creado"
            fi
       done < $2
    fi
fi