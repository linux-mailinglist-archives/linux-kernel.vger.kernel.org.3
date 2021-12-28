Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7C480981
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhL1NUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:20:17 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49222 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhL1NUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:20:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7FE681F38B;
        Tue, 28 Dec 2021 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640697614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bPRnzq8EZivJnYoZI2iyFj7x/Kpovbx4rPr7kOpPGyQ=;
        b=zBXO7yfV2+BDdJE5KoFTMkTwrm1QskblWd1O0ziFm0WIb8Pm223RfUc7Aqla+LeDMyv7dm
        K7aS3oCodKZ6K3I68HWz0ELyuhjVKqvKorvdBZGvduOn4YgPQGvjYuvQUEnFAUwvxrHHdH
        htb3v7z7chUtWLJaXdjPD/GlQPXhc4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640697614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bPRnzq8EZivJnYoZI2iyFj7x/Kpovbx4rPr7kOpPGyQ=;
        b=TiDEj+IrDFHGzkcg7IabwNIb48WRZ044DOdDKWIGPDGxzF639cKPNfpmv4IV02t2galmWU
        i0NR26ItgXAn9fAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64AAC13AE7;
        Tue, 28 Dec 2021 13:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vslEFw4Py2GOJAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 28 Dec 2021 13:20:14 +0000
Message-ID: <c9f80461-184a-c5e3-5b83-caf73eccd80a@suse.de>
Date:   Tue, 28 Dec 2021 14:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.296-rt229
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Language: en-US
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend from a different mail account. some dkim troubles]

Hello RT-list!

I'm pleased to announce the 4.4.296-rt229 stable release.
This is just an update to the latest stable release. No RT
specific changes.

Known issue:

   - locktorture reports a might_sleep warning for spin_locks test

You can get this release via the git tree at:

   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

   branch: v4.4-rt
   Head SHA1: e74cae7dec172a5ab396b493760686f629389a45

Signing key fingerprint:

   5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

Enjoy!
Daniel

Changes from v4.4.292-rt228:
---

Ahmad Fatoum (1):
       watchdog: f71808e_wdt: fix inaccurate report in WDIOC_GETTIMEOUT

Alan Young (1):
       ALSA: ctl: Fix copy of updated id with element read/write

Aleksander Jan Bajkowski (2):
       MIPS: lantiq: dma: add small delay after reset
       MIPS: lantiq: dma: reset correct number of channel

Alexander Aring (1):
       net: ieee802154: handle iftypes as u32

Alexander Mikhalitsyn (1):
       shm: extend forced shm destroy to support objects from several 
IPC nses

Anant Thazhemadam (1):
       media: usb: dvd-usb: fix uninit-value bug in 
dibusb_read_eeprom_byte()

Anatolij Gustschin (1):
       powerpc/5200: dts: fix memory node unit name

André Almeida (1):
       ACPI: battery: Accept charges over the design capacity as full

Andy Shevchenko (1):
       serial: 8250_dw: Drop wrong use of ACPI_PTR()

Anel Orazgaliyeva (1):
       cpuidle: Fix kobject memory leaks in error paths

Armin Wolf (1):
       hwmon: (dell-smm) Fix warning on /proc/i8k creation error

Arnd Bergmann (5):
       hyperv/vmbus: include linux/bitops.h
       ARM: 9136/1: ARMv7-M uses BE-8, not BE-32
       memstick: avoid out-of-range warning
       ARM: 9156/1: drop cc-option fallbacks for architecture selection
       siphash: use _unaligned version by default

Austin Kim (1):
       ALSA: synth: missing check for possible NULL after the call to 
kstrdup

Baokun Li (2):
       sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
       sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Barnabás Pőcze (1):
       platform/x86: wmi: do not fail if disabling fails

Bart Van Assche (1):
       MIPS: sni: Fix the build

Chengfeng Ye (2):
       nfc: pn533: Fix double free when pn533_fill_fragment_skbs() fails
       ALSA: gus: fix null pointer dereference on pointer block

