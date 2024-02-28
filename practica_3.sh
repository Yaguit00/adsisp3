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
        if [ $1 = "-a" ]; then

            while IFS=, read -r username passwd nombrecompleto; do
                exists=$(grep -c "^$username:" /etc/passwd)
                if [ $exists -ne 0 ]; then
                    echo "El usuario $username ya existe"
                else
                    if [ $username = "" -o passwd = "" -o nombrecompleto = "" ];then
                        echo "Campo invalido"
                    else
                        useradd -c $nombrecompleto -p $passwd -m -U -K PASS_MAX_DAYS=30 -K UID_MIN=1815 $username
                        echo "$nombrecompleto ha sido creado"
                    fi
                fi
            done < $2
        elif [ $1 = "-s" ]; then
            if ! [ -d /extra/backup ];then #si no existe ete directorio, lo crea
                mkdir -p /extra/backup
            fi
            while IFS=, read -r deleteme inutil inutil1; do
                echo "entro en el while"
                exists=$(grep -c "^$username:" /etc/passwd)
                echo $exists
                if [ $exists -ne 0 ]; then
                    echo "entro en el ifgrep"
                    tar -cf /extra/backup/$(deleteme).tar /home/$deleteme/ #teoricamente crea el tar file
                    echo "he hecho el tar"
                    if [ $? ];then # si es 0, entro y elimino usuario
                        userdel  $deleteme
                        echo "borra el usuario $deleteme"
                    fi
                else
                    echo "pitos y flautas"
                fi

            done < $2
        else
            echo "ponme parametros validos o que chupacharcos" 1>&2
        fi
    fi
fi
