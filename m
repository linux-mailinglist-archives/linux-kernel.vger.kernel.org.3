Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853A848F177
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiANUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:34:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51540 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiANUd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:33:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C41C5B82A34;
        Fri, 14 Jan 2022 20:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C32C36AE9;
        Fri, 14 Jan 2022 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642192431;
        bh=16cgM8sUwmPBqplAG6n0hDhSceqi44Q7vjxTVp/szK4=;
        h=Date:From:To:Cc:Subject:From;
        b=W62W8+co9/a25tXYECF2YG8zH0xX9sJiYmKbqJOvB+fUX/V1EzDut7+Ox6wabyp3/
         e4+IMsbAWyQj6HmEa8Rsu72Qja5PxPH1AK6Yuv4YN8w/+jq11nf5WoVTSzC20E3+MX
         MevKMBx9DFZto3bdO8EDkNbVpc2UjS+hwaOj4mP7hln79h/I8eZKphpDrqNlml5/Qc
         ao+UyhYfjm2kk8mXP9wVP7PQBaXffOhtjf6CJVM0Bjeh/VP18LUjn8lLVBcU3WLi4H
         mo57eB550xRJd1DIpibqGTB0KkKbPn6XxslQsZ7gugTHJ+jirvRdEn5HgGYKkeWxHW
         XEUGDjItPMGWQ==
Date:   Fri, 14 Jan 2022 12:33:49 -0800
From:   Mark Gross <markgross@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     markgross@kernel.org
Subject: [ANNOUNCE] 4.9.297-rt191
Message-ID: <164219233946.128752.6195986993321784852@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.297-rt191 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt-rebase
  Head SHA1: 4d49d6277e3c017d79a8b7528bda52927da4895f

Or to build 4.9.297-rt191 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.297.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.297-rt191.patch.xz


You can also build from 4.9.291-rt190 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.291-rt190-rt191.patch.xz

Enjoy!
Mark Gross

Changes from v4.9.291-rt190:
---

Alan Young (1):
      ALSA: ctl: Fix copy of updated id with element read/write

Alexander Aring (1):
      net: ieee802154: handle iftypes as u32

Alexander Mikhalitsyn (1):
      shm: extend forced shm destroy to support objects from several IPC nses

Alexey Makhalov (1):
      scsi: vmw_pvscsi: Set residual data length conditionally

Andrew Cooper (1):
      x86/pkey: Fix undefined behaviour with PKRU_WD_BIT

Ard Biesheuvel (1):
      ARM: 9169/1: entry: fix Thumb2 bug in iWMMXt exception handling

Armin Wolf (1):
      hwmon: (dell-smm) Fix warning on /proc/i8k creation error

Arnd Bergmann (1):
      siphash: use _unaligned version by default

Baokun Li (2):
      sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
      sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Benjamin Coddington (1):
      NFSv42: Fix pagecache invalidation after COPY/CLONE

Benjamin Tissoires (1):
      HID: holtek: fix mouse probing

Chen Jun (1):
      tracing: Fix a kmemleak false positive in tracing_map

Colin Ian King (1):
      ALSA: drivers: opl3: Fix incorrect use of vp->state

Cyril Novikov (1):
      ixgbe: set X550 MDIO speed before talking to PHY

Dan Carpenter (5):
      staging: rtl8192e: Fix use after free in _rtl92e_pci_disconnect()
      drm/vc4: fix error code in vc4_create_object()
      can: sja1000: fix use after free in ems_pcmcia_add_card()
      net: altera: set a couple error code in probe()
      net/qla3xxx: fix an error code in ql_adapter_up()

Daniele Palmas (2):
      USB: serial: option: add Telit LE910S1 0x9200 composition
      USB: serial: option: add Telit FN990 compositions

Darrick J. Wong (1):
      xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP just like fallocate

David Hildenbrand (1):
      proc/vmcore: fix clearing user buffer by properly using clear_user()

Davidlohr Bueso (1):
      block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)

Dmitry V. Levin (1):
      uapi: fix linux/nfc.h userspace compilation errors

Eric Biggers (3):
      wait: add wake_up_pollfree()
      binder: use wake_up_pollfree()
      signalfd: use wake_up_pollfree()

Eric Dumazet (3):
      tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows
      net, neigh: clear whole pneigh_entry at alloc time
      sch_qfq: prevent shift-out-of-bounds in qfq_init_qdisc

Erik Ekman (1):
      net/mlx4_en: Update reported link modes for 1/10G

Felix Fietkau (1):
      mac80211: send ADDBA requests using the tid/queue of the aggregation session

Fernando Fernandez Mancera (1):
      bonding: fix ad_actor_system option setting to default

Florian Fainelli (2):
      ARM: dts: BCM5301X: Add interrupt properties to GPIO node
      net: systemport: Add global locking for descriptor lifecycle

George Kennedy (1):
      scsi: scsi_debug: Sanity check block descriptor length in resp_mode_select()

Greg Jesionowski (1):
      net: usb: lan78xx: add Allied Telesis AT29M2-AF

Greg Kroah-Hartman (15):
      Linux 4.9.292
      HID: add hid_is_usb() function to make it simpler for USB detection
      HID: add USB_HID dependancy to hid-prodikeys
      HID: add USB_HID dependancy to hid-chicony
      HID: add USB_HID dependancy on some USB HID drivers
      HID: wacom: fix problems when device is not a valid USB device
      HID: check for valid USB device for many HID drivers
      USB: gadget: detect too-big endpoint 0 requests
      USB: gadget: zero allocate endpoint 0 buffers
      Linux 4.9.293
      USB: gadget: bRequestType is a bitfield, not a enum
      Linux 4.9.294
      Linux 4.9.295
      Linux 4.9.296
      Linux 4.9.297

Guenter Roeck (2):
      hwmon: (lm90) Fix usage of CONFIG2 register in detect function
      hwmon: (lm90) Do not report 'busy' status bit as alarm

Hangyu Hua (1):
      phonet: refcount leak in pep_sock_accep

Hannes Reinecke (1):
      libata: add horkage for ASMedia 1092

Hans de Goede (1):
      HID: asus: Add depends on USB_HID to HID_ASUS Kconfig option

Harshit Mogalapalli (1):
      net: netlink: af_netlink: Prevent empty skb by adding a check on len.

Heiko Carstens (1):
      recordmcount.pl: fix typo in s390 mcount regex

Helge Deller (2):
      parisc: Fix "make install" on newer debian releases
      parisc/agp: Annotate parisc agp init functions with __init

Ian Abbott (1):
      bug: split BUILD_BUG stuff out into <linux/build_bug.h>

J. Bruce Fields (1):
      nfsd: fix use-after-free due to delegation race

James Morse (1):
      arm64: sysreg: Move to use definitions for all the SCTLR bits

Jason Gerecke (1):
      HID: introduce hid_is_using_ll_driver

Jedrzej Jagielski (1):
      i40e: Fix incorrect netdev's real number of RX/TX queues

Jens Axboe (1):
      fs: add fget_many() and fput_many()

Jerome Marchand (1):
      recordmcount.pl: look for jgnop instruction as well as bcrl on s390

Jiasheng Jiang (3):
      qlcnic: potential dereference null pointer of rx_queue->page_ring
      fjes: Check for error irq
      drivers: net: smc911x: Check for error irq

Jimmy Assarsson (1):
      can: kvaser_usb: get CAN clock frequency from device

Joakim Zhang (1):
      net: fec: only clear interrupt of handling queue in fec_enet_rx_queue()

Joe Thornber (1):
      dm btree remove: fix use after free in rebalance_children()

Johan Hovold (1):
      serial: core: fix transmit-buffer reset and memleak

José Expósito (1):
      IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()

Juergen Gross (14):
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
      xen/netback: fix rx queue stall detection
      xen/netback: don't queue unlimited number of packages

Krzysztof Kozlowski (2):
      nfc: fix potential NULL pointer deref in nfc_genl_dump_ses_done
      nfc: uapi: use kernel size_t to fix user-space builds

Lars-Peter Clausen (5):
      iio: stk3310: Don't return error code in interrupt handler
      iio: mma8452: Fix trigger reference couting
      iio: ltr501: Don't return error code in trigger handler
      iio: kxsd9: Don't return error code in trigger handler
      iio: itg3200: Call iio_trigger_notify_done() on error

Lee Jones (2):
      staging: ion: Prevent incorrect reference counting behavour
      net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero

Leo L. Schwab (1):
      Input: spaceball - fix parsing of movement data packets

Letu Ren (1):
      igbvf: fix double free in `igbvf_probe`

Lin Ma (4):
      NFC: add NCI_UNREG flag to eliminate the race
      ax25: NPD bug when detaching AX25 device
      hamradio: defer ax25 kfree after unregister_netdev
      hamradio: improve the incomplete fix to avoid NPD

Linus Torvalds (1):
      fget: check that the fd still exists after getting a ref to it

Lixiaokeng (1):
      scsi: libiscsi: Fix UAF in iscsi_conn_get_param()/iscsi_conn_teardown()