Christian Löhle (1):
       mmc: dw_mmc: Dont wait for DRTO on Write RSP error

Christophe JAILLET (1):
       platform/x86: hp_accel: Fix an error handling path in 
'lis3lv02d_probe()'

Christophe Leroy (1):
       video: fbdev: chipsfb: use memset_io() instead of memset()

Claudiu Beznea (1):
       dmaengine: at_xdmac: fix AT_XDMAC_CC_PERID() macro

Damien Le Moal (1):
       libata: fix read log timeout value

Dan Carpenter (10):
       b43legacy: fix a lower bounds test
       b43: fix a lower bounds test
       memstick: jmb38x_ms: use appropriate free function in 
jmb38x_ms_alloc_host()
       drm/msm: uninitialized variable in msm_gem_import()
       usb: gadget: hid: fix error code in do_config()
       scsi: csiostor: Uninitialized data in csio_ln_vnp_read_cbfn()
       staging: rtl8192e: Fix use after free in _rtl92e_pci_disconnect()
       can: sja1000: fix use after free in ems_pcmcia_add_card()
       net: altera: set a couple error code in probe()
       net/qla3xxx: fix an error code in ql_adapter_up()

Daniel Jordan (1):
       crypto: pcrypt - Delay write to padata->info

Daniel Wagner (2):
       Merge tag 'v4.4.296' into v4.4-rt
       Linux 4.4.296-rt229

Daniele Palmas (2):
       USB: serial: option: add Telit LE910S1 0x9200 composition
       USB: serial: option: add Telit FN990 compositions

David Hildenbrand (1):
       proc/vmcore: fix clearing user buffer by properly using clear_user()

Davidlohr Bueso (1):
       block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)

Dirk Bender (1):
       media: mt9p031: Fix corrupted frame after restarting stream

Dongli Zhang (2):
       xen/netfront: stop tx queues during live migration
       vmxnet3: do not stop tx queues after netif_device_detach()

Dongliang Mu (2):
       JFS: fix memleak in jfs_mount
       memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe

Eiichi Tsukata (1):
       vsock: prevent unnecessary refcnt inc for nonblocking connect

Eric Badger (1):
       EDAC/sb_edac: Fix top-of-high-memory value for Broadwell/Haswell

Eric Biggers (3):
       wait: add wake_up_pollfree()
       binder: use wake_up_pollfree()
       signalfd: use wake_up_pollfree()

Eric Dumazet (3):
       llc: fix out-of-bound array index in llc_sk_dev_hash()
       tcp_cubic: fix spurious Hystart ACK train detections for 
not-cwnd-limited flows
       net, neigh: clear whole pneigh_entry at alloc time

Eric W. Biederman (1):
       signal: Remove the bogus sigkill_pending in ptrace_stop

Felix Fietkau (1):
       mac80211: send ADDBA requests using the tid/queue of the 
aggregation session

Filipe Manana (1):
       btrfs: fix lost error handling when replaying directory deletes

Florian Fainelli (2):
       ARM: dts: BCM5301X: Add interrupt properties to GPIO node
       net: systemport: Add global locking for descriptor lifecycle

Florian Westphal (1):
       netfilter: nfnetlink_queue: fix OOB when mac header was cleared

Giovanni Cabiddu (1):
       crypto: qat - detect PFVF collision after ACK

Greg Kroah-Hartman (13):
       Linux 4.4.293
       Linux 4.4.294
       HID: add hid_is_usb() function to make it simpler for USB detection
       HID: add USB_HID dependancy to hid-prodikeys
       HID: add USB_HID dependancy to hid-chicony
       HID: add USB_HID dependancy on some USB HID drivers
       HID: wacom: fix problems when device is not a valid USB device
       HID: check for valid USB device for many HID drivers
       USB: gadget: detect too-big endpoint 0 requests
       USB: gadget: zero allocate endpoint 0 buffers
       Linux 4.4.295
       USB: gadget: bRequestType is a bitfield, not a enum
       Linux 4.4.296

