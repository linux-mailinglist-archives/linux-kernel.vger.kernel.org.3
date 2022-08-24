Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7E59F4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiHXICu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiHXICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:02:47 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240583F08
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:02:43 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-3378303138bso400200127b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=qyklwiZxz0QapErtA7L87Tl+mDOM3S9cMMO35uSmTjs=;
        b=iRsS6s9OulZPukWfxACyBqCtZW9fIv9eK0vGBDHJ8W+6jJAfHtXO4hieS2h2i11k3A
         HtdlSySUd22Z2NoT7LD/HOMMR3kno+lkl3T5K5yiwUzqVal6XK+FGZOg7UxnbcXxcXt5
         9eEGQRW+wQE7w1bx9JQGmCIHuIahcVy9x7FeQKHimketw0EudomrPL5j1gFVNq/2NmD3
         uHYIUe+GTsm0KXANpqGvN+aNIwNEXodUw58vK1dcU1UVTxNvja54Z0M4uGL1tlCu6bwr
         gWtYFmyxnqSPa2mQUx3ltuGeeWsJL5z5Aa4mFGCnnEu2L3zGoZVE9rxEEN9faLVNwD8U
         6AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=qyklwiZxz0QapErtA7L87Tl+mDOM3S9cMMO35uSmTjs=;
        b=cAXDO5wYDZHmdTAwTy6At5n+cmGL1+3KSTE/SszzzCVp9TKbffnQjlQnd09unnXGvR
         53+6MeEGkxTQaDbJMHG/Q6Yjo7obS/Juhnwr/W6BMmAEzTjYoWKXlK6Ixdqfm9E1HMAB
         O7HlYXziikXOAuBuCtnJGjdxSLuidoPosYVzIAZoHxkhknsDgAqL+Sy3tyDVxFqUg3ig
         VJygbtWGonnbgQ5pt/WGhZ0ZP1cB/LjLp9r/HEa0BW5U1bZ1sK0IzxLsEwexCdd11cih
         4p1ePQeJaf3obiQEQS1M/uSlY3o74k5ig1YSkhaC4eb23bkZeqX4b2RuDIQFpyfKaDls
         N7FQ==
X-Gm-Message-State: ACgBeo3afIWs3FZwy5i6KxTwKOmXoP3eqoTcIfH3nsQ3mtLoF8hfAo7d
        Ei+WFbgdeK5PPd+lAWntHX2erBO8FK0Y4TDDAEXOaVrvPJA=
X-Google-Smtp-Source: AA6agR7AreY127Lbp16+KrhEvk5O4wHIg1DGoEM+bGvUEq8Tmmctypfl4gPCgo0fD9uh9wGb1cOrSCTBLmUBCikLAZY=
X-Received: by 2002:a25:7d82:0:b0:695:dec9:8359 with SMTP id
 y124-20020a257d82000000b00695dec98359mr8328667ybc.22.1661328155208; Wed, 24
 Aug 2022 01:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFf+5zgEgigggQzPFsYTThVR+smzxGDrw54VtUWaro0MMV0mLw@mail.gmail.com>
In-Reply-To: <CAFf+5zgEgigggQzPFsYTThVR+smzxGDrw54VtUWaro0MMV0mLw@mail.gmail.com>
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Wed, 24 Aug 2022 13:32:25 +0530
Message-ID: <CAFf+5zi+joa=a1_D9oAue8=U+tKdFT=SSa2tN5u3o-myiunzjA@mail.gmail.com>
Subject: List of all linux commands.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following is the list of all linux commands with short descriptions in
case someone needs a pocket reference of linux commands.

-------------------------------------------------------------------------------

aa-enabled - test whether AppArmor is enabled

addpart - tell the kernel about the existence of a partition

alsatplg - ALSA Topology Compiler

apport-unpack - extract the fields of a problem report to separate files

apt-sortpkgs - Utility to sort package index files

aseqdump - show the events received at an ALSA sequencer port

avahi-browse - Browse for mDNS/DNS-SD services using the Avahi daemon

aa-exec - confine a program with the specified AppArmor profile

addr2line - convert addresses into file names and line numbers

alsaucm - ALSA Use Case Manager

appres - list X application resource database

apturl - graphical apt-protocol interpreting package installer

aseqnet - ALSA sequencer connectors over network

avahi-browse-domains - Browse for mDNS/DNS-SD services using the Avahi daemon

aa-features-abi - Extract, validate and manipulate AppArmor feature abis

add-shell - add shells to the list of valid login shells

amidi - read from and write to ALSA RawMIDI ports

appstreamcli - Handle AppStream metadata formats and query AppStream data

apturl-gtk - graphical apt-protocol interpreting package installer

aspell - interactive spell checker

avahi-daemon - The Avahi mDNS/DNS-SD daemon

aa-remove-unknown - remove unknown AppArmor profiles

adduser - add a user or group to the system

amixer - command-line mixer for ALSA soundcard driver

apropos - search the manual page names and descriptions

ar - create, modify, and extract from archives

aspell-autobuildhash - Autobuilding aspell hash files for some dicts

avahi-publish - Register an mDNS/DNS-SD service or host name or
address mapping using the Avahi daemon

aa-status - display various information about the current AppArmor policy.

agetty - alternative Linux getty

anacron - runs commands periodically

apt - command-line interface

arch - print machine hardware name (same as uname -m)

aspell-import - import old personal dictionaries into GNU Aspell

avahi-publish-address - Register an mDNS/DNS-SD service or host name
or address mapping using the Avahi daemon

aa-teardown - unload all AppArmor profiles

airscan-discover - Discover sane-airscan compatible scanners

ant - a Java based make tool.

apt-add-repository - Adds a repository into the /etc/apt/sources.list
or /etc/apt/sources.list.d or removes an existing one

arecord - command-line sound recorder and player for ALSA soundcard driver

avahi-publish-service - Register an mDNS/DNS-SD service or host name
or address mapping using the Avahi daemon

accessdb - dumps the content of a man-db database in a human readable format

alacarte - Edit freedesktop.org menus

apg - generates several random passwords

apt-cache - query the APT cache

arecordmidi - record Standard MIDI Files

atobm - bitmap editor and converter utilities for the X Window System

avahi-resolve - Resolve one or more mDNS/DNS host name(s) to IP
address(es) (and vice versa) using the Avahi daemon

aclocal - manual page for aclocal 1.16.5

apgbfm - APG Bloom filter management program

apt-cdrom - APT CD-ROM management utility

arm2hpdl - Add HP download header/trailer to an ARM ELF binary.

autoconf - Generate configuration scripts

avahi-resolve-address - Resolve one or more mDNS/DNS host name(s) to
IP address(es) (and vice versa) using the Avahi daemon

aclocal-1.16 - manual page for aclocal 1.16.5

aplay - command-line sound recorder and player for ALSA soundcard driver

apt-config - APT Configuration Query program

arpd - userspace arp daemon.

autoheader - Create a template header for configure

avahi-resolve-host-name - Resolve one or more mDNS/DNS host name(s) to
IP address(es) (and vice versa) using the Avahi daemon

aconnect - ALSA sequencer connection manager

aplaymidi - play Standard MIDI Files

aptd - package managing daemon proving a D-Bus interface

arptables-nft - ARP table administration (nft-based)

autom4te - Generate files and scripts thanks to M4

avahi-set-host-name - Change mDNS host name

acpid - Advanced Configuration and Power Interface event daemon

alsabat - command-line sound tester for ALSA sound card driver

apparmor_parser - loads AppArmor profiles into the kernel

aptdcon - command line client for aptdaemon

arptables-nft - ARP table administration (nft-based)

automake - manual page for automake 1.16.5

acpi_listen - ACPI event listener

apparmor_status - display various information about the current AppArmor policy.

apt-extracttemplates - Utility to extract debconf config and templates
from Debian packages

arptables-nft-restore - Restore ARP Tables (nft-based)

automake-1.16 - manual page for automake 1.16.5

awk - pattern scanning and text processing language

acyclic - make directed graph acyclic

alsactl - advanced controls for ALSA soundcard driver

applygnupgdefaults - Run gpgconf --apply-defaults for all users.

apt-ftparchive - Utility to generate index files

arptables-nft-save - dump arptables rules to stdout (nft-based)

autoreconf - Update generated configuration files

axfer - command-line sound recorder and player for sound devices and
nodes supported by Linux sound subsystem (Advanced Linux Sound
Architecture, also known as ALSA).

add-apt-repository - Adds a repository into the /etc/apt/sources.list
or /etc/apt/sources.list.d or removes an existing one

alsa-info - command-line utility to gather information about the ALSA subsystem

apport-bug - file a bug report using Apport, or update an existing report

apt-get - command-line interface

arptables-nft-restore - Restore ARP Tables (nft-based)

autoscan - Generate a preliminary configure.ac

addgnupghome - Create .gnupg home directories

alsaloop - command-line PCM loopback

apport-cli - Apport user interfaces for reporting problems

apt-key - Deprecated APT key management utility

arptables-nft-save - dump arptables rules to stdout (nft-based)

autoupdate - Update a configure.ac to a newer Autoconf

addgroup - add a user or group to the system

alsamixer - soundcard mixer for ALSA soundcard driver, with ncurses interface

apport-collect - file a bug report using Apport, or update an existing report

apt-mark - show, set and unset various settings for a package

x86_64-linux-gnu-as - the portable GNU assembler.
as - the portable GNU assembler.

avahi-autoipd - IPv4LL network address configuration daemon

b2sum - compute and check BLAKE2 message digest

basenc - Encode/decode data and print to standard output

bdftruncate - generate truncated BDF font from ISO 10646-1-encoded BDF font

bitmap - bitmap editor and converter utilities for the X Window System

bluemoon - Bluemoon configuration utility

bootctl - Control EFI firmware boot settings and manage boot loader

btmon - Bluetooth monitor

bzcat - decompresses files to stdout

bzgrep - search possibly bzip2 compressed files for a regular expression

badblocks - search a device for bad blocks

bash - GNU Bourne-Again SHell

blkdeactivate - utility to deactivate block devices

bluetoothctl - interactive bluetooth control tool

break - unimplemented system calls

bzcmp - compare bzip2 compressed files

bzip2 - a block-sorting file compressor, v1.0.8

baobab - A graphical disk usage analyzer for the GNOME desktop

bashbug - report a bug in bash

bind - bind a name to a socket

blkdiscard - discard sectors on a device

bluetoothd - Bluetooth daemon

bridge - show / manipulate bridge addresses and devices

broadwayd - Broadway display server

bunzip2 - a block-sorting file compressor, v1.0.8

bzdiff - compare bzip2 compressed files

bzip2recover - recovers data from damaged bzip2 files

base32 - base32 encode/decode data and print to standard output

bc - An arbitrary precision calculator language

biosdecode - BIOS information decoder

blkid - locate/print block device attributes

bluetooth-sendto - GTK application for transferring files over Bluetooth

brltty - refreshable braille display driver for Linux/Unix

busctl - Introspect the bus

bzegrep - search possibly bzip2 compressed files for a regular expression

bzless - file perusal filter for crt viewing of bzip2 compressed text

base64 - base64 encode/decode data and print to standard output

bcomps - biconnected components filter for graphs

bison - GNU Project parser generator (yacc replacement)

blkzone - run zone command on a device

bmtoa - bitmap editor and converter utilities for the X Window System

btattach - Attach serial devices to BlueZ stack

busybox - The Swiss Army Knife of Embedded Linux

bzexe - compress executable files in place

bzmore - file perusal filter for crt viewing of bzip2 compressed text

basename - parse pathname components
basename - strip directory and suffix from filenames

bdftopcf - convert X font from Bitmap Distribution Format to Portable
Compiled Format

bison.yacc - GNU Project parser generator

blockdev - call block device ioctls from the command line

boltctl - control the thunderbolt device manager

btmgmt - A command-line interface of BlueZ for management Usage:

bwrap - container setup utility

bzfgrep - search possibly bzip2 compressed files for a regular expression

c++ - GNU project C and C++ compiler

ccache - a fast C/C++ compiler cache

chcon - change file security context

ciptool - Bluetooth Common ISDN Access Profile (CIP)

cppw - copy with locking the given file to the password or group file

ctstat - unified linux network statistics

c89 - ANSI (1989) C compiler

ccomps - connected components filter for graphs

chcpu - configure CPUs

circo - filter for circular layout of graphs

cpufreq-selector - tool to set CPU frequency

cupsaccept - accept/reject jobs sent to a destination

c89-gcc - ANSI (1989) C compiler

check-language-support - returns the list of missing packages in order
to provide a complete language environment

ckbcomp - compile a XKB keyboard description to a keymap suitable for
loadkeys or kbdcontrol

