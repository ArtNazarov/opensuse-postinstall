#!/bin/bash

readonly ACT_REPOS=1

fnOnRepos() {
   
	# ---------- REPOS  -----------
	echo "ADD NEW REPOS? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper ar -f http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
		sudo zypper ar -f https://download.opensuse.org/repositories/devel:/languages:/python/openSUSE_Tumbleweed/ python
		sudo zypper ar -f https://packages.microsoft.com/yumrepos/vscode vscode
	else
		echo "skipped adding repos"
	fi
 
}

readonly ACT_KEYS=2

fnKeys() {
	# ---------- KEYS  -----------
	echo "INSTALL KEYS (NEED AWAIT LONG TIME)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper refresh
		sudo zypper install gpg2
		echo "Please import the necessary keys manually as needed."
	else
		echo "skipped keys update"
	fi
}

readonly ACT_ZIPTOOLS=3

fnZipTools() {
	# ---------- INSTALL ZIP TOOLS -----------
	echo "install unzip, unrar etc ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper install lrzip unrar unzip p7zip
	else
		echo "skipped unzip setup"
	fi
}

readonly ACT_MAKETOOLS=4 

fnMakeTools() {
	# ---------- MAKE TOOLS  -----------
	echo "INSTALL MAKE TOOLS (RECOMMENDED)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper install autoconf gcc automake make git rhash cmake llvm clang
	else
		echo "skipped make tools install"
	fi
}

readonly ACT_SYSTEMTOOLS=5

fnSystemTools() {
	# ---------- SYSTEM TOOLS  -----------

	echo "INSTALL SYSTEM TOOLS? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper install gvfs ccache mc
	else
		echo "skipped SYSTEM TOOLS install"
	fi
}

readonly ACT_NETWORKINGTOOLS=6 

fnNetworkingTools(){
	# -------------NETWORK -------------

	echo "INSTALL NETWORKING TOOLS (RECOMMENDED)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper install wpa_supplicant
		echo "Tuning network manager"
		sudo systemctl mask NetworkManager-wait-online.service
	else
		echo "skipped networking install"
	fi
}

readonly ACT_PROCFREQ=7 

fnProcFreq() {
	# ---------- proc frequency ----------
	cd ~
	echo "INSTALL PROC FREQ TOOLS (RECOMMENDED)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper install cpupower
		sudo cpupower frequency-set -g performance
		sudo zypper addrepo https://download.opensuse.org/repositories/multimedia:proaudio/openSUSE_Tumbleweed/multimedia:proaudio.repo
		sudo zypper refresh
		sudo zypper install cpupower-gui  # Установка графического интерфейса
	else
		echo "skipped PROC FREQ install"
	fi
	cd -
}

readonly ACT_AUTOPROCFREQ=8

fnAutoProcFreq(){
	# ---------- auto proc frequency ----------
	cd ~
	echo "INSTALL AUTO FREQ TOOLS ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper addrepo https://download.opensuse.org/repositories/home:aperezm/openSUSE_Tumbleweed/home:aperezm.repo
		sudo zypper refresh
		sudo zypper install auto-cpufreq
		systemctl enable auto-cpufreq
		systemctl start auto-cpufreq
	else
		echo "skipped AUTO FREQ install"
	fi
	cd -
}

readonly ACT_UPDATEGRUB=9

fnUpdateGrub() {
	# ------------ update grub ------
	cd ~
	echo "Update grub (Y if install kernel) [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo grub-mkconfig -o /boot/grub/grub.cfg
	else
		echo "skipped grub update"
	fi
}

readonly ACT_ZENKERNEL=10

fnZenKernel() {
	# ------------ INSTALL ZEN KERNEL ------

	cd ~
	echo "INSTALL ZEN KERNEL ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper addrepo https://download.opensuse.org/repositories/Kernel:/zen/openSUSE_Tumbleweed/Kernel:zen.repo
		sudo zypper refresh
		sudo zypper install kernel-zen kernel-zen-devel
	else
		echo "skipped ZEN KERNEL install"
	fi

}

