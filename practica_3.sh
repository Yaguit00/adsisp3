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
        if [ $1 = "-a" ]; then

            while IFS=, read -r username passwd nombrecompleto; do
                exists=$(grep -c "^$username:" /etc/passwd)
                if [ $exists -ne 0 ]; then
                    echo "existes"
                else

                useradd -c $nombrecompleto -p $passwd -m -K PASS_MAX_DAYS=30 $username
                echo "$nombrecompleto ha sido creado"
                fi
            done < $2
        elif [ $1 = "-s" ]; then
            echo "quieres borrar y aun no se xd"
        fi
    fi
fi