compile_et - error table compiler

cracklib-check - Check passwords using libcrack2

cups-browsed - A daemon for browsing the Bonjour broadcasts of shared,
remote CUPS printers

c99 - ANSI (1999) C compiler

cd-create-profile - Color Manager Profile Creation Tool

cheese - tool to take pictures and videos from your webcam

cksum - checksum and count the bytes in a file

cracklib-format - cracklib dictionary utilities

cups-config - get cups api, compiler, directory, and link information
(deprecated).

c99-gcc - ANSI (1999) C compiler

cd-fix-profile - Color Manager Testing Tool

chfn - change real user name and information

clear - clear the terminal screen

cracklib-packer - cracklib dictionary utilities

cupsctl - configure cupsd.conf options

calibrate_ppa - pnm2ppa calibration tool

chgpasswd - update group passwords in batch mode

clear_console - clear the console

Compose - X client mappings for multi-key input sequences
compose - execute programs via entries in the mailcap file

cracklib-unpacker - cracklib dictionary utilities

cupsd - cups scheduler

cd-it8 - Color Manager Testing Tool

chgrp - change group ownership

cluster - find clusters in a graph and augment the graph with this information.

create-cracklib-dict - Check passwords using libcrack2

cupsdisable - stop/start printers and classes

canberra-gtk-play - play a sound event

cfdisk - display or manipulate a disk partition table

chmem - configure memory

cmp - compare two files byte by byte

c_rehash - Create symbolic links to files named by the hash values

cupsenable - stop/start printers and classes

cancel - cancel jobs

c++filt - demangle C++ and Java symbols

chmod - change file mode bits
chmod - change permissions of a file

codepage - extract a codepage from an MSDOS codepage file

corelist - a commandline frontend to Module::CoreList

cron - daemon to execute scheduled commands (Vixie Cron)

cupsfilter - convert a file to another format using cups filters (deprecated)

capsh - capability shell wrapper

cgdisk - Curses-based GUID partition table (GPT) manipulator

choom - display and adjust OOM-killer score.

col - filter reverse line feeds from input

cp - copy files and directories

crontab - tables for driving cron
crontab - maintain crontab files for individual users (Vixie Cron)

cupsreject - accept/reject jobs sent to a destination

captoinfo - convert a termcap description into a terminfo description

chacl - change the access control list of a file or directory

chown - change file owner and group
chown - change ownership of a file

colcrt - filter nroff output for CRT previewing

cpan - easily interact with CPAN from the command line

cscope - interactively examine a C program

cupstestppd - test conformance of ppd files (deprecated)

chage - change user password expiry information

chpasswd - update passwords in batch mode

colormgr - Color Manager Testing Tool

cpan5.34-x86_64-linux-gnu - easily interact with CPAN from the command line

cscope-indexer - Script to index files for cscope

cut - remove sections from each line of files

cat - concatenate files and print on the standard output

chardet - universal character encoding detector

chroot - change root directory
chroot - run command or interactive shell with special root directory

colrm - remove columns from a file

cpgr - copy with locking the given file to the password or group file

csplit - split a file into sections determined by context lines

cvt - calculate VESA CVT mode lines

catman - create or update the pre-formatted manual pages

chardetect - universal character encoding detector

chrt - manipulate the real-time attributes of a process

column - columnate lists

cpio - copy files to and from archives

ctags - Generate tag files for source code

cvtsudoers - convert between sudoers file formats

chat - Automated conversational script with a modem

chsh - change login shell

comm - compare two sorted files line by line

cpp - The C Preprocessor

ctags-universal - Generate tag files for source code

cc - GNU project C and C++ compiler

chattr - change file attributes on a Linux file system

chvt - change foreground virtual terminal

cpp-11 - The C Preprocessor

ctrlaltdel - set the function of the Ctrl-Alt-Del combination

dash - command interpreter (shell)

deb-systemd-invoke - wrapper around systemctl, respecting policy-rc.d

dhclient-script - DHCP client network configuration script

dpkg-maintscript-helper - works around known dpkg limitations in
maintainer scripts

date - print or set the system date and time

debugfs - ext2/ext3/ext4 file system debugger

dh_doxygen - helps with packaging doxygen-generated documentation

domainname - show or set the system's NIS/YP domain name

dpkg-mergechangelogs - 3-way merge of debian/changelog files

dbus-cleanup-sockets - clean up leftover sockets in a directory

dpkg-name - rename Debian packages to full package names

dbus-daemon - Message bus daemon

deja-dup - a desktop backup tool

dh_installxmlcatalogs - install and register XML catalog files

do-release-upgrade - upgrade operating system to latest release

dpkg-parsechangelog - parse Debian changelog files

dbus-monitor - debug probe to print message bus messages

delaunay - constructs the constrained Delaunay triangulation of the input

dh_perl_openssl - add dependencies required for OpenSSL modules

dosfsck - check and repair MS-DOS FAT filesystems

dpkg-preconfigure - let packages ask questions prior to their installation

dbus-run-session - start a process as a new D-Bus session

delgroup - remove a user or group from the system

diff - compare files line by line

dosfslabel - set or get MS-DOS filesystem label or volume ID

dpkg-query - a tool to query the dpkg database

dbus-send - Send a message to a message bus

delpart - tell the kernel to forget about a partition

diff3 - compare three files line by line

dot - filter for drawing directed graphs

dpkg-realpath - print the resolved pathname with DPKG_ROOT support

dbus-update-activation-environment - update environment used for D-Bus
session services

deluser - remove a user or group from the system

diffimg - Calculates intersection between two images

dot2gxl - GXL-GV converters

dpkg-reconfigure - reconfigure an already installed package

dbus-uuidgen - Utility to generate UUIDs

delv - DNS lookup and validation utility

dig - DNS lookup utility

dpkg-scanpackages - create Packages index files

dbxtool - modify the dbx revokation list

depmod - Generate modules.dep and map files.

dijkstra - single-source distance filter for Graphviz

dotty - A Customizable Graph Editor

dpkg-scansources - create Sources index files

dc - an arbitrary precision calculator

dir - list directory contents

doxygen - documentation system for various programming languages

dpkg-shlibdeps - generate shared library substvar dependencies

dcb - show / manipulate DCB (Data Center Bridging) settings

derb - disassemble a resource bundle

dircolors - color setup for ls

doxyindexer - creates a search index from raw search data

dpkg-source - Debian source package (.dsc) manipulation tool

dconf - A configuration system
dconf - Simple tool for manipulating a dconf database

dirmngr - CRL and OCSP daemon

doxysearch.cgi - search engine used for searching in doxygen documentation.

dpkg-split - Debian package archive split/join tool

dd - convert and copy a file

desktop-file-edit - Installation and edition of desktop files

dirmngr-client - Tool to access the Dirmngr services

Dpkg - module with core variables
dpkg - package manager for Debian

dpkg-statoverride - override ownership and mode of files

ddstdecode - Decode a Ricoh DDST stream into human readable form.

desktop-file-install - Installation and edition of desktop files

dirname - parse pathname components
dirname - strip last component from file name

dpkg-architecture - set and determine the architecture for package building

dpkg-trigger - a package trigger utility

deallocvt - deallocate unused virtual consoles

desktop-file-validate - Validate desktop entry files

dpkg-buildflags - returns build flags to use during package build

dpkg-vendor - queries information about distribution vendors

debconf - run a debconf-using program

desktoptojson - Converts a .desktop file to a .json file.

dirsplit - splits directory into multiple with equal size

dpkg-buildpackage - build binary or source packages from sources

driverless - PPD generator utility for driverless printing

debconf-apt-progress - install packages using debconf to display a progress bar

devdump - Utility programs for dumping and verifying iso9660 images.

dpkg-checkbuilddeps - check build dependencies and conflicts

debconf-communicate - communicate with debconf

devlink - Devlink tool

distro-info - provides information about the distributions' releases

dpkg-deb - Debian package archive (.deb) manipulation tool

du - estimate file space usage

debconf-copydb - copy a debconf database

df - report file system disk space usage

dmesg - print or control the kernel ring buffer

dpkg-distaddfile - add entries to debian/files

dumpe2fs - dump ext2/ext3/ext4 file system information

debconf-escape - helper when working with debconf's escape capability

dfu-tool - write firmware to DFU devices

dmidecode - DMI table decoder

dpkg-divert - override a package's version of a file

dumpkeys - dump keyboard translation tables

debconf-set-selections - insert new values into the debconf database

dh_autotools-dev_restoreconfig - restore config.sub and config.guess

dmsetup - low level logical volume management

dpkg-genbuildinfo - generate Debian .buildinfo files

duplicity - Encrypted incremental backup to local or remote storage.

debconf-show - query the debconf database

dh_autotools-dev_updateconfig - update config.sub and config.guess

dmstats - device-mapper statistics management

dpkg-genchanges - generate Debian .changes files

dvipdf - Convert TeX DVI file to PDF using ghostscript and dvips

debian-distro-info - provides information about Debian's distributions

dh_bash-completion - install bash completions for package

dnsdomainname - show the system's DNS domain name

dpkg-gencontrol - generate Debian control files

dwp - The DWARF packaging utility

deb-systemd-helper - subset of systemctl for machines not running systemd

dhclient - Dynamic Host Configuration Protocol Client

dnsmasq - A lightweight DHCP and caching DNS server.

dpkg-gensymbols - generate symbols files (shared library dependency information)

e2freefrag - report free space fragmentation information

e2undo - Replay an undo log for an ext2/ext3/ext4 file system

editres - a dynamic resource editor for X Toolkit applications

envsubst - substitutes environment variables in shell format strings

etags - Generate tag files for source code

ex - Vi IMproved, a programmer's text editor

e2fsck - check a Linux ext2/ext3/ext4 file system

e4crypt - ext4 file system encryption utility

eog - a GNOME image viewer

ethtool - query or control network driver and hardware settings

exec - execute a file

e2image - Save critical ext2/ext3/ext4 file system metadata to a file

e4defrag - online defragmenter for ext4 file system

echo - display a line of text

enc2xs - Perl Encode Module Generator

eps2eps - Ghostscript PostScript "distiller"

eutp - EuroBraille file transferring

exit - cause normal process termination
exit - terminate the calling process

e2label - Change the label on an ext2/ext3/ext4 file system

ebtables-nft - Ethernet bridge frame table administration (nft-based)

ed - line-oriented text editor

egrep - print lines that match patterns

encguess - guess character encodings of files

eqn - format equations for troff or MathML

expand - convert tabs to spaces

e2mmpstatus - Check MMP status of an ext4 file system

ebtables-nft - Ethernet bridge frame table administration (nft-based)

edgepaint - edge coloring to disambiguate crossing edges

eject - eject removable media

enchant-2 - a spellchecker

evince - GNOME document viewer

expiry - check and enforce password expiration policy

e2scrub - check the contents of a mounted ext[234] file system

ebtables-nft-restore - iptables using nftables kernel api

edit - execute programs via entries in the mailcap file

elfedit - update ELF header and program property of ELF files

enchant-lsmod-2 - list provider and dictionary information

evince-previewer - show a printing preview of PostScript and PDF documents

e2scrub_all - check all mounted ext[234] file systems for errors.

ebtables-nft-save - iptables using nftables kernel api

editor - Nano's ANOther editor, inspired by Pico

env - run a program in a modified environment

esc-m - ease viewing output of driver data

evince-thumbnailer - create png thumbnails from PostScript and PDF documents

expr - evaluate expressions

factor - factor numbers

fdp - filter for drawing undirected graphs

findfs - find a filesystem by label or UUID

foo2ddst - Convert Ghostscript pbmraw into a DDST printer stream

foo2oak-wrapper - Convert Postscript into an OAKT printer stream

foomatic-rip - Universal print filter/RIP wrapper

fsck.ext4 - check a Linux ext2/ext3/ext4 file system

fuser - identify processes using files or sockets

faillock - Tool for displaying and modifying the authentication
failure record files

fc-cache - build font information cache files

findmnt - find a filesystem

foo2ddst-wrapper - Convert Postscript into a DDST printer stream

foo2qpdl - Convert Ghostscript pbmraw or bitcmyk format into a QPDL
printer stream

fsck.fat - check and repair MS-DOS FAT filesystems

fusermount - mount and unmount FUSE filesystems

faillog - login failure logging file
faillog - display faillog records or set login failure limits

fc-cat - read font information cache files

fgconsole - print the number of the active VT.

foo2hbpl2 - Convert Ghostscript pbmraw or bitcmyk format into a ZJS
printer stream

foo2qpdl-wrapper - Convert Postscript into a QPDL printer stream

fprintd-delete - Fingerprint management daemon, and test applications