Guanghui Feng (1):
       tty: tty_buffer: Fix the softlockup issue in flush_to_ldisc

Guo Zhi (1):
       scsi: advansys: Fix kernel pointer leak

Hannes Reinecke (1):
       libata: add horkage for ASMedia 1092

Harshit Mogalapalli (1):
       net: netlink: af_netlink: Prevent empty skb by adding a check on len.

Helge Deller (3):
       parisc: Fix ptrace check on syscall return
       parisc: Fix "make install" on newer debian releases
       parisc/agp: Annotate parisc agp init functions with __init

Henrik Grimler (1):
       power: supply: max17042_battery: use VFSOC for capacity when no rsns

Huang Guobin (1):
       bonding: Fix a use-after-free problem when bond_sysfs_slave_add() 
failed

Ingmar Klein (1):
       PCI: Mark Atheros QCA6174 to avoid bus reset

J. Bruce Fields (1):
       nfsd: fix use-after-free due to delegation race

Jackie Liu (1):
       ARM: s3c: irq-s3c24xx: Fix return value check for s3c24xx_init_intc()

Jakob Hauser (1):
       power: supply: rt5033_battery: Change voltage values to µV

Jakub Kicinski (1):
       net: stream: don't purge sk_error_queue in sk_stream_kill_queues()

James Smart (1):
       scsi: lpfc: Fix list_add() corruption in lpfc_drain_txq()

Jan Kara (1):
       ocfs2: fix data corruption on truncate

Jason Gerecke (1):
       HID: introduce hid_is_using_ll_driver

Jens Axboe (1):
       fs: add fget_many() and fput_many()

Jerome Marchand (1):
       recordmcount.pl: look for jgnop instruction as well as bcrl on s390

Joakim Zhang (1):
       net: fec: only clear interrupt of handling queue in 
fec_enet_rx_queue()

Joe Thornber (1):
       dm btree remove: fix use after free in rebalance_children()

Johan Hovold (9):
       ALSA: ua101: fix division by zero at probe
       ALSA: 6fire: fix control and bulk message timeouts
       ALSA: line6: fix control and interrupt message timeouts
       mwifiex: fix division by zero in fw download path
       ath6kl: fix division by zero in send path
       ath6kl: fix control-message timeout
       USB: iowarrior: fix control-message timeouts
       USB: chipidea: fix interrupt deadlock
       drm/udl: fix control-message timeout

Johannes Berg (1):
       iwlwifi: mvm: disable RX-diversity in powersave

Jonas Dreßler (2):
       mwifiex: Read a PCI register after writing the TX ring write pointer
       mwifiex: Send DELBA requests according to spec

Juergen Gross (13):
       xen: sync include/xen/interface/io/ring.h with Xen's newest version
       xen/blkfront: read response from backend only once
       xen/blkfront: don't take local copy of a request from the ring page
       xen/blkfront: don't trust the backend response data blindly
       xen/netfront: read response from backend only once
       xen/netfront: don't read data from request on the ring page
       xen/netfront: disentangle tx_skb_freelist
       xen/netfront: don't trust the backend response data blindly
       tty: hvc: replace BUG_ON() with negative return value
       xen/blkfront: harden blkfront against event channel storms
       xen/netfront: harden netfront against event channel storms
       xen/console: harden hvc_xen against event channel storms
       xen/netback: don't queue unlimited number of packages

Kees Cook (1):
       media: si470x: Avoid card name truncation

Krzysztof Kozlowski (1):
       nfc: fix potential NULL pointer deref in nfc_genl_dump_ses_done

Lars-Peter Clausen (4):
       iio: stk3310: Don't return error code in interrupt handler
       iio: mma8452: Fix trigger reference couting
       iio: ltr501: Don't return error code in trigger handler
       iio: itg3200: Call iio_trigger_notify_done() on error

