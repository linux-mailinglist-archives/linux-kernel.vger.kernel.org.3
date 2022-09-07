Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728355B103C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIGXL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIGXLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:11:19 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1EB2A0609;
        Wed,  7 Sep 2022 16:11:14 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id ADE401102;
        Thu,  8 Sep 2022 01:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1662592270;
        bh=6LCLWQI59poVjOYVFfTggywe9QubOLG22cKEip1EYJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5a+GuJAhcg2G3GKx/JJ3saeZmPdxYp19xYTGxFYJMavluppNyNWyUGGf7LVmfFUH
         xUH9FLPaokkaCQuilmpYBCFsdH2jpv0XKmPtpk6HhE6uk/gCtezhvBbJ0cyJJBHs3Z
         y+hRdClRrj4iDoY+YeOuAcQr8ZJegqGxJAOhWXKFh/D5OevI3GFes//5MzJFgmCCqo
         IL5yxcGTBqpAqBAuKrsP8/4WbDiYUCrdgdBs5vxdNMaJr4ZnkDi7R8VxWiQCsrfkdL
         jkwqjrwDYA8VrlLMru3X3zQeVJSIakr261AO1kg57Vu6lVFPEzE2xpSUe1BGKaadXW
         QprxoP+RpAFte7I5Etmx6nJhn7BDdQUd24le8AhqaM1FnCbuyxUtNIK2b22mD/EYav
         QDhLqoE2lUTanAt15FeUQac28/8CRICcaJV0LZtM6xgFADpef6PR/n8Jrzvqv0bwOf
         wd+hiSjHRpeYaLGA4QxVXzniijjtjhDNOM6QtDhX7d6NnrjKJuGcKC+mPf3+8ralih
         TfAt5h6ct1/i5yFTxJgrC5LTMXUMqkFJ5Y2JGbfKlEsE9cXGY9pTcTdABSXDV1V7vO
         YOB1ThJJ3HKOinvpdBb4XZJx/bUiuxDG6ebclEwnyOgxEs4JdmhmRGjGPUDRThYGB1
         gkMBGJ6n/0ZKz2PMWEc1+e1g=