fsck.minix - check consistency of Minix filesystem

fusermount3 - mount and unmount FUSE filesystems

faked-sysv - daemon that remembers fake ownership/permissions of files
manipulated by fakeroot processes.

fc-conflist - Show the ruleset files information on the system

fgrep - print lines that match patterns

foo2hbpl2-wrapper - Convert Postscript into a ZJS printer stream

foo2slx - Convert Ghostscript pbmraw or bitcmyk format into a SLX printer stream

fprintd-enroll - Fingerprint management daemon, and test applications

fsck.msdos - check and repair MS-DOS FAT filesystems

faked-tcp - daemon that remembers fake ownership/permissions of files
manipulated by fakeroot processes.

fc-list - list available fonts

fixparts - MBR partition table repair utility

foo2hiperc - Convert Ghostscript pbmraw or bitcmyk format into a
HIPERC printer stream

foo2slx-wrapper - Convert Postscript into a SLX printer stream

fprintd-list - Fingerprint management daemon, and test applications

fsck.vfat - check and repair MS-DOS FAT filesystems

fwupdagent - firmware updating agent

fakeroot - run a command in an environment faking root privileges for
file manipulation

fc-match - match available fonts

FILE - overview of system data types
file - determine file type

flex - the fast lexical analyser generator

foo2hiperc-wrapper - Convert Postscript into a HIPERC printer stream

foo2xqx - Convert Ghostscript pbmraw into a XQX printer stream

fprintd-verify - Fingerprint management daemon, and test applications

fsfreeze - suspend access to a filesystem (Ext3/4, ReiserFS, JFS, XFS)

fwupdate - ddebugging utility for UEFI firmware updates

fakeroot-sysv - run a command in an environment faking root privileges
for file manipulation

fc-pattern - parse and show pattern

file2brl - Translate an xml or a text file into an embosser-ready braille file

flex++ - the fast lexical analyser generator

foo2hp - Convert Ghostscript pbmraw or bitcmyk format into a ZJS printer stream

foo2xqx-wrapper - Convert Postscript into a XQX printer stream

free - allocate and free dynamic memory
free - Display amount of free and used memory in the system

fstab-decode - run a command with fstab-encoded arguments

fwupdmgr - firmware update manager client utility

fakeroot-tcp - run a command in an environment faking root privileges
for file manipulation

fc-query - query font files

filefrag - report on file fragmentation

flock - manage locks from shell scripts
flock - apply or remove an advisory lock on an open file

foo2hp2600-wrapper - Convert Postscript into a ZJS printer stream

foo2zjs - Convert Ghostscript pbmraw or bitcmyk format into a ZJS printer stream

fsck - check and repair a Linux filesystem

fstrim - discard unused blocks on a mounted filesystem

fwupdtool - standalone firmware update utility

fallocate - preallocate or deallocate space to a file
fallocate - manipulate file space

fc-scan - scan font files or directories

file-roller - archive manager for GNOME

fmt - simple optimal text formatter

foo2lava - Convert Ghostscript pbmraw or bitcmyk format into a
LAVAFLOW or a OPL printer stream

fsck.cramfs - fsck compressed ROM file system

ftp - Internet file transfer program

false - do nothing, unsuccessfully

fc-validate - validate font files

fincore - count pages of file contents in core

fold - wrap each input line to fit in specified width

foo2lava-wrapper - Convert Postscript into a LAVAFLOW or OPL printer stream

foo2zjs-pstops - Add PS code for foo2*-wrapper

fsck.ext2 - check a Linux ext2/ext3/ext4 file system

fatlabel - set or get MS-DOS filesystem label or volume ID

fdisk - manipulate disk partition table

find - search for files in a directory hierarchy

fonttosfnt - Wrap a bitmap font in a sfnt (TrueType) wrapper

foo2oak - Convert Ghostscript pbmraw, pgmraw or bitcmyk format into an
OAKT printer stream

foo2zjs-wrapper - Convert Postscript into a ZJS printer stream

fsck.ext3 - check a Linux ext2/ext3/ext4 file system

funzip - filter for extracting from a ZIP archive in a pipe

g++ - GNU project C and C++ compiler

gedit - text editor for the GNOME Desktop

gnome-terminal.wrapper - A terminal emulator for GNOME

grub-customizer - a graphical grub2/burg editor

g++-11 - GNU project C and C++ compiler

genbrk - Compiles ICU break iteration rules source files into binary data files

glib-compile-resources - GLib resource compiler

gnome-text-editor - text editor for the GNOME Desktop

grub-editenv - edit GRUB environment block

gst-stats-1.0 - print info gathered from a GStreamer log file

gamemoded - daemon that optimises system performance on demand

gencat - Generate message catalog

glib-compile-schemas - GSettings schema compiler

grub-file - check file type

gamemoderun - invoke gamemode into any program

genccode - generate C or platform specific assembly code from an ICU data file.

glib-genmarshal - C code marshaller generation utility for GLib closures

grub-fstest - debug tool for GRUB filesystem drivers

gst-typefind-1.0 - print Media type of file

gamemode-simulate-game - simulate a game using gamemode

gencfu - Generates Unicode Confusable data files

glib-gettextize - gettext internationalization utility

gobject-query - display a tree of types

grub-glue-efi - generate a fat binary for EFI

gtbl - format tables for troff

gamma4scanimage - create a gamma table for scanimage

gencmn - generate an ICU memory-mappable data file

glib-mkenums - C language enum description generation utility

gold - The GNU ELF linker

grub-install - install GRUB to a device

gtester - test running utility

gapplication - D-Bus application launcher

gencnval - compile the converters aliases file

gmake - GNU make utility to maintain groups of programs

gpasswd - administer /etc/group and /etc/gshadow

grub-kbdcomp - generate a GRUB keyboard layout file

gtester-report - test report formatting utility

gatttool - tool for Bluetooth Low Energy device

gendict - Compiles word list into ICU string trie dictionary

gml2gv - GML-DOT converters

gperf - generate a perfect hash function from a key set

grub-macbless - bless a mac file/directory

gtf - calculate VESA GTF mode lines

gc - count graph components

genisoimage - create ISO9660/Joliet/HFS filesystem with optional Rock
Ridge attributes

gnome-calculator - a desktop calculator

gpg - OpenPGP encryption and signing tool

grub-menulst2cfg - transform legacy menu.lst into grub.cfg

gtk4-builder-tool - GtkBuilder File Utility

gcalccmd - a console calculator

genl - generic netlink utility frontend

gpg-agent - Secret key management for GnuPG

grub-mkconfig - generate a GRUB configuration file

gtk4-encode-symbolic-svg - Symbolic icon conversion utility

gcc - GNU project C and C++ compiler

gpgcompose - Generate a stream of OpenPGP packets

grub-mkdevicemap - make a device map file automatically

gtk4-launch - Launch an application

gcc-11 - GNU project C and C++ compiler

genrb - compile a resource bundle

gnome-control-center - Configure GNOME settings

gpgconf - Modify .gnupg home directories

grub-mkfont - make GRUB font files

gtk4-query-settings - Print name and value of GTK settings

gcc-ar - a wrapper around ar adding the --plugin option

gensprep - compile StringPrep data from files filtered by filterRFC3454.pl

gnome-disk-image-mounter - Attach and mount disk images

gpg-connect-agent - Communicate with a running agent

grub-mkimage - make a bootable image of GRUB

gtk4-update-icon-cache - Icon theme caching utility

gcc-ar-11 - a wrapper around ar adding the --plugin option

geqn - format equations for troff or MathML

gnome-disks - the GNOME Disks application

gpgparsemail - Parse a mail message into an annotated format

grub-mklayout - generate a GRUB keyboard layout file

gtk-builder-tool - GtkBuilder file utility

gcc-nm - a wrapper around nm adding the --plugin option

getcap - examine file capabilities

gnome-extensions - Command line tool for managing GNOME extensions

gpgsm - CMS encryption and signing tool

grub-mknetdir - prepare a GRUB netboot directory.

gtk-encode-symbolic-svg - Symbolic icon conversion utility

gcc-nm-11 - a wrapper around nm adding the --plugin option

getconf - Query system configuration variables

gpgsplit - Split an OpenPGP message into packets

grub-mkpasswd-pbkdf2 - generate hashed password for GRUB

gtk-launch - Launch an application

gcc-ranlib - a wrapper around ranlib adding the --plugin option

geteltorito - an El Torito boot image extractor

gpgtar - Encrypt or sign files into an archive

grub-mkrelpath - make a system path relative to its root

gtk-query-settings - Utility to print name and value of all
GtkSettings properties

gcc-ranlib-11 - a wrapper around ranlib adding the --plugin option

getent - get entries from Name Service Switch libraries

gnome-help - browse system documentation

gpgv - Verify OpenPGP signatures

grub-mkrescue - make a GRUB rescue image

gtk-update-icon-cache - Icon theme caching utility

gcore - Generate core files for running processes

getfacl - get file access control lists

gnome-keyring - The gnome-keyring commandline tool

gpg-wks-server - Server providing the Web Key Service

grub-mkstandalone - make a memdisk-based GRUB image

gts2dxf - converts a GTS file to DXF format.

gcov - coverage testing tool

getkeycodes - print kernel scancode-to-keycode mapping table

gnome-keyring-3 - The gnome-keyring commandline tool

gpg-zip - encrypt or sign files into an archive

grub-mount - export GRUB filesystem with FUSE

gts2oogl - converts a GTS file to OOGL file format (Geomview).

gcov-11 - coverage testing tool

getopt - Parse command-line options
getopt - parse command options (enhanced)

gnome-keyring-daemon - The gnome-keyring daemon

gpic - compile pictures for troff or TeX

gts2stl - converts a GTS file to STL format

gcov-dump - offline gcda and gcno profile dump tool

gnome-language-selector - graphical language selection utility

gprof - display call graph profile data

grub-probe - probe device information for GRUB

gcov-dump-11 - offline gcda and gcno profile dump tool

getpcaps - display process capabilities

gnome-logs - log viewer for the systemd journal

grub-reboot - set the default boot entry for GRUB, for the next boot only

gtscheck - checks that a surface defines a closed, orientable non
self-intersecting manifold.

gcov-tool - offline gcda profile processing tool

gettext - translate message
gettext - translate message

gnome-mahjongg - A matching game played with Mahjongg tiles

graphml2gv - GRAPHML-DOT converter

grub-render-label - generate a .disk_label for Apple Macs.

gtscompare - compare two GTS files.

gcov-tool-11 - offline gcda profile processing tool

gettextize - install or upgrade gettext infrastructure

grub-script-check - check grub.cfg for syntax errors

gts-config - defines values for programs using gts.

gnome-mines - The popular logic puzzle minesweeper

grep - print lines that match patterns

grub-set-default - set the saved default boot entry for GRUB

gtstemplate - generates of a template used to create new object classes.

gdb - The GNU Debugger

getty - alternative Linux getty

gnome-panel - Display the GNOME panel

gresource - GResource tool

grub-syslinux2cfg - transform syslinux config into grub.cfg

gunzip - compress or expand files

gdb-add-index - Add index files to speed up GDB

gnome-power-statistics - gnome power statistics gui

groff - front-end for the groff document formatting system

gs - Ghostscript (PostScript and PDF language interpreter and previewer)

gv2gml - GML-DOT converters

ghostscript - Ghostscript (PostScript and PDF language interpreter and
previewer)

gnome-session - Start the GNOME desktop environment

grog - guess options for a following groff command

gsbj - Format and print text for BubbleJet printer using ghostscript

gv2gxl - GXL-GV converters

gdbus - Tool for working with D-Bus objects

ginstall-info - update info/dir entries

grops - PostScript driver for groff

gsdj - Format and print text for DeskJet printer using ghostscript

gvcolor - flow colors through a ranked digraph

gdbus-codegen - D-Bus code and documentation generator

gio - GIO commandline tool

gnome-session-inhibit - inhibit gnome-session functionality

grotty - groff driver for typewriter-like devices

gsdj500 - Format and print text for DeskJet 500 BubbleJet using ghostscript

gvgen - generate graphs

gio-querymodules - GIO module cache creation

gnome-session-properties - Configure applications to start on login

groupadd - create a new group

gsettings - GSettings configuration tool

gvmap - find clusters and create a geographical map highlighting clusters.

gdisk - Interactive GUID partition table (GPT) manipulator

gipddecode - Decode a GIPD stream into human readable form.

gnome-session-quit - End the current GNOME session

groupdel - delete a group

gslj - Format and print text for LaserJet printer using ghostscript

gvmap.sh - pipeline for running gvmap

gdk-pixbuf-csource - C code generation utility for GdkPixbuf images

