function Update_ShellScript_sh_Main() {
    function Update_Backup() {
        updateBackup=$(wget -o - https://raw.githubusercontent.com/Krip4us/ShellScript-SH/main/Backup.sh --no-check-certificate)
        echo $updateBackup
        if [ -f Backup.sh.1 ]; then
            echo "updating backup script"
            cp Backup.sh.1 Backup.sh
            echo "removing copy backup file"
            rm Backup.sh.1
        else
            echo "error in updating backup script"
        fi
    }

    function Update_Startup() {
        updateStartup=$(wget -o - https://raw.githubusercontent.com/Krip4us/ShellScript-SH/main/Startup.sh --no-check-certificate)
        echo $updateStartup
        if [ -f Startup.sh.1 ]; then
            echo "updating Startup script"
            cp Startup.sh.1 Startup.sh
            echo "removing copy Startup file"
            rm Startup.sh.1
        else
            echo "error in updating Startup script"
        fi
    }

    function update_Install() {
        updateInstall=$(wget -o - https://raw.githubusercontent.com/Krip4us/ShellScript-SH/main/Install.sh --no-check-certificate)
        echo $updateInstall
        if [ -f Install.sh.1 ]; then
            echo "updating Install script"
            cp Install.sh.1 Install.sh
            echo "removing copy Install file"
            rm Install.sh.1
        else
            echo "error in updating Install script"
        fi
    }

    echo "choose: [backup / startup / install / all]" ; read update_script
    if [ $update_script == all ]; then
        Update_Backup ; Update_Startup ; update_Install
    elif [ $update_script == backup ]; then
        Update_Backup
    elif [ $update_script == startup ]; then
        Update_Startup
    elif [ $update_script == install ]; then
        update_Install 
    else
        echo "error"
    fi
}
Update_ShellScript_sh_Main
