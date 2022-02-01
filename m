Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57734A6124
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbiBAQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:14:54 -0500
Received: from mail.nearlyone.de ([46.163.114.145]:38254 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiBAQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:14:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 555365D21F;
        Tue,  1 Feb 2022 17:14:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1643732087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding; bh=ZaY+B690gHIE/b2OMxz8FeJ18Z7IoX5XKEqGbr+wHAk=;
        b=ra1iG1k3m9z6Yve5OJ+GDTS3xnlo0RfoFjAReAx8i32oPUoPOpYypsi5edBtgoSmYKSvNX
        W5+s7f7dbSqnJLsxHK9t5T4otEBwkSJC+LQZGOvd40zdIccT3UhyREKqNnVgt+NPzApnDK
        i+GrK4w7rYg15xNxgfDYG5c4R1rzOtKngQ06l+LbMzKymHEzM+/lzPMBZNaJP3kboQEAyO
        Zu0Om3x/5DmJ701y527wvArLbjR53glUpP8LSUvHox6qbvWcWysRZ3Aj8G+ZrHmJghMWAN
        TVy+EAVeTS2egk2/1n6TgX7RJrustZkHro1RLxwAmuiM5aXTtvTLktaNBHkv/g==
Date:   Tue, 1 Feb 2022 17:14:43 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.4.301-rt231
Message-ID: <164373149744.25521.668105457088547829@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.301-rt231 stable release.

This is just an update to the latest and last 4.4.x stable
release. There are no RT specific changes.

With this release there wont be any updates for this branch in
stable-rt tree. I understand Pavel Machek is continuing to maintaining
the v4.4-rt branch under the CIP umbrella:

  https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 5031d00d4f5a1e3b1e9aab6deb4055986826440c

Or to build 4.4.301-rt231 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.301.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.301-rt231.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

Enjoy!
Daniel

Changes from v4.4.296-rt229:
---

Alan Stern (2):
      USB: core: Fix bug in resuming hub's handling of wakeup requests
      USB: Fix "slab-out-of-bounds Write" bug in usb_hcd_poll_rh_status

Alexander Aring (1):
      fs: dlm: filter user dlm messages for kernel locks

Alexey Makhalov (1):
      scsi: vmw_pvscsi: Set residual data length conditionally

Andy Shevchenko (1):
      mfd: intel-lpss: Fix too early PM enablement in the ACPI ->probe()

Ard Biesheuvel (1):
      ARM: 9169/1: entry: fix Thumb2 bug in iWMMXt exception handling

Arnd Bergmann (1):
      dmaengine: pxa/mmp: stop referencing config->slave_id

Avihai Horon (1):
      RDMA/core: Let ib_find_gid() continue search even after empty entry

Benjamin Tissoires (1):
      HID: holtek: fix mouse probing

Bixuan Cui (1):
      ALSA: oss: fix compile error when OSS_DEBUG is enabled

Brian Silverman (1):
      can: gs_usb: gs_can_start_xmit(): zero-initialize hf->{flags,reserved}

Chengfeng Ye (2):
      crypto: qce - fix uaf on qce_ahash_register_one
      HSI: core: Fix return freed object in hsi_new_client

Christoph Hellwig (1):
      scsi: sr: Don't use GFP_DMA

Christophe Leroy (1):
      w1: Misuse of get_user()/put_user() reported by sparse

Colin Ian King (1):
      ALSA: drivers: opl3: Fix incorrect use of vp->state

Daniel Borkmann (1):
      bpf, test: fix ld_abs + vlan push/pop stress test

Daniel Wagner (4):
      Merge tag 'v4.4.299' into v4.4-rt
      Linux 4.4.299-rt230
      Merge tag 'v4.4.301' into v4.4-rt
      Linux 4.4.301-rt231

Darrick J. Wong (1):
      xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP just like fallocate

Dmitry Baryshkov (1):
      arm64: dts: qcom: msm8916: fix MMC controller aliases

Dmitry V. Levin (1):
      uapi: fix linux/nfc.h userspace compilation errors

Dominik Brodowski (1):
      pcmcia: fix setting of kthread task states

Eric Dumazet (4):
      sch_qfq: prevent shift-out-of-bounds in qfq_init_qdisc
      ppp: ensure minimum packet size in ppp_write()
      af_unix: annote lockless accesses to unix_tot_inflight & gc_in_progress
      netns: add schedule point in ops_exit_list()

Fernando Fernandez Mancera (1):
      bonding: fix ad_actor_system option setting to default

Florian Fainelli (1):
      net: mdio: Demote probed message to debug print

Florian Westphal (1):
      netfilter: bridge: add support for pppoe filtering

Greg Jesionowski (1):
      net: usb: lan78xx: add Allied Telesis AT29M2-AF

Greg Kroah-Hartman (5):
      Linux 4.4.297
      Linux 4.4.298
      Linux 4.4.299
      Linux 4.4.300
      Linux 4.4.301

Guenter Roeck (1):
      hwmon: (lm90) Fix usage of CONFIG2 register in detect function

Hangyu Hua (1):
      phonet: refcount leak in pep_sock_accep

Heiko Carstens (1):
      recordmcount.pl: fix typo in s390 mcount regex

Heiner Kallweit (1):
      i2c: i801: Don't silently correct invalid transfer size

Jan Kara (1):
      ext4: avoid trim error on fs with small groups

Jann Horn (1):
      HID: uhid: Fix worker destroying device without any protection

Jedrzej Jagielski (1):
      i40e: Fix incorrect netdev's real number of RX/TX queues

Jiasheng Jiang (4):
      qlcnic: potential dereference null pointer of rx_queue->page_ring
      drivers: net: smc911x: Check for error irq
      can: xilinx_can: xcan_probe(): check for error irq
      ASoC: samsung: idma: Check of ioremap return value

Jimmy Assarsson (1):
      can: kvaser_usb: get CAN clock frequency from device

Joakim Tjernlund (1):
      i2c: mpc: Correct I2C reset procedure

Joe Thornber (2):
      dm btree: add a defensive bounds check to insert_at()
      dm space map common: add bounds check to sm_ll_lookup_bitmap()

Johan Hovold (7):
      Bluetooth: bfusb: fix division by zero in send path
      media: uvcvideo: fix division by zero at stream start
      media: mceusb: fix control-message timeouts
      media: em28xx: fix control-message timeouts
      media: pvrusb2: fix control-message timeouts
      media: stk1160: fix control-message timeouts
      can: softing_cs: softingcs_probe(): fix memleak on registration failure

Johannes Berg (1):
      iwlwifi: mvm: synchronize with FW after multicast commands

John David Anglin (1):
      parisc: Avoid calling faulthandler_disabled() twice

Josef Bacik (2):
      btrfs: remove BUG_ON() in find_parent_nodes()
      btrfs: remove BUG_ON(!eie) in find_parent_nodes

José Expósito (1):
      IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()

Juergen Gross (1):
      xen/blkfront: fix bug in backported patch

Julia Lawall (4):
      powerpc/6xx: add missing of_node_put
      powerpc/powernv: add missing of_node_put
      powerpc/cell: add missing of_node_put
      powerpc/btext: add missing of_node_put

Kai-Heng Feng (1):
      usb: hub: Add delay for SuperSpeed hub resume to let links transit to U0

Kamal Heib (1):
      RDMA/cxgb4: Set queue pair state when being queried

Kees Cook (1):
      char/mwave: Adjust io port register size

Kevin Bracey (1):
      net_sched: restore "mpu xxx" handling

Krzysztof Kozlowski (2):
      nfc: uapi: use kernel size_t to fix user-space builds
      nfc: llcp: fix NULL error pointer dereference on sendmsg() after failed bind()

Lakshmi Sowjanya D (1):
      i2c: designware-pci: Fix to change data types of hcnt and lcnt parameters

Larry Finger (1):
      rtlwifi: rtl8192cu: Fix WARNING when calling local_irq_restore() with interrupts enabled

Leo L. Schwab (1):
      Input: spaceball - fix parsing of movement data packets

Lin Ma (3):
      ax25: NPD bug when detaching AX25 device
      hamradio: defer ax25 kfree after unregister_netdev
      hamradio: improve the incomplete fix to avoid NPD

Lino Sanfilippo (1):
      serial: amba-pl011: do not request memory region twice

Lixiaokeng (1):
      scsi: libiscsi: Fix UAF in iscsi_conn_get_param()/iscsi_conn_teardown()

Lukas Wunner (2):
      serial: pl010: Drop CR register reset on set_termios
      serial: core: Keep mctrl register state and cached copy in sync

Luís Henriques (1):
      ext4: set csum seed in tmp inode while migrating to extents

Marc Kleine-Budde (2):
      can: gs_usb: fix use of uninitialized variable, detach device on reception of invalid USB data
      can: softing: softing_startstop(): fix set but not used variable warning

Mateusz Jończyk (1):
      rtc: cmos: take rtc_lock while reading from CMOS

Mathias Nyman (1):
      xhci: Fresco FL1100 controller should not have BROKEN_MSI quirk set.

Mauro Carvalho Chehab (1):
      media: m920x: don't use stack on USB reads

Miaoqian Lin (3):
      spi: spi-meson-spifc: Add missing pm_runtime_disable() in meson_spifc_probe
      parisc: pdc_stable: Fix memory leak in pdcs_register_pathentries
      lib82596: Fix IRQ check in sni_82596_probe

Michael Ellerman (1):
      powerpc/smp: Move setup_profiling_timer() under CONFIG_PROFILING

Michael Kuron (1):
      media: dib0700: fix undefined behavior in tuner shutdown

Muchun Song (1):
      net: fix use-after-free in tw_timer_handler

Nathan Chancellor (2):
      power: reset: ltc2952: Fix use of floating point literals
      drm/i915: Avoid bitwise vs logical OR warning in snb_wm_latency_quirk()

Pavankumar Kondeti (1):
      usb: gadget: f_fs: Use stream_open() for endpoint files

Pavel Skripkin (4):
      Input: appletouch - initialize work before device registration
      ieee802154: atusb: fix uninit value in atusb_set_extended_addr
      Bluetooth: stop proccessing malicious adv data
      net: mcs7830: handle usb read errors properly

Peiwei Hu (1):
      powerpc/prom_init: Fix improper check of prom_getprop()

Petr Cvachoucek (1):
      ubifs: Error path in ubifs_remount_rw() seems to wrongly free write buffers

Rafael J. Wysocki (2):
      ACPICA: Utilities: Avoid deleting the same object twice in a row
      ACPICA: Executer: Fix the REFCLASS_REFOF case in acpi_ex_opcode_1A_0T_1R()

Randy Dunlap (3):
      mips: lantiq: add support for clk_set_parent()
      mips: bcm63xx: add support for clk_set_parent()
      um: registers: Rename function names to avoid conflicts and build problems

Robert Hancock (2):
      net: axienet: Wait for PhyRstCmplt after core reset
      net: axienet: fix number of TX ring slots for available check

Rémi Denis-Courmont (1):
      phonet/pep: refuse to enable an unbound pipe

Sean Young (1):
      media: igorplugusb: receiver overflow should be reported

Sergey Shtylyov (1):
      bcmgenet: add WOL IRQ check

Suresh Kumar (1):
      net: bonding: debug: avoid printing debug logs when bond is not notifying peers

Takashi Iwai (5):
      Bluetooth: btusb: Apply QCA Rome patches for some ATH3012 models
      ALSA: jack: Add missing rwsem around snd_ctl_remove() calls
      ALSA: PCM: Add missing rwsem around snd_ctl_remove() calls
      ALSA: hda: Add missing rwsem around snd_ctl_remove() calls
      ALSA: seq: Set upper limit of processed events

Tasos Sahanidis (1):
      floppy: Fix hang in watchdog when disk is ejected

Theodore Ts'o (1):
      ext4: don't use the orphan list when migrating an inode

Thomas Toye (1):
      rndis_host: support Hytera digital radios

Tianjia Zhang (1):
      MIPS: Octeon: Fix build errors using clang

Tobias Waldekranz (2):
      powerpc/fsl/dts: Enable WA for erratum A-009885 on fman3l MDIO buses
      net/fsl: xgmac_mdio: Fix incorrect iounmap when removing module

Tom Rix (2):
      selinux: initialize proto variable in selinux_ip_postroute_compat()
      mac80211: initialize variable have_higher_than_11mbit

Tudor Ambarus (6):
      tty: serial: atmel: Check return code of dmaengine_submit()
      tty: serial: atmel: Call dma_async_issue_pending()
      dmaengine: at_xdmac: Don't start transactions at tx_submit level
      dmaengine: at_xdmac: Print debug message after realeasing the lock
      dmaengine: at_xdmac: Fix lld view setting
      dmaengine: at_xdmac: Fix at_xdmac_lld struct definition

Tvrtko Ursulin (1):
      drm/i915: Flush TLBs before releasing backing store

Vincent Pelletier (1):
      usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear.

Wang Hai (2):
      Bluetooth: cmtp: fix possible panic when cmtp_init_sockets() fails
      media: msi001: fix possible null-ptr-deref in msi001_probe()

Wang Qing (1):
      platform/x86: apple-gmux: use resource_size() with res

Wei Yongjun (3):
      usb: ftdi-elan: fix memory leak on device disconnect
      misc: lattice-ecp3-config: Fix task hung when firmware load failed
      Bluetooth: Fix debugfs entry leak in hci_register_dev()

William Zhao (1):
      ip6_vti: initialize __ip6_tnl_parm struct in vti6_siocdevprivate

Xiaoke Wang (1):
      ALSA: jack: Check the return value of kstrdup()

Xiongwei Song (1):
      floppy: Add max size check for user space request

Yauhen Kharuzhy (1):
      power: bq25890: Enable continuous conversion for ADC at charging

Ye Bin (1):
      ext4: Fix BUG_ON in ext4_bread when write quota data

Yifeng Li (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9125 SATA controller

Zekun Shen (3):
      ar5523: Fix null-ptr-deref with unexpected WDCMSG_TARGET_START reply
      mwifiex: Fix skb_over_panic in mwifiex_usb_recv()
      ath9k: Fix out-of-bound memcpy in ath9k_hif_usb_rx_stream

Zheyu Ma (1):
      media: b2c2: Add missing check in flexcop_pci_isr:

Zhou Qingyang (7):
      drm/amdgpu: Fix a NULL pointer dereference in amdgpu_connector_lcd_native_mode()
      media: dib8000: Fix a memleak in dib8000_init()
      media: saa7146: mxb: Fix a NULL pointer dereference in mxb_attach()
      pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in __nonstatic_find_io_region()
      pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in nonstatic_find_mem_region()
      media: saa7146: hexium_orion: Fix a NULL pointer dereference in hexium_attach()
      media: saa7146: hexium_gemini: Fix a NULL pointer dereference in hexium_attach()

wolfgang huang (1):
      mISDN: change function names to avoid conflicts

yangxingwu (1):
      net: udp: fix alignment problem in udp4_seq_show()