Git - Perl interface to the Git version control system
git - the stupid content tracker

gnome-shell - Graphical shell for the GNOME desktop

groupmems - administer members of a user's primary group

gslp - Format and print text using ghostscript

gvpack - merge and pack disjoint graphs

gdk-pixbuf-pixdata - GDK Pixbuf library

git-receive-pack - Receive what is pushed into the repository

groupmod - modify a group definition on the system

gsnd - Run ghostscript (PostScript and PDF engine) without display

gvpr - graph pattern scanning and processing language

git-shell - Restricted login shell for Git-only SSH access

groups - print the groups a user is in

gst-device-monitor-1.0 - Simple command line testing tool for
GStreamer device monitors

gxl2dot - GXL-GV converters

gdm3 - take a picture of the screen

git-upload-archive - Send archive back to git-archive

gnome-sudoku - puzzle game for the popular Japanese sudoku logic puzzle

grpck - verify integrity of group files

gst-discoverer-1.0 - Display file metadata and stream information

gxl2gv - GXL-GV converters

gdmflexiserver - take a picture of the screen

git-upload-pack - Send objects packed back to git-fetch-pack

gnome-system-monitor - view and control processes

grpconv - convert to and from shadow passwords and groups

gst-inspect-1.0 - print info about a GStreamer plugin or element

gzexe - compress executable files in place

gdm-screenshot - take a picture of the screen
gdm3 - take a picture of the screen

gnome-terminal - A terminal emulator for GNOME

grpunconv - convert to and from shadow passwords and groups

gst-launch-1.0 - build and run a GStreamer pipeline

gzip - compress or expand files

grub-bios-setup - set up a device to boot using GRUB

gst-play-1.0 - Simple command line playback testing tool

h2ph - convert .h C header files to .ph Perl header files

hciattach - attach serial devices via UART HCI to BlueZ stack

host - DNS lookup utility

hp-clean - Printer Printhead Cleaning Utility

hp-levels - Supply Levels Utility

hp-probe - Printer Discovery Utility

hwclock - settings that affect the behaviour of the hwclock init script
hwclock - time clocks utility

h2xs - convert .h C header files to Perl extensions

hciconfig - Configure Bluetooth devices

helpztags - generate the help tags file for directory

hostid - print the numeric identifier for the current host

hp-colorcal - Printer Cartridge Color Calibration Utility

hp-logcapture - HPLIP logs capture Utility

hp-query - Model Query Utility

halt - Halt, power-off or reboot the machine

hcitool - Configure Bluetooth connections

hex2hcd - Broadcom Bluetooth firmware converter

hostname - hostname resolution description
hostname - Local hostname configuration file
hostname - show or set the system's host name

hp-config_usb_printer - HP device config using USB

hp-makeuri - Device URI Creation Utility

hp-scan - Scan Utility

hwinfo - probe for hardware

hardlink - link multiple copies of a file

hd - display file contents in hexadecimal, decimal, octal, or ascii
hd - MFM/IDE hard disk devices

hexdump - display file contents in hexadecimal, decimal, octal, or ascii

hostnamectl - Control the system hostname

hp-doctor - Self Diagnse Utility and Healing Utility

hp-pkservice - Policy Kit Service

hp-setup - Printer/Fax Setup Utility

hash - hash database access method

hdparm - get/set SATA/IDE device parameters

hipercdecode - Decode a HIPERC stream into human readable form.

hp-align - Printer Cartridge Alignment Utility

hp-firmware - Firmware Download Utility

hp-plugin - Plugin Download and Install Utility

hp-testpage - Testpage Print Utility

hbpldecode - Decode a HBPL stream into human readable form.

head - output the first part of files
HEAD - Simple command line user agent

history - GNU History Library

hp-check - Dependency/Version Check Utility

hp-info - Device Information Utility

hp-timedate - Time/Date Utility

ifnames - Extract CPP conditionals from a set of files

install-sgmlcatalog - maintain transitional SGML catalog

ip6tables-save - dump iptables rules

iptables-nft - iptables using nftables kernel api

isovfy - Utility programs for dumping and verifying iso9660 images.

instmodsh - A shell to examine installed modules

ip6tables-translate - translation tool to migrate from ip6tables to nftables

iptables-nft-restore - iptables using nftables kernel api

ispell-autobuildhash - Autobuilding the ispell hash file for some dicts

ibus - dconf database file for IBus
ibus - command line utility for ibus

im-config - set up input method framework configuration

intel-virtual-output - Utility for connecting the Integrated Intel GPU
to discrete outputs

ipcmk - make various IPC resources

iptables-nft-save - iptables using nftables kernel api

ispell-wrapper - smart wrapper for ispell

ibus-daemon - daemon program for ibus

im-launch - launch input method and execute session program

invoke-rc.d - executes System-V style init script actions

ipcrm - remove certain IPC resources

iptables-restore - Restore IP Tables

iucode-tool - Tool to manipulate Intel IA-32/X86-64 microcode bundles

ibus-setup - configuration program for ibus

ionice - set or get process I/O scheduling class and priority

ipcs - show information on IPC facilities

iptables-restore-translate - translation tool to migrate from iptables
to nftables

iucode_tool - Tool to manipulate Intel IA-32/X86-64 microcode bundles

ibus-table-createdb - create ibus-table database from table source

info - readable online documentation
info - read Info documents
info - OpenSSL application commands

ip - Linux IPv4 protocol implementation
ip - show / manipulate routing, network devices, interfaces and tunnels

iptables-save - dump iptables rules

iwconfig - configure a wireless network interface

iceauth - ICE authority file utility

infobrowser - read Info documents

ip6tables - administration tool for IPv4/IPv6 packet filtering and NAT

iptables-translate - translation tool to migrate from iptables to nftables

iwevent - Display Wireless Events generated by drivers and setting changes

ico - animate an icosahedron or other polyhedron

infocmp - compare or print out terminfo descriptions

ip6tables-apply - a safer way to update iptables remotely

ippeveprinter - an ipp everywhere printer application for cups

iptables-xml - Convert iptables-save format to XML

iwgetid - Report ESSID, NWID or AP/Cell Address of wireless network

iconv - perform character set conversion
iconv - convert text from one character encoding to another

infotocap - convert a terminfo description into a termcap description

ip6tables-legacy - iptables using old getsockopt/setsockopt-based kernel api

ippfind - find internet printing protocol printers

irqbalance - distribute hardware interrupts across processors on a
multiprocessor system

iwlist - Get more detailed wireless information from a wireless interface

iconvconfig - create iconv module configuration cache

init - systemd system and service manager

ip6tables-legacy-restore - iptables using old
getsockopt/setsockopt-based kernel api

ipptool - perform internet printing protocol requests

irqbalance-ui - user interface for irqbalance

iwpriv - configure optionals (private) parameters of a wireless
network interface

icuexportdata - Writes text files with Unicode properties data from ICU.

inputattach - attach a serial line to an input-layer device

ip6tables-legacy-save - iptables using old getsockopt/setsockopt-based
kernel api

ipp-usb - Daemon for IPP over USB printer support

ischroot - detect if running in a chroot

iwspy - Get wireless statistics from specific nodes

insmod - Simple program to insert a module into the Linux Kernel

ip6tables-nft - iptables using nftables kernel api

iptables - administration tool for IPv4/IPv6 packet filtering and NAT

icupkg - extract or modify an ICU .dat archive

install - copy files and set attributes

ip6tables-nft-restore - iptables using nftables kernel api

iptables-apply - a safer way to update iptables remotely

id - print real and effective user and group IDs

install-info - update info/dir entries

ip6tables-nft-save - iptables using nftables kernel api

iptables-legacy - iptables using old getsockopt/setsockopt-based kernel api

isodump - Utility programs for dumping and verifying iso9660 images.

iecset - Set or dump IEC958 status bits

installkernel - install a new kernel image

ip6tables-restore - Restore IPv6 Tables

iptables-legacy-restore - iptables using old
getsockopt/setsockopt-based kernel api

isoinfo - Utility programs for dumping and verifying iso9660 images.

ip6tables-restore-translate - translation tool to migrate from
iptables to nftables

iptables-legacy-save - iptables using old getsockopt/setsockopt-based kernel api

isosize - output the length of an iso9660 filesystem

java - Launches a Java application.

javap - Disassembles one or more class files.

jdb - Finds and fixes bugs in Java platform programs.

jpgicc - little cms ICC profile applier for JPEG.

jstat - Monitors Java Virtual Machine (JVM) statistics. This command
is experimental and unsupported.

jar - Manipulates Java Archive (JAR) files.

javac - Reads Java class and interface definitions and compiles them
into bytecode and class files.

jcmd - Sends diagnostic command requests to a running Java Virtual
Machine (JVM).

jinfo - Generates configuration information. This command is
experimental and unsupported.

jmap - Prints shared object memory maps or heap memory details for a
process, core file, or remote debug server. This command is
experimental and unsupported.

join - join lines of two files on a common field

jps - Lists the instrumented Java Virtual Machines (JVMs) on the
target system. This command is experimental and unsupported.

json_pp - JSON::PP command utility

jstatd - Monitors Java Virtual Machines (JVMs) and enables remote
monitoring tools to attach to JVMs. This command is experimental and
unsupported.

jarsigner - Signs and verifies Java Archive (JAR) files.

javadoc - Generates HTML pages of API documentation from Java source files.

jconsole - Starts a graphical console that lets you monitor and manage
Java applications.

jdeps - Java class dependency analyzer.

jjs - Invokes the Nashorn engine.

journalctl - Query the systemd journal

jrunscript - Runs a command-line script shell that supports
interactive and batch modes. This command is experimental and
unsupported.

jstack - Prints Java thread stack traces for a Java process, core
file, or remote debug server. This command is experimental and
unsupported.

kbdinfo - obtain information about the status of a console

kbuildsycoca5 - Rebuilds the KService desktop file system configuration cache

kmod - Program to manage Linux Kernel modules

krb5-config.mit - tool for linking against MIT Kerberos libraries

kbd_mode - report or set the keyboard mode

kbxutil - List, export, import Keybox data

keditbookmarks - Bookmark Organizer and Editor

keyring - Python-Keyring command-line utility

kill - send a signal to a process
kill - send signal to a process

kmodsign - Kernel module signing tool

kwallet-query - KDE Wallet command-line manipulation tool

kbdrate - reset the keyboard repeat rate and delay time

kcookiejar5 - Command line interface to the KDE HTTP cookie daemon

kernel-install - Add and remove kernel and initramfs images to and from /boot

keytool - Manages a keystore (database) of cryptographic keys, X.509
certificate chains, and trusted certificates.

killall - kill processes by name

kbookmarkmerger - A program for merging a given set of bookmarks into
the user's list of bookmarks.

kded5 - triggers Sycoca database updates when needed.

kerneloops - program to collect and submit kernel oopses to oops.kernel.org

killall5 - send a signal to all processes.

krb5-config - tool for linking against MIT Kerberos libraries

lessecho - expand metacharacters

lofromtemplate - LibreOffice office suite

lpq - show printer queue status

lspcmcia - display extended PCMCIA debugging information

l2ping - Send L2CAP echo request and receive answer

lessfile - "input preprocessor" for less.

linux-check-removal - check whether removal of a kernel is safe

logger - enter messages into the system log

lpr - print files

lspgpot - extracts the ownertrust values from PGP keyrings and list
them in GnuPG ownertrust format.

l2test - L2CAP testing tool

lesskey - specify key bindings for less

linux-update-symlinks - maintain symlinks to default kernel and initramfs

login - write utmp and wtmp entries
login - begin session on the system

lprm - cancel print jobs

lsusb - list USB devices

lesspipe - "input preprocessor" for less.

linux-version - operate on Linux kernel version strings

loginctl - Control the systemd login manager

lp_solve - a mixed integer linear programming (MILP) solver

lto-dump-11 - Tool for dumping LTO object files

laptop-detect - attempt to detect a laptop

listres - list resources in widgets

logname - print user's login name

lpstat - print cups status information

luit - Locale and ISO 2022 support for Unicode terminals

last - show a listing of last logged in users

lex - the fast lexical analyser generator

logout - write utmp and wtmp entries

lastb - show a listing of last logged in users

lexgrog - parse header information in man pages

logrotate - rotates, compresses, and mails system logs

ls - list directory contents

lwp-download - Fetch large files from the web

lastlog - reports the most recent login of all users or of a given user

ln - make links between files

logsave - save the output of a command in a logfile

lsattr - list file attributes on a Linux second extended file system

lwp-dump - See what headers and content is returned for a URL

lavadecode - Decode a LAVAFLOW stream into human readable form.

libnetcfg - configure libnet

