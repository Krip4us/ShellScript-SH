####################################
#
# Backup to NFS mount script.
#
####################################
# este script es solo para root del sistema
# primero se ejecutara FILE ANTERIOR BACKUP CONFIG
# regla de copias: margen 30dias
#! /bin/bash 
function saludo(){
	# What to backup. BACKUP FILES 
        # separate by spaces
	echo "What to backup" ; read backup_files
	# Where to backup to. DESTINATION
	echo "Where to backup to" ; read dest
	# Create archive filename. CONFIG ARCHIVE BACKUP
	day=$(date +"%m%d%Y")
	hostname=$(hostname -s)
	archive_file="$hostname-$day.tgz"
	echo "CONFIG: Backing up $backup_files to $dest/$archive_file"
	echo "CONFIG: today is $day : backing up only $day files"	
	# FILE ANTERIOR BACKUP CONFIG
	system_name=$(hostname -s)
	date_anterior=$(date +"%m%d%Y" -d "-30 days")
	file_anterior_backup="$system_name-$date_anterior.tgz"	
}
saludo

function backup(){
	if [ -d $dest ];
	then
		if [ -f  $dest/$archive_file ];
		then
			echo "function(backup):la copia ya existe"
			exit
		else
			echo "no existe ninguna version de $day"
			# las copias se realizaran con las siguientes condiciones: margen de 1 mes
			if [ -f  $dest/$file_anterior_backup ]; 
			then
				echo "CONFIG(file_anterior_backup_config): la copia no se puede realizar"
				exit
			else
				# la copia se realiza si todas las condiciones anteriores se incumplen
				echo "CONFIG: la copia se creara"
			fi
			echo "continue?????:(y/n):" ; read ask_continue
			if [ $ask_continue == "y" ];
			then
				sudo tar czf $dest/$archive_file $backup_files
			elif [ $ask_continue == "n" ]; 
            		then
				echo "session closed by the user"
				exit
			else
				echo "error in read"
				exit
			fi	
		fi	
	else
		echo "el origen o el destino no existen : $?"
		echo "el programa termino su ejecucion con ERRORES"
		exit
	fi
}
backup
	
if [ -f $dest/$archive_file ]; 
	then
		clear
		echo "codigo de retorno: $?"
		echo "Backup finished"
		echo "------------------------------"
		# Long listing of files in $dest to check file sizes.
		ls -lh $dest | grep $archive_file
		echo
	else
		echo "la copia no se realizido por motivos inesperados"
fi