Maciej W. Rozycki (1):
      vgacon: Propagate console boot parameters before calling `vc_resize'

Manaf Meethalavalappu Pallikunhi (1):
      thermal: core: Reset previous low and high trip during thermal zone init

Manjong Lee (1):
      mm: bdi: initialize bdi_min_ratio when bdi is unregistered

Mark Gross (2):
      Merge remote-tracking branch 'stable/linux-4.9.y' into v4.9-rt
      Linux 4.9.297-rt191

Mark Rutland (2):
      arm64: reduce el2_setup branching
      arm64: move !VHE work to end of el2_setup

Masami Hiramatsu (1):
      kprobes: Limit max data_size of the kretprobe instances

Mathias Nyman (3):
      usb: hub: Fix usb enumeration issue due to address0 race
      usb: hub: Fix locking issues with address0_mutex
      xhci: Fresco FL1100 controller should not have BROKEN_MSI quirk set.

Miaoqian Lin (1):
      fsl/fman: Fix missing put_device() call in fman_port_probe

Mike Christie (1):
      scsi: iscsi: Unblock session then wake up error handler

Mike Kravetz (1):
      hugetlb: take PMD sharing into account when flushing tlb/caches

Mike Marciniszyn (1):
      IB/hfi1: Correct guard on eager buffer deallocation

Miklos Szeredi (3):
      fuse: fix page stealing
      fuse: release pipe buf after last use
      fuse: annotate lock in fuse_reverse_inval_entry()

Mingjie Zhang (1):
      USB: serial: option: add Fibocom FM101-GL variants

Muchun Song (1):
      net: fix use-after-free in tw_timer_handler

Nadav Amit (1):
      hugetlbfs: flush TLBs correctly after huge_pmd_unshare

Nathan Chancellor (5):
      soc/tegra: fuse: Fix bitwise vs. logical OR warning
      net: lan78xx: Avoid unnecessary self assignment
      mwifiex: Remove unnecessary braces from HostCmd_SET_SEQ_NO_BSS_INFO
      Input: touchscreen - avoid bitwise vs logical OR warning
      power: reset: ltc2952: Fix use of floating point literals

Naveen N. Rao (2):
      tracing: Fix check for trace_percpu_buffer validity in get_trace_buf()
      tracing: Tag trace_percpu_buffer as a percpu pointer

Nicolas Pitre (1):
      ARM: 8805/2: remove unneeded naked function usage

Ondrej Jirman (1):
      i2c: rk3x: Handle a spurious start completion interrupt flag

Pali Rohár (2):
      irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
      irqchip/armada-370-xp: Fix support for Multi-MSI interrupts

Parav Pandit (1):
      virtio_pci: Support surprise removal of virtio pci device

Pavel Hofman (2):
      usb: core: config: fix validation of wMaxPacketValue entries
      usb: core: config: using bit mask instead of individual bits

Pavel Skripkin (2):
      Input: appletouch - initialize work before device registration
      ieee802154: atusb: fix uninit value in atusb_set_extended_addr

Pierre Gondois (1):
      serial: pl011: Add ACPI SBSA UART match id

Randy Dunlap (1):
      natsemi: xtensa: fix section mismatch warnings

Rémi Denis-Courmont (1):
      phonet/pep: refuse to enable an unbound pipe

Slark Xiao (1):
      platform/x86: thinkpad_acpi: Fix WWAN device disabled issue after S3 deep

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix kernel panic during drive powercycle test

Stefan Traby (1):
      arm64: Remove a redundancy in sysreg.h

Stefano Garzarella (1):
      vhost/vsock: fix incorrect used length reported to the guest

Stefano Stabellini (2):
      xen: don't continue xenstore initialization in case of errors
      xen: detect uninitialized xenbus in xenbus_init

Stephen Suryaputra (1):
      vrf: Reset IPCB/IP6CB when processing outbound pkts in vrf dev xmit

Steven Rostedt (VMware) (4):
      tracing: Fix pid filtering when triggers are attached
      tracing: Check pid filtering when creating events
      tracefs: Have new files inherit the ownership of their parent
      tracefs: Set all files to the same group ownership as the mount option

Sudeep Holla (1):
      firmware: arm_scpi: Fix string overflow in SCPI genpd driver

Sven Eckelmann (1):
      tty: serial: msm_serial: Deactivate RX DMA for polling support

Tadeusz Struk (1):
      nfc: fix segfault in nfc_genl_dump_devices_done

Takashi Iwai (7):
      ALSA: ctxfi: Fix out-of-range access
      ASoC: topology: Add missing rwsem around snd_ctl_remove() calls
      ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
      ALSA: pcm: oss: Fix negative period/buffer sizes
      ALSA: pcm: oss: Limit the period size to 16MB
      ALSA: pcm: oss: Handle missing errors in snd_pcm_oss_change_params*()
      Bluetooth: btusb: Apply QCA Rome patches for some ATH3012 models

Teng Qi (2):
      ethernet: hisilicon: hns: hns_dsaf_misc: fix a possible array overflow in hns_dsaf_ge_srst_by_port()
      net: ethernet: dec: tulip: de4x5: fix possible array overflows in type3_infoblock()

Thomas Gleixner (1):
      PCI/MSI: Clear PCI_MSIX_FLAGS_MASKALL on error

Thomas Toye (1):
      rndis_host: support Hytera digital radios

Thomas Zeitlhofer (1):
      PM: hibernate: use correct mode for swsusp_close()

Todd Kjos (1):
      binder: fix test regression due to sender_euid change

Tom Rix (2):
      selinux: initialize proto variable in selinux_ip_postroute_compat()
      mac80211: initialize variable have_higher_than_11mbit

Trond Myklebust (1):
      NFSv42: Don't fail clone() unless the OP_CLONE operation failed

Vasily Gorbik (1):
      s390/setup: avoid using memblock_enforce_memory_limit

Vincent Mailhol (1):
      can: pch_can: pch_can_rx_normal: fix use after free

Vincent Pelletier (1):
      usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear.

Vladimir Murzin (1):
      irqchip: nvic: Fix offset for Interrupt Priority Offsets

Wang Qing (1):
      platform/x86: apple-gmux: use resource_size() with res

William Kucharski (1):
      net/rds: correct socket tunable error in rds_tcp_tune()

William Zhao (1):
      ip6_vti: initialize __ip6_tnl_parm struct in vti6_siocdevprivate

Wudi Wang (1):
      irqchip/irq-gic-v3-its.c: Force synchronisation when issuing INVALL

Xiaoke Wang (1):
      ALSA: jack: Check the return value of kstrdup()

Yang Yingliang (1):
      iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove

Yu Liao (1):
      timekeeping: Really make sure wall_to_monotonic isn't positive

Zhou Qingyang (1):
      net: qlogic: qlcnic: Fix a NULL pointer dereference in qlcnic_83xx_add_rings()

liuguoqiang (1):
      net: return correct error code

wolfgang huang (1):
      mISDN: change function names to avoid conflicts

yangxingwu (1):
      net: udp: fix alignment problem in udp4_seq_show()

zhangyue (1):
      net: tulip: de4x5: fix the problem that the array 'lp->phy[8]' may be out of bound
---
Documentation/networking/bonding.txt               |  11 +-
 Makefile                                           |   2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   2 +
 arch/arm/include/asm/tlb.h                         |   8 +
 arch/arm/kernel/entry-armv.S                       |   8 +-
 arch/arm/mach-socfpga/core.h                       |   2 +-
 arch/arm/mach-socfpga/platsmp.c                    |   8 +-
 arch/arm/mm/copypage-fa.c                          |  35 +-
 arch/arm/mm/copypage-feroceon.c                    |  98 +++---
 arch/arm/mm/copypage-v4mc.c                        |  19 +-
 arch/arm/mm/copypage-v4wb.c                        |  41 ++-
 arch/arm/mm/copypage-v4wt.c                        |  37 +-
 arch/arm/mm/copypage-xsc3.c                        |  71 ++--
 arch/arm/mm/copypage-xscale.c                      |  71 ++--
 arch/arm64/include/asm/sysreg.h                    |  69 +++-
 arch/arm64/kernel/head.S                           |  49 ++-
 arch/arm64/mm/proc.S                               |  24 +-
 arch/ia64/include/asm/tlb.h                        |  10 +
 arch/parisc/install.sh                             |   1 +
 arch/s390/include/asm/tlb.h                        |  14 +
 arch/s390/kernel/setup.c                           |   3 -
 arch/sh/include/asm/tlb.h                          |  10 +
 arch/um/include/asm/tlb.h                          |  12 +
 arch/x86/include/asm/pgtable.h                     |   4 +-
 block/ioprio.c                                     |   3 +
 drivers/android/binder.c                           |  23 +-
 drivers/ata/libata-core.c                          |   2 +
 drivers/ata/sata_fsl.c                             |  20 +-
 drivers/block/xen-blkfront.c                       | 141 +++++---
 drivers/bluetooth/btusb.c                          |  32 +-
 drivers/char/agp/parisc-agp.c                      |   6 +-
 drivers/firmware/scpi_pm_domain.c                  |  10 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |   2 +-
 drivers/hid/Kconfig                                |  11 +-
 drivers/hid/hid-chicony.c                          |   8 +-
 drivers/hid/hid-corsair.c                          |   7 +-
 drivers/hid/hid-elo.c                              |   3 +
 drivers/hid/hid-holtek-kbd.c                       |   9 +-
 drivers/hid/hid-holtek-mouse.c                     |  24 ++
 drivers/hid/hid-lg.c                               |  10 +-
 drivers/hid/hid-prodikeys.c                        |  10 +-
 drivers/hid/hid-roccat-arvo.c                      |   3 +
 drivers/hid/hid-roccat-isku.c                      |   3 +
 drivers/hid/hid-roccat-kone.c                      |   3 +
 drivers/hid/hid-roccat-koneplus.c                  |   3 +
 drivers/hid/hid-roccat-konepure.c                  |   3 +
 drivers/hid/hid-roccat-kovaplus.c                  |   3 +
 drivers/hid/hid-roccat-lua.c                       |   3 +
 drivers/hid/hid-roccat-pyra.c                      |   3 +
 drivers/hid/hid-roccat-ryos.c                      |   3 +
 drivers/hid/hid-roccat-savu.c                      |   3 +
 drivers/hid/hid-samsung.c                          |   3 +
 drivers/hid/hid-uclogic.c                          |   3 +
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   3 +-
 drivers/hid/uhid.c                                 |   3 +-
 drivers/hid/usbhid/hid-core.c                      |   3 +-
 drivers/hid/wacom_sys.c                            |  17 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   7 +-
 drivers/hwmon/lm90.c                               |   8 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   4 +-
 drivers/iio/accel/kxcjk-1013.c                     |   5 +-
 drivers/iio/accel/kxsd9.c                          |   6 +-
 drivers/iio/accel/mma8452.c                        |   2 +-
 drivers/iio/gyro/itg3200_buffer.c                  |   2 +-
 drivers/iio/light/ltr501.c                         |   2 +-
 drivers/iio/light/stk3310.c                        |   6 +-
 drivers/infiniband/hw/hfi1/init.c                  |   2 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c          |   2 +-
 drivers/input/joystick/spaceball.c                 |  11 +-
 drivers/input/mouse/appletouch.c                   |   4 +-
 drivers/input/touchscreen/of_touchscreen.c         |  18 +-
 drivers/irqchip/irq-armada-370-xp.c                |  16 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/irqchip/irq-nvic.c                         |   2 +-
 drivers/isdn/mISDN/core.c                          |   6 +-
 drivers/isdn/mISDN/core.h                          |   4 +-
 drivers/isdn/mISDN/layer1.c                        |   4 +-
 drivers/md/persistent-data/dm-btree-remove.c       |   2 +-
 drivers/net/bonding/bond_options.c                 |   2 +-
 drivers/net/can/pch_can.c                          |   2 +-
 drivers/net/can/sja1000/ems_pcmcia.c               |   7 +-
 drivers/net/can/usb/kvaser_usb.c                   |  41 ++-
 drivers/net/ethernet/altera/altera_tse_main.c      |   9 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   5 +
 drivers/net/ethernet/broadcom/bcmsysport.h         |   1 +
 drivers/net/ethernet/dec/tulip/de4x5.c             |  34 +-
 drivers/net/ethernet/freescale/fec.h               |   3 +
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 drivers/net/ethernet/freescale/fman/fman_port.c    |  12 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   4 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  32 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   3 +
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   6 +-
 drivers/net/ethernet/natsemi/xtsonic.c             |   2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |  19 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  10 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h  |   2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  12 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |   4 +-
 drivers/net/ethernet/smsc/smc911x.c                |   5 +
 drivers/net/fjes/fjes_main.c                       |   5 +
 drivers/net/hamradio/mkiss.c                       |   5 +-
 drivers/net/ieee802154/atusb.c                     |  10 +-
 drivers/net/usb/cdc_ncm.c                          |   2 +
 drivers/net/usb/lan78xx.c                          |  12 +-
 drivers/net/usb/rndis_host.c                       |   5 +
 drivers/net/vrf.c                                  |   2 +
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |   4 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |   8 +-
 drivers/net/xen-netback/common.h                   |   1 +
 drivers/net/xen-netback/rx.c                       |  77 +++--
 drivers/net/xen-netfront.c                         | 372 ++++++++++++++-------
 drivers/pci/msi.c                                  |   2 +-
 drivers/platform/x86/apple-gmux.c                  |   2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  12 -
 drivers/power/reset/ltc2952-poweroff.c             |   4 +-
 drivers/scsi/libiscsi.c                            |   6 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   2 +-
 drivers/scsi/scsi_debug.c                          |   4 +-
 drivers/scsi/scsi_transport_iscsi.c                |   6 +-
 drivers/scsi/vmw_pvscsi.c                          |   7 +-
 drivers/soc/tegra/fuse/fuse-tegra.c                |   2 +-
 drivers/soc/tegra/fuse/fuse.h                      |   2 +-
 drivers/staging/android/ion/ion.c                  |   6 +
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   3 +-
 drivers/thermal/thermal_core.c                     |   2 +
 drivers/tty/hvc/hvc_xen.c                          |  47 ++-
 drivers/tty/serial/amba-pl011.c                    |   1 +
 drivers/tty/serial/msm_serial.c                    |   3 +
 drivers/tty/serial/serial_core.c                   |  13 +-
 drivers/usb/core/config.c                          |   6 +-
 drivers/usb/core/hub.c                             |  23 +-
 drivers/usb/gadget/composite.c                     |  14 +-
 drivers/usb/gadget/function/f_fs.c                 |   9 +-
 drivers/usb/gadget/legacy/dbgp.c                   |  15 +-
 drivers/usb/gadget/legacy/inode.c                  |  16 +-
 drivers/usb/host/xhci-pci.c                        |   5 +-
 drivers/usb/serial/option.c                        |  13 +
 drivers/vhost/vsock.c                              |   2 +-
 drivers/video/console/vgacon.c                     |  14 +-
 drivers/virtio/virtio_pci_common.c                 |   7 +
 drivers/xen/xenbus/xenbus_probe.c                  |  27 +-
 fs/file.c                                          |  19 +-
 fs/file_table.c                                    |   9 +-
 fs/fuse/dev.c                                      |  14 +-
 fs/fuse/dir.c                                      |   2 +-
 fs/nfs/nfs42proc.c                                 |   5 +-
 fs/nfs/nfs42xdr.c                                  |   3 +-
 fs/nfsd/nfs4state.c                                |   9 +-
 fs/proc/vmcore.c                                   |  15 +-
 fs/signalfd.c                                      |  12 +-
 fs/tracefs/inode.c                                 |  76 +++++
 fs/xfs/xfs_ioctl.c                                 |   3 +-
 include/asm-generic/tlb.h                          |   2 +
 include/linux/bug.h                                |  72 +---
 include/linux/build_bug.h                          |  84 +++++
 include/linux/file.h                               |   2 +
 include/linux/fs.h                                 |   4 +-
 include/linux/hid.h                                |  16 +
 include/linux/ipc_namespace.h                      |  15 +
 include/linux/kprobes.h                            |   2 +
 include/linux/sched.h                              |   2 +-
 include/linux/shm.h                                |  13 +-
 include/linux/siphash.h                            |  14 +-
 include/linux/wait.h                               |  26 ++
 include/net/nfc/nci_core.h                         |   1 +
 include/net/nl802154.h                             |   7 +-
 include/uapi/linux/nfc.h                           |   6 +-
 include/xen/interface/io/ring.h                    | 257 +++++++-------
 ipc/shm.c                                          | 176 +++++++---
 kernel/kprobes.c                                   |   3 +
 kernel/power/hibernate.c                           |   6 +-
 kernel/sched/wait.c                                |   8 +
 kernel/time/timekeeping.c                          |   3 +-
 kernel/trace/trace.c                               |   6 +-
 kernel/trace/trace.h                               |  24 +-
 kernel/trace/trace_events.c                        |   7 +
 kernel/trace/tracing_map.c                         |   3 +
 lib/siphash.c                                      |  12 +-
 localversion-rt                                    |   2 +-
 mm/backing-dev.c                                   |   7 +
 mm/hugetlb.c                                       |  72 +++-
 mm/memory.c                                        |  16 +
 net/ax25/af_ax25.c                                 |   4 +-
 net/bluetooth/hidp/core.c                          |   3 +-
 net/core/neighbour.c                               |   2 +-
 net/ipv4/af_inet.c                                 |  10 +-
 net/ipv4/devinet.c                                 |   2 +-
 net/ipv4/tcp_cubic.c                               |   5 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/ip6_vti.c                                 |   2 +
 net/mac80211/agg-tx.c                              |   2 +-
 net/mac80211/mlme.c                                |   2 +-
 net/netlink/af_netlink.c                           |   5 +
 net/nfc/nci/core.c                                 |  19 +-
 net/nfc/netlink.c                                  |  12 +-
 net/phonet/pep.c                                   |   3 +
 net/rds/tcp.c                                      |   2 +-
 net/sched/sch_qfq.c                                |   6 +-
 scripts/recordmcount.pl                            |   2 +-
 security/selinux/hooks.c                           |   2 +-
 sound/core/control_compat.c                        |   3 +
 sound/core/jack.c                                  |   4 +
 sound/core/oss/pcm_oss.c                           |  37 +-
 sound/drivers/opl3/opl3_midi.c                     |   2 +-
 sound/pci/ctxfi/ctamixer.c                         |  14 +-
 sound/pci/ctxfi/ctdaio.c                           |  16 +-
 sound/pci/ctxfi/ctresource.c                       |   7 +-
 sound/pci/ctxfi/ctresource.h                       |   4 +-
 sound/pci/ctxfi/ctsrc.c                            |   7 +-
 sound/soc/soc-topology.c                           |   3 +
 212 files changed, 2205 insertions(+), 1115 deletions(-)
---
diff --git a/Documentation/networking/bonding.txt b/Documentation/networking/bonding.txt
index 57f52cdce32e4..07b53b2b13df8 100644
--- a/Documentation/networking/bonding.txt
+++ b/Documentation/networking/bonding.txt
@@ -191,11 +191,12 @@ ad_actor_sys_prio
 ad_actor_system
 
 	In an AD system, this specifies the mac-address for the actor in
-	protocol packet exchanges (LACPDUs). The value cannot be NULL or
-	multicast. It is preferred to have the local-admin bit set for this
-	mac but driver does not enforce it. If the value is not given then
-	system defaults to using the masters' mac address as actors' system
-	address.
+	protocol packet exchanges (LACPDUs). The value cannot be a multicast
+	address. If the all-zeroes MAC is specified, bonding will internally
+	use the MAC of the bond itself. It is preferred to have the
+	local-admin bit set for this mac but driver does not enforce it. If
+	the value is not given then system defaults to using the masters'
+	mac address as actors' system address.
 
 	This parameter has effect only in 802.3ad mode and is available through
 	SysFs interface.
diff --git a/Makefile b/Makefile
index fa41ff3c7cc38..70a11157b2404 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 291
+SUBLEVEL = 297
 EXTRAVERSION =
 NAME = Roaring Lionus
 
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 4616452ce74de..e0f96be549f14 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -234,6 +234,8 @@
 
 			gpio-controller;
 			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		usb2: usb2@21000 {
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 1e25cd80589e7..1cee2d5409566 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -278,6 +278,14 @@ tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr
 	tlb_add_flush(tlb, addr);
 }
 
+static inline void
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	tlb_add_flush(tlb, address);
+	tlb_add_flush(tlb, address + size - PMD_SIZE);
+}
+
 #define pte_free_tlb(tlb, ptep, addr)	__pte_free_tlb(tlb, ptep, addr)
 #define pmd_free_tlb(tlb, pmdp, addr)	__pmd_free_tlb(tlb, pmdp, addr)
 #define pud_free_tlb(tlb, pudp, addr)	pud_free((tlb)->mm, pudp)
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 468e224d76aab..d723548b461c9 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -644,11 +644,9 @@ call_fpe:
 	tstne	r0, #0x04000000			@ bit 26 set on both ARM and Thumb-2
 	reteq	lr
 	and	r8, r0, #0x00000f00		@ mask out CP number
- THUMB(	lsr	r8, r8, #8		)
 	mov	r7, #1
-	add	r6, r10, #TI_USED_CP
- ARM(	strb	r7, [r6, r8, lsr #8]	)	@ set appropriate used_cp[]
- THUMB(	strb	r7, [r6, r8]		)	@ set appropriate used_cp[]
+	add	r6, r10, r8, lsr #8		@ add used_cp[] array offset first
+	strb	r7, [r6, #TI_USED_CP]		@ set appropriate used_cp[]
 #ifdef CONFIG_IWMMXT
 	@ Test if we need to give access to iWMMXt coprocessors
 	ldr	r5, [r10, #TI_FLAGS]
@@ -657,7 +655,7 @@ call_fpe:
 	bcs	iwmmxt_task_enable
 #endif
  ARM(	add	pc, pc, r8, lsr #6	)
- THUMB(	lsl	r8, r8, #2		)
+ THUMB(	lsr	r8, r8, #6		)
  THUMB(	add	pc, r8			)
 	nop
 
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 65e1817d8afe6..692a287a8712d 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -48,7 +48,7 @@ extern void __iomem *sdr_ctl_base_addr;
 u32 socfpga_sdram_self_refresh(u32 sdr_base);
 extern unsigned int socfpga_sdram_self_refresh_sz;
 
-extern char secondary_trampoline, secondary_trampoline_end;
+extern char secondary_trampoline[], secondary_trampoline_end[];
 
 extern unsigned long socfpga_cpu1start_addr;
 
diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 07945748b5714..1dfc9e7389a74 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -31,14 +31,14 @@
 
 static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+	int trampoline_size = secondary_trampoline_end - secondary_trampoline;
 
 	if (socfpga_cpu1start_addr) {
 		/* This will put CPU #1 into reset. */
 		writel(RSTMGR_MPUMODRST_CPU1,
 		       rst_manager_base_addr + SOCFPGA_RSTMGR_MODMPURST);
 
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+		memcpy(phys_to_virt(0), secondary_trampoline, trampoline_size);
 
 		writel(virt_to_phys(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x000000ff));
@@ -56,12 +56,12 @@ static int socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
+	int trampoline_size = secondary_trampoline_end - secondary_trampoline;
 
 	if (socfpga_cpu1start_addr) {
 		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
 		       SOCFPGA_A10_RSTMGR_MODMPURST);
-		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
+		memcpy(phys_to_virt(0), secondary_trampoline, trampoline_size);
 
 		writel(virt_to_phys(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
index d130a5ece5d55..bf24690ec83af 100644
--- a/arch/arm/mm/copypage-fa.c
+++ b/arch/arm/mm/copypage-fa.c
@@ -17,26 +17,25 @@
 /*
  * Faraday optimised copy_user_page
  */
-static void __naked
-fa_copy_user_page(void *kto, const void *kfrom)
+static void fa_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %0				@ 1\n\
-1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
-	add	r0, r0, #16			@ 1\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ 1   clean and invalidate D line\n\
-	add	r0, r0, #16			@ 1\n\
-	subs	r2, r2, #1			@ 1\n\
+	int tmp;
+
+	asm volatile ("\
+1:	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
+	add	%0, %0, #16			@ 1\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	stmia	%0, {r3, r4, ip, lr}		@ 4\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
+	add	%0, %0, #16			@ 1\n\
+	subs	%2, %2, #1			@ 1\n\
 	bne	1b				@ 1\n\
-	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
-	:
-	: "I" (PAGE_SIZE / 32));
+	mcr	p15, 0, %2, c7, c10, 4		@ 1   drain WB"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 32)
+	: "r3", "r4", "ip", "lr");
 }
 
 void fa_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-feroceon.c b/arch/arm/mm/copypage-feroceon.c
index 49ee0c1a72097..cc819732d9b82 100644
--- a/arch/arm/mm/copypage-feroceon.c
+++ b/arch/arm/mm/copypage-feroceon.c
@@ -13,58 +13,56 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 
-static void __naked
-feroceon_copy_user_page(void *kto, const void *kfrom)
+static void feroceon_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4-r9, lr}		\n\
-	mov	ip, %2				\n\
-1:	mov	lr, r1				\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	pld	[lr, #32]			\n\
-	pld	[lr, #64]			\n\
-	pld	[lr, #96]			\n\
-	pld	[lr, #128]			\n\
-	pld	[lr, #160]			\n\
-	pld	[lr, #192]			\n\
-	pld	[lr, #224]			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	ldmia	r1!, {r2 - r9}			\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
-	stmia	r0, {r2 - r9}			\n\
-	subs	ip, ip, #(32 * 8)		\n\
-	mcr	p15, 0, r0, c7, c14, 1		@ clean and invalidate D line\n\
-	add	r0, r0, #32			\n\
+	int tmp;
+
+	asm volatile ("\
+1:	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	pld	[%1, #0]			\n\
+	pld	[%1, #32]			\n\
+	pld	[%1, #64]			\n\
+	pld	[%1, #96]			\n\
+	pld	[%1, #128]			\n\
+	pld	[%1, #160]			\n\
+	pld	[%1, #192]			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	ldmia	%1!, {r2 - r7, ip, lr}		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
+	stmia	%0, {r2 - r7, ip, lr}		\n\
+	subs	%2, %2, #(32 * 8)		\n\
+	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
+	add	%0, %0, #32			\n\
 	bne	1b				\n\
-	mcr	p15, 0, ip, c7, c10, 4		@ drain WB\n\
-	ldmfd	sp!, {r4-r9, pc}"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE));
+	mcr	p15, 0, %2, c7, c10, 4		@ drain WB"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE)
+	: "r2", "r3", "r4", "r5", "r6", "r7", "ip", "lr");
 }
 
 void feroceon_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
index 1267e64133b92..db624170854a0 100644
--- a/arch/arm/mm/copypage-v4mc.c
+++ b/arch/arm/mm/copypage-v4mc.c
@@ -40,12 +40,11 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
  * instruction.  If your processor does not supply this, you have to write your
  * own copy_user_highpage that does the right thing.
  */
-static void __naked
-mc_copy_user_page(void *from, void *to)
+static void mc_copy_user_page(void *from, void *to)
 {
-	asm volatile(
-	"stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r4, %2				@ 1\n\
+	int tmp;
+
+	asm volatile ("\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
 1:	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
@@ -55,13 +54,13 @@ mc_copy_user_page(void *from, void *to)
 	mcr	p15, 0, %1, c7, c6, 1		@ 1   invalidate D line\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
 	ldmia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	subs	r4, r4, #1			@ 1\n\
+	subs	%2, %2, #1			@ 1\n\
 	stmia	%1!, {r2, r3, ip, lr}		@ 4\n\
 	ldmneia	%0!, {r2, r3, ip, lr}		@ 4\n\
-	bne	1b				@ 1\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
-	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64));
+	bne	1b				@ "
+	: "+&r" (from), "+&r" (to), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64)
+	: "r2", "r3", "ip", "lr");
 }
 
 void v4_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
index 067d0fdd630c1..cd3e165afeede 100644
--- a/arch/arm/mm/copypage-v4wb.c
+++ b/arch/arm/mm/copypage-v4wb.c
@@ -22,29 +22,28 @@
  * instruction.  If your processor does not supply this, you have to write your
  * own copy_user_highpage that does the right thing.
  */
-static void __naked
-v4wb_copy_user_page(void *kto, const void *kfrom)
+static void v4wb_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-1:	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	mcr	p15, 0, r0, c7, c6, 1		@ 1   invalidate D line\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	subs	r2, r2, #1			@ 1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
+	int tmp;
+
+	asm volatile ("\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+1:	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	mcr	p15, 0, %0, c7, c6, 1		@ 1   invalidate D line\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	subs	%2, %2, #1			@ 1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
-	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB\n\
-	ldmfd	 sp!, {r4, pc}			@ 3"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	mcr	p15, 0, %1, c7, c10, 4		@ 1   drain WB"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64)
+	: "r3", "r4", "ip", "lr");
 }
 
 void v4wb_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
index b85c5da2e510e..8614572e1296b 100644
--- a/arch/arm/mm/copypage-v4wt.c
+++ b/arch/arm/mm/copypage-v4wt.c
@@ -20,27 +20,26 @@
  * dirty data in the cache.  However, we do have to ensure that
  * subsequent reads are up to date.
  */
-static void __naked
-v4wt_copy_user_page(void *kto, const void *kfrom)
+static void v4wt_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, lr}			@ 2\n\
-	mov	r2, %2				@ 1\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-1:	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4+1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
-	subs	r2, r2, #1			@ 1\n\
-	stmia	r0!, {r3, r4, ip, lr}		@ 4\n\
-	ldmneia	r1!, {r3, r4, ip, lr}		@ 4\n\
+	int tmp;
+
+	asm volatile ("\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+1:	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4+1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmia	%1!, {r3, r4, ip, lr}		@ 4\n\
+	subs	%2, %2, #1			@ 1\n\
+	stmia	%0!, {r3, r4, ip, lr}		@ 4\n\
+	ldmneia	%1!, {r3, r4, ip, lr}		@ 4\n\
 	bne	1b				@ 1\n\
-	mcr	p15, 0, r2, c7, c7, 0		@ flush ID cache\n\
-	ldmfd	sp!, {r4, pc}			@ 3"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
+	mcr	p15, 0, %2, c7, c7, 0		@ flush ID cache"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64)
+	: "r3", "r4", "ip", "lr");
 }
 
 void v4wt_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm/mm/copypage-xsc3.c b/arch/arm/mm/copypage-xsc3.c
index 03a2042aced5f..55cbc3a89d858 100644
--- a/arch/arm/mm/copypage-xsc3.c
+++ b/arch/arm/mm/copypage-xsc3.c
@@ -21,53 +21,46 @@
 
 /*
  * XSC3 optimised copy_user_highpage
- *  r0 = destination
- *  r1 = source
  *
  * The source page may have some clean entries in the cache already, but we
  * can safely ignore them - break_cow() will flush them out of the cache
  * if we eventually end up using our copied page.
  *
  */
-static void __naked
-xsc3_mc_copy_user_page(void *kto, const void *kfrom)
+static void xsc3_mc_copy_user_page(void *kto, const void *kfrom)
 {
-	asm("\
-	stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
-						\n\
-	pld	[r1, #0]			\n\
-	pld	[r1, #32]			\n\
-1:	pld	[r1, #64]			\n\
-	pld	[r1, #96]			\n\
+	int tmp;
+
+	asm volatile ("\
+	pld	[%1, #0]			\n\
+	pld	[%1, #32]			\n\
+1:	pld	[%1, #64]			\n\
+	pld	[%1, #96]			\n\
 						\n\
-2:	ldrd	r2, [r1], #8			\n\
-	mov	ip, r0				\n\
-	ldrd	r4, [r1], #8			\n\
-	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
-	strd	r2, [r0], #8			\n\
-	ldrd	r2, [r1], #8			\n\
-	strd	r4, [r0], #8			\n\
-	ldrd	r4, [r1], #8			\n\
-	strd	r2, [r0], #8			\n\
-	strd	r4, [r0], #8			\n\
-	ldrd	r2, [r1], #8			\n\
-	mov	ip, r0				\n\
-	ldrd	r4, [r1], #8			\n\
-	mcr	p15, 0, ip, c7, c6, 1		@ invalidate\n\
-	strd	r2, [r0], #8			\n\
-	ldrd	r2, [r1], #8			\n\
-	subs	lr, lr, #1			\n\
-	strd	r4, [r0], #8			\n\
-	ldrd	r4, [r1], #8			\n\
-	strd	r2, [r0], #8			\n\
-	strd	r4, [r0], #8			\n\
+2:	ldrd	r2, [%1], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
+	strd	r2, [%0], #8			\n\
+	ldrd	r2, [%1], #8			\n\
+	strd	r4, [%0], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	strd	r2, [%0], #8			\n\
+	strd	r4, [%0], #8			\n\
+	ldrd	r2, [%1], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	mcr	p15, 0, %0, c7, c6, 1		@ invalidate\n\
+	strd	r2, [%0], #8			\n\
+	ldrd	r2, [%1], #8			\n\
+	subs	%2, %2, #1			\n\
+	strd	r4, [%0], #8			\n\
+	ldrd	r4, [%1], #8			\n\
+	strd	r2, [%0], #8			\n\
+	strd	r4, [%0], #8			\n\
 	bgt	1b				\n\
-	beq	2b				\n\
-						\n\
-	ldmfd	sp!, {r4, r5, pc}"
-	:
-	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64 - 1));
+	beq	2b				"
+	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64 - 1)
+	: "r2", "r3", "r4", "r5");
 }
 
 void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
@@ -85,8 +78,6 @@ void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
 
 /*
  * XScale optimised clear_user_page
- *  r0 = destination
- *  r1 = virtual user address of ultimate destination page
  */
 void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
 {
diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
index 0fb85025344d9..c775d4b7adb08 100644
--- a/arch/arm/mm/copypage-xscale.c
+++ b/arch/arm/mm/copypage-xscale.c
@@ -36,52 +36,51 @@ static DEFINE_RAW_SPINLOCK(minicache_lock);
  * Dcache aliasing issue.  The writes will be forwarded to the write buffer,
  * and merged as appropriate.
  */
-static void __naked
-mc_copy_user_page(void *from, void *to)
+static void mc_copy_user_page(void *from, void *to)
 {
+	int tmp;
+
 	/*
 	 * Strangely enough, best performance is achieved
 	 * when prefetching destination as well.  (NP)
 	 */
-	asm volatile(
-	"stmfd	sp!, {r4, r5, lr}		\n\
-	mov	lr, %2				\n\
-	pld	[r0, #0]			\n\
-	pld	[r0, #32]			\n\
-	pld	[r1, #0]			\n\
-	pld	[r1, #32]			\n\
-1:	pld	[r0, #64]			\n\
-	pld	[r0, #96]			\n\
-	pld	[r1, #64]			\n\
-	pld	[r1, #96]			\n\
-2:	ldrd	r2, [r0], #8			\n\
-	ldrd	r4, [r0], #8			\n\
-	mov	ip, r1				\n\
-	strd	r2, [r1], #8			\n\
-	ldrd	r2, [r0], #8			\n\
-	strd	r4, [r1], #8			\n\
-	ldrd	r4, [r0], #8			\n\
-	strd	r2, [r1], #8			\n\
-	strd	r4, [r1], #8			\n\
+	asm volatile ("\
+	pld	[%0, #0]			\n\
+	pld	[%0, #32]			\n\
+	pld	[%1, #0]			\n\
+	pld	[%1, #32]			\n\
+1:	pld	[%0, #64]			\n\
+	pld	[%0, #96]			\n\
+	pld	[%1, #64]			\n\
+	pld	[%1, #96]			\n\
+2:	ldrd	r2, [%0], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	mov	ip, %1				\n\
+	strd	r2, [%1], #8			\n\
+	ldrd	r2, [%0], #8			\n\
+	strd	r4, [%1], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	strd	r2, [%1], #8			\n\
+	strd	r4, [%1], #8			\n\
 	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
-	ldrd	r2, [r0], #8			\n\
+	ldrd	r2, [%0], #8			\n\
 	mcr	p15, 0, ip, c7, c6, 1		@ invalidate D line\n\
-	ldrd	r4, [r0], #8			\n\
-	mov	ip, r1				\n\
-	strd	r2, [r1], #8			\n\
-	ldrd	r2, [r0], #8			\n\
-	strd	r4, [r1], #8			\n\
-	ldrd	r4, [r0], #8			\n\
-	strd	r2, [r1], #8			\n\
-	strd	r4, [r1], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	mov	ip, %1				\n\
+	strd	r2, [%1], #8			\n\
+	ldrd	r2, [%0], #8			\n\
+	strd	r4, [%1], #8			\n\
+	ldrd	r4, [%0], #8			\n\
+	strd	r2, [%1], #8			\n\
+	strd	r4, [%1], #8			\n\
 	mcr	p15, 0, ip, c7, c10, 1		@ clean D line\n\
-	subs	lr, lr, #1			\n\
+	subs	%2, %2, #1			\n\
 	mcr	p15, 0, ip, c7, c6, 1		@ invalidate D line\n\
 	bgt	1b				\n\
-	beq	2b				\n\
-	ldmfd	sp!, {r4, r5, pc}		"
-	:
-	: "r" (from), "r" (to), "I" (PAGE_SIZE / 64 - 1));
+	beq	2b				"
+	: "+&r" (from), "+&r" (to), "=&r" (tmp)
+	: "2" (PAGE_SIZE / 64 - 1)
+	: "r2", "r3", "r4", "r5", "ip");
 }
 
 void xscale_mc_copy_user_highpage(struct page *to, struct page *from,
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 88bbe364b6ae0..ae1b31d02784c 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,6 +20,7 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
+#include <asm/compiler.h>
 #include <linux/stringify.h>
 
 #include <asm/opcodes.h>
@@ -88,25 +89,81 @@
 
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_EE    (1 << 25)
+#define SCTLR_ELx_WXN	(1 << 19)
 #define SCTLR_ELx_I	(1 << 12)
 #define SCTLR_ELx_SA	(1 << 3)
 #define SCTLR_ELx_C	(1 << 2)
 #define SCTLR_ELx_A	(1 << 1)
 #define SCTLR_ELx_M	1
 
-#define SCTLR_EL2_RES1	((1 << 4)  | (1 << 5)  | (1 << 11) | (1 << 16) | \
-			 (1 << 16) | (1 << 18) | (1 << 22) | (1 << 23) | \
-			 (1 << 28) | (1 << 29))
-
 #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
 			 SCTLR_ELx_SA | SCTLR_ELx_I)
 
+/* SCTLR_EL2 specific flags. */
+#define SCTLR_EL2_RES1	((1 << 4)  | (1 << 5)  | (1 << 11) | (1 << 16) | \
+			 (1 << 18) | (1 << 22) | (1 << 23) | (1 << 28) | \
+			 (1 << 29))
+#define SCTLR_EL2_RES0	((1 << 6)  | (1 << 7)  | (1 << 8)  | (1 << 9)  | \
+			 (1 << 10) | (1 << 13) | (1 << 14) | (1 << 15) | \
+			 (1 << 17) | (1 << 20) | (1 << 21) | (1 << 24) | \
+			 (1 << 26) | (1 << 27) | (1 << 30) | (1 << 31))
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define ENDIAN_SET_EL2		SCTLR_ELx_EE
+#define ENDIAN_CLEAR_EL2	0
+#else
+#define ENDIAN_SET_EL2		0
+#define ENDIAN_CLEAR_EL2	SCTLR_ELx_EE
+#endif
+
+/* SCTLR_EL2 value used for the hyp-stub */
+#define SCTLR_EL2_SET	(ENDIAN_SET_EL2   | SCTLR_EL2_RES1)
+#define SCTLR_EL2_CLEAR	(SCTLR_ELx_M      | SCTLR_ELx_A    | SCTLR_ELx_C   | \
+			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
+			 ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
+
+/* Check all the bits are accounted for */
+#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
+
+
 /* SCTLR_EL1 specific flags. */
 #define SCTLR_EL1_UCI		(1 << 26)
+#define SCTLR_EL1_E0E		(1 << 24)
 #define SCTLR_EL1_SPAN		(1 << 23)
+#define SCTLR_EL1_NTWE		(1 << 18)
+#define SCTLR_EL1_NTWI		(1 << 16)
 #define SCTLR_EL1_UCT		(1 << 15)
+#define SCTLR_EL1_DZE		(1 << 14)
+#define SCTLR_EL1_UMA		(1 << 9)
 #define SCTLR_EL1_SED		(1 << 8)
+#define SCTLR_EL1_ITD		(1 << 7)
 #define SCTLR_EL1_CP15BEN	(1 << 5)
+#define SCTLR_EL1_SA0		(1 << 4)
+
+#define SCTLR_EL1_RES1	((1 << 11) | (1 << 20) | (1 << 22) | (1 << 28) | \
+			 (1 << 29))
+#define SCTLR_EL1_RES0  ((1 << 6)  | (1 << 10) | (1 << 13) | (1 << 17) | \
+			 (1 << 21) | (1 << 27) | (1 << 30) | (1 << 31))
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define ENDIAN_SET_EL1		(SCTLR_EL1_E0E | SCTLR_ELx_EE)
+#define ENDIAN_CLEAR_EL1	0
+#else
+#define ENDIAN_SET_EL1		0
+#define ENDIAN_CLEAR_EL1	(SCTLR_EL1_E0E | SCTLR_ELx_EE)
+#endif
+
+#define SCTLR_EL1_SET	(SCTLR_ELx_M    | SCTLR_ELx_C    | SCTLR_ELx_SA   |\
+			 SCTLR_EL1_SA0  | SCTLR_EL1_SED  | SCTLR_ELx_I    |\
+			 SCTLR_EL1_DZE  | SCTLR_EL1_UCT  | SCTLR_EL1_NTWI |\
+			 SCTLR_EL1_NTWE | SCTLR_EL1_SPAN | ENDIAN_SET_EL1 |\
+			 SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
+#define SCTLR_EL1_CLEAR	(SCTLR_ELx_A   | SCTLR_EL1_CP15BEN | SCTLR_EL1_ITD    |\
+			 SCTLR_EL1_UMA | SCTLR_ELx_WXN     | ENDIAN_CLEAR_EL1 |\
+			 SCTLR_EL1_RES0)
+
+/* Check all the bits are accounted for */
+#define SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != ~0)
 
 /* id_aa64isar0 */
 #define ID_AA64ISAR0_RDM_SHIFT		28
@@ -244,6 +301,7 @@
 
 #else
 
+#include <linux/build_bug.h>
 #include <linux/types.h>
 
 asm(
@@ -300,6 +358,9 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 {
 	u32 val;
 
+	SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS;
+	SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS;
+
 	val = read_sysreg(sctlr_el1);
 	val &= ~clear;
 	val |= set;
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3875423836622..04f81675b6b3a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -489,21 +489,16 @@ ENTRY(el2_setup)
 	msr	SPsel, #1			// We want to use SP_EL{1,2}
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
-	b.ne	1f
-	mrs	x0, sctlr_el2
-CPU_BE(	orr	x0, x0, #(1 << 25)	)	// Set the EE bit for EL2
-CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
-	msr	sctlr_el2, x0
-	b	2f
-1:	mrs	x0, sctlr_el1
-CPU_BE(	orr	x0, x0, #(3 << 24)	)	// Set the EE and E0E bits for EL1
-CPU_LE(	bic	x0, x0, #(3 << 24)	)	// Clear the EE and E0E bits for EL1
+	b.eq	1f
+	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
 	msr	sctlr_el1, x0
 	mov	w0, #BOOT_CPU_MODE_EL1		// This cpu booted in EL1
 	isb
 	ret
 
-2:
+1:	mov_q	x0, (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
+	msr	sctlr_el2, x0
+
 #ifdef CONFIG_ARM64_VHE
 	/*
 	 * Check for VHE being present. For the rest of the EL2 setup,
@@ -554,26 +549,6 @@ set_hcr:
 	msr	vpidr_el2, x0
 	msr	vmpidr_el2, x1
 
-	/*
-	 * When VHE is not in use, early init of EL2 and EL1 needs to be
-	 * done here.
-	 * When VHE _is_ in use, EL1 will not be used in the host and
-	 * requires no configuration, and all non-hyp-specific EL2 setup
-	 * will be done via the _EL1 system register aliases in __cpu_setup.
-	 */
-	cbnz	x2, 1f
-
-	/* sctlr_el1 */
-	mov	x0, #0x0800			// Set/clear RES{1,0} bits
-CPU_BE(	movk	x0, #0x33d0, lsl #16	)	// Set EE and E0E on BE systems
-CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
-	msr	sctlr_el1, x0
-
-	/* Coprocessor traps. */
-	mov	x0, #0x33ff
-	msr	cptr_el2, x0			// Disable copro. traps to EL2
-1:
-
 #ifdef CONFIG_COMPAT
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
@@ -599,6 +574,20 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	ret
 
 install_el2_stub:
+	/*
+	 * When VHE is not in use, early init of EL2 and EL1 needs to be
+	 * done here.
+	 * When VHE _is_ in use, EL1 will not be used in the host and
+	 * requires no configuration, and all non-hyp-specific EL2 setup
+	 * will be done via the _EL1 system register aliases in __cpu_setup.
+	 */
+	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
+	msr	sctlr_el1, x0
+
+	/* Coprocessor traps. */
+	mov	x0, #0x33ff
+	msr	cptr_el2, x0			// Disable copro. traps to EL2
+
 	/* Hypervisor stub */
 	adrp	x0, __hyp_stub_vectors
 	add	x0, x0, #:lo12:__hyp_stub_vectors
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 1b91b8c8999bc..266211a0ecd6d 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -413,11 +413,7 @@ ENTRY(__cpu_setup)
 	/*
 	 * Prepare SCTLR
 	 */
-	adr	x5, crval
-	ldp	w5, w6, [x5]
-	mrs	x0, sctlr_el1
-	bic	x0, x0, x5			// clear bits
-	orr	x0, x0, x6			// set bits
+	mov_q	x0, SCTLR_EL1_SET
 	/*
 	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
 	 * both user and kernel.
@@ -453,21 +449,3 @@ ENTRY(__cpu_setup)
 	msr	tcr_el1, x10
 	ret					// return to head.S
 ENDPROC(__cpu_setup)
-
-	/*
-	 * We set the desired value explicitly, including those of the
-	 * reserved bits. The values of bits EE & E0E were set early in
-	 * el2_setup, which are left untouched below.
-	 *
-	 *                 n n            T
-	 *       U E      WT T UD     US IHBS
-	 *       CE0      XWHW CZ     ME TEEA S
-	 * .... .IEE .... NEAI TE.I ..AD DEN0 ACAM
-	 * 0011 0... 1101 ..0. ..0. 10.. .0.. .... < hardware reserved
-	 * .... .1.. .... 01.1 11.1 ..01 0.01 1101 < software settings
-	 */
-	.type	crval, #object
-crval:
-	.word	0xfcffffff			// clear
-	.word	0x34d5d91d			// set
-	.popsection
diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index 77e541cf0e5d5..34f4a53595619 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -272,6 +272,16 @@ __tlb_remove_tlb_entry (struct mmu_gather *tlb, pte_t *ptep, unsigned long addre
 	tlb->end_addr = address + PAGE_SIZE;
 }
 
+static inline void
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	if (tlb->start_addr > address)
+		tlb->start_addr = address;
+	if (tlb->end_addr < address + size)
+		tlb->end_addr = address + size;
+}
+
 #define tlb_migrate_finish(mm)	platform_tlb_migrate_finish(mm)
 
 #define tlb_start_vma(tlb, vma)			do { } while (0)
diff --git a/arch/parisc/install.sh b/arch/parisc/install.sh
index 6f68784fea25f..a8c49815f58c8 100644
--- a/arch/parisc/install.sh
+++ b/arch/parisc/install.sh
@@ -39,6 +39,7 @@ verify "$3"
 if [ -n "${INSTALLKERNEL}" ]; then
   if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
   if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+  if [ -x /usr/sbin/${INSTALLKERNEL} ]; then exec /usr/sbin/${INSTALLKERNEL} "$@"; fi
 fi
 
 # Default install
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 15711de104035..d2681d5a3d5a0 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -116,6 +116,20 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 	return tlb_remove_page(tlb, page);
 }
 
+static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
+				unsigned long address, unsigned long size)
+{
+	/*
+	 * the range might exceed the original range that was provided to
+	 * tlb_gather_mmu(), so we need to update it despite the fact it is
+	 * usually not updated.
+	 */
+	if (tlb->start > address)
+		tlb->start = address;
+	if (tlb->end < address + size)
+		tlb->end = address + size;
+}
+
 /*
  * pte_free_tlb frees a pte table and clears the CRSTE for the
  * page table from the tlb.
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 9939879f5f253..2f3b7802d8b87 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -693,9 +693,6 @@ static void __init setup_memory(void)
 		storage_key_init_range(reg->base, reg->base + reg->size);
 	}
 	psw_set_key(PAGE_DEFAULT_KEY);
-
-	/* Only cosmetics */
-	memblock_enforce_memory_limit(memblock_end_of_DRAM());
 }
 
 /*
diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index 025cdb1032f6f..9f6ab2cd10fc8 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -115,6 +115,16 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 	return __tlb_remove_page(tlb, page);
 }
 
+static inline void
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	if (tlb->start > address)
+		tlb->start = address;
+	if (tlb->end < address + size)
+		tlb->end = address + size;
+}
+
 static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
 					 struct page *page)
 {
diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
index 821ff0acfe17f..6fb47b17179ff 100644
--- a/arch/um/include/asm/tlb.h
+++ b/arch/um/include/asm/tlb.h
@@ -128,6 +128,18 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 	return tlb_remove_page(tlb, page);
 }
 
+static inline void
+tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+		    unsigned long size)
+{
+	tlb->need_flush = 1;
+
+	if (tlb->start > address)
+		tlb->start = address;
+	if (tlb->end < address + size)
+		tlb->end = address + size;
+}
+
 /**
  * tlb_remove_tlb_entry - remember a pte unmapping for later tlb invalidation.
  *
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e638e3bc3cb8a..6c40afcfe5b16 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1028,8 +1028,8 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 }
 #endif
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
+#define PKRU_AD_BIT 0x1u
+#define PKRU_WD_BIT 0x2u
 #define PKRU_BITS_PER_PKEY 2
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
diff --git a/block/ioprio.c b/block/ioprio.c
index 01b8116298a13..284bdfa3aacfc 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -202,6 +202,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 				pgrp = task_pgrp(current);
 			else
 				pgrp = find_vpid(who);
+			read_lock(&tasklist_lock);
 			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 				tmpio = get_task_ioprio(p);
 				if (tmpio < 0)
@@ -211,6 +212,8 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 				else
 					ret = ioprio_best(ret, tmpio);
 			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+			read_unlock(&tasklist_lock);
+
 			break;
 		case IOPRIO_WHO_USER:
 			uid = make_kuid(current_user_ns(), who);
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f78f7d06ad9fc..31a204ebfa6c5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1506,7 +1506,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = proc->cred->euid;
+	t->sender_euid = task_euid(proc->tsk);
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
@@ -2641,21 +2641,18 @@ static int binder_free_thread(struct binder_proc *proc,
 	}
 
 	/*
-	 * If this thread used poll, make sure we remove the waitqueue
-	 * from any epoll data structures holding it with POLLFREE.
-	 * waitqueue_active() is safe to use here because we're holding
-	 * the global lock.
+	 * If this thread used poll, make sure we remove the waitqueue from any
+	 * poll data structures holding it.
 	 */
-	if ((thread->looper & BINDER_LOOPER_STATE_POLL) &&
-	    waitqueue_active(&thread->wait)) {
-		wake_up_poll(&thread->wait, POLLHUP | POLLFREE);
-	}
+	if (thread->looper & BINDER_LOOPER_STATE_POLL)
+		wake_up_pollfree(&thread->wait);
 
 	/*
-	 * This is needed to avoid races between wake_up_poll() above and
-	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
-	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
-	 * lock, so we can be sure it's done after calling synchronize_rcu().
+	 * This is needed to avoid races between wake_up_pollfree() above and
+	 * someone else removing the last entry from the queue for other reasons
+	 * (e.g. ep_remove_wait_queue() being called due to an epoll file
+	 * descriptor being closed).  Such other users hold an RCU read lock, so
+	 * we can be sure they're done after we call synchronize_rcu().
 	 */
 	if (thread->looper & BINDER_LOOPER_STATE_POLL)
 		synchronize_rcu();
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d3804b215ffa6..a92cbe1aa72a2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4332,6 +4332,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "VRFDFC22048UCHC-TE*", NULL,		ATA_HORKAGE_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
 	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
+	/* Similar story with ASMedia 1092 */
+	{ "ASMT109x- Config",	NULL,		ATA_HORKAGE_DISABLE },
 
 	/* Weird ATAPI devices */
 	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 100b5a3621ef3..6d2e54209ae69 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1406,6 +1406,14 @@ static int sata_fsl_init_controller(struct ata_host *host)
 	return 0;
 }
 
+static void sata_fsl_host_stop(struct ata_host *host)
+{
+        struct sata_fsl_host_priv *host_priv = host->private_data;
+
+        iounmap(host_priv->hcr_base);
+        kfree(host_priv);
+}
+
 /*
  * scsi mid-layer and libata interface structures
  */
@@ -1438,6 +1446,8 @@ static struct ata_port_operations sata_fsl_ops = {
 	.port_start = sata_fsl_port_start,
 	.port_stop = sata_fsl_port_stop,
 
+	.host_stop      = sata_fsl_host_stop,
+
 	.pmp_attach = sata_fsl_pmp_attach,
 	.pmp_detach = sata_fsl_pmp_detach,
 };
@@ -1492,9 +1502,9 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	host_priv->ssr_base = ssr_base;
 	host_priv->csr_base = csr_base;
 
-	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	if (!irq) {
-		dev_err(&ofdev->dev, "invalid irq from platform\n");
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0) {
+		retval = irq;
 		goto error_exit_with_cleanup;
 	}
 	host_priv->irq = irq;
@@ -1571,10 +1581,6 @@ static int sata_fsl_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
-	irq_dispose_mapping(host_priv->irq);
-	iounmap(host_priv->hcr_base);
-	kfree(host_priv);
-
 	return 0;
 }
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 6ee3e928ebf18..d420597b0d2b4 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -78,6 +78,7 @@ enum blkif_state {
 	BLKIF_STATE_DISCONNECTED,
 	BLKIF_STATE_CONNECTED,
 	BLKIF_STATE_SUSPENDED,
+	BLKIF_STATE_ERROR,
 };
 
 struct grant {
@@ -87,6 +88,7 @@ struct grant {
 };
 
 enum blk_req_status {
+	REQ_PROCESSING,
 	REQ_WAITING,
 	REQ_DONE,
 	REQ_ERROR,
@@ -529,10 +531,10 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
 
 	id = get_id_from_freelist(rinfo);
 	rinfo->shadow[id].request = req;
-	rinfo->shadow[id].status = REQ_WAITING;
+	rinfo->shadow[id].status = REQ_PROCESSING;
 	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
 
-	(*ring_req)->u.rw.id = id;
+	rinfo->shadow[id].req.u.rw.id = id;
 
 	return id;
 }
@@ -540,11 +542,12 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
 static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_info *rinfo)
 {
 	struct blkfront_info *info = rinfo->dev_info;
-	struct blkif_request *ring_req;
+	struct blkif_request *ring_req, *final_ring_req;
 	unsigned long id;
 
 	/* Fill out a communications ring structure. */
-	id = blkif_ring_get_request(rinfo, req, &ring_req);
+	id = blkif_ring_get_request(rinfo, req, &final_ring_req);
+	ring_req = &rinfo->shadow[id].req;
 
 	ring_req->operation = BLKIF_OP_DISCARD;
 	ring_req->u.discard.nr_sectors = blk_rq_sectors(req);
@@ -555,8 +558,9 @@ static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_inf
 	else
 		ring_req->u.discard.flag = 0;
 
-	/* Keep a private copy so we can reissue requests when recovering. */
-	rinfo->shadow[id].req = *ring_req;
+	/* Copy the request to the ring page. */
+	*final_ring_req = *ring_req;
+	rinfo->shadow[id].status = REQ_WAITING;
 
 	return 0;
 }
@@ -689,6 +693,7 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 {
 	struct blkfront_info *info = rinfo->dev_info;
 	struct blkif_request *ring_req, *extra_ring_req = NULL;
+	struct blkif_request *final_ring_req, *final_extra_ring_req = NULL;
 	unsigned long id, extra_id = NO_ASSOCIATED_ID;
 	bool require_extra_req = false;
 	int i;
@@ -730,7 +735,8 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		}
 
 	/* Fill out a communications ring structure. */
-	id = blkif_ring_get_request(rinfo, req, &ring_req);
+	id = blkif_ring_get_request(rinfo, req, &final_ring_req);
+	ring_req = &rinfo->shadow[id].req;
 
 	num_sg = blk_rq_map_sg(req->q, req, rinfo->shadow[id].sg);
 	num_grant = 0;
@@ -781,7 +787,9 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		ring_req->u.rw.nr_segments = num_grant;
 		if (unlikely(require_extra_req)) {
 			extra_id = blkif_ring_get_request(rinfo, req,
-							  &extra_ring_req);
+							  &final_extra_ring_req);
+			extra_ring_req = &rinfo->shadow[extra_id].req;
+
 			/*
 			 * Only the first request contains the scatter-gather
 			 * list.
@@ -823,10 +831,13 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 	if (setup.segments)
 		kunmap_atomic(setup.segments);
 
-	/* Keep a private copy so we can reissue requests when recovering. */
-	rinfo->shadow[id].req = *ring_req;
-	if (unlikely(require_extra_req))
-		rinfo->shadow[extra_id].req = *extra_ring_req;
+	/* Copy request(s) to the ring page. */
+	*final_ring_req = *ring_req;
+	rinfo->shadow[id].status = REQ_WAITING;
+	if (unlikely(require_extra_req)) {
+		*final_extra_ring_req = *extra_ring_req;
+		rinfo->shadow[extra_id].status = REQ_WAITING;
+	}
 
 	if (max_grefs > 0)
 		gnttab_free_grant_references(setup.gref_head);
@@ -1396,8 +1407,8 @@ static enum blk_req_status blkif_rsp_to_req_status(int rsp)
 static int blkif_get_final_status(enum blk_req_status s1,
 				  enum blk_req_status s2)
 {
-	BUG_ON(s1 == REQ_WAITING);
-	BUG_ON(s2 == REQ_WAITING);
+	BUG_ON(s1 < REQ_DONE);
+	BUG_ON(s2 < REQ_DONE);
 
 	if (s1 == REQ_ERROR || s2 == REQ_ERROR)
 		return BLKIF_RSP_ERROR;
@@ -1430,7 +1441,7 @@ static bool blkif_completion(unsigned long *id,
 		s->status = blkif_rsp_to_req_status(bret->status);
 
 		/* Wait the second response if not yet here. */
-		if (s2->status == REQ_WAITING)
+		if (s2->status < REQ_DONE)
 			return 0;
 
 		bret->status = blkif_get_final_status(s->status,
@@ -1538,62 +1549,89 @@ static bool blkif_completion(unsigned long *id,
 static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 {
 	struct request *req;
-	struct blkif_response *bret;
+	struct blkif_response bret;
 	RING_IDX i, rp;
 	unsigned long flags;
 	struct blkfront_ring_info *rinfo = (struct blkfront_ring_info *)dev_id;
 	struct blkfront_info *info = rinfo->dev_info;
 	int error;
+	unsigned int eoiflag = XEN_EOI_FLAG_SPURIOUS;
 
-	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
+	if (unlikely(info->connected != BLKIF_STATE_CONNECTED)) {
+		xen_irq_lateeoi(irq, XEN_EOI_FLAG_SPURIOUS);
 		return IRQ_HANDLED;
+	}
 
 	spin_lock_irqsave(&rinfo->ring_lock, flags);
  again:
-	rp = rinfo->ring.sring->rsp_prod;
-	rmb(); /* Ensure we see queued responses up to 'rp'. */
+	rp = READ_ONCE(rinfo->ring.sring->rsp_prod);
+	virt_rmb(); /* Ensure we see queued responses up to 'rp'. */
+	if (RING_RESPONSE_PROD_OVERFLOW(&rinfo->ring, rp)) {
+		pr_alert("%s: illegal number of responses %u\n",
+			 info->gd->disk_name, rp - rinfo->ring.rsp_cons);
+		goto err;
+	}
 
 	for (i = rinfo->ring.rsp_cons; i != rp; i++) {
 		unsigned long id;
+		unsigned int op;
+
+		eoiflag = 0;
+
+		RING_COPY_RESPONSE(&rinfo->ring, i, &bret);
+		id = bret.id;
 
-		bret = RING_GET_RESPONSE(&rinfo->ring, i);
-		id   = bret->id;
 		/*
 		 * The backend has messed up and given us an id that we would
 		 * never have given to it (we stamp it up to BLK_RING_SIZE -
 		 * look in get_id_from_freelist.
 		 */
 		if (id >= BLK_RING_SIZE(info)) {
-			WARN(1, "%s: response to %s has incorrect id (%ld)\n",
-			     info->gd->disk_name, op_name(bret->operation), id);
-			/* We can't safely get the 'struct request' as
-			 * the id is busted. */
-			continue;
+			pr_alert("%s: response has incorrect id (%ld)\n",
+				 info->gd->disk_name, id);
+			goto err;
 		}
+		if (rinfo->shadow[id].status != REQ_WAITING) {
+			pr_alert("%s: response references no pending request\n",
+				 info->gd->disk_name);
+			goto err;
+		}
+
+		rinfo->shadow[id].status = REQ_PROCESSING;
 		req  = rinfo->shadow[id].request;
 
-		if (bret->operation != BLKIF_OP_DISCARD) {
+		op = rinfo->shadow[id].req.operation;
+		if (op == BLKIF_OP_INDIRECT)
+			op = rinfo->shadow[id].req.u.indirect.indirect_op;
+		if (bret.operation != op) {
+			pr_alert("%s: response has wrong operation (%u instead of %u)\n",
+				 info->gd->disk_name, bret.operation, op);
+			goto err;
+		}
+
+		if (bret.operation != BLKIF_OP_DISCARD) {
 			/*
 			 * We may need to wait for an extra response if the
 			 * I/O request is split in 2
 			 */
-			if (!blkif_completion(&id, rinfo, bret))
+			if (!blkif_completion(&id, rinfo, &bret))
 				continue;
 		}
 
 		if (add_id_to_freelist(rinfo, id)) {
 			WARN(1, "%s: response to %s (id %ld) couldn't be recycled!\n",
-			     info->gd->disk_name, op_name(bret->operation), id);
+			     info->gd->disk_name, op_name(bret.operation), id);
 			continue;
 		}
 
-		error = (bret->status == BLKIF_RSP_OKAY) ? 0 : -EIO;
-		switch (bret->operation) {
+		error = (bret.status == BLKIF_RSP_OKAY) ? 0 : -EIO;
+		switch (bret.operation) {
 		case BLKIF_OP_DISCARD:
-			if (unlikely(bret->status == BLKIF_RSP_EOPNOTSUPP)) {
+			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
 				struct request_queue *rq = info->rq;
-				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
-					   info->gd->disk_name, op_name(bret->operation));
+
+				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
+					   info->gd->disk_name, op_name(bret.operation));
 				error = -EOPNOTSUPP;
 				info->feature_discard = 0;
 				info->feature_secdiscard = 0;
@@ -1604,15 +1642,15 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			break;
 		case BLKIF_OP_FLUSH_DISKCACHE:
 		case BLKIF_OP_WRITE_BARRIER:
-			if (unlikely(bret->status == BLKIF_RSP_EOPNOTSUPP)) {
-				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
-				       info->gd->disk_name, op_name(bret->operation));
+			if (unlikely(bret.status == BLKIF_RSP_EOPNOTSUPP)) {
+				pr_warn_ratelimited("blkfront: %s: %s op failed\n",
+				       info->gd->disk_name, op_name(bret.operation));
 				error = -EOPNOTSUPP;
 			}
-			if (unlikely(bret->status == BLKIF_RSP_ERROR &&
+			if (unlikely(bret.status == BLKIF_RSP_ERROR &&
 				     rinfo->shadow[id].req.u.rw.nr_segments == 0)) {
-				printk(KERN_WARNING "blkfront: %s: empty %s op failed\n",
-				       info->gd->disk_name, op_name(bret->operation));
+				pr_warn_ratelimited("blkfront: %s: empty %s op failed\n",
+				       info->gd->disk_name, op_name(bret.operation));
 				error = -EOPNOTSUPP;
 			}
 			if (unlikely(error)) {
@@ -1625,9 +1663,10 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			/* fall through */
 		case BLKIF_OP_READ:
 		case BLKIF_OP_WRITE:
-			if (unlikely(bret->status != BLKIF_RSP_OKAY))
-				dev_dbg(&info->xbdev->dev, "Bad return from blkdev data "
-					"request: %x\n", bret->status);
+			if (unlikely(bret.status != BLKIF_RSP_OKAY))
+				dev_dbg_ratelimited(&info->xbdev->dev,
+					"Bad return from blkdev data request: %#x\n",
+					bret.status);
 
 			blk_mq_complete_request(req, error);
 			break;
@@ -1650,6 +1689,18 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
 
+	xen_irq_lateeoi(irq, eoiflag);
+
+	return IRQ_HANDLED;
+
+ err:
+	info->connected = BLKIF_STATE_ERROR;
+
+	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
+
+	/* No EOI in order to avoid further interrupts. */
+
+	pr_alert("%s disabled for further use\n", info->gd->disk_name);
 	return IRQ_HANDLED;
 }
 
@@ -1688,8 +1739,8 @@ static int setup_blkring(struct xenbus_device *dev,
 	if (err)
 		goto fail;
 
-	err = bind_evtchn_to_irqhandler(rinfo->evtchn, blkif_interrupt, 0,
-					"blkif", rinfo);
+	err = bind_evtchn_to_irqhandler_lateeoi(rinfo->evtchn, blkif_interrupt,
+						0, "blkif", rinfo);
 	if (err <= 0) {
 		xenbus_dev_fatal(dev, err,
 				 "bind_evtchn_to_irqhandler failed");
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 30c09b9ddbf0d..2069080191eeb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2442,11 +2442,9 @@ static const struct qca_device_info qca_devices_table[] = {
 	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
 };
 
-static int btusb_qca_send_vendor_req(struct hci_dev *hdev, u8 request,
+static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
 				     void *data, u16 size)
 {
-	struct btusb_data *btdata = hci_get_drvdata(hdev);
-	struct usb_device *udev = btdata->udev;
 	int pipe, err;
 	u8 *buf;
 
@@ -2461,7 +2459,7 @@ static int btusb_qca_send_vendor_req(struct hci_dev *hdev, u8 request,
 	err = usb_control_msg(udev, pipe, request, USB_TYPE_VENDOR | USB_DIR_IN,
 			      0, 0, buf, size, USB_CTRL_SET_TIMEOUT);
 	if (err < 0) {
-		BT_ERR("%s: Failed to access otp area (%d)", hdev->name, err);
+		dev_err(&udev->dev, "Failed to access otp area (%d)", err);
 		goto done;
 	}
 
@@ -2617,20 +2615,38 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
 	return err;
 }
 
+/* identify the ROM version and check whether patches are needed */
+static bool btusb_qca_need_patch(struct usb_device *udev)
+{
+	struct qca_version ver;
+
+	if (btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ver,
+				      sizeof(ver)) < 0)
+		return false;
+	/* only low ROM versions need patches */
+	return !(le32_to_cpu(ver.rom_version) & ~0xffffU);
+}
+
 static int btusb_setup_qca(struct hci_dev *hdev)
 {
+	struct btusb_data *btdata = hci_get_drvdata(hdev);
+	struct usb_device *udev = btdata->udev;
 	const struct qca_device_info *info = NULL;
 	struct qca_version ver;
 	u32 ver_rom;
 	u8 status;
 	int i, err;
 
-	err = btusb_qca_send_vendor_req(hdev, QCA_GET_TARGET_VERSION, &ver,
+	err = btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ver,
 					sizeof(ver));
 	if (err < 0)
 		return err;
 
 	ver_rom = le32_to_cpu(ver.rom_version);
+	/* Don't care about high ROM versions */
+	if (ver_rom & ~0xffffU)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
 		if (ver_rom == qca_devices_table[i].rom_version)
 			info = &qca_devices_table[i];
@@ -2641,7 +2657,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		return -ENODEV;
 	}
 
-	err = btusb_qca_send_vendor_req(hdev, QCA_CHECK_STATUS, &status,
+	err = btusb_qca_send_vendor_req(udev, QCA_CHECK_STATUS, &status,
 					sizeof(status));
 	if (err < 0)
 		return err;
@@ -2787,7 +2803,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 		/* Old firmware would otherwise let ath3k driver load
 		 * patch and sysconfig files */
-		if (le16_to_cpu(udev->descriptor.bcdDevice) <= 0x0001)
+		if (le16_to_cpu(udev->descriptor.bcdDevice) <= 0x0001 &&
+		    !btusb_qca_need_patch(udev))
 			return -ENODEV;
 	}
 
@@ -2937,6 +2954,7 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 
 	if (id->driver_info & BTUSB_ATH3012) {
+		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index 15f2e7025b78e..1d5510cb6db4e 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -285,7 +285,7 @@ agp_ioc_init(void __iomem *ioc_regs)
         return 0;
 }
 
-static int
+static int __init
 lba_find_capability(int cap)
 {
 	struct _parisc_agp_info *info = &parisc_agp_info;
@@ -370,7 +370,7 @@ parisc_agp_setup(void __iomem *ioc_hpa, void __iomem *lba_hpa)
 	return error;
 }
 
-static int
+static int __init
 find_quicksilver(struct device *dev, void *data)
 {
 	struct parisc_device **lba = data;
@@ -382,7 +382,7 @@ find_quicksilver(struct device *dev, void *data)
 	return 0;
 }
 
-static int
+static int __init
 parisc_agp_init(void)
 {
 	extern struct sba_device *sba_list;
diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/firmware/scpi_pm_domain.c
index f395dec271131..a6e62a793fbe6 100644
--- a/drivers/firmware/scpi_pm_domain.c
+++ b/drivers/firmware/scpi_pm_domain.c
@@ -27,7 +27,6 @@ struct scpi_pm_domain {
 	struct generic_pm_domain genpd;
 	struct scpi_ops *ops;
 	u32 domain;
-	char name[30];
 };
 
 /*
@@ -121,8 +120,13 @@ static int scpi_pm_domain_probe(struct platform_device *pdev)
 
 		scpi_pd->domain = i;
 		scpi_pd->ops = scpi_ops;
-		sprintf(scpi_pd->name, "%s.%d", np->name, i);
-		scpi_pd->genpd.name = scpi_pd->name;
+		scpi_pd->genpd.name = devm_kasprintf(dev, GFP_KERNEL,
+						     "%s.%d", np->name, i);
+		if (!scpi_pd->genpd.name) {
+			dev_err(dev, "Failed to allocate genpd name:%s.%d\n",
+				np->name, i);
+			continue;
+		}
 		scpi_pd->genpd.power_off = scpi_pd_power_off;
 		scpi_pd->genpd.power_on = scpi_pd_power_on;
 
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index d53e805d392f9..64fc99cf54d5b 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -198,7 +198,7 @@ struct drm_gem_object *vc4_create_object(struct drm_device *dev, size_t size)
 
 	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
 	if (!bo)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	mutex_lock(&vc4->bo_lock);
 	vc4->bo_stats.num_allocated++;
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 8eed456a67bed..da9813f09d7d7 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -136,6 +136,7 @@ config HID_APPLEIR
 
 config HID_ASUS
 	tristate "Asus"
+	depends on USB_HID
 	depends on I2C_HID
 	---help---
 	Support for Asus notebook built-in keyboard via i2c.
@@ -176,14 +177,14 @@ config HID_CHERRY
 
 config HID_CHICONY
 	tristate "Chicony devices"
-	depends on HID
+	depends on USB_HID
 	default !EXPERT
 	---help---
 	Support for Chicony Tactical pad and special keys on Chicony keyboards.
 
 config HID_CORSAIR
 	tristate "Corsair devices"
-	depends on HID && USB && LEDS_CLASS
+	depends on USB_HID && LEDS_CLASS
 	---help---
 	Support for Corsair devices that are not fully compliant with the
 	HID standard.
@@ -194,7 +195,7 @@ config HID_CORSAIR
 
 config HID_PRODIKEYS
 	tristate "Prodikeys PC-MIDI Keyboard support"
-	depends on HID && SND
+	depends on USB_HID && SND
 	select SND_RAWMIDI
 	---help---
 	Support for Prodikeys PC-MIDI Keyboard device support.
@@ -421,7 +422,7 @@ config HID_LENOVO
 
 config HID_LOGITECH
 	tristate "Logitech devices"
-	depends on HID
+	depends on USB_HID
 	default !EXPERT
 	---help---
 	Support for Logitech devices that are not fully compliant with HID standard.
@@ -730,7 +731,7 @@ config HID_SAITEK
 
 config HID_SAMSUNG
 	tristate "Samsung InfraRed remote control or keyboards"
-	depends on HID
+	depends on USB_HID
 	---help---
 	Support for Samsung InfraRed remote control or keyboards.
 
diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
index f04ed9aabc3f9..f11948ddf642e 100644
--- a/drivers/hid/hid-chicony.c
+++ b/drivers/hid/hid-chicony.c
@@ -61,8 +61,12 @@ static int ch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 static __u8 *ch_switch12_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
-	
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return rdesc;
+
+	intf = to_usb_interface(hdev->dev.parent);
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
 		/* Change usage maximum and logical maximum from 0x7fff to
 		 * 0x2fff, so they don't exceed HID_MAX_USAGES */
diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 9ba5d98a11804..d8cf08b6b31c6 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -553,7 +553,12 @@ static int corsair_probe(struct hid_device *dev, const struct hid_device_id *id)
 	int ret;
 	unsigned long quirks = id->driver_data;
 	struct corsair_drvdata *drvdata;
-	struct usb_interface *usbif = to_usb_interface(dev->dev.parent);
+	struct usb_interface *usbif;
+
+	if (!hid_is_usb(dev))
+		return -EINVAL;
+
+	usbif = to_usb_interface(dev->dev.parent);
 
 	drvdata = devm_kzalloc(&dev->dev, sizeof(struct corsair_drvdata),
 			       GFP_KERNEL);
diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 5eea6fe0d7bd8..c3ecac13e6203 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -230,6 +230,9 @@ static int elo_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct elo_priv *priv;
 	int ret;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
diff --git a/drivers/hid/hid-holtek-kbd.c b/drivers/hid/hid-holtek-kbd.c
index ab9da597106fa..2f8eb66397444 100644
--- a/drivers/hid/hid-holtek-kbd.c
+++ b/drivers/hid/hid-holtek-kbd.c
@@ -143,12 +143,17 @@ static int holtek_kbd_input_event(struct input_dev *dev, unsigned int type,
 static int holtek_kbd_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
-	int ret = hid_parse(hdev);
+	struct usb_interface *intf;
+	int ret;
+
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
 
+	ret = hid_parse(hdev);
 	if (!ret)
 		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 
+	intf = to_usb_interface(hdev->dev.parent);
 	if (!ret && intf->cur_altsetting->desc.bInterfaceNumber == 1) {
 		struct hid_input *hidinput;
 		list_for_each_entry(hidinput, &hdev->inputs, list) {
diff --git a/drivers/hid/hid-holtek-mouse.c b/drivers/hid/hid-holtek-mouse.c
index 78b3a0c767751..96db7e96fcea9 100644
--- a/drivers/hid/hid-holtek-mouse.c
+++ b/drivers/hid/hid-holtek-mouse.c
@@ -65,6 +65,29 @@ static __u8 *holtek_mouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int holtek_mouse_probe(struct hid_device *hdev,
+			      const struct hid_device_id *id)
+{
+	int ret;
+
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "hid parse failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct hid_device_id holtek_mouse_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
 			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A067) },
@@ -86,6 +109,7 @@ static struct hid_driver holtek_mouse_driver = {
 	.name = "holtek_mouse",
 	.id_table = holtek_mouse_devices,
 	.report_fixup = holtek_mouse_report_fixup,
+	.probe = holtek_mouse_probe,
 };
 
 module_hid_driver(holtek_mouse_driver);
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 7e55d3f755dd5..f8d1d481c8384 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -714,12 +714,18 @@ static int lg_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
-	__u8 iface_num = iface->cur_altsetting->desc.bInterfaceNumber;
+	struct usb_interface *iface;
+	__u8 iface_num;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
 	struct lg_drv_data *drv_data;
 	int ret;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
+	iface = to_usb_interface(hdev->dev.parent);
+	iface_num = iface->cur_altsetting->desc.bInterfaceNumber;
+
 	/* G29 only work with the 1st interface */
 	if ((hdev->product == USB_DEVICE_ID_LOGITECH_G29_WHEEL) &&
 	    (iface_num != 0)) {
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 762f33817dd0d..7c3e42efbc567 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -803,12 +803,18 @@ static int pk_raw_event(struct hid_device *hdev, struct hid_report *report,
 static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
-	unsigned short ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+	struct usb_interface *intf;
+	unsigned short ifnum;
 	unsigned long quirks = id->driver_data;
 	struct pk_device *pk;
 	struct pcmidi_snd *pm = NULL;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+
 	pk = kzalloc(sizeof(*pk), GFP_KERNEL);
 	if (pk == NULL) {
 		hid_err(hdev, "can't alloc descriptor\n");
diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 329c5d1270f94..fb545a11214f0 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -347,6 +347,9 @@ static int arvo_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 02db537f8f3ea..c07a7ea8a6873 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -327,6 +327,9 @@ static int isku_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 9be8c31f613fd..ef978586ff2f5 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -752,6 +752,9 @@ static int kone_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 09e8fc72aa1d4..b63de4c5b5dd3 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -434,6 +434,9 @@ static int koneplus_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 07de2f9014c67..ef9508822e5f0 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -136,6 +136,9 @@ static int konepure_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 317c9c2c0a7ce..6256c211398a1 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -504,6 +504,9 @@ static int kovaplus_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-lua.c b/drivers/hid/hid-roccat-lua.c
index ac1a7313e2596..13ae2a7d176d3 100644
--- a/drivers/hid/hid-roccat-lua.c
+++ b/drivers/hid/hid-roccat-lua.c
@@ -163,6 +163,9 @@ static int lua_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index b30aa7b82bf87..027aa9d0ec1f2 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -452,6 +452,9 @@ static int pyra_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index 47cc8f30ff6d4..fda4a396a12e8 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -144,6 +144,9 @@ static int ryos_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 6dbf6e04dce75..0230fb54f08a5 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -116,6 +116,9 @@ static int savu_probe(struct hid_device *hdev,
 {
 	int retval;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	retval = hid_parse(hdev);
 	if (retval) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index 7cbb067d4a9e3..89bb2260367f3 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -157,6 +157,9 @@ static int samsung_probe(struct hid_device *hdev,
 	int ret;
 	unsigned int cmask = HID_CONNECT_DEFAULT;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index 1509d7287ff3e..b3f2e40b1c5bd 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -791,6 +791,9 @@ static int uclogic_tablet_enable(struct hid_device *hdev)
 	__u8 *p;
 	s32 v;
 
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
 	/*
 	 * Read string descriptor containing tablet parameters. The specific
 	 * string descriptor and data were discovered by sniffing the Windows
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 800c477dd0761..518ccf15188ef 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -875,7 +875,7 @@ static int i2c_hid_power(struct hid_device *hid, int lvl)
 	return 0;
 }
 
-static struct hid_ll_driver i2c_hid_ll_driver = {
+struct hid_ll_driver i2c_hid_ll_driver = {
 	.parse = i2c_hid_parse,
 	.start = i2c_hid_start,
 	.stop = i2c_hid_stop,
@@ -885,6 +885,7 @@ static struct hid_ll_driver i2c_hid_ll_driver = {
 	.output_report = i2c_hid_output_report,
 	.raw_request = i2c_hid_raw_request,
 };
+EXPORT_SYMBOL_GPL(i2c_hid_ll_driver);
 
 static int i2c_hid_init_irq(struct i2c_client *client)
 {
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 731a7b3e01870..e60e41e775020 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -372,7 +372,7 @@ static int uhid_hid_output_report(struct hid_device *hid, __u8 *buf,
 	return uhid_hid_output_raw(hid, buf, count, HID_OUTPUT_REPORT);
 }
 
-static struct hid_ll_driver uhid_hid_driver = {
+struct hid_ll_driver uhid_hid_driver = {
 	.start = uhid_hid_start,
 	.stop = uhid_hid_stop,
 	.open = uhid_hid_open,
@@ -381,6 +381,7 @@ static struct hid_ll_driver uhid_hid_driver = {
 	.raw_request = uhid_hid_raw_request,
 	.output_report = uhid_hid_output_report,
 };
+EXPORT_SYMBOL_GPL(uhid_hid_driver);
 
 #ifdef CONFIG_COMPAT
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 368f849decd1f..cb57ccff31c20 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1272,7 +1272,7 @@ static int usbhid_idle(struct hid_device *hid, int report, int idle,
 	return hid_set_idle(dev, ifnum, report, idle);
 }
 
-static struct hid_ll_driver usb_hid_driver = {
+struct hid_ll_driver usb_hid_driver = {
 	.parse = usbhid_parse,
 	.start = usbhid_start,
 	.stop = usbhid_stop,
@@ -1285,6 +1285,7 @@ static struct hid_ll_driver usb_hid_driver = {
 	.output_report = usbhid_output_report,
 	.idle = usbhid_idle,
 };
+EXPORT_SYMBOL_GPL(usb_hid_driver);
 
 static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index e8b90b534f08e..b74fcda49a223 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -506,7 +506,7 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 	 * Skip the query for this type and modify defaults based on
 	 * interface number.
 	 */
-	if (features->type == WIRELESS) {
+	if (features->type == WIRELESS && intf) {
 		if (intf->cur_altsetting->desc.bInterfaceNumber == 0)
 			features->device_type = WACOM_DEVICETYPE_WL_MONITOR;
 		else
@@ -2115,6 +2115,9 @@ static void wacom_wireless_work(struct work_struct *work)
 
 	wacom_destroy_battery(wacom);
 
+	if (!usbdev)
+		return;
+
 	/* Stylus interface */
 	hdev1 = usb_get_intfdata(usbdev->config->interface[1]);
 	wacom1 = hid_get_drvdata(hdev1);
@@ -2354,8 +2357,6 @@ static void wacom_remote_work(struct work_struct *work)
 static int wacom_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
-	struct usb_device *dev = interface_to_usbdev(intf);
 	struct wacom *wacom;
 	struct wacom_wac *wacom_wac;
 	struct wacom_features *features;
@@ -2388,8 +2389,14 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom_wac->hid_data.inputmode = -1;
 	wacom_wac->mode_report = -1;
 
-	wacom->usbdev = dev;
-	wacom->intf = intf;
+	if (hid_is_usb(hdev)) {
+		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+		struct usb_device *dev = interface_to_usbdev(intf);
+
+		wacom->usbdev = dev;
+		wacom->intf = intf;
+	}
+
 	mutex_init(&wacom->lock);
 	INIT_WORK(&wacom->wireless_work, wacom_wireless_work);
 	INIT_WORK(&wacom->battery_work, wacom_battery_work);
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 34704b0451b49..d19ad92eede95 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -578,15 +578,18 @@ static const struct file_operations i8k_fops = {
 	.unlocked_ioctl	= i8k_ioctl,
 };
 
+static struct proc_dir_entry *entry;
+
 static void __init i8k_init_procfs(void)
 {
 	/* Register the proc entry */
-	proc_create("i8k", 0, NULL, &i8k_fops);
+	entry = proc_create("i8k", 0, NULL, &i8k_fops);
 }
 
 static void __exit i8k_exit_procfs(void)
 {
-	remove_proc_entry("i8k", NULL);
+	if (entry)
+		remove_proc_entry("i8k", NULL);
 }
 
 #else
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 293d1184976b3..1e9f029a328a6 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -196,6 +196,7 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 #define LM90_STATUS_RHIGH	(1 << 4) /* remote high temp limit tripped */
 #define LM90_STATUS_LLOW	(1 << 5) /* local low temp limit tripped */
 #define LM90_STATUS_LHIGH	(1 << 6) /* local high temp limit tripped */
+#define LM90_STATUS_BUSY	(1 << 7) /* conversion is ongoing */
 
 #define MAX6696_STATUS2_R2THRM	(1 << 1) /* remote2 THERM limit tripped */
 #define MAX6696_STATUS2_R2OPEN	(1 << 2) /* remote2 is an open circuit */
@@ -692,7 +693,7 @@ static int lm90_update_device(struct device *dev)
 		val = lm90_read_reg(client, LM90_REG_R_STATUS);
 		if (val < 0)
 			return val;
-		data->alarms = val;	/* lower 8 bit of alarms */
+		data->alarms = val & ~LM90_STATUS_BUSY;
 
 		if (data->kind == max6696) {
 			val = lm90_select_remote_channel(client, data, 1);
@@ -1345,12 +1346,11 @@ static int lm90_detect(struct i2c_client *client,
 	if (man_id < 0 || chip_id < 0 || config1 < 0 || convrate < 0)
 		return -ENODEV;
 
-	if (man_id == 0x01 || man_id == 0x5C || man_id == 0x41) {
+	if (man_id == 0x01 || man_id == 0x5C || man_id == 0xA1) {
 		config2 = i2c_smbus_read_byte_data(client, LM90_REG_R_CONFIG2);
 		if (config2 < 0)
 			return -ENODEV;
-	} else
-		config2 = 0;		/* Make compiler happy */
+	}
 
 	if ((address == 0x4C || address == 0x4D)
 	 && man_id == 0x01) { /* National Semiconductor */
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index df220666d6274..b4f8cd7dc8b74 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -424,8 +424,8 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
 	if (!(ipd & REG_INT_MBRF))
 		return;
 
-	/* ack interrupt */
-	i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
+	/* ack interrupt (read also produces a spurious START flag, clear it too) */
+	i2c_writel(i2c, REG_INT_MBRF | REG_INT_START, REG_IPD);
 
 	/* Can only handle a maximum of 32 bytes at a time */
 	if (len > 32)
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 626a605a0c0e6..799457aa36020 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1290,8 +1290,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	return 0;
 
 err_buffer_cleanup:
-	if (data->dready_trig)
-		iio_triggered_buffer_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 err_trigger_unregister:
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
@@ -1314,8 +1313,8 @@ static int kxcjk1013_remove(struct i2c_client *client)
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
+	iio_triggered_buffer_cleanup(indio_dev);
 	if (data->dready_trig) {
-		iio_triggered_buffer_cleanup(indio_dev);
 		iio_trigger_unregister(data->dready_trig);
 		iio_trigger_unregister(data->motion_trig);
 	}
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 1bda730a71c0b..c3ac798083f4f 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -227,14 +227,14 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 			       hw_values.chan,
 			       sizeof(hw_values.chan));
 	if (ret) {
-		dev_err(st->dev,
-			"error reading data\n");
-		return ret;
+		dev_err(st->dev, "error reading data: %d\n", ret);
+		goto out;
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev,
 					   &hw_values,
 					   iio_get_time_ns(indio_dev));
+out:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 90d4179e8c3de..0346c37b1e285 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1389,7 +1389,7 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	indio_dev->trig = trig;
+	indio_dev->trig = iio_trigger_get(trig);
 
 	return 0;
 }
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index e04483254b283..7157b1a731a60 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -64,9 +64,9 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 
+error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
 
-error_ret:
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 414fe857fa9d7..5e3cbb694a753 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1248,7 +1248,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 		ret = regmap_bulk_read(data->regmap, LTR501_ALS_DATA1,
 				       (u8 *)als_buf, sizeof(als_buf));
 		if (ret < 0)
-			return ret;
+			goto done;
 		if (test_bit(0, indio_dev->active_scan_mask))
 			scan.channels[j++] = le16_to_cpu(als_buf[1]);
 		if (test_bit(1, indio_dev->active_scan_mask))
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 45cf8b0a43637..ed9cf1ffec7bc 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -546,9 +546,8 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
 	mutex_lock(&data->lock);
 	ret = regmap_field_read(data->reg_flag_nf, &dir);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "register read failed\n");
-		mutex_unlock(&data->lock);
-		return ret;
+		dev_err(&data->client->dev, "register read failed: %d\n", ret);
+		goto out;
 	}
 	event = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
 				     IIO_EV_TYPE_THRESH,
@@ -560,6 +559,7 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
 	ret = regmap_field_write(data->reg_flag_psint, 0);
 	if (ret < 0)
 		dev_err(&data->client->dev, "failed to reset interrupts\n");
+out:
 	mutex_unlock(&data->lock);
 
 	return IRQ_HANDLED;
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 9dc8cf096e2ea..93ace2609bdd1 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -955,7 +955,7 @@ void hfi1_free_ctxtdata(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd)
 	kfree(rcd->egrbufs.rcvtids);
 
 	for (e = 0; e < rcd->egrbufs.alloced; e++) {
-		if (rcd->egrbufs.buffers[e].dma)
+		if (rcd->egrbufs.buffers[e].addr)
 			dma_free_coherent(&dd->pcidev->dev,
 					  rcd->egrbufs.buffers[e].len,
 					  rcd->egrbufs.buffers[e].addr,
diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index 0dc15f95e7626..2d0b992579d6f 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -946,7 +946,7 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 					       &addrlimit) ||
 			    addrlimit > type_max(typeof(pkt->addrlimit))) {
 				ret = -EINVAL;
-				goto free_pbc;
+				goto free_pkt;
 			}
 			pkt->addrlimit = addrlimit;
 
diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
index f4445a4e8d6a5..cfa1be4ad8689 100644
--- a/drivers/input/joystick/spaceball.c
+++ b/drivers/input/joystick/spaceball.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/input.h>
 #include <linux/serio.h>
+#include <asm/unaligned.h>
 
 #define DRIVER_DESC	"SpaceTec SpaceBall 2003/3003/4000 FLX driver"
 
@@ -91,9 +92,15 @@ static void spaceball_process_packet(struct spaceball* spaceball)
 
 		case 'D':					/* Ball data */
 			if (spaceball->idx != 15) return;
-			for (i = 0; i < 6; i++)
+			/*
+			 * Skip first three bytes; read six axes worth of data.
+			 * Axis values are signed 16-bit big-endian.
+			 */
+			data += 3;
+			for (i = 0; i < ARRAY_SIZE(spaceball_axes); i++) {
 				input_report_abs(dev, spaceball_axes[i],
-					(__s16)((data[2 * i + 3] << 8) | data[2 * i + 2]));
+					(__s16)get_unaligned_be16(&data[i * 2]));
+			}
 			break;
 
 		case 'K':					/* Button data */
diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index ef234c9b2f2f5..11773838a34d4 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -929,6 +929,8 @@ static int atp_probe(struct usb_interface *iface,
 	set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
 	set_bit(BTN_LEFT, input_dev->keybit);
 
+	INIT_WORK(&dev->work, atp_reinit);
+
 	error = input_register_device(dev->input);
 	if (error)
 		goto err_free_buffer;
@@ -936,8 +938,6 @@ static int atp_probe(struct usb_interface *iface,
 	/* save our data pointer in this interface device */
 	usb_set_intfdata(iface, dev);
 
-	INIT_WORK(&dev->work, atp_reinit);
-
 	return 0;
 
  err_free_buffer:
diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index 8d7f9c8f2771c..db499ef6ccff4 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -79,8 +79,8 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 	data_present = touchscreen_get_prop_u32(dev, "touchscreen-size-x",
 						input_abs_get_max(input,
 								  axis) + 1,
-						&maximum) |
-		       touchscreen_get_prop_u32(dev, "touchscreen-fuzz-x",
+						&maximum);
+	data_present |= touchscreen_get_prop_u32(dev, "touchscreen-fuzz-x",
 						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
@@ -90,8 +90,8 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 	data_present = touchscreen_get_prop_u32(dev, "touchscreen-size-y",
 						input_abs_get_max(input,
 								  axis) + 1,
-						&maximum) |
-		       touchscreen_get_prop_u32(dev, "touchscreen-fuzz-y",
+						&maximum);
+	data_present |= touchscreen_get_prop_u32(dev, "touchscreen-fuzz-y",
 						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
@@ -101,11 +101,11 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
 	data_present = touchscreen_get_prop_u32(dev,
 						"touchscreen-max-pressure",
 						input_abs_get_max(input, axis),
-						&maximum) |
-		       touchscreen_get_prop_u32(dev,
-						"touchscreen-fuzz-pressure",
-						input_abs_get_fuzz(input, axis),
-						&fuzz);
+						&maximum);
+	data_present |= touchscreen_get_prop_u32(dev,
+						 "touchscreen-fuzz-pressure",
+						 input_abs_get_fuzz(input, axis),
+						 &fuzz);
 	if (data_present)
 		touchscreen_set_params(input, axis, maximum, fuzz);
 
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 8bcee65a0b8c9..ace01a626b098 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -153,16 +153,12 @@ static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int virq,
 	int hwirq, i;
 
 	mutex_lock(&msi_used_lock);
+	hwirq = bitmap_find_free_region(msi_used, PCI_MSI_DOORBELL_NR,
+					order_base_2(nr_irqs));
+	mutex_unlock(&msi_used_lock);
 
-	hwirq = bitmap_find_next_zero_area(msi_used, PCI_MSI_DOORBELL_NR,
-					   0, nr_irqs, 0);
-	if (hwirq >= PCI_MSI_DOORBELL_NR) {
-		mutex_unlock(&msi_used_lock);
+	if (hwirq < 0)
 		return -ENOSPC;
-	}
-
-	bitmap_set(msi_used, hwirq, nr_irqs);
-	mutex_unlock(&msi_used_lock);
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
@@ -171,7 +167,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int virq,
 				    NULL, NULL);
 	}
 
-	return hwirq;
+	return 0;
 }
 
 static void armada_370_xp_msi_free(struct irq_domain *domain,
@@ -180,7 +176,7 @@ static void armada_370_xp_msi_free(struct irq_domain *domain,
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 
 	mutex_lock(&msi_used_lock);
-	bitmap_clear(msi_used, d->hwirq, nr_irqs);
+	bitmap_release_region(msi_used, d->hwirq, order_base_2(nr_irqs));
 	mutex_unlock(&msi_used_lock);
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d1efbb8dadc53..a964e381cbb81 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -369,7 +369,7 @@ static struct its_collection *its_build_invall_cmd(struct its_cmd_block *cmd,
 
 	its_fixup_cmd(cmd);
 
-	return NULL;
+	return desc->its_invall_cmd.col;
 }
 
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index b1777104fd9fe..9694529b709de 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -29,7 +29,7 @@
 
 #define NVIC_ISER		0x000
 #define NVIC_ICER		0x080
-#define NVIC_IPR		0x300
+#define NVIC_IPR		0x400
 
 #define NVIC_MAX_BANKS		16
 /*
diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index faf505462a4f5..f5a06a6fb297f 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -390,7 +390,7 @@ mISDNInit(void)
 	err = mISDN_inittimer(&debug);
 	if (err)
 		goto error2;
-	err = l1_init(&debug);
+	err = Isdnl1_Init(&debug);
 	if (err)
 		goto error3;
 	err = Isdnl2_Init(&debug);
@@ -404,7 +404,7 @@ mISDNInit(void)
 error5:
 	Isdnl2_cleanup();
 error4:
-	l1_cleanup();
+	Isdnl1_cleanup();
 error3:
 	mISDN_timer_cleanup();
 error2:
@@ -417,7 +417,7 @@ static void mISDN_cleanup(void)
 {
 	misdn_sock_cleanup();
 	Isdnl2_cleanup();
-	l1_cleanup();
+	Isdnl1_cleanup();
 	mISDN_timer_cleanup();
 	class_unregister(&mISDN_class);
 
diff --git a/drivers/isdn/mISDN/core.h b/drivers/isdn/mISDN/core.h
index 52695bb81ee7a..3c039b6ade2e1 100644
--- a/drivers/isdn/mISDN/core.h
+++ b/drivers/isdn/mISDN/core.h
@@ -69,8 +69,8 @@ struct Bprotocol	*get_Bprotocol4id(u_int);
 extern int	mISDN_inittimer(u_int *);
 extern void	mISDN_timer_cleanup(void);
 
-extern int	l1_init(u_int *);
-extern void	l1_cleanup(void);
+extern int	Isdnl1_Init(u_int *);
+extern void	Isdnl1_cleanup(void);
 extern int	Isdnl2_Init(u_int *);
 extern void	Isdnl2_cleanup(void);
 
diff --git a/drivers/isdn/mISDN/layer1.c b/drivers/isdn/mISDN/layer1.c
index bebc57b72138e..94d7cc58da648 100644
--- a/drivers/isdn/mISDN/layer1.c
+++ b/drivers/isdn/mISDN/layer1.c
@@ -407,7 +407,7 @@ create_l1(struct dchannel *dch, dchannel_l1callback *dcb) {
 EXPORT_SYMBOL(create_l1);
 
 int
-l1_init(u_int *deb)
+Isdnl1_Init(u_int *deb)
 {
 	debug = deb;
 	l1fsm_s.state_count = L1S_STATE_COUNT;
@@ -419,7 +419,7 @@ l1_init(u_int *deb)
 }
 
 void
-l1_cleanup(void)
+Isdnl1_cleanup(void)
 {
 	mISDN_FsmFree(&l1fsm_s);
 }
diff --git a/drivers/md/persistent-data/dm-btree-remove.c b/drivers/md/persistent-data/dm-btree-remove.c
index 9e4d1212f4c16..63f2baed3c8a6 100644
--- a/drivers/md/persistent-data/dm-btree-remove.c
+++ b/drivers/md/persistent-data/dm-btree-remove.c
@@ -423,9 +423,9 @@ static int rebalance_children(struct shadow_spine *s,
 
 		memcpy(n, dm_block_data(child),
 		       dm_bm_block_size(dm_tm_get_bm(info->tm)));
-		dm_tm_unlock(info->tm, child);
 
 		dm_tm_dec(info->tm, dm_block_location(child));
+		dm_tm_unlock(info->tm, child);
 		return 0;
 	}
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 258cb3999b0e3..5c6a962363096 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1408,7 +1408,7 @@ static int bond_option_ad_actor_system_set(struct bonding *bond,
 		mac = (u8 *)&newval->value;
 	}
 
-	if (!is_valid_ether_addr(mac))
+	if (is_multicast_ether_addr(mac))
 		goto err;
 
 	netdev_info(bond->dev, "Setting ad_actor_system to %pM\n", mac);
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index c1317889d3d8d..ced11ea892698 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -703,11 +703,11 @@ static int pch_can_rx_normal(struct net_device *ndev, u32 obj_num, int quota)
 			cf->data[i + 1] = data_reg >> 8;
 		}
 
-		netif_receive_skb(skb);
 		rcv_pkts++;
 		stats->rx_packets++;
 		quota--;
 		stats->rx_bytes += cf->can_dlc;
+		netif_receive_skb(skb);
 
 		pch_fifo_thresh(priv, obj_num);
 		obj_num++;
diff --git a/drivers/net/can/sja1000/ems_pcmcia.c b/drivers/net/can/sja1000/ems_pcmcia.c
index 381de998d2f16..fef5c59c0f4ca 100644
--- a/drivers/net/can/sja1000/ems_pcmcia.c
+++ b/drivers/net/can/sja1000/ems_pcmcia.c
@@ -243,7 +243,12 @@ static int ems_pcmcia_add_card(struct pcmcia_device *pdev, unsigned long base)
 			free_sja1000dev(dev);
 	}
 
-	err = request_irq(dev->irq, &ems_pcmcia_interrupt, IRQF_SHARED,
+	if (!card->channels) {
+		err = -ENODEV;
+		goto failure_cleanup;
+	}
+
+	err = request_irq(pdev->irq, &ems_pcmcia_interrupt, IRQF_SHARED,
 			  DRV_NAME, card);
 	if (!err)
 		return 0;
diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 792a1afabf5d1..5ab088d02fbad 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -31,7 +31,10 @@
 #define USB_SEND_TIMEOUT		1000 /* msecs */
 #define USB_RECV_TIMEOUT		1000 /* msecs */
 #define RX_BUFFER_SIZE			3072
-#define CAN_USB_CLOCK			8000000
+#define KVASER_USB_CAN_CLOCK_8MHZ	8000000
+#define KVASER_USB_CAN_CLOCK_16MHZ	16000000
+#define KVASER_USB_CAN_CLOCK_24MHZ	24000000
+#define KVASER_USB_CAN_CLOCK_32MHZ	32000000
 #define MAX_NET_DEVICES			3
 #define MAX_USBCAN_NET_DEVICES		2
 
@@ -142,6 +145,12 @@ static inline bool kvaser_is_usbcan(const struct usb_device_id *id)
 #define CMD_LEAF_USB_THROTTLE		77
 #define CMD_LEAF_LOG_MESSAGE		106
 
+/* Leaf frequency options */
+#define KVASER_USB_LEAF_SWOPTION_FREQ_MASK 0x60
+#define KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK 0
+#define KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK BIT(5)
+#define KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK BIT(6)
+
 /* error factors */
 #define M16C_EF_ACKE			BIT(0)
 #define M16C_EF_CRCE			BIT(1)
@@ -472,6 +481,8 @@ struct kvaser_usb {
 	bool rxinitdone;
 	void *rxbuf[MAX_RX_URBS];
 	dma_addr_t rxbuf_dma[MAX_RX_URBS];
+
+	struct can_clock clock;
 };
 
 struct kvaser_usb_net_priv {
@@ -652,6 +663,27 @@ static int kvaser_usb_send_simple_msg(const struct kvaser_usb *dev,
 	return rc;
 }
 
+static void kvaser_usb_get_software_info_leaf(struct kvaser_usb *dev,
+					      const struct leaf_msg_softinfo *softinfo)
+{
+	u32 sw_options = le32_to_cpu(softinfo->sw_options);
+
+	dev->fw_version = le32_to_cpu(softinfo->fw_version);
+	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
+
+	switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
+	case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
+		dev->clock.freq = KVASER_USB_CAN_CLOCK_16MHZ;
+		break;
+	case KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK:
+		dev->clock.freq = KVASER_USB_CAN_CLOCK_24MHZ;
+		break;
+	case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
+		dev->clock.freq = KVASER_USB_CAN_CLOCK_32MHZ;
+		break;
+	}
+}
+
 static int kvaser_usb_get_software_info(struct kvaser_usb *dev)
 {
 	struct kvaser_msg msg;
@@ -667,14 +699,13 @@ static int kvaser_usb_get_software_info(struct kvaser_usb *dev)
 
 	switch (dev->family) {
 	case KVASER_LEAF:
-		dev->fw_version = le32_to_cpu(msg.u.leaf.softinfo.fw_version);
-		dev->max_tx_urbs =
-			le16_to_cpu(msg.u.leaf.softinfo.max_outstanding_tx);
+		kvaser_usb_get_software_info_leaf(dev, &msg.u.leaf.softinfo);
 		break;
 	case KVASER_USBCAN:
 		dev->fw_version = le32_to_cpu(msg.u.usbcan.softinfo.fw_version);
 		dev->max_tx_urbs =
 			le16_to_cpu(msg.u.usbcan.softinfo.max_outstanding_tx);
+		dev->clock.freq = KVASER_USB_CAN_CLOCK_8MHZ;
 		break;
 	}
 
@@ -1926,7 +1957,7 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
 	kvaser_usb_reset_tx_urb_contexts(priv);
 
 	priv->can.state = CAN_STATE_STOPPED;
-	priv->can.clock.freq = CAN_USB_CLOCK;
+	priv->can.clock.freq = dev->clock.freq;
 	priv->can.bittiming_const = &kvaser_usb_bittiming_const;
 	priv->can.do_set_bittiming = kvaser_usb_set_bittiming;
 	priv->can.do_set_mode = kvaser_usb_set_mode;
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index e306342506f1f..e02b99f77b1ca 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1361,16 +1361,19 @@ static int altera_tse_probe(struct platform_device *pdev)
 		priv->rxdescmem_busaddr = dma_res->start;
 
 	} else {
+		ret = -ENODEV;
 		goto err_free_netdev;
 	}
 
-	if (!dma_set_mask(priv->device, DMA_BIT_MASK(priv->dmaops->dmamask)))
+	if (!dma_set_mask(priv->device, DMA_BIT_MASK(priv->dmaops->dmamask))) {
 		dma_set_coherent_mask(priv->device,
 				      DMA_BIT_MASK(priv->dmaops->dmamask));
-	else if (!dma_set_mask(priv->device, DMA_BIT_MASK(32)))
+	} else if (!dma_set_mask(priv->device, DMA_BIT_MASK(32))) {
 		dma_set_coherent_mask(priv->device, DMA_BIT_MASK(32));
-	else
+	} else {
+		ret = -EIO;
 		goto err_free_netdev;
+	}
 
 	/* MAC address space */
 	ret = request_and_map(pdev, "control_port", &control_port,
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 5d67dbdd943dc..98392a069f2b2 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -90,9 +90,13 @@ static inline void tdma_port_write_desc_addr(struct bcm_sysport_priv *priv,
 					     struct dma_desc *desc,
 					     unsigned int port)
 {
+	unsigned long desc_flags;
+
 	/* Ports are latched, so write upper address first */
+	spin_lock_irqsave(&priv->desc_lock, desc_flags);
 	tdma_writel(priv, desc->addr_status_len, TDMA_WRITE_PORT_HI(port));
 	tdma_writel(priv, desc->addr_lo, TDMA_WRITE_PORT_LO(port));
+	spin_unlock_irqrestore(&priv->desc_lock, desc_flags);
 }
 
 /* Ethtool operations */
@@ -1587,6 +1591,7 @@ static int bcm_sysport_open(struct net_device *dev)
 	}
 
 	/* Initialize both hardware and software ring */
+	spin_lock_init(&priv->desc_lock);
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		ret = bcm_sysport_init_tx_ring(priv, i);
 		if (ret) {
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index 0d3444f1d78a0..1cf5af2b11e1f 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -660,6 +660,7 @@ struct bcm_sysport_priv {
 	int			wol_irq;
 
 	/* Transmit rings */
+	spinlock_t		desc_lock;
 	struct bcm_sysport_tx_ring tx_rings[TDMA_NUM_RINGS];
 
 	/* Receive queue */
diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 005c79b5b3f01..a5a291b848b06 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -4704,6 +4704,10 @@ type3_infoblock(struct net_device *dev, u_char count, u_char *p)
         lp->ibn = 3;
         lp->active = *p++;
 	if (MOTO_SROM_BUG) lp->active = 0;
+	/* if (MOTO_SROM_BUG) statement indicates lp->active could
+	 * be 8 (i.e. the size of array lp->phy) */
+	if (WARN_ON(lp->active >= ARRAY_SIZE(lp->phy)))
+		return -EINVAL;
 	lp->phy[lp->active].gep = (*p ? p : NULL); p += (2 * (*p) + 1);
 	lp->phy[lp->active].rst = (*p ? p : NULL); p += (2 * (*p) + 1);
 	lp->phy[lp->active].mc  = get_unaligned_le16(p); p += 2;
@@ -4995,19 +4999,23 @@ mii_get_phy(struct net_device *dev)
 	}
 	if ((j == limit) && (i < DE4X5_MAX_MII)) {
 	    for (k=0; k < DE4X5_MAX_PHY && lp->phy[k].id; k++);
-	    lp->phy[k].addr = i;
-	    lp->phy[k].id = id;
-	    lp->phy[k].spd.reg = GENERIC_REG;      /* ANLPA register         */
-	    lp->phy[k].spd.mask = GENERIC_MASK;    /* 100Mb/s technologies   */
-	    lp->phy[k].spd.value = GENERIC_VALUE;  /* TX & T4, H/F Duplex    */
-	    lp->mii_cnt++;
-	    lp->active++;
-	    printk("%s: Using generic MII device control. If the board doesn't operate,\nplease mail the following dump to the author:\n", dev->name);
-	    j = de4x5_debug;
-	    de4x5_debug |= DEBUG_MII;
-	    de4x5_dbg_mii(dev, k);
-	    de4x5_debug = j;
-	    printk("\n");
+	    if (k < DE4X5_MAX_PHY) {
+		lp->phy[k].addr = i;
+		lp->phy[k].id = id;
+		lp->phy[k].spd.reg = GENERIC_REG;      /* ANLPA register         */
+		lp->phy[k].spd.mask = GENERIC_MASK;    /* 100Mb/s technologies   */
+		lp->phy[k].spd.value = GENERIC_VALUE;  /* TX & T4, H/F Duplex    */
+		lp->mii_cnt++;
+		lp->active++;
+		printk("%s: Using generic MII device control. If the board doesn't operate,\nplease mail the following dump to the author:\n", dev->name);
+		j = de4x5_debug;
+		de4x5_debug |= DEBUG_MII;
+		de4x5_dbg_mii(dev, k);
+		de4x5_debug = j;
+		printk("\n");
+	    } else {
+		goto purgatory;
+	    }
 	}
     }
   purgatory:
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5ea740b4cf14c..b4e23ab108527 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -371,6 +371,9 @@ struct bufdesc_ex {
 #define FEC_ENET_WAKEUP	((uint)0x00020000)	/* Wakeup request */
 #define FEC_ENET_TXF	(FEC_ENET_TXF_0 | FEC_ENET_TXF_1 | FEC_ENET_TXF_2)
 #define FEC_ENET_RXF	(FEC_ENET_RXF_0 | FEC_ENET_RXF_1 | FEC_ENET_RXF_2)
+#define FEC_ENET_RXF_GET(X)	(((X) == 0) ? FEC_ENET_RXF_0 :	\
+				(((X) == 1) ? FEC_ENET_RXF_1 :	\
+				FEC_ENET_RXF_2))
 #define FEC_ENET_TS_AVAIL       ((uint)0x00010000)
 #define FEC_ENET_TS_TIMER       ((uint)0x00008000)
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5fc40f025d214..c06ac5f66a17c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1380,7 +1380,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF, fep->hwp + FEC_IEVENT);
+		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index 4986f6ba278a3..45ac5cf717ea8 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1658,7 +1658,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 	fman = dev_get_drvdata(&fm_pdev->dev);
 	if (!fman) {
 		err = -EINVAL;
-		goto return_err;
+		goto put_device;
 	}
 
 	err = of_property_read_u32(port_node, "cell-index", &val);
@@ -1666,7 +1666,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 		dev_err(port->dev, "%s: reading cell-index for %s failed\n",
 			__func__, port_node->full_name);
 		err = -EINVAL;
-		goto return_err;
+		goto put_device;
 	}
 	port_id = (u8)val;
 	port->dts_params.id = port_id;
@@ -1700,7 +1700,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 	}  else {
 		dev_err(port->dev, "%s: Illegal port type\n", __func__);
 		err = -EINVAL;
-		goto return_err;
+		goto put_device;
 	}
 
 	port->dts_params.type = port_type;
@@ -1714,7 +1714,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 			dev_err(port->dev, "%s: incorrect qman-channel-id\n",
 				__func__);
 			err = -EINVAL;
-			goto return_err;
+			goto put_device;
 		}
 		port->dts_params.qman_channel_id = qman_channel_id;
 	}
@@ -1724,7 +1724,7 @@ static int fman_port_probe(struct platform_device *of_dev)
 		dev_err(port->dev, "%s: of_address_to_resource() failed\n",
 			__func__);
 		err = -ENOMEM;
-		goto return_err;
+		goto put_device;
 	}
 
 	port->dts_params.fman = fman;
@@ -1749,6 +1749,8 @@ static int fman_port_probe(struct platform_device *of_dev)
 
 	return 0;
 
+put_device:
+	put_device(&fm_pdev->dev);
 return_err:
 	of_node_put(port_node);
 free_port:
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index 67accce1d33d0..e89a62c6f2301 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -312,6 +312,10 @@ static void hns_dsaf_ge_srst_by_port(struct dsaf_device *dsaf_dev, u32 port,
 		return;
 
 	if (!HNS_DSAF_IS_DEBUG(dsaf_dev)) {
+		/* DSAF_MAX_PORT_NUM is 6, but DSAF_GE_NUM is 8.
+		   We need check to prevent array overflow */
+		if (port >= DSAF_MAX_PORT_NUM)
+			return;
 		reg_val_1  = 0x1 << port;
 		port_rst_off = dsaf_dev->mac_cb[port]->port_rst_off;
 		/* there is difference between V1 and V2 in register.*/
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e7585f6c4665b..104f8eb828a04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5429,6 +5429,27 @@ int i40e_open(struct net_device *netdev)
 	return 0;
 }
 
+/**
+ * i40e_netif_set_realnum_tx_rx_queues - Update number of tx/rx queues
+ * @vsi: vsi structure
+ *
+ * This updates netdev's number of tx/rx queues
+ *
+ * Returns status of setting tx/rx queues
+ **/
+static int i40e_netif_set_realnum_tx_rx_queues(struct i40e_vsi *vsi)
+{
+	int ret;
+
+	ret = netif_set_real_num_rx_queues(vsi->netdev,
+					   vsi->num_queue_pairs);
+	if (ret)
+		return ret;
+
+	return netif_set_real_num_tx_queues(vsi->netdev,
+					    vsi->num_queue_pairs);
+}
+
 /**
  * i40e_vsi_open -
  * @vsi: the VSI to open
@@ -5463,13 +5484,7 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
 			goto err_setup_rx;
 
 		/* Notify the stack of the actual queue counts. */
-		err = netif_set_real_num_tx_queues(vsi->netdev,
-						   vsi->num_queue_pairs);
-		if (err)
-			goto err_set_queues;
-
-		err = netif_set_real_num_rx_queues(vsi->netdev,
-						   vsi->num_queue_pairs);
+		err = i40e_netif_set_realnum_tx_rx_queues(vsi);
 		if (err)
 			goto err_set_queues;
 
@@ -9908,6 +9923,9 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	case I40E_VSI_VMDQ2:
 	case I40E_VSI_FCOE:
 		ret = i40e_config_netdev(vsi);
+		if (ret)
+			goto err_netdev;
+		ret = i40e_netif_set_realnum_tx_rx_queues(vsi);
 		if (ret)
 			goto err_netdev;
 		ret = register_netdev(vsi->netdev);
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 5428e39fa4e5c..7587a8f98619a 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2846,6 +2846,7 @@ static int igbvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_hw_init:
+	netif_napi_del(&adapter->rx_ring->napi);
 	kfree(adapter->tx_ring);
 	kfree(adapter->rx_ring);
 err_sw_init:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 8466f3874a285..5029db8835d7d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2597,6 +2597,9 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	/* flush pending Tx transactions */
 	ixgbe_clear_tx_pending(hw);
 
+	/* set MDIO speed before talking to the PHY in case it's the 1st time */
+	ixgbe_set_mdio_speed(hw);
+
 	/* PHY ops must be identified and initialized prior to reset */
 
 	/* Identify PHY and related function pointers */
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 410a36c982419..1569300844f0c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -620,7 +620,7 @@ void __init mlx4_en_init_ptys2ethtool_map(void)
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_1000BASE_T, SPEED_1000,
 				       ETHTOOL_LINK_MODE_1000baseT_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_1000BASE_CX_SGMII, SPEED_1000,
-				       ETHTOOL_LINK_MODE_1000baseKX_Full_BIT);
+				       ETHTOOL_LINK_MODE_1000baseX_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_1000BASE_KX, SPEED_1000,
 				       ETHTOOL_LINK_MODE_1000baseKX_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_T, SPEED_10000,
@@ -632,9 +632,9 @@ void __init mlx4_en_init_ptys2ethtool_map(void)
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_KR, SPEED_10000,
 				       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_CR, SPEED_10000,
-				       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT);
+				       ETHTOOL_LINK_MODE_10000baseCR_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_10GBASE_SR, SPEED_10000,
-				       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT);
+				       ETHTOOL_LINK_MODE_10000baseSR_Full_BIT);
 	MLX4_BUILD_PTYS2ETHTOOL_CONFIG(MLX4_20GBASE_KR2, SPEED_20000,
 				       ETHTOOL_LINK_MODE_20000baseMLD2_Full_BIT,
 				       ETHTOOL_LINK_MODE_20000baseKR2_Full_BIT);
diff --git a/drivers/net/ethernet/natsemi/xtsonic.c b/drivers/net/ethernet/natsemi/xtsonic.c
index 7007d212f3e4e..9b041848b3895 100644
--- a/drivers/net/ethernet/natsemi/xtsonic.c
+++ b/drivers/net/ethernet/natsemi/xtsonic.c
@@ -128,7 +128,7 @@ static const struct net_device_ops xtsonic_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 };
 
-static int __init sonic_probe1(struct net_device *dev)
+static int sonic_probe1(struct net_device *dev)
 {
 	static unsigned version_printed = 0;
 	unsigned int silicon_revision;
diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index cb9d43c871c4c..147effc16316f 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -3491,20 +3491,19 @@ static int ql_adapter_up(struct ql3_adapter *qdev)
 
 	spin_lock_irqsave(&qdev->hw_lock, hw_flags);
 
-	err = ql_wait_for_drvr_lock(qdev);
-	if (err) {
-		err = ql_adapter_initialize(qdev);
-		if (err) {
-			netdev_err(ndev, "Unable to initialize adapter\n");
-			goto err_init;
-		}
-		netdev_err(ndev, "Releasing driver lock\n");
-		ql_sem_unlock(qdev, QL_DRVR_SEM_MASK);
-	} else {
+	if (!ql_wait_for_drvr_lock(qdev)) {
 		netdev_err(ndev, "Could not acquire driver lock\n");
+		err = -ENODEV;
 		goto err_lock;
 	}
 
+	err = ql_adapter_initialize(qdev);
+	if (err) {
+		netdev_err(ndev, "Unable to initialize adapter\n");
+		goto err_init;
+	}
+	ql_sem_unlock(qdev, QL_DRVR_SEM_MASK);
+
 	spin_unlock_irqrestore(&qdev->hw_lock, hw_flags);
 
 	set_bit(QL_ADAPTER_UP, &qdev->flags);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index dce36e9e1879c..59b77bb891475 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -1078,8 +1078,14 @@ static int qlcnic_83xx_add_rings(struct qlcnic_adapter *adapter)
 	sds_mbx_size = sizeof(struct qlcnic_sds_mbx);
 	context_id = recv_ctx->context_id;
 	num_sds = adapter->drv_sds_rings - QLCNIC_MAX_SDS_RINGS;
-	ahw->hw_ops->alloc_mbx_args(&cmd, adapter,
-				    QLCNIC_CMD_ADD_RCV_RINGS);
+	err = ahw->hw_ops->alloc_mbx_args(&cmd, adapter,
+					QLCNIC_CMD_ADD_RCV_RINGS);
+	if (err) {
+		dev_err(&adapter->pdev->dev,
+			"Failed to alloc mbx args %d\n", err);
+		return err;
+	}
+
 	cmd.req.arg[1] = 0 | (num_sds << 8) | (context_id << 16);
 
 	/* set up status rings, mbx 2-81 */
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h
index 5f327659efa7a..85b688f60b876 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h
@@ -202,7 +202,7 @@ int qlcnic_sriov_get_vf_vport_info(struct qlcnic_adapter *,
 				   struct qlcnic_info *, u16);
 int qlcnic_sriov_cfg_vf_guest_vlan(struct qlcnic_adapter *, u16, u8);
 void qlcnic_sriov_free_vlans(struct qlcnic_adapter *);
-void qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *);
+int qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *);
 bool qlcnic_sriov_check_any_vlan(struct qlcnic_vf_info *);
 void qlcnic_sriov_del_vlan_id(struct qlcnic_sriov *,
 			      struct qlcnic_vf_info *, u16);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index c58180f408448..44caa7c2077ec 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -433,7 +433,7 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 					    struct qlcnic_cmd_args *cmd)
 {
 	struct qlcnic_sriov *sriov = adapter->ahw->sriov;
-	int i, num_vlans;
+	int i, num_vlans, ret;
 	u16 *vlans;
 
 	if (sriov->allowed_vlans)
@@ -444,7 +444,9 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 	dev_info(&adapter->pdev->dev, "Number of allowed Guest VLANs = %d\n",
 		 sriov->num_allowed_vlans);
 
-	qlcnic_sriov_alloc_vlans(adapter);
+	ret = qlcnic_sriov_alloc_vlans(adapter);
+	if (ret)
+		return ret;
 
 	if (!sriov->any_vlan)
 		return 0;
@@ -2164,7 +2166,7 @@ static int qlcnic_sriov_vf_resume(struct qlcnic_adapter *adapter)
 	return err;
 }
 
-void qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *adapter)
+int qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *adapter)
 {
 	struct qlcnic_sriov *sriov = adapter->ahw->sriov;
 	struct qlcnic_vf_info *vf;
@@ -2174,7 +2176,11 @@ void qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *adapter)
 		vf = &sriov->vf_info[i];
 		vf->sriov_vlans = kcalloc(sriov->num_allowed_vlans,
 					  sizeof(*vf->sriov_vlans), GFP_KERNEL);
+		if (!vf->sriov_vlans)
+			return -ENOMEM;
 	}
+
+	return 0;
 }
 
 void qlcnic_sriov_free_vlans(struct qlcnic_adapter *adapter)
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
index 50eaafa3eaba3..c9f2cd2462230 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
@@ -598,7 +598,9 @@ static int __qlcnic_pci_sriov_enable(struct qlcnic_adapter *adapter,
 	if (err)
 		goto del_flr_queue;
 
-	qlcnic_sriov_alloc_vlans(adapter);
+	err = qlcnic_sriov_alloc_vlans(adapter);
+	if (err)
+		goto del_flr_queue;
 
 	return err;
 
diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index d0cf971aa4ebe..4237bd311e0e6 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -2088,6 +2088,11 @@ static int smc911x_drv_probe(struct platform_device *pdev)
 
 	ndev->dma = (unsigned char)-1;
 	ndev->irq = platform_get_irq(pdev, 0);
+	if (ndev->irq < 0) {
+		ret = ndev->irq;
+		goto release_both;
+	}
+
 	lp = netdev_priv(ndev);
 	lp->netdev = ndev;
 #ifdef SMC_DYNAMIC_BUS_CONFIG
diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 440047a239f57..26bb43a675131 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1219,6 +1219,11 @@ static int fjes_probe(struct platform_device *plat_dev)
 	hw->hw_res.start = res->start;
 	hw->hw_res.size = resource_size(res);
 	hw->hw_res.irq = platform_get_irq(plat_dev, 0);
+	if (hw->hw_res.irq < 0) {
+		err = hw->hw_res.irq;
+		goto err_free_control_wq;
+	}
+
 	err = fjes_hw_init(&adapter->hw);
 	if (err)
 		goto err_free_control_wq;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 76340bc3cf445..8d85cedb4bf5b 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -803,13 +803,14 @@ static void mkiss_close(struct tty_struct *tty)
 	 */
 	netif_stop_queue(ax->dev);
 
-	/* Free all AX25 frame buffers. */
+	unregister_netdev(ax->dev);
+
+	/* Free all AX25 frame buffers after unreg. */
 	kfree(ax->rbuff);
 	kfree(ax->xbuff);
 
 	ax->tty = NULL;
 
-	unregister_netdev(ax->dev);
 	free_netdev(ax->dev);
 }
 
diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 0ee54fba0a237..92df7c2d5850e 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -79,7 +79,9 @@ static int atusb_control_msg(struct atusb *atusb, unsigned int pipe,
 
 	ret = usb_control_msg(usb_dev, pipe, request, requesttype,
 			      value, index, data, size, timeout);
-	if (ret < 0) {
+	if (ret < size) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		atusb->err = ret;
 		dev_err(&usb_dev->dev,
 			"atusb_control_msg: req 0x%02x val 0x%x idx 0x%x, error %d\n",
@@ -637,9 +639,9 @@ static int atusb_get_and_show_build(struct atusb *atusb)
 	if (!build)
 		return -ENOMEM;
 
-	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
-				ATUSB_BUILD, ATUSB_REQ_FROM_DEV, 0, 0,
-				build, ATUSB_BUILD_SIZE, 1000);
+	/* We cannot call atusb_control_msg() here, since this request may read various length data */
+	ret = usb_control_msg(atusb->usb_dev, usb_rcvctrlpipe(usb_dev, 0), ATUSB_BUILD,
+			      ATUSB_REQ_FROM_DEV, 0, 0, build, ATUSB_BUILD_SIZE, 1000);
 	if (ret >= 0) {
 		build[ret] = 0;
 		dev_info(&usb_dev->dev, "Firmware: build %s\n", build);
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5a5db2f09f788..8ed525a063cfb 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -175,6 +175,8 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 	/* clamp new_tx to sane values */
 	min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth16);
 	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
+	if (max == 0)
+		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
 
 	/* some devices set dwNtbOutMaxSize too low for the above default */
 	min = min(min, max);
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index bce898ad6e96f..580c1e7666a45 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -67,6 +67,8 @@
 #define LAN7850_USB_PRODUCT_ID		(0x7850)
 #define LAN78XX_EEPROM_MAGIC		(0x78A5)
 #define LAN78XX_OTP_MAGIC		(0x78F3)
+#define AT29M2AF_USB_VENDOR_ID		(0x07C9)
+#define AT29M2AF_USB_PRODUCT_ID	(0x0012)
 
 #define	MII_READ			1
 #define	MII_WRITE			0
@@ -865,11 +867,9 @@ static int lan78xx_read_otp(struct lan78xx_net *dev, u32 offset,
 	ret = lan78xx_read_raw_otp(dev, 0, 1, &sig);
 
 	if (ret == 0) {
-		if (sig == OTP_INDICATOR_1)
-			offset = offset;
-		else if (sig == OTP_INDICATOR_2)
+		if (sig == OTP_INDICATOR_2)
 			offset += 0x100;
-		else
+		else if (sig != OTP_INDICATOR_1)
 			ret = -EINVAL;
 		if (!ret)
 			ret = lan78xx_read_raw_otp(dev, offset, length, data);
@@ -3758,6 +3758,10 @@ static const struct usb_device_id products[] = {
 	/* LAN7850 USB Gigabit Ethernet Device */
 	USB_DEVICE(LAN78XX_USB_VENDOR_ID, LAN7850_USB_PRODUCT_ID),
 	},
+	{
+	/* ATM2-AF USB Gigabit Ethernet Device */
+	USB_DEVICE(AT29M2AF_USB_VENDOR_ID, AT29M2AF_USB_PRODUCT_ID),
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(usb, products);
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index dc5b8e69f8e86..9567bd00a8144 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -619,6 +619,11 @@ static const struct usb_device_id	products [] = {
 	USB_DEVICE_AND_INTERFACE_INFO(0x1630, 0x0042,
 				      USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
 	.driver_info = (unsigned long) &rndis_poll_status_info,
+}, {
+	/* Hytera Communications DMR radios' "Radio to PC Network" */
+	USB_VENDOR_AND_INTERFACE_INFO(0x238b,
+				      USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
+	.driver_info = (unsigned long)&rndis_info,
 }, {
 	/* RNDIS is MSFT's un-official variant of CDC ACM */
 	USB_INTERFACE_INFO(USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3b6e908d31646..9ac1dbf0a993c 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -226,6 +226,7 @@ static netdev_tx_t vrf_process_v6_outbound(struct sk_buff *skb,
 	/* strip the ethernet header added for pass through VRF device */
 	__skb_pull(skb, skb_network_offset(skb));
 
+	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 	ret = vrf_ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(ret)))
 		dev->stats.tx_errors++;
@@ -332,6 +333,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
 					       RT_SCOPE_LINK);
 	}
 
+	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	ret = vrf_ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 	if (unlikely(net_xmit_eval(ret)))
 		vrf_dev->stats.tx_errors++;
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 53477280f39c2..7c848852aa094 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -321,9 +321,9 @@ static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
 
 	adapter->seq_num++;
 	sleep_cfm_buf->seq_num =
-		cpu_to_le16((HostCmd_SET_SEQ_NO_BSS_INFO
+		cpu_to_le16(HostCmd_SET_SEQ_NO_BSS_INFO
 					(adapter->seq_num, priv->bss_num,
-					 priv->bss_type)));
+					 priv->bss_type));
 
 	mwifiex_dbg(adapter, CMD,
 		    "cmd: DNLD_CMD: %#x, act %#x, len %d, seqno %#x\n",
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 341f6ed5b3556..fccce1b4afcd1 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -482,10 +482,10 @@ enum mwifiex_channel_flags {
 
 #define RF_ANTENNA_AUTO                 0xFFFF
 
-#define HostCmd_SET_SEQ_NO_BSS_INFO(seq, num, type) {   \
-	(((seq) & 0x00ff) |                             \
-	 (((num) & 0x000f) << 8)) |                     \
-	(((type) & 0x000f) << 12);                  }
+#define HostCmd_SET_SEQ_NO_BSS_INFO(seq, num, type) \
+	((((seq) & 0x00ff) |                        \
+	 (((num) & 0x000f) << 8)) |                 \
+	(((type) & 0x000f) << 12))
 
 #define HostCmd_GET_SEQ_NO(seq)       \
 	((seq) & HostCmd_SEQ_NUM_MASK)
diff --git a/drivers/net/xen-netback/common.h b/drivers/net/xen-netback/common.h
index 347c796afd4ed..bfa3c6aaebe6b 100644
--- a/drivers/net/xen-netback/common.h
+++ b/drivers/net/xen-netback/common.h
@@ -203,6 +203,7 @@ struct xenvif_queue { /* Per-queue data for xenvif */
 	unsigned int rx_queue_max;
 	unsigned int rx_queue_len;
 	unsigned long last_rx_time;
+	unsigned int rx_slots_needed;
 	bool stalled;
 
 	struct xenvif_copy_state rx_copy;
diff --git a/drivers/net/xen-netback/rx.c b/drivers/net/xen-netback/rx.c
index ddfb1cfa2dd94..29c7645f57805 100644
--- a/drivers/net/xen-netback/rx.c
+++ b/drivers/net/xen-netback/rx.c
@@ -33,28 +33,36 @@
 #include <xen/xen.h>
 #include <xen/events.h>
 
-static bool xenvif_rx_ring_slots_available(struct xenvif_queue *queue)
+/*
+ * Update the needed ring page slots for the first SKB queued.
+ * Note that any call sequence outside the RX thread calling this function
+ * needs to wake up the RX thread via a call of xenvif_kick_thread()
+ * afterwards in order to avoid a race with putting the thread to sleep.
+ */
+static void xenvif_update_needed_slots(struct xenvif_queue *queue,
+				       const struct sk_buff *skb)
 {
-	RING_IDX prod, cons;
-	struct sk_buff *skb;
-	int needed;
-	unsigned long flags;
-
-	spin_lock_irqsave(&queue->rx_queue.lock, flags);
+	unsigned int needed = 0;
 
-	skb = skb_peek(&queue->rx_queue);
-	if (!skb) {
-		spin_unlock_irqrestore(&queue->rx_queue.lock, flags);
-		return false;
+	if (skb) {
+		needed = DIV_ROUND_UP(skb->len, XEN_PAGE_SIZE);
+		if (skb_is_gso(skb))
+			needed++;
+		if (skb->sw_hash)
+			needed++;
 	}
 
-	needed = DIV_ROUND_UP(skb->len, XEN_PAGE_SIZE);
-	if (skb_is_gso(skb))
-		needed++;
-	if (skb->sw_hash)
-		needed++;
+	WRITE_ONCE(queue->rx_slots_needed, needed);
+}
 
-	spin_unlock_irqrestore(&queue->rx_queue.lock, flags);
+static bool xenvif_rx_ring_slots_available(struct xenvif_queue *queue)
+{
+	RING_IDX prod, cons;
+	unsigned int needed;
+
+	needed = READ_ONCE(queue->rx_slots_needed);
+	if (!needed)
+		return false;
 
 	do {
 		prod = queue->rx.sring->req_prod;
@@ -80,13 +88,19 @@ void xenvif_rx_queue_tail(struct xenvif_queue *queue, struct sk_buff *skb)
 
 	spin_lock_irqsave(&queue->rx_queue.lock, flags);
 
-	__skb_queue_tail(&queue->rx_queue, skb);
-
-	queue->rx_queue_len += skb->len;
-	if (queue->rx_queue_len > queue->rx_queue_max) {
+	if (queue->rx_queue_len >= queue->rx_queue_max) {
 		struct net_device *dev = queue->vif->dev;
 
 		netif_tx_stop_queue(netdev_get_tx_queue(dev, queue->id));
+		kfree_skb(skb);
+		queue->vif->dev->stats.rx_dropped++;
+	} else {
+		if (skb_queue_empty(&queue->rx_queue))
+			xenvif_update_needed_slots(queue, skb);
+
+		__skb_queue_tail(&queue->rx_queue, skb);
+
+		queue->rx_queue_len += skb->len;
 	}
 
 	spin_unlock_irqrestore(&queue->rx_queue.lock, flags);
@@ -100,6 +114,8 @@ static struct sk_buff *xenvif_rx_dequeue(struct xenvif_queue *queue)
 
 	skb = __skb_dequeue(&queue->rx_queue);
 	if (skb) {
+		xenvif_update_needed_slots(queue, skb_peek(&queue->rx_queue));
+
 		queue->rx_queue_len -= skb->len;
 		if (queue->rx_queue_len < queue->rx_queue_max) {
 			struct netdev_queue *txq;
@@ -134,6 +150,7 @@ static void xenvif_rx_queue_drop_expired(struct xenvif_queue *queue)
 			break;
 		xenvif_rx_dequeue(queue);
 		kfree_skb(skb);
+		queue->vif->dev->stats.rx_dropped++;
 	}
 }
 
@@ -474,27 +491,31 @@ void xenvif_rx_action(struct xenvif_queue *queue)
 	xenvif_rx_copy_flush(queue);
 }
 
-static bool xenvif_rx_queue_stalled(struct xenvif_queue *queue)
+static RING_IDX xenvif_rx_queue_slots(const struct xenvif_queue *queue)
 {
 	RING_IDX prod, cons;
 
 	prod = queue->rx.sring->req_prod;
 	cons = queue->rx.req_cons;
 
+	return prod - cons;
+}
+
+static bool xenvif_rx_queue_stalled(const struct xenvif_queue *queue)
+{
+	unsigned int needed = READ_ONCE(queue->rx_slots_needed);
+
 	return !queue->stalled &&
-		prod - cons < 1 &&
+		xenvif_rx_queue_slots(queue) < needed &&
 		time_after(jiffies,
 			   queue->last_rx_time + queue->vif->stall_timeout);
 }
 
 static bool xenvif_rx_queue_ready(struct xenvif_queue *queue)
 {
-	RING_IDX prod, cons;
-
-	prod = queue->rx.sring->req_prod;
-	cons = queue->rx.req_cons;
+	unsigned int needed = READ_ONCE(queue->rx_slots_needed);
 
-	return queue->stalled && prod - cons >= 1;
+	return queue->stalled && xenvif_rx_queue_slots(queue) >= needed;
 }
 
 bool xenvif_have_rx_work(struct xenvif_queue *queue, bool test_kthread)
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 0971c09363cbf..65a50bc5661d2 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -120,21 +120,17 @@ struct netfront_queue {
 
 	/*
 	 * {tx,rx}_skbs store outstanding skbuffs. Free tx_skb entries
-	 * are linked from tx_skb_freelist through skb_entry.link.
-	 *
-	 *  NB. Freelist index entries are always going to be less than
-	 *  PAGE_OFFSET, whereas pointers to skbs will always be equal or
-	 *  greater than PAGE_OFFSET: we use this property to distinguish
-	 *  them.
+	 * are linked from tx_skb_freelist through tx_link.
 	 */
-	union skb_entry {
-		struct sk_buff *skb;
-		unsigned long link;
-	} tx_skbs[NET_TX_RING_SIZE];
+	struct sk_buff *tx_skbs[NET_TX_RING_SIZE];
+	unsigned short tx_link[NET_TX_RING_SIZE];
+#define TX_LINK_NONE 0xffff
+#define TX_PENDING   0xfffe
 	grant_ref_t gref_tx_head;
 	grant_ref_t grant_tx_ref[NET_TX_RING_SIZE];
 	struct page *grant_tx_page[NET_TX_RING_SIZE];
 	unsigned tx_skb_freelist;
+	unsigned int tx_pend_queue;
 
 	spinlock_t   rx_lock ____cacheline_aligned_in_smp;
 	struct xen_netif_rx_front_ring rx;
@@ -145,6 +141,9 @@ struct netfront_queue {
 	struct sk_buff *rx_skbs[NET_RX_RING_SIZE];
 	grant_ref_t gref_rx_head;
 	grant_ref_t grant_rx_ref[NET_RX_RING_SIZE];
+
+	unsigned int rx_rsp_unconsumed;
+	spinlock_t rx_cons_lock;
 };
 
 struct netfront_info {
@@ -160,6 +159,9 @@ struct netfront_info {
 	struct netfront_stats __percpu *rx_stats;
 	struct netfront_stats __percpu *tx_stats;
 
+	/* Is device behaving sane? */
+	bool broken;
+
 	atomic_t rx_gso_checksum_fixup;
 };
 
@@ -168,33 +170,25 @@ struct netfront_rx_info {
 	struct xen_netif_extra_info extras[XEN_NETIF_EXTRA_TYPE_MAX - 1];
 };
 
-static void skb_entry_set_link(union skb_entry *list, unsigned short id)
-{
-	list->link = id;
-}
-
-static int skb_entry_is_link(const union skb_entry *list)
-{
-	BUILD_BUG_ON(sizeof(list->skb) != sizeof(list->link));
-	return (unsigned long)list->skb < PAGE_OFFSET;
-}
-
 /*
  * Access macros for acquiring freeing slots in tx_skbs[].
  */
 
-static void add_id_to_freelist(unsigned *head, union skb_entry *list,
-			       unsigned short id)
+static void add_id_to_list(unsigned *head, unsigned short *list,
+			   unsigned short id)
 {
-	skb_entry_set_link(&list[id], *head);
+	list[id] = *head;
 	*head = id;
 }
 
-static unsigned short get_id_from_freelist(unsigned *head,
-					   union skb_entry *list)
+static unsigned short get_id_from_list(unsigned *head, unsigned short *list)
 {
 	unsigned int id = *head;
-	*head = list[id].link;
+
+	if (id != TX_LINK_NONE) {
+		*head = list[id];
+		list[id] = TX_LINK_NONE;
+	}
 	return id;
 }
 
@@ -352,7 +346,7 @@ static int xennet_open(struct net_device *dev)
 	unsigned int i = 0;
 	struct netfront_queue *queue = NULL;
 
-	if (!np->queues)
+	if (!np->queues || np->broken)
 		return -ENODEV;
 
 	for (i = 0; i < num_queues; ++i) {
@@ -374,33 +368,56 @@ static int xennet_open(struct net_device *dev)
 	return 0;
 }
 
-static void xennet_tx_buf_gc(struct netfront_queue *queue)
+static bool xennet_tx_buf_gc(struct netfront_queue *queue)
 {
 	RING_IDX cons, prod;
 	unsigned short id;
 	struct sk_buff *skb;
 	bool more_to_do;
+	bool work_done = false;
+	const struct device *dev = &queue->info->netdev->dev;
 
 	BUG_ON(!netif_carrier_ok(queue->info->netdev));
 
 	do {
 		prod = queue->tx.sring->rsp_prod;
+		if (RING_RESPONSE_PROD_OVERFLOW(&queue->tx, prod)) {
+			dev_alert(dev, "Illegal number of responses %u\n",
+				  prod - queue->tx.rsp_cons);
+			goto err;
+		}
 		rmb(); /* Ensure we see responses up to 'rp'. */
 
 		for (cons = queue->tx.rsp_cons; cons != prod; cons++) {
-			struct xen_netif_tx_response *txrsp;
+			struct xen_netif_tx_response txrsp;
 
-			txrsp = RING_GET_RESPONSE(&queue->tx, cons);
-			if (txrsp->status == XEN_NETIF_RSP_NULL)
+			work_done = true;
+
+			RING_COPY_RESPONSE(&queue->tx, cons, &txrsp);
+			if (txrsp.status == XEN_NETIF_RSP_NULL)
 				continue;
 
-			id  = txrsp->id;
-			skb = queue->tx_skbs[id].skb;
+			id = txrsp.id;
+			if (id >= RING_SIZE(&queue->tx)) {
+				dev_alert(dev,
+					  "Response has incorrect id (%u)\n",
+					  id);
+				goto err;
+			}
+			if (queue->tx_link[id] != TX_PENDING) {
+				dev_alert(dev,
+					  "Response for inactive request\n");
+				goto err;
+			}
+
+			queue->tx_link[id] = TX_LINK_NONE;
+			skb = queue->tx_skbs[id];
+			queue->tx_skbs[id] = NULL;
 			if (unlikely(gnttab_query_foreign_access(
 				queue->grant_tx_ref[id]) != 0)) {
-				pr_alert("%s: warning -- grant still in use by backend domain\n",
-					 __func__);
-				BUG();
+				dev_alert(dev,
+					  "Grant still in use by backend domain\n");
+				goto err;
 			}
 			gnttab_end_foreign_access_ref(
 				queue->grant_tx_ref[id], GNTMAP_readonly);
@@ -408,7 +425,7 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
 				&queue->gref_tx_head, queue->grant_tx_ref[id]);
 			queue->grant_tx_ref[id] = GRANT_INVALID_REF;
 			queue->grant_tx_page[id] = NULL;
-			add_id_to_freelist(&queue->tx_skb_freelist, queue->tx_skbs, id);
+			add_id_to_list(&queue->tx_skb_freelist, queue->tx_link, id);
 			dev_kfree_skb_irq(skb);
 		}
 
@@ -418,13 +435,22 @@ static void xennet_tx_buf_gc(struct netfront_queue *queue)
 	} while (more_to_do);
 
 	xennet_maybe_wake_tx(queue);
+
+	return work_done;
+
+ err:
+	queue->info->broken = true;
+	dev_alert(dev, "Disabled for further use\n");
+
+	return work_done;
 }
 
 struct xennet_gnttab_make_txreq {
 	struct netfront_queue *queue;
 	struct sk_buff *skb;
 	struct page *page;
-	struct xen_netif_tx_request *tx; /* Last request */
+	struct xen_netif_tx_request *tx;      /* Last request on ring page */
+	struct xen_netif_tx_request tx_local; /* Last request local copy*/
 	unsigned int size;
 };
 
@@ -440,7 +466,7 @@ static void xennet_tx_setup_grant(unsigned long gfn, unsigned int offset,
 	struct netfront_queue *queue = info->queue;
 	struct sk_buff *skb = info->skb;
 
-	id = get_id_from_freelist(&queue->tx_skb_freelist, queue->tx_skbs);
+	id = get_id_from_list(&queue->tx_skb_freelist, queue->tx_link);
 	tx = RING_GET_REQUEST(&queue->tx, queue->tx.req_prod_pvt++);
 	ref = gnttab_claim_grant_reference(&queue->gref_tx_head);
 	WARN_ON_ONCE(IS_ERR_VALUE((unsigned long)(int)ref));
@@ -448,34 +474,37 @@ static void xennet_tx_setup_grant(unsigned long gfn, unsigned int offset,
 	gnttab_grant_foreign_access_ref(ref, queue->info->xbdev->otherend_id,
 					gfn, GNTMAP_readonly);
 
-	queue->tx_skbs[id].skb = skb;
+	queue->tx_skbs[id] = skb;
 	queue->grant_tx_page[id] = page;
 	queue->grant_tx_ref[id] = ref;
 
-	tx->id = id;
-	tx->gref = ref;
-	tx->offset = offset;
-	tx->size = len;
-	tx->flags = 0;
+	info->tx_local.id = id;
+	info->tx_local.gref = ref;
+	info->tx_local.offset = offset;
+	info->tx_local.size = len;
+	info->tx_local.flags = 0;
+
+	*tx = info->tx_local;
+
+	/*
+	 * Put the request in the pending queue, it will be set to be pending
+	 * when the producer index is about to be raised.
+	 */
+	add_id_to_list(&queue->tx_pend_queue, queue->tx_link, id);
 
 	info->tx = tx;
-	info->size += tx->size;
+	info->size += info->tx_local.size;
 }
 
 static struct xen_netif_tx_request *xennet_make_first_txreq(
-	struct netfront_queue *queue, struct sk_buff *skb,
-	struct page *page, unsigned int offset, unsigned int len)
+	struct xennet_gnttab_make_txreq *info,
+	unsigned int offset, unsigned int len)
 {
-	struct xennet_gnttab_make_txreq info = {
-		.queue = queue,
-		.skb = skb,
-		.page = page,
-		.size = 0,
-	};
+	info->size = 0;
 
-	gnttab_for_one_grant(page, offset, len, xennet_tx_setup_grant, &info);
+	gnttab_for_one_grant(info->page, offset, len, xennet_tx_setup_grant, info);
 
-	return info.tx;
+	return info->tx;
 }
 
 static void xennet_make_one_txreq(unsigned long gfn, unsigned int offset,
@@ -488,35 +517,27 @@ static void xennet_make_one_txreq(unsigned long gfn, unsigned int offset,
 	xennet_tx_setup_grant(gfn, offset, len, data);
 }
 
-static struct xen_netif_tx_request *xennet_make_txreqs(
-	struct netfront_queue *queue, struct xen_netif_tx_request *tx,
-	struct sk_buff *skb, struct page *page,
+static void xennet_make_txreqs(
+	struct xennet_gnttab_make_txreq *info,
+	struct page *page,
 	unsigned int offset, unsigned int len)
 {
-	struct xennet_gnttab_make_txreq info = {
-		.queue = queue,
-		.skb = skb,
-		.tx = tx,
-	};
-
 	/* Skip unused frames from start of page */
 	page += offset >> PAGE_SHIFT;
 	offset &= ~PAGE_MASK;
 
 	while (len) {
-		info.page = page;
-		info.size = 0;
+		info->page = page;
+		info->size = 0;
 
 		gnttab_foreach_grant_in_range(page, offset, len,
 					      xennet_make_one_txreq,
-					      &info);
+					      info);
 
 		page++;
 		offset = 0;
-		len -= info.size;
+		len -= info->size;
 	}
-
-	return info.tx;
 }
 
 /*
@@ -563,13 +584,22 @@ static u16 xennet_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return queue_idx;
 }
 
+static void xennet_mark_tx_pending(struct netfront_queue *queue)
+{
+	unsigned int i;
+
+	while ((i = get_id_from_list(&queue->tx_pend_queue, queue->tx_link)) !=
+		TX_LINK_NONE)
+		queue->tx_link[i] = TX_PENDING;
+}
+
 #define MAX_XEN_SKB_FRAGS (65536 / XEN_PAGE_SIZE + 1)
 
 static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netfront_info *np = netdev_priv(dev);
 	struct netfront_stats *tx_stats = this_cpu_ptr(np->tx_stats);
-	struct xen_netif_tx_request *tx, *first_tx;
+	struct xen_netif_tx_request *first_tx;
 	unsigned int i;
 	int notify;
 	int slots;
@@ -578,6 +608,7 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int len;
 	unsigned long flags;
 	struct netfront_queue *queue = NULL;
+	struct xennet_gnttab_make_txreq info = { };
 	unsigned int num_queues = dev->real_num_tx_queues;
 	u16 queue_index;
 	struct sk_buff *nskb;
@@ -585,6 +616,8 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Drop the packet if no queues are set up */
 	if (num_queues < 1)
 		goto drop;
+	if (unlikely(np->broken))
+		goto drop;
 	/* Determine which queue to transmit this SKB on */
 	queue_index = skb_get_queue_mapping(skb);
 	queue = &np->queues[queue_index];
@@ -635,21 +668,24 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* First request for the linear area. */
-	first_tx = tx = xennet_make_first_txreq(queue, skb,
-						page, offset, len);
-	offset += tx->size;
+	info.queue = queue;
+	info.skb = skb;
+	info.page = page;
+	first_tx = xennet_make_first_txreq(&info, offset, len);
+	offset += info.tx_local.size;
 	if (offset == PAGE_SIZE) {
 		page++;
 		offset = 0;
 	}
-	len -= tx->size;
+	len -= info.tx_local.size;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		/* local packet? */
-		tx->flags |= XEN_NETTXF_csum_blank | XEN_NETTXF_data_validated;
+		first_tx->flags |= XEN_NETTXF_csum_blank |
+				   XEN_NETTXF_data_validated;
 	else if (skb->ip_summed == CHECKSUM_UNNECESSARY)
 		/* remote but checksummed. */
-		tx->flags |= XEN_NETTXF_data_validated;
+		first_tx->flags |= XEN_NETTXF_data_validated;
 
 	/* Optional extra info after the first request. */
 	if (skb_shinfo(skb)->gso_size) {
@@ -658,7 +694,7 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		gso = (struct xen_netif_extra_info *)
 			RING_GET_REQUEST(&queue->tx, queue->tx.req_prod_pvt++);
 
-		tx->flags |= XEN_NETTXF_extra_info;
+		first_tx->flags |= XEN_NETTXF_extra_info;
 
 		gso->u.gso.size = skb_shinfo(skb)->gso_size;
 		gso->u.gso.type = (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6) ?
@@ -672,19 +708,21 @@ static int xennet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* Requests for the rest of the linear area. */
-	tx = xennet_make_txreqs(queue, tx, skb, page, offset, len);
+	xennet_make_txreqs(&info, page, offset, len);
 
 	/* Requests for all the frags. */
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-		tx = xennet_make_txreqs(queue, tx, skb,
-					skb_frag_page(frag), frag->page_offset,
+		xennet_make_txreqs(&info, skb_frag_page(frag),
+					frag->page_offset,
 					skb_frag_size(frag));
 	}
 
 	/* First request has the packet length. */
 	first_tx->size = skb->len;
 
+	xennet_mark_tx_pending(queue);
+
 	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(&queue->tx, notify);
 	if (notify)
 		notify_remote_via_irq(queue->tx_irq);
@@ -724,6 +762,16 @@ static int xennet_close(struct net_device *dev)
 	return 0;
 }
 
+static void xennet_set_rx_rsp_cons(struct netfront_queue *queue, RING_IDX val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->rx_cons_lock, flags);
+	queue->rx.rsp_cons = val;
+	queue->rx_rsp_unconsumed = RING_HAS_UNCONSUMED_RESPONSES(&queue->rx);
+	spin_unlock_irqrestore(&queue->rx_cons_lock, flags);
+}
+
 static void xennet_move_rx_slot(struct netfront_queue *queue, struct sk_buff *skb,
 				grant_ref_t ref)
 {
@@ -742,7 +790,7 @@ static int xennet_get_extras(struct netfront_queue *queue,
 			     RING_IDX rp)
 
 {
-	struct xen_netif_extra_info *extra;
+	struct xen_netif_extra_info extra;
 	struct device *dev = &queue->info->netdev->dev;
 	RING_IDX cons = queue->rx.rsp_cons;
 	int err = 0;
@@ -758,26 +806,24 @@ static int xennet_get_extras(struct netfront_queue *queue,
 			break;
 		}
 
-		extra = (struct xen_netif_extra_info *)
-			RING_GET_RESPONSE(&queue->rx, ++cons);
+		RING_COPY_RESPONSE(&queue->rx, ++cons, &extra);
 
-		if (unlikely(!extra->type ||
-			     extra->type >= XEN_NETIF_EXTRA_TYPE_MAX)) {
+		if (unlikely(!extra.type ||
+			     extra.type >= XEN_NETIF_EXTRA_TYPE_MAX)) {
 			if (net_ratelimit())
 				dev_warn(dev, "Invalid extra type: %d\n",
-					extra->type);
+					 extra.type);
 			err = -EINVAL;
 		} else {
-			memcpy(&extras[extra->type - 1], extra,
-			       sizeof(*extra));
+			extras[extra.type - 1] = extra;
 		}
 
 		skb = xennet_get_rx_skb(queue, cons);
 		ref = xennet_get_rx_ref(queue, cons);
 		xennet_move_rx_slot(queue, skb, ref);
-	} while (extra->flags & XEN_NETIF_EXTRA_FLAG_MORE);
+	} while (extra.flags & XEN_NETIF_EXTRA_FLAG_MORE);
 
-	queue->rx.rsp_cons = cons;
+	xennet_set_rx_rsp_cons(queue, cons);
 	return err;
 }
 
@@ -785,7 +831,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 				struct netfront_rx_info *rinfo, RING_IDX rp,
 				struct sk_buff_head *list)
 {
-	struct xen_netif_rx_response *rx = &rinfo->rx;
+	struct xen_netif_rx_response *rx = &rinfo->rx, rx_local;
 	struct xen_netif_extra_info *extras = rinfo->extras;
 	struct device *dev = &queue->info->netdev->dev;
 	RING_IDX cons = queue->rx.rsp_cons;
@@ -843,7 +889,8 @@ static int xennet_get_responses(struct netfront_queue *queue,
 			break;
 		}
 
-		rx = RING_GET_RESPONSE(&queue->rx, cons + slots);
+		RING_COPY_RESPONSE(&queue->rx, cons + slots, &rx_local);
+		rx = &rx_local;
 		skb = xennet_get_rx_skb(queue, cons + slots);
 		ref = xennet_get_rx_ref(queue, cons + slots);
 		slots++;
@@ -856,7 +903,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 	}
 
 	if (unlikely(err))
-		queue->rx.rsp_cons = cons + slots;
+		xennet_set_rx_rsp_cons(queue, cons + slots);
 
 	return err;
 }
@@ -898,10 +945,11 @@ static int xennet_fill_frags(struct netfront_queue *queue,
 	struct sk_buff *nskb;
 
 	while ((nskb = __skb_dequeue(list))) {
-		struct xen_netif_rx_response *rx =
-			RING_GET_RESPONSE(&queue->rx, ++cons);
+		struct xen_netif_rx_response rx;
 		skb_frag_t *nfrag = &skb_shinfo(nskb)->frags[0];
 
+		RING_COPY_RESPONSE(&queue->rx, ++cons, &rx);
+
 		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
 			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
@@ -909,20 +957,21 @@ static int xennet_fill_frags(struct netfront_queue *queue,
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
 		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
-			queue->rx.rsp_cons = ++cons + skb_queue_len(list);
+			xennet_set_rx_rsp_cons(queue,
+					       ++cons + skb_queue_len(list));
 			kfree_skb(nskb);
 			return -ENOENT;
 		}
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				skb_frag_page(nfrag),
-				rx->offset, rx->status, PAGE_SIZE);
+				rx.offset, rx.status, PAGE_SIZE);
 
 		skb_shinfo(nskb)->nr_frags = 0;
 		kfree_skb(nskb);
 	}
 
-	queue->rx.rsp_cons = cons;
+	xennet_set_rx_rsp_cons(queue, cons);
 
 	return 0;
 }
@@ -1009,12 +1058,19 @@ static int xennet_poll(struct napi_struct *napi, int budget)
 	skb_queue_head_init(&tmpq);
 
 	rp = queue->rx.sring->rsp_prod;
+	if (RING_RESPONSE_PROD_OVERFLOW(&queue->rx, rp)) {
+		dev_alert(&dev->dev, "Illegal number of responses %u\n",
+			  rp - queue->rx.rsp_cons);
+		queue->info->broken = true;
+		spin_unlock(&queue->rx_lock);
+		return 0;
+	}
 	rmb(); /* Ensure we see queued responses up to 'rp'. */
 
 	i = queue->rx.rsp_cons;
 	work_done = 0;
 	while ((i != rp) && (work_done < budget)) {
-		memcpy(rx, RING_GET_RESPONSE(&queue->rx, i), sizeof(*rx));
+		RING_COPY_RESPONSE(&queue->rx, i, rx);
 		memset(extras, 0, sizeof(rinfo.extras));
 
 		err = xennet_get_responses(queue, &rinfo, rp, &tmpq);
@@ -1036,7 +1092,9 @@ static int xennet_poll(struct napi_struct *napi, int budget)
 
 			if (unlikely(xennet_set_skb_gso(skb, gso))) {
 				__skb_queue_head(&tmpq, skb);
-				queue->rx.rsp_cons += skb_queue_len(&tmpq);
+				xennet_set_rx_rsp_cons(queue,
+						       queue->rx.rsp_cons +
+						       skb_queue_len(&tmpq));
 				goto err;
 			}
 		}
@@ -1060,7 +1118,8 @@ static int xennet_poll(struct napi_struct *napi, int budget)
 
 		__skb_queue_tail(&rxq, skb);
 
-		i = ++queue->rx.rsp_cons;
+		i = queue->rx.rsp_cons + 1;
+		xennet_set_rx_rsp_cons(queue, i);
 		work_done++;
 	}
 
@@ -1138,17 +1197,18 @@ static void xennet_release_tx_bufs(struct netfront_queue *queue)
 
 	for (i = 0; i < NET_TX_RING_SIZE; i++) {
 		/* Skip over entries which are actually freelist references */
-		if (skb_entry_is_link(&queue->tx_skbs[i]))
+		if (!queue->tx_skbs[i])
 			continue;
 
-		skb = queue->tx_skbs[i].skb;
+		skb = queue->tx_skbs[i];
+		queue->tx_skbs[i] = NULL;
 		get_page(queue->grant_tx_page[i]);
 		gnttab_end_foreign_access(queue->grant_tx_ref[i],
 					  GNTMAP_readonly,
 					  (unsigned long)page_address(queue->grant_tx_page[i]));
 		queue->grant_tx_page[i] = NULL;
 		queue->grant_tx_ref[i] = GRANT_INVALID_REF;
-		add_id_to_freelist(&queue->tx_skb_freelist, queue->tx_skbs, i);
+		add_id_to_list(&queue->tx_skb_freelist, queue->tx_link, i);
 		dev_kfree_skb_irq(skb);
 	}
 }
@@ -1243,34 +1303,79 @@ static int xennet_set_features(struct net_device *dev,
 	return 0;
 }
 
-static irqreturn_t xennet_tx_interrupt(int irq, void *dev_id)
+static bool xennet_handle_tx(struct netfront_queue *queue, unsigned int *eoi)
 {
-	struct netfront_queue *queue = dev_id;
 	unsigned long flags;
 
+	if (unlikely(queue->info->broken))
+		return false;
+
 	spin_lock_irqsave(&queue->tx_lock, flags);
-	xennet_tx_buf_gc(queue);
+	if (xennet_tx_buf_gc(queue))
+		*eoi = 0;
 	spin_unlock_irqrestore(&queue->tx_lock, flags);
 
+	return true;
+}
+
+static irqreturn_t xennet_tx_interrupt(int irq, void *dev_id)
+{
+	unsigned int eoiflag = XEN_EOI_FLAG_SPURIOUS;
+
+	if (likely(xennet_handle_tx(dev_id, &eoiflag)))
+		xen_irq_lateeoi(irq, eoiflag);
+
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t xennet_rx_interrupt(int irq, void *dev_id)
+static bool xennet_handle_rx(struct netfront_queue *queue, unsigned int *eoi)
 {
-	struct netfront_queue *queue = dev_id;
-	struct net_device *dev = queue->info->netdev;
+	unsigned int work_queued;
+	unsigned long flags;
+
+	if (unlikely(queue->info->broken))
+		return false;
 
-	if (likely(netif_carrier_ok(dev) &&
-		   RING_HAS_UNCONSUMED_RESPONSES(&queue->rx)))
+	spin_lock_irqsave(&queue->rx_cons_lock, flags);
+	work_queued = RING_HAS_UNCONSUMED_RESPONSES(&queue->rx);
+	if (work_queued > queue->rx_rsp_unconsumed) {
+		queue->rx_rsp_unconsumed = work_queued;
+		*eoi = 0;
+	} else if (unlikely(work_queued < queue->rx_rsp_unconsumed)) {
+		const struct device *dev = &queue->info->netdev->dev;
+
+		spin_unlock_irqrestore(&queue->rx_cons_lock, flags);
+		dev_alert(dev, "RX producer index going backwards\n");
+		dev_alert(dev, "Disabled for further use\n");
+		queue->info->broken = true;
+		return false;
+	}
+	spin_unlock_irqrestore(&queue->rx_cons_lock, flags);
+
+	if (likely(netif_carrier_ok(queue->info->netdev) && work_queued))
 		napi_schedule(&queue->napi);
 
+	return true;
+}
+
+static irqreturn_t xennet_rx_interrupt(int irq, void *dev_id)
+{
+	unsigned int eoiflag = XEN_EOI_FLAG_SPURIOUS;
+
+	if (likely(xennet_handle_rx(dev_id, &eoiflag)))
+		xen_irq_lateeoi(irq, eoiflag);
+
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t xennet_interrupt(int irq, void *dev_id)
 {
-	xennet_tx_interrupt(irq, dev_id);
-	xennet_rx_interrupt(irq, dev_id);
+	unsigned int eoiflag = XEN_EOI_FLAG_SPURIOUS;
+
+	if (xennet_handle_tx(dev_id, &eoiflag) &&
+	    xennet_handle_rx(dev_id, &eoiflag))
+		xen_irq_lateeoi(irq, eoiflag);
+
 	return IRQ_HANDLED;
 }
 
@@ -1281,6 +1386,10 @@ static void xennet_poll_controller(struct net_device *dev)
 	struct netfront_info *info = netdev_priv(dev);
 	unsigned int num_queues = dev->real_num_tx_queues;
 	unsigned int i;
+
+	if (info->broken)
+		return;
+
 	for (i = 0; i < num_queues; ++i)
 		xennet_interrupt(0, &info->queues[i]);
 }
@@ -1498,9 +1607,10 @@ static int setup_netfront_single(struct netfront_queue *queue)
 	if (err < 0)
 		goto fail;
 
-	err = bind_evtchn_to_irqhandler(queue->tx_evtchn,
-					xennet_interrupt,
-					0, queue->info->netdev->name, queue);
+	err = bind_evtchn_to_irqhandler_lateeoi(queue->tx_evtchn,
+						xennet_interrupt, 0,
+						queue->info->netdev->name,
+						queue);
 	if (err < 0)
 		goto bind_fail;
 	queue->rx_evtchn = queue->tx_evtchn;
@@ -1528,18 +1638,18 @@ static int setup_netfront_split(struct netfront_queue *queue)
 
 	snprintf(queue->tx_irq_name, sizeof(queue->tx_irq_name),
 		 "%s-tx", queue->name);
-	err = bind_evtchn_to_irqhandler(queue->tx_evtchn,
-					xennet_tx_interrupt,
-					0, queue->tx_irq_name, queue);
+	err = bind_evtchn_to_irqhandler_lateeoi(queue->tx_evtchn,
+						xennet_tx_interrupt, 0,
+						queue->tx_irq_name, queue);
 	if (err < 0)
 		goto bind_tx_fail;
 	queue->tx_irq = err;
 
 	snprintf(queue->rx_irq_name, sizeof(queue->rx_irq_name),
 		 "%s-rx", queue->name);
-	err = bind_evtchn_to_irqhandler(queue->rx_evtchn,
-					xennet_rx_interrupt,
-					0, queue->rx_irq_name, queue);
+	err = bind_evtchn_to_irqhandler_lateeoi(queue->rx_evtchn,
+						xennet_rx_interrupt, 0,
+						queue->rx_irq_name, queue);
 	if (err < 0)
 		goto bind_rx_fail;
 	queue->rx_irq = err;
@@ -1641,6 +1751,7 @@ static int xennet_init_queue(struct netfront_queue *queue)
 
 	spin_lock_init(&queue->tx_lock);
 	spin_lock_init(&queue->rx_lock);
+	spin_lock_init(&queue->rx_cons_lock);
 
 	setup_timer(&queue->rx_refill_timer, rx_refill_timeout,
 		    (unsigned long)queue);
@@ -1649,13 +1760,15 @@ static int xennet_init_queue(struct netfront_queue *queue)
 	snprintf(queue->name, sizeof(queue->name), "vif%s-q%u",
 		 devid, queue->id);
 
-	/* Initialise tx_skbs as a free chain containing every entry. */
+	/* Initialise tx_skb_freelist as a free chain containing every entry. */
 	queue->tx_skb_freelist = 0;
+	queue->tx_pend_queue = TX_LINK_NONE;
 	for (i = 0; i < NET_TX_RING_SIZE; i++) {
-		skb_entry_set_link(&queue->tx_skbs[i], i+1);
+		queue->tx_link[i] = i + 1;
 		queue->grant_tx_ref[i] = GRANT_INVALID_REF;
 		queue->grant_tx_page[i] = NULL;
 	}
+	queue->tx_link[NET_TX_RING_SIZE - 1] = TX_LINK_NONE;
 
 	/* Clear out rx_skbs */
 	for (i = 0; i < NET_RX_RING_SIZE; i++) {
@@ -1865,6 +1978,9 @@ static int talk_to_netback(struct xenbus_device *dev,
 	if (info->queues)
 		xennet_destroy_queues(info);
 
+	/* For the case of a reconnect reset the "broken" indicator. */
+	info->broken = false;
+
 	err = xennet_create_queues(info, &num_queues);
 	if (err < 0) {
 		xenbus_dev_fatal(dev, err, "creating queues");
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index be2f1402c84c2..161de28dc1626 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -871,7 +871,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	free_msi_irqs(dev);
 
 out_disable:
-	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE, 0);
 
 	return ret;
 }
diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index a66be137324c0..76f5703bc4f65 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -628,7 +628,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	}
 
 	gmux_data->iostart = res->start;
-	gmux_data->iolen = res->end - res->start;
+	gmux_data->iolen = resource_size(res);
 
 	if (gmux_data->iolen < GMUX_MIN_IO_LEN) {
 		pr_err("gmux I/O region too small (%lu < %u)\n",
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9c929b5ce58e2..b19a51d12651d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1169,15 +1169,6 @@ static int tpacpi_rfk_update_swstate(const struct tpacpi_rfk *tp_rfk)
 	return status;
 }
 
-/* Query FW and update rfkill sw state for all rfkill switches */
-static void tpacpi_rfk_update_swstate_all(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < TPACPI_RFK_SW_MAX; i++)
-		tpacpi_rfk_update_swstate(tpacpi_rfkill_switches[i]);
-}
-
 /*
  * Sync the HW-blocking state of all rfkill switches,
  * do notice it causes the rfkill core to schedule uevents
@@ -3029,9 +3020,6 @@ static void tpacpi_send_radiosw_update(void)
 	if (wlsw == TPACPI_RFK_RADIO_OFF)
 		tpacpi_rfk_update_hwblock_state(true);
 
-	/* Sync sw blocking state */
-	tpacpi_rfk_update_swstate_all();
-
 	/* Sync hw blocking state last if it is hw-unblocked */
 	if (wlsw == TPACPI_RFK_RADIO_ON)
 		tpacpi_rfk_update_hwblock_state(false);
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 15fed9d8f871a..ec54cff108b3c 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -169,8 +169,8 @@ static void ltc2952_poweroff_kill(void)
 
 static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
 {
-	data->wde_interval = ktime_set(0, 300L*1E6L);
-	data->trigger_delay = ktime_set(2, 500L*1E6L);
+	data->wde_interval = ktime_set(0, 300L * NSEC_PER_MSEC);
+	data->trigger_delay = ktime_set(2, 500L * NSEC_PER_MSEC);
 
 	hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 30e954bb6c81e..8d1a05d5eb4dd 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2991,6 +2991,8 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iscsi_session *session = conn->session;
+	char *tmp_persistent_address = conn->persistent_address;
+	char *tmp_local_ipaddr = conn->local_ipaddr;
 
 	del_timer_sync(&conn->transport_timer);
 
@@ -3012,8 +3014,6 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 	spin_lock_bh(&session->frwd_lock);
 	free_pages((unsigned long) conn->data,
 		   get_order(ISCSI_DEF_MAX_RECV_SEG_LEN));
-	kfree(conn->persistent_address);
-	kfree(conn->local_ipaddr);
 	/* regular RX path uses back_lock */
 	spin_lock_bh(&session->back_lock);
 	kfifo_in(&session->cmdpool.queue, (void*)&conn->login_task,
@@ -3025,6 +3025,8 @@ void iscsi_conn_teardown(struct iscsi_cls_conn *cls_conn)
 	mutex_unlock(&session->eh_mutex);
 
 	iscsi_destroy_conn(cls_conn);
+	kfree(tmp_persistent_address);
+	kfree(tmp_local_ipaddr);
 }
 EXPORT_SYMBOL_GPL(iscsi_conn_teardown);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 58876b8a2e9f8..8063b97bf2e9b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2927,7 +2927,7 @@ _scsih_ublock_io_device(struct MPT3SAS_ADAPTER *ioc, u64 sas_address)
 
 	shost_for_each_device(sdev, ioc->shost) {
 		sas_device_priv_data = sdev->hostdata;
-		if (!sas_device_priv_data)
+		if (!sas_device_priv_data || !sas_device_priv_data->sas_target)
 			continue;
 		if (sas_device_priv_data->sas_target->sas_address
 		    != sas_address)
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 99bfb003be3fc..4358eb158c48c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -2175,11 +2175,11 @@ static int resp_mode_select(struct scsi_cmnd *scp,
 			    __func__, param_len, res);
 	md_len = mselect6 ? (arr[0] + 1) : (get_unaligned_be16(arr + 0) + 2);
 	bd_len = mselect6 ? arr[3] : get_unaligned_be16(arr + 6);
-	if (md_len > 2) {
+	off = bd_len + (mselect6 ? 4 : 8);
+	if (md_len > 2 || off >= res) {
 		mk_sense_invalid_fld(scp, SDEB_IN_DATA, 0, -1);
 		return check_condition_result;
 	}
-	off = bd_len + (mselect6 ? 4 : 8);
 	mpage = arr[off] & 0x3f;
 	ps = !!(arr[off] & 0x80);
 	if (ps) {
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index aed17f958448d..acd8eb8c94cf7 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1898,12 +1898,12 @@ static void session_recovery_timedout(struct work_struct *work)
 	}
 	spin_unlock_irqrestore(&session->lock, flags);
 
-	if (session->transport->session_recovery_timedout)
-		session->transport->session_recovery_timedout(session);
-
 	ISCSI_DBG_TRANS_SESSION(session, "Unblocking SCSI target\n");
 	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
 	ISCSI_DBG_TRANS_SESSION(session, "Completed unblocking SCSI target\n");
+
+	if (session->transport->session_recovery_timedout)
+		session->transport->session_recovery_timedout(session);
 }
 
 static void __iscsi_unblock_session(struct work_struct *work)
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 4d2172c115c6e..90057c31d01c6 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -581,9 +581,12 @@ static void pvscsi_complete_request(struct pvscsi_adapter *adapter,
 			 * Commands like INQUIRY may transfer less data than
 			 * requested by the initiator via bufflen. Set residual
 			 * count to make upper layer aware of the actual amount
-			 * of data returned.
+			 * of data returned. There are cases when controller
+			 * returns zero dataLen with non zero data - do not set
+			 * residual count in that case.
 			 */
-			scsi_set_resid(cmd, scsi_bufflen(cmd) - e->dataLen);
+			if (e->dataLen && (e->dataLen < scsi_bufflen(cmd)))
+				scsi_set_resid(cmd, scsi_bufflen(cmd) - e->dataLen);
 			cmd->result = (DID_OK << 16);
 			break;
 
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index c4f5e5bbb8dce..9397e8ba26469 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -176,7 +176,7 @@ static struct platform_driver tegra_fuse_driver = {
 };
 module_platform_driver(tegra_fuse_driver);
 
-bool __init tegra_fuse_read_spare(unsigned int spare)
+u32 __init tegra_fuse_read_spare(unsigned int spare)
 {
 	unsigned int offset = fuse->soc->info->spare + spare * 4;
 
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 10c2076d5089a..f368bd5373088 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -62,7 +62,7 @@ struct tegra_fuse {
 void tegra_init_revision(void);
 void tegra_init_apbmisc(void);
 
-bool __init tegra_fuse_read_spare(unsigned int spare);
+u32 __init tegra_fuse_read_spare(unsigned int spare);
 u32 __init tegra_fuse_read_early(unsigned int offset);
 
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 806e9b30b9dc8..aac9b38b8c25c 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -489,6 +489,9 @@ static void *ion_buffer_kmap_get(struct ion_buffer *buffer)
 	void *vaddr;
 
 	if (buffer->kmap_cnt) {
+		if (buffer->kmap_cnt == INT_MAX)
+			return ERR_PTR(-EOVERFLOW);
+
 		buffer->kmap_cnt++;
 		return buffer->vaddr;
 	}
@@ -509,6 +512,9 @@ static void *ion_handle_kmap_get(struct ion_handle *handle)
 	void *vaddr;
 
 	if (handle->kmap_cnt) {
+		if (handle->kmap_cnt == INT_MAX)
+			return ERR_PTR(-EOVERFLOW);
+
 		handle->kmap_cnt++;
 		return buffer->vaddr;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 0d6fe039ac19f..234a46ff4484a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2710,13 +2710,14 @@ static void _rtl92e_pci_disconnect(struct pci_dev *pdev)
 			free_irq(dev->irq, dev);
 			priv->irq = 0;
 		}
-		free_rtllib(dev);
 
 		if (dev->mem_start != 0) {
 			iounmap((void __iomem *)dev->mem_start);
 			release_mem_region(pci_resource_start(pdev, 1),
 					pci_resource_len(pdev, 1));
 		}
+
+		free_rtllib(dev);
 	} else {
 		priv = rtllib_priv(dev);
 	}
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4c2dc3a59eb59..5ef30ba3b73a4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -601,6 +601,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *pos;
 	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->prev_low_trip = -INT_MAX;
+	tz->prev_high_trip = INT_MAX;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
 		pos->initialized = false;
 }
diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 5e87e4866bcb7..2af089b2a343d 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -50,6 +50,8 @@ struct xencons_info {
 	struct xenbus_device *xbdev;
 	struct xencons_interface *intf;
 	unsigned int evtchn;
+	XENCONS_RING_IDX out_cons;
+	unsigned int out_cons_same;
 	struct hvc_struct *hvc;
 	int irq;
 	int vtermno;
@@ -99,7 +101,11 @@ static int __write_console(struct xencons_info *xencons,
 	cons = intf->out_cons;
 	prod = intf->out_prod;
 	mb();			/* update queue values before going on */
-	BUG_ON((prod - cons) > sizeof(intf->out));
+
+	if ((prod - cons) > sizeof(intf->out)) {
+		pr_err_once("xencons: Illegal ring page indices");
+		return -EINVAL;
+	}
 
 	while ((sent < len) && ((prod - cons) < sizeof(intf->out)))
 		intf->out[MASK_XENCONS_IDX(prod++, intf->out)] = data[sent++];
@@ -127,7 +133,10 @@ static int domU_write_console(uint32_t vtermno, const char *data, int len)
 	 */
 	while (len) {
 		int sent = __write_console(cons, data, len);
-		
+
+		if (sent < 0)
+			return sent;
+
 		data += sent;
 		len -= sent;
 
@@ -144,6 +153,8 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
 	XENCONS_RING_IDX cons, prod;
 	int recv = 0;
 	struct xencons_info *xencons = vtermno_to_xencons(vtermno);
+	unsigned int eoiflag = 0;
+
 	if (xencons == NULL)
 		return -EINVAL;
 	intf = xencons->intf;
@@ -151,7 +162,11 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
 	cons = intf->in_cons;
 	prod = intf->in_prod;
 	mb();			/* get pointers before reading ring */
-	BUG_ON((prod - cons) > sizeof(intf->in));
+
+	if ((prod - cons) > sizeof(intf->in)) {
+		pr_err_once("xencons: Illegal ring page indices");
+		return -EINVAL;
+	}
 
 	while (cons != prod && recv < len)
 		buf[recv++] = intf->in[MASK_XENCONS_IDX(cons++, intf->in)];
@@ -159,7 +174,27 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
 	mb();			/* read ring before consuming */
 	intf->in_cons = cons;
 
-	notify_daemon(xencons);
+	/*
+	 * When to mark interrupt having been spurious:
+	 * - there was no new data to be read, and
+	 * - the backend did not consume some output bytes, and
+	 * - the previous round with no read data didn't see consumed bytes
+	 *   (we might have a race with an interrupt being in flight while
+	 *   updating xencons->out_cons, so account for that by allowing one
+	 *   round without any visible reason)
+	 */
+	if (intf->out_cons != xencons->out_cons) {
+		xencons->out_cons = intf->out_cons;
+		xencons->out_cons_same = 0;
+	}
+	if (recv) {
+		notify_daemon(xencons);
+	} else if (xencons->out_cons_same++ > 1) {
+		eoiflag = XEN_EOI_FLAG_SPURIOUS;
+	}
+
+	xen_irq_lateeoi(xencons->irq, eoiflag);
+
 	return recv;
 }
 
@@ -388,7 +423,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 	if (ret)
 		return ret;
 	info->evtchn = evtchn;
-	irq = bind_evtchn_to_irq(evtchn);
+	irq = bind_interdomain_evtchn_to_irq_lateeoi(dev->otherend_id, evtchn);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
@@ -552,7 +587,7 @@ static int __init xen_hvc_init(void)
 			return r;
 
 		info = vtermno_to_xencons(HVC_COOKIE);
-		info->irq = bind_evtchn_to_irq(info->evtchn);
+		info->irq = bind_evtchn_to_irq_lateeoi(info->evtchn);
 	}
 	if (info->irq < 0)
 		info->irq = 0; /* NO_IRQ */
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d402f495e1b39..f183c7199a1f2 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2707,6 +2707,7 @@ MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
 
 static const struct acpi_device_id sbsa_uart_acpi_match[] = {
 	{ "ARMH0011", 0 },
+	{ "ARMHB000", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, sbsa_uart_acpi_match);
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 9e6d44df3fab7..c284e61ed4fcc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -611,6 +611,9 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
 	u32 val;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_CONSOLE_POLL))
+		return;
+
 	if (!dma->chan)
 		return;
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index bbba2174d6e75..e97961dc3622d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1522,6 +1522,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = uart_port_check(state);
+	char *buf;
 
 	/*
 	 * At this point, we stop accepting input.  To do this, we
@@ -1543,8 +1544,18 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	 */
 	tty_port_set_suspended(port, 0);
 
-	uart_change_pm(state, UART_PM_STATE_OFF);
+	/*
+	 * Free the transmit buffer.
+	 */
+	spin_lock_irq(&uport->lock);
+	buf = state->xmit.buf;
+	state->xmit.buf = NULL;
+	spin_unlock_irq(&uport->lock);
 
+	if (buf)
+		free_page((unsigned long)buf);
+
+	uart_change_pm(state, UART_PM_STATE_OFF);
 }
 
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 34081f03b1f56..fc55f7e31c4b2 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -404,7 +404,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 * the USB-2 spec requires such endpoints to have wMaxPacketSize = 0
 	 * (see the end of section 5.6.3), so don't warn about them.
 	 */
-	maxp = usb_endpoint_maxp(&endpoint->desc);
+	maxp = le16_to_cpu(endpoint->desc.wMaxPacketSize);
 	if (maxp == 0 && !(usb_endpoint_xfer_isoc(d) && asnum == 0)) {
 		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid wMaxPacketSize 0\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
@@ -420,9 +420,9 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		maxpacket_maxes = full_speed_maxpacket_maxes;
 		break;
 	case USB_SPEED_HIGH:
-		/* Bits 12..11 are allowed only for HS periodic endpoints */
+		/* Multiple-transactions bits are allowed only for HS periodic endpoints */
 		if (usb_endpoint_xfer_int(d) || usb_endpoint_xfer_isoc(d)) {
-			i = maxp & (BIT(12) | BIT(11));
+			i = maxp & USB_EP_MAXP_MULT_MASK;
 			maxp &= ~i;
 		}
 		/* fallthrough */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 92057a3f346f4..0abcf8bbb73fe 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4460,8 +4460,6 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	if (oldspeed == USB_SPEED_LOW)
 		delay = HUB_LONG_RESET_TIME;
 
-	mutex_lock(hcd->address0_mutex);
-
 	/* Reset the device; full speed may morph to high speed */
 	/* FIXME a USB 2.0 device may morph into SuperSpeed on reset. */
 	retval = hub_port_reset(hub, port1, udev, delay, false);
@@ -4748,7 +4746,6 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		hub_port_disable(hub, port1, 0);
 		update_devnum(udev, devnum);	/* for disconnect processing */
 	}
-	mutex_unlock(hcd->address0_mutex);
 	return retval;
 }
 
@@ -4838,6 +4835,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_device *udev = port_dev->child;
 	static int unreliable_port = -1;
+	bool retry_locked;
 
 	/* Disconnect any existing devices under this port */
 	if (udev) {
@@ -4893,7 +4891,11 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		unit_load = 100;
 
 	status = 0;
+
 	for (i = 0; i < SET_CONFIG_TRIES; i++) {
+		usb_lock_port(port_dev);
+		mutex_lock(hcd->address0_mutex);
+		retry_locked = true;
 
 		/* reallocate for each attempt, since references
 		 * to the previous one can escape in various ways
@@ -4902,6 +4904,8 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (!udev) {
 			dev_err(&port_dev->dev,
 					"couldn't allocate usb_device\n");
+			mutex_unlock(hcd->address0_mutex);
+			usb_unlock_port(port_dev);
 			goto done;
 		}
 
@@ -4923,12 +4927,14 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		}
 
 		/* reset (non-USB 3.0 devices) and get descriptor */
-		usb_lock_port(port_dev);
 		status = hub_port_init(hub, udev, port1, i);
-		usb_unlock_port(port_dev);
 		if (status < 0)
 			goto loop;
 
+		mutex_unlock(hcd->address0_mutex);
+		usb_unlock_port(port_dev);
+		retry_locked = false;
+
 		if (udev->quirks & USB_QUIRK_DELAY_INIT)
 			msleep(2000);
 
@@ -5021,6 +5027,10 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		usb_ep0_reinit(udev);
 		release_devnum(udev);
 		hub_free_dev(udev);
+		if (retry_locked) {
+			mutex_unlock(hcd->address0_mutex);
+			usb_unlock_port(port_dev);
+		}
 		usb_put_dev(udev);
 		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
 			break;
@@ -5572,6 +5582,8 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	bos = udev->bos;
 	udev->bos = NULL;
 
+	mutex_lock(hcd->address0_mutex);
+
 	for (i = 0; i < SET_CONFIG_TRIES; ++i) {
 
 		/* ep0 maxpacket size may change; let the HCD know about it.
@@ -5581,6 +5593,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
 	}
+	mutex_unlock(hcd->address0_mutex);
 
 	if (ret < 0)
 		goto re_enumerate;
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 438efa36552c8..a7c44a3cb2d25 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1631,6 +1631,18 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	struct usb_function		*f = NULL;
 	u8				endp;
 
+	if (w_length > USB_COMP_EP0_BUFSIZ) {
+		if (ctrl->bRequestType & USB_DIR_IN) {
+			/* Cast away the const, we are going to overwrite on purpose. */
+			__le16 *temp = (__le16 *)&ctrl->wLength;
+
+			*temp = cpu_to_le16(USB_COMP_EP0_BUFSIZ);
+			w_length = USB_COMP_EP0_BUFSIZ;
+		} else {
+			goto done;
+		}
+	}
+
 	/* partial re-init of the response message; the function or the
 	 * gadget might need to intercept e.g. a control-OUT completion
 	 * when we delegate to it.
@@ -2171,7 +2183,7 @@ int composite_dev_prepare(struct usb_composite_driver *composite,
 	if (!cdev->req)
 		return -ENOMEM;
 
-	cdev->req->buf = kmalloc(USB_COMP_EP0_BUFSIZ, GFP_KERNEL);
+	cdev->req->buf = kzalloc(USB_COMP_EP0_BUFSIZ, GFP_KERNEL);
 	if (!cdev->req->buf)
 		goto fail;
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 5fdc2860aa3d3..1a31becac203a 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1667,11 +1667,15 @@ static void ffs_data_clear(struct ffs_data *ffs)
 
 	BUG_ON(ffs->gadget);
 
-	if (ffs->epfiles)
+	if (ffs->epfiles) {
 		ffs_epfiles_destroy(ffs->epfiles, ffs->eps_count);
+		ffs->epfiles = NULL;
+	}
 
-	if (ffs->ffs_eventfd)
+	if (ffs->ffs_eventfd) {
 		eventfd_ctx_put(ffs->ffs_eventfd);
+		ffs->ffs_eventfd = NULL;
+	}
 
 	kfree(ffs->raw_descs_data);
 	kfree(ffs->raw_strings);
@@ -1684,7 +1688,6 @@ static void ffs_data_reset(struct ffs_data *ffs)
 
 	ffs_data_clear(ffs);
 
-	ffs->epfiles = NULL;
 	ffs->raw_descs_data = NULL;
 	ffs->raw_descs = NULL;
 	ffs->raw_strings = NULL;
diff --git a/drivers/usb/gadget/legacy/dbgp.c b/drivers/usb/gadget/legacy/dbgp.c
index 99ca3dabc4f34..e8818ad973e4b 100644
--- a/drivers/usb/gadget/legacy/dbgp.c
+++ b/drivers/usb/gadget/legacy/dbgp.c
@@ -136,7 +136,7 @@ static int dbgp_enable_ep_req(struct usb_ep *ep)
 		goto fail_1;
 	}
 
-	req->buf = kmalloc(DBGP_REQ_LEN, GFP_KERNEL);
+	req->buf = kzalloc(DBGP_REQ_LEN, GFP_KERNEL);
 	if (!req->buf) {
 		err = -ENOMEM;
 		stp = 2;
@@ -344,6 +344,19 @@ static int dbgp_setup(struct usb_gadget *gadget,
 	void *data = NULL;
 	u16 len = 0;
 
+	if (length > DBGP_REQ_LEN) {
+		if (ctrl->bRequestType & USB_DIR_IN) {
+			/* Cast away the const, we are going to overwrite on purpose. */
+			__le16 *temp = (__le16 *)&ctrl->wLength;
+
+			*temp = cpu_to_le16(DBGP_REQ_LEN);
+			length = DBGP_REQ_LEN;
+		} else {
+			return err;
+		}
+	}
+
+
 	if (request == USB_REQ_GET_DESCRIPTOR) {
 		switch (value>>8) {
 		case USB_DT_DEVICE:
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index d706d2e134d9f..68e6083897864 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -113,6 +113,8 @@ enum ep0_state {
 /* enough for the whole queue: most events invalidate others */
 #define	N_EVENT			5
 
+#define RBUF_SIZE		256
+
 struct dev_data {
 	spinlock_t			lock;
 	atomic_t			count;
@@ -147,7 +149,7 @@ struct dev_data {
 	struct dentry			*dentry;
 
 	/* except this scratch i/o buffer for ep0 */
-	u8				rbuf [256];
+	u8				rbuf[RBUF_SIZE];
 };
 
 static inline void get_dev (struct dev_data *data)
@@ -1336,6 +1338,18 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 	u16				w_value = le16_to_cpu(ctrl->wValue);
 	u16				w_length = le16_to_cpu(ctrl->wLength);
 
+	if (w_length > RBUF_SIZE) {
+		if (ctrl->bRequestType & USB_DIR_IN) {
+			/* Cast away the const, we are going to overwrite on purpose. */
+			__le16 *temp = (__le16 *)&ctrl->wLength;
+
+			*temp = cpu_to_le16(RBUF_SIZE);
+			w_length = RBUF_SIZE;
+		} else {
+			return value;
+		}
+	}
+
 	spin_lock (&dev->lock);
 	dev->setup_abort = 0;
 	if (dev->state == STATE_DEV_UNCONNECTED) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ae67f6383ca32..30c8eeed95074 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -92,7 +92,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	/* Look for vendor-specific quirks */
 	if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
 			(pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_PDK ||
-			 pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1100 ||
 			 pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1400)) {
 		if (pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_PDK &&
 				pdev->revision == 0x0) {
@@ -127,6 +126,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1009)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
+	if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
+			pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1100)
+		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
+
 	if (pdev->vendor == PCI_VENDOR_ID_NEC)
 		xhci->quirks |= XHCI_NEC_HOST;
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 9a0f8ee8cbd9f..9479abb9eaaaf 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1195,6 +1195,14 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1063, 0xff),	/* Telit LN920 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990 (rmnet) */
+	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990 (MBIM) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990 (RNDIS) */
+	  .driver_info = NCTRL(2) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990 (ECM) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -1243,6 +1251,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9010),				/* Telit SBL FN980 flashing device */
 	  .driver_info = NCTRL(0) | ZLP },
+	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9200),				/* Telit LE910S1 flashing device */
+	  .driver_info = NCTRL(0) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, ZTE_PRODUCT_MF622, 0xff, 0xff, 0xff) }, /* ZTE WCDMA products */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0002, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) },
@@ -2072,6 +2082,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 2ac966400c428..e282e8174a5d9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -406,7 +406,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		else
 			virtio_transport_free_pkt(pkt);
 
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + len);
+		vhost_add_used(vq, head, 0);
 		added = true;
 	}
 
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index cb9b879631293..6c5c7d45d9f67 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -420,11 +420,17 @@ static void vgacon_init(struct vc_data *c, int init)
 	struct uni_pagedir *p;
 
 	/*
-	 * We cannot be loaded as a module, therefore init is always 1,
-	 * but vgacon_init can be called more than once, and init will
-	 * not be 1.
+	 * We cannot be loaded as a module, therefore init will be 1
+	 * if we are the default console, however if we are a fallback
+	 * console, for example if fbcon has failed registration, then
+	 * init will be 0, so we need to make sure our boot parameters
+	 * have been copied to the console structure for vgacon_resize
+	 * ultimately called by vc_resize.  Any subsequent calls to
+	 * vgacon_init init will have init set to 0 too.
 	 */
 	c->vc_can_do_color = vga_can_do_color;
+	c->vc_scan_lines = vga_scan_lines;
+	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
 
 	/* set dimensions manually if init != 0 since vc_resize() will fail */
 	if (init) {
@@ -433,8 +439,6 @@ static void vgacon_init(struct vc_data *c, int init)
 	} else
 		vc_resize(c, vga_video_num_columns, vga_video_num_lines);
 
-	c->vc_scan_lines = vga_scan_lines;
-	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
 	c->vc_complement_mask = 0x7700;
 	if (vga_512_chars)
 		c->vc_hi_font_mask = 0x0800;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d9a9058279671..37e3ba5dadf60 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -547,6 +547,13 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 	struct device *dev = get_device(&vp_dev->vdev.dev);
 
+	/*
+	 * Device is marked broken on surprise removal so that virtio upper
+	 * layers can abort any ongoing operation.
+	 */
+	if (!pci_device_is_present(pci_dev))
+		virtio_break_device(&vp_dev->vdev);
+
 	unregister_virtio_device(&vp_dev->vdev);
 
 	if (vp_dev->ioaddr)
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index ba7590d75985e..d7f886dd7b550 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -764,7 +764,7 @@ static struct notifier_block xenbus_resume_nb = {
 
 static int __init xenbus_init(void)
 {
-	int err = 0;
+	int err;
 	uint64_t v = 0;
 	xen_store_domain_type = XS_UNKNOWN;
 
@@ -804,6 +804,29 @@ static int __init xenbus_init(void)
 		err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
 		if (err)
 			goto out_error;
+		/*
+		 * Uninitialized hvm_params are zero and return no error.
+		 * Although it is theoretically possible to have
+		 * HVM_PARAM_STORE_PFN set to zero on purpose, in reality it is
+		 * not zero when valid. If zero, it means that Xenstore hasn't
+		 * been properly initialized. Instead of attempting to map a
+		 * wrong guest physical address return error.
+		 *
+		 * Also recognize all bits set as an invalid value.
+		 */
+		if (!v || !~v) {
+			err = -ENOENT;
+			goto out_error;
+		}
+		/* Avoid truncation on 32-bit. */
+#if BITS_PER_LONG == 32
+		if (v > ULONG_MAX) {
+			pr_err("%s: cannot handle HVM_PARAM_STORE_PFN=%llx > ULONG_MAX\n",
+			       __func__, v);
+			err = -EINVAL;
+			goto out_error;
+		}
+#endif
 		xen_store_gfn = (unsigned long)v;
 		xen_store_interface =
 			xen_remap(xen_store_gfn << XEN_PAGE_SHIFT,
@@ -832,8 +855,10 @@ static int __init xenbus_init(void)
 	 */
 	proc_mkdir("xen", NULL);
 #endif
+	return 0;
 
 out_error:
+	xen_store_domain_type = XS_UNKNOWN;
 	return err;
 }
 
diff --git a/fs/file.c b/fs/file.c
index 82d3f925bab39..0e31a66207e86 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -692,7 +692,7 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__fget(unsigned int fd, fmode_t mask)
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -707,23 +707,32 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
 		 */
 		if (file->f_mode & mask)
 			file = NULL;
-		else if (!get_file_rcu(file))
+		else if (!get_file_rcu_many(file, refs))
 			goto loop;
+		else if (__fcheck_files(files, fd) != file) {
+			fput_many(file, refs);
+			goto loop;
+		}
 	}
 	rcu_read_unlock();
 
 	return file;
 }
 
+struct file *fget_many(unsigned int fd, unsigned int refs)
+{
+	return __fget(fd, FMODE_PATH, refs);
+}
+
 struct file *fget(unsigned int fd)
 {
-	return __fget(fd, FMODE_PATH);
+	return __fget(fd, FMODE_PATH, 1);
 }
 EXPORT_SYMBOL(fget);
 
 struct file *fget_raw(unsigned int fd)
 {
-	return __fget(fd, 0);
+	return __fget(fd, 0, 1);
 }
 EXPORT_SYMBOL(fget_raw);
 
@@ -754,7 +763,7 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 			return 0;
 		return (unsigned long)file;
 	} else {
-		file = __fget(fd, mask);
+		file = __fget(fd, mask, 1);
 		if (!file)
 			return 0;
 		return FDPUT_FPUT | (unsigned long)file;
diff --git a/fs/file_table.c b/fs/file_table.c
index ad17e05ebf95f..747bb386b4466 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -261,9 +261,9 @@ void flush_delayed_fput(void)
 
 static DECLARE_DELAYED_WORK(delayed_fput_work, delayed_fput);
 
-void fput(struct file *file)
+void fput_many(struct file *file, unsigned int refs)
 {
-	if (atomic_long_dec_and_test(&file->f_count)) {
+	if (atomic_long_sub_and_test(refs, &file->f_count)) {
 		struct task_struct *task = current;
 
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
@@ -282,6 +282,11 @@ void fput(struct file *file)
 	}
 }
 
+void fput(struct file *file)
+{
+	fput_many(file, 1);
+}
+
 /*
  * synchronous analog of fput(); for kernel threads that might be needed
  * in some umount() (and thus can't use flush_delayed_fput() without
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d21e41735805d..585c52dbb2e39 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -903,6 +903,12 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (!(buf->flags & PIPE_BUF_FLAG_LRU))
 		lru_cache_add_file(newpage);
 
+	/*
+	 * Release while we have extra ref on stolen page.  Otherwise
+	 * anon_pipe_buf_release() might think the page can be reused.
+	 */
+	pipe_buf_release(cs->pipe, buf);
+
 	err = 0;
 	spin_lock(&cs->req->waitq.lock);
 	if (test_bit(FR_ABORTED, &cs->req->flags))
@@ -2040,8 +2046,12 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	pipe_lock(pipe);
 out_free:
-	for (idx = 0; idx < nbuf; idx++)
-		pipe_buf_release(pipe, &bufs[idx]);
+	for (idx = 0; idx < nbuf; idx++) {
+		struct pipe_buffer *buf = &bufs[idx];
+
+		if (buf->ops)
+			pipe_buf_release(pipe, buf);
+	}
 	pipe_unlock(pipe);
 
 	kfree(bufs);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a3a89a411f807..02281fa147dd9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -973,7 +973,7 @@ int fuse_reverse_inval_entry(struct super_block *sb, u64 parent_nodeid,
 	if (!parent)
 		return -ENOENT;
 
-	inode_lock(parent);
+	inode_lock_nested(parent, I_MUTEX_PARENT);
 	if (!S_ISDIR(parent->i_mode))
 		goto unlock;
 
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7efb9e0e9f25b..3038cefff15cc 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -181,8 +181,9 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 			return status;
 	}
 
-	truncate_pagecache_range(dst_inode, pos_dst,
-				 pos_dst + res->write_res.count);
+	WARN_ON_ONCE(invalidate_inode_pages2_range(dst_inode->i_mapping,
+					pos_dst >> PAGE_SHIFT,
+					(pos_dst + res->write_res.count - 1) >> PAGE_SHIFT));
 
 	return res->write_res.count;
 }
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 8b2605882a201..335c34f0d1303 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -593,8 +593,7 @@ static int nfs4_xdr_dec_clone(struct rpc_rqst *rqstp,
 	status = decode_clone(xdr);
 	if (status)
 		goto out;
-	status = decode_getfattr(xdr, res->dst_fattr, res->server);
-
+	decode_getfattr(xdr, res->dst_fattr, res->server);
 out:
 	res->rpc_status = status;
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5c9231d5e14a0..524d98e3bcf5b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -955,6 +955,11 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 	return 0;
 }
 
+static bool delegation_hashed(struct nfs4_delegation *dp)
+{
+	return !(list_empty(&dp->dl_perfile));
+}
+
 static bool
 unhash_delegation_locked(struct nfs4_delegation *dp)
 {
@@ -962,7 +967,7 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
 
 	lockdep_assert_held(&state_lock);
 
-	if (list_empty(&dp->dl_perfile))
+	if (!delegation_hashed(dp))
 		return false;
 
 	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
@@ -3882,7 +3887,7 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 	 * queued for a lease break. Don't queue it again.
 	 */
 	spin_lock(&state_lock);
-	if (dp->dl_time == 0) {
+	if (delegation_hashed(dp) && dp->dl_time == 0) {
 		dp->dl_time = get_seconds();
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 8e8012769f3e9..e8b40835770cf 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -105,14 +105,19 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 			nr_bytes = count;
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (pfn_is_ram(pfn) == 0)
-			memset(buf, 0, nr_bytes);
-		else {
+		if (pfn_is_ram(pfn) == 0) {
+			tmp = 0;
+			if (!userbuf)
+				memset(buf, 0, nr_bytes);
+			else if (clear_user(buf, nr_bytes))
+				tmp = -EFAULT;
+		} else {
 			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
 						offset, userbuf);
-			if (tmp < 0)
-				return tmp;
 		}
+		if (tmp < 0)
+			return tmp;
+
 		*ppos += nr_bytes;
 		count -= nr_bytes;
 		buf += nr_bytes;
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 270221fcef42c..9c5fa0ab5e0fe 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -34,17 +34,7 @@
 
 void signalfd_cleanup(struct sighand_struct *sighand)
 {
-	wait_queue_head_t *wqh = &sighand->signalfd_wqh;
-	/*
-	 * The lockless check can race with remove_wait_queue() in progress,
-	 * but in this case its caller should run under rcu_read_lock() and
-	 * sighand_cachep is SLAB_DESTROY_BY_RCU, we can safely return.
-	 */
-	if (likely(!waitqueue_active(wqh)))
-		return;
-
-	/* wait_queue_t->func(POLLFREE) should do remove_wait_queue() */
-	wake_up_poll(wqh, POLLHUP | POLLFREE);
+	wake_up_pollfree(&sighand->signalfd_wqh);
 }
 
 struct signalfd_ctx {
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 985cccfcedad9..e00594ad99724 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -162,6 +162,77 @@ struct tracefs_fs_info {
 	struct tracefs_mount_opts mount_opts;
 };
 
+static void change_gid(struct dentry *dentry, kgid_t gid)
+{
+	if (!dentry->d_inode)
+		return;
+	dentry->d_inode->i_gid = gid;
+}
+
+/*
+ * Taken from d_walk, but without he need for handling renames.
+ * Nothing can be renamed while walking the list, as tracefs
+ * does not support renames. This is only called when mounting
+ * or remounting the file system, to set all the files to
+ * the given gid.
+ */
+static void set_gid(struct dentry *parent, kgid_t gid)
+{
+	struct dentry *this_parent;
+	struct list_head *next;
+
+	this_parent = parent;
+	spin_lock(&this_parent->d_lock);
+
+	change_gid(this_parent, gid);
+repeat:
+	next = this_parent->d_subdirs.next;
+resume:
+	while (next != &this_parent->d_subdirs) {
+		struct list_head *tmp = next;
+		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
+		next = tmp->next;
+
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+
+		change_gid(dentry, gid);
+
+		if (!list_empty(&dentry->d_subdirs)) {
+			spin_unlock(&this_parent->d_lock);
+			spin_release(&dentry->d_lock.dep_map, 1, _RET_IP_);
+			this_parent = dentry;
+			spin_acquire(&this_parent->d_lock.dep_map, 0, 1, _RET_IP_);
+			goto repeat;
+		}
+		spin_unlock(&dentry->d_lock);
+	}
+	/*
+	 * All done at this level ... ascend and resume the search.
+	 */
+	rcu_read_lock();
+ascend:
+	if (this_parent != parent) {
+		struct dentry *child = this_parent;
+		this_parent = child->d_parent;
+
+		spin_unlock(&child->d_lock);
+		spin_lock(&this_parent->d_lock);
+
+		/* go into the first sibling still alive */
+		do {
+			next = child->d_child.next;
+			if (next == &this_parent->d_subdirs)
+				goto ascend;
+			child = list_entry(next, struct dentry, d_child);
+		} while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
+		rcu_read_unlock();
+		goto resume;
+	}
+	rcu_read_unlock();
+	spin_unlock(&this_parent->d_lock);
+	return;
+}
+
 static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -194,6 +265,7 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 			if (!gid_valid(gid))
 				return -EINVAL;
 			opts->gid = gid;
+			set_gid(tracefs_mount->mnt_root, gid);
 			break;
 		case Opt_mode:
 			if (match_octal(&args[0], &option))
@@ -411,6 +483,8 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
 	inode->i_private = data;
+	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
+	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return end_creating(dentry);
@@ -433,6 +507,8 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
 	inode->i_op = ops;
 	inode->i_fop = &simple_dir_operations;
+	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
+	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 6c95812120ebd..5e28a5225e3fb 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -712,7 +712,8 @@ xfs_ioc_space(
 		flags |= XFS_PREALLOC_CLEAR;
 		if (bf->l_start > XFS_ISIZE(ip)) {
 			error = xfs_alloc_file_space(ip, XFS_ISIZE(ip),
-					bf->l_start - XFS_ISIZE(ip), 0);
+					bf->l_start - XFS_ISIZE(ip),
+					XFS_BMAPI_PREALLOC);
 			if (error)
 				goto out_unlock;
 		}
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index c6d6671876080..e9851100c0f7e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -123,6 +123,8 @@ void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start,
 							unsigned long end);
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
 				   int page_size);
+void tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+			 unsigned long size);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address)
diff --git a/include/linux/bug.h b/include/linux/bug.h
index 0faae96302bda..eafb6213e582a 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -3,6 +3,7 @@
 
 #include <asm/bug.h>
 #include <linux/compiler.h>
+#include <linux/build_bug.h>
 
 enum bug_trap_type {
 	BUG_TRAP_TYPE_NONE = 0,
@@ -13,80 +14,9 @@ enum bug_trap_type {
 struct pt_regs;
 
 #ifdef __CHECKER__
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#define BUILD_BUG_ON_ZERO(e) (0)
-#define BUILD_BUG_ON_NULL(e) ((void*)0)
-#define BUILD_BUG_ON_INVALID(e) (0)
-#define BUILD_BUG_ON_MSG(cond, msg) (0)
-#define BUILD_BUG_ON(condition) (0)
-#define BUILD_BUG() (0)
 #define MAYBE_BUILD_BUG_ON(cond) (0)
 #else /* __CHECKER__ */
 
-/* Force a compilation error if a constant expression is not a power of 2 */
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
-	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
-	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
-
-/* Force a compilation error if condition is true, but also produce a
-   result (of value 0 and type size_t), so the expression can be used
-   e.g. in a structure initializer (or where-ever else comma expressions
-   aren't permitted). */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
-#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
-
-/*
- * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
- * expression but avoids the generation of any code, even if that expression
- * has side-effects.
- */
-#define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
-
-/**
- * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
- *		      error message.
- * @condition: the condition which the compiler should know is false.
- *
- * See BUILD_BUG_ON for description.
- */
-#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
-
-/**
- * BUILD_BUG_ON - break compile if a condition is true.
- * @condition: the condition which the compiler should know is false.
- *
- * If you have some code which relies on certain constants being equal, or
- * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
- * detect if someone changes it.
- *
- * The implementation uses gcc's reluctance to create a negative array, but gcc
- * (as of 4.4) only emits that error for obvious cases (e.g. not arguments to
- * inline functions).  Luckily, in 4.3 they added the "error" function
- * attribute just for this type of case.  Thus, we use a negative sized array
- * (should always create an error on gcc versions older than 4.4) and then call
- * an undefined function with the error attribute (should always create an
- * error on gcc 4.3 and later).  If for some reason, neither creates a
- * compile-time error, we'll still have a link-time error, which is harder to
- * track down.
- */
-#ifndef __OPTIMIZE__
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-#else
-#define BUILD_BUG_ON(condition) \
-	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
-#endif
-
-/**
- * BUILD_BUG - break compile if used.
- *
- * If you have some code that you expect the compiler to eliminate at
- * build time, you should use BUILD_BUG to detect if it is
- * unexpectedly used.
- */
-#define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
-
 #define MAYBE_BUILD_BUG_ON(cond)			\
 	do {						\
 		if (__builtin_constant_p((cond)))       \
diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
new file mode 100644
index 0000000000000..b7d22d60008a9
--- /dev/null
+++ b/include/linux/build_bug.h
@@ -0,0 +1,84 @@
+#ifndef _LINUX_BUILD_BUG_H
+#define _LINUX_BUILD_BUG_H
+
+#include <linux/compiler.h>
+
+#ifdef __CHECKER__
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
+#define BUILD_BUG_ON_ZERO(e) (0)
+#define BUILD_BUG_ON_NULL(e) ((void *)0)
+#define BUILD_BUG_ON_INVALID(e) (0)
+#define BUILD_BUG_ON_MSG(cond, msg) (0)
+#define BUILD_BUG_ON(condition) (0)
+#define BUILD_BUG() (0)
+#else /* __CHECKER__ */
+
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
+	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+
+/*
+ * Force a compilation error if condition is true, but also produce a
+ * result (of value 0 and type size_t), so the expression can be used
+ * e.g. in a structure initializer (or where-ever else comma expressions
+ * aren't permitted).
+ */
+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
+#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:(-!!(e)); }))
+
+/*
+ * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
+ * expression but avoids the generation of any code, even if that expression
+ * has side-effects.
+ */
+#define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
+
+/**
+ * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
+ *		      error message.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * See BUILD_BUG_ON for description.
+ */
+#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
+
+/**
+ * BUILD_BUG_ON - break compile if a condition is true.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * If you have some code which relies on certain constants being equal, or
+ * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
+ * detect if someone changes it.
+ *
+ * The implementation uses gcc's reluctance to create a negative array, but gcc
+ * (as of 4.4) only emits that error for obvious cases (e.g. not arguments to
+ * inline functions).  Luckily, in 4.3 they added the "error" function
+ * attribute just for this type of case.  Thus, we use a negative sized array
+ * (should always create an error on gcc versions older than 4.4) and then call
+ * an undefined function with the error attribute (should always create an
+ * error on gcc 4.3 and later).  If for some reason, neither creates a
+ * compile-time error, we'll still have a link-time error, which is harder to
+ * track down.
+ */
+#ifndef __OPTIMIZE__
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
+#else
+#define BUILD_BUG_ON(condition) \
+	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
+#endif
+
+/**
+ * BUILD_BUG - break compile if used.
+ *
+ * If you have some code that you expect the compiler to eliminate at
+ * build time, you should use BUILD_BUG to detect if it is
+ * unexpectedly used.
+ */
+#define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
+
+#endif	/* __CHECKER__ */
+
+#endif	/* _LINUX_BUILD_BUG_H */
diff --git a/include/linux/file.h b/include/linux/file.h
index 7444f5feda125..d5baf7194fb0b 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -12,6 +12,7 @@
 struct file;
 
 extern void fput(struct file *);
+extern void fput_many(struct file *, unsigned int);
 
 struct file_operations;
 struct vfsmount;
@@ -40,6 +41,7 @@ static inline void fdput(struct fd fd)
 }
 
 extern struct file *fget(unsigned int fd);
+extern struct file *fget_many(unsigned int fd, unsigned int refs);
 extern struct file *fget_raw(unsigned int fd);
 extern unsigned long __fdget(unsigned int fd);
 extern unsigned long __fdget_raw(unsigned int fd);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b49278a3e7c4a..58479da94eeb6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -939,7 +939,9 @@ static inline struct file *get_file(struct file *f)
 	atomic_long_inc(&f->f_count);
 	return f;
 }
-#define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
+#define get_file_rcu_many(x, cnt)	\
+	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
+#define get_file_rcu(x) get_file_rcu_many((x), 1)
 #define fput_atomic(x)	atomic_long_add_unless(&(x)->f_count, -1, 1)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2ed6850356ead..a07fa623fd0c2 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -762,6 +762,22 @@ struct hid_ll_driver {
 	int (*idle)(struct hid_device *hdev, int report, int idle, int reqtype);
 };
 
+extern struct hid_ll_driver i2c_hid_ll_driver;
+extern struct hid_ll_driver hidp_hid_driver;
+extern struct hid_ll_driver uhid_hid_driver;
+extern struct hid_ll_driver usb_hid_driver;
+
+static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
+		struct hid_ll_driver *driver)
+{
+	return hdev->ll_driver == driver;
+}
+
+static inline bool hid_is_usb(struct hid_device *hdev)
+{
+	return hid_is_using_ll_driver(hdev, &usb_hid_driver);
+}
+
 #define	PM_HINT_FULLON	1<<5
 #define PM_HINT_NORMAL	1<<1
 
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 848e5796400e7..325e7cbb3d32d 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -122,6 +122,16 @@ static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 	return ns;
 }
 
+static inline struct ipc_namespace *get_ipc_ns_not_zero(struct ipc_namespace *ns)
+{
+	if (ns) {
+		if (atomic_inc_not_zero(&ns->count))
+			return ns;
+	}
+
+	return NULL;
+}
+
 extern void put_ipc_ns(struct ipc_namespace *ns);
 #else
 static inline struct ipc_namespace *copy_ipcs(unsigned long flags,
@@ -138,6 +148,11 @@ static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 	return ns;
 }
 
+static inline struct ipc_namespace *get_ipc_ns_not_zero(struct ipc_namespace *ns)
+{
+	return ns;
+}
+
 static inline void put_ipc_ns(struct ipc_namespace *ns)
 {
 }
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 4db62045f01ae..006ef813959b4 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -192,6 +192,8 @@ struct kretprobe {
 	raw_spinlock_t lock;
 };
 
+#define KRETPROBE_MAX_DATA_SIZE	4096
+
 struct kretprobe_instance {
 	struct hlist_node hlist;
 	struct kretprobe *rp;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11ec0c6dd0ecc..9566ec20e93a6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3191,7 +3191,7 @@ static inline int thread_group_empty(struct task_struct *p)
  * Protects ->fs, ->files, ->mm, ->group_info, ->comm, keyring
  * subscriptions and synchronises with wait4().  Also used in procfs.  Also
  * pins the final release of task.io_context.  Also protects ->cpuset and
- * ->cgroup.subsys[]. And ->vfork_done.
+ * ->cgroup.subsys[]. And ->vfork_done. And ->sysvshm.shm_clist.
  *
  * Nests both inside and outside of read_lock(&tasklist_lock).
  * It must not be nested with write_lock_irq(&tasklist_lock),
diff --git a/include/linux/shm.h b/include/linux/shm.h
index 04e8818296251..9c8b942bd67f0 100644
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -19,9 +19,18 @@ struct shmid_kernel /* private to the kernel */
 	pid_t			shm_lprid;
 	struct user_struct	*mlock_user;
 
-	/* The task created the shm object.  NULL if the task is dead. */
+	/*
+	 * The task created the shm object, for
+	 * task_lock(shp->shm_creator)
+	 */
 	struct task_struct	*shm_creator;
-	struct list_head	shm_clist;	/* list by creator */
+
+	/*
+	 * List by creator. task_lock(->shm_creator) required for read/write.
+	 * If list_empty(), then the creator is dead already.
+	 */
+	struct list_head	shm_clist;
+	struct ipc_namespace	*ns;
 };
 
 /* shm_mode upper byte flags */
diff --git a/include/linux/siphash.h b/include/linux/siphash.h
index bf21591a9e5e6..0cda61855d907 100644
--- a/include/linux/siphash.h
+++ b/include/linux/siphash.h
@@ -27,9 +27,7 @@ static inline bool siphash_key_is_zero(const siphash_key_t *key)
 }
 
 u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key);
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key);
-#endif
 
 u64 siphash_1u64(const u64 a, const siphash_key_t *key);
 u64 siphash_2u64(const u64 a, const u64 b, const siphash_key_t *key);
@@ -82,10 +80,9 @@ static inline u64 ___siphash_aligned(const __le64 *data, size_t len,
 static inline u64 siphash(const void *data, size_t len,
 			  const siphash_key_t *key)
 {
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-	if (!IS_ALIGNED((unsigned long)data, SIPHASH_ALIGNMENT))
+	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
+	    !IS_ALIGNED((unsigned long)data, SIPHASH_ALIGNMENT))
 		return __siphash_unaligned(data, len, key);
-#endif
 	return ___siphash_aligned(data, len, key);
 }
 
@@ -96,10 +93,8 @@ typedef struct {
 
 u32 __hsiphash_aligned(const void *data, size_t len,
 		       const hsiphash_key_t *key);
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u32 __hsiphash_unaligned(const void *data, size_t len,
 			 const hsiphash_key_t *key);
-#endif
 
 u32 hsiphash_1u32(const u32 a, const hsiphash_key_t *key);
 u32 hsiphash_2u32(const u32 a, const u32 b, const hsiphash_key_t *key);
@@ -135,10 +130,9 @@ static inline u32 ___hsiphash_aligned(const __le32 *data, size_t len,
 static inline u32 hsiphash(const void *data, size_t len,
 			   const hsiphash_key_t *key)
 {
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-	if (!IS_ALIGNED((unsigned long)data, HSIPHASH_ALIGNMENT))
+	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
+	    !IS_ALIGNED((unsigned long)data, HSIPHASH_ALIGNMENT))
 		return __hsiphash_unaligned(data, len, key);
-#endif
 	return ___hsiphash_aligned(data, len, key);
 }
 
diff --git a/include/linux/wait.h b/include/linux/wait.h
index db50d66091953..912a6e3cc9b1e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -203,6 +203,7 @@ void __wake_up_locked_key(wait_queue_head_t *q, unsigned int mode, void *key);
 void __wake_up_sync_key(wait_queue_head_t *q, unsigned int mode, int nr, void *key);
 void __wake_up_locked(wait_queue_head_t *q, unsigned int mode, int nr);
 void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr);
+void __wake_up_pollfree(wait_queue_head_t *wq_head);
 void __wake_up_bit(wait_queue_head_t *, void *, int);
 int __wait_on_bit(wait_queue_head_t *, struct wait_bit_queue *, wait_bit_action_f *, unsigned);
 int __wait_on_bit_lock(wait_queue_head_t *, struct wait_bit_queue *, wait_bit_action_f *, unsigned);
@@ -237,6 +238,31 @@ wait_queue_head_t *bit_waitqueue(void *, int);
 #define wake_up_interruptible_sync_poll(x, m)				\
 	__wake_up_sync_key((x), TASK_INTERRUPTIBLE, 1, (void *) (m))
 
+/**
+ * wake_up_pollfree - signal that a polled waitqueue is going away
+ * @wq_head: the wait queue head
+ *
+ * In the very rare cases where a ->poll() implementation uses a waitqueue whose
+ * lifetime is tied to a task rather than to the 'struct file' being polled,
+ * this function must be called before the waitqueue is freed so that
+ * non-blocking polls (e.g. epoll) are notified that the queue is going away.
+ *
+ * The caller must also RCU-delay the freeing of the wait_queue_head, e.g. via
+ * an explicit synchronize_rcu() or call_rcu(), or via SLAB_DESTROY_BY_RCU.
+ */
+static inline void wake_up_pollfree(wait_queue_head_t *wq_head)
+{
+	/*
+	 * For performance reasons, we don't always take the queue lock here.
+	 * Therefore, we might race with someone removing the last entry from
+	 * the queue, and proceed while they still hold the queue lock.
+	 * However, rcu_read_lock() is required to be held in such cases, so we
+	 * can safely proceed with an RCU-delayed free.
+	 */
+	if (waitqueue_active(wq_head))
+		__wake_up_pollfree(wq_head);
+}
+
 #define ___wait_cond_timeout(condition)					\
 ({									\
 	bool __cond = (condition);					\
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 2ba054fe14ac1..3bcce1523894e 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -42,6 +42,7 @@ enum nci_flag {
 	NCI_UP,
 	NCI_DATA_EXCHANGE,
 	NCI_DATA_EXCHANGE_TO,
+	NCI_UNREG,
 };
 
 /* NCI device states */
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index ddcee128f5d9a..145acb8f25095 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -19,6 +19,8 @@
  *
  */
 
+#include <linux/types.h>
+
 #define NL802154_GENL_NAME "nl802154"
 
 enum nl802154_commands {
@@ -150,10 +152,9 @@ enum nl802154_attrs {
 };
 
 enum nl802154_iftype {
-	/* for backwards compatibility TODO */
-	NL802154_IFTYPE_UNSPEC = -1,
+	NL802154_IFTYPE_UNSPEC = (~(__u32)0),
 
-	NL802154_IFTYPE_NODE,
+	NL802154_IFTYPE_NODE = 0,
 	NL802154_IFTYPE_MONITOR,
 	NL802154_IFTYPE_COORD,
 
diff --git a/include/uapi/linux/nfc.h b/include/uapi/linux/nfc.h
index 399f39ff8048d..1b6d54a328bad 100644
--- a/include/uapi/linux/nfc.h
+++ b/include/uapi/linux/nfc.h
@@ -261,7 +261,7 @@ enum nfc_sdp_attr {
 #define NFC_SE_ENABLED  0x1
 
 struct sockaddr_nfc {
-	sa_family_t sa_family;
+	__kernel_sa_family_t sa_family;
 	__u32 dev_idx;
 	__u32 target_idx;
 	__u32 nfc_protocol;
@@ -269,14 +269,14 @@ struct sockaddr_nfc {
 
 #define NFC_LLCP_MAX_SERVICE_NAME 63
 struct sockaddr_nfc_llcp {
-	sa_family_t sa_family;
+	__kernel_sa_family_t sa_family;
 	__u32 dev_idx;
 	__u32 target_idx;
 	__u32 nfc_protocol;
 	__u8 dsap; /* Destination SAP, if known */
 	__u8 ssap; /* Source SAP to be bound to */
 	char service_name[NFC_LLCP_MAX_SERVICE_NAME]; /* Service name URI */;
-	size_t service_name_len;
+	__kernel_size_t service_name_len;
 };
 
 /* NFC socket protocols */
diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 21f4fbd55e48e..276b81cf0daf5 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -24,82 +24,79 @@ typedef unsigned int RING_IDX;
  * A ring contains as many entries as will fit, rounded down to the nearest
  * power of two (so we can mask with (size-1) to loop around).
  */
-#define __CONST_RING_SIZE(_s, _sz)				\
-	(__RD32(((_sz) - offsetof(struct _s##_sring, ring)) /	\
-		sizeof(((struct _s##_sring *)0)->ring[0])))
-
+#define __CONST_RING_SIZE(_s, _sz) \
+    (__RD32(((_sz) - offsetof(struct _s##_sring, ring)) / \
+	    sizeof(((struct _s##_sring *)0)->ring[0])))
 /*
  * The same for passing in an actual pointer instead of a name tag.
  */
-#define __RING_SIZE(_s, _sz)						\
-	(__RD32(((_sz) - (long)&(_s)->ring + (long)(_s)) / sizeof((_s)->ring[0])))
+#define __RING_SIZE(_s, _sz) \
+    (__RD32(((_sz) - (long)(_s)->ring + (long)(_s)) / sizeof((_s)->ring[0])))
 
 /*
  * Macros to make the correct C datatypes for a new kind of ring.
  *
  * To make a new ring datatype, you need to have two message structures,
- * let's say struct request, and struct response already defined.
+ * let's say request_t, and response_t already defined.
  *
  * In a header where you want the ring datatype declared, you then do:
  *
- *     DEFINE_RING_TYPES(mytag, struct request, struct response);
+ *     DEFINE_RING_TYPES(mytag, request_t, response_t);
  *
  * These expand out to give you a set of types, as you can see below.
  * The most important of these are:
  *
- *     struct mytag_sring      - The shared ring.
- *     struct mytag_front_ring - The 'front' half of the ring.
- *     struct mytag_back_ring  - The 'back' half of the ring.
+ *     mytag_sring_t      - The shared ring.
+ *     mytag_front_ring_t - The 'front' half of the ring.
+ *     mytag_back_ring_t  - The 'back' half of the ring.
  *
  * To initialize a ring in your code you need to know the location and size
  * of the shared memory area (PAGE_SIZE, for instance). To initialise
  * the front half:
  *
- *     struct mytag_front_ring front_ring;
- *     SHARED_RING_INIT((struct mytag_sring *)shared_page);
- *     FRONT_RING_INIT(&front_ring, (struct mytag_sring *)shared_page,
- *		       PAGE_SIZE);
+ *     mytag_front_ring_t front_ring;
+ *     SHARED_RING_INIT((mytag_sring_t *)shared_page);
+ *     FRONT_RING_INIT(&front_ring, (mytag_sring_t *)shared_page, PAGE_SIZE);
  *
  * Initializing the back follows similarly (note that only the front
  * initializes the shared ring):
  *
- *     struct mytag_back_ring back_ring;
- *     BACK_RING_INIT(&back_ring, (struct mytag_sring *)shared_page,
- *		      PAGE_SIZE);
+ *     mytag_back_ring_t back_ring;
+ *     BACK_RING_INIT(&back_ring, (mytag_sring_t *)shared_page, PAGE_SIZE);
  */
 
-#define DEFINE_RING_TYPES(__name, __req_t, __rsp_t)			\
-									\
-/* Shared ring entry */							\
-union __name##_sring_entry {						\
-    __req_t req;							\
-    __rsp_t rsp;							\
-};									\
-									\
-/* Shared ring page */							\
-struct __name##_sring {							\
-    RING_IDX req_prod, req_event;					\
-    RING_IDX rsp_prod, rsp_event;					\
-    uint8_t  pad[48];							\
-    union __name##_sring_entry ring[1]; /* variable-length */		\
-};									\
-									\
-/* "Front" end's private variables */					\
-struct __name##_front_ring {						\
-    RING_IDX req_prod_pvt;						\
-    RING_IDX rsp_cons;							\
-    unsigned int nr_ents;						\
-    struct __name##_sring *sring;					\
-};									\
-									\
-/* "Back" end's private variables */					\
-struct __name##_back_ring {						\
-    RING_IDX rsp_prod_pvt;						\
-    RING_IDX req_cons;							\
-    unsigned int nr_ents;						\
-    struct __name##_sring *sring;					\
-};
-
+#define DEFINE_RING_TYPES(__name, __req_t, __rsp_t)                     \
+                                                                        \
+/* Shared ring entry */                                                 \
+union __name##_sring_entry {                                            \
+    __req_t req;                                                        \
+    __rsp_t rsp;                                                        \
+};                                                                      \
+                                                                        \
+/* Shared ring page */                                                  \
+struct __name##_sring {                                                 \
+    RING_IDX req_prod, req_event;                                       \
+    RING_IDX rsp_prod, rsp_event;                                       \
+    uint8_t __pad[48];                                                  \
+    union __name##_sring_entry ring[1]; /* variable-length */           \
+};                                                                      \
+                                                                        \
+/* "Front" end's private variables */                                   \
+struct __name##_front_ring {                                            \
+    RING_IDX req_prod_pvt;                                              \
+    RING_IDX rsp_cons;                                                  \
+    unsigned int nr_ents;                                               \
+    struct __name##_sring *sring;                                       \
+};                                                                      \
+                                                                        \
+/* "Back" end's private variables */                                    \
+struct __name##_back_ring {                                             \
+    RING_IDX rsp_prod_pvt;                                              \
+    RING_IDX req_cons;                                                  \
+    unsigned int nr_ents;                                               \
+    struct __name##_sring *sring;                                       \
+};                                                                      \
+                                                                        \
 /*
  * Macros for manipulating rings.
  *
@@ -116,105 +113,99 @@ struct __name##_back_ring {						\
  */
 
 /* Initialising empty rings */
-#define SHARED_RING_INIT(_s) do {					\
-    (_s)->req_prod  = (_s)->rsp_prod  = 0;				\
-    (_s)->req_event = (_s)->rsp_event = 1;				\
-    memset((_s)->pad, 0, sizeof((_s)->pad));				\
+#define SHARED_RING_INIT(_s) do {                                       \
+    (_s)->req_prod  = (_s)->rsp_prod  = 0;                              \
+    (_s)->req_event = (_s)->rsp_event = 1;                              \
+    (void)memset((_s)->__pad, 0, sizeof((_s)->__pad));                  \
 } while(0)
 
-#define FRONT_RING_INIT(_r, _s, __size) do {				\
-    (_r)->req_prod_pvt = 0;						\
-    (_r)->rsp_cons = 0;							\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
-    (_r)->sring = (_s);							\
+#define FRONT_RING_ATTACH(_r, _s, _i, __size) do {                      \
+    (_r)->req_prod_pvt = (_i);                                          \
+    (_r)->rsp_cons = (_i);                                              \
+    (_r)->nr_ents = __RING_SIZE(_s, __size);                            \
+    (_r)->sring = (_s);                                                 \
 } while (0)
 
-#define BACK_RING_INIT(_r, _s, __size) do {				\
-    (_r)->rsp_prod_pvt = 0;						\
-    (_r)->req_cons = 0;							\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
-    (_r)->sring = (_s);							\
-} while (0)
+#define FRONT_RING_INIT(_r, _s, __size) FRONT_RING_ATTACH(_r, _s, 0, __size)
 
-/* Initialize to existing shared indexes -- for recovery */
-#define FRONT_RING_ATTACH(_r, _s, __size) do {				\
-    (_r)->sring = (_s);							\
-    (_r)->req_prod_pvt = (_s)->req_prod;				\
-    (_r)->rsp_cons = (_s)->rsp_prod;					\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
+#define BACK_RING_ATTACH(_r, _s, _i, __size) do {                       \
+    (_r)->rsp_prod_pvt = (_i);                                          \
+    (_r)->req_cons = (_i);                                              \
+    (_r)->nr_ents = __RING_SIZE(_s, __size);                            \
+    (_r)->sring = (_s);                                                 \
 } while (0)
 
-#define BACK_RING_ATTACH(_r, _s, __size) do {				\
-    (_r)->sring = (_s);							\
-    (_r)->rsp_prod_pvt = (_s)->rsp_prod;				\
-    (_r)->req_cons = (_s)->req_prod;					\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
-} while (0)
+#define BACK_RING_INIT(_r, _s, __size) BACK_RING_ATTACH(_r, _s, 0, __size)
 
 /* How big is this ring? */
-#define RING_SIZE(_r)							\
+#define RING_SIZE(_r)                                                   \
     ((_r)->nr_ents)
 
 /* Number of free requests (for use on front side only). */
-#define RING_FREE_REQUESTS(_r)						\
+#define RING_FREE_REQUESTS(_r)                                          \
     (RING_SIZE(_r) - ((_r)->req_prod_pvt - (_r)->rsp_cons))
 
 /* Test if there is an empty slot available on the front ring.
  * (This is only meaningful from the front. )
  */
-#define RING_FULL(_r)							\
+#define RING_FULL(_r)                                                   \
     (RING_FREE_REQUESTS(_r) == 0)
 
 /* Test if there are outstanding messages to be processed on a ring. */
-#define RING_HAS_UNCONSUMED_RESPONSES(_r)				\
+#define RING_HAS_UNCONSUMED_RESPONSES(_r)                               \
     ((_r)->sring->rsp_prod - (_r)->rsp_cons)
 
-#define RING_HAS_UNCONSUMED_REQUESTS(_r)				\
-    ({									\
-	unsigned int req = (_r)->sring->req_prod - (_r)->req_cons;	\
-	unsigned int rsp = RING_SIZE(_r) -				\
-			   ((_r)->req_cons - (_r)->rsp_prod_pvt);	\
-	req < rsp ? req : rsp;						\
-    })
+#define RING_HAS_UNCONSUMED_REQUESTS(_r) ({                             \
+    unsigned int req = (_r)->sring->req_prod - (_r)->req_cons;          \
+    unsigned int rsp = RING_SIZE(_r) -                                  \
+        ((_r)->req_cons - (_r)->rsp_prod_pvt);                          \
+    req < rsp ? req : rsp;                                              \
+})
 
 /* Direct access to individual ring elements, by index. */
-#define RING_GET_REQUEST(_r, _idx)					\
+#define RING_GET_REQUEST(_r, _idx)                                      \
     (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].req))
 
+#define RING_GET_RESPONSE(_r, _idx)                                     \
+    (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].rsp))
+
 /*
- * Get a local copy of a request.
+ * Get a local copy of a request/response.
  *
- * Use this in preference to RING_GET_REQUEST() so all processing is
+ * Use this in preference to RING_GET_{REQUEST,RESPONSE}() so all processing is
  * done on a local copy that cannot be modified by the other end.
  *
  * Note that https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 may cause this
- * to be ineffective where _req is a struct which consists of only bitfields.
+ * to be ineffective where dest is a struct which consists of only bitfields.
  */
-#define RING_COPY_REQUEST(_r, _idx, _req) do {				\
-	/* Use volatile to force the copy into _req. */			\
-	*(_req) = *(volatile typeof(_req))RING_GET_REQUEST(_r, _idx);	\
+#define RING_COPY_(type, r, idx, dest) do {				\
+	/* Use volatile to force the copy into dest. */			\
+	*(dest) = *(volatile typeof(dest))RING_GET_##type(r, idx);	\
 } while (0)
 
-#define RING_GET_RESPONSE(_r, _idx)					\
-    (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].rsp))
+#define RING_COPY_REQUEST(r, idx, req)  RING_COPY_(REQUEST, r, idx, req)
+#define RING_COPY_RESPONSE(r, idx, rsp) RING_COPY_(RESPONSE, r, idx, rsp)
 
 /* Loop termination condition: Would the specified index overflow the ring? */
-#define RING_REQUEST_CONS_OVERFLOW(_r, _cons)				\
+#define RING_REQUEST_CONS_OVERFLOW(_r, _cons)                           \
     (((_cons) - (_r)->rsp_prod_pvt) >= RING_SIZE(_r))
 
 /* Ill-behaved frontend determination: Can there be this many requests? */
-#define RING_REQUEST_PROD_OVERFLOW(_r, _prod)               \
+#define RING_REQUEST_PROD_OVERFLOW(_r, _prod)                           \
     (((_prod) - (_r)->rsp_prod_pvt) > RING_SIZE(_r))
 
+/* Ill-behaved backend determination: Can there be this many responses? */
+#define RING_RESPONSE_PROD_OVERFLOW(_r, _prod)                          \
+    (((_prod) - (_r)->rsp_cons) > RING_SIZE(_r))
 
-#define RING_PUSH_REQUESTS(_r) do {					\
-    virt_wmb(); /* back sees requests /before/ updated producer index */	\
-    (_r)->sring->req_prod = (_r)->req_prod_pvt;				\
+#define RING_PUSH_REQUESTS(_r) do {                                     \
+    virt_wmb(); /* back sees requests /before/ updated producer index */\
+    (_r)->sring->req_prod = (_r)->req_prod_pvt;                         \
 } while (0)
 
-#define RING_PUSH_RESPONSES(_r) do {					\
-    virt_wmb(); /* front sees responses /before/ updated producer index */	\
-    (_r)->sring->rsp_prod = (_r)->rsp_prod_pvt;				\
+#define RING_PUSH_RESPONSES(_r) do {                                    \
+    virt_wmb(); /* front sees resps /before/ updated producer index */  \
+    (_r)->sring->rsp_prod = (_r)->rsp_prod_pvt;                         \
 } while (0)
 
 /*
@@ -247,40 +238,40 @@ struct __name##_back_ring {						\
  *  field appropriately.
  */
 
-#define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {		\
-    RING_IDX __old = (_r)->sring->req_prod;				\
-    RING_IDX __new = (_r)->req_prod_pvt;				\
-    virt_wmb(); /* back sees requests /before/ updated producer index */	\
-    (_r)->sring->req_prod = __new;					\
-    virt_mb(); /* back sees new requests /before/ we check req_event */	\
-    (_notify) = ((RING_IDX)(__new - (_r)->sring->req_event) <		\
-		 (RING_IDX)(__new - __old));				\
+#define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {           \
+    RING_IDX __old = (_r)->sring->req_prod;                             \
+    RING_IDX __new = (_r)->req_prod_pvt;                                \
+    virt_wmb(); /* back sees requests /before/ updated producer index */\
+    (_r)->sring->req_prod = __new;                                      \
+    virt_mb(); /* back sees new requests /before/ we check req_event */ \
+    (_notify) = ((RING_IDX)(__new - (_r)->sring->req_event) <           \
+                 (RING_IDX)(__new - __old));                            \
 } while (0)
 
-#define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {		\
-    RING_IDX __old = (_r)->sring->rsp_prod;				\
-    RING_IDX __new = (_r)->rsp_prod_pvt;				\
-    virt_wmb(); /* front sees responses /before/ updated producer index */	\
-    (_r)->sring->rsp_prod = __new;					\
-    virt_mb(); /* front sees new responses /before/ we check rsp_event */	\
-    (_notify) = ((RING_IDX)(__new - (_r)->sring->rsp_event) <		\
-		 (RING_IDX)(__new - __old));				\
+#define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {          \
+    RING_IDX __old = (_r)->sring->rsp_prod;                             \
+    RING_IDX __new = (_r)->rsp_prod_pvt;                                \
+    virt_wmb(); /* front sees resps /before/ updated producer index */  \
+    (_r)->sring->rsp_prod = __new;                                      \
+    virt_mb(); /* front sees new resps /before/ we check rsp_event */   \
+    (_notify) = ((RING_IDX)(__new - (_r)->sring->rsp_event) <           \
+                 (RING_IDX)(__new - __old));                            \
 } while (0)
 
-#define RING_FINAL_CHECK_FOR_REQUESTS(_r, _work_to_do) do {		\
-    (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
-    if (_work_to_do) break;						\
-    (_r)->sring->req_event = (_r)->req_cons + 1;			\
-    virt_mb();								\
-    (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
+#define RING_FINAL_CHECK_FOR_REQUESTS(_r, _work_to_do) do {             \
+    (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);                   \
+    if (_work_to_do) break;                                             \
+    (_r)->sring->req_event = (_r)->req_cons + 1;                        \
+    virt_mb();                                                          \
+    (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);                   \
 } while (0)
 
-#define RING_FINAL_CHECK_FOR_RESPONSES(_r, _work_to_do) do {		\
-    (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
-    if (_work_to_do) break;						\
-    (_r)->sring->rsp_event = (_r)->rsp_cons + 1;			\
-    virt_mb();								\
-    (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
+#define RING_FINAL_CHECK_FOR_RESPONSES(_r, _work_to_do) do {            \
+    (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);                  \
+    if (_work_to_do) break;                                             \
+    (_r)->sring->rsp_event = (_r)->rsp_cons + 1;                        \
+    virt_mb();                                                          \
+    (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);                  \
 } while (0)
 
 #endif /* __XEN_PUBLIC_IO_RING_H__ */
diff --git a/ipc/shm.c b/ipc/shm.c
index 9c687cda9b0ab..74e0f2af99982 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -90,6 +90,7 @@ static void do_shm_rmid(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 {
 	struct shmid_kernel *shp;
 	shp = container_of(ipcp, struct shmid_kernel, shm_perm);
+	WARN_ON(ns != shp->ns);
 
 	if (shp->shm_nattch) {
 		shp->shm_perm.mode |= SHM_DEST;
@@ -180,10 +181,43 @@ static void shm_rcu_free(struct rcu_head *head)
 	ipc_rcu_free(head);
 }
 
-static inline void shm_rmid(struct ipc_namespace *ns, struct shmid_kernel *s)
+/*
+ * It has to be called with shp locked.
+ * It must be called before ipc_rmid()
+ */
+static inline void shm_clist_rm(struct shmid_kernel *shp)
 {
-	list_del(&s->shm_clist);
-	ipc_rmid(&shm_ids(ns), &s->shm_perm);
+	struct task_struct *creator;
+
+	/* ensure that shm_creator does not disappear */
+	rcu_read_lock();
+
+	/*
+	 * A concurrent exit_shm may do a list_del_init() as well.
+	 * Just do nothing if exit_shm already did the work
+	 */
+	if (!list_empty(&shp->shm_clist)) {
+		/*
+		 * shp->shm_creator is guaranteed to be valid *only*
+		 * if shp->shm_clist is not empty.
+		 */
+		creator = shp->shm_creator;
+
+		task_lock(creator);
+		/*
+		 * list_del_init() is a nop if the entry was already removed
+		 * from the list.
+		 */
+		list_del_init(&shp->shm_clist);
+		task_unlock(creator);
+	}
+	rcu_read_unlock();
+}
+
+static inline void shm_rmid(struct shmid_kernel *s)
+{
+	shm_clist_rm(s);
+	ipc_rmid(&shm_ids(s->ns), &s->shm_perm);
 }
 
 
@@ -238,7 +272,7 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
 	shm_file = shp->shm_file;
 	shp->shm_file = NULL;
 	ns->shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	shm_rmid(ns, shp);
+	shm_rmid(shp);
 	shm_unlock(shp);
 	if (!is_file_hugepages(shm_file))
 		shmem_lock(shm_file, 0, shp->mlock_user);
@@ -259,10 +293,10 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
  *
  * 2) sysctl kernel.shm_rmid_forced is set to 1.
  */
-static bool shm_may_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
+static bool shm_may_destroy(struct shmid_kernel *shp)
 {
 	return (shp->shm_nattch == 0) &&
-	       (ns->shm_rmid_forced ||
+	       (shp->ns->shm_rmid_forced ||
 		(shp->shm_perm.mode & SHM_DEST));
 }
 
@@ -293,7 +327,7 @@ static void shm_close(struct vm_area_struct *vma)
 	shp->shm_lprid = task_tgid_vnr(current);
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
-	if (shm_may_destroy(ns, shp))
+	if (shm_may_destroy(shp))
 		shm_destroy(ns, shp);
 	else
 		shm_unlock(shp);
@@ -314,10 +348,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
 	 *
 	 * As shp->* are changed under rwsem, it's safe to skip shp locking.
 	 */
-	if (shp->shm_creator != NULL)
+	if (!list_empty(&shp->shm_clist))
 		return 0;
 
-	if (shm_may_destroy(ns, shp)) {
+	if (shm_may_destroy(shp)) {
 		shm_lock_by_ptr(shp);
 		shm_destroy(ns, shp);
 	}
@@ -335,48 +369,97 @@ void shm_destroy_orphaned(struct ipc_namespace *ns)
 /* Locking assumes this will only be called with task == current */
 void exit_shm(struct task_struct *task)
 {
-	struct ipc_namespace *ns = task->nsproxy->ipc_ns;
-	struct shmid_kernel *shp, *n;
+	for (;;) {
+		struct shmid_kernel *shp;
+		struct ipc_namespace *ns;
 
-	if (list_empty(&task->sysvshm.shm_clist))
-		return;
+		task_lock(task);
+
+		if (list_empty(&task->sysvshm.shm_clist)) {
+			task_unlock(task);
+			break;
+		}
+
+		shp = list_first_entry(&task->sysvshm.shm_clist, struct shmid_kernel,
+				shm_clist);
 
-	/*
-	 * If kernel.shm_rmid_forced is not set then only keep track of
-	 * which shmids are orphaned, so that a later set of the sysctl
-	 * can clean them up.
-	 */
-	if (!ns->shm_rmid_forced) {
-		down_read(&shm_ids(ns).rwsem);
-		list_for_each_entry(shp, &task->sysvshm.shm_clist, shm_clist)
-			shp->shm_creator = NULL;
 		/*
-		 * Only under read lock but we are only called on current
-		 * so no entry on the list will be shared.
+		 * 1) Get pointer to the ipc namespace. It is worth to say
+		 * that this pointer is guaranteed to be valid because
+		 * shp lifetime is always shorter than namespace lifetime
+		 * in which shp lives.
+		 * We taken task_lock it means that shp won't be freed.
 		 */
-		list_del(&task->sysvshm.shm_clist);
-		up_read(&shm_ids(ns).rwsem);
-		return;
-	}
+		ns = shp->ns;
 
-	/*
-	 * Destroy all already created segments, that were not yet mapped,
-	 * and mark any mapped as orphan to cover the sysctl toggling.
-	 * Destroy is skipped if shm_may_destroy() returns false.
-	 */
-	down_write(&shm_ids(ns).rwsem);
-	list_for_each_entry_safe(shp, n, &task->sysvshm.shm_clist, shm_clist) {
-		shp->shm_creator = NULL;
+		/*
+		 * 2) If kernel.shm_rmid_forced is not set then only keep track of
+		 * which shmids are orphaned, so that a later set of the sysctl
+		 * can clean them up.
+		 */
+		if (!ns->shm_rmid_forced)
+			goto unlink_continue;
 
-		if (shm_may_destroy(ns, shp)) {
-			shm_lock_by_ptr(shp);
-			shm_destroy(ns, shp);
+		/*
+		 * 3) get a reference to the namespace.
+		 *    The refcount could be already 0. If it is 0, then
+		 *    the shm objects will be free by free_ipc_work().
+		 */
+		ns = get_ipc_ns_not_zero(ns);
+		if (!ns) {
+unlink_continue:
+			list_del_init(&shp->shm_clist);
+			task_unlock(task);
+			continue;
 		}
-	}
 
-	/* Remove the list head from any segments still attached. */
-	list_del(&task->sysvshm.shm_clist);
-	up_write(&shm_ids(ns).rwsem);
+		/*
+		 * 4) get a reference to shp.
+		 *   This cannot fail: shm_clist_rm() is called before
+		 *   ipc_rmid(), thus the refcount cannot be 0.
+		 */
+		WARN_ON(!ipc_rcu_getref(&shp->shm_perm));
+
+		/*
+		 * 5) unlink the shm segment from the list of segments
+		 *    created by current.
+		 *    This must be done last. After unlinking,
+		 *    only the refcounts obtained above prevent IPC_RMID
+		 *    from destroying the segment or the namespace.
+		 */
+		list_del_init(&shp->shm_clist);
+
+		task_unlock(task);
+
+		/*
+		 * 6) we have all references
+		 *    Thus lock & if needed destroy shp.
+		 */
+		down_write(&shm_ids(ns).rwsem);
+		shm_lock_by_ptr(shp);
+		/*
+		 * rcu_read_lock was implicitly taken in shm_lock_by_ptr, it's
+		 * safe to call ipc_rcu_putref here
+		 */
+		ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
+
+		if (ipc_valid_object(&shp->shm_perm)) {
+			if (shm_may_destroy(shp))
+				shm_destroy(ns, shp);
+			else
+				shm_unlock(shp);
+		} else {
+			/*
+			 * Someone else deleted the shp from namespace
+			 * idr/kht while we have waited.
+			 * Just unlock and continue.
+			 */
+			shm_unlock(shp);
+		}
+
+		up_write(&shm_ids(ns).rwsem);
+		put_ipc_ns(ns); /* paired with get_ipc_ns_not_zero */
+	}
 }
 
 static int shm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
@@ -621,7 +704,11 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		goto no_id;
 	}
 
+	shp->ns = ns;
+
+	task_lock(current);
 	list_add(&shp->shm_clist, &current->sysvshm.shm_clist);
+	task_unlock(current);
 
 	/*
 	 * shmid gets reported as "inode#" in /proc/pid/maps.
@@ -1270,7 +1357,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	down_write(&shm_ids(ns).rwsem);
 	shp = shm_lock(ns, shmid);
 	shp->shm_nattch--;
-	if (shm_may_destroy(ns, shp))
+
+	if (shm_may_destroy(shp))
 		shm_destroy(ns, shp);
 	else
 		shm_unlock(shp);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 51867a2e537fa..fb2357d0dbc85 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1899,6 +1899,9 @@ int register_kretprobe(struct kretprobe *rp)
 		}
 	}
 
+	if (rp->data_size > KRETPROBE_MAX_DATA_SIZE)
+		return -E2BIG;
+
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 18f3162a9d394..8a406f53d2117 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -679,7 +679,7 @@ static int load_image_and_restore(void)
 		goto Unlock;
 
 	error = swsusp_read(&flags);
-	swsusp_close(FMODE_READ);
+	swsusp_close(FMODE_READ | FMODE_EXCL);
 	if (!error)
 		hibernation_restore(flags & SF_PLATFORM_MODE);
 
@@ -880,7 +880,7 @@ static int software_resume(void)
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
 		error = -EBUSY;
-		swsusp_close(FMODE_READ);
+		swsusp_close(FMODE_READ | FMODE_EXCL);
 		goto Unlock;
 	}
 
@@ -914,7 +914,7 @@ static int software_resume(void)
 	pr_debug("PM: Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(FMODE_READ);
+	swsusp_close(FMODE_READ | FMODE_EXCL);
 	goto Finish;
 }
 
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 9453efe9b25a6..133afaf05c3f4 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -10,6 +10,7 @@
 #include <linux/wait.h>
 #include <linux/hash.h>
 #include <linux/kthread.h>
+#include <linux/poll.h>
 
 void __init_waitqueue_head(wait_queue_head_t *q, const char *name, struct lock_class_key *key)
 {
@@ -156,6 +157,13 @@ void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 }
 EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
+void __wake_up_pollfree(wait_queue_head_t *wq_head)
+{
+	__wake_up(wq_head, TASK_NORMAL, 0, (void *)(POLLHUP | POLLFREE));
+	/* POLLFREE must have cleared the queue. */
+	WARN_ON_ONCE(waitqueue_active(wq_head));
+}
+
 /*
  * Note: we use "set_current_state()" _after_ the wait-queue add,
  * because we need a memory barrier there on SMP, so that any
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ce384f76bdd8c..6fb2316f212c9 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1198,8 +1198,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	timekeeping_forward_now(tk);
 
 	xt = tk_xtime(tk);
-	ts_delta.tv_sec = ts->tv_sec - xt.tv_sec;
-	ts_delta.tv_nsec = ts->tv_nsec - xt.tv_nsec;
+	ts_delta = timespec64_sub(*ts, xt);
 
 	if (timespec64_compare(&tk->wall_to_monotonic, &ts_delta) > 0) {
 		ret = -EINVAL;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fb940c9e77473..df5a3e8db8279 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2358,7 +2358,7 @@ struct trace_buffer_struct {
 	char buffer[4][TRACE_BUF_SIZE];
 };
 
-static struct trace_buffer_struct *trace_percpu_buffer;
+static struct trace_buffer_struct __percpu *trace_percpu_buffer;
 
 /*
  * Thise allows for lockless recording.  If we're nested too deeply, then
@@ -2368,7 +2368,7 @@ static char *get_trace_buf(void)
 {
 	struct trace_buffer_struct *buffer = this_cpu_ptr(trace_percpu_buffer);
 
-	if (!buffer || buffer->nesting >= 4)
+	if (!trace_percpu_buffer || buffer->nesting >= 4)
 		return NULL;
 
 	buffer->nesting++;
@@ -2387,7 +2387,7 @@ static void put_trace_buf(void)
 
 static int alloc_percpu_trace_buffer(void)
 {
-	struct trace_buffer_struct *buffers;
+	struct trace_buffer_struct __percpu *buffers;
 
 	buffers = alloc_percpu(struct trace_buffer_struct);
 	if (WARN(!buffers, "Could not allocate percpu trace_printk buffer"))
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 14578da6ffd1a..b64c7751c1565 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1163,14 +1163,26 @@ __event_trigger_test_discard(struct trace_event_file *file,
 	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
 		*tt = event_triggers_call(file, entry);
 
-	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
-	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
-	     !filter_match_preds(file->filter, entry))) {
-		__trace_event_discard_commit(buffer, event);
-		return true;
-	}
+	if (likely(!(file->flags & (EVENT_FILE_FL_SOFT_DISABLED |
+				    EVENT_FILE_FL_FILTERED |
+				    EVENT_FILE_FL_PID_FILTER))))
+		return false;
+
+	if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
+		goto discard;
+
+	if (file->flags & EVENT_FILE_FL_FILTERED &&
+	    !filter_match_preds(file->filter, entry))
+		goto discard;
+
+	if ((file->flags & EVENT_FILE_FL_PID_FILTER) &&
+	    trace_event_ignore_this_pid(file))
+		goto discard;
 
 	return false;
+ discard:
+	__trace_event_discard_commit(buffer, event);
+	return true;
 }
 
 /**
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 8b073a41de9fd..df7c162867970 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2243,12 +2243,19 @@ static struct trace_event_file *
 trace_create_new_event(struct trace_event_call *call,
 		       struct trace_array *tr)
 {
+	struct trace_pid_list *pid_list;
 	struct trace_event_file *file;
 
 	file = kmem_cache_alloc(file_cachep, GFP_TRACE);
 	if (!file)
 		return NULL;
 
+	pid_list = rcu_dereference_protected(tr->filtered_pids,
+					     lockdep_is_held(&event_mutex));
+
+	if (pid_list)
+		file->flags |= EVENT_FILE_FL_PID_FILTER;
+
 	file->event_call = call;
 	file->tr = tr;
 	atomic_set(&file->sm_ref, 0);
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 379db35838b64..572c0854d631c 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -24,6 +24,7 @@
 #include <linux/jhash.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/kmemleak.h>
 
 #include "tracing_map.h"
 #include "trace.h"
@@ -227,6 +228,7 @@ void tracing_map_array_free(struct tracing_map_array *a)
 	for (i = 0; i < a->n_pages; i++) {
 		if (!a->pages[i])
 			break;
+		kmemleak_free(a->pages[i]);
 		free_page((unsigned long)a->pages[i]);
 	}
 
@@ -262,6 +264,7 @@ struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 		a->pages[i] = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!a->pages[i])
 			goto free;
+		kmemleak_alloc(a->pages[i], PAGE_SIZE, 1, GFP_KERNEL);
 	}
  out:
 	return a;
diff --git a/lib/siphash.c b/lib/siphash.c
index 3ae58b4edad61..e632ee40aac1a 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -49,6 +49,7 @@
 	SIPROUND; \
 	return (v0 ^ v1) ^ (v2 ^ v3);
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
 {
 	const u8 *end = data + len - (len % sizeof(u64));
@@ -80,8 +81,8 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
 	POSTAMBLE
 }
 EXPORT_SYMBOL(__siphash_aligned);
+#endif
 
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
 {
 	const u8 *end = data + len - (len % sizeof(u64));
@@ -113,7 +114,6 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
 	POSTAMBLE
 }
 EXPORT_SYMBOL(__siphash_unaligned);
-#endif
 
 /**
  * siphash_1u64 - compute 64-bit siphash PRF value of a u64
@@ -250,6 +250,7 @@ EXPORT_SYMBOL(siphash_3u32);
 	HSIPROUND; \
 	return (v0 ^ v1) ^ (v2 ^ v3);
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 {
 	const u8 *end = data + len - (len % sizeof(u64));
@@ -280,8 +281,8 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 	HPOSTAMBLE
 }
 EXPORT_SYMBOL(__hsiphash_aligned);
+#endif
 
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u32 __hsiphash_unaligned(const void *data, size_t len,
 			 const hsiphash_key_t *key)
 {
@@ -313,7 +314,6 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 	HPOSTAMBLE
 }
 EXPORT_SYMBOL(__hsiphash_unaligned);
-#endif
 
 /**
  * hsiphash_1u32 - compute 64-bit hsiphash PRF value of a u32
@@ -418,6 +418,7 @@ EXPORT_SYMBOL(hsiphash_4u32);
 	HSIPROUND; \
 	return v1 ^ v3;
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 {
 	const u8 *end = data + len - (len % sizeof(u32));
@@ -438,8 +439,8 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 	HPOSTAMBLE
 }
 EXPORT_SYMBOL(__hsiphash_aligned);
+#endif
 
-#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 u32 __hsiphash_unaligned(const void *data, size_t len,
 			 const hsiphash_key_t *key)
 {
@@ -461,7 +462,6 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 	HPOSTAMBLE
 }
 EXPORT_SYMBOL(__hsiphash_unaligned);
-#endif
 
 /**
  * hsiphash_1u32 - compute 32-bit hsiphash PRF value of a u32
diff --git a/localversion-rt b/localversion-rt
index 204b8d4c3b7d1..d68f944b6cad8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt190
+-rt191
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 03bacb89e7dd5..de2f1f0ca2d0f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -865,6 +865,13 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	wb_shutdown(&bdi->wb);
 	cgwb_bdi_destroy(bdi);
 
+	/*
+	 * If this BDI's min ratio has been set, use bdi_set_min_ratio() to
+	 * update the global bdi_min_ratio.
+	 */
+	if (bdi->min_ratio)
+		bdi_set_min_ratio(bdi, 0);
+
 	if (bdi->dev) {
 		bdi_debug_unregister(bdi);
 		device_unregister(bdi->dev);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de89e9295f6c5..8aad9bd08462e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3393,14 +3393,20 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct page *page;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	const unsigned long mmun_start = start;	/* For mmu_notifiers */
-	const unsigned long mmun_end   = end;	/* For mmu_notifiers */
+	unsigned long mmun_start = start;	/* For mmu_notifiers */
+	unsigned long mmun_end   = end;		/* For mmu_notifiers */
+	bool force_flush = false;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON(start & ~huge_page_mask(h));
 	BUG_ON(end & ~huge_page_mask(h));
 
 	tlb_start_vma(tlb, vma);
+
+	/*
+	 * If sharing possible, alert mmu notifiers of worst case.
+	 */
+	adjust_range_if_pmd_sharing_possible(vma, &mmun_start, &mmun_end);
 	mmu_notifier_invalidate_range_start(mm, mmun_start, mmun_end);
 	address = start;
 	for (; address < end; address += sz) {
@@ -3411,6 +3417,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, &address, ptep)) {
 			spin_unlock(ptl);
+			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
+			force_flush = true;
 			continue;
 		}
 
@@ -3467,6 +3475,22 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
 	tlb_end_vma(tlb, vma);
+
+	/*
+	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
+	 * could defer the flush until now, since by holding i_mmap_rwsem we
+	 * guaranteed that the last refernece would not be dropped. But we must
+	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
+	 * dropped and the last reference to the shared PMDs page might be
+	 * dropped as well.
+	 *
+	 * In theory we could defer the freeing of the PMD pages as well, but
+	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
+	 * detect sharing, so we cannot defer the release of the page either.
+	 * Instead, do flush now.
+	 */
+	if (force_flush)
+		tlb_flush_mmu(tlb);
 }
 
 void __unmap_hugepage_range_final(struct mmu_gather *tlb,
@@ -3493,12 +3517,23 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 {
 	struct mm_struct *mm;
 	struct mmu_gather tlb;
+	unsigned long tlb_start = start;
+	unsigned long tlb_end = end;
+
+	/*
+	 * If shared PMDs were possibly used within this vma range, adjust
+	 * start/end for worst case tlb flushing.
+	 * Note that we can not be sure if PMDs are shared until we try to
+	 * unmap pages.  However, we want to make sure TLB flushing covers
+	 * the largest possible range.
+	 */
+	adjust_range_if_pmd_sharing_possible(vma, &tlb_start, &tlb_end);
 
 	mm = vma->vm_mm;
 
-	tlb_gather_mmu(&tlb, mm, start, end);
+	tlb_gather_mmu(&tlb, mm, tlb_start, tlb_end);
 	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
-	tlb_finish_mmu(&tlb, start, end);
+	tlb_finish_mmu(&tlb, tlb_start, tlb_end);
 }
 
 /*
@@ -4186,11 +4221,21 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long pages = 0;
+	unsigned long f_start = start;
+	unsigned long f_end = end;
+	bool shared_pmd = false;
+
+	/*
+	 * In the case of shared PMDs, the area to flush could be beyond
+	 * start/end.  Set f_start/f_end to cover the maximum possible
+	 * range if PMD sharing is possible.
+	 */
+	adjust_range_if_pmd_sharing_possible(vma, &f_start, &f_end);
 
 	BUG_ON(address >= end);
-	flush_cache_range(vma, address, end);
+	flush_cache_range(vma, f_start, f_end);
 
-	mmu_notifier_invalidate_range_start(mm, start, end);
+	mmu_notifier_invalidate_range_start(mm, f_start, f_end);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (; address < end; address += huge_page_size(h)) {
 		spinlock_t *ptl;
@@ -4201,6 +4246,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 		if (huge_pmd_unshare(mm, &address, ptep)) {
 			pages++;
 			spin_unlock(ptl);
+			shared_pmd = true;
 			continue;
 		}
 		pte = huge_ptep_get(ptep);
@@ -4235,12 +4281,18 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
 	 * may have cleared our pud entry and done put_page on the page table:
 	 * once we release i_mmap_rwsem, another task can do the final put_page
-	 * and that page table be reused and filled with junk.
+	 * and that page table be reused and filled with junk.  If we actually
+	 * did unshare a page of pmds, flush the range corresponding to the pud.
 	 */
-	flush_hugetlb_tlb_range(vma, start, end);
-	mmu_notifier_invalidate_range(mm, start, end);
+	if (shared_pmd) {
+		flush_hugetlb_tlb_range(vma, f_start, f_end);
+		mmu_notifier_invalidate_range(mm, f_start, f_end);
+	} else {
+		flush_hugetlb_tlb_range(vma, start, end);
+		mmu_notifier_invalidate_range(mm, start, end);
+	}
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
-	mmu_notifier_invalidate_range_end(mm, start, end);
+	mmu_notifier_invalidate_range_end(mm, f_start, f_end);
 
 	return pages << h->order;
 }
diff --git a/mm/memory.c b/mm/memory.c
index be592d434ad89..c2890dc104d9e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -320,6 +320,22 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 	return false;
 }
 
+void tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
+			 unsigned long size)
+{
+	if (tlb->page_size != 0 && tlb->page_size != PMD_SIZE)
+		tlb_flush_mmu(tlb);
+
+	tlb->page_size = PMD_SIZE;
+	tlb->start = min(tlb->start, address);
+	tlb->end = max(tlb->end, address + size);
+	/*
+	 * Track the last address with which we adjusted the range. This
+	 * will be used later to adjust again after a mmu_flush due to
+	 * failed __tlb_remove_page
+	 */
+	tlb->addr = address + size - PMD_SIZE;
+}
 #endif /* HAVE_GENERIC_MMU_GATHER */
 
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 64fede18aa33f..f4c8567e91b38 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -88,8 +88,10 @@ static void ax25_kill_by_device(struct net_device *dev)
 again:
 	ax25_for_each(s, &ax25_list) {
 		if (s->ax25_dev == ax25_dev) {
-			s->ax25_dev = NULL;
 			spin_unlock_bh(&ax25_list_lock);
+			lock_sock(s->sk);
+			s->ax25_dev = NULL;
+			release_sock(s->sk);
 			ax25_disconnect(s, ENETUNREACH);
 			spin_lock_bh(&ax25_list_lock);
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 9ec37c6c8c4aa..00f25e54119cf 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -734,7 +734,7 @@ static void hidp_stop(struct hid_device *hid)
 	hid->claimed = 0;
 }
 
-static struct hid_ll_driver hidp_hid_driver = {
+struct hid_ll_driver hidp_hid_driver = {
 	.parse = hidp_parse,
 	.start = hidp_start,
 	.stop = hidp_stop,
@@ -743,6 +743,7 @@ static struct hid_ll_driver hidp_hid_driver = {
 	.raw_request = hidp_raw_request,
 	.output_report = hidp_output_report,
 };
+EXPORT_SYMBOL_GPL(hidp_hid_driver);
 
 /* This function sets up the hid device. It does not add it
    to the HID system. That is done in hidp_add_connection(). */
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 2aa5c231560d2..19e6049058d18 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -597,7 +597,7 @@ struct pneigh_entry * pneigh_lookup(struct neigh_table *tbl,
 
 	ASSERT_RTNL();
 
-	n = kmalloc(sizeof(*n) + key_len, GFP_KERNEL);
+	n = kzalloc(sizeof(*n) + key_len, GFP_KERNEL);
 	if (!n)
 		goto out;
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 689246d079ad4..a8563745980b4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1833,6 +1833,10 @@ static int __init inet_init(void)
 
 	tcp_v4_init();
 
+	/* Initialise per-cpu ipv4 mibs */
+	if (init_ipv4_mibs())
+		panic("%s: Cannot init ipv4 mibs\n", __func__);
+
 	/* Setup TCP slab cache for open requests. */
 	tcp_init();
 
@@ -1861,12 +1865,6 @@ static int __init inet_init(void)
 
 	if (init_inet_pernet_ops())
 		pr_crit("%s: Cannot init ipv4 inet pernet ops\n", __func__);
-	/*
-	 *	Initialise per-cpu ipv4 mibs
-	 */
-
-	if (init_ipv4_mibs())
-		pr_crit("%s: Cannot init ipv4 mibs\n", __func__);
 
 	ipv4_proc_init();
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 6f3c529431865..7a2442623d6a6 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2271,7 +2271,7 @@ static int __devinet_sysctl_register(struct net *net, char *dev_name,
 free:
 	kfree(t);
 out:
-	return -ENOBUFS;
+	return -ENOMEM;
 }
 
 static void __devinet_sysctl_unregister(struct ipv4_devconf *cnf)
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 00397c6add202..d710c519a0357 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -342,8 +342,6 @@ static void bictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 		return;
 
 	if (tcp_in_slow_start(tp)) {
-		if (hystart && after(ack, ca->end_seq))
-			bictcp_hystart_reset(sk);
 		acked = tcp_slow_start(tp, acked);
 		if (!acked)
 			return;
@@ -394,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 delay)
 	if (ca->found & hystart_detect)
 		return;
 
+	if (after(tp->snd_una, ca->end_seq))
+		bictcp_hystart_reset(sk);
+
 	if (hystart_detect & HYSTART_ACK_TRAIN) {
 		u32 now = bictcp_clock();
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 860ab2e6544cc..8770966a564b5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2435,7 +2435,7 @@ int udp4_seq_show(struct seq_file *seq, void *v)
 {
 	seq_setwidth(seq, 127);
 	if (v == SEQ_START_TOKEN)
-		seq_puts(seq, "  sl  local_address rem_address   st tx_queue "
+		seq_puts(seq, "   sl  local_address rem_address   st tx_queue "
 			   "rx_queue tr tm->when retrnsmt   uid  timeout "
 			   "inode ref pointer drops");
 	else {
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index f58d69216b616..ce5b55491942d 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -773,6 +773,8 @@ vti6_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 
+	memset(&p1, 0, sizeof(p1));
+
 	switch (cmd) {
 	case SIOCGETTUNNEL:
 		if (dev == ip6n->fb_tnl_dev) {
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 80c45567ee3ad..030d85790584d 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -109,7 +109,7 @@ static void ieee80211_send_addba_request(struct ieee80211_sub_if_data *sdata,
 	mgmt->u.action.u.addba_req.start_seq_num =
 					cpu_to_le16(start_seq_num << 4);
 
-	ieee80211_tx_skb(sdata, skb);
+	ieee80211_tx_skb_tid(sdata, skb, tid);
 }
 
 void ieee80211_send_bar(struct ieee80211_vif *vif, u8 *ra, u16 tid, u16 ssn)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3217c98f2b5a2..56c58ff8ef748 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4450,7 +4450,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
 	if (new_sta) {
 		u32 rates = 0, basic_rates = 0;
-		bool have_higher_than_11mbit;
+		bool have_higher_than_11mbit = false;
 		int min_rate = INT_MAX, min_rate_index = -1;
 		struct ieee80211_chanctx_conf *chanctx_conf;
 		const struct cfg80211_bss_ies *ies;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 1b70de5898c42..13d69cbd14c20 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1804,6 +1804,11 @@ static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (msg->msg_flags&MSG_OOB)
 		return -EOPNOTSUPP;
 
+	if (len == 0) {
+		pr_warn_once("Zero length message leads to an empty skb\n");
+		return -ENODATA;
+	}
+
 	err = scm_send(sock, msg, &scm, true);
 	if (err < 0)
 		return err;
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 19518a231e571..84eedbd5716d1 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -486,6 +486,11 @@ static int nci_open_device(struct nci_dev *ndev)
 
 	mutex_lock(&ndev->req_lock);
 
+	if (test_bit(NCI_UNREG, &ndev->flags)) {
+		rc = -ENODEV;
+		goto done;
+	}
+
 	if (test_bit(NCI_UP, &ndev->flags)) {
 		rc = -EALREADY;
 		goto done;
@@ -549,6 +554,10 @@ static int nci_open_device(struct nci_dev *ndev)
 static int nci_close_device(struct nci_dev *ndev)
 {
 	nci_req_cancel(ndev, ENODEV);
+
+	/* This mutex needs to be held as a barrier for
+	 * caller nci_unregister_device
+	 */
 	mutex_lock(&ndev->req_lock);
 
 	if (!test_and_clear_bit(NCI_UP, &ndev->flags)) {
@@ -586,8 +595,8 @@ static int nci_close_device(struct nci_dev *ndev)
 	/* Flush cmd wq */
 	flush_workqueue(ndev->cmd_wq);
 
-	/* Clear flags */
-	ndev->flags = 0;
+	/* Clear flags except NCI_UNREG */
+	ndev->flags &= BIT(NCI_UNREG);
 
 	mutex_unlock(&ndev->req_lock);
 
@@ -1271,6 +1280,12 @@ void nci_unregister_device(struct nci_dev *ndev)
 {
 	struct nci_conn_info    *conn_info, *n;
 
+	/* This set_bit is not protected with specialized barrier,
+	 * However, it is fine because the mutex_lock(&ndev->req_lock);
+	 * in nci_close_device() will help to emit one.
+	 */
+	set_bit(NCI_UNREG, &ndev->flags);
+
 	nci_close_device(ndev);
 
 	destroy_workqueue(ndev->cmd_wq);
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index f326a6ea35fc7..6e771022d43e1 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -669,8 +669,10 @@ static int nfc_genl_dump_devices_done(struct netlink_callback *cb)
 {
 	struct class_dev_iter *iter = (struct class_dev_iter *) cb->args[0];
 
-	nfc_device_iter_exit(iter);
-	kfree(iter);
+	if (iter) {
+		nfc_device_iter_exit(iter);
+		kfree(iter);
+	}
 
 	return 0;
 }
@@ -1403,8 +1405,10 @@ static int nfc_genl_dump_ses_done(struct netlink_callback *cb)
 {
 	struct class_dev_iter *iter = (struct class_dev_iter *) cb->args[0];
 
-	nfc_device_iter_exit(iter);
-	kfree(iter);
+	if (iter) {
+		nfc_device_iter_exit(iter);
+		kfree(iter);
+	}
 
 	return 0;
 }
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index f6aa532bcbf64..a734d47c5eb19 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -878,6 +878,7 @@ static struct sock *pep_sock_accept(struct sock *sk, int flags, int *errp)
 
 	err = pep_accept_conn(newsk, skb);
 	if (err) {
+		__sock_put(sk);
 		sock_put(newsk);
 		newsk = NULL;
 		goto drop;
@@ -956,6 +957,8 @@ static int pep_ioctl(struct sock *sk, int cmd, unsigned long arg)
 			ret =  -EBUSY;
 		else if (sk->sk_state == TCP_ESTABLISHED)
 			ret = -EISCONN;
+		else if (!pn->pn_sk.sobject)
+			ret = -EADDRNOTAVAIL;
 		else
 			ret = pep_sock_enable(sk, NULL, 0);
 		release_sock(sk);
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 2daba5316caa0..192f932bce0dd 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -389,7 +389,7 @@ void rds_tcp_tune(struct socket *sock)
 		sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
 	}
 	if (rtn->rcvbuf_size > 0) {
-		sk->sk_sndbuf = rtn->rcvbuf_size;
+		sk->sk_rcvbuf = rtn->rcvbuf_size;
 		sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
 	}
 	release_sock(sk);
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index ca0516e6f7435..fd48a1e327d6a 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1439,10 +1439,8 @@ static int qfq_init_qdisc(struct Qdisc *sch, struct nlattr *opt)
 	if (err < 0)
 		return err;
 
-	if (qdisc_dev(sch)->tx_queue_len + 1 > QFQ_MAX_AGG_CLASSES)
-		max_classes = QFQ_MAX_AGG_CLASSES;
-	else
-		max_classes = qdisc_dev(sch)->tx_queue_len + 1;
+	max_classes = min_t(u64, (u64)qdisc_dev(sch)->tx_queue_len + 1,
+			    QFQ_MAX_AGG_CLASSES);
 	/* max_cl_shift = floor(log_2(max_classes)) */
 	max_cl_shift = __fls(max_classes);
 	q->max_agg_classes = 1<<max_cl_shift;
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 113c7a0718108..796174fd90322 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -250,7 +250,7 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "s390" && $bits == 64) {
     if ($cc =~ /-DCC_USING_HOTPATCH/) {
-	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
+	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(brcl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
 	$mcount_adjust = 0;
     } else {
 	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_390_(PC|PLT)32DBL\\s+_mcount\\+0x2\$";
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 607c7fc4f24d3..eb9e2b4e81d92 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5194,7 +5194,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	char *addrp;
-	u8 proto;
+	u8 proto = 0;
 
 	if (sk == NULL)
 		return NF_ACCEPT;
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 84ee29c3b1a0b..be5ca6f58e55a 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -281,6 +281,7 @@ static int copy_ctl_value_to_user(void __user *userdata,
 				  struct snd_ctl_elem_value *data,
 				  int type, int count)
 {
+	struct snd_ctl_elem_value32 __user *data32 = userdata;
 	int i, size;
 
 	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
@@ -297,6 +298,8 @@ static int copy_ctl_value_to_user(void __user *userdata,
 		if (copy_to_user(valuep, data->value.bytes.data, size))
 			return -EFAULT;
 	}
+	if (copy_to_user(&data32->id, &data->id, sizeof(data32->id)))
+		return -EFAULT;
 	return 0;
 }
 
diff --git a/sound/core/jack.c b/sound/core/jack.c
index f652e90efd7e7..5ddf81f091fa9 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -234,6 +234,10 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		return -ENOMEM;
 
 	jack->id = kstrdup(id, GFP_KERNEL);
+	if (jack->id == NULL) {
+		kfree(jack);
+		return -ENOMEM;
+	}
 
 	/* don't creat input device for phantom jack */
 	if (!phantom_jack) {
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index c2fb5198d5d56..0ce3f42721c4d 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -173,7 +173,7 @@ snd_pcm_hw_param_value_min(const struct snd_pcm_hw_params *params,
  *
  * Return the maximum value for field PAR.
  */
-static unsigned int
+static int
 snd_pcm_hw_param_value_max(const struct snd_pcm_hw_params *params,
 			   snd_pcm_hw_param_t var, int *dir)
 {
@@ -708,18 +708,24 @@ static int snd_pcm_oss_period_size(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *oss_params,
 				   struct snd_pcm_hw_params *slave_params)
 {
-	size_t s;
-	size_t oss_buffer_size, oss_period_size, oss_periods;
-	size_t min_period_size, max_period_size;
+	ssize_t s;
+	ssize_t oss_buffer_size;
+	ssize_t oss_period_size, oss_periods;
+	ssize_t min_period_size, max_period_size;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	size_t oss_frame_size;
 
 	oss_frame_size = snd_pcm_format_physical_width(params_format(oss_params)) *
 			 params_channels(oss_params) / 8;
 
+	oss_buffer_size = snd_pcm_hw_param_value_max(slave_params,
+						     SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+						     NULL);
+	if (oss_buffer_size <= 0)
+		return -EINVAL;
 	oss_buffer_size = snd_pcm_plug_client_size(substream,
-						   snd_pcm_hw_param_value_max(slave_params, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, NULL)) * oss_frame_size;
-	if (!oss_buffer_size)
+						   oss_buffer_size * oss_frame_size);
+	if (oss_buffer_size <= 0)
 		return -EINVAL;
 	oss_buffer_size = rounddown_pow_of_two(oss_buffer_size);
 	if (atomic_read(&substream->mmap_count)) {
@@ -756,7 +762,7 @@ static int snd_pcm_oss_period_size(struct snd_pcm_substream *substream,
 
 	min_period_size = snd_pcm_plug_client_size(substream,
 						   snd_pcm_hw_param_value_min(slave_params, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, NULL));
-	if (min_period_size) {
+	if (min_period_size > 0) {
 		min_period_size *= oss_frame_size;
 		min_period_size = roundup_pow_of_two(min_period_size);
 		if (oss_period_size < min_period_size)
@@ -765,7 +771,7 @@ static int snd_pcm_oss_period_size(struct snd_pcm_substream *substream,
 
 	max_period_size = snd_pcm_plug_client_size(substream,
 						   snd_pcm_hw_param_value_max(slave_params, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, NULL));
-	if (max_period_size) {
+	if (max_period_size > 0) {
 		max_period_size *= oss_frame_size;
 		max_period_size = rounddown_pow_of_two(max_period_size);
 		if (oss_period_size > max_period_size)
@@ -778,7 +784,7 @@ static int snd_pcm_oss_period_size(struct snd_pcm_substream *substream,
 		oss_periods = substream->oss.setup.periods;
 
 	s = snd_pcm_hw_param_value_max(slave_params, SNDRV_PCM_HW_PARAM_PERIODS, NULL);
-	if (runtime->oss.maxfrags && s > runtime->oss.maxfrags)
+	if (s > 0 && runtime->oss.maxfrags && s > runtime->oss.maxfrags)
 		s = runtime->oss.maxfrags;
 	if (oss_periods > s)
 		oss_periods = s;
@@ -904,8 +910,15 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 		err = -EINVAL;
 		goto failure;
 	}
-	choose_rate(substream, sparams, runtime->oss.rate);
-	snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_CHANNELS, runtime->oss.channels, NULL);
+
+	err = choose_rate(substream, sparams, runtime->oss.rate);
+	if (err < 0)
+		goto failure;
+	err = snd_pcm_hw_param_near(substream, sparams,
+				    SNDRV_PCM_HW_PARAM_CHANNELS,
+				    runtime->oss.channels, NULL);
+	if (err < 0)
+		goto failure;
 
 	format = snd_pcm_oss_format_from(runtime->oss.format);
 
@@ -2013,7 +2026,7 @@ static int snd_pcm_oss_set_fragment1(struct snd_pcm_substream *substream, unsign
 	if (runtime->oss.subdivision || runtime->oss.fragshift)
 		return -EINVAL;
 	fragshift = val & 0xffff;
-	if (fragshift >= 31)
+	if (fragshift >= 25) /* should be large enough */
 		return -EINVAL;
 	runtime->oss.fragshift = fragshift;
 	runtime->oss.maxfrags = (val >> 16) & 0xffff;
diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 7821b07415a78..ff67c4b67e264 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -415,7 +415,7 @@ void snd_opl3_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 	}
 	if (instr_4op) {
 		vp2 = &opl3->voices[voice + 3];
-		if (vp->state > 0) {
+		if (vp2->state > 0) {
 			opl3_reg = reg_side | (OPL3_REG_KEYON_BLOCK +
 					       voice_offset + 3);
 			reg_val = vp->keyon_reg & ~OPL3_KEYON_BIT;
diff --git a/sound/pci/ctxfi/ctamixer.c b/sound/pci/ctxfi/ctamixer.c
index 5fcbb065d8702..d32685ce6c059 100644
--- a/sound/pci/ctxfi/ctamixer.c
+++ b/sound/pci/ctxfi/ctamixer.c
@@ -27,16 +27,15 @@
 
 #define BLANK_SLOT		4094
 
-static int amixer_master(struct rsc *rsc)
+static void amixer_master(struct rsc *rsc)
 {
 	rsc->conj = 0;
-	return rsc->idx = container_of(rsc, struct amixer, rsc)->idx[0];
+	rsc->idx = container_of(rsc, struct amixer, rsc)->idx[0];
 }
 
-static int amixer_next_conj(struct rsc *rsc)
+static void amixer_next_conj(struct rsc *rsc)
 {
 	rsc->conj++;
-	return container_of(rsc, struct amixer, rsc)->idx[rsc->conj];
 }
 
 static int amixer_index(const struct rsc *rsc)
@@ -335,16 +334,15 @@ int amixer_mgr_destroy(struct amixer_mgr *amixer_mgr)
 
 /* SUM resource management */
 
-static int sum_master(struct rsc *rsc)
+static void sum_master(struct rsc *rsc)
 {
 	rsc->conj = 0;
-	return rsc->idx = container_of(rsc, struct sum, rsc)->idx[0];
+	rsc->idx = container_of(rsc, struct sum, rsc)->idx[0];
 }
 
-static int sum_next_conj(struct rsc *rsc)
+static void sum_next_conj(struct rsc *rsc)
 {
 	rsc->conj++;
-	return container_of(rsc, struct sum, rsc)->idx[rsc->conj];
 }
 
 static int sum_index(const struct rsc *rsc)
diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index 7f089cb433e17..df326b7663a2d 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -55,12 +55,12 @@ static struct daio_rsc_idx idx_20k2[NUM_DAIOTYP] = {
 	[SPDIFIO] = {.left = 0x05, .right = 0x85},
 };
 
-static int daio_master(struct rsc *rsc)
+static void daio_master(struct rsc *rsc)
 {
 	/* Actually, this is not the resource index of DAIO.
 	 * For DAO, it is the input mapper index. And, for DAI,
 	 * it is the output time-slot index. */
-	return rsc->conj = rsc->idx;
+	rsc->conj = rsc->idx;
 }
 
 static int daio_index(const struct rsc *rsc)
@@ -68,19 +68,19 @@ static int daio_index(const struct rsc *rsc)
 	return rsc->conj;
 }
 
-static int daio_out_next_conj(struct rsc *rsc)
+static void daio_out_next_conj(struct rsc *rsc)
 {
-	return rsc->conj += 2;
+	rsc->conj += 2;
 }
 
-static int daio_in_next_conj_20k1(struct rsc *rsc)
+static void daio_in_next_conj_20k1(struct rsc *rsc)
 {
-	return rsc->conj += 0x200;
+	rsc->conj += 0x200;
 }
 
-static int daio_in_next_conj_20k2(struct rsc *rsc)
+static void daio_in_next_conj_20k2(struct rsc *rsc)
 {
-	return rsc->conj += 0x100;
+	rsc->conj += 0x100;
 }
 
 static const struct rsc_ops daio_out_rsc_ops = {
diff --git a/sound/pci/ctxfi/ctresource.c b/sound/pci/ctxfi/ctresource.c
index c5124c3c0fd19..f610c32ae5ad2 100644
--- a/sound/pci/ctxfi/ctresource.c
+++ b/sound/pci/ctxfi/ctresource.c
@@ -113,18 +113,17 @@ static int audio_ring_slot(const struct rsc *rsc)
     return (rsc->conj << 4) + offset_in_audio_slot_block[rsc->type];
 }
 
-static int rsc_next_conj(struct rsc *rsc)
+static void rsc_next_conj(struct rsc *rsc)
 {
 	unsigned int i;
 	for (i = 0; (i < 8) && (!(rsc->msr & (0x1 << i))); )
 		i++;
 	rsc->conj += (AUDIO_SLOT_BLOCK_NUM >> i);
-	return rsc->conj;
 }
 
-static int rsc_master(struct rsc *rsc)
+static void rsc_master(struct rsc *rsc)
 {
-	return rsc->conj = rsc->idx;
+	rsc->conj = rsc->idx;
 }
 
 static const struct rsc_ops rsc_generic_ops = {
diff --git a/sound/pci/ctxfi/ctresource.h b/sound/pci/ctxfi/ctresource.h
index 736d9f7e9e165..29b6fe6de659c 100644
--- a/sound/pci/ctxfi/ctresource.h
+++ b/sound/pci/ctxfi/ctresource.h
@@ -43,8 +43,8 @@ struct rsc {
 };
 
 struct rsc_ops {
-	int (*master)(struct rsc *rsc);	/* Move to master resource */
-	int (*next_conj)(struct rsc *rsc); /* Move to next conjugate resource */
+	void (*master)(struct rsc *rsc); /* Move to master resource */
+	void (*next_conj)(struct rsc *rsc); /* Move to next conjugate resource */
 	int (*index)(const struct rsc *rsc); /* Return the index of resource */
 	/* Return the output slot number */
 	int (*output_slot)(const struct rsc *rsc);
diff --git a/sound/pci/ctxfi/ctsrc.c b/sound/pci/ctxfi/ctsrc.c
index a5a72df298013..234a7e96fd08a 100644
--- a/sound/pci/ctxfi/ctsrc.c
+++ b/sound/pci/ctxfi/ctsrc.c
@@ -594,16 +594,15 @@ int src_mgr_destroy(struct src_mgr *src_mgr)
 
 /* SRCIMP resource manager operations */
 
-static int srcimp_master(struct rsc *rsc)
+static void srcimp_master(struct rsc *rsc)
 {
 	rsc->conj = 0;
-	return rsc->idx = container_of(rsc, struct srcimp, rsc)->idx[0];
+	rsc->idx = container_of(rsc, struct srcimp, rsc)->idx[0];
 }
 
-static int srcimp_next_conj(struct rsc *rsc)
+static void srcimp_next_conj(struct rsc *rsc)
 {
 	rsc->conj++;
-	return container_of(rsc, struct srcimp, rsc)->idx[rsc->conj];
 }
 
 static int srcimp_index(const struct rsc *rsc)
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index e9c57bd3c02bf..6274a50026473 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2050,6 +2050,7 @@ EXPORT_SYMBOL_GPL(snd_soc_tplg_widget_remove_all);
 /* remove dynamic controls from the component driver */
 int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 {
+	struct snd_card *card = comp->card->snd_card;
 	struct snd_soc_dobj *dobj, *next_dobj;
 	int pass = SOC_TPLG_PASS_END;
 
@@ -2057,6 +2058,7 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 	while (pass >= SOC_TPLG_PASS_START) {
 
 		/* remove mixer controls */
+		down_write(&card->controls_rwsem);
 		list_for_each_entry_safe(dobj, next_dobj, &comp->dobj_list,
 			list) {
 
@@ -2090,6 +2092,7 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 				break;
 			}
 		}
+		up_write(&card->controls_rwsem);
 		pass--;
 	}