lneato - A Customizable Graph Editor

loimpress - LibreOffice office suite

lsblk - list block devices

lwp-mirror - Simple mirror utility

lcf - Determine which of the historical versions of a config is installed

libpng16-config - get information about installed libpng library

lnstat - unified linux network statistics

lomath - LibreOffice office suite

lsb_release - print distribution-specific information

lwp-request - Simple command line user agent

libpng-config - get information about installed libpng library

loadkeys - load keyboard translation tables

look - display lines beginning with a given string

lscpu - display information about the CPU architecture

lzcat - Compress or decompress .xz and .lzma files

ld - The GNU linker

libreoffice - LibreOffice office suite

loadunimap - load the kernel unicode-to-font mapping table

losetup - set up and control loop devices

lshw - list hardware

lzcmp - compare compressed files

ldattach - attach a line discipline to a serial line

libwacom-list-devices - utility to list supported tablet devices

loweb - LibreOffice office suite

lsinitramfs - list content of an initramfs image

lzdiff - compare compressed files

ld.bfd - The GNU linker

libwacom-list-local-devices - utility to list tablet devices

localc - LibreOffice office suite

lowntfs-3g - Third Generation Read/Write NTFS Driver

lsipc - show information on IPC facilities currently employed in the system

lzegrep - search compressed files for a regular expression

ldconfig - configure dynamic linker run-time bindings

locale - description of multilanguage support
locale - describes a locale definition file
locale - get locale-specific information

lowriter - LibreOffice office suite

lslocks - list local system locks

lzfgrep - search compressed files for a regular expression

lp - print files
lp - line printer devices

lslogins - display information about known users in the system

lzgrep - search compressed files for a regular expression

ldd - print shared object dependencies

localectl - Control the system locale and keyboard layout settings

lpadmin - configure cups printers and classes

lsmem - list the ranges of available memory with their online status

lzless - view xz or lzma compressed (text) files

ld.gold - The GNU ELF linker

link - call the link function to create a link to a file
link - make a new name for a file

localedef - compile locale definition files

lpc - line printer control program (deprecated)

lsmod - Show the status of modules in the Linux Kernel

lzma - Compress or decompress .xz and .lzma files

ldrdf - link RDOFF objects and libraries produced by rdflib(1)

linkicc - little cms device link generator.

locale-gen - generates localisation files from templates

lpinfo - show available devices or drivers (deprecated)

lsns - list namespaces

lzmainfo - show information stored in the .lzma file header

lefty - A Programmable Graphics Editor

linux32 - change reported architecture in new program environment
and/or set personality flags

lodraw - LibreOffice office suite

lpmove - move a job or all jobs to a new destination

lsof - list open files

lzmore - view xz or lzma compressed (text) files

less - opposite of more

linux64 - change reported architecture in new program environment
and/or set personality flags

loffice - LibreOffice office suite

lpoptions - display or set printer options and defaults

lspci - list all PCI devices

memusage - profile memory usage of a program

mkfs.cramfs - make compressed ROM file system

mm2gv - Matrix Market-DOT converters

msgcmp - compare message catalog and template

memusagestat - generate graphic from memory profiling data

mkfs.ext2 - create an ext2/ext3/ext4 file system

mmcli - Control and monitor the ModemManager

msgcomm - match two message catalogs

mkfs.ext3 - create an ext2/ext3/ext4 file system

moc-qt5 - generate Qt meta object support code

msgconv - character set conversion for message catalog

m4 - macro processor

mesg - display (or do not display) messages from other users

mkfs.ext4 - create an ext2/ext3/ext4 file system

modinfo - Show information about a Linux Kernel module

msgen - create English message catalog

make - GNU make utility to maintain groups of programs

x-window-manager - minimal GTK3 Window Manager
metacity - minimal GTK3 Window Manager

mkfs.fat - create an MS-DOS FAT filesystem

modprobe - Add and remove modules from the Linux Kernel

msgexec - process translations of message catalog

makeconv - compile a converter table

metacity-message - a command to send a message to Metacity

mkfs.minix - make a Minix filesystem

mokutil - utility to manipulate machine owner keys

msgfilter - edit translations of message catalog

make-first-existing-target - runs make on one of several targets

metacity-theme-viewer - view metacity themes

mkfs.msdos - create an MS-DOS FAT filesystem

msgfmt - compile message catalog to binary format

make-ssl-cert - Debconf wrapper for openssl

migrate-pubring-from-classic-gpg - Migrate a public keyring from
"classic" to "modern" GnuPG

mkfs.ntfs - create an NTFS file system

more - file perusal filter for crt viewing

msggrep - pattern matching on message catalog

mako-render - renders Mako templates

mimeopen - Open files by mimetype

mkfs.vfat - create an MS-DOS FAT filesystem

mount - mount filesystem
mount - mount a filesystem

msginit - initialize a message catalog

man - macros to format man pages
man - an interface to the system reference manuals

mimetype - Determine file type

mkhomedir_helper - Helper binary that creates home directories

mount.fuse - configuration and mount options for FUSE file systems

msgmerge - merge message catalog and template

mandb - create or update the manual page index caches

min12xxw - Convert pbmraw streams to Minolta PagePro 12xxW languages

mkinitramfs - low-level tool for generating an initramfs image

mount.fuse3 - configuration and mount options for FUSE file systems

msgunfmt - uncompile message catalog from binary format

manpath - format of the /etc/manpath.config file
manpath - determine search path for manual pages

mingle - fast edge bundling

mkisofs - create ISO9660/Joliet/HFS filesystem with optional Rock
Ridge attributes

mount.lowntfs-3g - Third Generation Read/Write NTFS Driver

msguniq - unify duplicate translations in message catalog

man-recode - convert manual pages to another encoding

mkdir - make directories
mkdir - create a directory

mklost+found - create a lost+found directory on a mounted Linux second
extended file system

mount.ntfs - Third Generation Read/Write NTFS Driver

mt - control magnetic tape drive operation

mkdosfs - create an MS-DOS FAT filesystem

mk_modmap - translate a Linux keytable file into an xmodmap file

mount.ntfs-3g - Third Generation Read/Write NTFS Driver

mt-gnu - control magnetic tape drive operation

mapscrn - load screen output mapping table

mke2fs - create an ext2/ext3/ext4 file system

mknod - make block or character special files
mknod - create a special or ordinary file

mountpoint - see if a directory or file is a mountpoint

mtr - a network diagnostic tool

mawk - pattern scanning and text processing language

mkfifo - make a FIFO special file (a named pipe)
mkfifo - make FIFOs (named pipes)

mkntfs - create an NTFS file system

mousetweaks - Accessibility enhancements for pointing devices

mtrace - malloc tracing
mtrace - interpret the malloc trace log

mcookie - generate magic cookies for xauth

mkfontdir - create an index of X font files in a directory

mksquashfs - tool to create and append to squashfs filesystems

mscompress - compress data using LZ77 algorithm

mtr-packet - send and receive network probes

md5sum - compute and check MD5 message digest

mkfontscale - create an index of scalable font files for X

mkswap - set up a Linux swap area

msexpand - decompress data compressed using mscompress(1) or COMPRESS.EXE

mv - move (rename) files

md5sum.textutils - compute and check MD5 message digest

mkfs - build a Linux filesystem

mktemp - make a unique temporary filename
mktemp - create a temporary file or directory

msgattrib - attribute matching and manipulation on message catalog

mdig - DNS pipelined lookup utility

mkfs.bfs - make an SCO bfs filesystem

mkzftree - Create a zisofs/RockRidge compressed file tree

msgcat - combines several message catalogs

namei - follow a pathname until a terminal point is found

ncursesw5-config - helper script for ncurses libraries

nfnl_osf - OS fingerprint loader utility

nmtui - Text User Interface for controlling NetworkManager

nslookup - query Internet name servers interactively

ntfscp - copy file to an NTFS volume.

ntfstruncate - truncate a file on an NTFS volume

nano - Nano's ANOther editor, inspired by Pico

ncursesw6-config - helper script for ncurses libraries

nft - Administration tool of the nftables framework for packet
filtering and classification

nmtui-connect - Text User Interface for controlling NetworkManager

ntfsdecrypt - decrypt or update NTFS files encrypted according to EFS

ntfsundelete - recover a deleted file from an NTFS volume.

nasm - the Netwide Assembler, a portable 80x86 assembler

ndisasm - the Netwide Disassembler, an 80x86 binary file disassembler

ngettext - translate message and choose plural form
ngettext - translate message and choose plural form

nmtui-edit - Text User Interface for controlling NetworkManager

ntfsfallocate - preallocate space to a file on an NTFS volume

ntfsusermap - NTFS Building a User Mapping File

nautilus - a file manager for GNOME

neato - filter for drawing undirected graphs

nice - run a program with modified scheduling priority
nice - change process priority

nmtui-hostname - Text User Interface for controlling NetworkManager

nstat - network statistics tools.

ntfsfix - fix common errors and force Windows to check NTFS

ntfswipe - overwrite unused space on an NTFS volume

nautilus-autorun-software - (unknown subject)

neqn - format equations for ASCII output

nisdomainname - show or set the system's NIS/YP domain name

nohup - run a command immune to hangups, with output to a non-tty

nsupdate - dynamic DNS update utility

ntfsinfo - dump a file's attributes

numfmt - Convert numbers from/to human-readable strings

nautilus-sendto - convenience application to send a file via email

netcat - arbitrary TCP and UDP connections and listens

nl - number lines of files

nologin - prevent unprivileged users from logging into the system
nologin - politely refuse a login

ntfs-3g - Third Generation Read/Write NTFS Driver

ntfslabel - display/change the label on an ntfs file system

nawk - pattern scanning and text processing language

netplan - YAML network configuration abstraction for various backends

nm - list symbols from object files

nop - pretty-print graph file

ntfs-3g.probe - Probe an NTFS volume mountability

ntfsls - list directory contents on an NTFS filesystem

nc - arbitrary TCP and UDP connections and listens

networkctl - Query the status of network links

nm-applet - network monitor and control GUI applet

notify-send - a program to send desktop notifications

ntfscat - print NTFS files and streams on the standard output

nc.openbsd - arbitrary TCP and UDP connections and listens

networkd-dispatcher - Dispatcher service for systemd-networkd
connection status changes

nmcli - command-line tool for controlling NetworkManager

nproc - print the number of processing units available

ntfsclone - Efficiently clone, image, restore or rescue an NTFS

ntfsrecover - Recover updates committed by Windows on an NTFS volume

ncurses5-config - helper script for ncurses libraries

newgrp - log in to a new group

nm-connection-editor - network connection editor for NetworkManager

nroff - use groff to format documents for TTY devices

ntfscluster - identify files in a specified region of an NTFS volume.

ntfsresize - resize an NTFS filesystem without data loss

ncurses6-config - helper script for ncurses libraries

newusers - update and create new users in batch

nm-online - ask NetworkManager whether the network is connected

nsenter - run program in different namespaces

ntfscmp - compare two NTFS filesystems and tell the differences

ntfssecaudit - NTFS Security Data Auditing

oakdecode - Decode an OAKT printer stream into human readable form.

objdump - display information from object files

od - dump files in octal and other formats

oomctl - Analyze the state stored in systemd-oomd

openvpn - Secure IP tunnel daemon

obexctl - A command-line interface of BlueZ for OBEX (file transfer)

oclock - round X clock

open - opens a file or URL in the user's preferred application
open - open and possibly create a file

openvt - start a program on a new virtual terminal (VT).

orca - a scriptable screen reader

ownership - Compaq ownership tag retriever

objcopy - copy and translate object files

ocs - creates and maintains the database for cscope on a recursive directory set

on_ac_power - test whether computer is running on AC power

openssl - OpenSSL command line program

opldecode - Decode a Raster Object (opl) stream into human readable form.

osage - filter for drawing clustered graphs

p11-kit - Tool for operating on configured PKCS#11 modules

patch - apply a diff file to an original

pkgdata - package data for use by ICU

pppd - Point-to-Point Protocol Daemon

ps2pdf14 - Convert PostScript to PDF 1.4 (Acrobat 5-and-later
compatible) using ghostscript

pacat - Play back or record raw or encoded audio streams on a
PulseAudio sound server

patchwork - filter for drawing clustered graphs as treemaps

pkill - look up, signal, or wait for processes based on name and other
attributes

pppdump - convert PPP record file to readable format

ps2pdfwr - Convert PostScript to PDF without specifying
CompatibilityLevel, using ghostscript

pw-metadata - The PipeWire metadata

pack200 - Packages a JAR file into a compressed pack200 file for web deployment.

pathchk - check whether file names are valid or portable

perlivp - Perl Installation Verification Procedure