Lasse Collin (2):
       lib/xz: Avoid overlapping memcpy() with invalid input with 
in-place decompression
       lib/xz: Validate the value before assigning it to an enum variable

Lee Jones (2):
       staging: ion: Prevent incorrect reference counting behavour
       net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero

Leon Romanovsky (1):
       RDMA/mlx4: Return missed an error if device doesn't support steering

Letu Ren (1):
       igbvf: fix double free in `igbvf_probe`

Lin Ma (3):
       NFC: reorganize the functions in nci_request
       NFC: reorder the logic in nfc_{un,}register_device
       NFC: add NCI_UNREG flag to eliminate the race

Linus Lüssing (5):
       ath9k: Fix potential interrupt storm on queue reset
       batman-adv: Fix multicast TT issues with bogus ROAM flags
       batman-adv: mcast: fix duplicate mcast packets in BLA backbone 
from LAN
       batman-adv: mcast: fix duplicate mcast packets in BLA backbone 
from mesh
       batman-adv: mcast: fix duplicate mcast packets from BLA backbone 
to mesh

Linus Torvalds (1):
       fget: check that the fd still exists after getting a ref to it

Loic Poulain (1):
       wcn36xx: Fix HT40 capability for 2Ghz band

Lu Wei (1):
       maple: fix wrong return value of maple_bus_init().

