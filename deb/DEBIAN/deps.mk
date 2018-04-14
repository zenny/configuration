# deps.mk --- Authoritative list of dependencies
### Prelude:
DEPS=locales
### Libraries:
DEPS+=libclass-isa-perl libswitch-perl liblockfile-bin libpam-systemd
### Utils:
DEPS+=pass telnet file reportbug lsof gawk vim tmux units	    \
	debian-goodies sudo vrms xz-utils alsa-utils bzip2 less	    \
	sqlite3 zip unzip python3-reportbug groff-base gnupg2 lshw  \
	openssh-client host texinfo cups-bsd cups-client bind9-host \
	sloccount pandoc
### Services:
DEPS+=nginx syncthing openssh-server avahi-daemon avahi-autoipd
### Devtools:
DEPS+=automake autoconf autoconf-archive strace build-essential bmake \
	exuberant-ctags gdb
### Laptop:
DEPS+=laptop-mode-tools hdparm
### Desktop & Xorg:
#### Base:
DEPS+=sane sane-utils dbus-x11 feh dunst suckless-tools i3lock	\
	notify-osd libnotify-bin
#### XMonad:
DEPS+=libghc-xmonad-dev libghc-xmonad-contrib-dev libghc-xmonad-doc \
	libghc-xmonad-contrib-doc
#### Xorg:
DEPS+=xorg xserver-xorg-input-all xserver-xorg-video-all xinput	\
	x11-apps
### Fonts:
DEPS+=fonts-freefont-ttf fonts-liberation fonts-dejavu
### Apps:
DEPS+=libreoffice libreoffice-help-en-gb		      \
	libreoffice-help-en-us xclip gimp gparted gnuplot feedgnuplot \
	gv cheese pavucontrol mpv quodlibet simple-scan evince	      \
	vokoscreen qutebrowser chromium
### Misc:
#DEPS+=gnome-session		# On Ubuntu, for normal Gnome 3 session
DEPS+=gnutls-bin cups cups-browsed cups-filters			      \
	debian-archive-keyring memtest86+ pciutils netcat-traditional \
	krb5-locales bash-completion ncurses-term mime-support	      \
	pulseaudio
### Libraries:
DEPS+=libxrandr-dev
### Documentation:
DEPS+=autoconf-doc ffmpeg-doc mailutils-doc nginx-doc perl-doc	   \
	python3-doc sbcl-doc gimp-help-en git-doc gnutls-doc	   \
	doc-debian manpages man-db debian-faq gnuplot-doc bash-doc \
	linux-doc glibc-doc # glibc-doc-reference manpages-dev	   \
	#hyperspec doc-base make-doc
### Emacs:
DEPS+=libjansson-dev		# Jansson is for faster JSON.
DEPS+=gnutls-dev
### Internet tools:
DEPS+=bind9utils net-tools curl phantomjs corebird dnsutils w3m	\
	w3m-el webalizer wget rsync traceroute finger whois
#### VPN
DEPS+=openvpn resolvconf
### VCS:
DEPS+=mercurial cvs git subversion rcs python-hglib python3-hglib \
	python-dulwich python-fastimport git-cvs gitk quilt
### Mail:
DEPS+=clamav mailutils spamassassin spamc
### Multimedia:
DEPS+=vorbisgain youtube-dl vorbis-tools
### TeX:
DEPS+=biber texlive-xetex texlive-full texlive-publishers	\
	texlive-bibtex-extra
### Programming languages:
#### Lisp:
DEPS+=guile-2.0 guile-2.0-doc guile-json guile-library sbcl
#### Python:
DEPS+=python-minimal python python3 python3-pip virtualenv	\
	python3-venv python-flup python3-tk python3-matplotlib
#### Perl:
DEPS+=perl perl-modules-5.24 perlbrew cpanminus liblocal-lib-perl
#### Ruby:
DEPS+=ruby bundler ri 

### Rules:
list-deps:
	@echo $(DEPS)
