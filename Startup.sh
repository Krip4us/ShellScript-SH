#! /bin/bash
echo "sistema de fichaje: [entrar/salir]" ;read fichar
usuario=$(whoami)
fecha=$(date)
formato=$(echo "user '$usuario' fecha '$fecha'")

# SISTEMA DE FICHAJE [entrar / salir / show[closed,opened,errors]]
if [ $fichar = "entrar"  ];
	then
		echo $formato >> $HOME/.profile_entry
		echo "_______________________________"
		echo "welcome to spartan server . . ."

	elif [ $fichar = "salir"  ];
	then
		echo $formato >> $HOME/.profile_exit
		echo "good bye spartan . . ."
		echo "_______________________________"
		echo "session closed by the user. TIME: 1m"
		#sleep 600
		#pkill -u $usuario
		exit
	elif [ $fichar = "show"  ];
	then
		entrylog=$(cat $HOME/.profile_entry)
		exitlog=$(cat $HOME/.profile_exit)
		errorlog=$(cat $HOME/.profile_error)
		clear
		printf "\n ENTRY LOG:\n 
		$entrylog \n -------------- \n 
		EXIT LOG: \n 
		$exitlog \n ---------------- \n 
		ERROR LOG: \n 
		$errorlog \n"
	else
		echo "entrada no permitida"
		echo $formato >> $HOME/.profile_error
		exit
fi

#sistemas de seguridad de las copias
if [ $usuario = "krip4us"  ];
	then
		clear
		echo "BACKUP APP . . . ."
		./media/srv230/LINUX/srv248/srv/backup_copia.ps1.sh

	else
		exit
fi

echo $formato > $HOME/.profile_date
echo
exit