Maciej W. Rozycki (1):
       vgacon: Propagate console boot parameters before calling `vc_resize'

Manjong Lee (1):
       mm: bdi: initialize bdi_min_ratio when bdi is unregistered

Masami Hiramatsu (2):
       ARM: clang: Do not rely on lr register for stacktrace
       kprobes: Limit max data_size of the kretprobe instances

Mathias Nyman (3):
       xhci: Fix USB 3.1 enumeration issues by increasing roothub 
power-on-good delay
       usb: hub: Fix usb enumeration issue due to address0 race
       usb: hub: Fix locking issues with address0_mutex

Maxim Kiselev (1):
       net: davinci_emac: Fix interrupt pacing disable

Michael Ellerman (1):
       powerpc/dcr: Use cmplwi instead of 3-argument cmpli

Mike Christie (3):
       scsi: target: Fix ordered tag handling
       scsi: target: Fix alua_tg_pt_gps_count tracking
       scsi: iscsi: Unblock session then wake up error handler

Mike Kravetz (1):
       hugetlb: take PMD sharing into account when flushing tlb/caches

Miklos Szeredi (2):
       fuse: fix page stealing
       fuse: release pipe buf after last use

Mingjie Zhang (1):
       USB: serial: option: add Fibocom FM101-GL variants

Nadav Amit (1):
       hugetlbfs: flush TLBs correctly after huge_pmd_unshare

Nathan Chancellor (5):
       platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
       hexagon: export raw I/O routines for modules
       soc/tegra: fuse: Fix bitwise vs. logical OR warning
       net: lan78xx: Avoid unnecessary self assignment
       Input: touchscreen - avoid bitwise vs logical OR warning

Nguyen Dinh Phi (1):
       cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

Nick Desaulniers (1):
       sh: check return code of request_irq

Nicolas Dichtel (1):
       tun: fix bonding active backup with arp monitoring

Nicolas Pitre (1):
       ARM: 8805/2: remove unneeded naked function usage

Nikolay Borisov (1):
       btrfs: fix memory ordering between normal and ordered work functions

Ondrej Jirman (1):
       i2c: rk3x: Handle a spurious start completion interrupt flag

Pali Rohár (1):
       PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros

Pavel Hofman (1):
       usb: core: config: fix validation of wMaxPacketValue entries

Pavel Skripkin (4):
       ALSA: mixer: fix deadlock in snd_mixer_oss_set_volume
       media: dvb-usb: fix ununit-value in az6027_rc_query
       net: batman-adv: fix error handling
       net: bnx2x: fix variable dereferenced before check

Pawan Gupta (1):
       smackfs: Fix use-after-free in netlbl_catmap_walk()

Pekka Korpinen (1):
       iio: dac: ad5446: Fix ad5622_write() return value

Peter Zijlstra (1):
       x86: Increase exception stack sizes

Phoenix Huang (1):
       Input: elantench - fix misreporting trackpoint coordinates

Pierre Gondois (1):
       serial: pl011: Add ACPI SBSA UART match id

Quinn Tran (1):
       scsi: qla2xxx: Turn off target reset during issue_lip

Rafael J. Wysocki (1):
       ACPICA: Avoid evaluating methods too early during system resume

Rajat Asthana (1):
       media: mceusb: return without resubmitting URB in case of -EPROTO 
error.

Randy Dunlap (8):
       mmc: winbond: don't build on M68K
       ia64: don't do IA64_CMPXCHG_DEBUG without CONFIG_PRINTK
       m68k: set a default value for MEMORY_RESERVE
       sh: fix kconfig unmet dependency warning for FRAME_POINTER
       sh: define __BIG_ENDIAN for math-emu
       mips: BCM63XX: ensure that CPU_SUPPORTS_32BIT_KERNEL is set
       mips: bcm63xx: add support for clk_get_parent()
       natsemi: xtensa: fix section mismatch warnings

Ricardo Ribalda (1):
       media: uvcvideo: Set capability in s_param

Roger Quadros (1):
       ARM: dts: omap: fix gpmc,mux-add-data type

Rustam Kovhaev (1):
       mm: kmemleak: slob: respect SLAB_NOLEAKTRACE flag

Sean Christopherson (1):
       x86/irq: Ensure PI wakeup handler is unregistered before module 
unload

Sean Young (1):
       media: ite-cir: IR receiver stop working after receive overflow

Sebastian Krzyszkowiak (1):
       power: supply: max17042_battery: Prevent int underflow in 
set_soc_threshold

Slark Xiao (1):
       platform/x86: thinkpad_acpi: Fix WWAN device disabled issue after 
S3 deep

Sreekanth Reddy (1):
       scsi: mpt3sas: Fix kernel panic during drive powercycle test

Stefano Stabellini (2):
       xen: don't continue xenstore initialization in case of errors
       xen: detect uninitialized xenbus in xenbus_init

Steven Rostedt (VMware) (4):
       tracefs: Have tracefs directories not set OTH permission bits by 
default
       tracing: Check pid filtering when creating events
       tracefs: Have new files inherit the ownership of their parent
       tracefs: Set all files to the same group ownership as the mount 
option

Sven Eckelmann (7):
       batman-adv: Keep fragments equally sized
       batman-adv: Prevent duplicated softif_vlan entry
       batman-adv: Consider fragmentation for needed_headroom
       batman-adv: Reserve needed_*room for fragments
       batman-adv: Don't always reallocate the fragmentation skb head
       batman-adv: Avoid WARN_ON timing related checks
       tty: serial: msm_serial: Deactivate RX DMA for polling support

Sven Schnelle (4):
       parisc: fix warning in flush_tlb_all
       parisc/kgdb: add kgdb_roundup() to make kgdb work with idle polling
       parisc/entry: fix trace test in syscall exit path
       parisc/sticon: fix reverse colors

Tadeusz Struk (1):
       nfc: fix segfault in nfc_genl_dump_devices_done

Taehee Yoo (1):
       batman-adv: set .owner to THIS_MODULE

Takashi Iwai (11):
       Input: i8042 - Add quirk for Fujitsu Lifebook T725
       ALSA: timer: Unconditionally unlink slave instances, too
       ALSA: mixer: oss: Fix racy access to slots
       Bluetooth: sco: Fix lock_sock() blockage by memcpy_from_msg()
       ASoC: DAPM: Cover regression by kctl change notification fix
       ALSA: ctxfi: Fix out-of-range access
       ASoC: topology: Add missing rwsem around snd_ctl_remove() calls
       ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
       ALSA: pcm: oss: Fix negative period/buffer sizes
       ALSA: pcm: oss: Limit the period size to 16MB
       ALSA: pcm: oss: Handle missing errors in snd_pcm_oss_change_params*()

Teng Qi (1):
       net: ethernet: dec: tulip: de4x5: fix possible array overflows in 
type3_infoblock()

Tetsuo Handa (2):
       smackfs: use __GFP_NOFAIL for smk_cipso_doi()
       smackfs: use netlbl_cfg_cipsov4_del() for deleting cipso_v4_doi

Thomas Gleixner (2):
       PCI/MSI: Destroy sysfs before freeing entries
       PCI/MSI: Clear PCI_MSIX_FLAGS_MASKALL on error

Thomas Perrot (1):
       spi: spl022: fix Microwire full duplex mode

Todd Kjos (3):
       binder: use euid from cred instead of using task
       binder: use cred instead of task for selinux checks
       binder: fix test regression due to sender_euid change

Tong Zhang (1):
       scsi: dc395: Fix error case unwinding

Trond Myklebust (1):
       NFSv42: Don't fail clone() unless the OP_CLONE operation failed

Tuo Li (2):
       media: s5p-mfc: fix possible null-pointer dereference in 
s5p_mfc_probe()
       ath: dfs_pattern_detector: Fix possible null-pointer dereference 
in channel_detector_create()

Uwe Kleine-König (1):
       usb: max-3421: Use driver data instead of maintaining a list of 
bound devices

Vasily Averin (1):
       mm, oom: pagefault_out_of_memory: don't force global OOM for 
dying tasks

Vasily Gorbik (1):
       s390/setup: avoid using memblock_enforce_memory_limit

Vincent Donnefort (1):
       sched/core: Mitigate race 
cpus_share_cache()/update_top_cache_domain()

Vincent Mailhol (1):
       can: pch_can: pch_can_rx_normal: fix use after free

Vladimir Murzin (1):
       irqchip: nvic: Fix offset for Interrupt Priority Offsets

Wang Hai (3):
       USB: serial: keyspan: fix memleak on probe errors
       libertas_tf: Fix possible memory leak in probe and disconnect
       libertas: Fix possible memory leak in probe and disconnect

Wang ShaoBo (1):
       Bluetooth: fix use-after-free error in lock_sock_nested()

Wang Wensheng (1):
       ALSA: timer: Fix use-after-free problem

Wudi Wang (1):
       irqchip/irq-gic-v3-its.c: Force synchronisation when issuing INVALL

Yang Yingliang (3):
       usb: musb: tusb6010: check return value after calling 
platform_get_resource()
       usb: host: ohci-tmio: check return value after calling 
platform_get_resource()
       iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove

Ye Bin (1):
       PM: hibernate: Get block device exclusively in swsusp_check()

Yu Liao (1):
       timekeeping: Really make sure wall_to_monotonic isn't positive

YueHaibing (1):
       xen-pciback: Fix return in pm_ctrl_init()

Zev Weiss (1):
       hwmon: (pmbus/lm25066) Add offset coefficients

Zhang Yi (2):
       quota: check block number when reading the block in quota file
       quota: correct error number in free_dqentry()

Zheyu Ma (3):
       media: netup_unidvb: handle interrupt properly according to the 
firmware
       memstick: r592: Fix a UAF bug when removing the driver
       mwl8k: Fix use-after-free in mwl8k_fw_state_machine()

Zhou Qingyang (1):
       net: qlogic: qlcnic: Fix a NULL pointer dereference in 
qlcnic_83xx_add_rings()

hongao (1):
       drm/amdgpu: fix set scaling mode Full/Full aspect/Center not 
works on vga and dvi connectors

liuguoqiang (1):
       net: return correct error code

zhangyue (1):
       net: tulip: de4x5: fix the problem that the array 'lp->phy[8]' 
may be out of bound