pkmon - PackageKit console client

pppoe-discovery - perform PPPoE discovery

ps2ps - Ghostscript PostScript "distiller"

pw-mididump - The PipeWire MIDI dump

pacmd - Reconfigure a PulseAudio sound server during runtime

pax11publish - PulseAudio X11 Credential Utility

perlthanks - how to submit bug reports on Perl

pkttyagent - Textual authentication helper

pppstats - print PPP statistics

pw-midiplay - Play and record media with PipeWire

pactl - Control a running PulseAudio sound server

pccardctl - PCMCIA card control utility

pf2afm - Make an AFM file from Postscript (PFB/PFA/PFM) font files
using ghostscript

pl2pm - Rough tool to translate Perl4 .pl files to Perl5 .pm modules.

pptp - PPTP driver

pw-midirecord - Play and record media with PipeWire

padsp - PulseAudio OSS Wrapper

pcre2-config - program to return PCRE2 configuration

pfbtopfa - Convert Postscript .pfb fonts to .pfa format using ghostscript

pldd - display dynamic shared objects linked into a process

pptpsetup - Point-to-Point Tunneling Protocol setup

psfaddtable - add a Unicode character table to a console font

pw-mon - The PipeWire monitor

pager - opposite of more

pcre-config - program to return PCRE configuration

pgrep - look up, signal, or wait for processes based on name and other
attributes

plog - starts up, shuts down or lists the log of PPP connections

pr - convert text files for printing

psfgettable - extract the embedded Unicode character table from a console font

pw-play - Play and record media with PipeWire

pdb3 - the Python debugger

pic - compile pictures for troff or TeX

plymouth - Send commands to plymouthd
plymouth - A graphical boot system and logger

precat - prefix delta compressor for Aspell

psfstriptable - remove the embedded Unicode character table from a console font

pw-profiler - The PipeWire profiler

pam-auth-update - manage PAM configuration using packaged profiles

pdb3.10 - the Python debugger

pico - Nano's ANOther editor, inspired by Pico

plymouthd - The plymouth daemon

preconv - convert encoding of input files to something GNU troff understands

psfxtable - handle Unicode character tables for console fonts

pw-record - Play and record media with PipeWire

pdf2dsc - generate a PostScript page list of a PDF document

piconv - iconv(1), reinvented in perl

pmap - report memory map of a process

preparetips5 - extract text from tips file

psicc - little cms PostScript converter.

pdf2ps - Ghostscript PDF to PostScript translator

pidof - find the process ID of a running program.

preunzip - prefix delta compressor for Aspell

pslog - report current logs path of a process

pam_getenv - get environment variables from /etc/environment

pdfattach - Portable Document Format (PDF) document embedded file
creator (version 3.03)

pidwait - look up, signal, or wait for processes based on name and
other attributes

prezip - prefix delta compressor for Aspell

pstree - display a tree of processes

pwunconv - convert to and from shadow passwords and groups

pamon - Play back or record raw or encoded audio streams on a
PulseAudio sound server

pdfdetach - Portable Document Format (PDF) document embedded file
extractor (version 3.03)

pinentry - PIN or pass-phrase entry dialog for GnuPG

pnm2ppa - convert portable anymap (PNM) images to HP's PPA printer format.

prezip-bin - prefix zip delta word list compressor/decompressor

pstree.x11 - display a tree of processes

pam_timestamp_check - Check to see if the default timestamp is valid

pdffonts - Portable Document Format (PDF) font analyzer (version 3.03)

pinentry-curses - PIN or pass-phrase entry dialog for GnuPG

pod2html - convert .pod files to .html files

print - execute programs via entries in the mailcap file

ptar - a tar-like program written in perl

py3clean - removes .pyc and .pyo files

pdfimages - Portable Document Format (PDF) image extractor (version 3.03)

pinentry-gnome3 - PIN or pass-phrase entry dialog for GnuPG

pod2man - Convert POD data to formatted *roff input

printafm - Print the metrics from a Postscript font in AFM format
using ghostscript

ptardiff - program that diffs an extracted archive against an unextracted one

py3compile - byte compile Python 3 source files

pdfinfo - Portable Document Format (PDF) document information
extractor (version 3.03)

pinentry-x11 - PIN or pass-phrase entry dialog for GnuPG

pod2text - Convert POD data to formatted ASCII text

printenv - print all or part of environment

ptargrep - Apply pattern matching to the contents of files in a tar archive

py3versions - print python3 version information

pango-view - "Pango text viewer"

pdfseparate - Portable Document Format (PDF) page extractor

ping - send ICMP ECHO_REQUEST to network hosts

pod2usage - print usage messages from embedded pod docs in files

printer-profile - Profile using X-Rite ColorMunki and Argyll CMS

ptx - produce a permuted index of file contents

pydoc3 - the Python documentation tool

paperconf - print paper configuration information

pdfsig - Portable Document Format (PDF) digital signatures tool

ping4 - send ICMP ECHO_REQUEST to network hosts

podchecker - check the syntax of POD format documentation files

printf - formatted output conversion
printf - format and print data

pulseaudio - The PulseAudio Sound System

pydoc3.10 - the Python documentation tool

paperconfig - configure the system default paper size

pdftocairo - Portable Document Format (PDF) to
PNG/JPEG/TIFF/PDF/PS/EPS/SVG using cairo

ping6 - send ICMP ECHO_REQUEST to network hosts

poff - starts up, shuts down or lists the log of PPP connections

vlimit - get/set resource limits
prlimit - get and set process resource limits
prlimit - get/set resource limits

pygettext3 - Python equivalent of xgettext(1)

paplay - Play back or record raw or encoded audio streams on a
PulseAudio sound server

pdftohtml - program to convert PDF files into HTML, XML and PNG images

pinky - lightweight finger

pon - starts up, shuts down or lists the log of PPP connections

pw-cat - Play and record media with PipeWire

pygettext3.10 - Python equivalent of xgettext(1)

parec - Play back or record raw or encoded audio streams on a
PulseAudio sound server

pdftoppm - Portable Document Format (PDF) to Portable Pixmap (PPM)
converter (version 3.03)

pipewire - The PipeWire media server

prove - Run tests through a TAP harness.

pwck - verify integrity of password files

python3 - an interpreted, interactive, object-oriented programming language

parecord - Play back or record raw or encoded audio streams on a
PulseAudio sound server

pdftops - Portable Document Format (PDF) to PostScript converter (version 3.03)

poweroff - Halt, power-off or reboot the machine

prtstat - print statistics of a process

pw-cli - The PipeWire Command Line Interface

python3.10 - an interpreted, interactive, object-oriented programming language

parted - a partition manipulation program

pdftotext - Portable Document Format (PDF) to text converter (version 3.03)

pivot_root - change the root mount
pivot_root - change the root filesystem

prune - Prune directed graphs

pwconv - convert to and from shadow passwords and groups

python3.10-config - output build options for python C/C++ extensions
or embedding

partprobe - inform the OS of partition table changes

pdfunite - Portable Document Format (PDF) page merger

ppdc - cups ppd compiler (deprecated)

ps - report a snapshot of the current processes.

pwd - print name of current/working directory

python3-config - output build options for python C/C++ extensions or embedding

partx - tell the kernel about the presence and numbering of on-disk partitions

peekfd - peek at file descriptors of running processes

pkaction - Get details about a registered action

ppdhtml - cups html summary generator (deprecated)

ps2ascii - Ghostscript translator from PostScript or PDF to ASCII

pw-dot - The PipeWire dot graph dump

passwd - the password file
passwd - change user password
passwd - OpenSSL application commands

perl - The Perl 5 language interpreter

pkcheck - Check whether a process is authorized

ppdi - import ppd files (deprecated)

ps2epsi - generate conforming Encapsulated PostScript

paste - merge lines of files

perl5.34.0 - The Perl 5 language interpreter

pkcon - PackageKit console client

ppdmerge - merge ppd files (deprecated)

ps2pdf - Convert PostScript to PDF using ghostscript

pzstd - parallelised Zstandard compression, al la pigz

perl5.34-x86_64-linux-gnu - The Perl 5 language interpreter

pkexec - Execute a command as another user

ppdpo - ppd message catalog generator (deprecated)

ps2pdf12 - Convert PostScript to PDF 1.2 (Acrobat 3-and-later
compatible) using ghostscript

pwdx - report current working directory of a process

pasuspender - Temporarily suspend PulseAudio

perlbug - how to submit bug reports on Perl

pkg-config - Return metainformation about installed libraries

ps2pdf13 - Convert PostScript to PDF 1.3 (Acrobat 4-and-later
compatible) using ghostscript

qmake-qt5 - cross-platform makefile generator for Qt

qpdldecode - Decode a QPDL stream into human readable form.

qtchooser - a wrapper used to select between Qt development binary versions

ranlib - generate an index to an archive

rdiffdir - compute and apply signatures and diffs to directories

recode-sr-latin - convert Serbian text from Cyrillic to Latin script

resize2fs - ext2/ext3/ext4 file system resizer

rm - remove files or directories

runcon - run command with specified security context

rbash - restricted bash, see bash(1)

rdma - RDMA tool

red - line-oriented text editor
tc-red - Random Early Detection

resizecons - change kernel idea of the console size

rmdir - remove empty directories
rmdir - delete a directory

rsh - OpenSSH remote login client

runlevel - Print previous and current SysV runlevel

rdx - load and execute an RDOFF object

remmina - Remmina the GTK+ Remote Desktop Client

resizepart - tell the kernel about the new size of a partition

rmic - Generates stub, skeleton, and tie classes for remote objects
that use the Java Remote Method Protocol (JRMP) or Internet Inter-Orb
protocol (IIOP). Also generates O...

rstart - a sample implementation of a Remote Start client

run-mailcap - execute programs via entries in the mailcap file

rcp - OpenSSH secure file copy

read - read from a file descriptor

remmina-file-wrapper - (unknown subject)

resolvectl - Resolve domain names, IPV4 and IPv6 addresses, DNS
resource records, and services; introspect and reconfigure the DNS
resolver

rmid - Starts the activation system daemon that enables objects to be
registered and activated in a Java Virtual Machine (JVM).

rstartd - a sample implementation of a Remote Start rsh helper

run-parts - run scripts or programs in a directory

rctest - RFCOMM testing

remmina-gnome - Script file to start common GNOME Shell interfaces

rmiregistry - Starts a remote object registry on the specified port on
the current host.

rsync - a fast, versatile, remote (and local) file-copying tool

runuser - run a command with substitute user and group ID

rdf2bin - convert an RDOFF object file to flat binary

readelf - display information about ELF files

remove-default-ispell - remove default ispell dictionary

rev - reverse lines characterwise

rmmod - Simple program to remove a module from the Linux Kernel

rsync-ssl - a helper script for connecting to an ssl rsync daemon

run-with-aspell - script to help use GNU Aspell as an ispell replacement

rdf2com - convert an RDOFF object file to flat binary

readlink - print resolved symbolic links or canonical file names
readlink - read value of a symbolic link

remove-default-wordlist - remove default wordlist

rfcomm - RFCOMM configuration utility

rmt - remote magnetic tape server

rsyslogd - reliable and extended syslogd

rview - Vi IMproved, a programmer's text editor

rdf2ihx - convert an RDOFF object file to flat binary

remove-shell - remove shells from the list of valid login shells

rfkill - tool for enabling and disabling wireless devices

rmt-tar - remote magnetic tape server

rtacct - network statistics tools.

rvim - Vi IMproved, a programmer's text editor

rdf2ith - convert an RDOFF object file to flat binary

readprofile - read kernel profiling information

rendercheck - simple tests of the X Render extension.

rgrep - print lines that match patterns

rnano - a restricted nano

rtcwake - enter a system sleep state until specified wakeup time

rygel - a collection of DLNA/UPnP AV services

rdf2srec - convert an RDOFF object file to flat binary

readtags - Find tag file entries matching specified names

renice - alter priority of running processes

rhythmbox - music player and library for tagged files using GStreamer

routef - flush routes

rtkitctl - Realtime Policy and Watchdog daemon control

rdfdump - dumps an RDOFF object in human-readable form

realpath - return the canonicalized absolute pathname
realpath - print the resolved path

rhythmbox-client - controls a running instance of rhythmbox

routel - list routes with pretty output format

rtmon - listens to and monitors RTnetlink

rdflib - manage a library file for use with ldrdf(1)

reboot - reboot or enable/disable Ctrl-Alt-Del
reboot - Halt, power-off or reboot the machine

reset - terminal initialization

rlogin - OpenSSH remote login client

rpcgen - an RPC protocol compiler

rtstat - unified linux network statistics

saned - SANE network daemon