Date:   Thu, 8 Sep 2022 01:11:09 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH v2] Documentation: remove magic number doc
Message-ID: <20220907231109.htnfxzmr6wkuhn2v@tarta.nabijaczleweli.xyz>
References: <ae1e3abd-cafb-7059-b8ae-5bcb13d53b40@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fuyv3cdwendrckks"
Content-Disposition: inline
In-Reply-To: <ae1e3abd-cafb-7059-b8ae-5bcb13d53b40@gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fuyv3cdwendrckks
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The entire file blames back to the start of git
(minus whitespace from the RST translation and a typo fix):
  * there are changelog comments for March 1994 through to Linux 2.5.74
  * struct tty_ldisc is two pointers nowadays, so naturally no magic
  * GDA_MAGIC is defined but unused, and it's been this way
    since start-of-git
  * M3_CARD_MAGIC isn't defined, because
    commit d56b9b9c464a10ab1ee51a4c6190a2b57b8ef7a6 ("[PATCH] The
    scheduled removal of some OSS drivers")
    removed the entire driver in 2006
  * CS_CARD_MAGIC likewise since
    commit b5d425c97f7d4e92151167b01ca038e7853c6b37 ("more scheduled OSS
    driver removal") in 2007
  * KMALLOC_MAGIC and VMALLOC_MAGIC were removed in
    commit e38e0cfa48ac38f4fe24453d2523852467c95b21 ("[ALSA] Remove
    kmalloc wrappers"), six months after start of git
  * SLAB_C_MAGIC has never even appeared in git
    (removed in in 2.4.0-test3pre6)

At a glance, the only ones still in use are in code mostly untouched
since git (TTY, SLIP, SCSI (drivers/scsi/{arm/queue.c,ncr53c8xx.c}),
&c., but not PPP or PTY (neither exist now)).

A rough estimate of magic numbers in the kernel may be obtained via
  # git grep define | grep '_MAGIC\b' |
    grep -ve IOC  -e ^tools/ -e '_IO[(WR]' -e _SUPER | wc -l
  780
there is, of course, a few other meanings of magic here,
but a random sampling of SR_EEPROM_MAGIC, L2TP_TUNNEL_MAGIC,
and MD_SB_MAGIC showed they are all used like magic-number.rst describes
and are not in it

By all accounts, it seems magic-number.rst is a low-value historical
relic at best and misleading cruft at worst

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v2: better subject line, per Bagas Sanjaya
    problem list in message reworded for clarity

 Documentation/process/index.rst               |   1 -
 Documentation/process/magic-number.rst        | 154 -----------------
 .../translations/it_IT/process/index.rst      |   1 -
 .../it_IT/process/magic-number.rst            | 161 ------------------
 .../translations/zh_CN/process/index.rst      |   1 -
 .../zh_CN/process/magic-number.rst            | 144 ----------------
 .../translations/zh_TW/process/index.rst      |   1 -
 .../zh_TW/process/magic-number.rst            | 148 ----------------
 8 files changed, 611 deletions(-)
 delete mode 100644 Documentation/process/magic-number.rst
 delete mode 100644 Documentation/translations/it_IT/process/magic-number.r=
st
 delete mode 100644 Documentation/translations/zh_CN/process/magic-number.r=
st
 delete mode 100644 Documentation/translations/zh_TW/process/magic-number.r=
st

diff --git a/Documentation/process/index.rst b/Documentation/process/index.=
rst
index 2ba2a1582bbe..ae2201ae0acf 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -58,7 +58,6 @@ lack of a better place.
=20
    applying-patches
    adding-syscalls
-   magic-number
    volatile-considered-harmful
    botching-up-ioctls
    clang-format
diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
deleted file mode 100644
index f5ba36e96461..000000000000
--- a/Documentation/process/magic-number.rst
+++ /dev/null
@@ -1,154 +0,0 @@
-.. _magicnumbers:
-
-Linux magic numbers
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-This file is a registry of magic numbers which are in use.  When you
-add a magic number to a structure, you should also add it to this
-file, since it is best if the magic numbers used by various structures
-are unique.
-
-It is a **very** good idea to protect kernel data structures with magic
-numbers.  This allows you to check at run time whether (a) a structure
-has been clobbered, or (b) you've passed the wrong structure to a
-routine.  This last is especially useful --- particularly when you are
-passing pointers to structures via a void * pointer.  The tty code,
-for example, does this frequently to pass driver-specific and line
-discipline-specific structures back and forth.
-
-The way to use magic numbers is to declare them at the beginning of
-the structure, like so::
-
-	struct tty_ldisc {
-		int	magic;
-		...
-	};
-
-Please follow this discipline when you are adding future enhancements
-to the kernel!  It has saved me countless hours of debugging,
-especially in the screwy cases where an array has been overrun and
-structures following the array have been overwritten.  Using this
-discipline, these cases get detected quickly and safely.
-
-Changelog::
-
-					Theodore Ts'o
-					31 Mar 94
-
-  The magic table is current to Linux 2.1.55.
-
-					Michael Chastain
-					<mailto:mec@shout.net>
-					22 Sep 1997
-
-  Now it should be up to date with Linux 2.1.112. Because
-  we are in feature freeze time it is very unlikely that
-  something will change before 2.2.x. The entries are
-  sorted by number field.
-
-					Krzysztof G. Baranowski
-					<mailto: kgb@knm.org.pl>
-					29 Jul 1998
-
-  Updated the magic table to Linux 2.5.45. Right over the feature freeze,
-  but it is possible that some new magic numbers will sneak into the
-  kernel before 2.6.x yet.
-
-					Petr Baudis
-					<pasky@ucw.cz>
-					03 Nov 2002
-
-  Updated the magic table to Linux 2.5.74.
-
-					Fabian Frederick
-					<ffrederick@users.sourceforge.net>
-					09 Jul 2003
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-Magic Name            Number           Structure                File
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
-SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
-MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
-RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
-NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
-BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
-HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
-YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-
-Note that there are also defined special per-driver magic numbers in sound
-memory management. See ``include/sound/sndmagic.h`` for complete list of t=
hem. Many
-OSS sound drivers have their magic numbers constructed from the soundcard =
PCI
-ID - these are not listed here as well.
-
-HFS is another larger user of magic numbers - you can find them in
-``fs/hfs/hfs.h``.
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documenta=
tion/translations/it_IT/process/index.rst
index 8d4e36a07ff4..71adf53bc297 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -56,7 +56,6 @@ perch=C3=A9 non si =C3=A8 trovato un posto migliore.
=20
    applying-patches
    adding-syscalls
-   magic-number
    volatile-considered-harmful
    clang-format
    ../riscv/patch-acceptance
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
deleted file mode 100644
index f452fafb1e84..000000000000
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ /dev/null
@@ -1,161 +0,0 @@
-.. include:: ../disclaimer-ita.rst
-
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
-
-.. _it_magicnumbers:
-
-I numeri magici di Linux
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Questo documento =C3=A8 un registro dei numeri magici in uso.  Quando
-aggiungete un numero magico ad una struttura, dovreste aggiungerlo anche
-a questo documento; la cosa migliore =C3=A8 che tutti i numeri magici usati
-dalle varie strutture siano unici.
-
-=C3=88 **davvero** un'ottima idea proteggere le strutture dati del kernel =
con
-dei numeri magici.  Questo vi permette in fase d'esecuzione di (a) verific=
are
-se una struttura =C3=A8 stata malmenata, o (b) avete passato a una procedu=
ra la
-struttura errata.  Quest'ultimo =C3=A8 molto utile - particolarmente quand=
o si passa
-una struttura dati tramite un puntatore void \*.  Il codice tty, per esemp=
io,
-effettua questa operazione con regolarit=C3=A0 passando avanti e indietro =
le
-strutture specifiche per driver e discipline.
-
-Per utilizzare un numero magico, dovete dichiararlo all'inizio della strut=
tura
-dati, come di seguito::
-
-	struct tty_ldisc {
-		int	magic;
-		...
-	};
-
-Per favore, seguite questa direttiva quando aggiungerete migliorie al kern=
el!
-Mi ha risparmiato un numero illimitato di ore di debug, specialmente nei c=
asi
-pi=C3=B9 ostici dove si =C3=A8 andati oltre la dimensione di un vettore e =
la struttura
-dati che lo seguiva in memoria =C3=A8 stata sovrascritta.  Seguendo questa
-direttiva, questi casi vengono identificati velocemente e in sicurezza.
-
-Registro dei cambiamenti::
-
-					Theodore Ts'o
-					31 Mar 94
-
-  La tabella magica =C3=A8 aggiornata a Linux 2.1.55.
-
-					Michael Chastain
-					<mailto:mec@shout.net>
-					22 Sep 1997
-
-  Ora dovrebbe essere aggiornata a Linux 2.1.112. Dato che
-  siamo in un momento di congelamento delle funzionalit=C3=A0
-  (*feature freeze*) =C3=A8 improbabile che qualcosa cambi prima
-  della versione 2.2.x.  Le righe sono ordinate secondo il
-  campo numero.
-
-					Krzysztof G. Baranowski
-					<mailto: kgb@knm.org.pl>
-					29 Jul 1998
-
-  Aggiornamento della tabella a Linux 2.5.45. Giusti nel congelamento
-  delle funzionalit=C3=A0 ma =C3=A8 comunque possibile che qualche nuovo
-  numero magico s'intrufoli prima del kernel 2.6.x.
-
-					Petr Baudis
-					<pasky@ucw.cz>
-					03 Nov 2002
-
-  Aggiornamento della tabella magica a Linux 2.5.74.
-
-					Fabian Frederick
-					<ffrederick@users.sourceforge.net>
-					09 Jul 2003
-
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-Nome magico           Numero           Struttura                File
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
-SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
-MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
-RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
-NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
-BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
-HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
-YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-
-Da notare che ci sono anche dei numeri magici specifici per driver nel
-*sound memory management*. Consultate ``include/sound/sndmagic.h`` per una
-lista completa.  Molti driver audio OSS hanno i loro numeri magici costrui=
ti a
-partire dall'identificativo PCI della scheda audio - nemmeno questi sono
-elencati in questo file.
-
-Il file-system HFS =C3=A8 un altro grande utilizzatore di numeri magici - =
potete
-trovarli qui ``fs/hfs/hfs.h``.
diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documenta=
tion/translations/zh_CN/process/index.rst
index a683dbea0c83..e102e6a8fa45 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -51,7 +51,6 @@
 .. toctree::
    :maxdepth: 1
=20
-   magic-number
    volatile-considered-harmful
=20
 .. only::  subproject and html
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
deleted file mode 100644
index 42f0635ca70a..000000000000
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ /dev/null
@@ -1,144 +0,0 @@
-.. _cn_magicnumbers:
-
-.. include:: ../disclaimer-zh_CN.rst
-
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-
-=E5=A6=82=E6=9E=9C=E6=83=B3=E8=AF=84=E8=AE=BA=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=8C=E8=AF=B7=E7=9B=B4=E6=
=8E=A5=E5=8F=91=E4=BF=A1=E5=88=B0LKML=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=
=E4=BD=BF=E7=94=A8=E8=8B=B1=E6=96=87=E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=
=9A=BE=E7=9A=84=E8=AF=9D=EF=BC=8C=E4=B9=9F=E5=8F=AF
-=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85=
=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=BB=E8=AF=91=E6=
=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=97=B6=E6=88=96=E8=80=85=E7=BF=BB=E8=AF=
=91=E5=AD=98=E5=9C=A8=E9=97=AE=E9=A2=98=EF=BC=8C=E8=AF=B7=E8=81=94=E7=B3=BB=
=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85::
-
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85=EF=BC=9A =
=E8=B4=BE=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=BF=BB=E8=AF=91=E8=80=85=EF=BC=9A =
=E8=B4=BE=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E6=A0=A1=E8=AF=91=E8=80=85=EF=BC=9A =
=E8=B4=BE=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-
-Linux =E9=AD=94=E6=9C=AF=E6=95=B0
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E6=98=AF=E6=9C=89=E5=85=B3=E5=BD=93=
=E5=89=8D=E4=BD=BF=E7=94=A8=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E6=B3=A8=E5=
=86=8C=E8=A1=A8=E3=80=82=E5=BD=93=E4=BD=A0=E7=BB=99=E4=B8=80=E4=B8=AA=E7=BB=
=93=E6=9E=84=E6=B7=BB=E5=8A=A0=E4=BA=86=E4=B8=80=E4=B8=AA=E9=AD=94=E6=9C=AF=
=E5=80=BC=EF=BC=8C=E4=BD=A0=E4=B9=9F=E5=BA=94=E8=AF=A5=E6=8A=8A=E8=BF=99=E4=
=B8=AA=E9=AD=94=E6=9C=AF=E5=80=BC=E6=B7=BB=E5=8A=A0=E5=88=B0=E8=BF=99=E4=B8=
=AA=E6=96=87=E4=BB=B6=EF=BC=8C=E5=9B=A0=E4=B8=BA=E6=88=91=E4=BB=AC=E6=9C=80=
=E5=A5=BD=E6=8A=8A=E7=94=A8=E4=BA=8E=E5=90=84=E7=A7=8D=E7=BB=93=E6=9E=84=E7=
=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E7=BB=9F=E4=B8=80=E8=B5=B7=E6=9D=A5=E3=80=
=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E6=9C=AF=E5=80=BC=E6=9D=A5=E4=BF=9D=E6=8A=A4=
=E5=86=85=E6=A0=B8=E6=95=B0=E6=8D=AE=E7=BB=93=E6=9E=84=E6=98=AF=E4=B8=80=E4=
=B8=AA=E9=9D=9E=E5=B8=B8=E5=A5=BD=E7=9A=84=E4=B8=BB=E6=84=8F=E3=80=82=E8=BF=
=99=E5=B0=B1=E5=85=81=E8=AE=B8=E4=BD=A0=E5=9C=A8=E8=BF=90=E8=A1=8C=E6=9C=9F=
=E6=A3=80=E6=9F=A5(a)=E4=B8=80=E4=B8=AA=E7=BB=93=E6=9E=84=E6=98=AF=E5=90=A6=
=E5=B7=B2=E7=BB=8F=E8=A2=AB=E6=94=BB=E5=87=BB=EF=BC=8C=E6=88=96=E8=80=85(b)=
=E4=BD=A0=E5=B7=B2=E7=BB=8F=E7=BB=99=E4=B8=80=E4=B8=AA=E4=BE=8B=E8=A1=8C=E7=
=A8=8B=E5=BA=8F=E9=80=9A=E8=BF=87=E4=BA=86=E4=B8=80=E4=B8=AA=E9=94=99=E8=AF=
=AF=E7=9A=84=E7=BB=93=E6=9E=84=E3=80=82=E5=90=8E=E4=B8=80=E7=A7=8D=E6=83=85=
=E5=86=B5=E7=89=B9=E5=88=AB=E5=9C=B0=E6=9C=89=E7=94=A8---=E7=89=B9=E5=88=AB=
=E6=98=AF=E5=BD=93=E4=BD=A0=E9=80=9A=E8=BF=87=E4=B8=80=E4=B8=AA=E7=A9=BA=E6=
=8C=87=E9=92=88=E6=8C=87=E5=90=91=E7=BB=93=E6=9E=84=E4=BD=93=E7=9A=84=E6=97=
=B6=E5=80=99=E3=80=82tty=E6=BA=90=E7=A0=81=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=
=8C=E7=BB=8F=E5=B8=B8=E9=80=9A=E8=BF=87=E7=89=B9=E5=AE=9A=E9=A9=B1=E5=8A=A8=
=E4=BD=BF=E7=94=A8=E8=BF=99=E7=A7=8D=E6=96=B9=E6=B3=95=E5=B9=B6=E4=B8=94=E5=
=8F=8D=E5=A4=8D=E5=9C=B0=E6=8E=92=E5=88=97=E7=89=B9=E5=AE=9A=E6=96=B9=E9=9D=
=A2=E7=9A=84=E7=BB=93=E6=9E=84=E3=80=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E6=9C=AF=E5=80=BC=E7=9A=84=E6=96=B9=E6=B3=95=
=E6=98=AF=E5=9C=A8=E7=BB=93=E6=9E=84=E7=9A=84=E5=BC=80=E5=A7=8B=E5=A4=84=E5=
=A3=B0=E6=98=8E=E7=9A=84=EF=BC=8C=E5=A6=82=E4=B8=8B::
-
-        struct tty_ldisc {
-	        int	magic;
-        	...
-        };
-
-=E5=BD=93=E4=BD=A0=E4=BB=A5=E5=90=8E=E7=BB=99=E5=86=85=E6=A0=B8=E6=B7=BB=
=E5=8A=A0=E5=A2=9E=E5=BC=BA=E5=8A=9F=E8=83=BD=E7=9A=84=E6=97=B6=E5=80=99=EF=
=BC=8C=E8=AF=B7=E9=81=B5=E5=AE=88=E8=BF=99=E6=9D=A1=E8=A7=84=E5=88=99=EF=BC=
=81=E8=BF=99=E6=A0=B7=E5=B0=B1=E4=BC=9A=E8=8A=82=E7=9C=81=E6=95=B0=E4=B8=8D=
=E6=B8=85=E7=9A=84=E8=B0=83=E8=AF=95=E6=97=B6=E9=97=B4=EF=BC=8C=E7=89=B9=E5=
=88=AB=E6=98=AF=E4=B8=80=E4=BA=9B=E5=8F=A4=E6=80=AA=E7=9A=84=E6=83=85=E5=86=
=B5=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=8C=E6=95=B0=E7=BB=84=E8=B6=85=E5=87=BA=
=E8=8C=83=E5=9B=B4=E5=B9=B6=E4=B8=94=E9=87=8D=E6=96=B0=E5=86=99=E4=BA=86=E8=
=B6=85=E5=87=BA=E9=83=A8=E5=88=86=E3=80=82=E9=81=B5=E5=AE=88=E8=BF=99=E4=B8=
=AA=E8=A7=84=E5=88=99=EF=BC=8C=E2=80=AA=E8=BF=99=E4=BA=9B=E6=83=85=E5=86=B5=
=E5=8F=AF=E4=BB=A5=E8=A2=AB=E5=BF=AB=E9=80=9F=E5=9C=B0=EF=BC=8C=E5=AE=89=E5=
=85=A8=E5=9C=B0=E9=81=BF=E5=85=8D=E3=80=82
-
-		Theodore Ts'o
-		  31 Mar 94
-
-=E7=BB=99=E5=BD=93=E5=89=8D=E7=9A=84Linux 2.1.55=E6=B7=BB=E5=8A=A0=E9=AD=
=94=E6=9C=AF=E8=A1=A8=E3=80=82
-
-		Michael Chastain
-		<mailto:mec@shout.net>
-		22 Sep 1997
-
-=E7=8E=B0=E5=9C=A8=E5=BA=94=E8=AF=A5=E6=9C=80=E6=96=B0=E7=9A=84Linux 2.1.1=
12.=E5=9B=A0=E4=B8=BA=E5=9C=A8=E7=89=B9=E6=80=A7=E5=86=BB=E7=BB=93=E6=9C=9F=
=E9=97=B4=EF=BC=8C=E4=B8=8D=E8=83=BD=E5=9C=A82.2.x=E5=89=8D=E6=94=B9=E5=8F=
=98=E4=BB=BB=E4=BD=95=E4=B8=9C=E8=A5=BF=E3=80=82=E8=BF=99=E4=BA=9B=E6=9D=A1=
=E7=9B=AE=E8=A2=AB=E6=95=B0=E5=9F=9F=E6=89=80=E6=8E=92=E5=BA=8F=E3=80=82
-
-		Krzysztof G.Baranowski
-	        <mailto: kgb@knm.org.pl>
-		29 Jul 1998
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E6=9C=AF=E8=A1=A8=E5=88=B0Linux 2.5.45=E3=80=
=82=E5=88=9A=E5=A5=BD=E8=B6=8A=E8=BF=87=E7=89=B9=E6=80=A7=E5=86=BB=E7=BB=93=
=EF=BC=8C=E4=BD=86=E6=98=AF=E6=9C=89=E5=8F=AF=E8=83=BD=E8=BF=98=E4=BC=9A=E6=
=9C=89=E4=B8=80=E4=BA=9B=E6=96=B0=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E5=9C=
=A82.6.x=E4=B9=8B=E5=89=8D=E8=9E=8D=E5=85=A5=E5=88=B0=E5=86=85=E6=A0=B8=E4=
=B8=AD=E3=80=82
-
-		Petr Baudis
-		<pasky@ucw.cz>
-		03 Nov 2002
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E6=9C=AF=E8=A1=A8=E5=88=B0Linux 2.5.74=E3=80=82
-
-		Fabian Frederick
-                <ffrederick@users.sourceforge.net>
-		09 Jul 2003
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=E9=AD=94=E6=9C=AF=E6=95=B0=E5=90=8D              =E6=95=B0=E5=AD=97      =
       =E7=BB=93=E6=9E=84                     =E6=96=87=E4=BB=B6
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
-SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
-MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
-RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
-GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
-NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
-BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
-HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
-DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drivers/=
scsi/gdth.h``
-YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-
-
-=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=9C=A8=E5=A3=B0=E9=9F=B3=E8=AE=B0=
=E5=BF=86=E7=AE=A1=E7=90=86=E4=B8=AD=E4=BB=8D=E7=84=B6=E6=9C=89=E4=B8=80=E4=
=BA=9B=E7=89=B9=E6=AE=8A=E7=9A=84=E4=B8=BA=E6=AF=8F=E4=B8=AA=E9=A9=B1=E5=8A=
=A8=E5=AE=9A=E4=B9=89=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=E3=80=82=E6=9F=A5=
=E7=9C=8Binclude/sound/sndmagic.h=E6=9D=A5=E8=8E=B7=E5=8F=96=E4=BB=96=E4=BB=
=AC=E5=AE=8C=E6=95=B4=E7=9A=84=E5=88=97=E8=A1=A8=E4=BF=A1=E6=81=AF=E3=80=82=
=E5=BE=88=E5=A4=9AOSS=E5=A3=B0=E9=9F=B3=E9=A9=B1=E5=8A=A8=E6=8B=A5=E6=9C=89=
=E8=87=AA=E5=B7=B1=E4=BB=8E=E5=A3=B0=E5=8D=A1PCI ID=E6=9E=84=E5=BB=BA=E7=9A=
=84=E9=AD=94=E6=9C=AF=E5=80=BC-=E4=BB=96=E4=BB=AC=E4=B9=9F=E6=B2=A1=E6=9C=
=89=E8=A2=AB=E5=88=97=E5=9C=A8=E8=BF=99=E9=87=8C=E3=80=82
-
-IrDA=E5=AD=90=E7=B3=BB=E7=BB=9F=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E6=9C=AF=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E6=9D=A5=E8=8E=B7=E5=8F=
=96=E4=BB=96=E4=BB=AC=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
-
-HFS=E6=98=AF=E5=8F=A6=E5=A4=96=E4=B8=80=E4=B8=AA=E6=AF=94=E8=BE=83=E5=A4=
=A7=E7=9A=84=E4=BD=BF=E7=94=A8=E9=AD=94=E6=9C=AF=E5=80=BC=E7=9A=84=E6=96=87=
=E4=BB=B6=E7=B3=BB=E7=BB=9F-=E4=BD=A0=E5=8F=AF=E4=BB=A5=E5=9C=A8fs/hfs/hfs.=
h=E4=B8=AD=E6=89=BE=E5=88=B0=E4=BB=96=E4=BB=AC=E3=80=82
diff --git a/Documentation/translations/zh_TW/process/index.rst b/Documenta=
tion/translations/zh_TW/process/index.rst
index c5c59b4fd595..cb3dea0b78ab 100644
--- a/Documentation/translations/zh_TW/process/index.rst
+++ b/Documentation/translations/zh_TW/process/index.rst
@@ -54,7 +54,6 @@
 .. toctree::
    :maxdepth: 1
=20
-   magic-number
    volatile-considered-harmful
=20
 .. only::  subproject and html
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Do=
cumentation/translations/zh_TW/process/magic-number.rst
deleted file mode 100644
index ae321a9aaece..000000000000
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ /dev/null
@@ -1,148 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-.. _tw_magicnumbers:
-
-.. include:: ../disclaimer-zh_TW.rst
-
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
-
-=E5=A6=82=E6=9E=9C=E6=83=B3=E8=A9=95=E8=AB=96=E6=88=96=E6=9B=B4=E6=96=B0=
=E6=9C=AC=E6=96=87=E7=9A=84=E5=85=A7=E5=AE=B9=EF=BC=8C=E8=AB=8B=E7=9B=B4=E6=
=8E=A5=E7=99=BC=E4=BF=A1=E5=88=B0LKML=E3=80=82=E5=A6=82=E6=9E=9C=E4=BD=A0=
=E4=BD=BF=E7=94=A8=E8=8B=B1=E6=96=87=E4=BA=A4=E6=B5=81=E6=9C=89=E5=9B=B0=E9=
=9B=A3=E7=9A=84=E8=A9=B1=EF=BC=8C=E4=B9=9F=E5=8F=AF
-=E4=BB=A5=E5=90=91=E4=B8=AD=E6=96=87=E7=89=88=E7=B6=AD=E8=AD=B7=E8=80=85=
=E6=B1=82=E5=8A=A9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E7=BF=BB=E8=AD=AF=E6=
=9B=B4=E6=96=B0=E4=B8=8D=E5=8F=8A=E6=99=82=E6=88=96=E8=80=85=E7=BF=BB=E8=AD=
=AF=E5=AD=98=E5=9C=A8=E5=95=8F=E9=A1=8C=EF=BC=8C=E8=AB=8B=E8=81=AF=E7=B9=AB=
=E4=B8=AD=E6=96=87=E7=89=88=E7=B6=AD=E8=AD=B7=E8=80=85::
-
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=B6=AD=E8=AD=B7=E8=80=85=EF=BC=9A =
=E8=B3=88=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E7=BF=BB=E8=AD=AF=E8=80=85=EF=BC=9A =
=E8=B3=88=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-        =E4=B8=AD=E6=96=87=E7=89=88=E6=A0=A1=E8=AD=AF=E8=80=85=EF=BC=9A =
=E8=B3=88=E5=A8=81=E5=A8=81 Jia Wei Wei <harryxiyou@gmail.com>
-                      =E8=83=A1=E7=9A=93=E6=96=87 Hu Haowen <src.res@email=
=2Ecn>
-
-Linux =E9=AD=94=E8=A1=93=E6=95=B8
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-=E9=80=99=E5=80=8B=E6=96=87=E4=BB=B6=E6=98=AF=E6=9C=89=E9=97=9C=E7=95=B6=
=E5=89=8D=E4=BD=BF=E7=94=A8=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E8=A8=BB=E5=
=86=8A=E8=A1=A8=E3=80=82=E7=95=B6=E4=BD=A0=E7=B5=A6=E4=B8=80=E5=80=8B=E7=B5=
=90=E6=A7=8B=E6=B7=BB=E5=8A=A0=E4=BA=86=E4=B8=80=E5=80=8B=E9=AD=94=E8=A1=93=
=E5=80=BC=EF=BC=8C=E4=BD=A0=E4=B9=9F=E6=87=89=E8=A9=B2=E6=8A=8A=E9=80=99=E5=
=80=8B=E9=AD=94=E8=A1=93=E5=80=BC=E6=B7=BB=E5=8A=A0=E5=88=B0=E9=80=99=E5=80=
=8B=E6=96=87=E4=BB=B6=EF=BC=8C=E5=9B=A0=E7=88=B2=E6=88=91=E5=80=91=E6=9C=80=
=E5=A5=BD=E6=8A=8A=E7=94=A8=E6=96=BC=E5=90=84=E7=A8=AE=E7=B5=90=E6=A7=8B=E7=
=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E7=B5=B1=E4=B8=80=E8=B5=B7=E4=BE=86=E3=80=
=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E8=A1=93=E5=80=BC=E4=BE=86=E4=BF=9D=E8=AD=B7=
=E5=85=A7=E6=A0=B8=E6=95=B8=E6=93=9A=E7=B5=90=E6=A7=8B=E6=98=AF=E4=B8=80=E5=
=80=8B=E9=9D=9E=E5=B8=B8=E5=A5=BD=E7=9A=84=E4=B8=BB=E6=84=8F=E3=80=82=E9=80=
=99=E5=B0=B1=E5=85=81=E8=A8=B1=E4=BD=A0=E5=9C=A8=E9=81=8B=E8=A1=8C=E6=9C=9F=
=E6=AA=A2=E6=9F=A5(a)=E4=B8=80=E5=80=8B=E7=B5=90=E6=A7=8B=E6=98=AF=E5=90=A6=
=E5=B7=B2=E7=B6=93=E8=A2=AB=E6=94=BB=E6=93=8A=EF=BC=8C=E6=88=96=E8=80=85(b)=
=E4=BD=A0=E5=B7=B2=E7=B6=93=E7=B5=A6=E4=B8=80=E5=80=8B=E4=BE=8B=E8=A1=8C=E7=
=A8=8B=E5=BA=8F=E9=80=9A=E9=81=8E=E4=BA=86=E4=B8=80=E5=80=8B=E9=8C=AF=E8=AA=
=A4=E7=9A=84=E7=B5=90=E6=A7=8B=E3=80=82=E5=BE=8C=E4=B8=80=E7=A8=AE=E6=83=85=
=E6=B3=81=E7=89=B9=E5=88=A5=E5=9C=B0=E6=9C=89=E7=94=A8---=E7=89=B9=E5=88=A5=
=E6=98=AF=E7=95=B6=E4=BD=A0=E9=80=9A=E9=81=8E=E4=B8=80=E5=80=8B=E7=A9=BA=E6=
=8C=87=E9=87=9D=E6=8C=87=E5=90=91=E7=B5=90=E6=A7=8B=E9=AB=94=E7=9A=84=E6=99=
=82=E5=80=99=E3=80=82tty=E6=BA=90=E7=A2=BC=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=
=8C=E7=B6=93=E5=B8=B8=E9=80=9A=E9=81=8E=E7=89=B9=E5=AE=9A=E9=A9=85=E5=8B=95=
=E4=BD=BF=E7=94=A8=E9=80=99=E7=A8=AE=E6=96=B9=E6=B3=95=E4=B8=A6=E4=B8=94=E5=
=8F=8D=E8=A6=86=E5=9C=B0=E6=8E=92=E5=88=97=E7=89=B9=E5=AE=9A=E6=96=B9=E9=9D=
=A2=E7=9A=84=E7=B5=90=E6=A7=8B=E3=80=82
-
-=E4=BD=BF=E7=94=A8=E9=AD=94=E8=A1=93=E5=80=BC=E7=9A=84=E6=96=B9=E6=B3=95=
=E6=98=AF=E5=9C=A8=E7=B5=90=E6=A7=8B=E7=9A=84=E9=96=8B=E5=A7=8B=E8=99=95=E8=
=81=B2=E6=98=8E=E7=9A=84=EF=BC=8C=E5=A6=82=E4=B8=8B::
-
-        struct tty_ldisc {
-	        int	magic;
-        	...
-        };
-
-=E7=95=B6=E4=BD=A0=E4=BB=A5=E5=BE=8C=E7=B5=A6=E5=85=A7=E6=A0=B8=E6=B7=BB=
=E5=8A=A0=E5=A2=9E=E5=BC=B7=E5=8A=9F=E8=83=BD=E7=9A=84=E6=99=82=E5=80=99=EF=
=BC=8C=E8=AB=8B=E9=81=B5=E5=AE=88=E9=80=99=E6=A2=9D=E8=A6=8F=E5=89=87=EF=BC=
=81=E9=80=99=E6=A8=A3=E5=B0=B1=E6=9C=83=E7=AF=80=E7=9C=81=E6=95=B8=E4=B8=8D=
=E6=B8=85=E7=9A=84=E8=AA=BF=E8=A9=A6=E6=99=82=E9=96=93=EF=BC=8C=E7=89=B9=E5=
=88=A5=E6=98=AF=E4=B8=80=E4=BA=9B=E5=8F=A4=E6=80=AA=E7=9A=84=E6=83=85=E6=B3=
=81=EF=BC=8C=E4=BE=8B=E5=A6=82=EF=BC=8C=E6=95=B8=E7=B5=84=E8=B6=85=E5=87=BA=
=E7=AF=84=E5=9C=8D=E4=B8=A6=E4=B8=94=E9=87=8D=E6=96=B0=E5=AF=AB=E4=BA=86=E8=
=B6=85=E5=87=BA=E9=83=A8=E5=88=86=E3=80=82=E9=81=B5=E5=AE=88=E9=80=99=E5=80=
=8B=E8=A6=8F=E5=89=87=EF=BC=8C=E2=80=AA=E9=80=99=E4=BA=9B=E6=83=85=E6=B3=81=
=E5=8F=AF=E4=BB=A5=E8=A2=AB=E5=BF=AB=E9=80=9F=E5=9C=B0=EF=BC=8C=E5=AE=89=E5=
=85=A8=E5=9C=B0=E9=81=BF=E5=85=8D=E3=80=82
-
-		Theodore Ts'o
-		  31 Mar 94
-
-=E7=B5=A6=E7=95=B6=E5=89=8D=E7=9A=84Linux 2.1.55=E6=B7=BB=E5=8A=A0=E9=AD=
=94=E8=A1=93=E8=A1=A8=E3=80=82
-
-		Michael Chastain
-		<mailto:mec@shout.net>
-		22 Sep 1997
-
-=E7=8F=BE=E5=9C=A8=E6=87=89=E8=A9=B2=E6=9C=80=E6=96=B0=E7=9A=84Linux 2.1.1=
12.=E5=9B=A0=E7=88=B2=E5=9C=A8=E7=89=B9=E6=80=A7=E5=87=8D=E7=B5=90=E6=9C=9F=
=E9=96=93=EF=BC=8C=E4=B8=8D=E8=83=BD=E5=9C=A82.2.x=E5=89=8D=E6=94=B9=E8=AE=
=8A=E4=BB=BB=E4=BD=95=E6=9D=B1=E8=A5=BF=E3=80=82=E9=80=99=E4=BA=9B=E6=A2=9D=
=E7=9B=AE=E8=A2=AB=E6=95=B8=E5=9F=9F=E6=89=80=E6=8E=92=E5=BA=8F=E3=80=82
-
-		Krzysztof G.Baranowski
-	        <mailto: kgb@knm.org.pl>
-		29 Jul 1998
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E8=A1=93=E8=A1=A8=E5=88=B0Linux 2.5.45=E3=80=
=82=E5=89=9B=E5=A5=BD=E8=B6=8A=E9=81=8E=E7=89=B9=E6=80=A7=E5=87=8D=E7=B5=90=
=EF=BC=8C=E4=BD=86=E6=98=AF=E6=9C=89=E5=8F=AF=E8=83=BD=E9=82=84=E6=9C=83=E6=
=9C=89=E4=B8=80=E4=BA=9B=E6=96=B0=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E5=9C=
=A82.6.x=E4=B9=8B=E5=89=8D=E8=9E=8D=E5=85=A5=E5=88=B0=E5=85=A7=E6=A0=B8=E4=
=B8=AD=E3=80=82
-
-		Petr Baudis
-		<pasky@ucw.cz>
-		03 Nov 2002
-
-=E6=9B=B4=E6=96=B0=E9=AD=94=E8=A1=93=E8=A1=A8=E5=88=B0Linux 2.5.74=E3=80=82
-
-		Fabian Frederick
-                <ffrederick@users.sourceforge.net>
-		09 Jul 2003
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-=E9=AD=94=E8=A1=93=E6=95=B8=E5=90=8D              =E6=95=B8=E5=AD=97      =
       =E7=B5=90=E6=A7=8B                     =E6=96=87=E4=BB=B6
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
-CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
-HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
-APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
-FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
-SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
-TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
-MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
-TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
-MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
-FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
-RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
-CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
-GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
-RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
-NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
-BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
-SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
-COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
-SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
-GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
-EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
-HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
-KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
-FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
-NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
-ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
-CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
-DPMEM_MAGIC           0xc0ffee11       gdt_pci_sram             ``drivers/=
scsi/gdth.h``
-YAM_MAGIC             0xF10A7654       yam_port                 ``drivers/=
net/hamradio/yam.c``
-CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
-QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
-QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
-NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-
-
-=E8=AB=8B=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=9C=A8=E8=81=B2=E9=9F=B3=E8=A8=98=
=E6=86=B6=E7=AE=A1=E7=90=86=E4=B8=AD=E4=BB=8D=E7=84=B6=E6=9C=89=E4=B8=80=E4=
=BA=9B=E7=89=B9=E6=AE=8A=E7=9A=84=E7=88=B2=E6=AF=8F=E5=80=8B=E9=A9=85=E5=8B=
=95=E5=AE=9A=E7=BE=A9=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=E3=80=82=E6=9F=A5=
=E7=9C=8Binclude/sound/sndmagic.h=E4=BE=86=E7=8D=B2=E5=8F=96=E4=BB=96=E5=80=
=91=E5=AE=8C=E6=95=B4=E7=9A=84=E5=88=97=E8=A1=A8=E4=BF=A1=E6=81=AF=E3=80=82=
=E5=BE=88=E5=A4=9AOSS=E8=81=B2=E9=9F=B3=E9=A9=85=E5=8B=95=E6=93=81=E6=9C=89=
=E8=87=AA=E5=B7=B1=E5=BE=9E=E9=9F=B3=E6=95=88=E5=8D=A1PCI ID=E6=A7=8B=E5=BB=
=BA=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC-=E4=BB=96=E5=80=91=E4=B9=9F=E6=B2=
=92=E6=9C=89=E8=A2=AB=E5=88=97=E5=9C=A8=E9=80=99=E8=A3=A1=E3=80=82
-
-IrDA=E5=AD=90=E7=B3=BB=E7=B5=B1=E4=B9=9F=E4=BD=BF=E7=94=A8=E4=BA=86=E5=A4=
=A7=E9=87=8F=E7=9A=84=E8=87=AA=E5=B7=B1=E7=9A=84=E9=AD=94=E8=A1=93=E5=80=BC=
=EF=BC=8C=E6=9F=A5=E7=9C=8Binclude/net/irda/irda.h=E4=BE=86=E7=8D=B2=E5=8F=
=96=E4=BB=96=E5=80=91=E5=AE=8C=E6=95=B4=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82
-
-HFS=E6=98=AF=E5=8F=A6=E5=A4=96=E4=B8=80=E5=80=8B=E6=AF=94=E8=BC=83=E5=A4=
=A7=E7=9A=84=E4=BD=BF=E7=94=A8=E9=AD=94=E8=A1=93=E5=80=BC=E7=9A=84=E6=96=87=
=E4=BB=B6=E7=B3=BB=E7=B5=B1-=E4=BD=A0=E5=8F=AF=E4=BB=A5=E5=9C=A8fs/hfs/hfs.=
h=E4=B8=AD=E6=89=BE=E5=88=B0=E4=BB=96=E5=80=91=E3=80=82
-
--=20
2.30.2

--fuyv3cdwendrckks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmMZJQ0ACgkQvP0LAY0m
WPEYdg//WEy9xsk88I0PLVU9M8RBKFF4Z7uNzxVM0WmzzVNaqn9JA/U4bSGI1R5r
xSWGLDEYPR9+nYuXfzecHjHdQvcmKMlD4NveGWNWr8AzN/Ibvntx9xbyYZXfHf+P
D1xeFOvjG5EGjONfm2P7CnKCZ+DFAPPGS7fdP0WahxysFR/aPdsG7uTC6HQb+8E+
JyMGUzP/wj9OVpV8wn57YgJyvz7WjWy0GqTd8Gj778VaUhTrQgkeTNTePz1Zl/je
acNP+yjYBpreQ6EJYcyJU4YL03+Gw6ijJggmHHeWNXWFd4FW1ICrmKitCGQIqAAy
NFhnGj9ajWmr9LX/OnMFrXTZIRdhvvikXSOvFScnRONHaK9RV9PrBZ1TmBV1GVao
GprpFuT8qtKL7CFUJGfmEVwqbLzULeLIN/zCXoNRrOmxEhTGpQtc0Mt/v5I2JcK2
xJf2RcBLBQWtd/wFsObOr1ziHRqLJTFD9xhttPCkyf2BPBdI8yZCoEKOKI0vZMwL
T39sH7BcoPqVCrFpwdUs7isg6+cxbndivt7bD5B0q1qYev9IJJquhDz4sHxFtkxT
gKvzT3fEAS+8lpDOFshZ4kCeUJPjLnzS4PYAW4RqhzAQ1OiNiwlYLniknh53nhPZ
JFu7NuETQ8Of8uet922P3B952gMejXSBg7E+tJbbv7ky4/MfOvc=
=MfYE
-----END PGP SIGNATURE-----

--fuyv3cdwendrckks--