readonly ACT_XANMODKERNEL=11

fnXanModKernel(){
	# ------------ INSTALL XANMOD KERNEL FOR AMD ------

	cd ~
	echo "INSTALL XANMOD KERNEL ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper addrepo https://download.opensuse.org/repositories/Kernel:/xanmod/openSUSE_Tumbleweed/Kernel:xanmod.repo
		sudo zypper refresh
		sudo zypper install kernel-xanmod kernel-xanmod-devel
	else
		echo "skipped XANMOD install"
	fi
}

readonly ACT_TKGKERNEL=12

fnTkgKernel() {
	# ------------ INSTALL TKG KERNEL ------

	cd ~
	echo "INSTALL LINUX TKG KERNEL ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper addrepo https://download.opensuse.org/repositories/Kernel:/TKG/openSUSE_Tumbleweed/Kernel:TKG.repo
		sudo zypper refresh
		sudo zypper install kernel-tkg kernel-tkg-devel
	else
		echo "skipped LINUX TKG install"
	fi
}

readonly ACT_MESA=13

fnMesa() {
	# ---------- MESA -----------

	echo "INSTALL MESA? [Y/N]?"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
			echo "begin mesa installation"
			sudo zypper addrepo https://download.opensuse.org/repositories/X11:XOrg/openSUSE_Tumbleweed/X11:XOrg.repo
			sudo zypper refresh
			sudo zypper install Mesa 
	else
			echo "skipped mesa installation"
	fi
}

readonly ACT_VULKAN=14 

fnVulkan(){
	# ---------- VULKAN -----------

	echo "INSTALL VULKAN? [Y/N]?"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
			echo "begin vulkan installation"
			sudo zypper addrepo https://download.opensuse.org/repositories/X11:XOrg/openSUSE_Tumbleweed/X11:XOrg.repo
			sudo zypper refresh
			sudo zypper install vulkan-devel  
	else
			echo "skipped vulkan installation"
	fi
}

readonly ACT_PORTPROTON=15

fnPortProton(){
	# ---------- PORTPROTON -----------

	echo "INSTALL AMD DRIVERS FOR GAMING AND PORTPROTON? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		echo "begin vulkan installation"
		sudo zypper addrepo https://download.opensuse.org/repositories/home:Boria138:PortProton/openSUSE_Tumbleweed/home:Boria138:PortProton.repo
		sudo zypper refresh
		sudo zypper install portproton
	else
		echo "skipped amd graphics and portproton installation"
	fi
}

readonly ACT_DBUSBROKER=16

fnDbusBroker() {
	# ---------- DBUS BROKER FOR VIDEO -----------
	cd ~
	echo "ENABLE DBUS BROKER ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		sudo zypper install dbus-broker
		sudo systemctl enable --now dbus-broker.service
	else
		echo "skipped dbus broker install"
	fi
	cd -
}

readonly ACT_CLEARFONTCACHE=17