sed - stream editor for filtering and transforming text

setkeycodes - load kernel scancode-to-keycode mapping table entries

sha256sum - compute and check SHA256 message digest

slxdecode - Decode a SLX stream into human readable form.

ssh-keygen - OpenSSH authentication key utility

sudo_sendlog - send sudo I/O log to log server

systemd-cryptenroll - Enroll PKCS#11, FIDO2, TPM2 token/devices to
LUKS2 encrypted volumes

sane-find-scanner - find SCSI and USB scanners and their device files

see - execute programs via entries in the mailcap file

setleds - set the keyboard leds

sha384sum - compute and check SHA384 message digest

smproxy - Session Manager Proxy

spd-conf - configure Speech Dispatcher and diagnose problems

ssh-keyscan - gather SSH public keys from servers

sulogin - single-user login

systemd-delta - Find overridden configuration files

savelog - save a log file

select - synchronous I/O multiplexing

setlogcons - Send kernel messages to console N

sha512sum - compute and check SHA512 message digest

snap - Tool to interact with snaps

spd-say - send text-to-speech output request to speech-dispatcher

start-pulseaudio-x11 - PulseAudio Sound Server X11 Startup Script

sum - checksum and count the blocks in a file

systemd-detect-virt - Detect execution in a virtualized environment

sbattach - UEFI secure boot detached signature tool

select-default-ispell - select default ispell dictionary

setmetamode - define the keyboard meta key handling

start-stop-daemon - start and stop system daemon programs

systemd-escape - Escape strings for usage in systemd unit names

sbkeysync - UEFI secure boot key synchronization tool

select-default-iwrap - Selects the user default ispell dictionary for
use with ispell-wrapper

setpci - configure PCI devices

shasum - Print or Check SHA Checksums

speaker-test - command-line speaker test tone generator for ALSA

startx - initialize an X session

swaplabel - print or change the label or UUID of a swap area

systemd-hwdb - hardware database management tool

sbsiglist - Create EFI_SIGNATURE_LIST signature databases

select-default-wordlist - select default wordlist

setpriv - run a program with different Linux privilege settings

speech-dispatcher - speech synthesis daemon

stat - display file or file system status
stat - get file status

swapoff - start/stop swapping to file/device
swapoff - enable/disable devices and files for paging and swapping

systemd-id128 - Generate and print sd-128 identifiers

sbsign - UEFI secure boot signing tool

select-editor - select your default sensible-editor from all installed editors

setsid - run a program in a new session
setsid - creates a session and sets the process group ID

spice-vdagent - Spice guest agent X11 session agent

swapon - start/stop swapping to file/device
swapon - enable/disable devices and files for paging and swapping

systemd-inhibit - Execute a program with an inhibition lock taken

sbvarsign - UEFI authenticated variable signing tool

sensible-browser - sensible web browsing

setterm - set terminal attributes

shotwell - Digital photo manager

spice-vdagentd - Spice guest agent daemon

stdbuf - Run COMMAND, with modified buffering operations for its
standard streams.

systemd-machine-id-setup - Initialize the machine ID in /etc/machine-id

sbverify - UEFI secure boot verification tool

sensible-editor - sensible editing

setupcon - sets up the font and the keyboard on the console

showconsolefont - Show the current EGA/VGA console screen font

snice - send a signal or report process status

splain - produce verbose warning diagnostics

stl2gts - convert an STL file to GTS format.

switch_root - switch to another filesystem as the root of the mount tree

systemd-mount - Establish and destroy transient mount or auto-mount points

scanimage - scan an image

sensible-pager - sensible paging

setvesablank - Turn VESA screen blanking on or off

showkey - examine the codes sent by the keyboard

soelim - interpret .so requests in groff input

split - split a file into pieces

strace - trace system calls and signals

sync - Synchronize cached writes to persistent storage
sync - commit filesystem caches to disk

systemd-notify - Notify service manager about start-up completion and
other daemon status changes

sccmap - extract strongly connected components of directed graphs

seq - print a sequence of numbers

setvtrgb - customize the console color map
setvtrgb - set the virtual terminal RGB colors

showrgb - display an rgb color-name database

splitfont - extract characters from an ISO-type font.

strace-log-merge - merge strace -ff -tt output

sysctl - read/write system parameters
sysctl - configure kernel parameters at runtime

systemd-path - List and query system and user paths

scp - OpenSSH secure file copy

serialver - Returns the serial version UID for specified classes.

setxkbmap - set the keyboard using the X Keyboard Extension

shred - overwrite a file to hide its contents, and optionally delete it

software-properties-gtk - Software Sources List editor

sprof - read and display shared object profiling data

streamzip - create a zip file from stdin

system-config-printer - configure a CUPS server

systemd-run - Run programs in transient scope units, service units, or
path-, socket-, or timer-triggered service units

service - run a System V init script

sfdisk - display or manipulate a disk partition table

shuf - generate random permutations

sol - a collection of card games which are easy to play with the aid of a mouse.

strings - print the sequences of printable characters in files

system-config-printer-applet - print job manager

systemd-socket-activate - Test socket activation of daemons

screendump - dump the contents of a virtual console to stdout

session-migration - Migrate in user session settings.

sfdp - filter for drawing large undirected graphs

shutdown - shut down part of a full-duplex connection
shutdown - Halt, power-off or reboot the machine

sort - sort lines of text files

strip - discard symbols and other data from object files

systemctl - Control the systemd system and service manager

script - make typescript of terminal session

sessreg - manage utmpx/wtmpx entries for non-init clients

sftp - OpenSSH secure file transfer

simple-scan - Scanning utility

sotruss - trace shared library calls through PLT

ss - another utility to investigate sockets

stty - change and print terminal line settings
stty - unimplemented system calls

systemd - systemd system and service manager

systemd-sysext - Activates System Extension Images

scriptlive - re-run session typescripts, using timing information

sg - execute command as different group ID

size - list section sizes and total size of binary files

ssh - OpenSSH remote login client

su - run a command with substitute user and group ID

systemd-analyze - Analyze and debug system manager

systemd-sysusers - Allocate system users and groups

scriptreplay - play back typescripts, using timing information

setarch - change reported architecture in new program environment
and/or set personality flags

sgdisk - Command-line GUID partition table (GPT) manipulator for Linux and Unix

skill - send a signal or report process status

ssh-add - adds private key identities to the OpenSSH authentication agent

sudo - execute a command as another user

systemd-ask-password - Query the user for a system password

systemd-tmpfiles - Creates, deletes and cleans up volatile and
temporary files and directories

sdiff - side-by-side merge of file differences

setcap - set file capabilities

sh - command interpreter (shell)

slabtop - display kernel slab cache information in real time

ssh-agent - OpenSSH authentication agent

sudoedit - execute a command as another user

systemd-cat - Connect a pipeline or program's output with the journal

systemd-tty-ask-password-agent - List or process pending systemd
password requests

sdptool - control and interrogate SDP servers

setfacl - set file access control lists

sha1sum - compute and check SHA1 message digest

sleep - sleep for a specified number of seconds
sleep - delay for a specified amount of time

ssh-argv0 - replaces the old ssh command-name as hostname handling

sudo_logsrvd - sudo event and I/O log server

systemd-cgls - Recursively show control group contents

systemd-umount - Establish and destroy transient mount or auto-mount points

seahorse - Passwords and Keys

setfont - load EGA/VGA console screen font

sha224sum - compute and check SHA224 message digest

slogin - OpenSSH remote login client

ssh-copy-id - use locally available keys to authorise logins on a remote machine

sudoreplay - replay sudo session logs

systemd-cgtop - Show top control groups by their resource usage

tabs - set tabs on a terminal

tclsh8.6 - Simple shell containing Tcl interpreter

thermald - start Linux thermal daemon

tload - graphic representation of system load average

tracepath - traces path to a network host discovering MTU along this path

true - do nothing, successfully

tac - concatenate and print files in reverse

tcpdump - dump traffic on a network

thunderbird - Mail User Agent (MUA) and newsgroup/RSS client for X11
derived from the Mozilla suite.

tnftp - Internet file transfer program

truncate - shrink or extend the size of a file to the specified size
truncate - truncate a file to a specified length

tail - output the last part of files

tee - read from standard input and write to standard output and files
tee - duplicating pipe content

tic - the terminfo entry-description compiler

toe - table of (terminfo) entries

transform - apply geometric transformations to the input.

trust - Tool for operating on the trust policy store

tzselect - view timezones
tzselect - select a timezone

tar - an archiving utility

telinit - Change SysV runlevel

tificc - little cms ICC profile applier for TIFF.

top - display Linux processes

transicc - little cms ColorSpace conversion calculator.

tset - terminal initialization

tarcat - concatenates the pieces of a GNU tar multi-volume archive

telnet - user interface to the TELNET protocol

time - overview of time and timers
time - run programs and summarize system resource usage
time - get time in seconds

totem - GNOME desktop movie player based on GStreamer

transmission-gtk - a bittorrent client

tsort - perform topological sort

taskset - set or retrieve a process's CPU affinity

telnet.netkit - user interface to the TELNET protocol

timedatectl - Control the system time and date

totem-video-thumbnailer - video thumbnailer for the GNOME desktop

transset - Set transparency on a window

tty - print the file name of the terminal connected to standard input
tty - controlling terminal

tbl - format tables for troff

tempfile - create a temporary file in a safe manner

timeout - run a command with a time limit

touch - change file timestamps

tune2fs - adjust tunable file system parameters on ext2/ext3/ext4 file systems

tc - show / manipulate traffic control settings

test - check file types and compare values

times - get process times

tput - initialize a terminal or query terminfo database

tred - transitive reduction filter for directed graphs

twopi - filter for radial layouts of graphs

tclsh - Simple shell containing Tcl interpreter

tipc - a TIPC configuration and management tool

tr - translate or delete characters

troff - the troff processor of the groff text formatting system

ua - Manage Ubuntu Advantage services from Canonical

update-catalog - create or update entry in SGML catalog file

update-info-dir - update or create index file from all installed info
files in directory

usb-devices - print USB device details

ubuntu-advantage - Manage Ubuntu Advantage services from Canonical

unix_chkpwd - Helper binary that verifies the password of the current user

update-ccache-symlinks - update symlinks in /usr/lib/ccache

update-initramfs - generate an initramfs image

usbhid-dump - dump USB HID device report descriptors and streams

ubuntu-bug - file a bug report using Apport, or update an existing report

ul - do underlining

unix_update - Helper binary that updates the password of a given user

update-cracklib - Regenerate cracklib dictionary

update-java-alternatives - update alternatives for jre/sdk installations

usb_modeswitch - control the mode of 'multi-state' USB devices

ulimit - get and set user limits
phys - unimplemented system calls

unlink - call the unlink function to remove the specified file
unlink - delete a name and possibly the file it refers to

update-default-aspell - rebuild aspell database and emacsen stuff

update-locale - Modify global locale settings

usb_modeswitch_dispatcher - Linux wrapper for usb_modeswitch (not
intended for direct invocation)

ubuntu-distro-info - provides information about Ubuntu's distributions

umask - set file mode creation mask

unlzma - Compress or decompress .xz and .lzma files

update-default-ispell - update default ispell dictionary

update-manager - graphical management of software packages updates

usbmuxd - Expose a socket to multiplex connections from and to iOS devices.

unmkinitramfs - extract content from an initramfs image

update-default-wordlist - update default wordlist

update-mime - create or update MIME information

usb_printerid - prints the ID of the printer on a USB port

ubuntu-report - Report metrics from your system, install and upgrades

umount - unmount filesystem
umount - unmount filesystems

unopkg - LibreOffice Extension Manager

update-desktop-database - Build cache database of MIME types handled
by desktop files

update-mime-database - a program to build the Shared MIME-Info database cache

umount.udisks2 - unmount file systems that have been mounted by UDisks2

unpack200 - Transforms a packed file produced by pack200(1) into a JAR
file for web deployment.

update-dictcommon-aspell - rebuild aspell database and emacsen stuff

useradd - create a new user or update default new user information

ucf - Update Configuration File: preserve user changes in configuration files

update-dictcommon-hunspell - rebuild hunspell database and emacsen stuff

update-passwd - safely update /etc/passwd, /etc/shadow and /etc/group

userdel - delete a user account and related files

ucfq - query the ucf database

uname - print system information
uname - get name and information about current kernel

unshare - run program in new namespaces
unshare - disassociate parts of the process execution context

update-fonts-alias - compile fonts.alias files

update-pciids - download new version of the PCI ID list

usermod - modify a user account

ucfr - Update Configuration File Registry: associate packages with
configuration files

unattended-upgrade - automatic installation of security (and other) upgrades

