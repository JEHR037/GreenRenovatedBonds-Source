
Debian
====================
This directory contains files used to package greenrenovatedbondsd/greenrenovatedbonds-qt
for Debian-based Linux systems. If you compile greenrenovatedbondsd/greenrenovatedbonds-qt yourself, there are some useful files here.

## greenrenovatedbonds: URI support ##


greenrenovatedbonds-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install greenrenovatedbonds-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your greenrenovatedbonds-qt binary to `/usr/bin`
and the `../../share/pixmaps/greenrenovatedbonds128.png` to `/usr/share/pixmaps`

greenrenovatedbonds-qt.protocol (KDE)