fnClearFontCache(){
	# ---------- CLEAR FONT CACHE -----------

	echo "CLEAR FONT CACHE? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
			echo "clear font cache"
			sudo rm /var/cache/fontconfig/*
		rm ~/.cache/fontconfig/*
		fc-cache -r

	else
			echo "skipped clearing font cache"
	fi
}

readonly ACT_REMPREVCHROMEINSTALL=18

fnRemPrevChromeInstall() {
	# ---------- remove prev google  -----------

	echo "REMOVE PREVIOUS GOOGLE CHROME INSTALLATION? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
			echo "clear prev. google chrome installation"
			rm /opt/google -rf
	else
			echo "skipped clearing google chrome"
	fi

	# --------------------------
}

readonly ACT_SECURITYTOOLS=19

fnSecurityTools() {
	# ---------- SECURITY  -----------

	echo "INSTALL SECURITY TOOLS (APPARMOR, FIREJAIL)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		echo "begin install security"
			sudo zypper addrepo https://download.opensuse.org/repositories/security:apparmor/openSUSE_Tumbleweed/security:apparmor.repo
			sudo zypper refresh
			sudo zypper install apparmor-parser
		sudo systemctl enable apparmor.service
		sudo systemctl start apparmor.service
		sudo zypper install firejail
	else
			echo "skipped security install"
	fi
}

readonly ACT_BLUETOOTHTOOLS=20

fnBluetoothTools() {
    # ---------- BLUETOOTH TOOLS -----------

    echo "INSTALL BLUETOOTH TOOLS? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of Bluetooth tools..."

        # Установка необходимых пакетов для Bluetooth
        sudo zypper install bluez bluez-utils blueman

        echo "Bluetooth tools installed successfully."

    else
        echo "Skipped Bluetooth install"
    fi
}

readonly ACT_PULSEAUDIO=21

fnPulseAudio() {
    # ---------- SOUND -----------

    echo "INSTALL SOUND TOOLS (PULSEAUDIO)? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of sound tools..."

        # Установка PulseAudio и необходимых пакетов
        sudo zypper install pulseaudio pulseaudio-module-bluetooth jack2 pulseaudio-alsa pulseaudio-jack

        # Запуск PulseAudio
        sudo systemctl start pulseaudio
        sudo systemctl enable pulseaudio

        # Установка pavucontrol для управления звуком
        sudo zypper install pavucontrol

        # Перезапуск PulseAudio
        pulseaudio -k
        pulseaudio --start

        # Изменение прав доступа к конфигурации PulseAudio
        sudo chown $USER:$USER ~/.config/pulse

        echo "PulseAudio and related tools installed successfully."

    else
        echo "Skipped sound install"
    fi
}

readonly ACT_PIPEWIRE=22

fnPipewire(){
    # ---------- PIPEWIRE SOUND -----------

    echo "INSTALL PIPEWIRE SOUND? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of PipeWire sound..."

        # Установка PipeWire и необходимых пакетов
        sudo zypper install pipewire pipewire-pulse pipewire-alsa pavucontrol

        # Включение и запуск PipeWire
        systemctl --user enable --now pipewire.service pipewire-pulse.service

        echo "PipeWire installed successfully."

    else
        echo "Skipped PipeWire sound install"
    fi
}

readonly ACT_ALSA=23

fnAlsa(){
    # ---------- ALSA SOUND -----------

    echo "INSTALL ALSA SOUND? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of ALSA sound..."

        # Установка ALSA и необходимых утилит
        sudo zypper install alsa alsa-utils

        echo "ALSA installed successfully."

    else
        echo "Skipped ALSA sound install"
    fi
}

readonly ACT_AUDIOPLAYER=24

fnAudioPlayer() {
    # ---------- AUDIO PLAYER -----------

    echo "INSTALL AUDIO PLAYERS? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of audio players..."

        # Установка необходимых пакетов
        sudo zypper install python3-pip clementine

        # Установка библиотеки httpx через pip
        pip3 install httpx

        echo "Audio players installed successfully."

    else
        echo "Skipped audio players install"
    fi
}

readonly ACT_INTERNETTOOLS=25

fnInternetTools(){
    # ---------- INTERNET TOOLS -----------

    echo "INSTALL INTERNET TOOLS? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of internet tools..."

        # Добавление репозитория Packman для установки qBittorrent
        sudo zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2)/ packman
        sudo zypper refresh

        # Установка интернет-инструментов
        sudo zypper install qbittorrent uget filezilla putty

        # Установка uget-integrator (может не быть в стандартных репозиториях)
        sudo zypper install uget-integrator

        echo "Internet tools installed successfully."

    else
        echo "Skipped internet tools install"
    fi
}

readonly ACT_SCREENCAST=26

fnScreencast() {
    # ---------- SCREENCAST TOOLS -----------

    echo "INSTALL SCREENCAST TOOLS? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of SCREENCAST tools..."

        # Установка VokoscreenNG и OBS Studio
        sudo zypper install vokoscreenNG obs-studio

        echo "Screencast tools installed successfully."

    else
        echo "Skipped SCREENCAST tools install"
    fi
}

readonly ACT_PROGRAMMING=27

fnProgramming() {
    # ---------- PROGRAMMING LANGUAGES -----------

    echo "INSTALL PROGRAMMING LANGUAGES? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of programming languages..."

        # Установка необходимых языков программирования
        sudo zypper install python3 python3-pip ruby nodejs npm rustup

        echo "Programming languages installed successfully."

    else
        echo "Skipped programming languages install"
    fi
}

readonly ACT_DEVELOPERTOOLS=28

fnDeveloperTools() {
    # ---------- DEVELOPER TOOLS -----------

    echo "INSTALL DEVELOPER TOOLS? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of developer tools..."

        # Установка необходимых инструментов разработчика
        sudo zypper install github-desktop notepadqq lazarus virtualbox eclipse docker

        echo "Developer tools installed successfully."

    else
        echo "Skipped developer tools install"
    fi
}

readonly ACT_FLATPAKSYSTEM=29

fnFlatpakSystem(){
    # ---------- FLATPAK SYSTEM -----------

    echo "INSTALL FLATPAK? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Beginning installation of developer tools..."

        # Установка необходимых пакетов для Flatpak
        sudo zypper install flatpak
		sudo zypper install PackageKit 

        # Добавление репозитория Flathub
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

        # Обновление Flatpak
        flatpak update

        # Добавление репозитория KDE Apps
        flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo

        # Обновление Flatpak
        flatpak update

    else
        echo "Skipped Flatpak install"
    fi
}

readonly ACT_FLATPAKSOFT=30

fnFlatpakSoft() {
    # ---------- FLATPAK SOFT -----------

    echo "INSTALL OFFICE SOFTWARE FROM FLATPAK? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        # Установка офисных приложений через Flatpak
        flatpak install flathub org.libreoffice.LibreOffice -y  # LibreOffice
        flatpak install flathub com.softmaker.FreeOffice -y      # FreeOffice

        echo "Office software installed successfully."

    else
        echo "Skipped office software install"
    fi
}

readonly ACT_SNAP=31

fnSnap() {
	# ---------- SNAP -----------

	echo "INSTALL SNAPD (PACKAGE MANAGER)? [Y/N]?"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
			echo "Adding snap repository..."
			sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed snappy
			sudo zypper --gpg-auto-import-keys refresh
			sudo zypper dup --from snappy
			echo "Installing snapd..."
			sudo zypper install snapd
			echo "Enabling and starting snapd service..."
			sudo systemctl enable --now snapd
			sudo systemctl enable --now snapd.apparmor
			echo "Installation complete. You may need to log out and back in or source /etc/profile."
	else
			echo "Skipped snap installation"
	fi
	# --------------------------
}

readonly ACT_VIDEO=32

fnVideo() {
	# ---------- VIDEO  -----------

	echo "INSTALL VIDEO PLAYER (VLC)? [Y/N]?"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
			echo "Adding VLC repository..."
			sudo zypper addrepo --refresh https://download.videolan.org/pub/vlc/SuSE/Tumbleweed/ vlc
			sudo zypper refresh
			echo "Installing VLC..."
			sudo zypper install vlc vlc-codecs
	else
			echo "Skipped video player installation"
	fi
	# --------------------------
}

readonly ACT_BACKUPS=33

fnBackups() {
	echo "INSTALL BACKUPING SOFTWARE? [Y/N]?"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

		sudo zypper addrepo https://download.opensuse.org/repositories/Archiving:Backup/openSUSE_Tumbleweed/Archiving:Backup.repo
		sudo zypper refresh
		sudo zypper install safecopy
		sudo zypper install fsarchiver
		sudo zypper install deja-dup
		sudo zypper install backintime

	else
			echo "Skipped video player installation"
	fi

}

readonly ACT_PASSWORDTOOL=34

fnPasswordTool() {
    # ---------- PASSWORD TOOL -----------

    echo "INSTALL PASSWORD TOOL? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Installing password tools..."

        # Установка KeePassXC и других приложений
        sudo zypper install keepassxc  gopass

        echo "Password tools installed successfully."

    else
        echo "Skipped password tool install"
    fi
    # --------------------------
}

readonly ACT_WINE=35

fnWine() {
    # ---------- WINE -----------

    echo "INSTALL WINE? [Y/N]?"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        echo "Installing Wine"

        # Добавление репозитория Wine
        sudo zypper addrepo https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/Emulators:Wine.repo
        sudo zypper refresh

        # Установка необходимых пакетов
        sudo zypper install cabextract wine winetricks

        # Установка дополнительных библиотек
        sudo zypper install lib32-gst-plugins-base lib32-gst-plugins-good libgphoto2 lib32-libpulse lib32-libxcomposite lib32-libxinerama lib32-opencl-icd-loader lib32-sdl2 unixodbc lib32-v4l-utils wine-gecko wine-mono

        # Настройка Wine
        chown $USER:$USER -R /home/artem/.wine

        export WINEARCH=win32
        export WINEDEBUG=-all
        WINEPREFIX=/home/artem/.wine

        ./wt-install-all.sh

    else
        echo "Skipped Wine install"
    fi
    # --------------------------
}

readonly ACT_DE=36

fnDe(){
    # ---------- DE ---------

    echo "INSTALL DE additional software? [Y/N]"
    echo "Confirm [Y,n]"
    read input
    if [[ $input == "Y" || $input == "y" ]]; then
        sudo zypper install ffmpegthumbs
    else
        echo "Skipped DE addons install"
    fi
}

readonly ACT_MESSENGERS=37

fnMessengers() {
	# ---------- MESSENGERS -----------

	echo "INSTALL MESSENGERS? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then
		echo "begin install MESSENGERS"

		# Add repository for Telegram Desktop
		sudo zypper addrepo https://download.opensuse.org/repositories/server:messaging/openSUSE_Factory/server:messaging.repo
		sudo zypper refresh
		sudo zypper install telegram-desktop

		# Install Viber and WhatsApp for Linux using Flatpak or other method if available
		sudo zypper install flatpak  # Ensure Flatpak is installed
		flatpak install flathub com.viber.Viber
		flatpak install com.github.eneshecan.WhatsAppForLinux

	else
		echo "skipped MESSENGERS install"
	fi
}

readonly ACT_ANANICY=38

fnAnanicy(){
	# ---------- ANANICY -----------
	cd ~
	echo "INSTALL ANANICY ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

		echo "Installing ananicy"
		sudo zypper install git make
		git clone https://gitlab.com/ananicy-cpp/ananicy-cpp.git
		cd ananicy-cpp
		make install
		sudo systemctl enable --now ananicy

	else
		echo "skipped ananicy install"
	fi
	cd -
}

readonly ACT_RNG=39

fnRng(){
	# ----------- RNG ---------------

	cd ~
	echo "ENABLE RNG (CHOOSE N IF INSTALL ANANICY) ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

		echo "Installing RNG"
		sudo zypper install rng-tools
		sudo systemctl enable --now rngd

	else
		echo "skipped RNG install"
	fi
	cd -
}

readonly ACT_HAVEGED=40

fnHaveged(){
	# ---------- HAVEGED -----------
	cd ~
	echo "INSTALL HAVEGED ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

		sudo zypper install haveged
		sudo systemctl enable haveged

	else
		echo "skipped haveged install"
	fi
	cd -
	# --------------------------
}

readonly ACT_TRIMSSD=41

fnTrimSSD(){
	# ---------- TRIM FOR SSD -----------
	cd ~
	echo "ENABLE TRIM FOR SSD ? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

		sudo zypper install util-linux
		sudo systemctl enable fstrim.timer
		sudo fstrim -v /
		sudo fstrim -va /

	else
		echo "skipped trim switching"
	fi
	cd -
}

readonly ACT_INSTALLGREETERS=42

fnInstallGreeters(){
	# ---------- install greeters -----------
	cd ~
	echo "INSTALL GREETERS (LOGIN SCREENS)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

	./install-greeters.sh

	else
			echo "skipped install greeters"
	fi
	cd -
}

readonly ACT_DISPLAYMANAGER=43

fnDisplayManager() {
	# ---------- choose display manager -----------
	cd ~
	echo "INSTALL AND SELECT DM (display managers)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

		sudo zypper install gdm
		sudo zypper install lightdm
		sudo zypper install lxdm

		echo "G) set gdm, L) set lightdm, X) set lxdm S) sddm[KDE] or any key to skip select"
		read Keypress

		case "$Keypress" in
			"G"  ) sudo ./dm/enable-gdm.sh ;;
			"L"  ) sudo ./dm/enable-lightdm.sh ;;
			"X"  ) sudo ./dm/enable-lxdm.sh ;;
			"S"  ) sudo ./dm/enable-sddm.sh ;;
			*   ) echo "skipped select" ;;
		esac

	else
		echo "skipped dm install"
	fi

	cd -
}

readonly ACT_INSTALLDE=44

fnInstallDE() {
	# ---------- install de -----------
	cd ~
	echo "INSTALL AND SELECT DE (desktop enviroment)? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

	./de/install-plasma-enviroment.sh
	./de/install-cinnamon-enviroment.sh
	./de/install-gnome-enviroment.sh
	./de/install-lxqt-enviroment.sh
	./de/install-deepin-enviroment.sh
	./de/install-lxde-enviroment.sh
	./de/install-mate-enviroment.sh
	./de/install-xfce4-enviroment.sh


	else
			echo "skipped dm install"
	fi

	cd -
	# --------------------------
}

readonly ACT_BLOCKADS=45

fnBlockAds() {
	# ---------- block ads  -----------
	cd ~
	echo "Setup hosts for blocking ads? [Y/N]?"
	echo "Confirm [Y,n]"
	read input
	if [[ $input == "Y" || $input == "y" ]]; then

	wget https://raw.githubusercontent.com/CrafterKolyan/hosts-adblock/master/hosts
	sudo cp /etc/hosts /etc/hosts.bak
	sudo cp hosts /etc/hosts
	sudo systemctl restart NetworkManager.service

	else
			echo "skipped hosts install"
	fi
}

# Функция диспетчер
fnSelect() {
    local i=$1
    echo "Опция с вариантом $i вызвана!"
    case $i in
        $ACT_REPOS)
            fnOnRepos;;
        $ACT_KEYS)
            fnKeys;;
        $ACT_ZIPTOOLS)
            fnZipTools;;
        $ACT_MAKETOOLS)
            fnMakeTools;;
        $ACT_SYSTEMTOOLS)
            fnSystemTools;;
        $ACT_NETWORKINGTOOLS)
            fnNetworkingTools;;
        $ACT_PROCFREQ)
            fnProcFreq;;
        $ACT_AUTOPROCFREQ)
            fnAutoProcFreq;;
        $ACT_UPDATEGRUB)
            fnUpdateGrub;;
        $ACT_ZENKERNEL)
            fnZenKernel;;
        $ACT_XANMODKERNEL)
            fnXanModKernel;;
        $ACT_TKGKERNEL)
            fnTkgKernel;;
        $ACT_MESA)
            fnMesa;;
        $ACT_VULKAN)
            fnVulkan;;
        $ACT_PORTPROTON)
            fnPortProton;;
        $ACT_DBUSBROKER)
            fnDbusBroker;;
        $ACT_CLEARFONTCACHE)
            fnClearFontCache;;
        $ACT_REMPREVCHROMEINSTALL)
            fnRemPrevChromeInstall;;
        $ACT_SECURITYTOOLS)
            fnSecurityTools;;
        $ACT_BLUETOOTHTOOLS)
            fnBluetoothTools;;
        $ACT_PULSEAUDIO)
            fnPulseAudio;;
        $ACT_PIPEWIRE)
            fnPipewire;;
        $ACT_ALSA)
            fnAlsa;;
        $ACT_AUDIOPLAYER)
            fnAudioPlayer;;
        $ACT_INTERNETTOOLS)
            fnInternetTools;;
        $ACT_SCREENCAST)
            fnScreencast;;
        $ACT_PROGRAMMING)
            fnProgramming;;
        $ACT_DEVELOPERTOOLS)
            fnDeveloperTools;;
        $ACT_FLATPAKSYSTEM)
            fnFlatpakSystem;;
        $ACT_FLATPAKSOFT)
            fnFlatpakSoft;;
        $ACT_SNAP)
            fnSnap;;
        $ACT_VIDEO)
            fnVideo;;
        $ACT_BACKUPS)
            fnBackups;;
        $ACT_PASSWORDTOOL)
            fnPasswordTool;;
        $ACT_WINE)
            fnWine;;
        $ACT_DE)
            fnDe;;
        $ACT_MESSENGERS)
            fnMessengers;;
        $ACT_ANANICY)
            fnAnanicy;;
        $ACT_RNG)
            fnRng;;
        $ACT_HAVEGED)
            fnHaveged;;
        $ACT_TRIMSSD)
            fnTrimSSD;;
        $ACT_INSTALLGREETERS)
            fnInstallGreeters;;
        $ACT_DISPLAYMANAGER)
            fnDisplayManager;;
        $ACT_INSTALLDE)
            fnInstallDE;;
        $ACT_BLOCKADS)
            fnBlockAds;;
    esac
}

# Определяем массив с кортежами (логическое значение, метка)
options=(
    "FALSE" "Repos Репозитории 1"
    "FALSE" "Keys Ключи 2"
    "FALSE" "Zip Архиваторы 3"
    "FALSE" "Make Сборка и компиляция 4"
    "FALSE" "System Системные утилиты 5"
    "FALSE" "Networking Сетевые программы 6"
    "FALSE" "CPU Настройка процессора 7"
    "FALSE" "AutoCPU Автоматическая настройка процессора 8"
    "FALSE" "Update grub Обновить загрузчик 9"
    "FALSE" "Zen kernel Ядро zen 10"
    "FALSE" "XanMod kernel Ядро xanmod 11"
    "FALSE" "Tkg kernel Ядро tkg 12"
    "FALSE" "Mesa 13"
    "FALSE" "Vulkan 14"
    "FALSE" "PortProton 15"
    "FALSE" "Dbus broker 16"
    "FALSE" "Clear font cache Очистить кеш шрифтов 17"
    "FALSE" "Remove old Chrome Удалить старый профиль Chrome 18"
    "FALSE" "Security tools Утилиты безопасности 19"
    "FALSE" "Bluetooth 20"
    "FALSE" "PulseAudio 21"
    "FALSE" "PipeWire 22"
    "FALSE" "Alsa 23"
    "FALSE" "Audio Player 24"
    "FALSE" "Internet Tools Утилиты для интернета 25"
    "FALSE" "Screencast Запись экрана 26"
    "FALSE" "Programming Программирование 27"
    "FALSE" "Development tools Утилиты для разработчиков 28"
    "FALSE" "Flatpak 29"
    "FALSE" "Flatpak soft 30"
    "FALSE" "Snap 31"
    "FALSE" "Video 32"
    "FALSE" "Backups 33"
    "FALSE" "Password tool Хранилки паролей 34"
    "FALSE" "Wine 35"
    "FALSE" "DE 36"
    "FALSE" "Messengers Для переписки 37"
    "FALSE" "Ananicy 38"
    "FALSE" "Rng 39"
    "FALSE" "Haveged 40"
    "FALSE" "Trim SSD 41"
    "FALSE" "GREETERS 42"
    "FALSE" "Display manager 43"
    "FALSE" "Install DE 44"
    "FALSE" "Block ads Блокировка рекламы 45"

)

# Создаем диалоговое окно с флажками
selected=$(zenity --list --checklist \
    --column "Выбор" \
    --column "Опции" \
    "${options[@]}")

# Выбираем номера...
selections=($( echo $selected | grep -o '[0-9]\+'))

echo "Выбранные опции: $selections"
# вызываем над номерами функцию
    for number in "${selections[@]}"; do
    	fnSelect "$number"
	done