unsquashfs - tool to uncompress squashfs filesystems

update-fonts-dir - compile fonts.dir files

update-rc.d - install and remove System-V style init script links

users - print the user names of users currently logged in to the current host

uclampset - manipulate the utilization clamping attributes of the
system or a process

unattended-upgrades - automatic installation of security (and other) upgrades

update-fonts-scale - generate fonts.scale files

utmpdump - dump UTMP and WTMP files in raw format

uconv - convert data from one encoding to another

uncompress - compress or expand files

unxz - Compress or decompress .xz and .lzma files

update-grub - stub for grub-mkconfig

update-shells - update the list of valid login shells

uuidd - UUID generation daemon

ucs2any - generate BDF fonts containing subsets of ISO 10646-1 codepoints

unexpand - convert spaces to tabs

unzip - list, test and extract compressed files in a ZIP archive

update-grub2 - stub for grub-mkconfig

update-xmlcatalog - maintain XML catalog files

uuidgen - create a new UUID value

unflatten - adjust directed graphs to improve layout aspect ratio

unzipsfx - self-extracting stub for prepending to ZIP archives

update-grub-gfxpayload - update /boot/grub/gfxblacklist.txt

uuidparse - a utility to parse unique identifiers

udevadm - udev management tool

unicode_start - put keyboard and console in unicode mode

unzstd - Compress or decompress .zst files

UPower - System-wide Power Management
upower - UPower command line tool

udisksctl - The udisks command line tool

unicode_stop - revert keyboard and console from unicode mode

update-alternatives - maintain symbolic links determining default commands

update-icon-caches - Update wrapper script for the icon caches

uptime - Tell how long the system has been running.

ufw - program for managing a netfilter firewall

uniq - report or omit repeated lines

update-ca-certificates - update /etc/ssl/certs and ca-certificates.crt

update-inetd - create, remove, enable or disable entry /etc/inetd.conf

usb-creator-gtk - Ubuntu startup disk creation tool for Gtk+

validlocale - Test if a given locale is available

view - Vi IMproved, a programmer's text editor

vimdiff - edit between two and eight versions of a file with Vim and
show differences

visudo - edit the sudoers file

vcstime - Show time in upper right hand corner of the console screen

viewres - graphical class browser for Xt

vimdot - Combined text editor and dot viewer

vmware-checkvm - Check if running in a VM or not

vmware-toolbox-cmd - GUI toolbox (commandline version)

vmware-xferlogs - dump vm-support output to vmx logfile

vdir - list directory contents

vigr - edit the password, group, shadow-password or shadow-group file

vmstat - Report virtual memory statistics

vdpa - vdpa management tool

vim - Vi IMproved, a programmer's text editor

vimtutor - the Vim tutor

vmware-user-suid-wrapper - wrapper programm for vmware-user(1)

vpddecode - VPD structure decoder

vi - Vi IMproved, a programmer's text editor

vipw - edit the password, group, shadow-password or shadow-group file

vstp - VisioBraille file transferring

w - Show who is logged on and what they are doing.

watchgnupg - Read and print logs from a socket

wget - The non-interactive network downloader.

which.debianutils - locate a command

whoami - print effective userid

word-list-compress - word list compressor/decompressor for GNU Aspell

wpa_supplicant - Wi-Fi Protected Access client and IEEE 802.1X supplicant

wait - wait for process to change state

whatis - display one-line manual page descriptions

wpa_action - wpa_cli action script

write - send a message to another user
write - write to a file descriptor

wall - write a message to all users

wc - print newline, word, and byte counts for each file

whereis - locate the binary, source, and manual page files for a command

whiptail - display dialog boxes from shell scripts

wpa_cli - WPA command line client

write.ul - send a message to another user

watch - execute a program periodically, showing output fullscreen

wdctl - show hardware watchdog status

which - locate a command

who - show who is logged on

wipefs - wipe a signature from a device

wpa_passphrase - Generate a WPA PSK from an ASCII passphrase for a SSID

x11perf - X11 server performance test program

x86_64-linux-gnu-ld - The GNU linker

xdg-desktop-icon - command line tool for (un)installing icons to the desktop

xkbvleds - XKB extension user utility

xsetwacom - commandline utility to query and modify wacom driver settings.

x11perfcomp - X11 server performance comparison program

x86_64-linux-gnu-ld.bfd - The GNU linker

xdg-desktop-menu - command line tool for (un)installing desktop menu items

xkbwatch - XKB extension user utility

xslt-config - script to get information about the installed version of libxslt

x86_64 - change reported architecture in new program environment
and/or set personality flags

x86_64-linux-gnu-ld.gold - The GNU ELF linker

xdg-email - command line tool for sending mail using the user's
preferred e-mail composer

xsltproc - command line XSLT processor

x86_64-linux-gnu-addr2line - convert addresses into file names and line numbers

x86_64-linux-gnu-lto-dump-11 - Tool for dumping LTO object files

xdg-icon-resource - command line tool for (un)installing icon resources

xkill - kill a client by its X resource

xsm - X Session Manager

x86_64-linux-gnu-ar - create, modify, and extract from archives

x86_64-linux-gnu-nm - list symbols from object files

xdg-mime - command line tool for querying information about file type
handling and adding descriptions for new file types

xload - system load average display for X

xstdcmap - X standard colormap utility

x86_64-linux-gnu-as - the portable GNU assembler.

x86_64-linux-gnu-objcopy - copy and translate object files

xdg-open - opens a file or URL in the user's preferred application

xlogo - X Window System logo

xsubpp - compiler to convert Perl XS code into C code

x86_64-linux-gnu-c++filt - demangle C++ and Java symbols

x86_64-linux-gnu-objdump - display information from object files

xdg-screensaver - command line tool for controlling the screensaver

xlsatoms - list interned atoms defined on server

xtables-legacy-multi - iptables using old getsockopt/setsockopt-based kernel api

x86_64-linux-gnu-cpp - The C Preprocessor

xdg-settings - get various settings from the desktop environment

xlsclients - list client applications running on a display

xtables-monitor - show changes to rule set and trace-events

x86_64-linux-gnu-cpp-11 - The C Preprocessor

x86_64-linux-gnu-python3.10-config - output build options for python
C/C++ extensions or embedding

xdg-user-dir - Find an XDG user dir

xlsfonts - server font list displayer for X

xtables-nft-multi - iptables using nftables kernel api

x86_64-linux-gnu-dwp - The DWARF packaging utility

x86_64-linux-gnu-python3-config - output build options for python
C/C++ extensions or embedding

xmag - magnify parts of the screen

x-terminal-emulator - A terminal emulator for GNOME

x86_64-linux-gnu-elfedit - update ELF header and program property of ELF files

xdg-user-dirs-update - Update XDG user dir configuration

xman - Manual page display program for the X Window System

xvidtune - video mode tuner for Xorg

x86_64-linux-gnu-g++ - GNU project C and C++ compiler

x86_64-linux-gnu-ranlib - generate an index to an archive

xditview - display ditroff output

xmessage - display a message or query in a window (X-based /bin/echo)

xvinfo - Print out X-Video extension adaptor information

x86_64-linux-gnu-g++-11 - GNU project C and C++ compiler

x86_64-linux-gnu-readelf - display information about ELF files

xdpyinfo - display information utility for X

xml2-config - script to get information about the installed version of GNOME-XML

xwd - dump an image of an X window

x86_64-linux-gnu-gcc - GNU project C and C++ compiler

x86_64-linux-gnu-size - list section sizes and total size of binary files

xdriinfo - query configuration information of DRI drivers

xmlcatalog - Command line tool to parse and manipulate XML or SGML
catalog files.

x-window-manager - minimal GTK3 Window Manager

x86_64-linux-gnu-gcc-11 - GNU project C and C++ compiler

x86_64-linux-gnu-strings - print the sequences of printable characters in files

xedit - simple text editor for X

xmllint - command line XML tool

xwininfo - window information utility for X

x86_64-linux-gnu-gcc-ar - a wrapper around ar adding the --plugin option

x86_64-linux-gnu-strip - discard symbols and other data from object files

xev - print contents of X events

xwud - image displayer for X

x86_64-linux-gnu-gcc-ar-11 - a wrapper around ar adding the --plugin option

xeyes - a follow the mouse X demo

xxd - make a hexdump or do the reverse.

x86_64-linux-gnu-gcc-nm - a wrapper around nm adding the --plugin option

xargs - build and execute command lines from standard input

xfd - display all the characters in an X font

xmodmap - utility for modifying keymaps and pointer button mappings in X

xz - Compress or decompress .xz and .lzma files

x86_64-linux-gnu-gcc-nm-11 - a wrapper around nm adding the --plugin option

xauth - X authority file utility

xfontsel - point and click selection of X11 font names

xmore - plain text display program for the X Window System

xzcat - Compress or decompress .xz and .lzma files

x86_64-linux-gnu-gcc-ranlib - a wrapper around ranlib adding the --plugin option

xbiff - mailbox flag for X

xgamma - Alter a monitor's gamma correction through the X server

xprop - property displayer for X

xzcmp - compare compressed files

x86_64-linux-gnu-gcc-ranlib-11 - a wrapper around ranlib adding the
--plugin option

xbrlapi - X11 BrlAPI helper for Linux/Unix

xgc - X graphics demo

xqxdecode - Decode a XQX stream into human readable form.

xzdiff - compare compressed files

x86_64-linux-gnu-gcov - coverage testing tool

xcalc - scientific calculator for X

xgettext - extract gettext strings from source

Xrandr - X Resize, Rotate and Reflection extension.
xrandr - primitive command line interface to RandR extension

xzegrep - search compressed files for a regular expression

x86_64-linux-gnu-gcov-11 - coverage testing tool

xclipboard - X clipboard client

xhost - server access control program for X

xrdb - X server resource database utility

xzfgrep - search compressed files for a regular expression

x86_64-linux-gnu-gcov-dump - offline gcda and gcno profile dump tool

xclock - analog / digital clock for X

xinit - X Window System initializer

xrefresh - refresh all or part of an X screen

xzgrep - search compressed files for a regular expression

x86_64-linux-gnu-gcov-dump-11 - offline gcda and gcno profile dump tool

xcmsdb - Device Color Characterization utility for X Color Management System

xinput - utility to configure and test X input devices

x-session-manager - Start the GNOME desktop environment

xzless - view xz or lzma compressed (text) files

x86_64-linux-gnu-gcov-tool - offline gcda profile processing tool

xconsole - monitor system console messages with X

xkbbell - XKB extension user utility

xset - user preference utility for X

xzmore - view xz or lzma compressed (text) files

x86_64-linux-gnu-gcov-tool-11 - offline gcda profile processing tool

xcursorgen - create an X cursor file from a collection of PNG images

xkbcomp - compile XKB keyboard description

xsetmode - set the mode for an X Input device

x86_64-linux-gnu-gold - The GNU ELF linker

xcutsel - interchange between cut buffer and selection

xkbevd - XKB event daemon

xsetpointer - set an X Input device as the main pointer

x86_64-linux-gnu-gprof - display call graph profile data

xdg-dbus-proxy - D-Bus proxy

xkbprint - print an XKB keyboard description

xsetroot - root window parameter setting utility for X

yacc - GNU Project parser generator

yelp - browse system documentation

yes - output a string repeatedly until killed

ypdomainname - show or set the system's NIS/YP domain name

zcat - compress or expand files

zdiff - compare compressed files

zegrep - search possibly compressed files for a regular expression

zerofree - zero free blocks from ext2, ext3 and ext4 file-systems

zforce - force a '.gz' extension on all gzip files

zic - timezone compiler

zipcloak - encrypt entries in a zipfile

zipgrep - search files in a ZIP archive for lines matching a pattern

zipnote - write the comments in zipfile to stdout, edit comments and
rename files in zipfile

zjsdecode - Decode a ZjStream into human readable form.

zmore - file perusal filter for crt viewing of compressed text

zramctl - set up and control zram devices

zstdcat - Compress or decompress .zst files

zstdless - view zstandard-compressed files

zcmp - compare compressed files

zdump - timezone dumper

zenity - display GTK+ dialogs

zfgrep - search possibly compressed files for a regular expression

zgrep - search possibly compressed files for a regular expression

zip - package and compress (archive) files

zipdetails - display the internal structure of zip files

zipinfo - list detailed information about a ZIP archive

zipsplit - split a zipfile into smaller zipfiles

zless - file perusal filter for crt viewing of compressed text

znew - recompress .Z files to .gz files

zstd - Compress or decompress .zst files

zstdgrep - print lines matching a pattern in zstandard-compressed files

zstdmt - Compress or decompress .zst files

-------------------------------------------------------------------------------
