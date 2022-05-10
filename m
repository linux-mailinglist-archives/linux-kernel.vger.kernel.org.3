Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE56852277A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiEJXTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiEJXTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:19:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2272631CD;
        Tue, 10 May 2022 16:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42CE8B82014;
        Tue, 10 May 2022 23:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8C3C385CC;
        Tue, 10 May 2022 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652224747;
        bh=78GdTRFYr887ntfoYkeN+Ix2HHKrb1VC9hoLAhdyAlI=;
        h=Date:From:To:Subject:From;
        b=rcl8K7M77vaQiyuctnW+PCJ33qAvPHnNpF8hNO6UnWfa7FixpPvTR97BLAUDqWONu
         D9bRK0VVaogxML+1swBjbv7yyG+q0wYHqyWDkz2Z0GVD7htgAQB4CLmIOk16VtYAml
         NpiPnyzP4O4RCfwlUz0P/Cd2Ke8ym7YxjIYUOlO7Ulk2FFW7O2Lr2v2ABMP3UMUvVN
         dwPhkaPksMLD1bBaFcYwggVtNIQr+l3TSaSU06p+hQjIwdjdY63oFmlE9xkOPAEQ0Q
         gO/okC0v1oeVZHQCkJwWf+5Ll8vq7syrKL7S8ZRs9xCC2Tz5kFx1N7jhoa5tLdl3IY
         K/2z8N1pVG7cw==
Date:   Tue, 10 May 2022 16:19:04 -0700
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
Subject: [ANNOUNCE] 4.9.312-rt193
Message-ID: <165222469651.210737.17409564443317121708@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.312-rt193 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 9fa8a14439281cb467a9bf7bdb8795e52bf2293c

Or to build 4.9.312-rt193 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.312.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.312-rt193.patch.xz


You can also build from 4.9.303-rt192 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.303-rt192-rt193.patch.xz

Signing key fingerprint:

  A073 BC64 746A 086C DA24  97C8 F92D 73C9 A31A 1C17

Enjoy!
Mark Gross

Changes from v4.9.303-rt192:
---

Adrian Hunter (2):
      perf/core: Fix address filter parser for multiple filters
      perf/x86/intel/pt: Fix address filter config for 32-bit kernel

Alan Stern (2):
      usb: gadget: Fix use-after-free bug by not setting udc->dev.driver
      USB: usb-storage: Fix use of bitfields for hardware data in ene_ub6250.c

Alexander Lobakin (2):
      MIPS: smp: fill in sibling and core maps earlier
      MIPS: fix fortify panic when copying asm exception handlers

Alexey Galakhov (1):
      scsi: mvsas: Add PCI ID of RocketRaid 2640

Alexey Khoroshilov (2):
      serial: 8250: fix error handling in of_platform_serial_probe()
      NFS: remove unneeded check in decode_devicenotify_args()

Alistair Popple (1):
      mm/pages_alloc.c: don't create ZONE_MOVABLE beyond the end of a node

Amadeusz Sławiński (1):
      ASoC: topology: Allow TLV control to be either read or write

Andrew Price (1):
      gfs2: Make sure FITRIM minlen is rounded up to fs block size

Anshuman Khandual (1):
      arm64: Add Cortex-X2 CPU part definition

Armin Wolf (1):
      hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING

Arnaldo Carvalho de Melo (1):
      tools build: Use $(shell ) instead of `` to get embedded libperl's ccopts

Arnd Bergmann (1):
      arm64: arch_timer: avoid unused function warning

Baokun Li (3):
      jffs2: fix use-after-free in jffs2_clear_xattr_subsystem
      jffs2: fix memory leak in jffs2_do_mount_fs
      jffs2: fix memory leak in jffs2_scan_medium

Bart Van Assche (1):
      RDMA/ib_srp: Fix a deadlock

Benjamin Beichler (1):
      mac80211_hwsim: report NOACK frames in tx_status

Bharata B Rao (1):
      sched/debug: Remove mpol_get/put and task_lock/unlock from sched_show_numa

Bob Peterson (1):
      gfs2: assign rgrp glock before compute_bitstructs

Borislav Petkov (3):
      x86/speculation: Merge one test in spectre_v2_user_select_mitigation()
      ALSA: usb-audio: Fix undefined behavior due to shift overflowing the constant
      brcmfmac: sdio: Fix undefined behavior due to shift overflowing the constant

Brandon Wyman (1):
      hwmon: (pmbus) Add Vin unit off handling

Casey Schaufler (1):
      Fix incorrect type in assignment of ipv6 port for audit

Chaitanya Kulkarni (1):
      loop: use sysfs_emit() in the sysfs xxx show()

Chen-Yu Tsai (2):
      pinctrl: pinconf-generic: Print arguments for bias-pull-*
      net: stmmac: Fix unset max_speed difference between DT and non-DT platforms

ChenXiaoSong (1):
      configfs: fix a race in configfs_{,un}register_subsystem()

Chengming Zhou (1):
      kselftest/vm: fix tests build with old libc

Christian Göttsche (1):
      selinux: use correct type for context length

Christophe JAILLET (2):
      iio: adc: men_z188_adc: Fix a resource leak in an error handling path
      scsi: zorro7xx: Fix a resource leak in zorro7xx_remove_one()

Codrin Ciubotariu (1):
      ASoC: dmaengine: do not use a NULL prepare_slave_config() callback

Colin Ian King (2):
      carl9170: fix missing bit-wise or operator for tx_params
      iwlwifi: Fix -EIO error code that is never returned

Corentin Labbe (1):
      ARM: dts: rockchip: fix a typo on rk3288 crypto-controller

Daehwan Jung (1):
      usb: gadget: rndis: add spinlock for rndis response list

Damien Le Moal (6):
      scsi: libsas: Fix sas_ata_qc_issue() handling of NCQ NON DATA commands
      scsi: pm8001: Fix command initialization in pm80XX_send_read_log()
      scsi: pm8001: Fix command initialization in pm8001_chip_ssp_tm_req()
      scsi: pm8001: Fix payload initialization in pm80xx_set_thermal_config()
      scsi: pm8001: Fix abort all task initialization
      scsi: pm8001: Fix pm8001_mpi_task_abort_resp()

Dan Carpenter (6):
      staging: gdm724x: fix use after free in gdm_lte_rx()
      usb: gadget: rndis: prevent integer overflow in rndis_set_response()
      NFSD: prevent underflow in nfssvc_decode_writeargs()
      video: fbdev: fbcvt.c: fix printing in fb_cvt_print_name()
      media: usb: go7007: s2250-board: fix leak in probe()
      USB: storage: ums-realtek: fix error code in rts51x_read_mem()

Daniel González Cabanelas (1):
      media: cx88-mpeg: clear interrupt status register before streaming video

Daniele Palmas (2):
      USB: serial: option: add Telit LE910R1 compositions
      net: usb: cdc_mbim: avoid altsetting toggling for Telit FN990

Darren Hart (1):
      ACPI/APEI: Limit printable size of BERT table data

Dave Martin (1):
      arm64: capabilities: Update prototype for enable call back

David Heidelberg (1):
      ARM: dts: qcom: fix gic_irq_domain_translate warnings for msm8960

David Howells (1):
      cifs: Check the IOCB_DIRECT flag, not O_DIRECT

David Matlack (1):
      KVM: Prevent module exit until all VMs are freed

Ding Tianhong (2):
      clocksource/drivers/arm_arch_timer: Remove fsl-a008585 parameter
      clocksource/drivers/arm_arch_timer: Introduce generic errata handling infrastructure

Dinh Nguyen (1):
      net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-link

Dirk Müller (1):
      lib/raid6/test: fix multiple definition linking error

Dmitry Baryshkov (1):
      PM: core: keep irq flags in device_pm_check_callbacks()

Dmitry Torokhov (1):
      HID: i2c-hid: fix GET/SET_REPORT for unnumbered reports

Dmytro Bagrii (1):
      Revert "USB: serial: ch341: add new Product ID for CH341A"

Dongliang Mu (2):
      ntfs: add sanity check on allocation size
      media: hdpvr: initialize dev->worker at hdpvr_register_videodev

Duoming Zhou (4):
      ax25: Fix NULL pointer dereference in ax25_kill_by_device
      drivers: hamradio: 6pack: fix UAF bug caused by mod_timer()
      net/x25: Fix null-ptr-deref caused by x25_disconnect
      drivers: net: slip: fix NPD bug in sl_tx_timeout()

Dāvis Mosāns (1):
      crypto: ccp - ccp_dmaengine_unregister release dma channels

Eddie James (1):
      USB: serial: pl2303: add IBM device IDs

Emmanuel Gil Peyrot (1):
      ARM: fix build error when BPF_SYSCALL is disabled

Eric Anholt (1):
      i2c: bcm2835: Avoid clock stretching timeouts

Eric Dumazet (7):
      net: __pskb_pull_tail() & pskb_carve_frag_list() drop_monitor friends
      sctp: fix kernel-infoleak for SCTP sockets
      tcp: make tcp_read_sock() more robust
      net/packet: fix slab-out-of-bounds access in packet_recvmsg()
      llc: fix netdevice reference leaks in llc_ui_bind()
      llc: only change llc->dev when bind() succeeds
      netlink: reset network and mac headers in netlink_dump()

Evgeny Novikov (1):
      video: fbdev: w100fb: Reset global state

Fabio M. De Francesco (1):
      ALSA: pcm: Test for "silence" field in struct "pcm_format_data"

Fangrui Song (1):
      arm64: module: remove (NOLOAD) from linker script

Florian Fainelli (1):
      net: phy: broadcom: Fix brcm_fet_config_init()

Florian Westphal (2):
      netfilter: nf_queue: don't assume sk is full socket
      netfilter: nf_queue: fix possible use-after-free

Frank Wunderlich (1):
      arm64: dts: broadcom: Fix sata nodename

Gal Pressman (1):
      net/mlx5e: Fix wrong return value on ioctl EEPROM query failure

George Kennedy (1):
      video: fbdev: cirrusfb: check pixclock to avoid divide by zero

Giacomo Guiduzzi (1):
      ALSA: pci: fix reading of swapped values from pcmreg in AC97 codec

Giovanni Cabiddu (1):
      crypto: qat - disable registration of algorithms

Greg Kroah-Hartman (9):
      Linux 4.9.304
      Linux 4.9.305
      Linux 4.9.306
      Linux 4.9.307
      Linux 4.9.308
      Linux 4.9.309
      Linux 4.9.310
      Linux 4.9.311
      Linux 4.9.312

Guillaume Nault (1):
      veth: Ensure eth header is in skb's linear part

Guo Ren (1):
      arm64: patch_text: Fixup last cpu should be master

H. Nikolaus Schaller (1):
      usb: dwc3: omap: fix "unbalanced disables for smps10_out1" on omap5evm

Haimin Zhang (2):
      af_key: add __GFP_ZERO flag for compose_sadb_supported in function pfkey_register
      jfs: prevent NULL deref in diFree

Hangbin Liu (1):
      net/packet: fix packet_sock xmit return value checking

Hangyu Hua (3):
      usb: gadget: don't release an existing dev->buf
      usb: gadget: clear related members when goto fail
      can: ems_usb: ems_usb_start_xmit(): fix double dev_kfree_skb() in error path

Hans de Goede (2):
      Input: elan_i2c - move regulator_[en|dis]able() out of elan_[en|dis]able_power()
      Input: elan_i2c - fix regulator enable count imbalance after suspend/resume

Harshit Mogalapalli (1):
      cifs: potential buffer overflow in handling symlinks

Hector Martin (2):
      brcmfmac: firmware: Allocate space for default boardrev in nvram
      brcmfmac: pcie: Replace brcmf_pcie_copy_mem_todev with memcpy_toio

Helge Deller (3):
      parisc/unaligned: Fix fldd and fstd unaligned handlers on 32-bit kernel
      parisc/unaligned: Fix ldw() and stw() unalignment handlers
      video: fbdev: sm712fb: Fix crash in smtcfb_read()

Herbert Xu (1):
      crypto: authenc - Fix sleep in atomic context in decrypt_tail

Hongbin Wang (1):
      vxlan: fix error return code in vxlan_fdb_append

Hongyu Xie (1):
      xhci: Prevent futile URB re-submissions due to incorrect return value.

Hou Wenlong (1):
      KVM: x86/emulator: Defer not-present segment check in __load_segment_descriptor()

Huang Pei (1):
      hamradio: fix macro redefine warning

Hugh Dickins (2):
      memfd: fix F_SEAL_WRITE after shmem huge page allocated
      mempolicy: mbind_range() set_policy() after vma_merge()

JaeMan Park (1):
      mac80211_hwsim: initialize ieee80211_tx_info at hw_scan_work

Jakob Koschel (1):
      powerpc/sysdev: fix incorrect use to determine if list is empty

James Clark (1):
      coresight: Fix TRCCONFIGR.QE sysfs interface

James Morse (20):
      arm64: Remove useless UAO IPI and describe how this gets enabled
      arm64: entry.S: Add ventry overflow sanity checks
      arm64: entry: Make the trampoline cleanup optional
      arm64: entry: Free up another register on kpti's tramp_exit path
      arm64: entry: Move the trampoline data page before the text page
      arm64: entry: Allow tramp_alias to access symbols after the 4K boundary
      arm64: entry: Don't assume tramp_vectors is the start of the vectors
      arm64: entry: Move trampoline macros out of ifdef'd section
      arm64: entry: Make the kpti trampoline's kpti sequence optional
      arm64: entry: Allow the trampoline text to occupy multiple pages
      arm64: entry: Add non-kpti __bp_harden_el1_vectors for mitigations
      arm64: Move arm64_update_smccc_conduit() out of SSBD ifdef
      arm64: entry: Add vectors that have the bhb mitigation sequences
      arm64: entry: Add macro for reading symbol addresses from the trampoline
      arm64: Add percpu vectors for EL1
      KVM: arm64: Add templates for BHB mitigation sequences
      arm64: Mitigate spectre style branch history side channels
      KVM: arm64: Allow SMCCC_ARCH_WORKAROUND_3 to be discovered and migrated
      arm64: add ID_AA64ISAR2_EL1 sys register
      arm64: Use the clearbhb instruction in mitigations

Jann Horn (2):
      efivars: Respect "block" flag in efivar_entry_set_safe()
      ptrace: Check PTRACE_O_SUSPEND_SECCOMP permission on PTRACE_SEIZE

Jason A. Donenfeld (1):
      gcc-plugins: latent_entropy: use /dev/urandom

Jia-Ju Bai (4):
      net: chelsio: cxgb3: check the return value of pci_find_capability()
      net: qlogic: check the return value of dma_alloc_coherent() in qed_vf_hw_prepare()
      atm: firestream: check the return value of ioremap() in fs_init()
      memory: emif: check the pointer temp in get_device_details()

Jianglei Nie (1):
      scsi: libfc: Fix use after free in fc_exch_abts_resp()

Jiapeng Chong (1):
      platform/x86: samsung-laptop: Fix an unsigned comparison which can never be negative

Jiasheng Jiang (17):
      soc: fsl: qe: Check of ioremap return value
      net: ethernet: lpc_eth: Handle error for clk_enable
      atm: eni: Add check for dma_map_single
      ASoC: ti: davinci-i2s: Add check for clk_enable()
      ALSA: spi: Add check for clk_enable()
      ASoC: mxs-saif: Handle errors for clk_enable
      ASoC: atmel_ssc_dai: Handle errors for clk_enable
      memory: emif: Add check for setup_interrupts
      ASoC: wm8350: Handle error for wm8350_register_irq
      ASoC: fsi: Add check for clk_enable
      mtd: onenand: Check for error irq
      ray_cs: Check ioremap return value
      power: supply: wm8350-power: Handle error for wm8350_register_irq
      power: supply: wm8350-power: Add missing free in free_charger_irq
      mfd: mc13xxx: Add check for mc13xxx_irq_request
      iio: adc: Add check for devm_request_threaded_irq
      rtc: wm8350: Handle error for wm8350_register_irq

Jim Mattson (1):
      KVM: x86/svm: Clear reserved bits written to PerfEvtSeln MSRs

Jing Yao (2):
      video: fbdev: omapfb: panel-dsi-cm: Use sysfs_emit() instead of snprintf()
      video: fbdev: omapfb: panel-tpo-td043mtea1: Use sysfs_emit() instead of snprintf()

Jiri Bohac (1):
      xfrm: fix MTU regression

Jiri Slaby (2):
      mxser: fix xmit_buf leak in activate when LSR == 0xff
      serial: samsung_tty: do not unlock port->lock for uart_write_wakeup()

Johan Hovold (3):
      firmware: qemu_fw_cfg: fix kobject leak in probe error path
      USB: serial: simple: add Nokia phone driver
      media: davinci: vpif: fix unbalanced runtime PM get

Jonathan Neuschäfer (2):
      clk: loongson1: Terminate clk_div_table with sentinel element
      clk: clps711x: Terminate clk_div_table with sentinel element

Jonathan Teh (1):
      ALSA: cmipci: Restore aux vol on suspend/resume

Jordy Zomer (2):
      nfc: st21nfca: Fix potential buffer overflows in EVT_TRANSACTION
      dm ioctl: prevent potential spectre v1 gadget

Josh Poimboeuf (4):
      Documentation: Add swapgs description to the Spectre v1 documentation
      x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting
      x86/speculation: Warn about Spectre v2 LFENCE mitigation
      x86/speculation: Warn about eIBRS + LFENCE + Unprivileged eBPF + SMT

José Expósito (3):
      Input: clear BTN_RIGHT/MIDDLE on buttonpads
      Revert "Input: clear BTN_RIGHT/MIDDLE on buttonpads"
      drm/imx: Fix memory leak in imx_pd_connector_get_modes

Juergen Gross (10):
      xen/xenbus: don't let xenbus_grant_ring() remove grants in error case
      xen/grant-table: add gnttab_try_end_foreign_access()
      xen/blkfront: don't use gnttab_query_foreign_access() for mapped status
      xen/netfront: don't use gnttab_query_foreign_access() for mapped status
      xen/scsifront: don't use gnttab_query_foreign_access() for mapped status
      xen/gntalloc: don't use gnttab_query_foreign_access()
      xen: remove gnttab_query_foreign_access()
      xen/gnttab: fix gnttab_end_foreign_access() without page specified
      xen/netfront: react properly to failing gnttab_end_foreign_access_ref()
      mm, page_alloc: fix build_zonerefs_node()

Julian Braha (1):
      ARM: 9178/1: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE

Kees Cook (2):
      etherdevice: Adjust ether_addr* prototypes to silence -Wstringop-overead
      ARM: vexpress/spc: Avoid negative array index when !SMP

Khazhismel Kumykov (1):
      block/compat_ioctl: fix range check in BLKGETSIZE

Kim Phillips (2):
      x86/speculation: Use generic retpoline by default on AMD
      x86/speculation: Update link to AMD speculation whitepaper

Krzysztof Kozlowski (3):
      ARM: dts: exynos: fix UART3 pins configuration in Exynos5250
      ARM: dts: exynos: add missing HDMI supplies on SMDK5250
      ARM: dts: exynos: add missing HDMI supplies on SMDK5420

Kuldeep Singh (3):
      arm64: dts: ns2: Fix spi-cpol and spi-cpha property
      ARM: dts: spear1340: Update serial node properties
      ARM: dts: spear13xx: Update SPI dma properties

Kunihiko Hayashi (1):
      clk: uniphier: Fix fixed-rate initialization

Lad Prabhakar (1):
      can: rcar_canfd: rcar_canfd_channel_probe(): register the CAN device when fully ready

Lars-Peter Clausen (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on RODE NT-USB

Leo Ruan (1):
      gpu: ipu-v3: Fix dev_dbg frequency output

Liam Beguin (2):
      iio: inkern: apply consumer scale on IIO_VAL_INT cases
      iio: inkern: make a best effort on offset calculation

Liguang Zhang (1):
      PCI: pciehp: Clear cmd_busy bit in polling mode

Lin Ma (1):
      nfc: nci: add flush_workqueue to prevent uaf

Linus Lüssing (1):
      mac80211: fix potential double free on mesh join

Linus Torvalds (1):
      fget: clarify and improve __fget_files() implementation

Lucas Denefle (1):
      w1: w1_therm: fixes w1_seq for ds28ea00 sensors

Lucas Wei (1):
      fs: sysfs_emit: Remove PAGE_SIZE alignment check

Luiz Augusto von Dentz (1):
      Bluetooth: Fix use after free in hci_send_acl

Lukas Bulwahn (1):
      Documentation: refer to config RANDOMIZE_BASE for kernel address-space randomization

Lv Yunlong (1):
      drbd: Fix five use after free bugs in get_initial_state

Maciej W. Rozycki (1):
      DEC: Limit PMAX memory probing to R3k systems

Marc Zyngier (6):
      arm64: arch_timer: Add infrastructure for multiple erratum detection methods
      arm64: arch_timer: Add erratum handler for CPU-specific capability
      arm64: arch_timer: Add workaround for ARM erratum 1188873
      arm64: Add silicon-errata.txt entry for ARM erratum 1188873
      arm64: Make ARM64_ERRATUM_1188873 depend on COMPAT
      arm64: Add part number for Neoverse N1

Marek Marczykowski-Górecki (1):
      Revert "xen-netback: Check for hotplug-status existence before watching"

Marek Vasut (1):
      ASoC: ops: Shift tested values in snd_soc_put_volsw() by +min

Mark Cilissen (1):
      ACPI / x86: Work around broken XSDT on Advantech DAC-BJ01 board

Mark Featherston (1):
      gpio: ts4900: Do not set DAT and OE together

Mark Gross (2):
      Merge tag 'v4.9.312' into v4.9-rt
      Linux 4.9.312-rt193

Mark Rutland (1):
      arm/arm64: smccc/psci: add arm_smccc_1_1_get_conduit()

Martin Povišer (1):
      i2c: pasemi: Wait for write xfers to finish

Martin Varghese (1):
      openvswitch: Fixed nd target mask field in the flow dump.

Masahiro Yamada (1):
      x86/build: Fix compiler support check for CONFIG_RETPOLINE

Mauricio Faria de Oliveira (1):
      mm: fix race between MADV_FREE reclaim and blkdev direct IO read

Max Filippov (1):
      xtensa: fix DTC warning unit_address_format

Maxim Kiselev (1):
      powerpc: dts: t104xrdb: fix phy type for FMAN 4/5

Maxime Ripard (2):
      drm/edid: Always set RGB444
      drm/edid: Don't clear formats if using deep color

Maximilian Luz (1):
      ACPI: battery: Add device HID and quirk for Microsoft Surface Go 3

Miaohe Lin (2):
      memblock: use kfree() to release kmalloced memblock regions
      mm/mempolicy: fix mpol_new leak in shared_policy_replace

Miaoqian Lin (15):
      ethernet: Fix error handling in xemaclite_of_probe
      spi: tegra114: Add missing IRQ check in tegra_spi_probe
      soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe
      ASoC: atmel: Add missing of_node_put() in at91sam9g20ek_audio_probe
      video: fbdev: omapfb: Add missing of_node_put() in dvic_probe_of
      ASoC: mxs: Fix error handling in mxs_sgtl5000_probe
      power: supply: ab8500: Fix memory leak in ab8500_fg_sysfs_init
      drm/tegra: Fix reference leak in tegra_dsi_ganged_probe
      mfd: asic3: Add missing iounmap() on error asic3_mfd_probe
      remoteproc: qcom_wcnss: Add missing of_node_put() in wcnss_alloc_memory_region
      clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver
      pinctrl: mediatek: Fix missing of_node_put() in mtk_pctrl_init
      pinctrl: nomadik: Add missing of_node_put() in nmk_pinctrl_probe
      pinctrl/rockchip: Add missing of_node_put() in rockchip_pinctrl_probe
      dmaengine: imx-sdma: Fix error checking in sdma_event_remap

Michael Chan (1):
      bnxt_en: Eliminate unintended link toggle during FW reset

Michael S. Tsirkin (1):
      virtio_console: break out of buf poll on remove

Michael Schmitz (1):
      video: fbdev: atari: Atari 2 bpp (STe) palette bugfix

Mike Kravetz (1):
      selftests/memfd: clean up mapping in mfd_fail_write

Minghao Chi (1):
      spi: tegra20: Use of_device_get_match_data()

Mohammad Kabat (1):
      net/mlx5: Fix size field in bufferx_reg struct

Muhammad Usama Anjum (1):
      selftests/x86: Add validity check and allow field splitting

Nadav Amit (1):
      smp: Fix offline cpu check in flush_smp_call_function_queue()

Nathan Chancellor (2):
      ARM: Do not use NOCROSSREFS directive with ld.lld
      ARM: davinci: da850-evm: Avoid NULL pointer dereference

NeilBrown (2):
      SUNRPC: avoid race between mod_timer() and del_timer_sync()
      SUNRPC/call_alloc: async tasks mustn't block waiting for memory

Nicolas Escande (1):
      mac80211: fix forwarded mesh frames AC & queue selection

Niels Dossche (1):
      sfc: extend the locking on mcdi->seqno

Oliver Graute (1):
      staging: fbtft: fb_st7789v: reset display before initialization

Oliver Neukum (2):
      sr9700: sanity check for packet length
      USB: zaurus: support another broken Zaurus

Pablo Neira Ayuso (2):
      netfilter: nf_tables: initialize registers in nft_do_chain()
      netfilter: nf_conntrack_tcp: preserve liberal flag in tcp options

Paolo Bonzini (1):
      mmmremap.c: avoid pointless invalidate_range_start/end on mremap(old_size=0)

Paolo Valerio (1):
      openvswitch: fix OOB access in reserve_sfa_size()

Patrick Rudolph (1):
      hwmon: (pmbus) Add mutex to regulator ops

Patrick Wang (1):
      mm: kmemleak: take a full lowmem check in kmemleak_*_phys()

Paul Blakey (1):
      openvswitch: Fix setting ipv6 fields causing hw csum failure

Pavel Kubelun (1):
      ARM: dts: qcom: ipq4019: fix sleep clock

Pavel Skripkin (4):
      NFC: port100: fix use-after-free in port100_send_complete
      Input: aiptek - properly check endpoint type
      ath9k_htc: fix uninit value bugs
      jfs: fix divide error in dbNextAG

Pawan Gupta (2):
      x86/pm: Save the MSR validity status at context setup
      x86/speculation: Restore speculation related MSRs during S3 resume

Peter Rosin (1):
      i2c: mux: demux-pinctrl: do not deactivate a master that is not active

Peter Xu (1):
      mm: don't skip swap entry even if zap_details specified

Peter Zijlstra (3):
      x86,bugs: Unconditionally allow spectre_v2=retpoline,amd
      x86/speculation: Add eIBRS + Retpoline options
      Documentation/hw-vuln: Update spectre doc

Peter Zijlstra (Intel) (1):
      x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFENCE

Petr Machata (1):
      af_netlink: Fix shift out of bounds in group mask calculation

Petr Vorel (1):
      crypto: vmx - add missing dependencies

QintaoShen (1):
      drm/amdkfd: Check for potential null return of kmalloc_array()

Qiushi Wu (1):
      firmware: Fix a reference count leak.

Qu Wenruo (1):
      btrfs: unlock newly allocated extent buffer after error

Quinn Tran (1):
      scsi: qla2xxx: Fix incorrect reporting of task management failure

Rafael J. Wysocki (2):
      ACPICA: Avoid walking the ACPI Namespace if it is not there
      ACPI: CPPC: Avoid out of bounds access when parsing _CPC data

Randy Dunlap (20):
      net: stmmac: fix return value of __setup handler
      net: sxgbe: fix return value of __setup handler
      ARM: 9182/1: mmu: fix returns from early_param() and __setup() functions
      ARM: Spectre-BHB: provide empty stub for non-config
      PM: hibernate: fix __setup handler error handling
      PM: suspend: fix return value of __setup handler
      clocksource: acpi_pm: fix return value of __setup handler
      printk: fix return value of printk.devkmsg __setup handler
      TOMOYO: fix __setup handlers return values
      MIPS: RB532: fix return value of __setup handler
      tty: hvc: fix return value of __setup handler
      kgdboc: fix return value of __setup handler
      kgdbts: fix return value of __setup handler
      mm/mmap: return 1 from stack_guard_gap __setup() handler
      mm/memcontrol: return 1 from cgroup.memory __setup() handler
      ARM: 9187/1: JIVE: fix return value of __setup handler
      scsi: aha152x: Fix aha152x_setup() __setup handler return value
      init/main.c: return 1 from handled __setup() functions
      virtio_console: eliminate anonymous module_init & module_exit
      net: micrel: fix KS8851_MLL Kconfig

Richard Leitner (1):
      ARM: tegra: tamonten: Fix I2C3 pad setting

Richard Schleich (1):
      ARM: dts: bcm2837: Add the missing L1/L2 cache information

Rob Herring (1):
      arm64: Add part number for Arm Cortex-A77

Robert Hancock (2):
      serial: 8250: of: Fix mapped region size when using reg-offset property
      i2c: xiic: Make bus names unique

Robert Richter (1):
      arm64: errata: Provide macro for major and minor cpu revisions

Ronnie Sahlberg (1):
      cifs: fix double free race when mount fails in cifs_get_root()

Russell King (Oracle) (8):
      ARM: report Spectre v2 status through sysfs
      ARM: early traps initialisation
      ARM: use LOADADDR() to get load address of sections
      ARM: Spectre-BHB workaround
      ARM: include unprivileged BPF status in Spectre V2 reporting
      ARM: fix co-processor register typo
      ARM: fix build warning in proc-v7-bugs.c
      ARM: fix Thumb2 regression with Spectre BHB

Sasha Neftin (1):
      e1000e: Fix possible overflow in LTR decoding

Sebastian Andrzej Siewior (1):
      usb: dwc3: gadget: Let the interrupt handler disable bottom halves.

Sergey Matyukevich (1):
      ARC: entry: fix syscall_trace_exit argument

Sergey Shtylyov (2):
      ata: pata_hpt37x: disable primary channel on HPT371
      ata: pata_hpt37x: fix PCI clock detection

Shengjiu Wang (1):
      ASoC: soc-core: skip zero num_dai component in searching dai name

Slark Xiao (1):
      USB: serial: option: add support for DW5829e

Souptick Joarder (HPE) (1):
      irqchip/nvic: Release nvic_base upon failure

Sreeramya Soratkal (1):
      nl80211: Update bss channel on channel switch for P2P_CLIENT

Srinivas Pandruvada (1):
      thermal: int340x: Increase bitmap size

Stefano Garzarella (1):
      vhost/vsock: don't check owner in vhost_vsock_stop() while releasing

Steven Price (1):
      arm/arm64: Provide a wrapper for SMCCC 1.1 calls

Steven Rostedt (Google) (1):
      tracefs: Set the group ownership in apply_options() not parse_options()

Suzuki K Poulose (10):
      arm64: Add MIDR encoding for Arm Cortex-A55 and Cortex-A35
      arm64: capabilities: Move errata work around check on boot CPU
      arm64: capabilities: Move errata processing code
      arm64: capabilities: Prepare for fine grained capabilities
      arm64: capabilities: Add flags to handle the conflicts on late CPU
      arm64: capabilities: Clean up midr range helpers
      arm64: Add helpers for checking CPU MIDR against a range
      arm64: capabilities: Add support for checks based on a list of MIDRs
      arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
      arm64: Add helper to decode register from instruction

Sven Eckelmann (2):
      batman-adv: Request iflink once in batadv-on-batadv check
      batman-adv: Don't expect inter-netns unique iflink indices

Sven Schnelle (1):
      tracing: Ensure trace buffer is at least 4096 bytes large

Szymon Heidrich (1):
      USB: gadget: validate endpoint index for xilinx udc

Tadeusz Struk (2):
      net: ipv6: fix skb_over_panic in __ip6_append_data
      ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

Takashi Iwai (2):
      ALSA: pcm: Add stream lock during PCM reset ioctl operations
      ALSA: usb-audio: Clear MIDI port active flag after draining

Takashi Sakamoto (1):
      ALSA: firewire-lib: fix uninitialized flag for AV/C deferred transaction

Taniya Das (1):
      clk: qcom: clk-rcg2: Update the frac table for pixel clock

Tao Liu (1):
      gso: do not skip outer ip header in case of ipip and net_failover

Theodore Ts'o (3):
      ext4: don't BUG if someone dirty pages without asking ext4 first
      ext4: fix overhead calculation to account for the reserved gdt blocks
      ext4: force overhead calculation if the s_overhead_cluster makes no sense

Tim Chen (1):
      Documentation: Add section about CPU vulnerabilities for Spectre

Tim Gardner (1):
      video: fbdev: nvidiafb: Use strscpy() to prevent buffer overflow

Tom Rix (2):
      qed: return status of qed_iov_get_link
      qlcnic: dcb: default to returning -EOPNOTSUPP

Tomas Paukrt (1):
      crypto: mxs-dcp - Fix scatterlist processing

Tyrel Datwyler (1):
      scsi: ibmvscsis: Increase INITIAL_SRP_LIMIT to 1024

Ulf Hansson (1):
      mmc: host: Return an error when ->enable_sdio_irq() ops is missing

Uwe Kleine-König (2):
      pwm: lpc18xx-sct: Initialize driver data and hardware before pwmchip_add()
      ARM: mmp: Fix failure to remove sram device

Vincent Mailhol (1):
      can: gs_usb: change active_channels's type from atomic_t to u8

Vinod Koul (1):
      dmaengine: Revert "dmaengine: shdma: Fix runtime PM imbalance on error"

Vitaly Kuznetsov (1):
      KVM: x86: Forbid VMM to set SYNIC/STIMER MSRs when SynIC wasn't activated

Vladimir Oltean (2):
      net: dcb: flush lingering app table entries for unregistered devices
      net: dcb: disable softirqs in dcbnl_flush_dev()

WANG Chao (1):
      x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE

Wang Hai (1):
      video: fbdev: smscufx: Fix null-ptr-deref in ufx_usb_probe()

Wang Wensheng (1):
      ASoC: imx-es8328: Fix error return code in imx_es8328_probe()

Werner Sembach (1):
      ACPI: video: Force backlight native for Clevo NL5xRU and NL5xNU

William Mahon (1):
      HID: add mapping for KEY_ALL_APPLICATIONS

Wolfram Sang (1):
      i2c: qup: allow COMPILE_TEST

Xiaoke Wang (1):
      drm/msm/mdp5: check the return of kzalloc()

Xiaomeng Tong (3):
      ALSA: cs4236: fix an incorrect NULL check on list iterator
      dma: at_xdmac: fix a missing check on list iterator
      ASoC: soc-dapm: fix two incorrect uses of list iterator

Xie Yongji (2):
      block: Add a helper to validate the block size
      virtio-blk: Use blk_validate_block_size() to validate block size

Xin Long (1):
      xfrm: policy: match with both mark and mask on user interfaces

Xiongwei Song (1):
      mm: page_alloc: fix building error on -Werror=array-compare

Yajun Deng (1):
      netdevice: add the case if dev is NULL

Yan Yan (1):
      xfrm: Fix xfrm migrate issues when address family changes

Yang Guang (4):
      video: fbdev: omapfb: acx565akm: replace snprintf with sysfs_emit
      ptp: replace snprintf with sysfs_emit
      scsi: mvsas: Replace snprintf() with sysfs_emit()
      scsi: bfa: Replace snprintf() with sysfs_emit()

Yongzhi Liu (1):
      dmaengine: shdma: Fix runtime PM imbalance on error

Zekun Shen (1):
      ath5k: fix OOB in ath5k_eeprom_read_pcal_info_5111

Zhang Yi (1):
      ext2: correct max file size computing

Zhenzhong Duan (4):
      x86/speculation: Add RETPOLINE_AMD support to the inline asm CALL_NOSPEC variant
      x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support
      x86/retpoline: Remove minimal retpoline support
      KVM: x86: Fix emulation in writing cr8

Zheyu Ma (4):
      net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()
      ethernet: sun: Free the coherent when failing in probing
      video: fbdev: sm712fb: Fix crash in smtcfb_write()
      ata: pata_marvell: Check the 'bmdma_addr' beforing reading

Zhihao Cheng (3):
      ubifs: Add missing iput if do_tmpfile() failed in rename whiteout
      ubifs: setflags: Make dirtied_ino_d 8 bytes aligned
      ubi: fastmap: Return error code if memory allocation fails in add_aeb()

Zhou Guanghui (1):
      iommu/arm-smmu-v3: fix event handling soft lockup

daniel.starke@siemens.com (2):
      tty: n_gsm: fix encoding of control signal octet bit DV
      tty: n_gsm: fix proper link termination after failed open

david regan (1):
      mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status

suresh kumar (1):
      net-sysfs: add check for netdevice being present to speed_show
---
Documentation/arm64/silicon-errata.txt             |   1 +
 Documentation/hw-vuln/index.rst                    |   1 +
 Documentation/hw-vuln/spectre.rst                  | 785 +++++++++++++++++++++
 Documentation/kernel-parameters.txt                |  17 +-
 Makefile                                           |   2 +-
 arch/arc/kernel/entry.S                            |   1 +
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   3 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   3 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   3 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi                |   8 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |   6 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   6 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   6 +-
 arch/arm/include/asm/assembler.h                   |  10 +
 arch/arm/include/asm/kvm_host.h                    |   5 +
 arch/arm/include/asm/spectre.h                     |  38 +
 arch/arm/kernel/Makefile                           |   2 +
 arch/arm/kernel/entry-armv.S                       |  79 ++-
 arch/arm/kernel/entry-common.S                     |  24 +
 arch/arm/kernel/spectre.c                          |  71 ++
 arch/arm/kernel/traps.c                            |  65 +-
 arch/arm/kernel/vmlinux-xip.lds.S                  |  45 +-
 arch/arm/kernel/vmlinux.lds.S                      |  45 +-
 arch/arm/kvm/psci.c                                |   4 +
 arch/arm/mach-davinci/board-da850-evm.c            |   4 +-
 arch/arm/mach-mmp/sram.c                           |  22 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |   6 +-
 arch/arm/mach-vexpress/spc.c                       |   2 +-
 arch/arm/mm/Kconfig                                |  11 +
 arch/arm/mm/mmu.c                                  |   2 +
 arch/arm/mm/proc-v7-bugs.c                         | 199 +++++-
 arch/arm64/Kconfig                                 |  24 +
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |  49 ++
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |   8 +-
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |   2 +-
 arch/arm64/include/asm/arch_timer.h                |  44 +-
 arch/arm64/include/asm/assembler.h                 |  34 +
 arch/arm64/include/asm/cpu.h                       |   1 +
 arch/arm64/include/asm/cpucaps.h                   |   4 +-
 arch/arm64/include/asm/cpufeature.h                | 232 +++++-
 arch/arm64/include/asm/cputype.h                   |  63 ++
 arch/arm64/include/asm/fixmap.h                    |   6 +-
 arch/arm64/include/asm/insn.h                      |   2 +
 arch/arm64/include/asm/kvm_host.h                  |   4 +
 arch/arm64/include/asm/kvm_mmu.h                   |   2 +-
 arch/arm64/include/asm/mmu.h                       |   8 +-
 arch/arm64/include/asm/processor.h                 |   6 +-
 arch/arm64/include/asm/sections.h                  |   6 +
 arch/arm64/include/asm/sysreg.h                    |   5 +
 arch/arm64/include/asm/vectors.h                   |  74 ++
 arch/arm64/kernel/bpi.S                            |  55 ++
 arch/arm64/kernel/cpu_errata.c                     | 595 +++++++++++++---
 arch/arm64/kernel/cpufeature.c                     | 167 +++--
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/entry.S                          | 197 ++++--
 arch/arm64/kernel/fpsimd.c                         |   1 +
 arch/arm64/kernel/insn.c                           |  33 +-
 arch/arm64/kernel/module.lds                       |   2 +-
 arch/arm64/kernel/smp.c                            |   6 -
 arch/arm64/kernel/traps.c                          |   4 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   2 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |   4 +
 arch/arm64/kvm/hyp/switch.c                        |   9 +-
 arch/arm64/mm/fault.c                              |  17 +-
 arch/arm64/mm/mmu.c                                |  11 +-
 arch/mips/dec/prom/Makefile                        |   2 +-
 arch/mips/include/asm/dec/prom.h                   |  15 +-
 arch/mips/include/asm/setup.h                      |   2 +-
 arch/mips/kernel/smp.c                             |   6 +-
 arch/mips/kernel/traps.c                           |  22 +-
 arch/mips/rb532/devices.c                          |   6 +-
 arch/parisc/kernel/unaligned.c                     |  14 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |   4 +-
 arch/powerpc/sysdev/fsl_gtm.c                      |   4 +-
 arch/x86/Kconfig                                   |   4 -
 arch/x86/Makefile                                  |  11 +-
 arch/x86/events/intel/pt.c                         |   2 +-
 arch/x86/include/asm/cpufeatures.h                 |   2 +-
 arch/x86/include/asm/nospec-branch.h               |  41 +-
 arch/x86/kernel/acpi/boot.c                        |  24 +
 arch/x86/kernel/cpu/bugs.c                         | 225 ++++--
 arch/x86/kvm/emulate.c                             |  14 +-
 arch/x86/kvm/hyperv.c                              |  15 +
 arch/x86/kvm/lapic.c                               |   5 +-
 arch/x86/kvm/pmu_amd.c                             |   8 +-
 arch/x86/power/cpu.c                               |  21 +-
 arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi        |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi         |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi          |   4 +-
 block/compat_ioctl.c                               |   2 +-
 crypto/authenc.c                                   |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   3 +
 drivers/acpi/apei/bert.c                           |   8 +-
 drivers/acpi/battery.c                             |  12 +
 drivers/acpi/cppc_acpi.c                           |   5 +
 drivers/acpi/video_detect.c                        |  75 ++
 drivers/ata/pata_hpt37x.c                          |  18 +-
 drivers/ata/pata_marvell.c                         |   2 +
 drivers/atm/eni.c                                  |   2 +
 drivers/atm/firestream.c                           |   2 +
 drivers/base/power/main.c                          |   6 +-
 drivers/block/drbd/drbd_int.h                      |   8 +-
 drivers/block/drbd/drbd_nl.c                       |  41 +-
 drivers/block/drbd/drbd_state.c                    |  18 +-
 drivers/block/drbd/drbd_state_change.h             |   8 +-
 drivers/block/loop.c                               |  10 +-
 drivers/block/virtio_blk.c                         |  12 +-
 drivers/block/xen-blkfront.c                       |  67 +-
 drivers/char/virtio_console.c                      |  15 +-
 drivers/clk/clk-clps711x.c                         |   2 +
 drivers/clk/loongson1/clk-loongson1c.c             |   1 +
 drivers/clk/qcom/clk-rcg2.c                        |   1 +
 drivers/clk/tegra/clk-emc.c                        |   1 +
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c     |   1 +
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/acpi_pm.c                      |   6 +-
 drivers/clocksource/arm_arch_timer.c               | 192 ++++-
 drivers/crypto/ccp/ccp-dmaengine.c                 |  16 +
 drivers/crypto/mxs-dcp.c                           |   2 +-
 drivers/crypto/qat/qat_common/qat_crypto.c         |   8 +
 drivers/crypto/vmx/Kconfig                         |   4 +
 drivers/dma/at_xdmac.c                             |  12 +-
 drivers/dma/imx-sdma.c                             |   4 +-
 drivers/firmware/efi/vars.c                        |   5 +-
 drivers/firmware/psci.c                            |  15 +
 drivers/firmware/qemu_fw_cfg.c                     |  10 +-
 drivers/gpio/gpio-ts4900.c                         |  24 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   2 +
 drivers/gpu/drm/drm_edid.c                         |  10 +-
 drivers/gpu/drm/imx/parallel-display.c             |   4 +-
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c          |   3 +
 drivers/gpu/drm/tegra/dsi.c                        |   4 +-
 drivers/gpu/ipu-v3/ipu-di.c                        |   5 +-
 drivers/hid/hid-debug.c                            |   4 +-
 drivers/hid/hid-input.c                            |   2 +
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  32 +-
 drivers/hwmon/pmbus/pmbus.h                        |   1 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  18 +-
 drivers/hwmon/sch56xx-common.c                     |   2 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   8 +-
 drivers/i2c/busses/Kconfig                         |   2 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |  11 +
 drivers/i2c/busses/i2c-pasemi.c                    |   6 +
 drivers/i2c/busses/i2c-xiic.c                      |   3 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   5 +-
 drivers/iio/adc/men_z188_adc.c                     |   9 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   2 +
 drivers/iio/inkern.c                               |  34 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   6 +-
 drivers/input/mouse/elan_i2c_core.c                |  64 +-
 drivers/input/tablet/aiptek.c                      |  10 +-
 drivers/iommu/arm-smmu-v3.c                        |   1 +
 drivers/irqchip/irq-nvic.c                         |   2 +
 drivers/md/dm-ioctl.c                              |   2 +
 drivers/media/pci/cx88/cx88-mpeg.c                 |   3 +
 drivers/media/platform/davinci/vpif.c              |   1 +
 drivers/media/usb/go7007/s2250-board.c             |  10 +-
 drivers/media/usb/hdpvr/hdpvr-video.c              |   4 +-
 drivers/memory/emif.c                              |   8 +-
 drivers/mfd/asic3.c                                |  10 +-
 drivers/mfd/mc13xxx-core.c                         |   4 +-
 drivers/misc/kgdbts.c                              |   4 +-
 drivers/mmc/core/host.c                            |  15 +-
 drivers/mtd/nand/brcmnand/brcmnand.c               |   2 +-
 drivers/mtd/onenand/generic.c                      |   7 +-
 drivers/mtd/ubi/fastmap.c                          |  28 +-
 drivers/net/arcnet/com20020-pci.c                  |   3 +
 drivers/net/can/rcar/rcar_canfd.c                  |   6 +-
 drivers/net/can/usb/ems_usb.c                      |   1 -
 drivers/net/can/usb/gs_usb.c                       |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 +-
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c         |   2 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   2 +-
 drivers/net/ethernet/micrel/Kconfig                |   1 +
 drivers/net/ethernet/nxp/lpc_eth.c                 |   5 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |  18 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |   7 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h    |  10 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |   6 +-
 drivers/net/ethernet/sfc/mcdi.c                    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c |   8 -
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h |   4 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +-
 drivers/net/ethernet/sun/sunhme.c                  |   6 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   4 +-
 drivers/net/hamradio/6pack.c                       |   4 +-
 drivers/net/hamradio/mkiss.c                       |   2 +
 drivers/net/phy/broadcom.c                         |  21 +
 drivers/net/slip/slip.c                            |   2 +-
 drivers/net/usb/cdc_ether.c                        |  12 +
 drivers/net/usb/cdc_mbim.c                         |   5 +
 drivers/net/usb/sr9700.c                           |   2 +-
 drivers/net/usb/zaurus.c                           |  12 +
 drivers/net/veth.c                                 |   2 +-
 drivers/net/vxlan.c                                |   4 +-
 drivers/net/wireless/ath/ath5k/eeprom.c            |   3 +
 drivers/net/wireless/ath/ath9k/htc_hst.c           |   5 +
 drivers/net/wireless/ath/carl9170/main.c           |   2 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |   2 +
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  48 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   2 +-
 drivers/net/wireless/mac80211_hwsim.c              |  13 +
 drivers/net/wireless/ray_cs.c                      |   6 +
 drivers/net/xen-netback/xenbus.c                   |  12 +-
 drivers/net/xen-netfront.c                         |  54 +-
 drivers/nfc/port100.c                              |   2 +
 drivers/nfc/st21nfca/se.c                          |  10 +
 drivers/pci/hotplug/pciehp_hpc.c                   |   2 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   2 +
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |   4 +-
 drivers/pinctrl/pinconf-generic.c                  |   6 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |   2 +
 drivers/platform/x86/samsung-laptop.c              |   2 -
 drivers/power/supply/ab8500_fg.c                   |   4 +-
 drivers/power/supply/wm8350_power.c                |  97 ++-
 drivers/ptp/ptp_sysfs.c                            |   4 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |  20 +-
 drivers/remoteproc/qcom_wcnss.c                    |   1 +
 drivers/rtc/rtc-wm8350.c                           |  11 +-
 drivers/scsi/aha152x.c                             |   6 +-
 drivers/scsi/bfa/bfad_attr.c                       |  26 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           |   2 +-
 drivers/scsi/libfc/fc_exch.c                       |   1 +
 drivers/scsi/libsas/sas_ata.c                      |   2 +-
 drivers/scsi/mvsas/mv_init.c                       |   5 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |  13 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |  11 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   1 +
 drivers/scsi/xen-scsifront.c                       |   3 +-
 drivers/scsi/zorro7xx.c                            |   2 +
 drivers/soc/fsl/qe/qe_io.c                         |   2 +
 drivers/soc/ti/wkup_m3_ipc.c                       |   4 +-
 drivers/spi/spi-tegra114.c                         |   4 +
 drivers/spi/spi-tegra20-slink.c                    |   8 +-
 drivers/staging/fbtft/fb_st7789v.c                 |   2 +
 drivers/staging/gdm724x/gdm_lte.c                  |   5 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   2 +-
 drivers/tty/hvc/hvc_iucv.c                         |   4 +-
 drivers/tty/mxser.c                                |  15 +-
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/serial/8250/8250_of.c                  |  30 +-
 drivers/tty/serial/kgdboc.c                        |   6 +-
 drivers/tty/serial/samsung.c                       |   5 +-
 drivers/usb/dwc3/dwc3-omap.c                       |   2 +-
 drivers/usb/dwc3/gadget.c                          |   2 +
 drivers/usb/gadget/function/rndis.c                |   9 +
 drivers/usb/gadget/function/rndis.h                |   1 +
 drivers/usb/gadget/legacy/inode.c                  |  10 +-
 drivers/usb/gadget/udc/core.c                      |   3 -
 drivers/usb/gadget/udc/udc-xilinx.c                |   6 +
 drivers/usb/host/xhci.c                            |   9 +-
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/ch341.c                         |   1 -
 drivers/usb/serial/option.c                        |  12 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   3 +
 drivers/usb/serial/usb-serial-simple.c             |   7 +
 drivers/usb/storage/ene_ub6250.c                   | 155 ++--
 drivers/usb/storage/realtek_cr.c                   |   2 +-
 drivers/vhost/vsock.c                              |  21 +-
 drivers/video/fbdev/atafb.c                        |  12 +-
 drivers/video/fbdev/cirrusfb.c                     |  16 +-
 drivers/video/fbdev/core/fbcvt.c                   |  53 +-
 drivers/video/fbdev/nvidia/nv_i2c.c                |   2 +-
 .../fbdev/omap2/omapfb/displays/connector-dvi.c    |   1 +
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |   8 +-
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   |   2 +-
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |   4 +-
 drivers/video/fbdev/sm712fb.c                      |  46 +-
 drivers/video/fbdev/smscufx.c                      |   3 +-
 drivers/video/fbdev/w100fb.c                       |  15 +-
 drivers/w1/slaves/w1_therm.c                       |   8 +-
 drivers/xen/gntalloc.c                             |  25 +-
 drivers/xen/grant-table.c                          |  59 +-
 drivers/xen/xenbus/xenbus_client.c                 |  24 +-
 fs/btrfs/extent-tree.c                             |   1 +
 fs/cifs/cifsfs.c                                   |   3 +-
 fs/cifs/link.c                                     |   3 +
 fs/configfs/dir.c                                  |  14 +
 fs/ext2/super.c                                    |   6 +-
 fs/ext4/inode.c                                    |  36 +-
 fs/ext4/super.c                                    |  19 +-
 fs/file.c                                          |  73 +-
 fs/gfs2/rgrp.c                                     |  12 +-
 fs/jffs2/build.c                                   |   4 +-
 fs/jffs2/fs.c                                      |   2 +-
 fs/jffs2/scan.c                                    |   6 +-
 fs/jfs/inode.c                                     |   3 +-
 fs/jfs/jfs_dmap.c                                  |   7 +
 fs/nfs/callback_xdr.c                              |   4 -
 fs/nfsd/nfsproc.c                                  |   2 +-
 fs/nfsd/xdr.h                                      |   2 +-
 fs/ntfs/inode.c                                    |   4 +
 fs/sysfs/file.c                                    |   3 +-
 fs/tracefs/inode.c                                 |   5 +-
 fs/ubifs/dir.c                                     |   2 +
 fs/ubifs/ioctl.c                                   |   2 +-
 include/linux/arm-smccc.h                          |  81 +++
 include/linux/blkdev.h                             |   8 +
 include/linux/bpf.h                                |  11 +
 include/linux/compiler-gcc.h                       |   2 +-
 include/linux/etherdevice.h                        |   5 +-
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 include/linux/module.h                             |   2 +-
 include/linux/netdevice.h                          |   6 +-
 include/net/checksum.h                             |   5 +
 include/net/netfilter/nf_queue.h                   |   2 +-
 include/net/xfrm.h                                 |   9 +-
 include/uapi/linux/input-event-codes.h             |   3 +-
 include/xen/grant_table.h                          |  19 +-
 init/main.c                                        |   6 +-
 kernel/events/core.c                               |   3 +
 kernel/power/hibernate.c                           |   2 +-
 kernel/power/suspend_test.c                        |   8 +-
 kernel/printk/printk.c                             |   6 +-
 kernel/ptrace.c                                    |  47 +-
 kernel/sched/debug.c                               |  10 -
 kernel/smp.c                                       |   2 +-
 kernel/sysctl.c                                    |   8 +
 kernel/trace/trace.c                               |  10 +-
 lib/Kconfig                                        |   1 -
 lib/raid6/test/test.c                              |   1 -
 localversion-rt                                    |   2 +-
 mm/kmemleak.c                                      |   8 +-
 mm/memblock.c                                      |  10 +-
 mm/memcontrol.c                                    |   2 +-
 mm/memory.c                                        |  24 +-
 mm/mempolicy.c                                     |   9 +-
 mm/mmap.c                                          |   2 +-
 mm/mremap.c                                        |   3 +
 mm/page_alloc.c                                    |  13 +-
 mm/rmap.c                                          |  35 +-
 mm/shmem.c                                         |   7 +-
 net/ax25/af_ax25.c                                 |   7 +
 net/batman-adv/hard-interface.c                    |  13 +-
 net/bluetooth/hci_event.c                          |   3 +-
 net/core/net-sysfs.c                               |   2 +-
 net/core/skbuff.c                                  |   4 +-
 net/dcb/dcbnl.c                                    |  44 ++
 net/ipv4/af_inet.c                                 |   5 +-
 net/ipv4/tcp.c                                     |  10 +-
 net/ipv6/ip6_offload.c                             |   2 +
 net/ipv6/ip6_output.c                              |  11 +-
 net/key/af_key.c                                   |   6 +-
 net/llc/af_llc.c                                   |  49 +-
 net/mac80211/cfg.c                                 |   3 -
 net/mac80211/rx.c                                  |   4 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |  17 +-
 net/netfilter/nf_queue.c                           |  23 +-
 net/netfilter/nf_tables_core.c                     |   2 +-
 net/netfilter/nfnetlink_queue.c                    |  12 +-
 net/netlink/af_netlink.c                           |   9 +
 net/nfc/nci/core.c                                 |   4 +
 net/openvswitch/actions.c                          |  46 +-
 net/openvswitch/flow_netlink.c                     |   6 +-
 net/packet/af_packet.c                             |  24 +-
 net/sctp/sctp_diag.c                               |   9 +-
 net/sunrpc/sched.c                                 |   4 +-
 net/sunrpc/xprt.c                                  |   7 +
 net/sunrpc/xprtrdma/transport.c                    |   4 +-
 net/wireless/nl80211.c                             |   3 +-
 net/x25/af_x25.c                                   |  11 +-
 net/xfrm/xfrm_policy.c                             |  24 +-
 net/xfrm/xfrm_state.c                              |   8 +-
 net/xfrm/xfrm_user.c                               |  14 +-
 scripts/gcc-plugins/latent_entropy_plugin.c        |  44 +-
 scripts/mod/modpost.c                              |   2 +-
 security/selinux/xfrm.c                            |   2 +-
 security/smack/smack_lsm.c                         |   2 +-
 security/tomoyo/load_policy.c                      |   4 +-
 sound/core/pcm_misc.c                              |   2 +-
 sound/core/pcm_native.c                            |   4 +
 sound/firewire/fcp.c                               |   4 +-
 sound/isa/cs423x/cs4236.c                          |   8 +-
 sound/pci/ac97/ac97_codec.c                        |   4 +-
 sound/pci/cmipci.c                                 |   3 +-
 sound/soc/atmel/atmel_ssc_dai.c                    |   5 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   1 +
 sound/soc/codecs/wm8350.c                          |  28 +-
 sound/soc/davinci/davinci-i2s.c                    |   5 +-
 sound/soc/fsl/imx-es8328.c                         |   1 +
 sound/soc/mxs/mxs-saif.c                           |   5 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |   3 +
 sound/soc/sh/fsi.c                                 |  19 +-
 sound/soc/soc-core.c                               |   2 +-
 sound/soc/soc-dapm.c                               |   6 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   6 +-
 sound/soc/soc-ops.c                                |   4 +-
 sound/soc/soc-topology.c                           |   3 +-
 sound/spi/at73c213.c                               |  27 +-
 sound/usb/midi.c                                   |   1 +
 sound/usb/mixer_quirks.c                           |   7 +-
 sound/usb/usbaudio.h                               |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h           |   2 +-
 tools/build/feature/Makefile                       |   2 +-
 tools/testing/selftests/memfd/memfd_test.c         |   1 +
 tools/testing/selftests/vm/userfaultfd.c           |   1 +
 tools/testing/selftests/x86/check_cc.sh            |   2 +-
 virt/kvm/kvm_main.c                                |  13 +
 405 files changed, 5390 insertions(+), 1604 deletions(-)
---
diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index ac9489fad31b..47df2c25302a 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -55,6 +55,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 | ARM            | Cortex-A72      | #853709         | N/A                         |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
+| ARM            | Cortex-A76      | #1188873        | ARM64_ERRATUM_1188873       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/Documentation/hw-vuln/index.rst b/Documentation/hw-vuln/index.rst
index b5fbc6ae9d5f..74466ba80167 100644
--- a/Documentation/hw-vuln/index.rst
+++ b/Documentation/hw-vuln/index.rst
@@ -9,6 +9,7 @@ are configurable at compile, boot or run time.
 .. toctree::
    :maxdepth: 1
 
+   spectre
    l1tf
    mds
    tsx_async_abort
diff --git a/Documentation/hw-vuln/spectre.rst b/Documentation/hw-vuln/spectre.rst
new file mode 100644
index 000000000000..c6c43ac2ba43
--- /dev/null
+++ b/Documentation/hw-vuln/spectre.rst
@@ -0,0 +1,785 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Spectre Side Channels
+=====================
+
+Spectre is a class of side channel attacks that exploit branch prediction
+and speculative execution on modern CPUs to read memory, possibly
+bypassing access controls. Speculative execution side channel exploits
+do not modify memory but attempt to infer privileged data in the memory.
+
+This document covers Spectre variant 1 and Spectre variant 2.
+
+Affected processors
+-------------------
+
+Speculative execution side channel methods affect a wide range of modern
+high performance processors, since most modern high speed processors
+use branch prediction and speculative execution.
+
+The following CPUs are vulnerable:
+
+    - Intel Core, Atom, Pentium, and Xeon processors
+
+    - AMD Phenom, EPYC, and Zen processors
+
+    - IBM POWER and zSeries processors
+
+    - Higher end ARM processors
+
+    - Apple CPUs
+
+    - Higher end MIPS CPUs
+
+    - Likely most other high performance CPUs. Contact your CPU vendor for details.
+
+Whether a processor is affected or not can be read out from the Spectre
+vulnerability files in sysfs. See :ref:`spectre_sys_info`.
+
+Related CVEs
+------------
+
+The following CVE entries describe Spectre variants:
+
+   =============   =======================  ==========================
+   CVE-2017-5753   Bounds check bypass      Spectre variant 1
+   CVE-2017-5715   Branch target injection  Spectre variant 2
+   CVE-2019-1125   Spectre v1 swapgs        Spectre variant 1 (swapgs)
+   =============   =======================  ==========================
+
+Problem
+-------
+
+CPUs use speculative operations to improve performance. That may leave
+traces of memory accesses or computations in the processor's caches,
+buffers, and branch predictors. Malicious software may be able to
+influence the speculative execution paths, and then use the side effects
+of the speculative execution in the CPUs' caches and buffers to infer
+privileged data touched during the speculative execution.
+
+Spectre variant 1 attacks take advantage of speculative execution of
+conditional branches, while Spectre variant 2 attacks use speculative
+execution of indirect branches to leak privileged memory.
+See :ref:`[1] <spec_ref1>` :ref:`[5] <spec_ref5>` :ref:`[6] <spec_ref6>`
+:ref:`[7] <spec_ref7>` :ref:`[10] <spec_ref10>` :ref:`[11] <spec_ref11>`.
+
+Spectre variant 1 (Bounds Check Bypass)
+---------------------------------------
+
+The bounds check bypass attack :ref:`[2] <spec_ref2>` takes advantage
+of speculative execution that bypasses conditional branch instructions
+used for memory access bounds check (e.g. checking if the index of an
+array results in memory access within a valid range). This results in
+memory accesses to invalid memory (with out-of-bound index) that are
+done speculatively before validation checks resolve. Such speculative
+memory accesses can leave side effects, creating side channels which
+leak information to the attacker.
+
+There are some extensions of Spectre variant 1 attacks for reading data
+over the network, see :ref:`[12] <spec_ref12>`. However such attacks
+are difficult, low bandwidth, fragile, and are considered low risk.
+
+Note that, despite "Bounds Check Bypass" name, Spectre variant 1 is not
+only about user-controlled array bounds checks.  It can affect any
+conditional checks.  The kernel entry code interrupt, exception, and NMI
+handlers all have conditional swapgs checks.  Those may be problematic
+in the context of Spectre v1, as kernel code can speculatively run with
+a user GS.
+
+Spectre variant 2 (Branch Target Injection)
+-------------------------------------------
+
+The branch target injection attack takes advantage of speculative
+execution of indirect branches :ref:`[3] <spec_ref3>`.  The indirect
+branch predictors inside the processor used to guess the target of
+indirect branches can be influenced by an attacker, causing gadget code
+to be speculatively executed, thus exposing sensitive data touched by
+the victim. The side effects left in the CPU's caches during speculative
+execution can be measured to infer data values.
+
+.. _poison_btb:
+
+In Spectre variant 2 attacks, the attacker can steer speculative indirect
+branches in the victim to gadget code by poisoning the branch target
+buffer of a CPU used for predicting indirect branch addresses. Such
+poisoning could be done by indirect branching into existing code,
+with the address offset of the indirect branch under the attacker's
+control. Since the branch prediction on impacted hardware does not
+fully disambiguate branch address and uses the offset for prediction,
+this could cause privileged code's indirect branch to jump to a gadget
+code with the same offset.
+
+The most useful gadgets take an attacker-controlled input parameter (such
+as a register value) so that the memory read can be controlled. Gadgets
+without input parameters might be possible, but the attacker would have
+very little control over what memory can be read, reducing the risk of
+the attack revealing useful data.
+
+One other variant 2 attack vector is for the attacker to poison the
+return stack buffer (RSB) :ref:`[13] <spec_ref13>` to cause speculative
+subroutine return instruction execution to go to a gadget.  An attacker's
+imbalanced subroutine call instructions might "poison" entries in the
+return stack buffer which are later consumed by a victim's subroutine
+return instructions.  This attack can be mitigated by flushing the return
+stack buffer on context switch, or virtual machine (VM) exit.
+
+On systems with simultaneous multi-threading (SMT), attacks are possible
+from the sibling thread, as level 1 cache and branch target buffer
+(BTB) may be shared between hardware threads in a CPU core.  A malicious
+program running on the sibling thread may influence its peer's BTB to
+steer its indirect branch speculations to gadget code, and measure the
+speculative execution's side effects left in level 1 cache to infer the
+victim's data.
+
+Yet another variant 2 attack vector is for the attacker to poison the
+Branch History Buffer (BHB) to speculatively steer an indirect branch
+to a specific Branch Target Buffer (BTB) entry, even if the entry isn't
+associated with the source address of the indirect branch. Specifically,
+the BHB might be shared across privilege levels even in the presence of
+Enhanced IBRS.
+
+Currently the only known real-world BHB attack vector is via
+unprivileged eBPF. Therefore, it's highly recommended to not enable
+unprivileged eBPF, especially when eIBRS is used (without retpolines).
+For a full mitigation against BHB attacks, it's recommended to use
+retpolines (or eIBRS combined with retpolines).
+
+Attack scenarios
+----------------
+
+The following list of attack scenarios have been anticipated, but may
+not cover all possible attack vectors.
+
+1. A user process attacking the kernel
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Spectre variant 1
+~~~~~~~~~~~~~~~~~
+
+   The attacker passes a parameter to the kernel via a register or
+   via a known address in memory during a syscall. Such parameter may
+   be used later by the kernel as an index to an array or to derive
+   a pointer for a Spectre variant 1 attack.  The index or pointer
+   is invalid, but bound checks are bypassed in the code branch taken
+   for speculative execution. This could cause privileged memory to be
+   accessed and leaked.
+
+   For kernel code that has been identified where data pointers could
+   potentially be influenced for Spectre attacks, new "nospec" accessor
+   macros are used to prevent speculative loading of data.
+
+Spectre variant 1 (swapgs)
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+   An attacker can train the branch predictor to speculatively skip the
+   swapgs path for an interrupt or exception.  If they initialize
+   the GS register to a user-space value, if the swapgs is speculatively
+   skipped, subsequent GS-related percpu accesses in the speculation
+   window will be done with the attacker-controlled GS value.  This
+   could cause privileged memory to be accessed and leaked.
+
+   For example:
+
+   ::
+
+     if (coming from user space)
+         swapgs
+     mov %gs:<percpu_offset>, %reg
+     mov (%reg), %reg1
+
+   When coming from user space, the CPU can speculatively skip the
+   swapgs, and then do a speculative percpu load using the user GS
+   value.  So the user can speculatively force a read of any kernel
+   value.  If a gadget exists which uses the percpu value as an address
+   in another load/store, then the contents of the kernel value may
+   become visible via an L1 side channel attack.
+
+   A similar attack exists when coming from kernel space.  The CPU can
+   speculatively do the swapgs, causing the user GS to get used for the
+   rest of the speculative window.
+
+Spectre variant 2
+~~~~~~~~~~~~~~~~~
+
+   A spectre variant 2 attacker can :ref:`poison <poison_btb>` the branch
+   target buffer (BTB) before issuing syscall to launch an attack.
+   After entering the kernel, the kernel could use the poisoned branch
+   target buffer on indirect jump and jump to gadget code in speculative
+   execution.
+
+   If an attacker tries to control the memory addresses leaked during
+   speculative execution, he would also need to pass a parameter to the
+   gadget, either through a register or a known address in memory. After
+   the gadget has executed, he can measure the side effect.
+
+   The kernel can protect itself against consuming poisoned branch
+   target buffer entries by using return trampolines (also known as
+   "retpoline") :ref:`[3] <spec_ref3>` :ref:`[9] <spec_ref9>` for all
+   indirect branches. Return trampolines trap speculative execution paths
+   to prevent jumping to gadget code during speculative execution.
+   x86 CPUs with Enhanced Indirect Branch Restricted Speculation
+   (Enhanced IBRS) available in hardware should use the feature to
+   mitigate Spectre variant 2 instead of retpoline. Enhanced IBRS is
+   more efficient than retpoline.
+
+   There may be gadget code in firmware which could be exploited with
+   Spectre variant 2 attack by a rogue user process. To mitigate such
+   attacks on x86, Indirect Branch Restricted Speculation (IBRS) feature
+   is turned on before the kernel invokes any firmware code.
+
+2. A user process attacking another user process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+   A malicious user process can try to attack another user process,
+   either via a context switch on the same hardware thread, or from the
+   sibling hyperthread sharing a physical processor core on simultaneous
+   multi-threading (SMT) system.
+
+   Spectre variant 1 attacks generally require passing parameters
+   between the processes, which needs a data passing relationship, such
+   as remote procedure calls (RPC).  Those parameters are used in gadget
+   code to derive invalid data pointers accessing privileged memory in
+   the attacked process.
+
+   Spectre variant 2 attacks can be launched from a rogue process by
+   :ref:`poisoning <poison_btb>` the branch target buffer.  This can
+   influence the indirect branch targets for a victim process that either
+   runs later on the same hardware thread, or running concurrently on
+   a sibling hardware thread sharing the same physical core.
+
+   A user process can protect itself against Spectre variant 2 attacks
+   by using the prctl() syscall to disable indirect branch speculation
+   for itself.  An administrator can also cordon off an unsafe process
+   from polluting the branch target buffer by disabling the process's
+   indirect branch speculation. This comes with a performance cost
+   from not using indirect branch speculation and clearing the branch
+   target buffer.  When SMT is enabled on x86, for a process that has
+   indirect branch speculation disabled, Single Threaded Indirect Branch
+   Predictors (STIBP) :ref:`[4] <spec_ref4>` are turned on to prevent the
+   sibling thread from controlling branch target buffer.  In addition,
+   the Indirect Branch Prediction Barrier (IBPB) is issued to clear the
+   branch target buffer when context switching to and from such process.
+
+   On x86, the return stack buffer is stuffed on context switch.
+   This prevents the branch target buffer from being used for branch
+   prediction when the return stack buffer underflows while switching to
+   a deeper call stack. Any poisoned entries in the return stack buffer
+   left by the previous process will also be cleared.
+
+   User programs should use address space randomization to make attacks
+   more difficult (Set /proc/sys/kernel/randomize_va_space = 1 or 2).
+
+3. A virtualized guest attacking the host
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+   The attack mechanism is similar to how user processes attack the
+   kernel.  The kernel is entered via hyper-calls or other virtualization
+   exit paths.
+
+   For Spectre variant 1 attacks, rogue guests can pass parameters
+   (e.g. in registers) via hyper-calls to derive invalid pointers to
+   speculate into privileged memory after entering the kernel.  For places
+   where such kernel code has been identified, nospec accessor macros
+   are used to stop speculative memory access.
+
+   For Spectre variant 2 attacks, rogue guests can :ref:`poison
+   <poison_btb>` the branch target buffer or return stack buffer, causing
+   the kernel to jump to gadget code in the speculative execution paths.
+
+   To mitigate variant 2, the host kernel can use return trampolines
+   for indirect branches to bypass the poisoned branch target buffer,
+   and flushing the return stack buffer on VM exit.  This prevents rogue
+   guests from affecting indirect branching in the host kernel.
+
+   To protect host processes from rogue guests, host processes can have
+   indirect branch speculation disabled via prctl().  The branch target
+   buffer is cleared before context switching to such processes.
+
+4. A virtualized guest attacking other guest
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+   A rogue guest may attack another guest to get data accessible by the
+   other guest.
+
+   Spectre variant 1 attacks are possible if parameters can be passed
+   between guests.  This may be done via mechanisms such as shared memory
+   or message passing.  Such parameters could be used to derive data
+   pointers to privileged data in guest.  The privileged data could be
+   accessed by gadget code in the victim's speculation paths.
+
+   Spectre variant 2 attacks can be launched from a rogue guest by
+   :ref:`poisoning <poison_btb>` the branch target buffer or the return
+   stack buffer. Such poisoned entries could be used to influence
+   speculation execution paths in the victim guest.
+
+   Linux kernel mitigates attacks to other guests running in the same
+   CPU hardware thread by flushing the return stack buffer on VM exit,
+   and clearing the branch target buffer before switching to a new guest.
+
+   If SMT is used, Spectre variant 2 attacks from an untrusted guest
+   in the sibling hyperthread can be mitigated by the administrator,
+   by turning off the unsafe guest's indirect branch speculation via
+   prctl().  A guest can also protect itself by turning on microcode
+   based mitigations (such as IBPB or STIBP on x86) within the guest.
+
+.. _spectre_sys_info:
+
+Spectre system information
+--------------------------
+
+The Linux kernel provides a sysfs interface to enumerate the current
+mitigation status of the system for Spectre: whether the system is
+vulnerable, and which mitigations are active.
+
+The sysfs file showing Spectre variant 1 mitigation status is:
+
+   /sys/devices/system/cpu/vulnerabilities/spectre_v1
+
+The possible values in this file are:
+
+  .. list-table::
+
+     * - 'Not affected'
+       - The processor is not vulnerable.
+     * - 'Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers'
+       - The swapgs protections are disabled; otherwise it has
+         protection in the kernel on a case by case base with explicit
+         pointer sanitation and usercopy LFENCE barriers.
+     * - 'Mitigation: usercopy/swapgs barriers and __user pointer sanitization'
+       - Protection in the kernel on a case by case base with explicit
+         pointer sanitation, usercopy LFENCE barriers, and swapgs LFENCE
+         barriers.
+
+However, the protections are put in place on a case by case basis,
+and there is no guarantee that all possible attack vectors for Spectre
+variant 1 are covered.
+
+The spectre_v2 kernel file reports if the kernel has been compiled with
+retpoline mitigation or if the CPU has hardware mitigation, and if the
+CPU has support for additional process-specific mitigation.
+
+This file also reports CPU features enabled by microcode to mitigate
+attack between user processes:
+
+1. Indirect Branch Prediction Barrier (IBPB) to add additional
+   isolation between processes of different users.
+2. Single Thread Indirect Branch Predictors (STIBP) to add additional
+   isolation between CPU threads running on the same core.
+
+These CPU features may impact performance when used and can be enabled
+per process on a case-by-case base.
+
+The sysfs file showing Spectre variant 2 mitigation status is:
+
+   /sys/devices/system/cpu/vulnerabilities/spectre_v2
+
+The possible values in this file are:
+
+  - Kernel status:
+
+  ========================================  =================================
+  'Not affected'                            The processor is not vulnerable
+  'Mitigation: None'                        Vulnerable, no mitigation
+  'Mitigation: Retpolines'                  Use Retpoline thunks
+  'Mitigation: LFENCE'                      Use LFENCE instructions
+  'Mitigation: Enhanced IBRS'               Hardware-focused mitigation
+  'Mitigation: Enhanced IBRS + Retpolines'  Hardware-focused + Retpolines
+  'Mitigation: Enhanced IBRS + LFENCE'      Hardware-focused + LFENCE
+  ========================================  =================================
+
+  - Firmware status: Show if Indirect Branch Restricted Speculation (IBRS) is
+    used to protect against Spectre variant 2 attacks when calling firmware (x86 only).
+
+  ========== =============================================================
+  'IBRS_FW'  Protection against user program attacks when calling firmware
+  ========== =============================================================
+
+  - Indirect branch prediction barrier (IBPB) status for protection between
+    processes of different users. This feature can be controlled through
+    prctl() per process, or through kernel command line options. This is
+    an x86 only feature. For more details see below.
+
+  ===================   ========================================================
+  'IBPB: disabled'      IBPB unused
+  'IBPB: always-on'     Use IBPB on all tasks
+  'IBPB: conditional'   Use IBPB on SECCOMP or indirect branch restricted tasks
+  ===================   ========================================================
+
+  - Single threaded indirect branch prediction (STIBP) status for protection
+    between different hyper threads. This feature can be controlled through
+    prctl per process, or through kernel command line options. This is x86
+    only feature. For more details see below.
+
+  ====================  ========================================================
+  'STIBP: disabled'     STIBP unused
+  'STIBP: forced'       Use STIBP on all tasks
+  'STIBP: conditional'  Use STIBP on SECCOMP or indirect branch restricted tasks
+  ====================  ========================================================
+
+  - Return stack buffer (RSB) protection status:
+
+  =============   ===========================================
+  'RSB filling'   Protection of RSB on context switch enabled
+  =============   ===========================================
+
+Full mitigation might require a microcode update from the CPU
+vendor. When the necessary microcode is not available, the kernel will
+report vulnerability.
+
+Turning on mitigation for Spectre variant 1 and Spectre variant 2
+-----------------------------------------------------------------
+
+1. Kernel mitigation
+^^^^^^^^^^^^^^^^^^^^
+
+Spectre variant 1
+~~~~~~~~~~~~~~~~~
+
+   For the Spectre variant 1, vulnerable kernel code (as determined
+   by code audit or scanning tools) is annotated on a case by case
+   basis to use nospec accessor macros for bounds clipping :ref:`[2]
+   <spec_ref2>` to avoid any usable disclosure gadgets. However, it may
+   not cover all attack vectors for Spectre variant 1.
+
+   Copy-from-user code has an LFENCE barrier to prevent the access_ok()
+   check from being mis-speculated.  The barrier is done by the
+   barrier_nospec() macro.
+
+   For the swapgs variant of Spectre variant 1, LFENCE barriers are
+   added to interrupt, exception and NMI entry where needed.  These
+   barriers are done by the FENCE_SWAPGS_KERNEL_ENTRY and
+   FENCE_SWAPGS_USER_ENTRY macros.
+
+Spectre variant 2
+~~~~~~~~~~~~~~~~~
+
+   For Spectre variant 2 mitigation, the compiler turns indirect calls or
+   jumps in the kernel into equivalent return trampolines (retpolines)
+   :ref:`[3] <spec_ref3>` :ref:`[9] <spec_ref9>` to go to the target
+   addresses.  Speculative execution paths under retpolines are trapped
+   in an infinite loop to prevent any speculative execution jumping to
+   a gadget.
+
+   To turn on retpoline mitigation on a vulnerable CPU, the kernel
+   needs to be compiled with a gcc compiler that supports the
+   -mindirect-branch=thunk-extern -mindirect-branch-register options.
+   If the kernel is compiled with a Clang compiler, the compiler needs
+   to support -mretpoline-external-thunk option.  The kernel config
+   CONFIG_RETPOLINE needs to be turned on, and the CPU needs to run with
+   the latest updated microcode.
+
+   On Intel Skylake-era systems the mitigation covers most, but not all,
+   cases. See :ref:`[3] <spec_ref3>` for more details.
+
+   On CPUs with hardware mitigation for Spectre variant 2 (e.g. Enhanced
+   IBRS on x86), retpoline is automatically disabled at run time.
+
+   The retpoline mitigation is turned on by default on vulnerable
+   CPUs. It can be forced on or off by the administrator
+   via the kernel command line and sysfs control files. See
+   :ref:`spectre_mitigation_control_command_line`.
+
+   On x86, indirect branch restricted speculation is turned on by default
+   before invoking any firmware code to prevent Spectre variant 2 exploits
+   using the firmware.
+
+   Using kernel address space randomization (CONFIG_RANDOMIZE_BASE=y
+   and CONFIG_SLAB_FREELIST_RANDOM=y in the kernel configuration) makes
+   attacks on the kernel generally more difficult.
+
+2. User program mitigation
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+   User programs can mitigate Spectre variant 1 using LFENCE or "bounds
+   clipping". For more details see :ref:`[2] <spec_ref2>`.
+
+   For Spectre variant 2 mitigation, individual user programs
+   can be compiled with return trampolines for indirect branches.
+   This protects them from consuming poisoned entries in the branch
+   target buffer left by malicious software.  Alternatively, the
+   programs can disable their indirect branch speculation via prctl()
+   (See Documentation/spec_ctrl.txt).
+   On x86, this will turn on STIBP to guard against attacks from the
+   sibling thread when the user program is running, and use IBPB to
+   flush the branch target buffer when switching to/from the program.
+
+   Restricting indirect branch speculation on a user program will
+   also prevent the program from launching a variant 2 attack
+   on x86.  All sand-boxed SECCOMP programs have indirect branch
+   speculation restricted by default.  Administrators can change
+   that behavior via the kernel command line and sysfs control files.
+   See :ref:`spectre_mitigation_control_command_line`.
+
+   Programs that disable their indirect branch speculation will have
+   more overhead and run slower.
+
+   User programs should use address space randomization
+   (/proc/sys/kernel/randomize_va_space = 1 or 2) to make attacks more
+   difficult.
+
+3. VM mitigation
+^^^^^^^^^^^^^^^^
+
+   Within the kernel, Spectre variant 1 attacks from rogue guests are
+   mitigated on a case by case basis in VM exit paths. Vulnerable code
+   uses nospec accessor macros for "bounds clipping", to avoid any
+   usable disclosure gadgets.  However, this may not cover all variant
+   1 attack vectors.
+
+   For Spectre variant 2 attacks from rogue guests to the kernel, the
+   Linux kernel uses retpoline or Enhanced IBRS to prevent consumption of
+   poisoned entries in branch target buffer left by rogue guests.  It also
+   flushes the return stack buffer on every VM exit to prevent a return
+   stack buffer underflow so poisoned branch target buffer could be used,
+   or attacker guests leaving poisoned entries in the return stack buffer.
+
+   To mitigate guest-to-guest attacks in the same CPU hardware thread,
+   the branch target buffer is sanitized by flushing before switching
+   to a new guest on a CPU.
+
+   The above mitigations are turned on by default on vulnerable CPUs.
+
+   To mitigate guest-to-guest attacks from sibling thread when SMT is
+   in use, an untrusted guest running in the sibling thread can have
+   its indirect branch speculation disabled by administrator via prctl().
+
+   The kernel also allows guests to use any microcode based mitigation
+   they choose to use (such as IBPB or STIBP on x86) to protect themselves.
+
+.. _spectre_mitigation_control_command_line:
+
+Mitigation control on the kernel command line
+---------------------------------------------
+
+Spectre variant 2 mitigation can be disabled or force enabled at the
+kernel command line.
+
+	nospectre_v1
+
+		[X86,PPC] Disable mitigations for Spectre Variant 1
+		(bounds check bypass). With this option data leaks are
+		possible in the system.
+
+	nospectre_v2
+
+		[X86] Disable all mitigations for the Spectre variant 2
+		(indirect branch prediction) vulnerability. System may
+		allow data leaks with this option, which is equivalent
+		to spectre_v2=off.
+
+
+        spectre_v2=
+
+		[X86] Control mitigation of Spectre variant 2
+		(indirect branch speculation) vulnerability.
+		The default operation protects the kernel from
+		user space attacks.
+
+		on
+			unconditionally enable, implies
+			spectre_v2_user=on
+		off
+			unconditionally disable, implies
+		        spectre_v2_user=off
+		auto
+			kernel detects whether your CPU model is
+		        vulnerable
+
+		Selecting 'on' will, and 'auto' may, choose a
+		mitigation method at run time according to the
+		CPU, the available microcode, the setting of the
+		CONFIG_RETPOLINE configuration option, and the
+		compiler with which the kernel was built.
+
+		Selecting 'on' will also enable the mitigation
+		against user space to user space task attacks.
+
+		Selecting 'off' will disable both the kernel and
+		the user space protections.
+
+		Specific mitigations can also be selected manually:
+
+                retpoline               auto pick between generic,lfence
+                retpoline,generic       Retpolines
+                retpoline,lfence        LFENCE; indirect branch
+                retpoline,amd           alias for retpoline,lfence
+                eibrs                   enhanced IBRS
+                eibrs,retpoline         enhanced IBRS + Retpolines
+                eibrs,lfence            enhanced IBRS + LFENCE
+
+		Not specifying this option is equivalent to
+		spectre_v2=auto.
+
+For user space mitigation:
+
+        spectre_v2_user=
+
+		[X86] Control mitigation of Spectre variant 2
+		(indirect branch speculation) vulnerability between
+		user space tasks
+
+		on
+			Unconditionally enable mitigations. Is
+			enforced by spectre_v2=on
+
+		off
+			Unconditionally disable mitigations. Is
+			enforced by spectre_v2=off
+
+		prctl
+			Indirect branch speculation is enabled,
+			but mitigation can be enabled via prctl
+			per thread. The mitigation control state
+			is inherited on fork.
+
+		prctl,ibpb
+			Like "prctl" above, but only STIBP is
+			controlled per thread. IBPB is issued
+			always when switching between different user
+			space processes.
+
+		seccomp
+			Same as "prctl" above, but all seccomp
+			threads will enable the mitigation unless
+			they explicitly opt out.
+
+		seccomp,ibpb
+			Like "seccomp" above, but only STIBP is
+			controlled per thread. IBPB is issued
+			always when switching between different
+			user space processes.
+
+		auto
+			Kernel selects the mitigation depending on
+			the available CPU features and vulnerability.
+
+		Default mitigation:
+		If CONFIG_SECCOMP=y then "seccomp", otherwise "prctl"
+
+		Not specifying this option is equivalent to
+		spectre_v2_user=auto.
+
+		In general the kernel by default selects
+		reasonable mitigations for the current CPU. To
+		disable Spectre variant 2 mitigations, boot with
+		spectre_v2=off. Spectre variant 1 mitigations
+		cannot be disabled.
+
+Mitigation selection guide
+--------------------------
+
+1. Trusted userspace
+^^^^^^^^^^^^^^^^^^^^
+
+   If all userspace applications are from trusted sources and do not
+   execute externally supplied untrusted code, then the mitigations can
+   be disabled.
+
+2. Protect sensitive programs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+   For security-sensitive programs that have secrets (e.g. crypto
+   keys), protection against Spectre variant 2 can be put in place by
+   disabling indirect branch speculation when the program is running
+   (See Documentation/spec_ctrl.txt).
+
+3. Sandbox untrusted programs
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+   Untrusted programs that could be a source of attacks can be cordoned
+   off by disabling their indirect branch speculation when they are run
+   (See Documentation/spec_ctrl.txt).
+   This prevents untrusted programs from polluting the branch target
+   buffer.  All programs running in SECCOMP sandboxes have indirect
+   branch speculation restricted by default. This behavior can be
+   changed via the kernel command line and sysfs control files. See
+   :ref:`spectre_mitigation_control_command_line`.
+
+3. High security mode
+^^^^^^^^^^^^^^^^^^^^^
+
+   All Spectre variant 2 mitigations can be forced on
+   at boot time for all programs (See the "on" option in
+   :ref:`spectre_mitigation_control_command_line`).  This will add
+   overhead as indirect branch speculations for all programs will be
+   restricted.
+
+   On x86, branch target buffer will be flushed with IBPB when switching
+   to a new program. STIBP is left on all the time to protect programs
+   against variant 2 attacks originating from programs running on
+   sibling threads.
+
+   Alternatively, STIBP can be used only when running programs
+   whose indirect branch speculation is explicitly disabled,
+   while IBPB is still used all the time when switching to a new
+   program to clear the branch target buffer (See "ibpb" option in
+   :ref:`spectre_mitigation_control_command_line`).  This "ibpb" option
+   has less performance cost than the "on" option, which leaves STIBP
+   on all the time.
+
+References on Spectre
+---------------------
+
+Intel white papers:
+
+.. _spec_ref1:
+
+[1] `Intel analysis of speculative execution side channels <https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/Intel-Analysis-of-Speculative-Execution-Side-Channels.pdf>`_.
+
+.. _spec_ref2:
+
+[2] `Bounds check bypass <https://software.intel.com/security-software-guidance/software-guidance/bounds-check-bypass>`_.
+
+.. _spec_ref3:
+
+[3] `Deep dive: Retpoline: A branch target injection mitigation <https://software.intel.com/security-software-guidance/insights/deep-dive-retpoline-branch-target-injection-mitigation>`_.
+
+.. _spec_ref4:
+
+[4] `Deep Dive: Single Thread Indirect Branch Predictors <https://software.intel.com/security-software-guidance/insights/deep-dive-single-thread-indirect-branch-predictors>`_.
+
+AMD white papers:
+
+.. _spec_ref5:
+
+[5] `AMD64 technology indirect branch control extension <https://developer.amd.com/wp-content/resources/Architecture_Guidelines_Update_Indirect_Branch_Control.pdf>`_.
+
+.. _spec_ref6:
+
+[6] `Software techniques for managing speculation on AMD processors <https://developer.amd.com/wp-content/resources/Managing-Speculation-on-AMD-Processors.pdf>`_.
+
+ARM white papers:
+
+.. _spec_ref7:
+
+[7] `Cache speculation side-channels <https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/download-the-whitepaper>`_.
+
+.. _spec_ref8:
+
+[8] `Cache speculation issues update <https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/latest-updates/cache-speculation-issues-update>`_.
+
+Google white paper:
+
+.. _spec_ref9:
+
+[9] `Retpoline: a software construct for preventing branch-target-injection <https://support.google.com/faqs/answer/7625886>`_.
+
+MIPS white paper:
+
+.. _spec_ref10:
+
+[10] `MIPS: response on speculative execution and side channel vulnerabilities <https://www.mips.com/blog/mips-response-on-speculative-execution-and-side-channel-vulnerabilities/>`_.
+
+Academic papers:
+
+.. _spec_ref11:
+
+[11] `Spectre Attacks: Exploiting Speculative Execution <https://spectreattack.com/spectre.pdf>`_.
+
+.. _spec_ref12:
+
+[12] `NetSpectre: Read Arbitrary Memory over Network <https://arxiv.org/abs/1807.10535>`_.
+
+.. _spec_ref13:
+
+[13] `Spectre Returns! Speculation Attacks using the Return Stack Buffer <https://www.usenix.org/system/files/conference/woot18/woot18-paper-koruyeh.pdf>`_.
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 713765521c45..f2b10986ab88 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -751,15 +751,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			loops can be debugged more effectively on production
 			systems.
 
-	clocksource.arm_arch_timer.fsl-a008585=
-			[ARM64]
-			Format: <bool>
-			Enable/disable the workaround of Freescale/NXP
-			erratum A-008585.  This can be useful for KVM
-			guests, if the guest device tree doesn't show the
-			erratum.  If unspecified, the workaround is
-			enabled based on the device tree.
-
 	clearcpuid=BITNUM [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
@@ -4174,8 +4165,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Specific mitigations can also be selected manually:
 
 			retpoline	  - replace indirect branches
-			retpoline,generic - google's original retpoline
-			retpoline,amd     - AMD-specific minimal thunk
+			retpoline,generic - Retpolines
+			retpoline,lfence  - LFENCE; indirect branch
+			retpoline,amd     - alias for retpoline,lfence
+			eibrs		  - enhanced IBRS
+			eibrs,retpoline   - enhanced IBRS + Retpolines
+			eibrs,lfence      - enhanced IBRS + LFENCE
 
 			Not specifying this option is equivalent to
 			spectre_v2=auto.
diff --git a/Makefile b/Makefile
index 27d5e129444e..a9f16c9c9614 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 303
+SUBLEVEL = 312
 EXTRAVERSION =
 NAME = Roaring Lionus
 
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 37ad245cf989..fb458623f386 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -191,6 +191,7 @@ tracesys_exit:
 	st  r0, [sp, PT_r0]     ; sys call return value in pt_regs
 
 	;POST Sys Call Ptrace Hook
+	mov r0, sp		; pt_regs needed
 	bl  @syscall_trace_exit
 	b   ret_from_exception ; NOT ret_from_system_call at is saves r0 which
 	; we'd done before calling post hook above
diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index 2f6ab32b5954..7bb09532840f 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -257,7 +257,7 @@
 	};
 
 	uart3_data: uart3-data {
-		samsung,pins = "gpa1-4", "gpa1-4";
+		samsung,pins = "gpa1-4", "gpa1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index f0906d67a107..54e79f6887ff 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -118,6 +118,9 @@
 
 &hdmi {
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
+	vdd-supply = <&ldo8_reg>;
+	vdd_osc-supply = <&ldo10_reg>;
+	vdd_pll-supply = <&ldo8_reg>;
 };
 
 &i2c_0 {
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index aaccd0da41e5..5ab719cf69dd 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -134,6 +134,9 @@
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_hpd_irq>;
+	vdd-supply = <&ldo6_reg>;
+	vdd_osc-supply = <&ldo7_reg>;
+	vdd_pll-supply = <&ldo6_reg>;
 };
 
 &hsi2c_4 {
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 5ee84e3cb3e9..1fd63f485d3b 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -93,7 +93,8 @@
 	clocks {
 		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32768>;
+			clock-frequency = <32000>;
+			clock-output-names = "gcc_sleep_clk_src";
 			#clock-cells = <0>;
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 288f56e0ccf5..819d0f085f8c 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -139,7 +139,9 @@
 			reg		= <0x108000 0x1000>;
 			qcom,ipc	= <&l2cc 0x8 2>;
 
-			interrupts	= <0 19 0>, <0 21 0>, <0 22 0>;
+			interrupts	= <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+					  <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+					  <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names	= "ack", "err", "wakeup";
 
 			regulators {
@@ -185,7 +187,7 @@
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16440000 0x1000>,
 				      <0x16400000 0x1000>;
-				interrupts = <0 154 0x0>;
+				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
 				clock-names = "core", "iface";
 				status = "disabled";
@@ -311,7 +313,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0x16080000 0x1000>;
-				interrupts = <0 147 0>;
+				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 				spi-max-frequency = <24000000>;
 				cs-gpios = <&msmgpio 8 0>;
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 7b727d738b69..4702aa980ef8 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -918,7 +918,7 @@
 		status = "disabled";
 	};
 
-	crypto: cypto-controller@ff8a0000 {
+	crypto: crypto@ff8a0000 {
 		compatible = "rockchip,rk3288-crypto";
 		reg = <0xff8a0000 0x4000>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 6361cbfcbe5e..ece38b8c450d 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -141,9 +141,9 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 12 0 1>,
-					<&dwdma0 13 1 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 13 0 1>,
+					<&dwdma0 12 1 0>;
+				dma-names = "rx", "tx";
 			};
 
 			thermal@e07008c4 {
diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 9564337c1815..45f5bd8d30f0 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -288,9 +288,9 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 4 0 0>,
-					<&dwdma0 5 0 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 5 0 0>,
+					<&dwdma0 4 0 0>;
+				dma-names = "rx", "tx";
 			};
 
 			rtc@e0580000 {
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index a613e3b85b45..29769bf7a11a 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -182,8 +182,8 @@
 			};
 			conf_ata {
 				nvidia,pins = "ata", "atb", "atc", "atd", "ate",
-					"cdev1", "cdev2", "dap1", "dtb", "gma",
-					"gmb", "gmc", "gmd", "gme", "gpu7",
+					"cdev1", "cdev2", "dap1", "dtb", "dtf",
+					"gma", "gmb", "gmc", "gmd", "gme", "gpu7",
 					"gpv", "i2cp", "irrx", "irtx", "pta",
 					"rm", "slxa", "slxk", "spia", "spib",
 					"uac";
@@ -202,7 +202,7 @@
 			};
 			conf_crtp {
 				nvidia,pins = "crtp", "dap2", "dap3", "dap4",
-					"dtc", "dte", "dtf", "gpu", "sdio1",
+					"dtc", "dte", "gpu", "sdio1",
 					"slxc", "slxd", "spdi", "spdo", "spig",
 					"uda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 7d727506096f..2fa3fd30a9d6 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -108,6 +108,16 @@
 	.endm
 #endif
 
+#if __LINUX_ARM_ARCH__ < 7
+	.macro	dsb, args
+	mcr	p15, 0, r0, c7, c10, 4
+	.endm
+
+	.macro	isb, args
+	mcr	p15, 0, r0, c7, c5, 4
+	.endm
+#endif
+
 	.macro asm_trace_hardirqs_off, save=1
 #if defined(CONFIG_TRACE_IRQFLAGS)
 	.if \save
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 2fda7e905754..82c71a147f21 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -349,4 +349,9 @@ static inline int kvm_arm_have_ssbd(void)
 	return KVM_SSBD_UNKNOWN;
 }
 
+static inline bool kvm_arm_spectre_bhb_mitigated(void)
+{
+	/* 32bit guests don't need firmware for this */
+	return false;
+}
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/include/asm/spectre.h b/arch/arm/include/asm/spectre.h
new file mode 100644
index 000000000000..85f9e538fb32
--- /dev/null
+++ b/arch/arm/include/asm/spectre.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_SPECTRE_H
+#define __ASM_SPECTRE_H
+
+enum {
+	SPECTRE_UNAFFECTED,
+	SPECTRE_MITIGATED,
+	SPECTRE_VULNERABLE,
+};
+
+enum {
+	__SPECTRE_V2_METHOD_BPIALL,
+	__SPECTRE_V2_METHOD_ICIALLU,
+	__SPECTRE_V2_METHOD_SMC,
+	__SPECTRE_V2_METHOD_HVC,
+	__SPECTRE_V2_METHOD_LOOP8,
+};
+
+enum {
+	SPECTRE_V2_METHOD_BPIALL = BIT(__SPECTRE_V2_METHOD_BPIALL),
+	SPECTRE_V2_METHOD_ICIALLU = BIT(__SPECTRE_V2_METHOD_ICIALLU),
+	SPECTRE_V2_METHOD_SMC = BIT(__SPECTRE_V2_METHOD_SMC),
+	SPECTRE_V2_METHOD_HVC = BIT(__SPECTRE_V2_METHOD_HVC),
+	SPECTRE_V2_METHOD_LOOP8 = BIT(__SPECTRE_V2_METHOD_LOOP8),
+};
+
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
+void spectre_v2_update_state(unsigned int state, unsigned int methods);
+#else
+static inline void spectre_v2_update_state(unsigned int state,
+					   unsigned int methods)
+{}
+#endif
+
+int spectre_bhb_update_vectors(unsigned int method);
+
+#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 9bddd762880c..1738d5b61eaa 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -100,4 +100,6 @@ endif
 
 obj-$(CONFIG_HAVE_ARM_SMCCC)	+= smccc-call.o
 
+obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += spectre.o
+
 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d723548b461c..4a554d1c45c1 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1049,12 +1049,11 @@ vector_\name:
 	sub	lr, lr, #\correction
 	.endif
 
-	@
-	@ Save r0, lr_<exception> (parent PC) and spsr_<exception>
-	@ (parent CPSR)
-	@
+	@ Save r0, lr_<exception> (parent PC)
 	stmia	sp, {r0, lr}		@ save r0, lr
-	mrs	lr, spsr
+
+	@ Save spsr_<exception> (parent CPSR)
+2:	mrs	lr, spsr
 	str	lr, [sp, #8]		@ save spsr
 
 	@
@@ -1075,6 +1074,44 @@ vector_\name:
 	movs	pc, lr			@ branch to handler in SVC mode
 ENDPROC(vector_\name)
 
+#ifdef CONFIG_HARDEN_BRANCH_HISTORY
+	.subsection 1
+	.align 5
+vector_bhb_loop8_\name:
+	.if \correction
+	sub	lr, lr, #\correction
+	.endif
+
+	@ Save r0, lr_<exception> (parent PC)
+	stmia	sp, {r0, lr}
+
+	@ bhb workaround
+	mov	r0, #8
+3:	b	. + 4
+	subs	r0, r0, #1
+	bne	3b
+	dsb
+	isb
+	b	2b
+ENDPROC(vector_bhb_loop8_\name)
+
+vector_bhb_bpiall_\name:
+	.if \correction
+	sub	lr, lr, #\correction
+	.endif
+
+	@ Save r0, lr_<exception> (parent PC)
+	stmia	sp, {r0, lr}
+
+	@ bhb workaround
+	mcr	p15, 0, r0, c7, c5, 6	@ BPIALL
+	@ isb not needed due to "movs pc, lr" in the vector stub
+	@ which gives a "context synchronisation".
+	b	2b
+ENDPROC(vector_bhb_bpiall_\name)
+	.previous
+#endif
+
 	.align	2
 	@ handler addresses follow this label
 1:
@@ -1083,6 +1120,10 @@ ENDPROC(vector_\name)
 	.section .stubs, "ax", %progbits
 	@ This must be the first word
 	.word	vector_swi
+#ifdef CONFIG_HARDEN_BRANCH_HISTORY
+	.word	vector_bhb_loop8_swi
+	.word	vector_bhb_bpiall_swi
+#endif
 
 vector_rst:
  ARM(	swi	SYS_ERROR0	)
@@ -1197,8 +1238,10 @@ vector_addrexcptn:
  * FIQ "NMI" handler
  *-----------------------------------------------------------------------------
  * Handle a FIQ using the SVC stack allowing FIQ act like NMI on x86
- * systems.
+ * systems. This must be the last vector stub, so lets place it in its own
+ * subsection.
  */
+	.subsection 2
 	vector_stub	fiq, FIQ_MODE, 4
 
 	.long	__fiq_usr			@  0  (USR_26 / USR_32)
@@ -1231,6 +1274,30 @@ vector_addrexcptn:
 	W(b)	vector_irq
 	W(b)	vector_fiq
 
+#ifdef CONFIG_HARDEN_BRANCH_HISTORY
+	.section .vectors.bhb.loop8, "ax", %progbits
+.L__vectors_bhb_loop8_start:
+	W(b)	vector_rst
+	W(b)	vector_bhb_loop8_und
+	W(ldr)	pc, .L__vectors_bhb_loop8_start + 0x1004
+	W(b)	vector_bhb_loop8_pabt
+	W(b)	vector_bhb_loop8_dabt
+	W(b)	vector_addrexcptn
+	W(b)	vector_bhb_loop8_irq
+	W(b)	vector_bhb_loop8_fiq
+
+	.section .vectors.bhb.bpiall, "ax", %progbits
+.L__vectors_bhb_bpiall_start:
+	W(b)	vector_rst
+	W(b)	vector_bhb_bpiall_und
+	W(ldr)	pc, .L__vectors_bhb_bpiall_start + 0x1008
+	W(b)	vector_bhb_bpiall_pabt
+	W(b)	vector_bhb_bpiall_dabt
+	W(b)	vector_addrexcptn
+	W(b)	vector_bhb_bpiall_irq
+	W(b)	vector_bhb_bpiall_fiq
+#endif
+
 	.data
 
 	.globl	cr_alignment
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 97a93bd9e63d..8799dae53f74 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -147,6 +147,29 @@ ENDPROC(ret_from_fork)
  *-----------------------------------------------------------------------------
  */
 
+	.align	5
+#ifdef CONFIG_HARDEN_BRANCH_HISTORY
+ENTRY(vector_bhb_loop8_swi)
+	sub	sp, sp, #PT_REGS_SIZE
+	stmia	sp, {r0 - r12}
+	mov	r8, #8
+1:	b	2f
+2:	subs	r8, r8, #1
+	bne	1b
+	dsb
+	isb
+	b	3f
+ENDPROC(vector_bhb_loop8_swi)
+
+	.align	5
+ENTRY(vector_bhb_bpiall_swi)
+	sub	sp, sp, #PT_REGS_SIZE
+	stmia	sp, {r0 - r12}
+	mcr	p15, 0, r8, c7, c5, 6	@ BPIALL
+	isb
+	b	3f
+ENDPROC(vector_bhb_bpiall_swi)
+#endif
 	.align	5
 ENTRY(vector_swi)
 #ifdef CONFIG_CPU_V7M
@@ -154,6 +177,7 @@ ENTRY(vector_swi)
 #else
 	sub	sp, sp, #PT_REGS_SIZE
 	stmia	sp, {r0 - r12}			@ Calling r0 - r12
+3:
  ARM(	add	r8, sp, #S_PC		)
  ARM(	stmdb	r8, {sp, lr}^		)	@ Calling sp, lr
  THUMB(	mov	r8, sp			)
diff --git a/arch/arm/kernel/spectre.c b/arch/arm/kernel/spectre.c
new file mode 100644
index 000000000000..0dcefc36fb7a
--- /dev/null
+++ b/arch/arm/kernel/spectre.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bpf.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+
+#include <asm/spectre.h>
+
+static bool _unprivileged_ebpf_enabled(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	return !sysctl_unprivileged_bpf_disabled;
+#else
+	return false;
+#endif
+}
+
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}
+
+static unsigned int spectre_v2_state;
+static unsigned int spectre_v2_methods;
+
+void spectre_v2_update_state(unsigned int state, unsigned int method)
+{
+	if (state > spectre_v2_state)
+		spectre_v2_state = state;
+	spectre_v2_methods |= method;
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	const char *method;
+
+	if (spectre_v2_state == SPECTRE_UNAFFECTED)
+		return sprintf(buf, "%s\n", "Not affected");
+
+	if (spectre_v2_state != SPECTRE_MITIGATED)
+		return sprintf(buf, "%s\n", "Vulnerable");
+
+	if (_unprivileged_ebpf_enabled())
+		return sprintf(buf, "Vulnerable: Unprivileged eBPF enabled\n");
+
+	switch (spectre_v2_methods) {
+	case SPECTRE_V2_METHOD_BPIALL:
+		method = "Branch predictor hardening";
+		break;
+
+	case SPECTRE_V2_METHOD_ICIALLU:
+		method = "I-cache invalidation";
+		break;
+
+	case SPECTRE_V2_METHOD_SMC:
+	case SPECTRE_V2_METHOD_HVC:
+		method = "Firmware call";
+		break;
+
+	case SPECTRE_V2_METHOD_LOOP8:
+		method = "History overwrite";
+		break;
+
+	default:
+		method = "Multiple mitigations";
+		break;
+	}
+
+	return sprintf(buf, "Mitigation: %s\n", method);
+}
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index aa316a7562b1..7fca7ece8f97 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
 #include <asm/exception.h>
+#include <asm/spectre.h>
 #include <asm/unistd.h>
 #include <asm/traps.h>
 #include <asm/ptrace.h>
@@ -819,10 +820,59 @@ static inline void __init kuser_init(void *vectors)
 }
 #endif
 
+#ifndef CONFIG_CPU_V7M
+static void copy_from_lma(void *vma, void *lma_start, void *lma_end)
+{
+	memcpy(vma, lma_start, lma_end - lma_start);
+}
+
+static void flush_vectors(void *vma, size_t offset, size_t size)
+{
+	unsigned long start = (unsigned long)vma + offset;
+	unsigned long end = start + size;
+
+	flush_icache_range(start, end);
+}
+
+#ifdef CONFIG_HARDEN_BRANCH_HISTORY
+int spectre_bhb_update_vectors(unsigned int method)
+{
+	extern char __vectors_bhb_bpiall_start[], __vectors_bhb_bpiall_end[];
+	extern char __vectors_bhb_loop8_start[], __vectors_bhb_loop8_end[];
+	void *vec_start, *vec_end;
+
+	if (system_state >= SYSTEM_RUNNING) {
+		pr_err("CPU%u: Spectre BHB workaround too late - system vulnerable\n",
+		       smp_processor_id());
+		return SPECTRE_VULNERABLE;
+	}
+
+	switch (method) {
+	case SPECTRE_V2_METHOD_LOOP8:
+		vec_start = __vectors_bhb_loop8_start;
+		vec_end = __vectors_bhb_loop8_end;
+		break;
+
+	case SPECTRE_V2_METHOD_BPIALL:
+		vec_start = __vectors_bhb_bpiall_start;
+		vec_end = __vectors_bhb_bpiall_end;
+		break;
+
+	default:
+		pr_err("CPU%u: unknown Spectre BHB state %d\n",
+		       smp_processor_id(), method);
+		return SPECTRE_VULNERABLE;
+	}
+
+	copy_from_lma(vectors_page, vec_start, vec_end);
+	flush_vectors(vectors_page, 0, vec_end - vec_start);
+
+	return SPECTRE_MITIGATED;
+}
+#endif
+
 void __init early_trap_init(void *vectors_base)
 {
-#ifndef CONFIG_CPU_V7M
-	unsigned long vectors = (unsigned long)vectors_base;
 	extern char __stubs_start[], __stubs_end[];
 	extern char __vectors_start[], __vectors_end[];
 	unsigned i;
@@ -843,17 +893,20 @@ void __init early_trap_init(void *vectors_base)
 	 * into the vector page, mapped at 0xffff0000, and ensure these
 	 * are visible to the instruction stream.
 	 */
-	memcpy((void *)vectors, __vectors_start, __vectors_end - __vectors_start);
-	memcpy((void *)vectors + 0x1000, __stubs_start, __stubs_end - __stubs_start);
+	copy_from_lma(vectors_base, __vectors_start, __vectors_end);
+	copy_from_lma(vectors_base + 0x1000, __stubs_start, __stubs_end);
 
 	kuser_init(vectors_base);
 
-	flush_icache_range(vectors, vectors + PAGE_SIZE * 2);
+	flush_vectors(vectors_base, 0, PAGE_SIZE * 2);
+}
 #else /* ifndef CONFIG_CPU_V7M */
+void __init early_trap_init(void *vectors_base)
+{
 	/*
 	 * on V7-M there is no need to copy the vector table to a dedicated
 	 * memory area. The address is configurable and so a table in the kernel
 	 * image can be used.
 	 */
-#endif
 }
+#endif
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 37b2a11af345..d80ef8c2bb46 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -12,6 +12,19 @@
 #include <asm/memory.h>
 #include <asm/page.h>
 
+/*
+ * ld.lld does not support NOCROSSREFS:
+ * https://github.com/ClangBuiltLinux/linux/issues/1609
+ */
+#ifdef CONFIG_LD_IS_LLD
+#define NOCROSSREFS
+#endif
+
+/* Set start/end symbol names to the LMA for the section */
+#define ARM_LMA(sym, section)						\
+	sym##_start = LOADADDR(section);				\
+	sym##_end = LOADADDR(section) + SIZEOF(section)
+
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
@@ -148,19 +161,31 @@ SECTIONS
 	 * The vectors and stubs are relocatable code, and the
 	 * only thing that matters is their relative offsets
 	 */
-	__vectors_start = .;
-	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+	__vectors_lma = .;
+	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {
+		.vectors {
+			*(.vectors)
+		}
+		.vectors.bhb.loop8 {
+			*(.vectors.bhb.loop8)
+		}
+		.vectors.bhb.bpiall {
+			*(.vectors.bhb.bpiall)
+		}
 	}
-	. = __vectors_start + SIZEOF(.vectors);
-	__vectors_end = .;
-
-	__stubs_start = .;
-	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
+	ARM_LMA(__vectors, .vectors);
+	ARM_LMA(__vectors_bhb_loop8, .vectors.bhb.loop8);
+	ARM_LMA(__vectors_bhb_bpiall, .vectors.bhb.bpiall);
+	. = __vectors_lma + SIZEOF(.vectors) +
+		SIZEOF(.vectors.bhb.loop8) +
+		SIZEOF(.vectors.bhb.bpiall);
+
+	__stubs_lma = .;
+	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_lma) {
 		*(.stubs)
 	}
-	. = __stubs_start + SIZEOF(.stubs);
-	__stubs_end = .;
+	ARM_LMA(__stubs, .stubs);
+	. = __stubs_lma + SIZEOF(.stubs);
 
 	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index f7f55df0bf7b..0d560a24408f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -14,6 +14,19 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
+/*
+ * ld.lld does not support NOCROSSREFS:
+ * https://github.com/ClangBuiltLinux/linux/issues/1609
+ */
+#ifdef CONFIG_LD_IS_LLD
+#define NOCROSSREFS
+#endif
+
+/* Set start/end symbol names to the LMA for the section */
+#define ARM_LMA(sym, section)						\
+	sym##_start = LOADADDR(section);				\
+	sym##_end = LOADADDR(section) + SIZEOF(section)
+
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
@@ -169,19 +182,31 @@ SECTIONS
 	 * The vectors and stubs are relocatable code, and the
 	 * only thing that matters is their relative offsets
 	 */
-	__vectors_start = .;
-	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+	__vectors_lma = .;
+	OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) {
+		.vectors {
+			*(.vectors)
+		}
+		.vectors.bhb.loop8 {
+			*(.vectors.bhb.loop8)
+		}
+		.vectors.bhb.bpiall {
+			*(.vectors.bhb.bpiall)
+		}
 	}
-	. = __vectors_start + SIZEOF(.vectors);
-	__vectors_end = .;
-
-	__stubs_start = .;
-	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
+	ARM_LMA(__vectors, .vectors);
+	ARM_LMA(__vectors_bhb_loop8, .vectors.bhb.loop8);
+	ARM_LMA(__vectors_bhb_bpiall, .vectors.bhb.bpiall);
+	. = __vectors_lma + SIZEOF(.vectors) +
+		SIZEOF(.vectors.bhb.loop8) +
+		SIZEOF(.vectors.bhb.bpiall);
+
+	__stubs_lma = .;
+	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_lma) {
 		*(.stubs)
 	}
-	. = __stubs_start + SIZEOF(.stubs);
-	__stubs_end = .;
+	ARM_LMA(__stubs, .stubs);
+	. = __stubs_lma + SIZEOF(.stubs);
 
 	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
 
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 83365bec04b6..a262c175456d 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -431,6 +431,10 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 				break;
 			}
 			break;
+		case ARM_SMCCC_ARCH_WORKAROUND_3:
+			if (kvm_arm_spectre_bhb_mitigated())
+				val = SMCCC_RET_SUCCESS;
+			break;
 		}
 		break;
 	default:
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 3bdf0d588238..5deafd26c709 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1043,11 +1043,13 @@ static int __init da850_evm_config_emac(void)
 	int ret;
 	u32 val;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	u8 rmii_en = soc_info->emac_pdata->rmii_en;
+	u8 rmii_en;
 
 	if (!machine_is_davinci_da850_evm())
 		return 0;
 
+	rmii_en = soc_info->emac_pdata->rmii_en;
+
 	cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
 
 	val = __raw_readl(cfg_chip3_base);
diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index bf5e64906e65..a41162dc4af4 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -75,6 +75,8 @@ static int sram_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, info);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "no memory resource defined\n");
@@ -110,8 +112,6 @@ static int sram_probe(struct platform_device *pdev)
 	list_add(&info->node, &sram_bank_list);
 	mutex_unlock(&sram_lock);
 
-	platform_set_drvdata(pdev, info);
-
 	dev_info(&pdev->dev, "initialized\n");
 	return 0;
 
@@ -130,17 +130,19 @@ static int sram_remove(struct platform_device *pdev)
 	struct sram_bank_info *info;
 
 	info = platform_get_drvdata(pdev);
-	if (info == NULL)
-		return -ENODEV;
 
-	mutex_lock(&sram_lock);
-	list_del(&info->node);
-	mutex_unlock(&sram_lock);
+	if (info->sram_size) {
+		mutex_lock(&sram_lock);
+		list_del(&info->node);
+		mutex_unlock(&sram_lock);
+
+		gen_pool_destroy(info->gpool);
+		iounmap(info->sram_virt);
+		kfree(info->pool_name);
+	}
 
-	gen_pool_destroy(info->gpool);
-	iounmap(info->sram_virt);
-	kfree(info->pool_name);
 	kfree(info);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 7d99fe8f6157..5d43733ee7d6 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -240,11 +240,11 @@ static int __init jive_mtdset(char *options)
 	unsigned long set;
 
 	if (options == NULL || options[0] == '\0')
-		return 0;
+		return 1;
 
 	if (kstrtoul(options, 10, &set)) {
 		printk(KERN_ERR "failed to parse mtdset=%s\n", options);
-		return 0;
+		return 1;
 	}
 
 	switch (set) {
@@ -259,7 +259,7 @@ static int __init jive_mtdset(char *options)
 		       "using default.", set);
 	}
 
-	return 0;
+	return 1;
 }
 
 /* parse the mtdset= option given to the kernel command line */
diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 635b0d549487..c16f39614003 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -584,7 +584,7 @@ static int __init ve_spc_clk_init(void)
 		}
 
 		cluster = topology_physical_package_id(cpu_dev->id);
-		if (init_opp_table[cluster])
+		if (cluster < 0 || init_opp_table[cluster])
 			continue;
 
 		if (ve_init_opp_table(cpu_dev))
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 93623627a0b6..5c98074010d2 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -803,6 +803,7 @@ config CPU_BPREDICT_DISABLE
 
 config CPU_SPECTRE
 	bool
+	select GENERIC_CPU_VULNERABILITIES
 
 config HARDEN_BRANCH_PREDICTOR
 	bool "Harden the branch predictor against aliasing attacks" if EXPERT
@@ -823,6 +824,16 @@ config HARDEN_BRANCH_PREDICTOR
 
 	   If unsure, say Y.
 
+config HARDEN_BRANCH_HISTORY
+	bool "Harden Spectre style attacks against branch history" if EXPERT
+	depends on CPU_SPECTRE
+	default y
+	help
+	  Speculation attacks against some high-performance processors can
+	  make use of branch history to influence future speculation. When
+	  taking an exception, a sequence of branches overwrites the branch
+	  history, or branch history is invalidated.
+
 config TLS_REG_EMUL
 	bool
 	select NEED_KUSER_HELPERS
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 7edc6c3f4bd9..a99e7ebcd004 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -228,12 +228,14 @@ early_param("ecc", early_ecc);
 static int __init early_cachepolicy(char *p)
 {
 	pr_warn("cachepolicy kernel parameter not supported without cp15\n");
+	return 0;
 }
 early_param("cachepolicy", early_cachepolicy);
 
 static int __init noalign_setup(char *__unused)
 {
 	pr_warn("noalign kernel parameter not supported without cp15\n");
+	return 1;
 }
 __setup("noalign", noalign_setup);
 
diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 9a07916af8dd..1b6e770bc1cd 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -7,8 +7,36 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/proc-fns.h>
+#include <asm/spectre.h>
 #include <asm/system_misc.h>
 
+#ifdef CONFIG_ARM_PSCI
+#define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
+static int __maybe_unused spectre_v2_get_cpu_fw_mitigation_state(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+			     ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+
+	switch ((int)res.a0) {
+	case SMCCC_RET_SUCCESS:
+		return SPECTRE_MITIGATED;
+
+	case SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED:
+		return SPECTRE_UNAFFECTED;
+
+	default:
+		return SPECTRE_VULNERABLE;
+	}
+}
+#else
+static int __maybe_unused spectre_v2_get_cpu_fw_mitigation_state(void)
+{
+	return SPECTRE_VULNERABLE;
+}
+#endif
+
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 DEFINE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
 
@@ -37,13 +65,61 @@ static void __maybe_unused call_hvc_arch_workaround_1(void)
 	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
 }
 
-static void cpu_v7_spectre_init(void)
+static unsigned int spectre_v2_install_workaround(unsigned int method)
 {
 	const char *spectre_v2_method = NULL;
 	int cpu = smp_processor_id();
 
 	if (per_cpu(harden_branch_predictor_fn, cpu))
-		return;
+		return SPECTRE_MITIGATED;
+
+	switch (method) {
+	case SPECTRE_V2_METHOD_BPIALL:
+		per_cpu(harden_branch_predictor_fn, cpu) =
+			harden_branch_predictor_bpiall;
+		spectre_v2_method = "BPIALL";
+		break;
+
+	case SPECTRE_V2_METHOD_ICIALLU:
+		per_cpu(harden_branch_predictor_fn, cpu) =
+			harden_branch_predictor_iciallu;
+		spectre_v2_method = "ICIALLU";
+		break;
+
+	case SPECTRE_V2_METHOD_HVC:
+		per_cpu(harden_branch_predictor_fn, cpu) =
+			call_hvc_arch_workaround_1;
+		cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
+		spectre_v2_method = "hypervisor";
+		break;
+
+	case SPECTRE_V2_METHOD_SMC:
+		per_cpu(harden_branch_predictor_fn, cpu) =
+			call_smc_arch_workaround_1;
+		cpu_do_switch_mm = cpu_v7_smc_switch_mm;
+		spectre_v2_method = "firmware";
+		break;
+	}
+
+	if (spectre_v2_method)
+		pr_info("CPU%u: Spectre v2: using %s workaround\n",
+			smp_processor_id(), spectre_v2_method);
+
+	return SPECTRE_MITIGATED;
+}
+#else
+static unsigned int spectre_v2_install_workaround(unsigned int method)
+{
+	pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n",
+		smp_processor_id());
+
+	return SPECTRE_VULNERABLE;
+}
+#endif
+
+static void cpu_v7_spectre_v2_init(void)
+{
+	unsigned int state, method = 0;
 
 	switch (read_cpuid_part()) {
 	case ARM_CPU_PART_CORTEX_A8:
@@ -52,29 +128,32 @@ static void cpu_v7_spectre_init(void)
 	case ARM_CPU_PART_CORTEX_A17:
 	case ARM_CPU_PART_CORTEX_A73:
 	case ARM_CPU_PART_CORTEX_A75:
-		per_cpu(harden_branch_predictor_fn, cpu) =
-			harden_branch_predictor_bpiall;
-		spectre_v2_method = "BPIALL";
+		state = SPECTRE_MITIGATED;
+		method = SPECTRE_V2_METHOD_BPIALL;
 		break;
 
 	case ARM_CPU_PART_CORTEX_A15:
 	case ARM_CPU_PART_BRAHMA_B15:
-		per_cpu(harden_branch_predictor_fn, cpu) =
-			harden_branch_predictor_iciallu;
-		spectre_v2_method = "ICIALLU";
+		state = SPECTRE_MITIGATED;
+		method = SPECTRE_V2_METHOD_ICIALLU;
 		break;
 
-#ifdef CONFIG_ARM_PSCI
 	default:
 		/* Other ARM CPUs require no workaround */
-		if (read_cpuid_implementor() == ARM_CPU_IMP_ARM)
+		if (read_cpuid_implementor() == ARM_CPU_IMP_ARM) {
+			state = SPECTRE_UNAFFECTED;
 			break;
+		}
 		/* fallthrough */
-		/* Cortex A57/A72 require firmware workaround */
+	/* Cortex A57/A72 require firmware workaround */
 	case ARM_CPU_PART_CORTEX_A57:
 	case ARM_CPU_PART_CORTEX_A72: {
 		struct arm_smccc_res res;
 
+		state = spectre_v2_get_cpu_fw_mitigation_state();
+		if (state != SPECTRE_MITIGATED)
+			break;
+
 		if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
 			break;
 
@@ -84,10 +163,7 @@ static void cpu_v7_spectre_init(void)
 					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 			if ((int)res.a0 != 0)
 				break;
-			per_cpu(harden_branch_predictor_fn, cpu) =
-				call_hvc_arch_workaround_1;
-			cpu_do_switch_mm = cpu_v7_hvc_switch_mm;
-			spectre_v2_method = "hypervisor";
+			method = SPECTRE_V2_METHOD_HVC;
 			break;
 
 		case PSCI_CONDUIT_SMC:
@@ -95,29 +171,97 @@ static void cpu_v7_spectre_init(void)
 					  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 			if ((int)res.a0 != 0)
 				break;
-			per_cpu(harden_branch_predictor_fn, cpu) =
-				call_smc_arch_workaround_1;
-			cpu_do_switch_mm = cpu_v7_smc_switch_mm;
-			spectre_v2_method = "firmware";
+			method = SPECTRE_V2_METHOD_SMC;
 			break;
 
 		default:
+			state = SPECTRE_VULNERABLE;
 			break;
 		}
 	}
-#endif
 	}
 
-	if (spectre_v2_method)
-		pr_info("CPU%u: Spectre v2: using %s workaround\n",
-			smp_processor_id(), spectre_v2_method);
+	if (state == SPECTRE_MITIGATED)
+		state = spectre_v2_install_workaround(method);
+
+	spectre_v2_update_state(state, method);
+}
+
+#ifdef CONFIG_HARDEN_BRANCH_HISTORY
+static int spectre_bhb_method;
+
+static const char *spectre_bhb_method_name(int method)
+{
+	switch (method) {
+	case SPECTRE_V2_METHOD_LOOP8:
+		return "loop";
+
+	case SPECTRE_V2_METHOD_BPIALL:
+		return "BPIALL";
+
+	default:
+		return "unknown";
+	}
+}
+
+static int spectre_bhb_install_workaround(int method)
+{
+	if (spectre_bhb_method != method) {
+		if (spectre_bhb_method) {
+			pr_err("CPU%u: Spectre BHB: method disagreement, system vulnerable\n",
+			       smp_processor_id());
+
+			return SPECTRE_VULNERABLE;
+		}
+
+		if (spectre_bhb_update_vectors(method) == SPECTRE_VULNERABLE)
+			return SPECTRE_VULNERABLE;
+
+		spectre_bhb_method = method;
+	}
+
+	pr_info("CPU%u: Spectre BHB: using %s workaround\n",
+		smp_processor_id(), spectre_bhb_method_name(method));
+
+	return SPECTRE_MITIGATED;
 }
 #else
-static void cpu_v7_spectre_init(void)
+static int spectre_bhb_install_workaround(int method)
 {
+	return SPECTRE_VULNERABLE;
 }
 #endif
 
+static void cpu_v7_spectre_bhb_init(void)
+{
+	unsigned int state, method = 0;
+
+	switch (read_cpuid_part()) {
+	case ARM_CPU_PART_CORTEX_A15:
+	case ARM_CPU_PART_BRAHMA_B15:
+	case ARM_CPU_PART_CORTEX_A57:
+	case ARM_CPU_PART_CORTEX_A72:
+		state = SPECTRE_MITIGATED;
+		method = SPECTRE_V2_METHOD_LOOP8;
+		break;
+
+	case ARM_CPU_PART_CORTEX_A73:
+	case ARM_CPU_PART_CORTEX_A75:
+		state = SPECTRE_MITIGATED;
+		method = SPECTRE_V2_METHOD_BPIALL;
+		break;
+
+	default:
+		state = SPECTRE_UNAFFECTED;
+		break;
+	}
+
+	if (state == SPECTRE_MITIGATED)
+		state = spectre_bhb_install_workaround(method);
+
+	spectre_v2_update_state(state, method);
+}
+
 static __maybe_unused bool cpu_v7_check_auxcr_set(bool *warned,
 						  u32 mask, const char *msg)
 {
@@ -146,16 +290,17 @@ static bool check_spectre_auxcr(bool *warned, u32 bit)
 void cpu_v7_ca8_ibe(void)
 {
 	if (check_spectre_auxcr(this_cpu_ptr(&spectre_warned), BIT(6)))
-		cpu_v7_spectre_init();
+		cpu_v7_spectre_v2_init();
 }
 
 void cpu_v7_ca15_ibe(void)
 {
 	if (check_spectre_auxcr(this_cpu_ptr(&spectre_warned), BIT(0)))
-		cpu_v7_spectre_init();
+		cpu_v7_spectre_v2_init();
 }
 
 void cpu_v7_bugs_init(void)
 {
-	cpu_v7_spectre_init();
+	cpu_v7_spectre_v2_init();
+	cpu_v7_spectre_bhb_init();
 }
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a478cfbd400b..fa4a8fe0c935 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -442,6 +442,20 @@ config ARM64_ERRATUM_1024718
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1188873
+	bool "Cortex-A76: MRC read following MRRC read of specific Generic Timer in AArch32 might give incorrect result"
+	default y
+	depends on COMPAT
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
+	help
+	  This option adds work arounds for ARM Cortex-A76 erratum 1188873
+
+	  Affected Cortex-A76 cores (r0p0, r1p0, r2p0) could cause
+	  register corruption when accessing the timer registers from
+	  AArch32 userspace.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
@@ -786,6 +800,16 @@ config ARM64_SSBD
 
 	  If unsure, say Y.
 
+config MITIGATE_SPECTRE_BRANCH_HISTORY
+	bool "Mitigate Spectre style attacks against branch history" if EXPERT
+	default y
+	depends on HARDEN_BRANCH_PREDICTOR || !KVM
+	help
+	  Speculation attacks against some high-performance processors can
+	  make use of branch history to influence future speculation.
+	  When taking an exception from user-space, a sequence of branches
+	  or a firmware call overwrites the branch history.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
index c1f719b7097a..95e3cb38474f 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2837.dtsi
@@ -31,12 +31,26 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		/* Source for d/i-cache-line-size and d/i-cache-sets
+		 * https://developer.arm.com/documentation/ddi0500/e/level-1-memory-system
+		 * /about-the-l1-memory-system?lang=en
+		 *
+		 * Source for d/i-cache-size
+		 * https://magpi.raspberrypi.com/articles/raspberry-pi-3-specs-benchmarks
+		 */
 		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000d8>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>; // 32KiB(size)/64(line-size)=512ways/4-way set
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 32KiB(size)/64(line-size)=512ways/2-way set
+			next-level-cache = <&l2>;
 		};
 
 		cpu1: cpu@1 {
@@ -45,6 +59,13 @@
 			reg = <1>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000e0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>; // 32KiB(size)/64(line-size)=512ways/4-way set
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 32KiB(size)/64(line-size)=512ways/2-way set
+			next-level-cache = <&l2>;
 		};
 
 		cpu2: cpu@2 {
@@ -53,6 +74,13 @@
 			reg = <2>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000e8>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>; // 32KiB(size)/64(line-size)=512ways/4-way set
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 32KiB(size)/64(line-size)=512ways/2-way set
+			next-level-cache = <&l2>;
 		};
 
 		cpu3: cpu@3 {
@@ -61,6 +89,27 @@
 			reg = <3>;
 			enable-method = "spin-table";
 			cpu-release-addr = <0x0 0x000000f0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>; // 32KiB(size)/64(line-size)=512ways/4-way set
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 32KiB(size)/64(line-size)=512ways/2-way set
+			next-level-cache = <&l2>;
+		};
+
+		/* Source for cache-line-size + cache-sets
+		 * https://developer.arm.com/documentation/ddi0500
+		 * /e/level-2-memory-system/about-the-l2-memory-system?lang=en
+		 * Source for cache-size
+		 * https://datasheets.raspberrypi.com/cm/cm1-and-cm3-datasheet.pdf
+		 */
+		l2: l2-cache0 {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>; // 512KiB(size)/64(line-size)=8192ways/16-way set
+			cache-level = <2>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index b09f3bc5c6c1..58114b842a59 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -103,8 +103,8 @@
 		compatible = "silabs,si3226x";
 		reg = <0>;
 		spi-max-frequency = <5000000>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
@@ -127,8 +127,8 @@
 		at25,byte-len = <0x8000>;
 		at25,addr-mode = <2>;
 		at25,page-size = <64>;
-		spi-cpha = <1>;
-		spi-cpol = <1>;
+		spi-cpha;
+		spi-cpol;
 		pl022,hierarchy = <0>;
 		pl022,interface = <0>;
 		pl022,slave-tx-disable = <0>;
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 8a94ec8035d3..83c1718dac29 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -514,7 +514,7 @@
 			};
 		};
 
-		sata: ahci@663f2000 {
+		sata: sata@663f2000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x663f2000 0x1000>;
 			reg-names = "ahci";
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index eaa5bbe3fa87..1b0d7e994e0c 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -29,41 +29,35 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
+#if IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND)
 extern struct static_key_false arch_timer_read_ool_enabled;
-#define needs_fsl_a008585_workaround() \
+#define needs_unstable_timer_counter_workaround() \
 	static_branch_unlikely(&arch_timer_read_ool_enabled)
 #else
-#define needs_fsl_a008585_workaround()  false
+#define needs_unstable_timer_counter_workaround()  false
 #endif
 
-u32 __fsl_a008585_read_cntp_tval_el0(void);
-u32 __fsl_a008585_read_cntv_tval_el0(void);
-u64 __fsl_a008585_read_cntvct_el0(void);
+enum arch_timer_erratum_match_type {
+	ate_match_dt,
+	ate_match_local_cap_id,
+};
 
-/*
- * The number of retries is an arbitrary value well beyond the highest number
- * of iterations the loop has been observed to take.
- */
-#define __fsl_a008585_read_reg(reg) ({			\
-	u64 _old, _new;					\
-	int _retries = 200;				\
-							\
-	do {						\
-		_old = read_sysreg(reg);		\
-		_new = read_sysreg(reg);		\
-		_retries--;				\
-	} while (unlikely(_old != _new) && _retries);	\
-							\
-	WARN_ON_ONCE(!_retries);			\
-	_new;						\
-})
+struct arch_timer_erratum_workaround {
+	enum arch_timer_erratum_match_type match_type;
+	const void *id;
+	const char *desc;
+	u32 (*read_cntp_tval_el0)(void);
+	u32 (*read_cntv_tval_el0)(void);
+	u64 (*read_cntvct_el0)(void);
+};
+
+extern const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround;
 
 #define arch_timer_reg_read_stable(reg) 		\
 ({							\
 	u64 _val;					\
-	if (needs_fsl_a008585_workaround())		\
-		_val = __fsl_a008585_read_##reg();	\
+	if (needs_unstable_timer_counter_workaround())		\
+		_val = timer_unstable_counter_workaround->read_##reg();\
 	else						\
 		_val = read_sysreg(reg);		\
 	_val;						\
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3f85bbcd7e40..a6aaeb871d5f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -94,6 +94,13 @@
 	hint	#20
 	.endm
 
+/*
+ * Clear Branch History instruction
+ */
+	.macro clearbhb
+	hint	#22
+	.endm
+
 /*
  * Sanitise a 64-bit bounded index wrt speculation, returning zero if out
  * of bounds.
@@ -494,4 +501,31 @@ alternative_endif
 .Ldone\@:
 	.endm
 
+	.macro __mitigate_spectre_bhb_loop      tmp
+#ifdef CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
+alternative_cb  spectre_bhb_patch_loop_iter
+	mov	\tmp, #32		// Patched to correct the immediate
+alternative_cb_end
+.Lspectre_bhb_loop\@:
+	b	. + 4
+	subs	\tmp, \tmp, #1
+	b.ne	.Lspectre_bhb_loop\@
+	dsb	nsh
+	isb
+#endif /* CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY */
+	.endm
+
+	/* Save/restores x0-x3 to the stack */
+	.macro __mitigate_spectre_bhb_fw
+#ifdef CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
+	stp	x0, x1, [sp, #-16]!
+	stp	x2, x3, [sp, #-16]!
+	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_3
+alternative_cb	arm64_update_smccc_conduit
+	nop					// Patched to SMC/HVC #0
+alternative_cb_end
+	ldp	x2, x3, [sp], #16
+	ldp	x0, x1, [sp], #16
+#endif /* CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY */
+	.endm
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 889226b4c6e1..c7f17e663e72 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -36,6 +36,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64dfr1;
 	u64		reg_id_aa64isar0;
 	u64		reg_id_aa64isar1;
+	u64		reg_id_aa64isar2;
 	u64		reg_id_aa64mmfr0;
 	u64		reg_id_aa64mmfr1;
 	u64		reg_id_aa64mmfr2;
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 8c7c4b23a8b1..9935e55a3cc7 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -38,7 +38,9 @@
 #define ARM64_HARDEN_BRANCH_PREDICTOR		17
 #define ARM64_SSBD				18
 #define ARM64_MISMATCHED_CACHE_TYPE		19
+#define ARM64_WORKAROUND_1188873		20
+#define ARM64_SPECTRE_BHB			21
 
-#define ARM64_NCAPS				20
+#define ARM64_NCAPS				22
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e7bef3d936d8..58a32511da8f 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -10,6 +10,7 @@
 #define __ASM_CPUFEATURE_H
 
 #include <asm/cpucaps.h>
+#include <asm/cputype.h>
 #include <asm/hwcap.h>
 #include <asm/sysreg.h>
 
@@ -66,24 +67,173 @@ struct arm64_ftr_reg {
 
 extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 
-/* scope of capability check */
-enum {
-	SCOPE_SYSTEM,
-	SCOPE_LOCAL_CPU,
-};
+/*
+ * CPU capabilities:
+ *
+ * We use arm64_cpu_capabilities to represent system features, errata work
+ * arounds (both used internally by kernel and tracked in cpu_hwcaps) and
+ * ELF HWCAPs (which are exposed to user).
+ *
+ * To support systems with heterogeneous CPUs, we need to make sure that we
+ * detect the capabilities correctly on the system and take appropriate
+ * measures to ensure there are no incompatibilities.
+ *
+ * This comment tries to explain how we treat the capabilities.
+ * Each capability has the following list of attributes :
+ *
+ * 1) Scope of Detection : The system detects a given capability by
+ *    performing some checks at runtime. This could be, e.g, checking the
+ *    value of a field in CPU ID feature register or checking the cpu
+ *    model. The capability provides a call back ( @matches() ) to
+ *    perform the check. Scope defines how the checks should be performed.
+ *    There are two cases:
+ *
+ *     a) SCOPE_LOCAL_CPU: check all the CPUs and "detect" if at least one
+ *        matches. This implies, we have to run the check on all the
+ *        booting CPUs, until the system decides that state of the
+ *        capability is finalised. (See section 2 below)
+ *		Or
+ *     b) SCOPE_SYSTEM: check all the CPUs and "detect" if all the CPUs
+ *        matches. This implies, we run the check only once, when the
+ *        system decides to finalise the state of the capability. If the
+ *        capability relies on a field in one of the CPU ID feature
+ *        registers, we use the sanitised value of the register from the
+ *        CPU feature infrastructure to make the decision.
+ *
+ *    The process of detection is usually denoted by "update" capability
+ *    state in the code.
+ *
+ * 2) Finalise the state : The kernel should finalise the state of a
+ *    capability at some point during its execution and take necessary
+ *    actions if any. Usually, this is done, after all the boot-time
+ *    enabled CPUs are brought up by the kernel, so that it can make
+ *    better decision based on the available set of CPUs. However, there
+ *    are some special cases, where the action is taken during the early
+ *    boot by the primary boot CPU. (e.g, running the kernel at EL2 with
+ *    Virtualisation Host Extensions). The kernel usually disallows any
+ *    changes to the state of a capability once it finalises the capability
+ *    and takes any action, as it may be impossible to execute the actions
+ *    safely. A CPU brought up after a capability is "finalised" is
+ *    referred to as "Late CPU" w.r.t the capability. e.g, all secondary
+ *    CPUs are treated "late CPUs" for capabilities determined by the boot
+ *    CPU.
+ *
+ * 3) Verification: When a CPU is brought online (e.g, by user or by the
+ *    kernel), the kernel should make sure that it is safe to use the CPU,
+ *    by verifying that the CPU is compliant with the state of the
+ *    capabilities finalised already. This happens via :
+ *
+ *	secondary_start_kernel()-> check_local_cpu_capabilities()
+ *
+ *    As explained in (2) above, capabilities could be finalised at
+ *    different points in the execution. Each CPU is verified against the
+ *    "finalised" capabilities and if there is a conflict, the kernel takes
+ *    an action, based on the severity (e.g, a CPU could be prevented from
+ *    booting or cause a kernel panic). The CPU is allowed to "affect" the
+ *    state of the capability, if it has not been finalised already.
+ *    See section 5 for more details on conflicts.
+ *
+ * 4) Action: As mentioned in (2), the kernel can take an action for each
+ *    detected capability, on all CPUs on the system. Appropriate actions
+ *    include, turning on an architectural feature, modifying the control
+ *    registers (e.g, SCTLR, TCR etc.) or patching the kernel via
+ *    alternatives. The kernel patching is batched and performed at later
+ *    point. The actions are always initiated only after the capability
+ *    is finalised. This is usally denoted by "enabling" the capability.
+ *    The actions are initiated as follows :
+ *	a) Action is triggered on all online CPUs, after the capability is
+ *	finalised, invoked within the stop_machine() context from
+ *	enable_cpu_capabilitie().
+ *
+ *	b) Any late CPU, brought up after (1), the action is triggered via:
+ *
+ *	  check_local_cpu_capabilities() -> verify_local_cpu_capabilities()
+ *
+ * 5) Conflicts: Based on the state of the capability on a late CPU vs.
+ *    the system state, we could have the following combinations :
+ *
+ *		x-----------------------------x
+ *		| Type  | System   | Late CPU |
+ *		|-----------------------------|
+ *		|  a    |   y      |    n     |
+ *		|-----------------------------|
+ *		|  b    |   n      |    y     |
+ *		x-----------------------------x
+ *
+ *     Two separate flag bits are defined to indicate whether each kind of
+ *     conflict can be allowed:
+ *		ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU - Case(a) is allowed
+ *		ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU - Case(b) is allowed
+ *
+ *     Case (a) is not permitted for a capability that the system requires
+ *     all CPUs to have in order for the capability to be enabled. This is
+ *     typical for capabilities that represent enhanced functionality.
+ *
+ *     Case (b) is not permitted for a capability that must be enabled
+ *     during boot if any CPU in the system requires it in order to run
+ *     safely. This is typical for erratum work arounds that cannot be
+ *     enabled after the corresponding capability is finalised.
+ *
+ *     In some non-typical cases either both (a) and (b), or neither,
+ *     should be permitted. This can be described by including neither
+ *     or both flags in the capability's type field.
+ */
+
+
+/* Decide how the capability is detected. On a local CPU vs System wide */
+#define ARM64_CPUCAP_SCOPE_LOCAL_CPU		((u16)BIT(0))
+#define ARM64_CPUCAP_SCOPE_SYSTEM		((u16)BIT(1))
+#define ARM64_CPUCAP_SCOPE_MASK			\
+	(ARM64_CPUCAP_SCOPE_SYSTEM	|	\
+	 ARM64_CPUCAP_SCOPE_LOCAL_CPU)
+
+#define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
+#define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
+
+/*
+ * Is it permitted for a late CPU to have this capability when system
+ * hasn't already enabled it ?
+ */
+#define ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU	((u16)BIT(4))
+/* Is it safe for a late CPU to miss this capability when system has it */
+#define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
+
+/*
+ * CPU errata workarounds that need to be enabled at boot time if one or
+ * more CPUs in the system requires it. When one of these capabilities
+ * has been enabled, it is safe to allow any CPU to boot that doesn't
+ * require the workaround. However, it is not safe if a "late" CPU
+ * requires a workaround and the system hasn't enabled it already.
+ */
+#define ARM64_CPUCAP_LOCAL_CPU_ERRATUM		\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
+/*
+ * CPU feature detected at boot time based on system-wide value of a
+ * feature. It is safe for a late CPU to have this feature even though
+ * the system hasn't enabled it, although the featuer will not be used
+ * by Linux in this case. If the system has enabled this feature already,
+ * then every late CPU must have it.
+ */
+#define ARM64_CPUCAP_SYSTEM_FEATURE	\
+	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
 
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
-	int def_scope;			/* default scope */
+	u16 type;
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
-	int (*enable)(void *);		/* Called on all active CPUs */
+	/*
+	 * Take the appropriate actions to enable this capability for this CPU.
+	 * For each successfully booted CPU, this method is called for each
+	 * globally detected capability.
+	 */
+	void (*cpu_enable)(const struct arm64_cpu_capabilities *cap);
 	union {
 		struct {	/* To be used for erratum handling only */
-			u32 midr_model;
-			u32 midr_range_min, midr_range_max;
+			struct midr_range midr_range;
 		};
 
+		const struct midr_range *midr_range_list;
 		struct {	/* Feature register checking */
 			u32 sys_reg;
 			u8 field_pos;
@@ -95,6 +245,23 @@ struct arm64_cpu_capabilities {
 	};
 };
 
+static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
+{
+	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
+}
+
+static inline bool
+cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
+{
+	return !!(cap->type & ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU);
+}
+
+static inline bool
+cpucap_late_cpu_permitted(const struct arm64_cpu_capabilities *cap)
+{
+	return !!(cap->type & ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU);
+}
+
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
@@ -195,15 +362,8 @@ static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
 }
 
 void __init setup_cpu_features(void);
-
-void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			    const char *info);
-void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps);
 void check_local_cpu_capabilities(void);
 
-void update_cpu_errata_workarounds(void);
-void __init enable_errata_workarounds(void);
-void verify_local_cpu_errata_workarounds(void);
 
 u64 read_system_reg(u32 id);
 
@@ -212,6 +372,34 @@ static inline bool cpu_supports_mixed_endian_el0(void)
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
 }
 
+static inline bool supports_csv2p3(int scope)
+{
+	u64 pfr0;
+	u8 csv2_val;
+
+	if (scope == SCOPE_LOCAL_CPU)
+		pfr0 = read_sysreg_s(SYS_ID_AA64PFR0_EL1);
+	else
+		pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
+
+	csv2_val = cpuid_feature_extract_unsigned_field(pfr0,
+							ID_AA64PFR0_CSV2_SHIFT);
+	return csv2_val == 3;
+}
+
+static inline bool supports_clearbhb(int scope)
+{
+	u64 isar2;
+
+	if (scope == SCOPE_LOCAL_CPU)
+		isar2 = read_sysreg_s(SYS_ID_AA64ISAR2_EL1);
+	else
+		isar2 = read_system_reg(SYS_ID_AA64ISAR2_EL1);
+
+	return cpuid_feature_extract_unsigned_field(isar2,
+						    ID_AA64ISAR2_CLEARBHB_SHIFT);
+}
+
 static inline bool system_supports_32bit_el0(void)
 {
 	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
@@ -244,6 +432,18 @@ void arm64_set_ssbd_mitigation(bool state);
 static inline void arm64_set_ssbd_mitigation(bool state) {}
 #endif
 
+/* Watch out, ordering is important here. */
+enum mitigation_state {
+	SPECTRE_UNAFFECTED,
+	SPECTRE_MITIGATED,
+	SPECTRE_VULNERABLE,
+};
+
+enum mitigation_state arm64_get_spectre_bhb_state(void);
+bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
+u8 spectre_bhb_loop_affected(int scope);
+void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry);
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 39d1db68748d..7ffa41caa417 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -83,6 +83,18 @@
 #define ARM_CPU_PART_CORTEX_A53		0xD03
 #define ARM_CPU_PART_CORTEX_A73		0xD09
 #define ARM_CPU_PART_CORTEX_A75		0xD0A
+#define ARM_CPU_PART_CORTEX_A35		0xD04
+#define ARM_CPU_PART_CORTEX_A55		0xD05
+#define ARM_CPU_PART_CORTEX_A76		0xD0B
+#define ARM_CPU_PART_NEOVERSE_N1	0xD0C
+#define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_NEOVERSE_V1	0xD40
+#define ARM_CPU_PART_CORTEX_A78		0xD41
+#define ARM_CPU_PART_CORTEX_X1		0xD44
+#define ARM_CPU_PART_CORTEX_A710	0xD47
+#define ARM_CPU_PART_CORTEX_X2		0xD48
+#define ARM_CPU_PART_NEOVERSE_N2	0xD49
+#define ARM_CPU_PART_CORTEX_A78C	0xD4B
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -98,6 +110,18 @@
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
 #define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
 #define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
+#define MIDR_CORTEX_A35 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A35)
+#define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
+#define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
+#define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
+#define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
+#define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
+#define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
+#define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
+#define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
+#define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
+#define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
@@ -109,6 +133,45 @@
 
 #define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
 
+/*
+ * Represent a range of MIDR values for a given CPU model and a
+ * range of variant/revision values.
+ *
+ * @model	- CPU model as defined by MIDR_CPU_MODEL
+ * @rv_min	- Minimum value for the revision/variant as defined by
+ *		  MIDR_CPU_VAR_REV
+ * @rv_max	- Maximum value for the variant/revision for the range.
+ */
+struct midr_range {
+	u32 model;
+	u32 rv_min;
+	u32 rv_max;
+};
+
+#define MIDR_RANGE(m, v_min, r_min, v_max, r_max)		\
+	{							\
+		.model = m,					\
+		.rv_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
+		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
+	}
+
+#define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
+
+static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
+{
+	return MIDR_IS_CPU_MODEL_RANGE(midr, range->model,
+				 range->rv_min, range->rv_max);
+}
+
+static inline bool
+is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
+{
+	while (ranges->model)
+		if (is_midr_in_range(midr, ranges++))
+			return true;
+	return false;
+}
+
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index d8e58051f32d..4ffe0d698fa7 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -53,9 +53,11 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	FIX_ENTRY_TRAMP_TEXT3,
+	FIX_ENTRY_TRAMP_TEXT2,
+	FIX_ENTRY_TRAMP_TEXT1,
 	FIX_ENTRY_TRAMP_DATA,
-	FIX_ENTRY_TRAMP_TEXT,
-#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
+#define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT1))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 	__end_of_permanent_fixed_addresses,
 
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index bc853663dd51..aecc07e09a18 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -332,6 +332,8 @@ bool aarch64_insn_is_branch(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 				  u32 insn, u64 imm);
+u32 aarch64_insn_decode_register(enum aarch64_insn_register_type type,
+					 u32 insn);
 u32 aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
 				enum aarch64_insn_branch_type type);
 u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a152a7bbc85a..a75f02e5f0fd 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -452,4 +452,8 @@ static inline int kvm_arm_have_ssbd(void)
 	}
 }
 
+static inline bool kvm_arm_spectre_bhb_mitigated(void)
+{
+	return arm64_get_spectre_bhb_state() == SPECTRE_MITIGATED;
+}
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index ff721659eb94..4a2c95854856 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -362,7 +362,7 @@ static inline void *kvm_get_hyp_vector(void)
 	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
 	void *vect = kvm_ksym_ref(__kvm_hyp_vector);
 
-	if (data->fn) {
+	if (data->template_start) {
 		vect = __bp_harden_hyp_vecs_start +
 		       data->hyp_vectors_slot * SZ_2K;
 
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 6ac34c75f4e1..f4377b005cba 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -34,7 +34,7 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
-static inline bool arm64_kernel_unmapped_at_el0(void)
+static __always_inline bool arm64_kernel_unmapped_at_el0(void)
 {
 	return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) &&
 	       cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
@@ -45,6 +45,12 @@ typedef void (*bp_hardening_cb_t)(void);
 struct bp_hardening_data {
 	int			hyp_vectors_slot;
 	bp_hardening_cb_t	fn;
+
+	/*
+	 * template_start is only used by the BHB mitigation to identify the
+	 * hyp_vectors_slot sequence.
+	 */
+	const char *template_start;
 };
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 9ee660013e5c..367141e05c34 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -37,6 +37,7 @@
 #include <linux/string.h>
 
 #include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
@@ -219,9 +220,8 @@ static inline void spin_lock_prefetch(const void *ptr)
 
 #endif
 
-int cpu_enable_pan(void *__unused);
-int cpu_enable_uao(void *__unused);
-int cpu_enable_cache_maint_trap(void *__unused);
+void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
+void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 4e7e7067afdb..09ebd37d5aa3 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -26,5 +26,11 @@ extern char __hyp_text_start[], __hyp_text_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
+extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+
+static inline size_t entry_tramp_text_size(void)
+{
+	return __entry_tramp_text_end - __entry_tramp_text_start;
+}
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ae1b31d02784..46e97be12e02 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -70,6 +70,7 @@
 
 #define SYS_ID_AA64ISAR0_EL1		sys_reg(3, 0, 0, 6, 0)
 #define SYS_ID_AA64ISAR1_EL1		sys_reg(3, 0, 0, 6, 1)
+#define SYS_ID_AA64ISAR2_EL1		sys_reg(3, 0, 0, 6, 2)
 
 #define SYS_ID_AA64MMFR0_EL1		sys_reg(3, 0, 0, 7, 0)
 #define SYS_ID_AA64MMFR1_EL1		sys_reg(3, 0, 0, 7, 1)
@@ -173,6 +174,9 @@
 #define ID_AA64ISAR0_SHA1_SHIFT		8
 #define ID_AA64ISAR0_AES_SHIFT		4
 
+/* id_aa64isar2 */
+#define ID_AA64ISAR2_CLEARBHB_SHIFT	28
+
 /* id_aa64pfr0 */
 #define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_CSV2_SHIFT		56
@@ -211,6 +215,7 @@
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
 
 /* id_aa64mmfr1 */
+#define ID_AA64MMFR1_ECBHB_SHIFT	60
 #define ID_AA64MMFR1_PAN_SHIFT		20
 #define ID_AA64MMFR1_LOR_SHIFT		16
 #define ID_AA64MMFR1_HPD_SHIFT		12
diff --git a/arch/arm64/include/asm/vectors.h b/arch/arm64/include/asm/vectors.h
new file mode 100644
index 000000000000..695583b9a145
--- /dev/null
+++ b/arch/arm64/include/asm/vectors.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 ARM Ltd.
+ */
+#ifndef __ASM_VECTORS_H
+#define __ASM_VECTORS_H
+
+#include <linux/bug.h>
+#include <linux/percpu.h>
+
+#include <asm/fixmap.h>
+#include <asm/mmu.h>
+
+extern char vectors[];
+extern char tramp_vectors[];
+extern char __bp_harden_el1_vectors[];
+
+/*
+ * Note: the order of this enum corresponds to two arrays in entry.S:
+ * tramp_vecs and __bp_harden_el1_vectors. By default the canonical
+ * 'full fat' vectors are used directly.
+ */
+enum arm64_bp_harden_el1_vectors {
+#ifdef CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
+	/*
+	 * Perform the BHB loop mitigation, before branching to the canonical
+	 * vectors.
+	 */
+	EL1_VECTOR_BHB_LOOP,
+
+	/*
+	 * Make the SMC call for firmware mitigation, before branching to the
+	 * canonical vectors.
+	 */
+	EL1_VECTOR_BHB_FW,
+
+	/*
+	 * Use the ClearBHB instruction, before branching to the canonical
+	 * vectors.
+	 */
+	EL1_VECTOR_BHB_CLEAR_INSN,
+#endif /* CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY */
+
+	/*
+	 * Remap the kernel before branching to the canonical vectors.
+	 */
+	EL1_VECTOR_KPTI,
+};
+
+#ifndef CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
+#define EL1_VECTOR_BHB_LOOP		-1
+#define EL1_VECTOR_BHB_FW		-1
+#define EL1_VECTOR_BHB_CLEAR_INSN	-1
+#endif /* !CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY */
+
+/* The vectors to use on return from EL0. e.g. to remap the kernel */
+DECLARE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector);
+
+#ifndef CONFIG_UNMAP_KERNEL_AT_EL0
+#define TRAMP_VALIAS	0
+#endif
+
+static inline const char *
+arm64_get_bp_hardening_vector(enum arm64_bp_harden_el1_vectors slot)
+{
+	if (arm64_kernel_unmapped_at_el0())
+		return (char *)TRAMP_VALIAS + SZ_2K * slot;
+
+	WARN_ON_ONCE(slot == EL1_VECTOR_KPTI);
+
+	return __bp_harden_el1_vectors + SZ_2K * slot;
+}
+
+#endif /* __ASM_VECTORS_H */
diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
index dc4eb154e33b..d3fd8bf42d86 100644
--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -73,3 +73,58 @@ ENTRY(__smccc_workaround_1_smc_end)
 ENTRY(__smccc_workaround_1_hvc_start)
 	smccc_workaround_1	hvc
 ENTRY(__smccc_workaround_1_hvc_end)
+
+ENTRY(__smccc_workaround_3_smc_start)
+	sub     sp, sp, #(8 * 4)
+	stp     x2, x3, [sp, #(8 * 0)]
+	stp     x0, x1, [sp, #(8 * 2)]
+	mov     w0, #ARM_SMCCC_ARCH_WORKAROUND_3
+	smc     #0
+	ldp     x2, x3, [sp, #(8 * 0)]
+	ldp     x0, x1, [sp, #(8 * 2)]
+	add     sp, sp, #(8 * 4)
+ENTRY(__smccc_workaround_3_smc_end)
+
+ENTRY(__spectre_bhb_loop_k8_start)
+	sub     sp, sp, #(8 * 2)
+	stp     x0, x1, [sp, #(8 * 0)]
+	mov     x0, #8
+2:	b       . + 4
+	subs    x0, x0, #1
+	b.ne    2b
+	dsb     nsh
+	isb
+	ldp     x0, x1, [sp, #(8 * 0)]
+	add     sp, sp, #(8 * 2)
+ENTRY(__spectre_bhb_loop_k8_end)
+
+ENTRY(__spectre_bhb_loop_k24_start)
+	sub     sp, sp, #(8 * 2)
+	stp     x0, x1, [sp, #(8 * 0)]
+	mov     x0, #24
+2:	b       . + 4
+	subs    x0, x0, #1
+	b.ne    2b
+	dsb     nsh
+	isb
+	ldp     x0, x1, [sp, #(8 * 0)]
+	add     sp, sp, #(8 * 2)
+ENTRY(__spectre_bhb_loop_k24_end)
+
+ENTRY(__spectre_bhb_loop_k32_start)
+	sub     sp, sp, #(8 * 2)
+	stp     x0, x1, [sp, #(8 * 0)]
+	mov     x0, #32
+2:	b       . + 4
+	subs    x0, x0, #1
+	b.ne    2b
+	dsb     nsh
+	isb
+	ldp     x0, x1, [sp, #(8 * 0)]
+	add     sp, sp, #(8 * 2)
+ENTRY(__spectre_bhb_loop_k32_end)
+
+ENTRY(__spectre_bhb_clearbhb_start)
+	hint	#22	/* aka clearbhb */
+	isb
+ENTRY(__spectre_bhb_clearbhb_end)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 3b680a32886b..f0cdf21b1006 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -23,14 +23,23 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/vectors.h>
 
 static bool __maybe_unused
 is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
 {
+	u32 midr = read_cpuid_id();
+
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
-	return MIDR_IS_CPU_MODEL_RANGE(read_cpuid_id(), entry->midr_model,
-				       entry->midr_range_min,
-				       entry->midr_range_max);
+	return is_midr_in_range(midr, &entry->midr_range);
+}
+
+static bool __maybe_unused
+is_affected_midr_range_list(const struct arm64_cpu_capabilities *entry,
+			    int scope)
+{
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+	return is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
 }
 
 static bool
@@ -48,17 +57,18 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
 	       (arm64_ftr_reg_ctrel0.sys_val & mask);
 }
 
-static int cpu_enable_trap_ctr_access(void *__unused)
+static void
+cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *__unused)
 {
 	/* Clear SCTLR_EL1.UCT */
 	config_sctlr_el1(SCTLR_EL1_UCT, 0);
-	return 0;
 }
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
+static bool __hardenbp_enab;
 DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 
 #ifdef CONFIG_KVM
@@ -66,6 +76,16 @@ extern char __smccc_workaround_1_smc_start[];
 extern char __smccc_workaround_1_smc_end[];
 extern char __smccc_workaround_1_hvc_start[];
 extern char __smccc_workaround_1_hvc_end[];
+extern char __smccc_workaround_3_smc_start[];
+extern char __smccc_workaround_3_smc_end[];
+extern char __spectre_bhb_loop_k8_start[];
+extern char __spectre_bhb_loop_k8_end[];
+extern char __spectre_bhb_loop_k24_start[];
+extern char __spectre_bhb_loop_k24_end[];
+extern char __spectre_bhb_loop_k32_start[];
+extern char __spectre_bhb_loop_k32_end[];
+extern char __spectre_bhb_clearbhb_start[];
+extern char __spectre_bhb_clearbhb_end[];
 
 static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 				const char *hyp_vecs_end)
@@ -79,12 +99,14 @@ static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 	flush_icache_range((uintptr_t)dst, (uintptr_t)dst + SZ_2K);
 }
 
+static DEFINE_SPINLOCK(bp_lock);
+static int last_slot = -1;
+
 static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_start,
 				      const char *hyp_vecs_end)
 {
-	static int last_slot = -1;
-	static DEFINE_SPINLOCK(bp_lock);
+
 	int cpu, slot = -1;
 
 	spin_lock(&bp_lock);
@@ -105,6 +127,8 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 
 	__this_cpu_write(bp_hardening_data.hyp_vectors_slot, slot);
 	__this_cpu_write(bp_hardening_data.fn, fn);
+	__this_cpu_write(bp_hardening_data.template_start, hyp_vecs_start);
+	__hardenbp_enab = true;
 	spin_unlock(&bp_lock);
 }
 #else
@@ -118,6 +142,7 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_end)
 {
 	__this_cpu_write(bp_hardening_data.fn, fn);
+	__hardenbp_enab = true;
 }
 #endif	/* CONFIG_KVM */
 
@@ -152,25 +177,25 @@ static void call_hvc_arch_workaround_1(void)
 	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
 }
 
-static int enable_smccc_arch_workaround_1(void *data)
+static void
+enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
 {
-	const struct arm64_cpu_capabilities *entry = data;
 	bp_hardening_cb_t cb;
 	void *smccc_start, *smccc_end;
 	struct arm_smccc_res res;
 
 	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
-		return 0;
+		return;
 
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
-		return 0;
+		return;
 
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
-			return 0;
+			return;
 		cb = call_hvc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_hvc_start;
 		smccc_end = __smccc_workaround_1_hvc_end;
@@ -180,22 +205,44 @@ static int enable_smccc_arch_workaround_1(void *data)
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if ((int)res.a0 < 0)
-			return 0;
+			return;
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
 		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
-		return 0;
+		return;
 	}
 
 	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
 
-	return 0;
+	return;
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
+void __init arm64_update_smccc_conduit(struct alt_instr *alt,
+				       __le32 *origptr, __le32 *updptr,
+				       int nr_inst)
+{
+	u32 insn;
+
+	BUG_ON(nr_inst != 1);
+
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		insn = aarch64_insn_get_hvc_value();
+		break;
+	case PSCI_CONDUIT_SMC:
+		insn = aarch64_insn_get_smc_value();
+		break;
+	default:
+		return;
+	}
+
+	*updptr = cpu_to_le32(insn);
+}
+
 #ifdef CONFIG_ARM64_SSBD
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
@@ -231,28 +278,6 @@ static int __init ssbd_cfg(char *buf)
 }
 early_param("ssbd", ssbd_cfg);
 
-void __init arm64_update_smccc_conduit(struct alt_instr *alt,
-				       __le32 *origptr, __le32 *updptr,
-				       int nr_inst)
-{
-	u32 insn;
-
-	BUG_ON(nr_inst != 1);
-
-	switch (psci_ops.conduit) {
-	case PSCI_CONDUIT_HVC:
-		insn = aarch64_insn_get_hvc_value();
-		break;
-	case PSCI_CONDUIT_SMC:
-		insn = aarch64_insn_get_smc_value();
-		break;
-	default:
-		return;
-	}
-
-	*updptr = cpu_to_le32(insn);
-}
-
 void __init arm64_enable_wa2_handling(struct alt_instr *alt,
 				      __le32 *origptr, __le32 *updptr,
 				      int nr_inst)
@@ -368,19 +393,60 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 }
 #endif	/* CONFIG_ARM64_SSBD */
 
-#define MIDR_RANGE(model, min, max) \
-	.def_scope = SCOPE_LOCAL_CPU, \
-	.matches = is_affected_midr_range, \
-	.midr_model = model, \
-	.midr_range_min = min, \
-	.midr_range_max = max
+#define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
+	.matches = is_affected_midr_range,			\
+	.midr_range = MIDR_RANGE(model, v_min, r_min, v_max, r_max)
+
+#define CAP_MIDR_ALL_VERSIONS(model)					\
+	.matches = is_affected_midr_range,				\
+	.midr_range = MIDR_ALL_VERSIONS(model)
+
+#define MIDR_FIXED(rev, revidr_mask) \
+	.fixed_revs = (struct arm64_midr_revidr[]){{ (rev), (revidr_mask) }, {}}
+
+#define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max)		\
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
+	CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)
+
+#define CAP_MIDR_RANGE_LIST(list)				\
+	.matches = is_affected_midr_range_list,			\
+	.midr_range_list = list
 
-#define MIDR_ALL_VERSIONS(model) \
-	.def_scope = SCOPE_LOCAL_CPU, \
-	.matches = is_affected_midr_range, \
-	.midr_model = model, \
-	.midr_range_min = 0, \
-	.midr_range_max = (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
+/* Errata affecting a range of revisions of  given model variant */
+#define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max)	 \
+	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
+
+/* Errata affecting a single variant/revision of a model */
+#define ERRATA_MIDR_REV(model, var, rev)	\
+	ERRATA_MIDR_RANGE(model, var, rev, var, rev)
+
+/* Errata affecting all variants/revisions of a given a model */
+#define ERRATA_MIDR_ALL_VERSIONS(model)				\
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
+	CAP_MIDR_ALL_VERSIONS(model)
+
+/* Errata affecting a list of midr ranges, with same work around */
+#define ERRATA_MIDR_RANGE_LIST(midr_list)			\
+	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
+	CAP_MIDR_RANGE_LIST(midr_list)
+
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+
+/*
+ * List of CPUs where we need to issue a psci call to
+ * harden the branch predictor.
+ */
+static const struct midr_range arm64_bp_harden_smccc_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+	{},
+};
+
+#endif
 
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
@@ -390,8 +456,8 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[012] */
 		.desc = "ARM errata 826319, 827319, 824069",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x02),
-		.enable = cpu_enable_cache_maint_trap,
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
+		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_819472
@@ -399,8 +465,8 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[01] */
 		.desc = "ARM errata 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x01),
-		.enable = cpu_enable_cache_maint_trap,
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
+		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_832075
@@ -408,8 +474,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 832075",
 		.capability = ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE,
-		MIDR_RANGE(MIDR_CORTEX_A57, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 2),
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A57,
+				  0, 0,
+				  1, 2),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_834220
@@ -417,8 +484,9 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A57 r0p0 - r1p2 */
 		.desc = "ARM erratum 834220",
 		.capability = ARM64_WORKAROUND_834220,
-		MIDR_RANGE(MIDR_CORTEX_A57, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 2),
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A57,
+				  0, 0,
+				  1, 2),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_845719
@@ -426,7 +494,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cortex-A53 r0p[01234] */
 		.desc = "ARM erratum 845719",
 		.capability = ARM64_WORKAROUND_845719,
-		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x04),
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 4),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
@@ -434,7 +502,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, pass 1.x */
 		.desc = "Cavium erratum 23154",
 		.capability = ARM64_WORKAROUND_CAVIUM_23154,
-		MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
+		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0, 0, 1),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
@@ -442,103 +510,402 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		MIDR_RANGE(MIDR_THUNDERX, 0x00,
-			   (1 << MIDR_VARIANT_SHIFT) | 1),
+		ERRATA_MIDR_RANGE(MIDR_THUNDERX,
+				  0, 0,
+				  1, 1),
 	},
 	{
 	/* Cavium ThunderX, T81 pass 1.0 */
 		.desc = "Cavium erratum 27456",
 		.capability = ARM64_WORKAROUND_CAVIUM_27456,
-		MIDR_RANGE(MIDR_THUNDERX_81XX, 0x00, 0x00),
+		ERRATA_MIDR_REV(MIDR_THUNDERX_81XX, 0, 0),
 	},
 #endif
 	{
 		.desc = "Mismatched cache line size",
 		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
 		.matches = has_mismatched_cache_type,
-		.def_scope = SCOPE_LOCAL_CPU,
-		.enable = cpu_enable_trap_ctr_access,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.cpu_enable = cpu_enable_trap_ctr_access,
 	},
 	{
 		.desc = "Mismatched cache type",
 		.capability = ARM64_MISMATCHED_CACHE_TYPE,
 		.matches = has_mismatched_cache_type,
-		.def_scope = SCOPE_LOCAL_CPU,
-		.enable = cpu_enable_trap_ctr_access,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.cpu_enable = cpu_enable_trap_ctr_access,
 	},
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-		.enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-		.enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		.enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		.enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-		.enable = enable_smccc_arch_workaround_1,
-	},
-	{
-		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
-		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-		.enable = enable_smccc_arch_workaround_1,
+		ERRATA_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
+		.cpu_enable = enable_smccc_arch_workaround_1,
 	},
 #endif
 #ifdef CONFIG_ARM64_SSBD
 	{
 		.desc = "Speculative Store Bypass Disable",
-		.def_scope = SCOPE_LOCAL_CPU,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.capability = ARM64_SSBD,
 		.matches = has_ssbd_mitigation,
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_1188873
+	{
+		/* Cortex-A76 r0p0 to r2p0 */
+		.desc = "ARM erratum 1188873",
+		.capability = ARM64_WORKAROUND_1188873,
+		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+	},
+#endif
+	{
+		.desc = "Spectre-BHB",
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.capability = ARM64_SPECTRE_BHB,
+		.matches = is_spectre_bhb_affected,
+#ifdef CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
+		.cpu_enable = spectre_bhb_enable_mitigation,
+#endif
+	},
 	{
 	}
 };
 
 /*
- * The CPU Errata work arounds are detected and applied at boot time
- * and the related information is freed soon after. If the new CPU requires
- * an errata not detected at boot, fail this CPU.
+ * We try to ensure that the mitigation state can never change as the result of
+ * onlining a late CPU.
  */
-void verify_local_cpu_errata_workarounds(void)
+static void __maybe_unused update_mitigation_state(enum mitigation_state *oldp,
+						   enum mitigation_state new)
 {
-	const struct arm64_cpu_capabilities *caps = arm64_errata;
-
-	for (; caps->matches; caps++) {
-		if (cpus_have_cap(caps->capability)) {
-			if (caps->enable)
-				caps->enable((void *)caps);
-		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
-			pr_crit("CPU%d: Requires work around for %s, not detected"
-					" at boot time\n",
-				smp_processor_id(),
-				caps->desc ? : "an erratum");
-			cpu_die_early();
+	enum mitigation_state state;
+
+	do {
+		state = READ_ONCE(*oldp);
+		if (new <= state)
+			break;
+	} while (cmpxchg_relaxed(oldp, state, new) != state);
+}
+
+/*
+ * Spectre BHB.
+ *
+ * A CPU is either:
+ * - Mitigated by a branchy loop a CPU specific number of times, and listed
+ *   in our "loop mitigated list".
+ * - Mitigated in software by the firmware Spectre v2 call.
+ * - Has the ClearBHB instruction to perform the mitigation.
+ * - Has the 'Exception Clears Branch History Buffer' (ECBHB) feature, so no
+ *   software mitigation in the vectors is needed.
+ * - Has CSV2.3, so is unaffected.
+ */
+static enum mitigation_state spectre_bhb_state;
+
+enum mitigation_state arm64_get_spectre_bhb_state(void)
+{
+	return spectre_bhb_state;
+}
+
+/*
+ * This must be called with SCOPE_LOCAL_CPU for each type of CPU, before any
+ * SCOPE_SYSTEM call will give the right answer.
+ */
+u8 spectre_bhb_loop_affected(int scope)
+{
+	u8 k = 0;
+	static u8 max_bhb_k;
+
+	if (scope == SCOPE_LOCAL_CPU) {
+		static const struct midr_range spectre_bhb_k32_list[] = {
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+			{},
+		};
+		static const struct midr_range spectre_bhb_k24_list[] = {
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			{},
+		};
+		static const struct midr_range spectre_bhb_k8_list[] = {
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+			{},
+		};
+
+		if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
+			k = 32;
+		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
+			k = 24;
+		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
+			k =  8;
+
+		max_bhb_k = max(max_bhb_k, k);
+	} else {
+		k = max_bhb_k;
+	}
+
+	return k;
+}
+
+static enum mitigation_state spectre_bhb_get_cpu_fw_mitigation_state(void)
+{
+	int ret;
+	struct arm_smccc_res res;
+
+	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+		return SPECTRE_VULNERABLE;
+
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_3, &res);
+		break;
+
+	case PSCI_CONDUIT_SMC:
+		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_3, &res);
+		break;
+
+	default:
+		return SPECTRE_VULNERABLE;
+	}
+
+	ret = res.a0;
+	switch (ret) {
+	case SMCCC_RET_SUCCESS:
+		return SPECTRE_MITIGATED;
+	case SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED:
+		return SPECTRE_UNAFFECTED;
+	default:
+	case SMCCC_RET_NOT_SUPPORTED:
+		return SPECTRE_VULNERABLE;
+	}
+}
+
+static bool is_spectre_bhb_fw_affected(int scope)
+{
+	static bool system_affected;
+	enum mitigation_state fw_state;
+	bool has_smccc = (psci_ops.smccc_version >= SMCCC_VERSION_1_1);
+	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
+		{},
+	};
+	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
+					 spectre_bhb_firmware_mitigated_list);
+
+	if (scope != SCOPE_LOCAL_CPU)
+		return system_affected;
+
+	fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
+	if (cpu_in_list || (has_smccc && fw_state == SPECTRE_MITIGATED)) {
+		system_affected = true;
+		return true;
+	}
+
+	return false;
+}
+
+static bool __maybe_unused supports_ecbhb(int scope)
+{
+	u64 mmfr1;
+
+	if (scope == SCOPE_LOCAL_CPU)
+		mmfr1 = read_sysreg_s(SYS_ID_AA64MMFR1_EL1);
+	else
+		mmfr1 = read_system_reg(SYS_ID_AA64MMFR1_EL1);
+
+	return cpuid_feature_extract_unsigned_field(mmfr1,
+						    ID_AA64MMFR1_ECBHB_SHIFT);
+}
+
+bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
+			     int scope)
+{
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	if (supports_csv2p3(scope))
+		return false;
+
+	if (supports_clearbhb(scope))
+		return true;
+
+	if (spectre_bhb_loop_affected(scope))
+		return true;
+
+	if (is_spectre_bhb_fw_affected(scope))
+		return true;
+
+	return false;
+}
+
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
+{
+	const char *v = arm64_get_bp_hardening_vector(slot);
+
+	if (slot < 0)
+		return;
+
+	__this_cpu_write(this_cpu_vector, v);
+
+	/*
+	 * When KPTI is in use, the vectors are switched when exiting to
+	 * user-space.
+	 */
+	if (arm64_kernel_unmapped_at_el0())
+		return;
+
+	write_sysreg(v, vbar_el1);
+	isb();
+}
+
+#ifdef CONFIG_KVM
+static const char *kvm_bhb_get_vecs_end(const char *start)
+{
+	if (start == __smccc_workaround_3_smc_start)
+		return __smccc_workaround_3_smc_end;
+	else if (start == __spectre_bhb_loop_k8_start)
+		return __spectre_bhb_loop_k8_end;
+	else if (start == __spectre_bhb_loop_k24_start)
+		return __spectre_bhb_loop_k24_end;
+	else if (start == __spectre_bhb_loop_k32_start)
+		return __spectre_bhb_loop_k32_end;
+	else if (start == __spectre_bhb_clearbhb_start)
+		return __spectre_bhb_clearbhb_end;
+
+	return NULL;
+}
+
+static void kvm_setup_bhb_slot(const char *hyp_vecs_start)
+{
+	int cpu, slot = -1;
+	const char *hyp_vecs_end;
+
+	if (!IS_ENABLED(CONFIG_KVM) || !is_hyp_mode_available())
+		return;
+
+	hyp_vecs_end = kvm_bhb_get_vecs_end(hyp_vecs_start);
+	if (WARN_ON_ONCE(!hyp_vecs_start || !hyp_vecs_end))
+		return;
+
+	spin_lock(&bp_lock);
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(bp_hardening_data.template_start, cpu) == hyp_vecs_start) {
+			slot = per_cpu(bp_hardening_data.hyp_vectors_slot, cpu);
+			break;
 		}
 	}
+
+	if (slot == -1) {
+		last_slot++;
+		BUG_ON(((__bp_harden_hyp_vecs_end - __bp_harden_hyp_vecs_start)
+			/ SZ_2K) <= last_slot);
+		slot = last_slot;
+		__copy_hyp_vect_bpi(slot, hyp_vecs_start, hyp_vecs_end);
+	}
+
+	__this_cpu_write(bp_hardening_data.hyp_vectors_slot, slot);
+	__this_cpu_write(bp_hardening_data.template_start, hyp_vecs_start);
+	spin_unlock(&bp_lock);
 }
+#else
+#define __smccc_workaround_3_smc_start NULL
+#define __spectre_bhb_loop_k8_start NULL
+#define __spectre_bhb_loop_k24_start NULL
+#define __spectre_bhb_loop_k32_start NULL
+#define __spectre_bhb_clearbhb_start NULL
+
+static void kvm_setup_bhb_slot(const char *hyp_vecs_start) { };
+#endif /* CONFIG_KVM */
 
-void update_cpu_errata_workarounds(void)
+static bool is_spectrev2_safe(void)
 {
-	update_cpu_capabilities(arm64_errata, "enabling workaround for");
+	return !is_midr_in_range_list(read_cpuid_id(),
+				      arm64_bp_harden_smccc_cpus);
 }
 
-void __init enable_errata_workarounds(void)
+void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
-	enable_cpu_capabilities(arm64_errata);
+	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
+
+	if (!is_spectre_bhb_affected(entry, SCOPE_LOCAL_CPU))
+		return;
+
+	if (!is_spectrev2_safe() &&  !__hardenbp_enab) {
+		/* No point mitigating Spectre-BHB alone. */
+	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
+		pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
+	} else if (cpu_mitigations_off()) {
+		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
+	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
+		state = SPECTRE_MITIGATED;
+	} else if (supports_clearbhb(SCOPE_LOCAL_CPU)) {
+		kvm_setup_bhb_slot(__spectre_bhb_clearbhb_start);
+		this_cpu_set_vectors(EL1_VECTOR_BHB_CLEAR_INSN);
+
+		state = SPECTRE_MITIGATED;
+	} else if (spectre_bhb_loop_affected(SCOPE_LOCAL_CPU)) {
+		switch (spectre_bhb_loop_affected(SCOPE_SYSTEM)) {
+		case 8:
+			kvm_setup_bhb_slot(__spectre_bhb_loop_k8_start);
+			break;
+		case 24:
+			kvm_setup_bhb_slot(__spectre_bhb_loop_k24_start);
+			break;
+		case 32:
+			kvm_setup_bhb_slot(__spectre_bhb_loop_k32_start);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+		}
+		this_cpu_set_vectors(EL1_VECTOR_BHB_LOOP);
+
+		state = SPECTRE_MITIGATED;
+	} else if (is_spectre_bhb_fw_affected(SCOPE_LOCAL_CPU)) {
+		fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
+		if (fw_state == SPECTRE_MITIGATED) {
+			kvm_setup_bhb_slot(__smccc_workaround_3_smc_start);
+			this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
+
+			/*
+			 * With WA3 in the vectors, the WA1 calls can be
+			 * removed.
+			 */
+			__this_cpu_write(bp_hardening_data.fn, NULL);
+
+			state = SPECTRE_MITIGATED;
+		}
+	}
+
+	update_mitigation_state(&spectre_bhb_state, state);
+}
+
+/* Patched to correct the immediate */
+void __init spectre_bhb_patch_loop_iter(struct alt_instr *alt,
+					__le32 *origptr, __le32 *updptr, int nr_inst)
+{
+	u8 rd;
+	u32 insn;
+	u16 loop_count = spectre_bhb_loop_affected(SCOPE_SYSTEM);
+
+	BUG_ON(nr_inst != 1); /* MOV -> MOV */
+
+	if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY))
+		return;
+
+	insn = le32_to_cpu(*origptr);
+	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
+	insn = aarch64_insn_gen_movewide(rd, loop_count, 0,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_ZERO);
+	*updptr++ = cpu_to_le32(insn);
 }
+#endif /* CONFIG_HARDEN_BRANCH_PREDICTOR */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8cf001baee21..9b7e7d2f236e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -20,15 +20,18 @@
 
 #include <linux/bsearch.h>
 #include <linux/cpumask.h>
+#include <linux/percpu.h>
 #include <linux/sort.h>
 #include <linux/stop_machine.h>
 #include <linux/types.h>
+
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
+#include <asm/vectors.h>
 #include <asm/virt.h>
 
 unsigned long elf_hwcap __read_mostly;
@@ -49,6 +52,8 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcaps);
 
+DEFINE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector) = vectors;
+
 DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcap_keys);
 
@@ -93,6 +98,11 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_CLEARBHB_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV2_SHIFT, 4, 0),
@@ -327,6 +337,7 @@ static const struct __ftr_reg_entry {
 	/* Op1 = 0, CRn = 0, CRm = 6 */
 	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
 	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_aa64raz),
+	ARM64_FTR_REG(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
@@ -439,6 +450,9 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	reg->strict_mask = strict_mask;
 }
 
+extern const struct arm64_cpu_capabilities arm64_errata[];
+static void update_cpu_errata_workarounds(void);
+
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
 {
 	/* Before we start using the tables, make sure it is sorted */
@@ -451,6 +465,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64DFR1_EL1, info->reg_id_aa64dfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR0_EL1, info->reg_id_aa64isar0);
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
+	init_cpu_ftr_reg(SYS_ID_AA64ISAR2_EL1, info->reg_id_aa64isar2);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
@@ -476,6 +491,11 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
 	}
 
+	/*
+	 * Run the errata work around checks on the boot CPU, once we have
+	 * initialised the cpu feature infrastructure.
+	 */
+	update_cpu_errata_workarounds();
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -557,6 +577,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64isar0, boot->reg_id_aa64isar0);
 	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR1_EL1, cpu,
 				      info->reg_id_aa64isar1, boot->reg_id_aa64isar1);
+	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR2_EL1, cpu,
+				      info->reg_id_aa64isar2, boot->reg_id_aa64isar2);
 
 	/*
 	 * Differing PARange support is fine as long as all peripherals and
@@ -676,6 +698,7 @@ static u64 __raw_read_system_reg(u32 sys_id)
 	case SYS_ID_AA64MMFR2_EL1:	return read_cpuid(ID_AA64MMFR2_EL1);
 	case SYS_ID_AA64ISAR0_EL1:	return read_cpuid(ID_AA64ISAR0_EL1);
 	case SYS_ID_AA64ISAR1_EL1:	return read_cpuid(ID_AA64ISAR1_EL1);
+	case SYS_ID_AA64ISAR2_EL1:	return read_cpuid(ID_AA64ISAR2_EL1);
 
 	case SYS_CNTFRQ_EL0:		return read_cpuid(CNTFRQ_EL0);
 	case SYS_CTR_EL0:		return read_cpuid(CTR_EL0);
@@ -728,13 +751,11 @@ static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry,
 static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	u32 midr = read_cpuid_id();
-	u32 rv_min, rv_max;
 
 	/* Cavium ThunderX pass 1.x and 2.x */
-	rv_min = 0;
-	rv_max = (1 << MIDR_VARIANT_SHIFT) | MIDR_REVISION_MASK;
-
-	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX, rv_min, rv_max);
+	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
+		MIDR_CPU_VAR_REV(0, 0),
+		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
 }
 
 static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
@@ -761,6 +782,17 @@ static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	/* List of CPUs that are not vulnerable and don't need KPTI */
+	static const struct midr_range kpti_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+	};
 	char const *str = "command line option";
 	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
 
@@ -786,23 +818,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		return true;
 
 	/* Don't force KPTI for CPUs that are not vulnerable */
-	switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
-	case MIDR_CAVIUM_THUNDERX2:
-	case MIDR_BRCM_VULCAN:
-	case MIDR_CORTEX_A53:
-	case MIDR_CORTEX_A55:
-	case MIDR_CORTEX_A57:
-	case MIDR_CORTEX_A72:
-	case MIDR_CORTEX_A73:
+	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
 		return false;
-	}
 
 	/* Defer to CPU feature registers */
 	return !cpuid_feature_extract_unsigned_field(pfr0,
 						     ID_AA64PFR0_CSV3_SHIFT);
 }
 
-static int kpti_install_ng_mappings(void *__unused)
+static void
+kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
 	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
@@ -811,8 +836,14 @@ static int kpti_install_ng_mappings(void *__unused)
 	static bool kpti_applied = false;
 	int cpu = smp_processor_id();
 
+	if (__this_cpu_read(this_cpu_vector) == vectors) {
+		const char *v = arm64_get_bp_hardening_vector(EL1_VECTOR_KPTI);
+
+		__this_cpu_write(this_cpu_vector, v);
+	}
+
 	if (kpti_applied)
-		return 0;
+		return;
 
 	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
@@ -823,7 +854,7 @@ static int kpti_install_ng_mappings(void *__unused)
 	if (!cpu)
 		kpti_applied = true;
 
-	return 0;
+	return;
 }
 
 static int __init parse_kpti(char *str)
@@ -840,7 +871,7 @@ static int __init parse_kpti(char *str)
 early_param("kpti", parse_kpti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
-static int cpu_copy_el2regs(void *__unused)
+static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
 	 * Copy register values that aren't redirected by hardware.
@@ -852,15 +883,13 @@ static int cpu_copy_el2regs(void *__unused)
 	 */
 	if (!alternatives_applied)
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
-
-	return 0;
 }
 
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_useable_gicv3_cpuif,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_GIC_SHIFT,
@@ -871,20 +900,20 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Privileged Access Never",
 		.capability = ARM64_HAS_PAN,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
-		.enable = cpu_enable_pan,
+		.cpu_enable = cpu_enable_pan,
 	},
 #endif /* CONFIG_ARM64_PAN */
 #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
 	{
 		.desc = "LSE atomic instructions",
 		.capability = ARM64_HAS_LSE_ATOMICS,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
@@ -895,39 +924,42 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_no_hw_prefetch,
 	},
 #ifdef CONFIG_ARM64_UAO
 	{
 		.desc = "User Access Override",
 		.capability = ARM64_HAS_UAO,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
 		.min_field_value = 1,
-		.enable = cpu_enable_uao,
+		/*
+		 * We rely on stop_machine() calling uao_thread_switch() to set
+		 * UAO immediately after patching.
+		 */
 	},
 #endif /* CONFIG_ARM64_UAO */
 #ifdef CONFIG_ARM64_PAN
 	{
 		.capability = ARM64_ALT_PAN_NOT_UAO,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = cpufeature_pan_not_uao,
 	},
 #endif /* CONFIG_ARM64_PAN */
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = runs_at_el2,
-		.enable = cpu_copy_el2regs,
+		.cpu_enable = cpu_copy_el2regs,
 	},
 	{
 		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
@@ -937,31 +969,31 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Reduced HYP mapping offset",
 		.capability = ARM64_HYP_OFFSET_LOW,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = hyp_offset_low,
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
 		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = unmap_kernel_at_el0,
-		.enable = kpti_install_ng_mappings,
+		.cpu_enable = kpti_install_ng_mappings,
 	},
 #endif
 	{},
 };
 
-#define HWCAP_CAP(reg, field, s, min_value, type, cap)	\
+#define HWCAP_CAP(reg, field, s, min_value, cap_type, cap)	\
 	{							\
 		.desc = #cap,					\
-		.def_scope = SCOPE_SYSTEM,			\
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,		\
 		.matches = has_cpuid_feature,			\
 		.sys_reg = reg,					\
 		.field_pos = field,				\
 		.sign = s,					\
 		.min_field_value = min_value,			\
-		.hwcap_type = type,				\
+		.hwcap_type = cap_type,				\
 		.hwcap = cap,					\
 	}
 
@@ -1038,7 +1070,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
 	for (; hwcaps->matches; hwcaps++)
-		if (hwcaps->matches(hwcaps, hwcaps->def_scope))
+		if (hwcaps->matches(hwcaps, cpucap_default_scope(hwcaps)))
 			cap_set_elf_hwcap(hwcaps);
 }
 
@@ -1061,11 +1093,11 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 	return false;
 }
 
-void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			    const char *info)
+static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
+				    const char *info)
 {
 	for (; caps->matches; caps++) {
-		if (!caps->matches(caps, caps->def_scope))
+		if (!caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
 		if (!cpus_have_cap(caps->capability) && caps->desc)
@@ -1074,11 +1106,20 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+static int __enable_cpu_capability(void *arg)
+{
+	const struct arm64_cpu_capabilities *cap = arg;
+
+	cap->cpu_enable(cap);
+	return 0;
+}
+
 /*
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
+static void __init
+enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	for (; caps->matches; caps++) {
 		unsigned int num = caps->capability;
@@ -1089,14 +1130,15 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 		/* Ensure cpus_have_const_cap(num) works */
 		static_branch_enable(&cpu_hwcap_keys[num]);
 
-		if (caps->enable) {
+		if (caps->cpu_enable) {
 			/*
 			 * Use stop_machine() as it schedules the work allowing
 			 * us to modify PSTATE, instead of on_each_cpu() which
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
+			stop_machine(__enable_cpu_capability, (void *)caps,
+				     cpu_online_mask);
 		}
 	}
 }
@@ -1154,11 +1196,44 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
 		}
-		if (caps->enable)
-			caps->enable((void *)caps);
+		if (caps->cpu_enable)
+			caps->cpu_enable(caps);
 	}
 }
 
+/*
+ * The CPU Errata work arounds are detected and applied at boot time
+ * and the related information is freed soon after. If the new CPU requires
+ * an errata not detected at boot, fail this CPU.
+ */
+static void verify_local_cpu_errata_workarounds(void)
+{
+	const struct arm64_cpu_capabilities *caps = arm64_errata;
+
+	for (; caps->matches; caps++) {
+		if (cpus_have_cap(caps->capability)) {
+			if (caps->cpu_enable)
+				caps->cpu_enable(caps);
+		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
+			pr_crit("CPU%d: Requires work around for %s, not detected"
+					" at boot time\n",
+				smp_processor_id(),
+				caps->desc ? : "an erratum");
+			cpu_die_early();
+		}
+	}
+}
+
+static void update_cpu_errata_workarounds(void)
+{
+	update_cpu_capabilities(arm64_errata, "enabling workaround for");
+}
+
+static void __init enable_errata_workarounds(void)
+{
+	enable_cpu_capabilities(arm64_errata);
+}
+
 /*
  * Run through the enabled system capabilities and enable() it on this CPU.
  * The capabilities were decided based on the available CPUs at the boot time.
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index b3d5b3e8fbcb..4c09f87650f4 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -335,6 +335,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
 	info->reg_id_aa64isar0 = read_cpuid(ID_AA64ISAR0_EL1);
 	info->reg_id_aa64isar1 = read_cpuid(ID_AA64ISAR1_EL1);
+	info->reg_id_aa64isar2 = read_cpuid(ID_AA64ISAR2_EL1);
 	info->reg_id_aa64mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
 	info->reg_id_aa64mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
 	info->reg_id_aa64mmfr2 = read_cpuid(ID_AA64MMFR2_EL1);
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 209a6a85ae5f..1e687b144eaa 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -74,26 +74,33 @@
 
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-alternative_if ARM64_UNMAP_KERNEL_AT_EL0
+.Lventry_start\@:
 	.if	\el == 0
+	/*
+	 * This must be the first instruction of the EL0 vector entries. It is
+	 * skipped by the trampoline vectors, to trigger the cleanup.
+	 */
+	b	.Lskip_tramp_vectors_cleanup\@
 	.if	\regsize == 64
 	mrs	x30, tpidrro_el0
 	msr	tpidrro_el0, xzr
 	.else
 	mov	x30, xzr
 	.endif
+.Lskip_tramp_vectors_cleanup\@:
 	.endif
-alternative_else_nop_endif
-#endif
 
 	sub	sp, sp, #S_FRAME_SIZE
 	b	el\()\el\()_\label
+.org .Lventry_start\@ + 128	// Did we overflow the ventry slot?
 	.endm
 
-	.macro tramp_alias, dst, sym
+	.macro tramp_alias, dst, sym, tmp
 	mov_q	\dst, TRAMP_VALIAS
-	add	\dst, \dst, #(\sym - .entry.tramp.text)
+	adr_l	\tmp, \sym
+	add	\dst, \dst, \tmp
+	adr_l	\tmp, .entry.tramp.text
+	sub	\dst, \dst, \tmp
 	.endm
 
 	// This macro corrupts x0-x3. It is the caller's duty
@@ -238,21 +245,25 @@ alternative_else_nop_endif
 	ldp	x24, x25, [sp, #16 * 12]
 	ldp	x26, x27, [sp, #16 * 13]
 	ldp	x28, x29, [sp, #16 * 14]
-	ldr	lr, [sp, #S_LR]
-	add	sp, sp, #S_FRAME_SIZE		// restore sp
 
 	.if	\el == 0
-alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
+alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
+	ldr	lr, [sp, #S_LR]
+	add	sp, sp, #S_FRAME_SIZE		// restore sp
+	eret
+alternative_else_nop_endif
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	bne	4f
-	msr	far_el1, x30
-	tramp_alias	x30, tramp_exit_native
+	msr	far_el1, x29
+	tramp_alias	x30, tramp_exit_native, x29
 	br	x30
 4:
-	tramp_alias	x30, tramp_exit_compat
+	tramp_alias	x30, tramp_exit_compat, x29
 	br	x30
 #endif
 	.else
+	ldr	lr, [sp, #S_LR]
+	add	sp, sp, #S_FRAME_SIZE		// restore sp
 	eret
 	.endif
 	.endm
@@ -889,12 +900,7 @@ __ni_sys_trace:
 
 	.popsection				// .entry.text
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-/*
- * Exception vectors trampoline.
- */
-	.pushsection ".entry.tramp.text", "ax"
-
+	// Move from tramp_pg_dir to swapper_pg_dir
 	.macro tramp_map_kernel, tmp
 	mrs	\tmp, ttbr1_el1
 	sub	\tmp, \tmp, #SWAPPER_DIR_SIZE
@@ -914,12 +920,47 @@ __ni_sys_trace:
 	 */
 	.endm
 
-	.macro tramp_ventry, regsize = 64
+	.macro tramp_data_page	dst
+	adr_l	\dst, .entry.tramp.text
+	sub	\dst, \dst, PAGE_SIZE
+	.endm
+
+	.macro tramp_data_read_var	dst, var
+#ifdef CONFIG_RANDOMIZE_BASE
+	tramp_data_page		\dst
+	add	\dst, \dst, #:lo12:__entry_tramp_data_\var
+	ldr	\dst, [\dst]
+#else
+	ldr	\dst, =\var
+#endif
+	.endm
+
+#define BHB_MITIGATION_NONE	0
+#define BHB_MITIGATION_LOOP	1
+#define BHB_MITIGATION_FW	2
+#define BHB_MITIGATION_INSN	3
+
+	.macro tramp_ventry, vector_start, regsize, kpti, bhb
 	.align	7
 1:
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
+
+	.if	\bhb == BHB_MITIGATION_LOOP
+	/*
+	 * This sequence must appear before the first indirect branch. i.e. the
+	 * ret out of tramp_ventry. It appears here because x30 is free.
+	 */
+	__mitigate_spectre_bhb_loop	x30
+	.endif // \bhb == BHB_MITIGATION_LOOP
+
+	.if	\bhb == BHB_MITIGATION_INSN
+	clearbhb
+	isb
+	.endif // \bhb == BHB_MITIGATION_INSN
+
+	.if	\kpti == 1
 	/*
 	 * Defend against branch aliasing attacks by pushing a dummy
 	 * entry onto the return stack and using a RET instruction to
@@ -929,43 +970,74 @@ __ni_sys_trace:
 	b	.
 2:
 	tramp_map_kernel	x30
-#ifdef CONFIG_RANDOMIZE_BASE
-	adr	x30, tramp_vectors + PAGE_SIZE
-	isb
-	ldr	x30, [x30]
-#else
-	ldr	x30, =vectors
-#endif
-	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
+	tramp_data_read_var	x30, vectors
+	prfm	plil1strm, [x30, #(1b - \vector_start)]
 	msr	vbar_el1, x30
-	add	x30, x30, #(1b - tramp_vectors)
 	isb
+	.else
+	ldr	x30, =vectors
+	.endif // \kpti == 1
+
+	.if	\bhb == BHB_MITIGATION_FW
+	/*
+	 * The firmware sequence must appear before the first indirect branch.
+	 * i.e. the ret out of tramp_ventry. But it also needs the stack to be
+	 * mapped to save/restore the registers the SMC clobbers.
+	 */
+	__mitigate_spectre_bhb_fw
+	.endif // \bhb == BHB_MITIGATION_FW
+
+	add	x30, x30, #(1b - \vector_start + 4)
 	ret
+.org 1b + 128	// Did we overflow the ventry slot?
 	.endm
 
 	.macro tramp_exit, regsize = 64
-	adr	x30, tramp_vectors
+	tramp_data_read_var	x30, this_cpu_vector
+alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
+	mrs	x29, tpidr_el1
+alternative_else
+	mrs	x29, tpidr_el2
+alternative_endif
+	ldr	x30, [x30, x29]
+
 	msr	vbar_el1, x30
-	tramp_unmap_kernel	x30
+	ldr	lr, [sp, #S_LR]
+	tramp_unmap_kernel	x29
 	.if	\regsize == 64
-	mrs	x30, far_el1
+	mrs	x29, far_el1
 	.endif
+	add	sp, sp, #S_FRAME_SIZE		// restore sp
 	eret
 	.endm
 
-	.align	11
-ENTRY(tramp_vectors)
+	.macro	generate_tramp_vector,	kpti, bhb
+.Lvector_start\@:
 	.space	0x400
 
-	tramp_ventry
-	tramp_ventry
-	tramp_ventry
-	tramp_ventry
+	.rept	4
+	tramp_ventry	.Lvector_start\@, 64, \kpti, \bhb
+	.endr
+	.rept	4
+	tramp_ventry	.Lvector_start\@, 32, \kpti, \bhb
+	.endr
+	.endm
 
-	tramp_ventry	32
-	tramp_ventry	32
-	tramp_ventry	32
-	tramp_ventry	32
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+/*
+ * Exception vectors trampoline.
+ * The order must match __bp_harden_el1_vectors and the
+ * arm64_bp_harden_el1_vectors enum.
+ */
+	.pushsection ".entry.tramp.text", "ax"
+	.align	11
+ENTRY(tramp_vectors)
+#ifdef CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
+	generate_tramp_vector	kpti=1, bhb=BHB_MITIGATION_LOOP
+	generate_tramp_vector	kpti=1, bhb=BHB_MITIGATION_FW
+	generate_tramp_vector	kpti=1, bhb=BHB_MITIGATION_INSN
+#endif /* CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY */
+	generate_tramp_vector	kpti=1, bhb=BHB_MITIGATION_NONE
 END(tramp_vectors)
 
 ENTRY(tramp_exit_native)
@@ -983,11 +1055,54 @@ END(tramp_exit_compat)
 	.align PAGE_SHIFT
 	.globl	__entry_tramp_data_start
 __entry_tramp_data_start:
+__entry_tramp_data_vectors:
 	.quad	vectors
+#ifdef CONFIG_ARM_SDE_INTERFACE
+__entry_tramp_data___sdei_asm_trampoline_next_handler:
+	.quad	__sdei_asm_handler
+#endif /* CONFIG_ARM_SDE_INTERFACE */
+__entry_tramp_data_this_cpu_vector:
+	.quad	this_cpu_vector
 	.popsection				// .rodata
 #endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
+/*
+ * Exception vectors for spectre mitigations on entry from EL1 when
+ * kpti is not in use.
+ */
+	.macro generate_el1_vector, bhb
+.Lvector_start\@:
+	kernel_ventry	1, sync_invalid			// Synchronous EL1t
+	kernel_ventry	1, irq_invalid			// IRQ EL1t
+	kernel_ventry	1, fiq_invalid			// FIQ EL1t
+	kernel_ventry	1, error_invalid		// Error EL1t
+
+	kernel_ventry	1, sync				// Synchronous EL1h
+	kernel_ventry	1, irq				// IRQ EL1h
+	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+	kernel_ventry	1, error_invalid		// Error EL1h
+
+	.rept	4
+	tramp_ventry	.Lvector_start\@, 64, 0, \bhb
+	.endr
+	.rept 4
+	tramp_ventry	.Lvector_start\@, 32, 0, \bhb
+	.endr
+	.endm
+
+/* The order must match tramp_vecs and the arm64_bp_harden_el1_vectors enum. */
+	.pushsection ".entry.text", "ax"
+	.align	11
+ENTRY(__bp_harden_el1_vectors)
+#ifdef CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
+	generate_el1_vector	bhb=BHB_MITIGATION_LOOP
+	generate_el1_vector	bhb=BHB_MITIGATION_FW
+	generate_el1_vector	bhb=BHB_MITIGATION_INSN
+#endif /* CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY */
+END(__bp_harden_el1_vectors)
+	.popsection
+
 /*
  * Special system call wrappers.
  */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1d5890f19ca3..ee34be8bed03 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -26,6 +26,7 @@
 #include <linux/hardirq.h>
 
 #include <asm/fpsimd.h>
+#include <asm/cpufeature.h>
 #include <asm/cputype.h>
 
 #define FPEXC_IOF	(1 << 0)
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 6f2ac4fc66ca..fbfad5a83526 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -234,8 +234,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
 	int i, ret = 0;
 	struct aarch64_insn_patch *pp = arg;
 
-	/* The first CPU becomes master */
-	if (atomic_inc_return(&pp->cpu_count) == 1) {
+	/* The last CPU becomes master */
+	if (atomic_inc_return(&pp->cpu_count) == num_online_cpus()) {
 		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
 			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
 							     pp->new_insns[i]);
@@ -418,6 +418,35 @@ u32 __kprobes aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 	return insn;
 }
 
+u32 aarch64_insn_decode_register(enum aarch64_insn_register_type type,
+					u32 insn)
+{
+	int shift;
+
+	switch (type) {
+	case AARCH64_INSN_REGTYPE_RT:
+	case AARCH64_INSN_REGTYPE_RD:
+		shift = 0;
+		break;
+	case AARCH64_INSN_REGTYPE_RN:
+		shift = 5;
+		break;
+	case AARCH64_INSN_REGTYPE_RT2:
+	case AARCH64_INSN_REGTYPE_RA:
+		shift = 10;
+		break;
+	case AARCH64_INSN_REGTYPE_RM:
+		shift = 16;
+		break;
+	default:
+		pr_err("%s: unknown register type encoding %d\n", __func__,
+		       type);
+		return 0;
+	}
+
+	return (insn >> shift) & GENMASK(4, 0);
+}
+
 static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
 					u32 insn,
 					enum aarch64_insn_register reg)
diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/kernel/module.lds
index 8949f6c6f729..05881e2b414c 100644
--- a/arch/arm64/kernel/module.lds
+++ b/arch/arm64/kernel/module.lds
@@ -1,3 +1,3 @@
 SECTIONS {
-	.plt (NOLOAD) : { BYTE(0) }
+	.plt : { BYTE(0) }
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 13b9c20a84b5..ea4aedb6bbdc 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -444,12 +444,6 @@ void __init smp_prepare_boot_cpu(void)
 	jump_label_init();
 	cpuinfo_store_boot_cpu();
 	save_boot_cpu_run_el();
-	/*
-	 * Run the errata work around checks on the boot CPU, once we have
-	 * initialised the cpu feature infrastructure from
-	 * cpuinfo_store_boot_cpu() above.
-	 */
-	update_cpu_errata_workarounds();
 }
 
 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b6fd2a21b015..adf18b9a2c03 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -34,6 +34,7 @@
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
 #include <asm/insn.h>
@@ -432,10 +433,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
-int cpu_enable_cache_maint_trap(void *__unused)
+void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_UCI, 0);
-	return 0;
 }
 
 #define __user_cache_maint(insn, address, res)			\
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index fa3ffad50a61..17fc1671b990 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -261,7 +261,7 @@ ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
 	<= SZ_4K, "Hibernate exit text too big or misaligned")
 #endif
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == PAGE_SIZE,
+ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) <= 3*PAGE_SIZE,
 	"Entry trampoline text too big")
 #endif
 /*
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 7ced1fb93d07..d14a8c89d08e 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -136,6 +136,10 @@ el1_hvc_guest:
 	/* ARM_SMCCC_ARCH_WORKAROUND_2 handling */
 	eor	w1, w1, #(ARM_SMCCC_ARCH_WORKAROUND_1 ^ \
 			  ARM_SMCCC_ARCH_WORKAROUND_2)
+	cbz	w1, wa_epilogue
+
+	eor	w1, w1, #(ARM_SMCCC_ARCH_WORKAROUND_2 ^ \
+			  ARM_SMCCC_ARCH_WORKAROUND_3)
 	cbnz	w1, el1_trap
 
 #ifdef CONFIG_ARM64_SSBD
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 0a2f37bceab0..1751d2763cc1 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -26,7 +26,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/uaccess.h>
-
+#include <asm/vectors.h>
 extern struct exception_table_entry __start___kvm_ex_table;
 extern struct exception_table_entry __stop___kvm_ex_table;
 
@@ -107,11 +107,14 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
 
 static void __hyp_text __deactivate_traps_vhe(void)
 {
-	extern char vectors[];	/* kernel exception vectors */
+	const char *host_vectors = vectors;
 
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 	write_sysreg(CPACR_EL1_FPEN, cpacr_el1);
-	write_sysreg(vectors, vbar_el1);
+
+	if (!arm64_kernel_unmapped_at_el0())
+		host_vectors = __this_cpu_read(this_cpu_vector);
+	write_sysreg(host_vectors, vbar_el1);
 }
 
 static void __hyp_text __deactivate_traps_nvhe(void)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f3d3f2e97add..a0c3efbc3717 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -727,7 +727,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr_if_watchpoint,
 NOKPROBE_SYMBOL(do_debug_exception);
 
 #ifdef CONFIG_ARM64_PAN
-int cpu_enable_pan(void *__unused)
+void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
 	 * We modify PSTATE. This won't work from irq context as the PSTATE
@@ -737,20 +737,5 @@ int cpu_enable_pan(void *__unused)
 
 	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
 	asm(SET_PSTATE_PAN(1));
-	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
-
-#ifdef CONFIG_ARM64_UAO
-/*
- * Kernel threads have fs=KERNEL_DS by default, and don't need to call
- * set_fs(), devtmpfs in particular relies on this behaviour.
- * We need to enable the feature at runtime (instead of adding it to
- * PSR_MODE_EL1h) as the feature may not be implemented by the cpu.
- */
-int cpu_enable_uao(void *__unused)
-{
-	asm(SET_PSTATE_UAO(1));
-	return 0;
-}
-#endif /* CONFIG_ARM64_UAO */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 60be5bc0984a..36bd50091c4b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -438,6 +438,7 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __init map_entry_trampoline(void)
 {
+	int i;
 	extern char __entry_tramp_text_start[];
 
 	pgprot_t prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
@@ -448,11 +449,15 @@ static int __init map_entry_trampoline(void)
 
 	/* Map only the text into the trampoline page table */
 	memset(tramp_pg_dir, 0, PGD_SIZE);
-	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
-			     prot, pgd_pgtable_alloc, 0);
+	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
+			     entry_tramp_text_size(), prot, pgd_pgtable_alloc,
+			     0);
 
 	/* Map both the text and data into the kernel page table */
-	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
+	for (i = 0; i < DIV_ROUND_UP(entry_tramp_text_size(), PAGE_SIZE); i++)
+		__set_fixmap(FIX_ENTRY_TRAMP_TEXT1 - i,
+			     pa_start + i * PAGE_SIZE, prot);
+
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern char __entry_tramp_data_start[];
 
diff --git a/arch/mips/dec/prom/Makefile b/arch/mips/dec/prom/Makefile
index ae73e42ac20b..4c369359cdab 100644
--- a/arch/mips/dec/prom/Makefile
+++ b/arch/mips/dec/prom/Makefile
@@ -5,4 +5,4 @@
 
 lib-y			+= init.o memory.o cmdline.o identify.o console.o
 
-lib-$(CONFIG_32BIT)	+= locore.o
+lib-$(CONFIG_CPU_R3000)	+= locore.o
diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index b59a2103b61a..09538ff5e924 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -47,16 +47,11 @@
  */
 #define REX_PROM_MAGIC		0x30464354
 
-#ifdef CONFIG_64BIT
-
-#define prom_is_rex(magic)	1	/* KN04 and KN05 are REX PROMs.  */
-
-#else /* !CONFIG_64BIT */
-
-#define prom_is_rex(magic)	((magic) == REX_PROM_MAGIC)
-
-#endif /* !CONFIG_64BIT */
-
+/* KN04 and KN05 are REX PROMs, so only do the check for R3k systems.  */
+static inline bool prom_is_rex(u32 magic)
+{
+	return !IS_ENABLED(CONFIG_CPU_R3000) || magic == REX_PROM_MAGIC;
+}
 
 /*
  * 3MIN/MAXINE PROM entry points for DS5000/1xx's, DS5000/xx's and
diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index 4f5279a8308d..e301967fcffd 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -13,7 +13,7 @@ static inline void setup_8250_early_printk_port(unsigned long base,
 	unsigned int reg_shift, unsigned int timeout) {}
 #endif
 
-extern void set_handler(unsigned long offset, void *addr, unsigned long len);
+void set_handler(unsigned long offset, const void *addr, unsigned long len);
 extern void set_uncached_handler(unsigned long offset, void *addr, unsigned long len);
 
 typedef void (*vi_handler_t)(void);
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 95ba4271af6a..01aa8d6da4b9 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -369,6 +369,9 @@ asmlinkage void start_secondary(void)
 	cpu = smp_processor_id();
 	cpu_data[cpu].udelay_val = loops_per_jiffy;
 
+	set_cpu_sibling_map(cpu);
+	set_cpu_core_map(cpu);
+
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
@@ -380,9 +383,6 @@ asmlinkage void start_secondary(void)
 	/* The CPU is running and counters synchronised, now mark it online */
 	set_cpu_online(cpu, true);
 
-	set_cpu_sibling_map(cpu);
-	set_cpu_core_map(cpu);
-
 	calculate_cpu_foreign_map();
 
 	/*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 5f717473d08e..278e81c9e614 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2019,19 +2019,19 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		 * If no shadow set is selected then use the default handler
 		 * that does normal register saving and standard interrupt exit
 		 */
-		extern char except_vec_vi, except_vec_vi_lui;
-		extern char except_vec_vi_ori, except_vec_vi_end;
-		extern char rollback_except_vec_vi;
-		char *vec_start = using_rollback_handler() ?
-			&rollback_except_vec_vi : &except_vec_vi;
+		extern const u8 except_vec_vi[], except_vec_vi_lui[];
+		extern const u8 except_vec_vi_ori[], except_vec_vi_end[];
+		extern const u8 rollback_except_vec_vi[];
+		const u8 *vec_start = using_rollback_handler() ?
+				      rollback_except_vec_vi : except_vec_vi;
 #if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
-		const int lui_offset = &except_vec_vi_lui - vec_start + 2;
-		const int ori_offset = &except_vec_vi_ori - vec_start + 2;
+		const int lui_offset = except_vec_vi_lui - vec_start + 2;
+		const int ori_offset = except_vec_vi_ori - vec_start + 2;
 #else
-		const int lui_offset = &except_vec_vi_lui - vec_start;
-		const int ori_offset = &except_vec_vi_ori - vec_start;
+		const int lui_offset = except_vec_vi_lui - vec_start;
+		const int ori_offset = except_vec_vi_ori - vec_start;
 #endif
-		const int handler_len = &except_vec_vi_end - vec_start;
+		const int handler_len = except_vec_vi_end - vec_start;
 
 		if (handler_len > VECTORSPACING) {
 			/*
@@ -2251,7 +2251,7 @@ void per_cpu_trap_init(bool is_boot_cpu)
 }
 
 /* Install CPU exception handler */
-void set_handler(unsigned long offset, void *addr, unsigned long size)
+void set_handler(unsigned long offset, const void *addr, unsigned long size)
 {
 #ifdef CONFIG_CPU_MICROMIPS
 	memcpy((void *)(ebase + offset), ((unsigned char *)addr - 1), size);
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 0966adccf520..ed921f7b4364 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -313,11 +313,9 @@ static int __init plat_setup_devices(void)
 static int __init setup_kmac(char *s)
 {
 	printk(KERN_INFO "korina mac = %s\n", s);
-	if (!mac_pton(s, korina_dev0_data.mac)) {
+	if (!mac_pton(s, korina_dev0_data.mac))
 		printk(KERN_ERR "Invalid mac\n");
-		return -EINVAL;
-	}
-	return 0;
+	return 1;
 }
 
 __setup("kmac=", setup_kmac);
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index 2b65c0177778..957bdeb7a5c7 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -353,7 +353,7 @@ static int emulate_stw(struct pt_regs *regs, int frreg, int flop)
 	: "r" (val), "r" (regs->ior), "r" (regs->isr)
 	: "r19", "r20", "r21", "r22", "r1", FIXUP_BRANCH_CLOBBER );
 
-	return 0;
+	return ret;
 }
 static int emulate_std(struct pt_regs *regs, int frreg, int flop)
 {
@@ -410,7 +410,7 @@ static int emulate_std(struct pt_regs *regs, int frreg, int flop)
 	__asm__ __volatile__ (
 "	mtsp	%4, %%sr1\n"
 "	zdep	%2, 29, 2, %%r19\n"
-"	dep	%%r0, 31, 2, %2\n"
+"	dep	%%r0, 31, 2, %3\n"
 "	mtsar	%%r19\n"
 "	zvdepi	-2, 32, %%r19\n"
 "1:	ldw	0(%%sr1,%3),%%r20\n"
@@ -422,7 +422,7 @@ static int emulate_std(struct pt_regs *regs, int frreg, int flop)
 "	andcm	%%r21, %%r19, %%r21\n"
 "	or	%1, %%r20, %1\n"
 "	or	%2, %%r21, %2\n"
-"3:	stw	%1,0(%%sr1,%1)\n"
+"3:	stw	%1,0(%%sr1,%3)\n"
 "4:	stw	%%r1,4(%%sr1,%3)\n"
 "5:	stw	%2,8(%%sr1,%3)\n"
 "	copy	%%r0, %0\n"
@@ -610,7 +610,6 @@ void handle_unaligned(struct pt_regs *regs)
 		ret = ERR_NOTHANDLED;	/* "undefined", but lets kill them. */
 		break;
 	}
-#ifdef CONFIG_PA20
 	switch (regs->iir & OPCODE2_MASK)
 	{
 	case OPCODE_FLDD_L:
@@ -621,22 +620,23 @@ void handle_unaligned(struct pt_regs *regs)
 		flop=1;
 		ret = emulate_std(regs, R2(regs->iir),1);
 		break;
+#ifdef CONFIG_PA20
 	case OPCODE_LDD_L:
 		ret = emulate_ldd(regs, R2(regs->iir),0);
 		break;
 	case OPCODE_STD_L:
 		ret = emulate_std(regs, R2(regs->iir),0);
 		break;
-	}
 #endif
+	}
 	switch (regs->iir & OPCODE3_MASK)
 	{
 	case OPCODE_FLDW_L:
 		flop=1;
-		ret = emulate_ldw(regs, R2(regs->iir),0);
+		ret = emulate_ldw(regs, R2(regs->iir), 1);
 		break;
 	case OPCODE_LDW_M:
-		ret = emulate_ldw(regs, R2(regs->iir),1);
+		ret = emulate_ldw(regs, R2(regs->iir), 0);
 		break;
 
 	case OPCODE_FSTW_L:
diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 5fdddbd2a62b..b0a9beab1c26 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -139,12 +139,12 @@
 		fman@400000 {
 			ethernet@e6000 {
 				phy-handle = <&phy_rgmii_0>;
-				phy-connection-type = "rgmii";
+				phy-connection-type = "rgmii-id";
 			};
 
 			ethernet@e8000 {
 				phy-handle = <&phy_rgmii_1>;
-				phy-connection-type = "rgmii";
+				phy-connection-type = "rgmii-id";
 			};
 
 			mdio0: mdio@fc000 {
diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index a6f0b96ce2c9..97dee7c99aa0 100644
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -90,7 +90,7 @@ static LIST_HEAD(gtms);
  */
 struct gtm_timer *gtm_get_timer16(void)
 {
-	struct gtm *gtm = NULL;
+	struct gtm *gtm;
 	int i;
 
 	list_for_each_entry(gtm, &gtms, list_node) {
@@ -107,7 +107,7 @@ struct gtm_timer *gtm_get_timer16(void)
 		spin_unlock_irq(&gtm->lock);
 	}
 
-	if (gtm)
+	if (!list_empty(&gtms))
 		return ERR_PTR(-EBUSY);
 	return ERR_PTR(-ENODEV);
 }
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0d643ab6ec0c..4ce58439c044 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -422,10 +422,6 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-	  Without compiler support, at least indirect branches in assembler
-	  code are eliminated. Since this includes the syscall entry path,
-	  it is not entirely pointless.
-
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0bc35e3e6c5c..a77737a979c8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -221,9 +221,7 @@ ifdef CONFIG_RETPOLINE
     RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
 
     RETPOLINE_CFLAGS += $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
-    ifneq ($(RETPOLINE_CFLAGS),)
-        KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
-    endif
+    KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
 archscripts: scripts_basic
@@ -239,6 +237,13 @@ archprepare:
 ifeq ($(CONFIG_KEXEC_FILE),y)
 	$(Q)$(MAKE) $(build)=arch/x86/purgatory arch/x86/purgatory/kexec-purgatory.c
 endif
+ifdef CONFIG_RETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+	@echo "You are building kernel with non-retpoline compiler." >&2
+	@echo "Please update your compiler." >&2
+	@false
+endif
+endif
 
 ###
 # Kernel objects
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 1808c57ce161..2539aaddd137 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -410,7 +410,7 @@ static u64 pt_config_filters(struct perf_event *event)
 			pt->filters.filter[range].msr_b = filter->msr_b;
 		}
 
-		rtit_ctl |= filter->config << pt_address_ranges[range].reg_off;
+		rtit_ctl |= (u64)filter->config << pt_address_ranges[range].reg_off;
 	}
 
 	return rtit_ctl;
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 8ceb7a8a249c..5b197248d546 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -195,7 +195,7 @@
 #define X86_FEATURE_FENCE_SWAPGS_USER	( 7*32+10) /* "" LFENCE in user entry SWAPGS path */
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	( 7*32+11) /* "" LFENCE in kernel entry SWAPGS path */
 #define X86_FEATURE_RETPOLINE	( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCE for Spectre variant 2 */
 
 #define X86_FEATURE_MSR_SPEC_CTRL ( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
 #define X86_FEATURE_SSBD	( 7*32+17) /* Speculative Store Bypass Disable */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 204a5ce65afd..19829b00e4fe 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -119,7 +119,7 @@
 	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
 		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_LFENCE
 #else
 	jmp	*\reg
 #endif
@@ -130,7 +130,7 @@
 	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
 		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_LFENCE
 #else
 	call	*\reg
 #endif
@@ -164,29 +164,35 @@
 	_ASM_PTR " 999b\n\t"					\
 	".popsection\n\t"
 
-#if defined(CONFIG_X86_64) && defined(RETPOLINE)
+#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_X86_64
 
 /*
- * Since the inline asm uses the %V modifier which is only in newer GCC,
- * the 64-bit one is dependent on RETPOLINE not CONFIG_RETPOLINE.
+ * Inline asm uses the %V modifier which is only in newer GCC
+ * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
-	ALTERNATIVE(						\
+	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE)
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_LFENCE)
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
-#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
+#else /* CONFIG_X86_32 */
 /*
  * For i386 we use the original ret-equivalent retpoline, because
  * otherwise we'll run out of registers. We don't care about CET
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ALTERNATIVE(						\
+	ANNOTATE_NOSPEC_ALTERNATIVE				\
+	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"       jmp    904f;\n"					\
@@ -201,9 +207,14 @@
 	"       ret;\n"						\
 	"       .align 16\n"					\
 	"904:	call   901b;\n",				\
-	X86_FEATURE_RETPOLINE)
+	X86_FEATURE_RETPOLINE,					\
+	"lfence;\n"						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%[thunk_target]\n",				\
+	X86_FEATURE_RETPOLINE_LFENCE)
 
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#endif
 #else /* No retpoline for C / inline asm */
 # define CALL_NOSPEC "call *%[thunk_target]\n"
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
@@ -212,11 +223,11 @@
 /* The Spectre V2 mitigation variants */
 enum spectre_v2_mitigation {
 	SPECTRE_V2_NONE,
-	SPECTRE_V2_RETPOLINE_MINIMAL,
-	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
-	SPECTRE_V2_RETPOLINE_GENERIC,
-	SPECTRE_V2_RETPOLINE_AMD,
-	SPECTRE_V2_IBRS_ENHANCED,
+	SPECTRE_V2_RETPOLINE,
+	SPECTRE_V2_LFENCE,
+	SPECTRE_V2_EIBRS,
+	SPECTRE_V2_EIBRS_RETPOLINE,
+	SPECTRE_V2_EIBRS_LFENCE,
 };
 
 /* The indirect branch speculation control variants */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index eb34bf9ef987..e4ca2dd2be76 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1326,6 +1326,17 @@ static int __init disable_acpi_pci(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init disable_acpi_xsdt(const struct dmi_system_id *d)
+{
+	if (!acpi_force) {
+		pr_notice("%s detected: force use of acpi=rsdt\n", d->ident);
+		acpi_gbl_do_not_use_xsdt = TRUE;
+	} else {
+		pr_notice("Warning: DMI blacklist says broken, but acpi XSDT forced\n");
+	}
+	return 0;
+}
+
 static int __init dmi_disable_acpi(const struct dmi_system_id *d)
 {
 	if (!acpi_force) {
@@ -1446,6 +1457,19 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		     },
 	 },
+	/*
+	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
+	 */
+	{
+	 .callback = disable_acpi_xsdt,
+	 .ident = "Advantech DAC-BJ01",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
+		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
+		     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
+		     },
+	 },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a884bb7e7b01..94aa0206b1f9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -30,6 +30,7 @@
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
 #include <asm/e820.h>
+#include <linux/bpf.h>
 
 #include "cpu.h"
 
@@ -585,7 +586,7 @@ static enum spectre_v2_user_mitigation spectre_v2_user_stibp __ro_after_init =
 static enum spectre_v2_user_mitigation spectre_v2_user_ibpb __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 static bool spectre_v2_bad_module;
 
 bool retpoline_module_ok(bool has_retpoline)
@@ -606,6 +607,32 @@ static inline const char *spectre_v2_module_string(void)
 static inline const char *spectre_v2_module_string(void) { return ""; }
 #endif
 
+#define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
+#define SPECTRE_V2_EIBRS_EBPF_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!\n"
+#define SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG "WARNING: Unprivileged eBPF is enabled with eIBRS+LFENCE mitigation and SMT, data leaks possible via Spectre v2 BHB attacks!\n"
+
+#ifdef CONFIG_BPF_SYSCALL
+void unpriv_ebpf_notify(int new_state)
+{
+	if (new_state)
+		return;
+
+	/* Unprivileged eBPF is enabled */
+
+	switch (spectre_v2_enabled) {
+	case SPECTRE_V2_EIBRS:
+		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
+		break;
+	case SPECTRE_V2_EIBRS_LFENCE:
+		if (sched_smt_active())
+			pr_err(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
+		break;
+	default:
+		break;
+	}
+}
+#endif
+
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
 	int len = strlen(opt);
@@ -620,7 +647,10 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_FORCE,
 	SPECTRE_V2_CMD_RETPOLINE,
 	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
-	SPECTRE_V2_CMD_RETPOLINE_AMD,
+	SPECTRE_V2_CMD_RETPOLINE_LFENCE,
+	SPECTRE_V2_CMD_EIBRS,
+	SPECTRE_V2_CMD_EIBRS_RETPOLINE,
+	SPECTRE_V2_CMD_EIBRS_LFENCE,
 };
 
 enum spectre_v2_user_cmd {
@@ -693,6 +723,13 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
 	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
+static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
+{
+	return (mode == SPECTRE_V2_EIBRS ||
+		mode == SPECTRE_V2_EIBRS_RETPOLINE ||
+		mode == SPECTRE_V2_EIBRS_LFENCE);
+}
+
 static void __init
 spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 {
@@ -755,10 +792,12 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	}
 
 	/*
-	 * If enhanced IBRS is enabled or SMT impossible, STIBP is not
+	 * If no STIBP, enhanced IBRS is enabled or SMT impossible, STIBP is not
 	 * required.
 	 */
-	if (!smt_possible || spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
+	    !smt_possible ||
+	    spectre_v2_in_eibrs_mode(spectre_v2_enabled))
 		return;
 
 	/*
@@ -770,12 +809,6 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
 		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
 
-	/*
-	 * If STIBP is not available, clear the STIBP mode.
-	 */
-	if (!boot_cpu_has(X86_FEATURE_STIBP))
-		mode = SPECTRE_V2_USER_NONE;
-
 	spectre_v2_user_stibp = mode;
 
 set_mode:
@@ -784,11 +817,11 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 
 static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
-	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
-	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
-	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
-	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
-	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
+	[SPECTRE_V2_RETPOLINE]			= "Mitigation: Retpolines",
+	[SPECTRE_V2_LFENCE]			= "Mitigation: LFENCE",
+	[SPECTRE_V2_EIBRS]			= "Mitigation: Enhanced IBRS",
+	[SPECTRE_V2_EIBRS_LFENCE]		= "Mitigation: Enhanced IBRS + LFENCE",
+	[SPECTRE_V2_EIBRS_RETPOLINE]		= "Mitigation: Enhanced IBRS + Retpolines",
 };
 
 static const struct {
@@ -799,8 +832,12 @@ static const struct {
 	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
 	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
 	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
-	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_AMD,	  false },
+	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
+	{ "retpoline,lfence",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
 	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
+	{ "eibrs",		SPECTRE_V2_CMD_EIBRS,		  false },
+	{ "eibrs,lfence",	SPECTRE_V2_CMD_EIBRS_LFENCE,	  false },
+	{ "eibrs,retpoline",	SPECTRE_V2_CMD_EIBRS_RETPOLINE,	  false },
 	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 };
 
@@ -810,11 +847,6 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 		pr_info("%s selected on command line.\n", reason);
 }
 
-static inline bool retp_compiler(void)
-{
-	return __is_defined(RETPOLINE);
-}
-
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
@@ -842,16 +874,30 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
+	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
+		       mitigation_options[i].option);
+		return SPECTRE_V2_CMD_AUTO;
+	}
+
+	if ((cmd == SPECTRE_V2_CMD_EIBRS ||
+	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
+		pr_err("%s selected but CPU doesn't have eIBRS. Switching to AUTO select\n",
+		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+	if ((cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
+	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
+		pr_err("%s selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n",
+		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -860,6 +906,16 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	return cmd;
 }
 
+static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
+{
+	if (!IS_ENABLED(CONFIG_RETPOLINE)) {
+		pr_err("Kernel not compiled with retpoline; no mitigation available!");
+		return SPECTRE_V2_NONE;
+	}
+
+	return SPECTRE_V2_RETPOLINE;
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -880,50 +936,64 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
-			mode = SPECTRE_V2_IBRS_ENHANCED;
-			/* Force it so VMEXIT will restore correctly */
-			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
-			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
-			goto specv2_set_mode;
+			mode = SPECTRE_V2_EIBRS;
+			break;
 		}
-		if (IS_ENABLED(CONFIG_RETPOLINE))
-			goto retpoline_auto;
+
+		mode = spectre_v2_select_retpoline();
 		break;
-	case SPECTRE_V2_CMD_RETPOLINE_AMD:
-		if (IS_ENABLED(CONFIG_RETPOLINE))
-			goto retpoline_amd;
+
+	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
+		pr_err(SPECTRE_V2_LFENCE_MSG);
+		mode = SPECTRE_V2_LFENCE;
 		break;
+
 	case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
-		if (IS_ENABLED(CONFIG_RETPOLINE))
-			goto retpoline_generic;
+		mode = SPECTRE_V2_RETPOLINE;
 		break;
+
 	case SPECTRE_V2_CMD_RETPOLINE:
-		if (IS_ENABLED(CONFIG_RETPOLINE))
-			goto retpoline_auto;
+		mode = spectre_v2_select_retpoline();
+		break;
+
+	case SPECTRE_V2_CMD_EIBRS:
+		mode = SPECTRE_V2_EIBRS;
+		break;
+
+	case SPECTRE_V2_CMD_EIBRS_LFENCE:
+		mode = SPECTRE_V2_EIBRS_LFENCE;
+		break;
+
+	case SPECTRE_V2_CMD_EIBRS_RETPOLINE:
+		mode = SPECTRE_V2_EIBRS_RETPOLINE;
 		break;
 	}
-	pr_err("Spectre mitigation: kernel not compiled with retpoline; no mitigation available!");
-	return;
 
-retpoline_auto:
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-	retpoline_amd:
-		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
-			goto retpoline_generic;
-		}
-		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
-					 SPECTRE_V2_RETPOLINE_MINIMAL_AMD;
-		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
-		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
-	} else {
-	retpoline_generic:
-		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_GENERIC :
-					 SPECTRE_V2_RETPOLINE_MINIMAL;
+	if (mode == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
+		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
+
+	if (spectre_v2_in_eibrs_mode(mode)) {
+		/* Force it so VMEXIT will restore correctly */
+		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+	}
+
+	switch (mode) {
+	case SPECTRE_V2_NONE:
+	case SPECTRE_V2_EIBRS:
+		break;
+
+	case SPECTRE_V2_LFENCE:
+	case SPECTRE_V2_EIBRS_LFENCE:
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
+		/* fallthrough */
+
+	case SPECTRE_V2_RETPOLINE:
+	case SPECTRE_V2_EIBRS_RETPOLINE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+		break;
 	}
 
-specv2_set_mode:
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -949,7 +1019,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 * the CPU supports Enhanced IBRS, kernel might un-intentionally not
 	 * enable IBRS around firmware calls.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS) && mode != SPECTRE_V2_IBRS_ENHANCED) {
+	if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_eibrs_mode(mode)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
@@ -1019,6 +1089,10 @@ void arch_smt_update(void)
 {
 	mutex_lock(&spec_ctrl_mutex);
 
+	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
+	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
+		pr_warn_once(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
+
 	switch (spectre_v2_user_stibp) {
 	case SPECTRE_V2_USER_NONE:
 		break;
@@ -1263,7 +1337,6 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
 		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return 0;
-
 		/*
 		 * With strict mode for both IBPB and STIBP, the instruction
 		 * code paths avoid checking this task flag and instead,
@@ -1610,7 +1683,7 @@ static ssize_t tsx_async_abort_show_state(char *buf)
 
 static char *stibp_state(void)
 {
-	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
 		return "";
 
 	switch (spectre_v2_user_stibp) {
@@ -1640,6 +1713,27 @@ static char *ibpb_state(void)
 	return "";
 }
 
+static ssize_t spectre_v2_show_state(char *buf)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_LFENCE)
+		return sprintf(buf, "Vulnerable: LFENCE\n");
+
+	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
+		return sprintf(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
+
+	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
+	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
+		return sprintf(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
+
+	return sprintf(buf, "%s%s%s%s%s%s\n",
+		       spectre_v2_strings[spectre_v2_enabled],
+		       ibpb_state(),
+		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
+		       stibp_state(),
+		       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
+		       spectre_v2_module_string());
+}
+
 static ssize_t srbds_show_state(char *buf)
 {
 	return sprintf(buf, "%s\n", srbds_strings[srbds_mitigation]);
@@ -1662,12 +1756,7 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return sprintf(buf, "%s\n", spectre_v1_strings[spectre_v1_mitigation]);
 
 	case X86_BUG_SPECTRE_V2:
-		return sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
-			       ibpb_state(),
-			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
-			       stibp_state(),
-			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
-			       spectre_v2_module_string());
+		return spectre_v2_show_state(buf);
 
 	case X86_BUG_SPEC_STORE_BYPASS:
 		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2e5553091f90..3edafdffa687 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1674,11 +1674,6 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 		goto exception;
 	}
 
-	if (!seg_desc.p) {
-		err_vec = (seg == VCPU_SREG_SS) ? SS_VECTOR : NP_VECTOR;
-		goto exception;
-	}
-
 	dpl = seg_desc.dpl;
 
 	switch (seg) {
@@ -1718,6 +1713,10 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 	case VCPU_SREG_TR:
 		if (seg_desc.s || (seg_desc.type != 1 && seg_desc.type != 9))
 			goto exception;
+		if (!seg_desc.p) {
+			err_vec = NP_VECTOR;
+			goto exception;
+		}
 		old_desc = seg_desc;
 		seg_desc.type |= 2; /* busy */
 		ret = ctxt->ops->cmpxchg_emulated(ctxt, desc_addr, &old_desc, &seg_desc,
@@ -1742,6 +1741,11 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 		break;
 	}
 
+	if (!seg_desc.p) {
+		err_vec = (seg == VCPU_SREG_SS) ? SS_VECTOR : NP_VECTOR;
+		goto exception;
+	}
+
 	if (seg_desc.s) {
 		/* mark segment as accessed */
 		if (!(seg_desc.type & 1)) {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5e837c96e93f..56feb7d8f96d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -244,6 +244,9 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 	case HV_X64_MSR_EOM: {
 		int i;
 
+		if (!synic->active)
+			break;
+
 		for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
 			kvm_hv_notify_acked_sint(vcpu, i);
 		break;
@@ -504,6 +507,12 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 			     bool host)
 {
+	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
+	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
+
+	if (!synic->active && (!host || config))
+		return 1;
+
 	trace_kvm_hv_stimer_set_config(stimer_to_vcpu(stimer)->vcpu_id,
 				       stimer->index, config, host);
 
@@ -518,6 +527,12 @@ static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 			    bool host)
 {
+	struct kvm_vcpu *vcpu = stimer_to_vcpu(stimer);
+	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
+
+	if (!synic->active && (!host || count))
+		return 1;
+
 	trace_kvm_hv_stimer_set_count(stimer_to_vcpu(stimer)->vcpu_id,
 				      stimer->index, count, host);
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 2739b2c8db0e..4f1a56135a53 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1767,10 +1767,7 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
 
 void kvm_lapic_set_tpr(struct kvm_vcpu *vcpu, unsigned long cr8)
 {
-	struct kvm_lapic *apic = vcpu->arch.apic;
-
-	apic_set_tpr(apic, ((cr8 & 0x0f) << 4)
-		     | (kvm_lapic_get_reg(apic, APIC_TASKPRI) & 4));
+	apic_set_tpr(vcpu->arch.apic, (cr8 & 0x0f) << 4);
 }
 
 u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/pmu_amd.c b/arch/x86/kvm/pmu_amd.c
index cd944435dfbd..e0473c72062e 100644
--- a/arch/x86/kvm/pmu_amd.c
+++ b/arch/x86/kvm/pmu_amd.c
@@ -139,12 +139,10 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	/* MSR_K7_EVNTSELn */
 	pmc = get_gp_pmc(pmu, msr, MSR_K7_EVNTSEL0);
 	if (pmc) {
-		if (data == pmc->eventsel)
-			return 0;
-		if (!(data & pmu->reserved_bits)) {
+		data &= ~pmu->reserved_bits;
+		if (data != pmc->eventsel)
 			reprogram_gp_counter(pmc, data);
-			return 0;
-		}
+		return 0;
 	}
 
 	return 1;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index c8f947a4aaf2..357b3e6a2f7b 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -41,7 +41,8 @@ static void msr_save_context(struct saved_context *ctxt)
 	struct saved_msr *end = msr + ctxt->saved_msrs.num;
 
 	while (msr < end) {
-		msr->valid = !rdmsrl_safe(msr->info.msr_no, &msr->info.reg.q);
+		if (msr->valid)
+			rdmsrl(msr->info.msr_no, msr->info.reg.q);
 		msr++;
 	}
 }
@@ -419,8 +420,10 @@ static int msr_build_context(const u32 *msr_id, const int num)
 	}
 
 	for (i = saved_msrs->num, j = 0; i < total_num; i++, j++) {
+		u64 dummy;
+
 		msr_array[i].info.msr_no	= msr_id[j];
-		msr_array[i].valid		= false;
+		msr_array[i].valid		= !rdmsrl_safe(msr_id[j], &dummy);
 		msr_array[i].info.reg.q		= 0;
 	}
 	saved_msrs->num   = total_num;
@@ -507,10 +510,24 @@ static int pm_cpu_check(const struct x86_cpu_id *c)
 	return ret;
 }
 
+static void pm_save_spec_msr(void)
+{
+	u32 spec_msr_id[] = {
+		MSR_IA32_SPEC_CTRL,
+		MSR_IA32_TSX_CTRL,
+		MSR_TSX_FORCE_ABORT,
+		MSR_IA32_MCU_OPT_CTRL,
+		MSR_AMD64_LS_CFG,
+	};
+
+	msr_build_context(spec_msr_id, ARRAY_SIZE(spec_msr_id));
+}
+
 static int pm_check_save_msr(void)
 {
 	dmi_check_system(msr_save_dmi_table);
 	pm_cpu_check(msr_save_cpu_table);
+	pm_save_spec_msr();
 
 	return 0;
 }
diff --git a/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi b/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi
index d3a88e029873..d9b399b57bcd 100644
--- a/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi
+++ b/arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi
@@ -7,19 +7,19 @@
 			reg = <0x00000000 0x08000000>;
 			bank-width = <2>;
 			device-width = <2>;
-			partition@0x0 {
+			partition@0 {
 				label = "data";
 				reg = <0x00000000 0x06000000>;
 			};
-			partition@0x6000000 {
+			partition@6000000 {
 				label = "boot loader area";
 				reg = <0x06000000 0x00800000>;
 			};
-			partition@0x6800000 {
+			partition@6800000 {
 				label = "kernel image";
 				reg = <0x06800000 0x017e0000>;
 			};
-			partition@0x7fe0000 {
+			partition@7fe0000 {
 				label = "boot environment";
 				reg = <0x07fe0000 0x00020000>;
 			};
diff --git a/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi b/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi
index 1d97203c18e7..c9d0fc0b6265 100644
--- a/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi
+++ b/arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi
@@ -7,19 +7,19 @@
 			reg = <0x08000000 0x01000000>;
 			bank-width = <2>;
 			device-width = <2>;
-			partition@0x0 {
+			partition@0 {
 				label = "boot loader area";
 				reg = <0x00000000 0x00400000>;
 			};
-			partition@0x400000 {
+			partition@400000 {
 				label = "kernel image";
 				reg = <0x00400000 0x00600000>;
 			};
-			partition@0xa00000 {
+			partition@a00000 {
 				label = "data";
 				reg = <0x00a00000 0x005e0000>;
 			};
-			partition@0xfe0000 {
+			partition@fe0000 {
 				label = "boot environment";
 				reg = <0x00fe0000 0x00020000>;
 			};
diff --git a/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi b/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi
index d1c621ca8be1..332892315f92 100644
--- a/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi
+++ b/arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi
@@ -7,11 +7,11 @@
 			reg = <0x08000000 0x00400000>;
 			bank-width = <2>;
 			device-width = <2>;
-			partition@0x0 {
+			partition@0 {
 				label = "boot loader area";
 				reg = <0x00000000 0x003f0000>;
 			};
-			partition@0x3f0000 {
+			partition@3f0000 {
 				label = "boot environment";
 				reg = <0x003f0000 0x00010000>;
 			};
diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index b6e5447d563e..f538bac4ac66 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -394,7 +394,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return 0;
 	case BLKGETSIZE:
 		size = i_size_read(bdev->bd_inode);
-		if ((size >> 9) > ~0UL)
+		if ((size >> 9) > ~(compat_ulong_t)0)
 			return -EFBIG;
 		return compat_put_ulong(arg, size >> 9);
 
diff --git a/crypto/authenc.c b/crypto/authenc.c
index 6bfec690ca5b..f9ab04aa6dd5 100644
--- a/crypto/authenc.c
+++ b/crypto/authenc.c
@@ -268,7 +268,7 @@ static int crypto_authenc_decrypt_tail(struct aead_request *req,
 		dst = scatterwalk_ffwd(areq_ctx->dst, req->dst, req->assoclen);
 
 	skcipher_request_set_tfm(skreq, ctx->enc);
-	skcipher_request_set_callback(skreq, aead_request_flags(req),
+	skcipher_request_set_callback(skreq, flags,
 				      req->base.complete, req->base.data);
 	skcipher_request_set_crypt(skreq, src, dst,
 				   req->cryptlen - authsize, req->iv);
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index ebd731fe8e45..6902c2a01f6f 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -203,6 +203,9 @@ acpi_ns_walk_namespace(acpi_object_type type,
 
 	if (start_node == ACPI_ROOT_OBJECT) {
 		start_node = acpi_gbl_root_node;
+		if (!start_node) {
+			return_ACPI_STATUS(AE_NO_NAMESPACE);
+		}
 	}
 
 	/* Null child means "get first node" */
diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index a05b5c0cf181..e22f3d89b84b 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -31,6 +31,7 @@
 
 #undef pr_fmt
 #define pr_fmt(fmt) "BERT: " fmt
+#define ACPI_BERT_PRINT_MAX_LEN 1024
 
 static int bert_disable;
 
@@ -59,8 +60,11 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 		}
 
 		pr_info_once("Error records from previous boot:\n");
-
-		cper_estatus_print(KERN_INFO HW_ERR, estatus);
+		if (region_len < ACPI_BERT_PRINT_MAX_LEN)
+			cper_estatus_print(KERN_INFO HW_ERR, estatus);
+		else
+			pr_info_once("Max print length exceeded, table data is available at:\n"
+				     "/sys/firmware/acpi/tables/data/BERT");
 
 		/*
 		 * Because the boot error source is "one-time polled" type,
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 69c6f02f16b5..ee300bbe8831 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -88,6 +88,10 @@ enum acpi_battery_files {
 
 static const struct acpi_device_id battery_device_ids[] = {
 	{"PNP0C0A", 0},
+
+	/* Microsoft Surface Go 3 */
+	{"MSHW0146", 0},
+
 	{"", 0},
 };
 
@@ -1153,6 +1157,14 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire V5-573G"),
 		},
 	},
+	{
+		/* Microsoft Surface Go 3 */
+		.callback = battery_notification_delay_quirk,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 3"),
+		},
+	},
 	{},
 };
 
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 318bdfb8703c..b27a405a0f87 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -681,6 +681,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	cpc_obj = &out_obj->package.elements[0];
 	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
 		num_ent = cpc_obj->integer.value;
+		if (num_ent <= 1) {
+			pr_debug("Unexpected _CPC NumEntries value (%d) for CPU:%d\n",
+				 num_ent, pr->id);
+			goto out_free;
+		}
 	} else {
 		pr_debug("Unexpected entry type(%d) for NumEntries\n",
 				cpc_obj->type);
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index ec2f77a47150..2837b2f98213 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -135,6 +135,81 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
 		},
 	},
+	/*
+	 * Clevo NL5xRU and NL5xNU/TUXEDO Aura 15 Gen1 and Gen2 have both a
+	 * working native and video interface. However the default detection
+	 * mechanism first registers the video interface before unregistering
+	 * it again and switching to the native interface during boot. This
+	 * results in a dangling SBIOS request for backlight change for some
+	 * reason, causing the backlight to switch to ~2% once per boot on the
+	 * first power cord connect or disconnect event. Setting the native
+	 * interface explicitly circumvents this buggy behaviour, by avoiding
+	 * the unregistering process.
+	 */
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xRU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xNU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xNU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+	},
+	{
+	.callback = video_detect_force_native,
+	.ident = "Clevo NL5xNU",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+		DMI_MATCH(DMI_BOARD_NAME, "NL5xNU"),
+		},
+	},
 
 	/*
 	 * These models have a working acpi_video backlight control, and using
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 3ba843f5cdc0..44cc02afaa8b 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -919,6 +919,20 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	irqmask &= ~0x10;
 	pci_write_config_byte(dev, 0x5a, irqmask);
 
+	/*
+	 * HPT371 chips physically have only one channel, the secondary one,
+	 * but the primary channel registers do exist!  Go figure...
+	 * So,  we manually disable the non-existing channel here
+	 * (if the BIOS hasn't done this already).
+	 */
+	if (dev->device == PCI_DEVICE_ID_TTI_HPT371) {
+		u8 mcr1;
+
+		pci_read_config_byte(dev, 0x50, &mcr1);
+		mcr1 &= ~0x04;
+		pci_write_config_byte(dev, 0x50, mcr1);
+	}
+
 	/*
 	 * default to pci clock. make sure MA15/16 are set to output
 	 * to prevent drives having problems with 40-pin cables. Needed
@@ -950,14 +964,14 @@ static int hpt37x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	if ((freq >> 12) != 0xABCDE) {
 		int i;
-		u8 sr;
+		u16 sr;
 		u32 total = 0;
 
 		pr_warn("BIOS has not set timing clocks\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for (i = 0; i < 128; i++) {
-			pci_read_config_byte(dev, 0x78, &sr);
+			pci_read_config_word(dev, 0x78, &sr);
 			total += sr & 0x1FF;
 			udelay(15);
 		}
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index ff468a6fd8dd..677f582cf3d6 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -82,6 +82,8 @@ static int marvell_cable_detect(struct ata_port *ap)
 	switch(ap->port_no)
 	{
 	case 0:
+		if (!ap->ioaddr.bmdma_addr)
+			return ATA_CBL_PATA_UNK;
 		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
 			return ATA_CBL_PATA40;
 		return ATA_CBL_PATA80;
diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 2b7786cd548f..0ec52fb2b7fc 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -1114,6 +1114,8 @@ DPRINTK("iovcnt = %d\n",skb_shinfo(skb)->nr_frags);
 	}
 	paddr = dma_map_single(&eni_dev->pci_dev->dev,skb->data,skb->len,
 			       DMA_TO_DEVICE);
+	if (dma_mapping_error(&eni_dev->pci_dev->dev, paddr))
+		return enq_next;
 	ENI_PRV_PADDR(skb) = paddr;
 	/* prepare DMA queue entries */
 	j = 0;
diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 7cb2b863e653..7d74b7e1a837 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1692,6 +1692,8 @@ static int fs_init(struct fs_dev *dev)
 	dev->hw_base = pci_resource_start(pci_dev, 0);
 
 	dev->base = ioremap(dev->hw_base, 0x1000);
+	if (!dev->base)
+		return 1;
 
 	reset_chip (dev);
   
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d707cd16ed01..b4d50c5dcbf8 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1766,7 +1766,9 @@ static bool pm_ops_is_empty(const struct dev_pm_ops *ops)
 
 void device_pm_check_callbacks(struct device *dev)
 {
-	spin_lock_irq(&dev->power.lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
 	dev->power.no_pm_callbacks =
 		(!dev->bus || (pm_ops_is_empty(dev->bus->pm) &&
 		 !dev->bus->suspend && !dev->bus->resume)) &&
@@ -1776,5 +1778,5 @@ void device_pm_check_callbacks(struct device *dev)
 		(!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
 		(!dev->driver || (pm_ops_is_empty(dev->driver->pm) &&
 		 !dev->driver->suspend && !dev->driver->resume));
-	spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4cb8f21ff4ef..4a7be81e7de9 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1696,22 +1696,22 @@ struct sib_info {
 };
 void drbd_bcast_event(struct drbd_device *device, const struct sib_info *sib);
 
-extern void notify_resource_state(struct sk_buff *,
+extern int notify_resource_state(struct sk_buff *,
 				  unsigned int,
 				  struct drbd_resource *,
 				  struct resource_info *,
 				  enum drbd_notification_type);
-extern void notify_device_state(struct sk_buff *,
+extern int notify_device_state(struct sk_buff *,
 				unsigned int,
 				struct drbd_device *,
 				struct device_info *,
 				enum drbd_notification_type);
-extern void notify_connection_state(struct sk_buff *,
+extern int notify_connection_state(struct sk_buff *,
 				    unsigned int,
 				    struct drbd_connection *,
 				    struct connection_info *,
 				    enum drbd_notification_type);
-extern void notify_peer_device_state(struct sk_buff *,
+extern int notify_peer_device_state(struct sk_buff *,
 				     unsigned int,
 				     struct drbd_peer_device *,
 				     struct peer_device_info *,
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b809f325c2be..3c9cee9520ed 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4611,7 +4611,7 @@ static int nla_put_notification_header(struct sk_buff *msg,
 	return drbd_notification_header_to_skb(msg, &nh, true);
 }
 
-void notify_resource_state(struct sk_buff *skb,
+int notify_resource_state(struct sk_buff *skb,
 			   unsigned int seq,
 			   struct drbd_resource *resource,
 			   struct resource_info *resource_info,
@@ -4653,16 +4653,17 @@ void notify_resource_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(resource, "Error %d while broadcasting event. Event seq:%u\n",
 			err, seq);
+	return err;
 }
 
-void notify_device_state(struct sk_buff *skb,
+int notify_device_state(struct sk_buff *skb,
 			 unsigned int seq,
 			 struct drbd_device *device,
 			 struct device_info *device_info,
@@ -4702,16 +4703,17 @@ void notify_device_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(device, "Error %d while broadcasting event. Event seq:%u\n",
 		 err, seq);
+	return err;
 }
 
-void notify_connection_state(struct sk_buff *skb,
+int notify_connection_state(struct sk_buff *skb,
 			     unsigned int seq,
 			     struct drbd_connection *connection,
 			     struct connection_info *connection_info,
@@ -4751,16 +4753,17 @@ void notify_connection_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(connection, "Error %d while broadcasting event. Event seq:%u\n",
 		 err, seq);
+	return err;
 }
 
-void notify_peer_device_state(struct sk_buff *skb,
+int notify_peer_device_state(struct sk_buff *skb,
 			      unsigned int seq,
 			      struct drbd_peer_device *peer_device,
 			      struct peer_device_info *peer_device_info,
@@ -4801,13 +4804,14 @@ void notify_peer_device_state(struct sk_buff *skb,
 		if (err && err != -ESRCH)
 			goto failed;
 	}
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 failed:
 	drbd_err(peer_device, "Error %d while broadcasting event. Event seq:%u\n",
 		 err, seq);
+	return err;
 }
 
 void notify_helper(enum drbd_notification_type type,
@@ -4858,7 +4862,7 @@ void notify_helper(enum drbd_notification_type type,
 		 err, seq);
 }
 
-static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
+static int notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
 {
 	struct drbd_genlmsghdr *dh;
 	int err;
@@ -4872,11 +4876,12 @@ static void notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
 	if (nla_put_notification_header(skb, NOTIFY_EXISTS))
 		goto nla_put_failure;
 	genlmsg_end(skb, dh);
-	return;
+	return 0;
 
 nla_put_failure:
 	nlmsg_free(skb);
 	pr_err("Error %d sending event. Event seq:%u\n", err, seq);
+	return err;
 }
 
 static void free_state_changes(struct list_head *list)
@@ -4903,6 +4908,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 	unsigned int seq = cb->args[2];
 	unsigned int n;
 	enum drbd_notification_type flags = 0;
+	int err = 0;
 
 	/* There is no need for taking notification_mutex here: it doesn't
 	   matter if the initial state events mix with later state chage
@@ -4911,32 +4917,32 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 
 	cb->args[5]--;
 	if (cb->args[5] == 1) {
-		notify_initial_state_done(skb, seq);
+		err = notify_initial_state_done(skb, seq);
 		goto out;
 	}
 	n = cb->args[4]++;
 	if (cb->args[4] < cb->args[3])
 		flags |= NOTIFY_CONTINUES;
 	if (n < 1) {
-		notify_resource_state_change(skb, seq, state_change->resource,
+		err = notify_resource_state_change(skb, seq, state_change->resource,
 					     NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n--;
 	if (n < state_change->n_connections) {
-		notify_connection_state_change(skb, seq, &state_change->connections[n],
+		err = notify_connection_state_change(skb, seq, &state_change->connections[n],
 					       NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n -= state_change->n_connections;
 	if (n < state_change->n_devices) {
-		notify_device_state_change(skb, seq, &state_change->devices[n],
+		err = notify_device_state_change(skb, seq, &state_change->devices[n],
 					   NOTIFY_EXISTS | flags);
 		goto next;
 	}
 	n -= state_change->n_devices;
 	if (n < state_change->n_devices * state_change->n_connections) {
-		notify_peer_device_state_change(skb, seq, &state_change->peer_devices[n],
+		err = notify_peer_device_state_change(skb, seq, &state_change->peer_devices[n],
 						NOTIFY_EXISTS | flags);
 		goto next;
 	}
@@ -4951,7 +4957,10 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[4] = 0;
 	}
 out:
-	return skb->len;
+	if (err)
+		return err;
+	else
+		return skb->len;
 }
 
 int drbd_adm_get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index eea0c4aec978..b636d9c08c0e 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1505,7 +1505,7 @@ int drbd_bitmap_io_from_worker(struct drbd_device *device,
 	return rv;
 }
 
-void notify_resource_state_change(struct sk_buff *skb,
+int notify_resource_state_change(struct sk_buff *skb,
 				  unsigned int seq,
 				  struct drbd_resource_state_change *resource_state_change,
 				  enum drbd_notification_type type)
@@ -1518,10 +1518,10 @@ void notify_resource_state_change(struct sk_buff *skb,
 		.res_susp_fen = resource_state_change->susp_fen[NEW],
 	};
 
-	notify_resource_state(skb, seq, resource, &resource_info, type);
+	return notify_resource_state(skb, seq, resource, &resource_info, type);
 }
 
-void notify_connection_state_change(struct sk_buff *skb,
+int notify_connection_state_change(struct sk_buff *skb,
 				    unsigned int seq,
 				    struct drbd_connection_state_change *connection_state_change,
 				    enum drbd_notification_type type)
@@ -1532,10 +1532,10 @@ void notify_connection_state_change(struct sk_buff *skb,
 		.conn_role = connection_state_change->peer_role[NEW],
 	};
 
-	notify_connection_state(skb, seq, connection, &connection_info, type);
+	return notify_connection_state(skb, seq, connection, &connection_info, type);
 }
 
-void notify_device_state_change(struct sk_buff *skb,
+int notify_device_state_change(struct sk_buff *skb,
 				unsigned int seq,
 				struct drbd_device_state_change *device_state_change,
 				enum drbd_notification_type type)
@@ -1545,10 +1545,10 @@ void notify_device_state_change(struct sk_buff *skb,
 		.dev_disk_state = device_state_change->disk_state[NEW],
 	};
 
-	notify_device_state(skb, seq, device, &device_info, type);
+	return notify_device_state(skb, seq, device, &device_info, type);
 }
 
-void notify_peer_device_state_change(struct sk_buff *skb,
+int notify_peer_device_state_change(struct sk_buff *skb,
 				     unsigned int seq,
 				     struct drbd_peer_device_state_change *p,
 				     enum drbd_notification_type type)
@@ -1562,7 +1562,7 @@ void notify_peer_device_state_change(struct sk_buff *skb,
 		.peer_resync_susp_dependency = p->resync_susp_dependency[NEW],
 	};
 
-	notify_peer_device_state(skb, seq, peer_device, &peer_device_info, type);
+	return notify_peer_device_state(skb, seq, peer_device, &peer_device_info, type);
 }
 
 static void broadcast_state_change(struct drbd_state_change *state_change)
@@ -1570,7 +1570,7 @@ static void broadcast_state_change(struct drbd_state_change *state_change)
 	struct drbd_resource_state_change *resource_state_change = &state_change->resource[0];
 	bool resource_state_has_changed;
 	unsigned int n_device, n_connection, n_peer_device, n_peer_devices;
-	void (*last_func)(struct sk_buff *, unsigned int, void *,
+	int (*last_func)(struct sk_buff *, unsigned int, void *,
 			  enum drbd_notification_type) = NULL;
 	void *uninitialized_var(last_arg);
 
diff --git a/drivers/block/drbd/drbd_state_change.h b/drivers/block/drbd/drbd_state_change.h
index 9e503a1a0bfb..e5a956d26866 100644
--- a/drivers/block/drbd/drbd_state_change.h
+++ b/drivers/block/drbd/drbd_state_change.h
@@ -43,19 +43,19 @@ extern struct drbd_state_change *remember_old_state(struct drbd_resource *, gfp_
 extern void copy_old_to_new_state_change(struct drbd_state_change *);
 extern void forget_state_change(struct drbd_state_change *);
 
-extern void notify_resource_state_change(struct sk_buff *,
+extern int notify_resource_state_change(struct sk_buff *,
 					 unsigned int,
 					 struct drbd_resource_state_change *,
 					 enum drbd_notification_type type);
-extern void notify_connection_state_change(struct sk_buff *,
+extern int notify_connection_state_change(struct sk_buff *,
 					   unsigned int,
 					   struct drbd_connection_state_change *,
 					   enum drbd_notification_type type);
-extern void notify_device_state_change(struct sk_buff *,
+extern int notify_device_state_change(struct sk_buff *,
 				       unsigned int,
 				       struct drbd_device_state_change *,
 				       enum drbd_notification_type type);
-extern void notify_peer_device_state_change(struct sk_buff *,
+extern int notify_peer_device_state_change(struct sk_buff *,
 					    unsigned int,
 					    struct drbd_peer_device_state_change *,
 					    enum drbd_notification_type type);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f236b7984b94..2ff17b397cd2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -773,33 +773,33 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
 {
 	int partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN);
 
-	return sprintf(buf, "%s\n", partscan ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", partscan ? "1" : "0");
 }
 
 static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 302260e9002c..45bd0d7d6a94 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -692,9 +692,17 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err) {
+		err = blk_validate_block_size(blk_size);
+		if (err) {
+			dev_err(&vdev->dev,
+				"virtio_blk: invalid block size: 0x%x\n",
+				blk_size);
+			goto out_free_tags;
+		}
+
 		blk_queue_logical_block_size(q, blk_size);
-	else
+	} else
 		blk_size = queue_logical_block_size(q);
 
 	/* Use topology information if available */
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index d420597b0d2b..17ea0ba50278 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1266,17 +1266,16 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 		list_for_each_entry_safe(persistent_gnt, n,
 					 &rinfo->grants, node) {
 			list_del(&persistent_gnt->node);
-			if (persistent_gnt->gref != GRANT_INVALID_REF) {
-				gnttab_end_foreign_access(persistent_gnt->gref,
-							  0, 0UL);
-				rinfo->persistent_gnts_c--;
-			}
+			if (persistent_gnt->gref == GRANT_INVALID_REF ||
+			    !gnttab_try_end_foreign_access(persistent_gnt->gref))
+				continue;
+
+			rinfo->persistent_gnts_c--;
 			if (info->feature_persistent)
 				__free_page(persistent_gnt->page);
 			kfree(persistent_gnt);
 		}
 	}
-	BUG_ON(rinfo->persistent_gnts_c != 0);
 
 	for (i = 0; i < BLK_RING_SIZE(info); i++) {
 		/*
@@ -1333,7 +1332,8 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 			rinfo->ring_ref[i] = GRANT_INVALID_REF;
 		}
 	}
-	free_pages((unsigned long)rinfo->ring.sring, get_order(info->nr_ring_pages * XEN_PAGE_SIZE));
+	free_pages_exact(rinfo->ring.sring,
+			 info->nr_ring_pages * XEN_PAGE_SIZE);
 	rinfo->ring.sring = NULL;
 
 	if (rinfo->irq)
@@ -1417,9 +1417,15 @@ static int blkif_get_final_status(enum blk_req_status s1,
 	return BLKIF_RSP_OKAY;
 }
 
-static bool blkif_completion(unsigned long *id,
-			     struct blkfront_ring_info *rinfo,
-			     struct blkif_response *bret)
+/*
+ * Return values:
+ *  1 response processed.
+ *  0 missing further responses.
+ * -1 error while processing.
+ */
+static int blkif_completion(unsigned long *id,
+			    struct blkfront_ring_info *rinfo,
+			    struct blkif_response *bret)
 {
 	int i = 0;
 	struct scatterlist *sg;
@@ -1493,42 +1499,43 @@ static bool blkif_completion(unsigned long *id,
 	}
 	/* Add the persistent grant into the list of free grants */
 	for (i = 0; i < num_grant; i++) {
-		if (gnttab_query_foreign_access(s->grants_used[i]->gref)) {
+		if (!gnttab_try_end_foreign_access(s->grants_used[i]->gref)) {
 			/*
 			 * If the grant is still mapped by the backend (the
 			 * backend has chosen to make this grant persistent)
 			 * we add it at the head of the list, so it will be
 			 * reused first.
 			 */
-			if (!info->feature_persistent)
-				pr_alert_ratelimited("backed has not unmapped grant: %u\n",
-						     s->grants_used[i]->gref);
+			if (!info->feature_persistent) {
+				pr_alert("backed has not unmapped grant: %u\n",
+					 s->grants_used[i]->gref);
+				return -1;
+			}
 			list_add(&s->grants_used[i]->node, &rinfo->grants);
 			rinfo->persistent_gnts_c++;
 		} else {
 			/*
-			 * If the grant is not mapped by the backend we end the
-			 * foreign access and add it to the tail of the list,
-			 * so it will not be picked again unless we run out of
-			 * persistent grants.
+			 * If the grant is not mapped by the backend we add it
+			 * to the tail of the list, so it will not be picked
+			 * again unless we run out of persistent grants.
 			 */
-			gnttab_end_foreign_access(s->grants_used[i]->gref, 0, 0UL);
 			s->grants_used[i]->gref = GRANT_INVALID_REF;
 			list_add_tail(&s->grants_used[i]->node, &rinfo->grants);
 		}
 	}
 	if (s->req.operation == BLKIF_OP_INDIRECT) {
 		for (i = 0; i < INDIRECT_GREFS(num_grant); i++) {
-			if (gnttab_query_foreign_access(s->indirect_grants[i]->gref)) {
-				if (!info->feature_persistent)
-					pr_alert_ratelimited("backed has not unmapped grant: %u\n",
-							     s->indirect_grants[i]->gref);
+			if (!gnttab_try_end_foreign_access(s->indirect_grants[i]->gref)) {
+				if (!info->feature_persistent) {
+					pr_alert("backed has not unmapped grant: %u\n",
+						 s->indirect_grants[i]->gref);
+					return -1;
+				}
 				list_add(&s->indirect_grants[i]->node, &rinfo->grants);
 				rinfo->persistent_gnts_c++;
 			} else {
 				struct page *indirect_page;
 
-				gnttab_end_foreign_access(s->indirect_grants[i]->gref, 0, 0UL);
 				/*
 				 * Add the used indirect page back to the list of
 				 * available pages for indirect grefs.
@@ -1610,12 +1617,17 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 		}
 
 		if (bret.operation != BLKIF_OP_DISCARD) {
+			int ret;
+
 			/*
 			 * We may need to wait for an extra response if the
 			 * I/O request is split in 2
 			 */
-			if (!blkif_completion(&id, rinfo, &bret))
+			ret = blkif_completion(&id, rinfo, &bret);
+			if (!ret)
 				continue;
+			if (unlikely(ret < 0))
+				goto err;
 		}
 
 		if (add_id_to_freelist(rinfo, id)) {
@@ -1717,8 +1729,7 @@ static int setup_blkring(struct xenbus_device *dev,
 	for (i = 0; i < info->nr_ring_pages; i++)
 		rinfo->ring_ref[i] = GRANT_INVALID_REF;
 
-	sring = (struct blkif_sring *)__get_free_pages(GFP_NOIO | __GFP_HIGH,
-						       get_order(ring_size));
+	sring = alloc_pages_exact(ring_size, GFP_NOIO);
 	if (!sring) {
 		xenbus_dev_fatal(dev, -ENOMEM, "allocating shared ring");
 		return -ENOMEM;
@@ -1728,7 +1739,7 @@ static int setup_blkring(struct xenbus_device *dev,
 
 	err = xenbus_grant_ring(dev, rinfo->ring.sring, info->nr_ring_pages, gref);
 	if (err < 0) {
-		free_pages((unsigned long)sring, get_order(ring_size));
+		free_pages_exact(sring, ring_size);
 		rinfo->ring.sring = NULL;
 		goto fail;
 	}
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2632b0fdb1b5..ba4c546db756 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2004,6 +2004,13 @@ static void virtcons_remove(struct virtio_device *vdev)
 	list_del(&portdev->list);
 	spin_unlock_irq(&pdrvdata_lock);
 
+	/* Device is going away, exit any polling for buffers */
+	virtio_break_device(vdev);
+	if (use_multiport(portdev))
+		flush_work(&portdev->control_work);
+	else
+		flush_work(&portdev->config_work);
+
 	/* Disable interrupts for vqs */
 	vdev->config->reset(vdev);
 	/* Finish up work that's lined up */
@@ -2277,7 +2284,7 @@ static struct virtio_driver virtio_rproc_serial = {
 	.remove =	virtcons_remove,
 };
 
-static int __init init(void)
+static int __init virtio_console_init(void)
 {
 	int err;
 
@@ -2314,7 +2321,7 @@ static int __init init(void)
 	return err;
 }
 
-static void __exit fini(void)
+static void __exit virtio_console_fini(void)
 {
 	reclaim_dma_bufs();
 
@@ -2324,8 +2331,8 @@ static void __exit fini(void)
 	class_destroy(pdrvdata.class);
 	debugfs_remove_recursive(pdrvdata.debugfs_dir);
 }
-module_init(init);
-module_exit(fini);
+module_init(virtio_console_init);
+module_exit(virtio_console_fini);
 
 MODULE_DESCRIPTION("Virtio console driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index 9193f64561f6..4dcf15a88269 100644
--- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -32,11 +32,13 @@ static const struct clk_div_table spi_div_table[] = {
 	{ .val = 1, .div = 8, },
 	{ .val = 2, .div = 2, },
 	{ .val = 3, .div = 1, },
+	{ /* sentinel */ }
 };
 
 static const struct clk_div_table timer_div_table[] = {
 	{ .val = 0, .div = 256, },
 	{ .val = 1, .div = 1, },
+	{ /* sentinel */ }
 };
 
 struct clps711x_clk {
diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
index 3466f7320b40..e3aa502761a3 100644
--- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -40,6 +40,7 @@ static const struct clk_div_table ahb_div_table[] = {
 	[1] = { .val = 1, .div = 4 },
 	[2] = { .val = 2, .div = 3 },
 	[3] = { .val = 3, .div = 3 },
+	[4] = { /* sentinel */ }
 };
 
 void __init ls1x_clk_init(void)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 29abb600d7e1..e4d605dcc03d 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -644,6 +644,7 @@ static const struct frac_entry frac_table_pixel[] = {
 	{ 2, 9 },
 	{ 4, 9 },
 	{ 1, 1 },
+	{ 2, 3 },
 	{ }
 };
 
diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 74e7544f861b..348e7196b7b9 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -190,6 +190,7 @@ static struct tegra_emc *emc_ensure_emc_driver(struct tegra_clk_emc *tegra)
 
 	tegra->emc = platform_get_drvdata(pdev);
 	if (!tegra->emc) {
+		put_device(&pdev->dev);
 		pr_err("%s: cannot find EMC driver\n", __func__);
 		return NULL;
 	}
diff --git a/drivers/clk/uniphier/clk-uniphier-fixed-rate.c b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
index 0ad0d46173c0..225de2302cb7 100644
--- a/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
+++ b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
@@ -33,6 +33,7 @@ struct clk_hw *uniphier_clk_register_fixed_rate(struct device *dev,
 
 	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
+	init.flags = 0;
 	init.parent_names = NULL;
 	init.num_parents = 0;
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index e2c6e43cf8ca..3d748eac1a68 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -305,10 +305,14 @@ config ARM_ARCH_TIMER_EVTSTREAM
 	  This must be disabled for hardware validation purposes to detect any
 	  hardware anomalies of missing events.
 
+config ARM_ARCH_TIMER_OOL_WORKAROUND
+	bool
+
 config FSL_ERRATUM_A008585
 	bool "Workaround for Freescale/NXP Erratum A-008585"
 	default y
 	depends on ARM_ARCH_TIMER && ARM64
+	select ARM_ARCH_TIMER_OOL_WORKAROUND
 	help
 	  This option enables a workaround for Freescale/NXP Erratum
 	  A-008585 ("ARM generic timer may contain an erroneous
diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 28037d0b8dcd..55348e7c1e6f 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -230,8 +230,10 @@ static int __init parse_pmtmr(char *arg)
 	int ret;
 
 	ret = kstrtouint(arg, 16, &base);
-	if (ret)
-		return ret;
+	if (ret) {
+		pr_warn("PMTMR: invalid 'pmtmr=' value: '%s'\n", arg);
+		return 1;
+	}
 
 	pr_info("PMTMR IOPort override: 0x%04x -> 0x%04x\n", pmtmr_ioport,
 		base);
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5d7f83d27093..e70d0974470c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -96,41 +96,159 @@ early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
  */
 
 #ifdef CONFIG_FSL_ERRATUM_A008585
+/*
+ * The number of retries is an arbitrary value well beyond the highest number
+ * of iterations the loop has been observed to take.
+ */
+#define __fsl_a008585_read_reg(reg) ({			\
+	u64 _old, _new;					\
+	int _retries = 200;				\
+							\
+	do {						\
+		_old = read_sysreg(reg);		\
+		_new = read_sysreg(reg);		\
+		_retries--;				\
+	} while (unlikely(_old != _new) && _retries);	\
+							\
+	WARN_ON_ONCE(!_retries);			\
+	_new;						\
+})
+
+static u32 notrace fsl_a008585_read_cntp_tval_el0(void)
+{
+	return __fsl_a008585_read_reg(cntp_tval_el0);
+}
+
+static u32 notrace fsl_a008585_read_cntv_tval_el0(void)
+{
+	return __fsl_a008585_read_reg(cntv_tval_el0);
+}
+
+static u64 notrace fsl_a008585_read_cntvct_el0(void)
+{
+	return __fsl_a008585_read_reg(cntvct_el0);
+}
+#endif
+
+#ifdef CONFIG_ARM64_ERRATUM_1188873
+static u64 notrace arm64_1188873_read_cntvct_el0(void)
+{
+	return read_sysreg(cntvct_el0);
+}
+#endif
+
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
+const struct arch_timer_erratum_workaround *timer_unstable_counter_workaround = NULL;
+EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
+
 DEFINE_STATIC_KEY_FALSE(arch_timer_read_ool_enabled);
 EXPORT_SYMBOL_GPL(arch_timer_read_ool_enabled);
 
-static int fsl_a008585_enable = -1;
+static const struct arch_timer_erratum_workaround ool_workarounds[] = {
+#ifdef CONFIG_FSL_ERRATUM_A008585
+	{
+		.match_type = ate_match_dt,
+		.id = "fsl,erratum-a008585",
+		.desc = "Freescale erratum a005858",
+		.read_cntp_tval_el0 = fsl_a008585_read_cntp_tval_el0,
+		.read_cntv_tval_el0 = fsl_a008585_read_cntv_tval_el0,
+		.read_cntvct_el0 = fsl_a008585_read_cntvct_el0,
+	},
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_1188873
+	{
+		.match_type = ate_match_local_cap_id,
+		.id = (void *)ARM64_WORKAROUND_1188873,
+		.desc = "ARM erratum 1188873",
+		.read_cntvct_el0 = arm64_1188873_read_cntvct_el0,
+	},
+#endif
+};
 
-static int __init early_fsl_a008585_cfg(char *buf)
+typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
+			       const void *);
+
+static
+bool arch_timer_check_dt_erratum(const struct arch_timer_erratum_workaround *wa,
+				 const void *arg)
 {
-	int ret;
-	bool val;
+	const struct device_node *np = arg;
 
-	ret = strtobool(buf, &val);
-	if (ret)
-		return ret;
+	return of_property_read_bool(np, wa->id);
+}
 
-	fsl_a008585_enable = val;
-	return 0;
+static
+bool arch_timer_check_local_cap_erratum(const struct arch_timer_erratum_workaround *wa,
+					const void *arg)
+{
+	return this_cpu_has_cap((uintptr_t)wa->id);
 }
-early_param("clocksource.arm_arch_timer.fsl-a008585", early_fsl_a008585_cfg);
 
-u32 __fsl_a008585_read_cntp_tval_el0(void)
+static const struct arch_timer_erratum_workaround *
+arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
+			  ate_match_fn_t match_fn,
+			  void *arg)
 {
-	return __fsl_a008585_read_reg(cntp_tval_el0);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
+		if (ool_workarounds[i].match_type != type)
+			continue;
+
+		if (match_fn(&ool_workarounds[i], arg))
+			return &ool_workarounds[i];
+	}
+
+	return NULL;
 }
 
-u32 __fsl_a008585_read_cntv_tval_el0(void)
+static
+void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa)
 {
-	return __fsl_a008585_read_reg(cntv_tval_el0);
+	timer_unstable_counter_workaround = wa;
+	static_branch_enable(&arch_timer_read_ool_enabled);
 }
 
-u64 __fsl_a008585_read_cntvct_el0(void)
+static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type type,
+					    void *arg)
 {
-	return __fsl_a008585_read_reg(cntvct_el0);
+	const struct arch_timer_erratum_workaround *wa;
+	ate_match_fn_t match_fn = NULL;
+	bool local = false;
+
+	switch (type) {
+	case ate_match_dt:
+		match_fn = arch_timer_check_dt_erratum;
+		break;
+	case ate_match_local_cap_id:
+		match_fn = arch_timer_check_local_cap_erratum;
+		local = true;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	wa = arch_timer_iterate_errata(type, match_fn, arg);
+	if (!wa)
+		return;
+
+	if (needs_unstable_timer_counter_workaround()) {
+		if (wa != timer_unstable_counter_workaround)
+			pr_warn("Can't enable workaround for %s (clashes with %s\n)",
+				wa->desc,
+				timer_unstable_counter_workaround->desc);
+		return;
+	}
+
+	arch_timer_enable_workaround(wa);
+	pr_info("Enabling %s workaround for %s\n",
+		local ? "local" : "global", wa->desc);
 }
-EXPORT_SYMBOL(__fsl_a008585_read_cntvct_el0);
-#endif /* CONFIG_FSL_ERRATUM_A008585 */
+
+#else
+#define arch_timer_check_ool_workaround(t,a)		do { } while(0)
+#endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static __always_inline
 void arch_timer_reg_write(int access, enum arch_timer_reg reg, u32 val,
@@ -281,8 +399,8 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
-static __always_inline void fsl_a008585_set_next_event(const int access,
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
+static __always_inline void erratum_set_next_event_generic(const int access,
 		unsigned long evt, struct clock_event_device *clk)
 {
 	unsigned long ctrl;
@@ -300,20 +418,20 @@ static __always_inline void fsl_a008585_set_next_event(const int access,
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-static int fsl_a008585_set_next_event_virt(unsigned long evt,
+static int erratum_set_next_event_virt(unsigned long evt,
 					   struct clock_event_device *clk)
 {
-	fsl_a008585_set_next_event(ARCH_TIMER_VIRT_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
 
-static int fsl_a008585_set_next_event_phys(unsigned long evt,
+static int erratum_set_next_event_phys(unsigned long evt,
 					   struct clock_event_device *clk)
 {
-	fsl_a008585_set_next_event(ARCH_TIMER_PHYS_ACCESS, evt, clk);
+	erratum_set_next_event_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
 	return 0;
 }
-#endif /* CONFIG_FSL_ERRATUM_A008585 */
+#endif /* CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND */
 
 static int arch_timer_set_next_event_virt(unsigned long evt,
 					  struct clock_event_device *clk)
@@ -343,16 +461,16 @@ static int arch_timer_set_next_event_phys_mem(unsigned long evt,
 	return 0;
 }
 
-static void fsl_a008585_set_sne(struct clock_event_device *clk)
+static void erratum_workaround_set_sne(struct clock_event_device *clk)
 {
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 	if (!static_branch_unlikely(&arch_timer_read_ool_enabled))
 		return;
 
 	if (arch_timer_uses_ppi == VIRT_PPI)
-		clk->set_next_event = fsl_a008585_set_next_event_virt;
+		clk->set_next_event = erratum_set_next_event_virt;
 	else
-		clk->set_next_event = fsl_a008585_set_next_event_phys;
+		clk->set_next_event = erratum_set_next_event_phys;
 #endif
 }
 
@@ -385,7 +503,9 @@ static void __arch_timer_setup(unsigned type,
 			BUG();
 		}
 
-		fsl_a008585_set_sne(clk);
+		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
+
+		erratum_workaround_set_sne(clk);
 	} else {
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
@@ -614,7 +734,7 @@ static void __init arch_counter_register(unsigned type)
 
 		clocksource_counter.archdata.vdso_direct = true;
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
+#ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
 		/*
 		 * Don't use the vdso fastpath if errata require using
 		 * the out-of-line counter accessor.
@@ -902,14 +1022,8 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
 
-#ifdef CONFIG_FSL_ERRATUM_A008585
-	if (fsl_a008585_enable < 0)
-		fsl_a008585_enable = of_property_read_bool(np, "fsl,erratum-a008585");
-	if (fsl_a008585_enable) {
-		static_branch_enable(&arch_timer_read_ool_enabled);
-		pr_info("Enabling workaround for FSL erratum A-008585\n");
-	}
-#endif
+	/* Check for globally applicable workarounds */
+	arch_timer_check_ool_workaround(ate_match_dt, np);
 
 	/*
 	 * If we cannot rely on firmware initializing the timer registers then
diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index c4581510c3a1..6f9e228fc8ad 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -621,6 +621,20 @@ static int ccp_terminate_all(struct dma_chan *dma_chan)
 	return 0;
 }
 
+static void ccp_dma_release(struct ccp_device *ccp)
+{
+	struct ccp_dma_chan *chan;
+	struct dma_chan *dma_chan;
+	unsigned int i;
+
+	for (i = 0; i < ccp->cmd_q_count; i++) {
+		chan = ccp->ccp_dma_chan + i;
+		dma_chan = &chan->dma_chan;
+		tasklet_kill(&chan->cleanup_tasklet);
+		list_del_rcu(&dma_chan->device_node);
+	}
+}
+
 int ccp_dmaengine_register(struct ccp_device *ccp)
 {
 	struct ccp_dma_chan *chan;
@@ -715,6 +729,7 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
 	return 0;
 
 err_reg:
+	ccp_dma_release(ccp);
 	kmem_cache_destroy(ccp->dma_desc_cache);
 
 err_cache:
@@ -728,6 +743,7 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
 	struct dma_device *dma_dev = &ccp->dma_dev;
 
 	dma_async_device_unregister(dma_dev);
+	ccp_dma_release(ccp);
 
 	kmem_cache_destroy(ccp->dma_desc_cache);
 	kmem_cache_destroy(ccp->dma_cmd_cache);
diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 0e14a6642de4..ad714798f5d8 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -328,7 +328,7 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 		memset(key + AES_KEYSIZE_128, 0, AES_KEYSIZE_128);
 	}
 
-	for_each_sg(req->src, src, sg_nents(src), i) {
+	for_each_sg(req->src, src, sg_nents(req->src), i) {
 		src_buf = sg_virt(src);
 		len = sg_dma_len(src);
 		tlen += len;
diff --git a/drivers/crypto/qat/qat_common/qat_crypto.c b/drivers/crypto/qat/qat_common/qat_crypto.c
index 3852d31ce0a4..37a9f969c59c 100644
--- a/drivers/crypto/qat/qat_common/qat_crypto.c
+++ b/drivers/crypto/qat/qat_common/qat_crypto.c
@@ -170,6 +170,14 @@ int qat_crypto_dev_config(struct adf_accel_dev *accel_dev)
 		goto err;
 	if (adf_cfg_section_add(accel_dev, "Accelerator0"))
 		goto err;
+
+	/* Temporarily set the number of crypto instances to zero to avoid
+	 * registering the crypto algorithms.
+	 * This will be removed when the algorithms will support the
+	 * CRYPTO_TFM_REQ_MAY_BACKLOG flag
+	 */
+	instances = 0;
+
 	for (i = 0; i < instances; i++) {
 		val = i;
 		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_BANK_NUM, i);
diff --git a/drivers/crypto/vmx/Kconfig b/drivers/crypto/vmx/Kconfig
index c3d524ea6998..f39eeca87932 100644
--- a/drivers/crypto/vmx/Kconfig
+++ b/drivers/crypto/vmx/Kconfig
@@ -1,7 +1,11 @@
 config CRYPTO_DEV_VMX_ENCRYPT
 	tristate "Encryption acceleration support on P8 CPU"
 	depends on CRYPTO_DEV_VMX
+	select CRYPTO_AES
+	select CRYPTO_CBC
+	select CRYPTO_CTR
 	select CRYPTO_GHASH
+	select CRYPTO_XTS
 	default m
 	help
 	  Support for VMX cryptographic acceleration instructions on Power8 CPU.
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c15ca560fe60..ca266fcca186 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1392,7 +1392,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
-	struct at_xdmac_desc	*desc, *_desc;
+	struct at_xdmac_desc	*desc, *_desc, *iter;
 	struct list_head	*descs_list;
 	enum dma_status		ret;
 	int			residue, retry;
@@ -1507,11 +1507,13 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 * microblock.
 	 */
 	descs_list = &desc->descs_list;
-	list_for_each_entry_safe(desc, _desc, descs_list, desc_node) {
-		dwidth = at_xdmac_get_dwidth(desc->lld.mbr_cfg);
-		residue -= (desc->lld.mbr_ubc & 0xffffff) << dwidth;
-		if ((desc->lld.mbr_nda & 0xfffffffc) == cur_nda)
+	list_for_each_entry_safe(iter, _desc, descs_list, desc_node) {
+		dwidth = at_xdmac_get_dwidth(iter->lld.mbr_cfg);
+		residue -= (iter->lld.mbr_ubc & 0xffffff) << dwidth;
+		if ((iter->lld.mbr_nda & 0xfffffffc) == cur_nda) {
+			desc = iter;
 			break;
+		}
 	}
 	residue += cur_ubc << dwidth;
 
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 558d509b7d85..4337cf9defc2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1528,7 +1528,7 @@ static int sdma_event_remap(struct sdma_engine *sdma)
 	u32 reg, val, shift, num_map, i;
 	int ret = 0;
 
-	if (IS_ERR(np) || IS_ERR(gpr_np))
+	if (IS_ERR(np) || !gpr_np)
 		goto out;
 
 	event_remap = of_find_property(np, propname, NULL);
@@ -1576,7 +1576,7 @@ static int sdma_event_remap(struct sdma_engine *sdma)
 	}
 
 out:
-	if (!IS_ERR(gpr_np))
+	if (gpr_np)
 		of_node_put(gpr_np);
 
 	return ret;
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index fceaafd67ec6..e619ced030d5 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -763,6 +763,7 @@ int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
 {
 	const struct efivar_operations *ops;
 	efi_status_t status;
+	unsigned long varsize;
 
 	if (!__efivars)
 		return -EINVAL;
@@ -785,15 +786,17 @@ int efivar_entry_set_safe(efi_char16_t *name, efi_guid_t vendor, u32 attributes,
 		return efivar_entry_set_nonblocking(name, vendor, attributes,
 						    size, data);
 
+	varsize = size + ucs2_strsize(name, 1024);
 	if (!block) {
 		if (down_trylock(&efivars_lock))
 			return -EBUSY;
+		status = check_var_size_nonblocking(attributes, varsize);
 	} else {
 		if (down_interruptible(&efivars_lock))
 			return -EINTR;
+		status = check_var_size(attributes, varsize);
 	}
 
-	status = check_var_size(attributes, size + ucs2_strsize(name, 1024));
 	if (status != EFI_SUCCESS) {
 		up(&efivars_lock);
 		return -ENOSPC;
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 79a48c37fb35..2a6d9572d639 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -64,6 +64,21 @@ struct psci_operations psci_ops = {
 	.smccc_version = SMCCC_VERSION_1_0,
 };
 
+enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
+{
+	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
+		return SMCCC_CONDUIT_NONE;
+
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_SMC:
+		return SMCCC_CONDUIT_SMC;
+	case PSCI_CONDUIT_HVC:
+		return SMCCC_CONDUIT_HVC;
+	default:
+		return SMCCC_CONDUIT_NONE;
+	}
+}
+
 typedef unsigned long (psci_fn)(unsigned long, unsigned long,
 				unsigned long, unsigned long);
 static psci_fn *invoke_psci_fn;
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 595bf12e7653..062d0eb50799 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -462,12 +462,12 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	err = kobject_init_and_add(&entry->kobj, &fw_cfg_sysfs_entry_ktype,
 				   fw_cfg_sel_ko, "%d", entry->f.select);
 	if (err)
-		goto err_register;
+		goto err_put_entry;
 
 	/* add raw binary content access */
 	err = sysfs_create_bin_file(&entry->kobj, &fw_cfg_sysfs_attr_raw);
 	if (err)
-		goto err_add_raw;
+		goto err_del_entry;
 
 	/* try adding "/sys/firmware/qemu_fw_cfg/by_name/" symlink */
 	fw_cfg_build_symlink(fw_cfg_fname_kset, &entry->kobj, entry->f.name);
@@ -476,10 +476,10 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 	fw_cfg_sysfs_cache_enlist(entry);
 	return 0;
 
-err_add_raw:
+err_del_entry:
 	kobject_del(&entry->kobj);
-err_register:
-	kfree(entry);
+err_put_entry:
+	kobject_put(&entry->kobj);
 	return err;
 }
 
diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index 5bd21725e604..930a6098b758 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -1,7 +1,7 @@
 /*
  * Digital I/O driver for Technologic Systems I2C FPGA Core
  *
- * Copyright (C) 2015 Technologic Systems
+ * Copyright (C) 2015, 2018 Technologic Systems
  * Copyright (C) 2016 Savoir-Faire Linux
  *
  * This program is free software; you can redistribute it and/or
@@ -52,19 +52,33 @@ static int ts4900_gpio_direction_input(struct gpio_chip *chip,
 {
 	struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
 
-	/*
-	 * This will clear the output enable bit, the other bits are
-	 * dontcare when this is cleared
+	/* Only clear the OE bit here, requires a RMW. Prevents potential issue
+	 * with OE and data getting to the physical pin at different times.
 	 */
-	return regmap_write(priv->regmap, offset, 0);
+	return regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OE, 0);
 }
 
 static int ts4900_gpio_direction_output(struct gpio_chip *chip,
 					unsigned int offset, int value)
 {
 	struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
+	unsigned int reg;
 	int ret;
 
+	/* If changing from an input to an output, we need to first set the
+	 * proper data bit to what is requested and then set OE bit. This
+	 * prevents a glitch that can occur on the IO line
+	 */
+	regmap_read(priv->regmap, offset, &reg);
+	if (!(reg & TS4900_GPIO_OE)) {
+		if (value)
+			reg = TS4900_GPIO_OUT;
+		else
+			reg &= ~TS4900_GPIO_OUT;
+
+		regmap_write(priv->regmap, offset, reg);
+	}
+
 	if (value)
 		ret = regmap_write(priv->regmap, offset, TS4900_GPIO_OE |
 							 TS4900_GPIO_OUT);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 6a3470f84998..732713ff3190 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -607,6 +607,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 	event_waiters = kmalloc_array(num_events,
 					sizeof(struct kfd_event_waiter),
 					GFP_KERNEL);
+	if (!event_waiters)
+		return NULL;
 
 	for (i = 0; (event_waiters) && (i < num_events) ; i++) {
 		INIT_LIST_HEAD(&event_waiters[i].waiters);
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 5b5970f0e91d..6f93250518e3 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3791,16 +3791,8 @@ static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
 		  connector->name, dc_bpc);
 	info->bpc = dc_bpc;
 
-	/*
-	 * Deep color support mandates RGB444 support for all video
-	 * modes and forbids YCRCB422 support for all video modes per
-	 * HDMI 1.3 spec.
-	 */
-	info->color_formats = DRM_COLOR_FORMAT_RGB444;
-
 	/* YCRCB444 is optional according to spec. */
 	if (hdmi[6] & DRM_EDID_HDMI_DC_Y444) {
-		info->color_formats |= DRM_COLOR_FORMAT_YCRCB444;
 		DRM_DEBUG("%s: HDMI sink does YCRCB444 in deep color.\n",
 			  connector->name);
 	}
@@ -3886,6 +3878,7 @@ static void drm_add_display_info(struct drm_connector *connector,
 	if (!(edid->input & DRM_EDID_INPUT_DIGITAL))
 		return;
 
+	info->color_formats |= DRM_COLOR_FORMAT_RGB444;
 	drm_parse_cea_ext(connector, edid);
 
 	/*
@@ -3934,7 +3927,6 @@ static void drm_add_display_info(struct drm_connector *connector,
 	DRM_DEBUG("%s: Assigning EDID-1.4 digital sink color depth as %d bpc.\n",
 			  connector->name, info->bpc);
 
-	info->color_formats |= DRM_COLOR_FORMAT_RGB444;
 	if (edid->features & DRM_EDID_FEATURE_RGB_YCRCB444)
 		info->color_formats |= DRM_COLOR_FORMAT_YCRCB444;
 	if (edid->features & DRM_EDID_FEATURE_RGB_YCRCB422)
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index d796ada2a47a..924a11232b84 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -83,8 +83,10 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		ret = of_get_drm_display_mode(np, &imxpd->mode,
 					      &imxpd->bus_flags,
 					      OF_USE_NATIVE_MODE);
-		if (ret)
+		if (ret) {
+			drm_mode_destroy(connector->dev, mode);
 			return ret;
+		}
 
 		drm_mode_copy(mode, &imxpd->mode);
 		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c
index 83bf997dda03..e14bfbdbaf2b 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_plane.c
@@ -192,7 +192,10 @@ static void mdp5_plane_reset(struct drm_plane *plane)
 		drm_framebuffer_unreference(plane->state->fb);
 
 	kfree(to_mdp5_plane_state(plane->state));
+	plane->state = NULL;
 	mdp5_state = kzalloc(sizeof(*mdp5_state), GFP_KERNEL);
+	if (!mdp5_state)
+		return;
 
 	/* assign default blend parameters */
 	mdp5_state->alpha = 255;
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 3dea1216bafd..dfd9e0b9582d 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1475,8 +1475,10 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 		dsi->slave = platform_get_drvdata(gangster);
 		of_node_put(np);
 
-		if (!dsi->slave)
+		if (!dsi->slave) {
+			put_device(&gangster->dev);
 			return -EPROBE_DEFER;
+		}
 
 		dsi->slave->master = dsi;
 	}
diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index a8d87ddd8a17..dc0511b22600 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -460,8 +460,9 @@ static void ipu_di_config_clock(struct ipu_di *di,
 
 		error = rate / (sig->mode.pixelclock / 1000);
 
-		dev_dbg(di->ipu->dev, "  IPU clock can give %lu with divider %u, error %d.%u%%\n",
-			rate, div, (signed)(error - 1000) / 10, error % 10);
+		dev_dbg(di->ipu->dev, "  IPU clock can give %lu with divider %u, error %c%d.%d%%\n",
+			rate, div, error < 1000 ? '-' : '+',
+			abs(error - 1000) / 10, abs(error - 1000) % 10);
 
 		/* Allow a 1% error */
 		if (error < 1010 && error >= 990) {
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 3cafa1d28fed..07dea71d41fc 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -833,7 +833,9 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_F22] = "F22",			[KEY_F23] = "F23",
 	[KEY_F24] = "F24",			[KEY_PLAYCD] = "PlayCD",
 	[KEY_PAUSECD] = "PauseCD",		[KEY_PROG3] = "Prog3",
-	[KEY_PROG4] = "Prog4",			[KEY_SUSPEND] = "Suspend",
+	[KEY_PROG4] = "Prog4",
+	[KEY_ALL_APPLICATIONS] = "AllApplications",
+	[KEY_SUSPEND] = "Suspend",
 	[KEY_CLOSE] = "Close",			[KEY_PLAY] = "Play",
 	[KEY_FASTFORWARD] = "FastForward",	[KEY_BASSBOOST] = "BassBoost",
 	[KEY_PRINT] = "Print",			[KEY_HP] = "HP",
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5e1a51ba6500..1dccc072da4a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -937,6 +937,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
 		case 0x28c: map_key_clear(KEY_SEND);		break;
 
+		case 0x2a2: map_key_clear(KEY_ALL_APPLICATIONS);	break;
+
 		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
 		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
 		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 518ccf15188e..26c7701fb188 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -643,6 +643,17 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
 	if (report_type == HID_OUTPUT_REPORT)
 		return -EINVAL;
 
+	/*
+	 * In case of unnumbered reports the response from the device will
+	 * not have the report ID that the upper layers expect, so we need
+	 * to stash it the buffer ourselves and adjust the data size.
+	 */
+	if (!report_number) {
+		buf[0] = 0;
+		buf++;
+		count--;
+	}
+
 	/* +2 bytes to include the size of the reply in the query buffer */
 	ask_count = min(count + 2, (size_t)ihid->bufsize);
 
@@ -664,6 +675,9 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
 	count = min(count, ret_count - 2);
 	memcpy(buf, ihid->rawbuf + 2, count);
 
+	if (!report_number)
+		count++;
+
 	return count;
 }
 
@@ -680,17 +694,19 @@ static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 
 	mutex_lock(&ihid->reset_lock);
 
-	if (report_id) {
-		buf++;
-		count--;
-	}
-
+	/*
+	 * Note that both numbered and unnumbered reports passed here
+	 * are supposed to have report ID stored in the 1st byte of the
+	 * buffer, so we strip it off unconditionally before passing payload
+	 * to i2c_hid_set_or_send_report which takes care of encoding
+	 * everything properly.
+	 */
 	ret = i2c_hid_set_or_send_report(client,
 				report_type == HID_FEATURE_REPORT ? 0x03 : 0x02,
-				report_id, buf, count, use_data);
+				report_id, buf + 1, count - 1, use_data);
 
-	if (report_id && ret >= 0)
-		ret++; /* add report_id to the number of transfered bytes */
+	if (ret >= 0)
+		ret++; /* add report_id to the number of transferred bytes */
 
 	mutex_unlock(&ihid->reset_lock);
 
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index bfcb13bae34b..8b6acb7497e2 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -262,6 +262,7 @@ enum pmbus_regs {
 /*
  * STATUS_VOUT, STATUS_INPUT
  */
+#define PB_VOLTAGE_VIN_OFF		BIT(3)
 #define PB_VOLTAGE_UV_FAULT		BIT(4)
 #define PB_VOLTAGE_UV_WARNING		BIT(5)
 #define PB_VOLTAGE_OV_WARNING		BIT(6)
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 0d75bc7b5065..a662702632a8 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1133,7 +1133,7 @@ static const struct pmbus_limit_attr vin_limit_attrs[] = {
 		.reg = PMBUS_VIN_UV_FAULT_LIMIT,
 		.attr = "lcrit",
 		.alarm = "lcrit_alarm",
-		.sbit = PB_VOLTAGE_UV_FAULT,
+		.sbit = PB_VOLTAGE_UV_FAULT | PB_VOLTAGE_VIN_OFF,
 	}, {
 		.reg = PMBUS_VIN_OV_WARN_LIMIT,
 		.attr = "max",
@@ -1818,10 +1818,14 @@ static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
 {
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
 	u8 page = rdev_get_id(rdev);
 	int ret;
 
+	mutex_lock(&data->update_lock);
 	ret = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
+	mutex_unlock(&data->update_lock);
+
 	if (ret < 0)
 		return ret;
 
@@ -1832,11 +1836,17 @@ static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
 {
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
 	u8 page = rdev_get_id(rdev);
+	int ret;
 
-	return pmbus_update_byte_data(client, page, PMBUS_OPERATION,
-				      PB_OPERATION_CONTROL_ON,
-				      enable ? PB_OPERATION_CONTROL_ON : 0);
+	mutex_lock(&data->update_lock);
+	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
+				     PB_OPERATION_CONTROL_ON,
+				     enable ? PB_OPERATION_CONTROL_ON : 0);
+	mutex_unlock(&data->update_lock);
+
+	return ret;
 }
 
 static int pmbus_regulator_enable(struct regulator_dev *rdev)
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 68c350c704fb..5fd9b6769d42 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -438,7 +438,7 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 	if (nowayout)
 		set_bit(WDOG_NO_WAY_OUT, &data->wddev.status);
 	if (output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)
-		set_bit(WDOG_ACTIVE, &data->wddev.status);
+		set_bit(WDOG_HW_RUNNING, &data->wddev.status);
 
 	/* Since the watchdog uses a downcounter there is no register to read
 	   the BIOS set timeout from (if any was set at all) ->
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 00904c6b5b5e..1bf107af8ce0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -379,8 +379,12 @@ static ssize_t mode_store(struct device *dev,
 	mode = ETM_MODE_QELEM(config->mode);
 	/* start by clearing QE bits */
 	config->cfg &= ~(BIT(13) | BIT(14));
-	/* if supported, Q elements with instruction counts are enabled */
-	if ((mode & BIT(0)) && (drvdata->q_support & BIT(0)))
+	/*
+	 * if supported, Q elements with instruction counts are enabled.
+	 * Always set the low bit for any requested mode. Valid combos are
+	 * 0b00, 0b01 and 0b11.
+	 */
+	if (mode && drvdata->q_support)
 		config->cfg |= BIT(13);
 	/*
 	 * if supported, Q elements with and without instruction
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 759c621a860a..be4b7b1ad39b 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -783,7 +783,7 @@ config I2C_PXA_SLAVE
 
 config I2C_QUP
 	tristate "Qualcomm QUP based I2C controller"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Qualcomm SoCs.
diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 7ed09865cb4b..4729c14b7501 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -28,6 +28,11 @@
 #define BCM2835_I2C_FIFO	0x10
 #define BCM2835_I2C_DIV		0x14
 #define BCM2835_I2C_DEL		0x18
+/*
+ * 16-bit field for the number of SCL cycles to wait after rising SCL
+ * before deciding the slave is not responding. 0 disables the
+ * timeout detection.
+ */
 #define BCM2835_I2C_CLKT	0x1c
 
 #define BCM2835_I2C_C_READ	BIT(0)
@@ -313,6 +318,12 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	adap->dev.of_node = pdev->dev.of_node;
 	adap->quirks = &bcm2835_i2c_quirks;
 
+	/*
+	 * Disable the hardware clock stretching timeout. SMBUS
+	 * specifies a limit for how long the device can stretch the
+	 * clock, but core I2C doesn't.
+	 */
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_CLKT, 0);
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
 
 	ret = i2c_add_adapter(adap);
diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index df1dbc92a024..25c877654c32 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -145,6 +145,12 @@ static int pasemi_i2c_xfer_msg(struct i2c_adapter *adapter,
 
 		TXFIFO_WR(smbus, msg->buf[msg->len-1] |
 			  (stop ? MTXFIFO_STOP : 0));
+
+		if (stop) {
+			err = pasemi_smb_waitready(smbus);
+			if (err)
+				goto reset_out;
+		}
 	}
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index b72cf2f8da5c..c65a5d0af555 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -727,7 +727,6 @@ static const struct i2c_algorithm xiic_algorithm = {
 
 static struct i2c_adapter xiic_adapter = {
 	.owner = THIS_MODULE,
-	.name = DRIVER_NAME,
 	.class = I2C_CLASS_DEPRECATED,
 	.algo = &xiic_algorithm,
 };
@@ -763,6 +762,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
+	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
+		 DRIVER_NAME " %s", pdev->name);
 
 	mutex_init(&i2c->lock);
 	init_waitqueue_head(&i2c->wait);
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index a86c511c29e0..c347860b3690 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -259,7 +259,7 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 	err = device_create_file(&pdev->dev, &dev_attr_available_masters);
 	if (err)
-		goto err_rollback;
+		goto err_rollback_activation;
 
 	err = device_create_file(&pdev->dev, &dev_attr_current_master);
 	if (err)
@@ -269,8 +269,9 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 err_rollback_available:
 	device_remove_file(&pdev->dev, &dev_attr_available_masters);
-err_rollback:
+err_rollback_activation:
 	i2c_demux_deactivate_master(priv);
+err_rollback:
 	for (j = 0; j < i; j++) {
 		of_node_put(priv->chan[j].parent_np);
 		of_changeset_destroy(&priv->chan[j].chgset);
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index 8f3606de4eaf..47be2cd2c60d 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -107,6 +107,7 @@ static int men_z188_probe(struct mcb_device *dev,
 	struct z188_adc *adc;
 	struct iio_dev *indio_dev;
 	struct resource *mem;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&dev->dev, sizeof(struct z188_adc));
 	if (!indio_dev)
@@ -133,8 +134,14 @@ static int men_z188_probe(struct mcb_device *dev,
 	adc->mem = mem;
 	mcb_set_drvdata(dev, indio_dev);
 
-	return iio_device_register(indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_unmap;
+
+	return 0;
 
+err_unmap:
+	iounmap(adc->base);
 err:
 	mcb_release_mem(mem);
 	return -ENXIO;
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index becbb0aef232..5075f594d97f 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -927,6 +927,8 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 				twl6030_gpadc_irq_handler,
 				IRQF_ONESHOT, "twl6030_gpadc", indio_dev);
+	if (ret)
+		return ret;
 
 	ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
 	if (ret < 0) {
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c4757e6367e7..218cf4567ab5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -591,13 +591,35 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int raw, int *processed, unsigned int scale)
 {
-	int scale_type, scale_val, scale_val2, offset;
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
 	s64 raw64 = raw;
-	int ret;
 
-	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
-	if (ret >= 0)
-		raw64 += offset;
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+	if (offset_type >= 0) {
+		switch (offset_type) {
+		case IIO_VAL_INT:
+			break;
+		case IIO_VAL_INT_PLUS_MICRO:
+		case IIO_VAL_INT_PLUS_NANO:
+			/*
+			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
+			 * implicitely truncate the offset to it's integer form.
+			 */
+			break;
+		case IIO_VAL_FRACTIONAL:
+			offset_val /= offset_val2;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			offset_val >>= offset_val2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		raw64 += offset_val;
+	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
@@ -606,7 +628,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-		*processed = raw64 * scale_val;
+		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index af68be201c29..67b993f4ec91 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3646,9 +3646,11 @@ static void srp_remove_one(struct ib_device *device, void *client_data)
 		spin_unlock(&host->target_lock);
 
 		/*
-		 * Wait for tl_err and target port removal tasks.
+		 * srp_queue_remove_work() queues a call to
+		 * srp_remove_target(). The latter function cancels
+		 * target->tl_err_work so waiting for the remove works to
+		 * finish is sufficient.
 		 */
-		flush_workqueue(system_long_wq);
 		flush_workqueue(srp_remove_wq);
 
 		kfree(host);
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 16f5d5660053..44015e6bd6a0 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -132,55 +132,21 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
 	return 0;
 }
 
-static int elan_enable_power(struct elan_tp_data *data)
+static int elan_set_power(struct elan_tp_data *data, bool on)
 {
 	int repeat = ETP_RETRY_COUNT;
 	int error;
 
-	error = regulator_enable(data->vcc);
-	if (error) {
-		dev_err(&data->client->dev,
-			"failed to enable regulator: %d\n", error);
-		return error;
-	}
-
 	do {
-		error = data->ops->power_control(data->client, true);
+		error = data->ops->power_control(data->client, on);
 		if (error >= 0)
 			return 0;
 
 		msleep(30);
 	} while (--repeat > 0);
 
-	dev_err(&data->client->dev, "failed to enable power: %d\n", error);
-	return error;
-}
-
-static int elan_disable_power(struct elan_tp_data *data)
-{
-	int repeat = ETP_RETRY_COUNT;
-	int error;
-
-	do {
-		error = data->ops->power_control(data->client, false);
-		if (!error) {
-			error = regulator_disable(data->vcc);
-			if (error) {
-				dev_err(&data->client->dev,
-					"failed to disable regulator: %d\n",
-					error);
-				/* Attempt to power the chip back up */
-				data->ops->power_control(data->client, true);
-				break;
-			}
-
-			return 0;
-		}
-
-		msleep(30);
-	} while (--repeat > 0);
-
-	dev_err(&data->client->dev, "failed to disable power: %d\n", error);
+	dev_err(&data->client->dev, "failed to set power %s: %d\n",
+		on ? "on" : "off", error);
 	return error;
 }
 
@@ -1195,9 +1161,19 @@ static int __maybe_unused elan_suspend(struct device *dev)
 		/* Enable wake from IRQ */
 		data->irq_wake = (enable_irq_wake(client->irq) == 0);
 	} else {
-		ret = elan_disable_power(data);
+		ret = elan_set_power(data, false);
+		if (ret)
+			goto err;
+
+		ret = regulator_disable(data->vcc);
+		if (ret) {
+			dev_err(dev, "error %d disabling regulator\n", ret);
+			/* Attempt to power the chip back up */
+			elan_set_power(data, true);
+		}
 	}
 
+err:
 	mutex_unlock(&data->sysfs_mutex);
 	return ret;
 }
@@ -1208,12 +1184,18 @@ static int __maybe_unused elan_resume(struct device *dev)
 	struct elan_tp_data *data = i2c_get_clientdata(client);
 	int error;
 
-	if (device_may_wakeup(dev) && data->irq_wake) {
+	if (!device_may_wakeup(dev)) {
+		error = regulator_enable(data->vcc);
+		if (error) {
+			dev_err(dev, "error %d enabling regulator\n", error);
+			goto err;
+		}
+	} else if (data->irq_wake) {
 		disable_irq_wake(client->irq);
 		data->irq_wake = false;
 	}
 
-	error = elan_enable_power(data);
+	error = elan_set_power(data, true);
 	if (error) {
 		dev_err(dev, "power up when resuming failed: %d\n", error);
 		goto err;
diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 5a7e5e073e52..58c0705470be 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1821,15 +1821,13 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	input_set_abs_params(inputdev, ABS_TILT_Y, AIPTEK_TILT_MIN, AIPTEK_TILT_MAX, 0, 0);
 	input_set_abs_params(inputdev, ABS_WHEEL, AIPTEK_WHEEL_MIN, AIPTEK_WHEEL_MAX - 1, 0, 0);
 
-	/* Verify that a device really has an endpoint */
-	if (intf->cur_altsetting->desc.bNumEndpoints < 1) {
+	err = usb_find_common_endpoints(intf->cur_altsetting,
+					NULL, NULL, &endpoint, NULL);
+	if (err) {
 		dev_err(&intf->dev,
-			"interface has %d endpoints, but must have minimum 1\n",
-			intf->cur_altsetting->desc.bNumEndpoints);
-		err = -EINVAL;
+			"interface has no int in endpoints, but must have minimum 1\n");
 		goto fail3;
 	}
-	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
 	/* Go set up our URB, which is called when the tablet receives
 	 * input.
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 48d382008788..db40ce599e97 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1171,6 +1171,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 				dev_info(smmu->dev, "\t0x%016llx\n",
 					 (unsigned long long)evt[i]);
 
+			cond_resched();
 		}
 
 		/*
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 9694529b709d..330beb62d015 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -108,6 +108,7 @@ static int __init nvic_of_init(struct device_node *node,
 
 	if (!nvic_irq_domain) {
 		pr_warn("Failed to allocate irq domain\n");
+		iounmap(nvic_base);
 		return -ENOMEM;
 	}
 
@@ -117,6 +118,7 @@ static int __init nvic_of_init(struct device_node *node,
 	if (ret) {
 		pr_warn("Failed to allocate irq chips\n");
 		irq_domain_remove(nvic_irq_domain);
+		iounmap(nvic_base);
 		return ret;
 	}
 
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index eb2659a12310..70245782e7f6 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -16,6 +16,7 @@
 #include <linux/dm-ioctl.h>
 #include <linux/hdreg.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 
 #include <asm/uaccess.h>
 
@@ -1642,6 +1643,7 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
 	if (unlikely(cmd >= ARRAY_SIZE(_ioctls)))
 		return NULL;
 
+	cmd = array_index_nospec(cmd, ARRAY_SIZE(_ioctls));
 	*ioctl_flags = _ioctls[cmd].flags;
 	return _ioctls[cmd].fn;
 }
diff --git a/drivers/media/pci/cx88/cx88-mpeg.c b/drivers/media/pci/cx88/cx88-mpeg.c
index 245357adbc25..37d4512f3eb8 100644
--- a/drivers/media/pci/cx88/cx88-mpeg.c
+++ b/drivers/media/pci/cx88/cx88-mpeg.c
@@ -175,6 +175,9 @@ int cx8802_start_dma(struct cx8802_dev    *dev,
 	cx_write(MO_TS_GPCNTRL, GP_COUNT_CONTROL_RESET);
 	q->count = 0;
 
+	/* clear interrupt status register */
+	cx_write(MO_TS_INTSTAT,  0x1f1111);
+
 	/* enable irqs */
 	dprintk( 1, "setting the interrupt mask\n" );
 	cx_set(MO_PCI_INTMSK, core->pci_irqmask | PCI_INT_TSINT);
diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index 0380cf2e5775..736719d6d648 100644
--- a/drivers/media/platform/davinci/vpif.c
+++ b/drivers/media/platform/davinci/vpif.c
@@ -437,6 +437,7 @@ static int vpif_probe(struct platform_device *pdev)
 
 static int vpif_remove(struct platform_device *pdev)
 {
+	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
diff --git a/drivers/media/usb/go7007/s2250-board.c b/drivers/media/usb/go7007/s2250-board.c
index 1466db150d82..625e77f4dbd2 100644
--- a/drivers/media/usb/go7007/s2250-board.c
+++ b/drivers/media/usb/go7007/s2250-board.c
@@ -512,6 +512,7 @@ static int s2250_probe(struct i2c_client *client,
 	u8 *data;
 	struct go7007 *go = i2c_get_adapdata(adapter);
 	struct go7007_usb *usb = go->hpi_context;
+	int err = -EIO;
 
 	audio = i2c_new_dummy(adapter, TLV320_ADDRESS >> 1);
 	if (audio == NULL)
@@ -540,11 +541,8 @@ static int s2250_probe(struct i2c_client *client,
 		V4L2_CID_HUE, -512, 511, 1, 0);
 	sd->ctrl_handler = &state->hdl;
 	if (state->hdl.error) {
-		int err = state->hdl.error;
-
-		v4l2_ctrl_handler_free(&state->hdl);
-		kfree(state);
-		return err;
+		err = state->hdl.error;
+		goto fail;
 	}
 
 	state->std = V4L2_STD_NTSC;
@@ -608,7 +606,7 @@ static int s2250_probe(struct i2c_client *client,
 	i2c_unregister_device(audio);
 	v4l2_ctrl_handler_free(&state->hdl);
 	kfree(state);
-	return -EIO;
+	return err;
 }
 
 static int s2250_remove(struct i2c_client *client)
diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
index 474c11e1d495..cfd8c09f9ded 100644
--- a/drivers/media/usb/hdpvr/hdpvr-video.c
+++ b/drivers/media/usb/hdpvr/hdpvr-video.c
@@ -312,7 +312,6 @@ static int hdpvr_start_streaming(struct hdpvr_device *dev)
 
 	dev->status = STATUS_STREAMING;
 
-	INIT_WORK(&dev->worker, hdpvr_transmit_buffers);
 	schedule_work(&dev->worker);
 
 	v4l2_dbg(MSG_BUFFER, hdpvr_debug, &dev->v4l2_dev,
@@ -1156,6 +1155,9 @@ int hdpvr_register_videodev(struct hdpvr_device *dev, struct device *parent,
 	bool ac3 = dev->flags & HDPVR_FLAG_AC3_CAP;
 	int res;
 
+	// initialize dev->worker
+	INIT_WORK(&dev->worker, hdpvr_transmit_buffers);
+
 	dev->cur_std = V4L2_STD_525_60;
 	dev->width = 720;
 	dev->height = 480;
diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 88c32b8dc88a..9f293b931144 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1425,7 +1425,7 @@ static struct emif_data *__init_or_module get_device_details(
 	temp	= devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	dev_info = devm_kzalloc(dev, sizeof(*dev_info), GFP_KERNEL);
 
-	if (!emif || !pd || !dev_info) {
+	if (!emif || !temp || !dev_info) {
 		dev_err(dev, "%s:%d: allocation error\n", __func__, __LINE__);
 		goto error;
 	}
@@ -1517,7 +1517,7 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 {
 	struct emif_data	*emif;
 	struct resource		*res;
-	int			irq;
+	int			irq, ret;
 
 	if (pdev->dev.of_node)
 		emif = of_get_memory_device_details(pdev->dev.of_node, &pdev->dev);
@@ -1551,7 +1551,9 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	emif_onetime_settings(emif);
 	emif_debugfs_init(emif);
 	disable_and_clear_all_interrupts(emif);
-	setup_interrupts(emif, irq);
+	ret = setup_interrupts(emif, irq);
+	if (ret)
+		goto error;
 
 	/* One-time actions taken on probing the first device */
 	if (!emif1) {
diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 0413c8159551..34270e237726 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -915,14 +915,14 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 		ret = mfd_add_devices(&pdev->dev, pdev->id,
 			&asic3_cell_ds1wm, 1, mem, asic->irq_base, NULL);
 		if (ret < 0)
-			goto out;
+			goto out_unmap;
 	}
 
 	if (mem_sdio && (irq >= 0)) {
 		ret = mfd_add_devices(&pdev->dev, pdev->id,
 			&asic3_cell_mmc, 1, mem_sdio, irq, NULL);
 		if (ret < 0)
-			goto out;
+			goto out_unmap;
 	}
 
 	ret = 0;
@@ -936,8 +936,12 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 		ret = mfd_add_devices(&pdev->dev, 0,
 			asic3_cell_leds, ASIC3_NUM_LEDS, NULL, 0, NULL);
 	}
+	return ret;
 
- out:
+out_unmap:
+	if (asic->tmio_cnf)
+		iounmap(asic->tmio_cnf);
+out:
 	return ret;
 }
 
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 75d52034f89d..5b4faebdcae2 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -313,8 +313,10 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 		adc1 |= MC13783_ADC1_ATOX;
 
 	dev_dbg(mc13xxx->dev, "%s: request irq\n", __func__);
-	mc13xxx_irq_request(mc13xxx, MC13XXX_IRQ_ADCDONE,
+	ret = mc13xxx_irq_request(mc13xxx, MC13XXX_IRQ_ADCDONE,
 			mc13xxx_handler_adcdone, __func__, &adcdone_data);
+	if (ret)
+		goto out;
 
 	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC0, adc0);
 	mc13xxx_reg_write(mc13xxx, MC13XXX_ADC1, adc1);
diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index ab2184003c29..d75686c1c6e8 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1066,10 +1066,10 @@ static int kgdbts_option_setup(char *opt)
 {
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdbts: config string too long\n");
-		return -ENOSPC;
+		return 1;
 	}
 	strcpy(config, opt);
-	return 0;
+	return 1;
 }
 
 __setup("kgdbts=", kgdbts_option_setup);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 848b3453517e..60c2ca58dec3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -403,6 +403,16 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static int mmc_validate_host_caps(struct mmc_host *host)
+{
+	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
+		dev_warn(host->parent, "missing ->enable_sdio_irq() ops\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -415,8 +425,9 @@ int mmc_add_host(struct mmc_host *host)
 {
 	int err;
 
-	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
-		!host->ops->enable_sdio_irq);
+	err = mmc_validate_host_caps(host);
+	if (err)
+		return err;
 
 	err = device_add(&host->class_dev);
 	if (err)
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 40fdc9d267b9..1c8e95cf29d2 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1637,7 +1637,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 					mtd->oobsize / trans,
 					host->hwcfg.sector_size_1k);
 
-		if (!ret) {
+		if (ret != -EBADMSG) {
 			*err_addr = brcmnand_read_reg(ctrl,
 					BRCMNAND_UNCORR_ADDR) |
 				((u64)(brcmnand_read_reg(ctrl,
diff --git a/drivers/mtd/onenand/generic.c b/drivers/mtd/onenand/generic.c
index 125da34d8ff9..23a878e7974e 100644
--- a/drivers/mtd/onenand/generic.c
+++ b/drivers/mtd/onenand/generic.c
@@ -58,7 +58,12 @@ static int generic_onenand_probe(struct platform_device *pdev)
 	}
 
 	info->onenand.mmcontrol = pdata ? pdata->mmcontrol : NULL;
-	info->onenand.irq = platform_get_irq(pdev, 0);
+
+	err = platform_get_irq(pdev, 0);
+	if (err < 0)
+		goto out_iounmap;
+
+	info->onenand.irq = err;
 
 	info->mtd.dev.parent = &pdev->dev;
 	info->mtd.priv = &info->onenand;
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index e7b177c61642..1486f9af8f1e 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -478,7 +478,9 @@ static int scan_pool(struct ubi_device *ubi, struct ubi_attach_info *ai,
 			if (err == UBI_IO_FF_BITFLIPS)
 				scrub = 1;
 
-			add_aeb(ai, free, pnum, ec, scrub);
+			ret = add_aeb(ai, free, pnum, ec, scrub);
+			if (ret)
+				goto out;
 			continue;
 		} else if (err == 0 || err == UBI_IO_BITFLIPS) {
 			dbg_bld("Found non empty PEB:%i in pool", pnum);
@@ -648,8 +650,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->free, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		ret = add_aeb(ai, &ai->free, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 0);
+		if (ret)
+			goto fail;
 	}
 
 	/* read EC values from used list */
@@ -659,8 +663,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 0);
+		ret = add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 0);
+		if (ret)
+			goto fail;
 	}
 
 	/* read EC values from scrub list */
@@ -670,8 +676,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		ret = add_aeb(ai, &used, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 1);
+		if (ret)
+			goto fail;
 	}
 
 	/* read EC values from erase list */
@@ -681,8 +689,10 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 		if (fm_pos >= fm_size)
 			goto fail_bad;
 
-		add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
-			be32_to_cpu(fmec->ec), 1);
+		ret = add_aeb(ai, &ai->erase, be32_to_cpu(fmec->pnum),
+			      be32_to_cpu(fmec->ec), 1);
+		if (ret)
+			goto fail;
 	}
 
 	ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 239de38fbd6a..1c9fff038569 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -115,6 +115,9 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	ci = (struct com20020_pci_card_info *)id->driver_data;
+	if (!ci)
+		return -EINVAL;
+
 	priv->ci = ci;
 	mm = &ci->misc_map;
 
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 43cdd5544b0c..a127c853a4e9 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1601,15 +1601,15 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	netif_napi_add(ndev, &priv->napi, rcar_canfd_rx_poll,
 		       RCANFD_NAPI_WEIGHT);
+	spin_lock_init(&priv->tx_lock);
+	devm_can_led_init(ndev);
+	gpriv->ch[priv->channel] = priv;
 	err = register_candev(ndev);
 	if (err) {
 		dev_err(&pdev->dev,
 			"register_candev() failed, error %d\n", err);
 		goto fail_candev;
 	}
-	spin_lock_init(&priv->tx_lock);
-	devm_can_led_init(ndev);
-	gpriv->ch[priv->channel] = priv;
 	dev_info(&pdev->dev, "device registered (channel %u)\n", priv->channel);
 	return 0;
 
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index d62d61d734ea..4d01b6cbf0eb 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -834,7 +834,6 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 
 		usb_unanchor_urb(urb);
 		usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
-		dev_kfree_skb(skb);
 
 		atomic_dec(&dev->active_tx_urbs);
 
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 75399aa1ba95..6771c51f72c3 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -198,8 +198,8 @@ struct gs_can {
 struct gs_usb {
 	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
-	atomic_t active_channels;
 	struct usb_device *udev;
+	u8 active_channels;
 };
 
 /* 'allocate' a tx context.
@@ -597,7 +597,7 @@ static int gs_can_open(struct net_device *netdev)
 	if (rc)
 		return rc;
 
-	if (atomic_add_return(1, &parent->active_channels) == 1) {
+	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			struct urb *urb;
 			u8 *buf;
@@ -698,6 +698,7 @@ static int gs_can_open(struct net_device *netdev)
 
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	parent->active_channels++;
 	if (!(dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 		netif_start_queue(netdev);
 
@@ -713,7 +714,8 @@ static int gs_can_close(struct net_device *netdev)
 	netif_stop_queue(netdev);
 
 	/* Stop polling */
-	if (atomic_dec_and_test(&parent->active_channels))
+	parent->active_channels--;
+	if (!parent->active_channels)
 		usb_kill_anchored_urbs(&parent->rx_submitted);
 
 	/* Stop sending URBs */
@@ -992,8 +994,6 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 	init_usb_anchor(&dev->rx_submitted);
 
-	atomic_set(&dev->active_channels, 0);
-
 	usb_set_intfdata(intf, dev);
 	dev->udev = interface_to_usbdev(intf);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9e5251c427a3..401d9718841f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1008,9 +1008,7 @@ static int bnxt_set_pauseparam(struct net_device *dev,
 		}
 
 		link_info->autoneg |= BNXT_AUTONEG_FLOW_CTRL;
-		if (bp->hwrm_spec_code >= 0x10201)
-			link_info->req_flow_ctrl =
-				PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE;
+		link_info->req_flow_ctrl = 0;
 	} else {
 		/* when transition from auto pause to force pause,
 		 * force a link change
diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index a89721fad633..29220141e4e4 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -3677,6 +3677,8 @@ int t3_prep_adapter(struct adapter *adapter, const struct adapter_info *ai,
 	    MAC_STATS_ACCUM_SECS : (MAC_STATS_ACCUM_SECS * 10);
 	adapter->params.pci.vpd_cap_addr =
 	    pci_find_capability(adapter->pdev, PCI_CAP_ID_VPD);
+	if (!adapter->params.pci.vpd_cap_addr)
+		return -ENODEV;
 	ret = get_vpd_params(adapter, &adapter->params.vpd);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 500016209ae0..3ed40bde796b 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1010,8 +1010,8 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 {
 	u32 reg = link << (E1000_LTRV_REQ_SHIFT + E1000_LTRV_NOSNOOP_SHIFT) |
 	    link << E1000_LTRV_REQ_SHIFT | E1000_LTRV_SEND;
-	u16 max_ltr_enc_d = 0;	/* maximum LTR decoded by platform */
-	u16 lat_enc_d = 0;	/* latency decoded */
+	u32 max_ltr_enc_d = 0;	/* maximum LTR decoded by platform */
+	u32 lat_enc_d = 0;	/* latency decoded */
 	u16 lat_enc = 0;	/* latency encoded */
 
 	if (link) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index e13a6cd5163f..5f23e26b0415 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1405,7 +1405,7 @@ static int mlx5e_get_module_eeprom(struct net_device *netdev,
 		if (size_read < 0) {
 			netdev_err(priv->netdev, "%s: mlx5_query_eeprom failed:0x%x\n",
 				   __func__, size_read);
-			return 0;
+			return size_read;
 		}
 
 		i += size_read;
diff --git a/drivers/net/ethernet/micrel/Kconfig b/drivers/net/ethernet/micrel/Kconfig
index b7e2f49696b7..aa12bace8673 100644
--- a/drivers/net/ethernet/micrel/Kconfig
+++ b/drivers/net/ethernet/micrel/Kconfig
@@ -45,6 +45,7 @@ config KS8851
 config KS8851_MLL
 	tristate "Micrel KS8851 MLL"
 	depends on HAS_IOMEM
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select MII
 	---help---
 	  This platform driver is for Micrel KS8851 Address/data bus
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index ad7b9772a4b2..78f34e87212a 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1515,6 +1515,7 @@ static int lpc_eth_drv_resume(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct netdata_local *pldat;
+	int ret;
 
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(ndev->irq);
@@ -1524,7 +1525,9 @@ static int lpc_eth_drv_resume(struct platform_device *pdev)
 			pldat = netdev_priv(ndev);
 
 			/* Enable interface clock */
-			clk_enable(pldat->clk);
+			ret = clk_enable(pldat->clk);
+			if (ret)
+				return ret;
 
 			/* Reset and initialize */
 			__lpc_eth_reset(pldat);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index 6379bfedc9f0..9a7ba55b4693 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -2899,11 +2899,11 @@ int qed_iov_mark_vf_flr(struct qed_hwfn *p_hwfn, u32 *p_disabled_vfs)
 	return found;
 }
 
-static void qed_iov_get_link(struct qed_hwfn *p_hwfn,
-			     u16 vfid,
-			     struct qed_mcp_link_params *p_params,
-			     struct qed_mcp_link_state *p_link,
-			     struct qed_mcp_link_capabilities *p_caps)
+static int qed_iov_get_link(struct qed_hwfn *p_hwfn,
+			    u16 vfid,
+			    struct qed_mcp_link_params *p_params,
+			    struct qed_mcp_link_state *p_link,
+			    struct qed_mcp_link_capabilities *p_caps)
 {
 	struct qed_vf_info *p_vf = qed_iov_get_vf_info(p_hwfn,
 						       vfid,
@@ -2911,7 +2911,7 @@ static void qed_iov_get_link(struct qed_hwfn *p_hwfn,
 	struct qed_bulletin_content *p_bulletin;
 
 	if (!p_vf)
-		return;
+		return -EINVAL;
 
 	p_bulletin = p_vf->bulletin.p_virt;
 
@@ -2921,6 +2921,7 @@ static void qed_iov_get_link(struct qed_hwfn *p_hwfn,
 		__qed_vf_get_link_state(p_hwfn, p_link, p_bulletin);
 	if (p_caps)
 		__qed_vf_get_link_caps(p_hwfn, p_caps, p_bulletin);
+	return 0;
 }
 
 static void qed_iov_process_mbx_req(struct qed_hwfn *p_hwfn,
@@ -3538,6 +3539,7 @@ static int qed_get_vf_config(struct qed_dev *cdev,
 	struct qed_public_vf_info *vf_info;
 	struct qed_mcp_link_state link;
 	u32 tx_rate;
+	int ret;
 
 	/* Sanitize request */
 	if (IS_VF(cdev))
@@ -3551,7 +3553,9 @@ static int qed_get_vf_config(struct qed_dev *cdev,
 
 	vf_info = qed_iov_get_public_vf_info(hwfn, vf_id, true);
 
-	qed_iov_get_link(hwfn, vf_id, NULL, &link, NULL);
+	ret = qed_iov_get_link(hwfn, vf_id, NULL, &link, NULL);
+	if (ret)
+		return ret;
 
 	/* Fill information about VF */
 	ivi->vf = vf_id;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 170243d3276b..d0449d5418f7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -384,6 +384,9 @@ int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn)
 						    p_iov->bulletin.size,
 						    &p_iov->bulletin.phys,
 						    GFP_KERNEL);
+	if (!p_iov->bulletin.p_virt)
+		goto free_pf2vf_reply;
+
 	DP_VERBOSE(p_hwfn, QED_MSG_IOV,
 		   "VF's bulletin Board [%p virt 0x%llx phys 0x%08x bytes]\n",
 		   p_iov->bulletin.p_virt,
@@ -397,6 +400,10 @@ int qed_vf_hw_prepare(struct qed_hwfn *p_hwfn)
 
 	return qed_vf_pf_acquire(p_hwfn);
 
+free_pf2vf_reply:
+	dma_free_coherent(&p_hwfn->cdev->pdev->dev,
+			  sizeof(union pfvf_tlvs),
+			  p_iov->pf2vf_reply, p_iov->pf2vf_reply_phys);
 free_vf2pf_request:
 	dma_free_coherent(&p_hwfn->cdev->pdev->dev,
 			  sizeof(union vfpf_tlvs),
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h
index f4aa6331b367..0a9d24e86715 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h
@@ -52,7 +52,7 @@ static inline int qlcnic_dcb_get_hw_capability(struct qlcnic_dcb *dcb)
 	if (dcb && dcb->ops->get_hw_capability)
 		return dcb->ops->get_hw_capability(dcb);
 
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline void qlcnic_dcb_free(struct qlcnic_dcb *dcb)
@@ -66,7 +66,7 @@ static inline int qlcnic_dcb_attach(struct qlcnic_dcb *dcb)
 	if (dcb && dcb->ops->attach)
 		return dcb->ops->attach(dcb);
 
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline int
@@ -75,7 +75,7 @@ qlcnic_dcb_query_hw_capability(struct qlcnic_dcb *dcb, char *buf)
 	if (dcb && dcb->ops->query_hw_capability)
 		return dcb->ops->query_hw_capability(dcb, buf);
 
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline void qlcnic_dcb_get_info(struct qlcnic_dcb *dcb)
@@ -90,7 +90,7 @@ qlcnic_dcb_query_cee_param(struct qlcnic_dcb *dcb, char *buf, u8 type)
 	if (dcb && dcb->ops->query_cee_param)
 		return dcb->ops->query_cee_param(dcb, buf, type);
 
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline int qlcnic_dcb_get_cee_cfg(struct qlcnic_dcb *dcb)
@@ -98,7 +98,7 @@ static inline int qlcnic_dcb_get_cee_cfg(struct qlcnic_dcb *dcb)
 	if (dcb && dcb->ops->get_cee_cfg)
 		return dcb->ops->get_cee_cfg(dcb);
 
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline void qlcnic_dcb_aen_handler(struct qlcnic_dcb *dcb, void *msg)
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 11dd7c8d576d..ab1d01dd2eb3 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -2311,18 +2311,18 @@ static int __init sxgbe_cmdline_opt(char *str)
 	char *opt;
 
 	if (!str || !*str)
-		return -EINVAL;
+		return 1;
 	while ((opt = strsep(&str, ",")) != NULL) {
 		if (!strncmp(opt, "eee_timer:", 10)) {
 			if (kstrtoint(opt + 10, 0, &eee_timer))
 				goto err;
 		}
 	}
-	return 0;
+	return 1;
 
 err:
 	pr_err("%s: ERROR broken module parameter conversion\n", __func__);
-	return -EINVAL;
+	return 1;
 }
 
 __setup("sxgbeeth=", sxgbe_cmdline_opt);
diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index 241520943ada..221798499e24 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -162,9 +162,9 @@ static void efx_mcdi_send_request(struct efx_nic *efx, unsigned cmd,
 	/* Serialise with efx_mcdi_ev_cpl() and efx_mcdi_ev_death() */
 	spin_lock_bh(&mcdi->iface_lock);
 	++mcdi->seqno;
+	seqno = mcdi->seqno & SEQ_MASK;
 	spin_unlock_bh(&mcdi->iface_lock);
 
-	seqno = mcdi->seqno & SEQ_MASK;
 	xflags = 0;
 	if (mcdi->mode == MCDI_MODE_EVENTS)
 		xflags |= MCDI_HEADER_XFLAGS_EVREQ;
diff --git a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
index 6a9c954492f2..6ca428a702f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c
@@ -68,10 +68,6 @@
 #define TSE_PCS_USE_SGMII_ENA				BIT(0)
 #define TSE_PCS_IF_USE_SGMII				0x03
 
-#define SGMII_ADAPTER_CTRL_REG				0x00
-#define SGMII_ADAPTER_DISABLE				0x0001
-#define SGMII_ADAPTER_ENABLE				0x0000
-
 #define AUTONEGO_LINK_TIMER				20
 
 static int tse_pcs_reset(void __iomem *base, struct tse_pcs *pcs)
@@ -215,12 +211,8 @@ void tse_pcs_fix_mac_speed(struct tse_pcs *pcs, struct phy_device *phy_dev,
 			   unsigned int speed)
 {
 	void __iomem *tse_pcs_base = pcs->tse_pcs_base;
-	void __iomem *sgmii_adapter_base = pcs->sgmii_adapter_base;
 	u32 val;
 
-	writew(SGMII_ADAPTER_ENABLE,
-	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
-
 	pcs->autoneg = phy_dev->autoneg;
 
 	if (phy_dev->autoneg == AUTONEG_ENABLE) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h
index 2f5882450b06..254199f2efdb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h
@@ -21,6 +21,10 @@
 #include <linux/phy.h>
 #include <linux/timer.h>
 
+#define SGMII_ADAPTER_CTRL_REG		0x00
+#define SGMII_ADAPTER_ENABLE		0x0000
+#define SGMII_ADAPTER_DISABLE		0x0001
+
 struct tse_pcs {
 	struct device *dev;
 	void __iomem *tse_pcs_base;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c3a78c113424..b138968b8672 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -29,9 +29,6 @@
 
 #include "altr_tse_pcs.h"
 
-#define SGMII_ADAPTER_CTRL_REG                          0x00
-#define SGMII_ADAPTER_DISABLE                           0x0001
-
 #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII 0x0
 #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII 0x1
 #define SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII 0x2
@@ -65,16 +62,14 @@ static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
 {
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
 	void __iomem *splitter_base = dwmac->splitter_base;
-	void __iomem *tse_pcs_base = dwmac->pcs.tse_pcs_base;
 	void __iomem *sgmii_adapter_base = dwmac->pcs.sgmii_adapter_base;
 	struct device *dev = dwmac->dev;
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct phy_device *phy_dev = ndev->phydev;
 	u32 val;
 
-	if ((tse_pcs_base) && (sgmii_adapter_base))
-		writew(SGMII_ADAPTER_DISABLE,
-		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+	writew(SGMII_ADAPTER_DISABLE,
+	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 
 	if (splitter_base) {
 		val = readl(splitter_base + EMAC_SPLITTER_CTRL_REG);
@@ -96,7 +91,9 @@ static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
 		writel(val, splitter_base + EMAC_SPLITTER_CTRL_REG);
 	}
 
-	if (tse_pcs_base && sgmii_adapter_base)
+	writew(SGMII_ADAPTER_ENABLE,
+	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+	if (phy_dev)
 		tse_pcs_fix_mac_speed(&dwmac->pcs, phy_dev, speed);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0a7ff854d1c3..bb44f8161ea9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3608,7 +3608,7 @@ static int __init stmmac_cmdline_opt(char *str)
 	char *opt;
 
 	if (!str || !*str)
-		return -EINVAL;
+		return 1;
 	while ((opt = strsep(&str, ",")) != NULL) {
 		if (!strncmp(opt, "debug:", 6)) {
 			if (kstrtoint(opt + 6, 0, &debug))
@@ -3639,11 +3639,11 @@ static int __init stmmac_cmdline_opt(char *str)
 				goto err;
 		}
 	}
-	return 0;
+	return 1;
 
 err:
 	pr_err("%s: ERROR broken module parameter conversion", __func__);
-	return -EINVAL;
+	return 1;
 }
 
 __setup("stmmaceth=", stmmac_cmdline_opt);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 2019e163e0e9..cbdd0deb7c56 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -221,8 +221,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 	plat->interface = of_get_phy_mode(np);
 
 	/* Get max speed of operation from device tree */
-	if (of_property_read_u32(np, "max-speed", &plat->max_speed))
-		plat->max_speed = -1;
+	of_property_read_u32(np, "max-speed", &plat->max_speed);
 
 	plat->bus_id = of_alias_get_id(np, "ethernet");
 	if (plat->bus_id < 0)
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index cf4dcff051d5..b38106a7cb5d 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -3160,7 +3160,7 @@ static int happy_meal_pci_probe(struct pci_dev *pdev,
 	if (err) {
 		printk(KERN_ERR "happymeal(PCI): Cannot register net device, "
 		       "aborting.\n");
-		goto err_out_iounmap;
+		goto err_out_free_coherent;
 	}
 
 	pci_set_drvdata(pdev, hp);
@@ -3193,6 +3193,10 @@ static int happy_meal_pci_probe(struct pci_dev *pdev,
 
 	return 0;
 
+err_out_free_coherent:
+	dma_free_coherent(hp->dma_dev, PAGE_SIZE,
+			  hp->happy_block, hp->hblock_dvma);
+
 err_out_iounmap:
 	iounmap(hp->gregs);
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index df3b3384984c..1f9a6ea356b0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1175,7 +1175,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	if (rc) {
 		dev_err(dev,
 			"Cannot register network device, aborting\n");
-		goto error;
+		goto put_node;
 	}
 
 	dev_info(dev,
@@ -1183,6 +1183,8 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 		 (unsigned int __force)ndev->mem_start, lp->base_addr, ndev->irq);
 	return 0;
 
+put_node:
+	of_node_put(lp->phy_node);
 error:
 	xemaclite_remove_ndev(ndev);
 	return rc;
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 96fb2a2a59f0..f829233a911a 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -685,14 +685,14 @@ static void sixpack_close(struct tty_struct *tty)
 	 */
 	netif_stop_queue(sp->dev);
 
+	unregister_netdev(sp->dev);
+
 	del_timer_sync(&sp->tx_t);
 	del_timer_sync(&sp->resync_t);
 
 	/* Free all 6pack frame buffers. */
 	kfree(sp->rbuff);
 	kfree(sp->xbuff);
-
-	unregister_netdev(sp->dev);
 }
 
 /* Perform I/O control on an active 6pack channel. */
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 8d85cedb4bf5..cbf959e7bbff 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -41,6 +41,8 @@
 
 #define AX_MTU		236
 
+/* some arch define END as assembly function ending, just undef it */
+#undef	END
 /* SLIP/KISS protocol characters. */
 #define END             0300		/* indicates end of frame	*/
 #define ESC             0333		/* indicates byte stuffing	*/
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 870327efccf7..6bea2b219e00 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -15,6 +15,7 @@
  */
 
 #include "bcm-phy-lib.h"
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/brcmphy.h>
@@ -357,6 +358,26 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	/* The datasheet indicates the PHY needs up to 1us to complete a reset,
+	 * build some slack here.
+	 */
+	usleep_range(1000, 2000);
+
+	/* The PHY requires 65 MDC clock cycles to complete a write operation
+	 * and turnaround the line properly.
+	 *
+	 * We ignore -EIO here as the MDIO controller (e.g.: mdio-bcm-unimac)
+	 * may flag the lack of turn-around as a read failure. This is
+	 * particularly true with this combination since the MDIO controller
+	 * only used 64 MDC cycles. This is not a critical failure in this
+	 * specific case and it has no functional impact otherwise, so we let
+	 * that one go through. If there is a genuine bus error, the next read
+	 * of MII_BRCM_FET_INTREG will error out.
+	 */
+	err = phy_read(phydev, MII_BMCR);
+	if (err < 0 && err != -EIO)
+		return err;
+
 	reg = phy_read(phydev, MII_BRCM_FET_INTREG);
 	if (reg < 0)
 		return reg;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index f870396e05e1..ba26fa0ceba8 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -471,7 +471,7 @@ static void sl_tx_timeout(struct net_device *dev)
 	spin_lock(&sl->lock);
 
 	if (netif_queue_stopped(dev)) {
-		if (!netif_running(dev))
+		if (!netif_running(dev) || !sl->tty)
 			goto out;
 
 		/* May be we must check transmitter timeout here ?
diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 8f03cc52ddda..1819b104418c 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -555,6 +555,11 @@ static const struct usb_device_id	products[] = {
 	.bInterfaceSubClass	= USB_CDC_SUBCLASS_ETHERNET, \
 	.bInterfaceProtocol	= USB_CDC_PROTO_NONE
 
+#define ZAURUS_FAKE_INTERFACE \
+	.bInterfaceClass	= USB_CLASS_COMM, \
+	.bInterfaceSubClass	= USB_CDC_SUBCLASS_MDLM, \
+	.bInterfaceProtocol	= USB_CDC_PROTO_NONE
+
 /* SA-1100 based Sharp Zaurus ("collie"), or compatible;
  * wire-incompatible with true CDC Ethernet implementations.
  * (And, it seems, needlessly so...)
@@ -608,6 +613,13 @@ static const struct usb_device_id	products[] = {
 	.idProduct              = 0x9032,	/* SL-6000 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+		 | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor               = 0x04DD,
+	.idProduct              = 0x9032,	/* SL-6000 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info		= 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index d86132d41416..95256765b388 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -652,6 +652,11 @@ static const struct usb_device_id mbim_devs[] = {
 	  .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
 	},
 
+	/* Telit FN990 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x1071, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
+	  .driver_info = (unsigned long)&cdc_mbim_info_avoid_altsetting_toggle,
+	},
+
 	/* default entry */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
 	  .driver_info = (unsigned long)&cdc_mbim_info_zlp,
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index aadfe1d1c37e..f4c4df01874c 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -409,7 +409,7 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		/* ignore the CRC length */
 		len = (skb->data[1] | (skb->data[2] << 8)) - 4;
 
-		if (len > ETH_FRAME_LEN)
+		if (len > ETH_FRAME_LEN || len > skb->len)
 			return 0;
 
 		/* the last packet of current skb */
diff --git a/drivers/net/usb/zaurus.c b/drivers/net/usb/zaurus.c
index 6aaa6eb9df72..3d126761044f 100644
--- a/drivers/net/usb/zaurus.c
+++ b/drivers/net/usb/zaurus.c
@@ -268,6 +268,11 @@ static const struct usb_device_id	products [] = {
 	.bInterfaceSubClass	= USB_CDC_SUBCLASS_ETHERNET, \
 	.bInterfaceProtocol	= USB_CDC_PROTO_NONE
 
+#define ZAURUS_FAKE_INTERFACE \
+	.bInterfaceClass	= USB_CLASS_COMM, \
+	.bInterfaceSubClass	= USB_CDC_SUBCLASS_MDLM, \
+	.bInterfaceProtocol	= USB_CDC_PROTO_NONE
+
 /* SA-1100 based Sharp Zaurus ("collie"), or compatible. */
 {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
@@ -325,6 +330,13 @@ static const struct usb_device_id	products [] = {
 	.idProduct              = 0x9032,	/* SL-6000 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			    | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x9032,	/* SL-6000 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long)&bogus_mdlm_info,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index ee7460ee3d05..57ff2fd95f75 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -114,7 +114,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rcu_read_lock();
 	rcv = rcu_dereference(priv->peer);
-	if (unlikely(!rcv)) {
+	if (unlikely(!rcv) || !pskb_may_pull(skb, ETH_HLEN)) {
 		kfree_skb(skb);
 		goto drop;
 	}
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 0bfadec8b79c..d59cb381e80b 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -490,11 +490,11 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 
 	rd = kmalloc(sizeof(*rd), GFP_ATOMIC);
 	if (rd == NULL)
-		return -ENOBUFS;
+		return -ENOMEM;
 
 	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
 		kfree(rd);
-		return -ENOBUFS;
+		return -ENOMEM;
 	}
 
 	rd->remote_ip = *ip;
diff --git a/drivers/net/wireless/ath/ath5k/eeprom.c b/drivers/net/wireless/ath/ath5k/eeprom.c
index 94d34ee02265..01163b333945 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.c
+++ b/drivers/net/wireless/ath/ath5k/eeprom.c
@@ -746,6 +746,9 @@ ath5k_eeprom_convert_pcal_info_5111(struct ath5k_hw *ah, int mode,
 			}
 		}
 
+		if (idx == AR5K_EEPROM_N_PD_CURVES)
+			goto err_out;
+
 		ee->ee_pd_gains[mode] = 1;
 
 		pd = &chinfo[pier].pd_curves[idx];
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 625823e45d8f..06a6e7443550 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -31,6 +31,7 @@ static int htc_issue_send(struct htc_target *target, struct sk_buff* skb,
 	hdr->endpoint_id = epid;
 	hdr->flags = flags;
 	hdr->payload_len = cpu_to_be16(len);
+	memset(hdr->control, 0, sizeof(hdr->control));
 
 	status = target->hif->send(target->hif_dev, endpoint->ul_pipeid, skb);
 
@@ -278,6 +279,10 @@ int htc_connect_service(struct htc_target *target,
 	conn_msg->dl_pipeid = endpoint->dl_pipeid;
 	conn_msg->ul_pipeid = endpoint->ul_pipeid;
 
+	/* To prevent infoleak */
+	conn_msg->svc_meta_len = 0;
+	conn_msg->pad = 0;
+
 	ret = htc_issue_send(target, skb, skb->len, 0, ENDPOINT0);
 	if (ret)
 		goto err;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index 202f421e0e37..1ea80d004d46 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -1920,7 +1920,7 @@ static int carl9170_parse_eeprom(struct ar9170 *ar)
 		WARN_ON(!(tx_streams >= 1 && tx_streams <=
 			IEEE80211_HT_MCS_TX_MAX_STREAMS));
 
-		tx_params = (tx_streams - 1) <<
+		tx_params |= (tx_streams - 1) <<
 			    IEEE80211_HT_MCS_TX_MAX_STREAMS_SHIFT;
 
 		carl9170_band_2GHz.ht_cap.mcs.tx_params |= tx_params;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index d231042f19d6..33a7378164b8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -216,6 +216,8 @@ static int brcmf_init_nvram_parser(struct nvram_parser *nvp,
 		size = BRCMF_FW_MAX_NVRAM_SIZE;
 	else
 		size = data_len;
+	/* Add space for properties we may add */
+	size += strlen(BRCMF_FW_DEFAULT_BOARDREV) + 1;
 	/* Alloc for extra 0 byte + roundup by 4 + length field */
 	size += 1 + 3 + sizeof(u32);
 	nvp->nvram = kzalloc(size, GFP_KERNEL);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index d3d79219fbb0..9e90737f4d49 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/bcma/bcma.h>
 #include <linux/sched.h>
+#include <linux/io.h>
 #include <asm/unaligned.h>
 
 #include <soc.h>
@@ -406,47 +407,6 @@ brcmf_pcie_write_ram32(struct brcmf_pciedev_info *devinfo, u32 mem_offset,
 }
 
 
-static void
-brcmf_pcie_copy_mem_todev(struct brcmf_pciedev_info *devinfo, u32 mem_offset,
-			  void *srcaddr, u32 len)
-{
-	void __iomem *address = devinfo->tcm + mem_offset;
-	__le32 *src32;
-	__le16 *src16;
-	u8 *src8;
-
-	if (((ulong)address & 4) || ((ulong)srcaddr & 4) || (len & 4)) {
-		if (((ulong)address & 2) || ((ulong)srcaddr & 2) || (len & 2)) {
-			src8 = (u8 *)srcaddr;
-			while (len) {
-				iowrite8(*src8, address);
-				address++;
-				src8++;
-				len--;
-			}
-		} else {
-			len = len / 2;
-			src16 = (__le16 *)srcaddr;
-			while (len) {
-				iowrite16(le16_to_cpu(*src16), address);
-				address += 2;
-				src16++;
-				len--;
-			}
-		}
-	} else {
-		len = len / 4;
-		src32 = (__le32 *)srcaddr;
-		while (len) {
-			iowrite32(le32_to_cpu(*src32), address);
-			address += 4;
-			src32++;
-			len--;
-		}
-	}
-}
-
-
 static void
 brcmf_pcie_copy_dev_tomem(struct brcmf_pciedev_info *devinfo, u32 mem_offset,
 			  void *dstaddr, u32 len)
@@ -1422,8 +1382,8 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		return err;
 
 	brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
-	brcmf_pcie_copy_mem_todev(devinfo, devinfo->ci->rambase,
-				  (void *)fw->data, fw->size);
+	memcpy_toio(devinfo->tcm + devinfo->ci->rambase,
+		    (void *)fw->data, fw->size);
 
 	resetintr = get_unaligned_le32(fw->data);
 	release_firmware(fw);
@@ -1437,7 +1397,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		brcmf_dbg(PCIE, "Download NVRAM %s\n", devinfo->nvram_name);
 		address = devinfo->ci->rambase + devinfo->ci->ramsize -
 			  nvram_len;
-		brcmf_pcie_copy_mem_todev(devinfo, address, nvram, nvram_len);
+		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 998a4bd6db78..d8f34883c096 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -547,7 +547,7 @@ enum brcmf_sdio_frmtype {
 	BRCMF_SDIO_FT_SUB,
 };
 
-#define SDIOD_DRVSTR_KEY(chip, pmu)     (((chip) << 16) | (pmu))
+#define SDIOD_DRVSTR_KEY(chip, pmu)     (((unsigned int)(chip) << 16) | (pmu))
 
 /* SDIO Pad drive strength to select value mappings */
 struct sdiod_drive_str {
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 8c0719468d00..6bd2486f617e 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -315,7 +315,7 @@ static int iwlagn_mac_start(struct ieee80211_hw *hw)
 
 	priv->is_open = 1;
 	IWL_DEBUG_MAC80211(priv, "leave\n");
-	return 0;
+	return ret;
 }
 
 static void iwlagn_mac_stop(struct ieee80211_hw *hw)
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index dd6924d21b8a..a34647efb5ea 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1987,6 +1987,15 @@ static void hw_scan_work(struct work_struct *work)
 				memcpy(skb_put(probe, req->ie_len), req->ie,
 				       req->ie_len);
 
+			if (!ieee80211_tx_prepare_skb(hwsim->hw,
+						      hwsim->hw_scan_vif,
+						      probe,
+						      hwsim->tmp_chan->band,
+						      NULL)) {
+				kfree_skb(probe);
+				continue;
+			}
+
 			local_bh_disable();
 			mac80211_hwsim_tx_frame(hwsim->hw, probe,
 						hwsim->tmp_chan);
@@ -2919,6 +2928,10 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 		}
 		txi->flags |= IEEE80211_TX_STAT_ACK;
 	}
+
+	if (hwsim_flags & HWSIM_TX_CTL_NO_ACK)
+		txi->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+
 	ieee80211_tx_status_irqsafe(data2->hw, skb);
 	return 0;
 out:
diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index c78abfc7bd96..784063b1e60f 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -396,6 +396,8 @@ static int ray_config(struct pcmcia_device *link)
 		goto failed;
 	local->sram = ioremap(link->resource[2]->start,
 			resource_size(link->resource[2]));
+	if (!local->sram)
+		goto failed;
 
 /*** Set up 16k window for shared memory (receive buffer) ***************/
 	link->resource[3]->flags |=
@@ -410,6 +412,8 @@ static int ray_config(struct pcmcia_device *link)
 		goto failed;
 	local->rmem = ioremap(link->resource[3]->start,
 			resource_size(link->resource[3]));
+	if (!local->rmem)
+		goto failed;
 
 /*** Set up window for attribute memory ***********************************/
 	link->resource[4]->flags |=
@@ -424,6 +428,8 @@ static int ray_config(struct pcmcia_device *link)
 		goto failed;
 	local->amem = ioremap(link->resource[4]->start,
 			resource_size(link->resource[4]));
+	if (!local->amem)
+		goto failed;
 
 	dev_dbg(&link->dev, "ray_config sram=%p\n", local->sram);
 	dev_dbg(&link->dev, "ray_config rmem=%p\n", local->rmem);
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index e6646c8a7bdb..78788402edd8 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -1040,15 +1040,11 @@ static void connect(struct backend_info *be)
 	xenvif_carrier_on(be->vif);
 
 	unregister_hotplug_status_watch(be);
-	if (xenbus_exists(XBT_NIL, dev->nodename, "hotplug-status")) {
-		err = xenbus_watch_pathfmt(dev, &be->hotplug_status_watch,
-					   NULL, hotplug_status_changed,
-					   "%s/%s", dev->nodename,
-					   "hotplug-status");
-		if (err)
-			goto err;
+	err = xenbus_watch_pathfmt(dev, &be->hotplug_status_watch, NULL,
+				   hotplug_status_changed,
+				   "%s/%s", dev->nodename, "hotplug-status");
+	if (!err)
 		be->have_hotplug_status_watch = 1;
-	}
 
 	netif_tx_wake_all_queues(be->vif->dev);
 
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 65a50bc5661d..82dcd44b3e5e 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -413,14 +413,12 @@ static bool xennet_tx_buf_gc(struct netfront_queue *queue)
 			queue->tx_link[id] = TX_LINK_NONE;
 			skb = queue->tx_skbs[id];
 			queue->tx_skbs[id] = NULL;
-			if (unlikely(gnttab_query_foreign_access(
-				queue->grant_tx_ref[id]) != 0)) {
+			if (unlikely(!gnttab_end_foreign_access_ref(
+				queue->grant_tx_ref[id], GNTMAP_readonly))) {
 				dev_alert(dev,
 					  "Grant still in use by backend domain\n");
 				goto err;
 			}
-			gnttab_end_foreign_access_ref(
-				queue->grant_tx_ref[id], GNTMAP_readonly);
 			gnttab_release_grant_reference(
 				&queue->gref_tx_head, queue->grant_tx_ref[id]);
 			queue->grant_tx_ref[id] = GRANT_INVALID_REF;
@@ -840,7 +838,6 @@ static int xennet_get_responses(struct netfront_queue *queue,
 	int max = XEN_NETIF_NR_SLOTS_MIN + (rx->status <= RX_COPY_THRESHOLD);
 	int slots = 1;
 	int err = 0;
-	unsigned long ret;
 
 	if (rx->flags & XEN_NETRXF_extra_info) {
 		err = xennet_get_extras(queue, extras, rp);
@@ -871,8 +868,13 @@ static int xennet_get_responses(struct netfront_queue *queue,
 			goto next;
 		}
 
-		ret = gnttab_end_foreign_access_ref(ref, 0);
-		BUG_ON(!ret);
+		if (!gnttab_end_foreign_access_ref(ref, 0)) {
+			dev_alert(dev,
+				  "Grant still in use by backend domain\n");
+			queue->info->broken = true;
+			dev_alert(dev, "Disabled for further use\n");
+			return -EINVAL;
+		}
 
 		gnttab_release_grant_reference(&queue->gref_rx_head, ref);
 
@@ -1076,6 +1078,10 @@ static int xennet_poll(struct napi_struct *napi, int budget)
 		err = xennet_get_responses(queue, &rinfo, rp, &tmpq);
 
 		if (unlikely(err)) {
+			if (queue->info->broken) {
+				spin_unlock(&queue->rx_lock);
+				return 0;
+			}
 err:
 			while ((skb = __skb_dequeue(&tmpq)))
 				__skb_queue_tail(&errq, skb);
@@ -1673,7 +1679,7 @@ static int setup_netfront(struct xenbus_device *dev,
 			struct netfront_queue *queue, unsigned int feature_split_evtchn)
 {
 	struct xen_netif_tx_sring *txs;
-	struct xen_netif_rx_sring *rxs;
+	struct xen_netif_rx_sring *rxs = NULL;
 	grant_ref_t gref;
 	int err;
 
@@ -1693,21 +1699,21 @@ static int setup_netfront(struct xenbus_device *dev,
 
 	err = xenbus_grant_ring(dev, txs, 1, &gref);
 	if (err < 0)
-		goto grant_tx_ring_fail;
+		goto fail;
 	queue->tx_ring_ref = gref;
 
 	rxs = (struct xen_netif_rx_sring *)get_zeroed_page(GFP_NOIO | __GFP_HIGH);
 	if (!rxs) {
 		err = -ENOMEM;
 		xenbus_dev_fatal(dev, err, "allocating rx ring page");
-		goto alloc_rx_ring_fail;
+		goto fail;
 	}
 	SHARED_RING_INIT(rxs);
 	FRONT_RING_INIT(&queue->rx, rxs, XEN_PAGE_SIZE);
 
 	err = xenbus_grant_ring(dev, rxs, 1, &gref);
 	if (err < 0)
-		goto grant_rx_ring_fail;
+		goto fail;
 	queue->rx_ring_ref = gref;
 
 	if (feature_split_evtchn)
@@ -1720,22 +1726,28 @@ static int setup_netfront(struct xenbus_device *dev,
 		err = setup_netfront_single(queue);
 
 	if (err)
-		goto alloc_evtchn_fail;
+		goto fail;
 
 	return 0;
 
 	/* If we fail to setup netfront, it is safe to just revoke access to
 	 * granted pages because backend is not accessing it at this point.
 	 */
-alloc_evtchn_fail:
-	gnttab_end_foreign_access_ref(queue->rx_ring_ref, 0);
-grant_rx_ring_fail:
-	free_page((unsigned long)rxs);
-alloc_rx_ring_fail:
-	gnttab_end_foreign_access_ref(queue->tx_ring_ref, 0);
-grant_tx_ring_fail:
-	free_page((unsigned long)txs);
-fail:
+ fail:
+	if (queue->rx_ring_ref != GRANT_INVALID_REF) {
+		gnttab_end_foreign_access(queue->rx_ring_ref, 0,
+					  (unsigned long)rxs);
+		queue->rx_ring_ref = GRANT_INVALID_REF;
+	} else {
+		free_page((unsigned long)rxs);
+	}
+	if (queue->tx_ring_ref != GRANT_INVALID_REF) {
+		gnttab_end_foreign_access(queue->tx_ring_ref, 0,
+					  (unsigned long)txs);
+		queue->tx_ring_ref = GRANT_INVALID_REF;
+	} else {
+		free_page((unsigned long)txs);
+	}
 	return err;
 }
 
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index ed65993aae96..838ec17073fd 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1617,7 +1617,9 @@ static int port100_probe(struct usb_interface *interface,
 	nfc_digital_free_device(dev->nfc_digital_dev);
 
 error:
+	usb_kill_urb(dev->in_urb);
 	usb_free_urb(dev->in_urb);
+	usb_kill_urb(dev->out_urb);
 	usb_free_urb(dev->out_urb);
 	usb_put_dev(dev->udev);
 
diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index eac608a457f0..475f8a67856d 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -330,6 +330,11 @@ int st21nfca_connectivity_event_received(struct nfc_hci_dev *hdev, u8 host,
 			return -ENOMEM;
 
 		transaction->aid_len = skb->data[1];
+
+		/* Checking if the length of the AID is valid */
+		if (transaction->aid_len > sizeof(transaction->aid))
+			return -EINVAL;
+
 		memcpy(transaction->aid, &skb->data[2],
 		       transaction->aid_len);
 
@@ -339,6 +344,11 @@ int st21nfca_connectivity_event_received(struct nfc_hci_dev *hdev, u8 host,
 			return -EPROTO;
 
 		transaction->params_len = skb->data[transaction->aid_len + 3];
+
+		/* Total size is allocated (skb->len - 2) minus fixed array members */
+		if (transaction->params_len > ((skb->len - 2) - sizeof(struct nfc_evt_transaction)))
+			return -EINVAL;
+
 		memcpy(transaction->params, skb->data +
 		       transaction->aid_len + 4, transaction->params_len);
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8b8b096167d7..31be1c69fd70 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -120,6 +120,8 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 		if (slot_status & PCI_EXP_SLTSTA_CC) {
 			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 						   PCI_EXP_SLTSTA_CC);
+			ctrl->cmd_busy = 0;
+			smp_mb();
 			return 1;
 		}
 		if (timeout < 0)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index f9aef2ac03a1..4cce72017109 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1355,6 +1355,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
 	if (node) {
 		pctl->regmap1 = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(pctl->regmap1))
 			return PTR_ERR(pctl->regmap1);
 	} else if (regmap) {
@@ -1368,6 +1369,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	node = of_parse_phandle(np, "mediatek,pctl-regmap", 1);
 	if (node) {
 		pctl->regmap2 = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(pctl->regmap2))
 			return PTR_ERR(pctl->regmap2);
 	}
diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index d318ca055489..6e237c46e1bd 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1916,8 +1916,10 @@ static int nmk_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	prcm_np = of_parse_phandle(np, "prcm", 0);
-	if (prcm_np)
+	if (prcm_np) {
 		npct->prcm_base = of_iomap(prcm_np, 0);
+		of_node_put(prcm_np);
+	}
 	if (!npct->prcm_base) {
 		if (version == PINCTRL_NMK_STN8815) {
 			dev_info(&pdev->dev,
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 5020ae534479..074a7e044e25 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -31,10 +31,10 @@ static const struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_BIAS_BUS_HOLD, "input bias bus hold", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NULL, false),
-	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", NULL, false),
+	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", "ohms", true),
 	PCONFDUMP(PIN_CONFIG_BIAS_PULL_PIN_DEFAULT,
-				"input bias pull to pin specific state", NULL, false),
-	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", NULL, false),
+				"input bias pull to pin specific state", "ohms", true),
+	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", "ohms", true),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_DRAIN, "output drive open drain", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL, false),
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 17827a88b85e..9bcb238c2e12 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2414,6 +2414,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	node = of_parse_phandle(np, "rockchip,grf", 0);
 	if (node) {
 		info->regmap_base = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(info->regmap_base))
 			return PTR_ERR(info->regmap_base);
 	} else {
@@ -2450,6 +2451,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
 	if (node) {
 		info->regmap_pmu = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(info->regmap_pmu))
 			return PTR_ERR(info->regmap_pmu);
 	}
diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 8c146e2b6727..4664d3e191c8 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1125,8 +1125,6 @@ static void kbd_led_set(struct led_classdev *led_cdev,
 
 	if (value > samsung->kbd_led.max_brightness)
 		value = samsung->kbd_led.max_brightness;
-	else if (value < 0)
-		value = 0;
 
 	samsung->kbd_led_wk = value;
 	queue_work(samsung->led_workqueue, &samsung->kbd_led_work);
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index d6079e892e11..c07437ad1b85 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2545,8 +2545,10 @@ static int ab8500_fg_sysfs_init(struct ab8500_fg *di)
 	ret = kobject_init_and_add(&di->fg_kobject,
 		&ab8500_fg_ktype,
 		NULL, "battery");
-	if (ret < 0)
+	if (ret < 0) {
+		kobject_put(&di->fg_kobject);
 		dev_err(di->dev, "failed to create sysfs entry\n");
+	}
 
 	return ret;
 }
diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index 5c5880664e09..28c7102fb24e 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -410,44 +410,112 @@ static const struct power_supply_desc wm8350_usb_desc = {
  *		Initialisation
  *********************************************************************/
 
-static void wm8350_init_charger(struct wm8350 *wm8350)
+static int wm8350_init_charger(struct wm8350 *wm8350)
 {
+	int ret;
+
 	/* register our interest in charger events */
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_HOT,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_HOT,
 			    wm8350_charger_handler, 0, "Battery hot", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD,
+	if (ret)
+		goto err;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD,
 			    wm8350_charger_handler, 0, "Battery cold", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL,
+	if (ret)
+		goto free_chg_bat_hot;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL,
 			    wm8350_charger_handler, 0, "Battery fail", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_TO,
+	if (ret)
+		goto free_chg_bat_cold;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_TO,
 			    wm8350_charger_handler, 0,
 			    "Charger timeout", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_END,
+	if (ret)
+		goto free_chg_bat_fail;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_END,
 			    wm8350_charger_handler, 0,
 			    "Charge end", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_START,
+	if (ret)
+		goto free_chg_to;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_START,
 			    wm8350_charger_handler, 0,
 			    "Charge start", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY,
+	if (ret)
+		goto free_chg_end;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY,
 			    wm8350_charger_handler, 0,
 			    "Fast charge ready", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9,
+	if (ret)
+		goto free_chg_start;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9,
 			    wm8350_charger_handler, 0,
 			    "Battery <3.9V", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1,
+	if (ret)
+		goto free_chg_fast_rdy;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1,
 			    wm8350_charger_handler, 0,
 			    "Battery <3.1V", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85,
+	if (ret)
+		goto free_chg_vbatt_lt_3p9;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85,
 			    wm8350_charger_handler, 0,
 			    "Battery <2.85V", wm8350);
+	if (ret)
+		goto free_chg_vbatt_lt_3p1;
 
 	/* and supply change events */
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_USB_FB,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_USB_FB,
 			    wm8350_charger_handler, 0, "USB", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_WALL_FB,
+	if (ret)
+		goto free_chg_vbatt_lt_2p85;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_WALL_FB,
 			    wm8350_charger_handler, 0, "Wall", wm8350);
-	wm8350_register_irq(wm8350, WM8350_IRQ_EXT_BAT_FB,
+	if (ret)
+		goto free_ext_usb_fb;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_EXT_BAT_FB,
 			    wm8350_charger_handler, 0, "Battery", wm8350);
+	if (ret)
+		goto free_ext_wall_fb;
+
+	return 0;
+
+free_ext_wall_fb:
+	wm8350_free_irq(wm8350, WM8350_IRQ_EXT_WALL_FB, wm8350);
+free_ext_usb_fb:
+	wm8350_free_irq(wm8350, WM8350_IRQ_EXT_USB_FB, wm8350);
+free_chg_vbatt_lt_2p85:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85, wm8350);
+free_chg_vbatt_lt_3p1:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1, wm8350);
+free_chg_vbatt_lt_3p9:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9, wm8350);
+free_chg_fast_rdy:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY, wm8350);
+free_chg_start:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_START, wm8350);
+free_chg_end:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_END, wm8350);
+free_chg_to:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_TO, wm8350);
+free_chg_bat_fail:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL, wm8350);
+free_chg_bat_cold:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD, wm8350);
+free_chg_bat_hot:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_BAT_HOT, wm8350);
+err:
+	return ret;
 }
 
 static void free_charger_irq(struct wm8350 *wm8350)
@@ -458,6 +526,7 @@ static void free_charger_irq(struct wm8350 *wm8350)
 	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_TO, wm8350);
 	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_END, wm8350);
 	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_START, wm8350);
+	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_FAST_RDY, wm8350);
 	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P9, wm8350);
 	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_3P1, wm8350);
 	wm8350_free_irq(wm8350, WM8350_IRQ_CHG_VBATT_LT_2P85, wm8350);
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 731d0423c8aa..b690621b4fc8 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -26,7 +26,7 @@ static ssize_t clock_name_show(struct device *dev,
 			       struct device_attribute *attr, char *page)
 {
 	struct ptp_clock *ptp = dev_get_drvdata(dev);
-	return snprintf(page, PAGE_SIZE-1, "%s\n", ptp->info->name);
+	return sysfs_emit(page, "%s\n", ptp->info->name);
 }
 static DEVICE_ATTR(clock_name, 0444, clock_name_show, NULL);
 
@@ -240,7 +240,7 @@ static ssize_t ptp_pin_show(struct device *dev, struct device_attribute *attr,
 
 	mutex_unlock(&ptp->pincfg_mux);
 
-	return snprintf(page, PAGE_SIZE, "%u %u\n", func, chan);
+	return sysfs_emit(page, "%u %u\n", func, chan);
 }
 
 static ssize_t ptp_pin_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index d7f5f7de030d..8b3aad06e236 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -406,12 +406,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_LIMIT,
 			   BIT(lpc18xx_pwm->period_event));
 
-	ret = pwmchip_add(&lpc18xx_pwm->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
-		goto disable_pwmclk;
-	}
-
 	for (i = 0; i < lpc18xx_pwm->chip.npwm; i++) {
 		struct lpc18xx_pwm_data *data;
 
@@ -421,14 +415,12 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 				    GFP_KERNEL);
 		if (!data) {
 			ret = -ENOMEM;
-			goto remove_pwmchip;
+			goto disable_pwmclk;
 		}
 
 		pwm_set_chip_data(pwm, data);
 	}
 
-	platform_set_drvdata(pdev, lpc18xx_pwm);
-
 	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
 	val &= ~LPC18XX_PWM_BIDIR;
 	val &= ~LPC18XX_PWM_CTRL_HALT;
@@ -436,10 +428,16 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	val |= LPC18XX_PWM_PRE(0);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
 
+	ret = pwmchip_add(&lpc18xx_pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
+		goto disable_pwmclk;
+	}
+
+	platform_set_drvdata(pdev, lpc18xx_pwm);
+
 	return 0;
 
-remove_pwmchip:
-	pwmchip_remove(&lpc18xx_pwm->chip);
 disable_pwmclk:
 	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
 	return ret;
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 323b629474a6..9f76ad9e959d 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -472,6 +472,7 @@ static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
 	}
 
 	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
 	if (ret)
 		return ret;
 
diff --git a/drivers/rtc/rtc-wm8350.c b/drivers/rtc/rtc-wm8350.c
index fa247deb9cf4..b45d7d9b8c06 100644
--- a/drivers/rtc/rtc-wm8350.c
+++ b/drivers/rtc/rtc-wm8350.c
@@ -443,14 +443,21 @@ static int wm8350_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	wm8350_register_irq(wm8350, WM8350_IRQ_RTC_SEC,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_RTC_SEC,
 			    wm8350_rtc_update_handler, 0,
 			    "RTC Seconds", wm8350);
+	if (ret)
+		return ret;
+
 	wm8350_mask_irq(wm8350, WM8350_IRQ_RTC_SEC);
 
-	wm8350_register_irq(wm8350, WM8350_IRQ_RTC_ALM,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_RTC_ALM,
 			    wm8350_rtc_alarm_handler, 0,
 			    "RTC Alarm", wm8350);
+	if (ret) {
+		wm8350_free_irq(wm8350, WM8350_IRQ_RTC_SEC, wm8350);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index f44d0487236e..bd850c5faf77 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -3381,13 +3381,11 @@ static int __init aha152x_setup(char *str)
 	setup[setup_count].synchronous = ints[0] >= 6 ? ints[6] : 1;
 	setup[setup_count].delay       = ints[0] >= 7 ? ints[7] : DELAY_DEFAULT;
 	setup[setup_count].ext_trans   = ints[0] >= 8 ? ints[8] : 0;
-	if (ints[0] > 8) {                                                /*}*/
+	if (ints[0] > 8)
 		printk(KERN_NOTICE "aha152x: usage: aha152x=<IOBASE>[,<IRQ>[,<SCSI ID>"
 		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>]]]]]]]\n");
-	} else {
+	else
 		setup_count++;
-		return 0;
-	}
 
 	return 1;
 }
diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
index 0a70d54a4df6..47e599352468 100644
--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -722,7 +722,7 @@ bfad_im_serial_num_show(struct device *dev, struct device_attribute *attr,
 	char serial_num[BFA_ADAPTER_SERIAL_NUM_LEN];
 
 	bfa_get_adapter_serial_num(&bfad->bfa, serial_num);
-	return snprintf(buf, PAGE_SIZE, "%s\n", serial_num);
+	return sysfs_emit(buf, "%s\n", serial_num);
 }
 
 static ssize_t
@@ -736,7 +736,7 @@ bfad_im_model_show(struct device *dev, struct device_attribute *attr,
 	char model[BFA_ADAPTER_MODEL_NAME_LEN];
 
 	bfa_get_adapter_model(&bfad->bfa, model);
-	return snprintf(buf, PAGE_SIZE, "%s\n", model);
+	return sysfs_emit(buf, "%s\n", model);
 }
 
 static ssize_t
@@ -816,7 +816,7 @@ bfad_im_model_desc_show(struct device *dev, struct device_attribute *attr,
 		snprintf(model_descr, BFA_ADAPTER_MODEL_DESCR_LEN,
 			"Invalid Model");
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", model_descr);
+	return sysfs_emit(buf, "%s\n", model_descr);
 }
 
 static ssize_t
@@ -830,7 +830,7 @@ bfad_im_node_name_show(struct device *dev, struct device_attribute *attr,
 	u64        nwwn;
 
 	nwwn = bfa_fcs_lport_get_nwwn(port->fcs_port);
-	return snprintf(buf, PAGE_SIZE, "0x%llx\n", cpu_to_be64(nwwn));
+	return sysfs_emit(buf, "0x%llx\n", cpu_to_be64(nwwn));
 }
 
 static ssize_t
@@ -847,7 +847,7 @@ bfad_im_symbolic_name_show(struct device *dev, struct device_attribute *attr,
 	bfa_fcs_lport_get_attr(&bfad->bfa_fcs.fabric.bport, &port_attr);
 	strlcpy(symname, port_attr.port_cfg.sym_name.symname,
 			BFA_SYMNAME_MAXLEN);
-	return snprintf(buf, PAGE_SIZE, "%s\n", symname);
+	return sysfs_emit(buf, "%s\n", symname);
 }
 
 static ssize_t
@@ -861,14 +861,14 @@ bfad_im_hw_version_show(struct device *dev, struct device_attribute *attr,
 	char hw_ver[BFA_VERSION_LEN];
 
 	bfa_get_pci_chip_rev(&bfad->bfa, hw_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", hw_ver);
+	return sysfs_emit(buf, "%s\n", hw_ver);
 }
 
 static ssize_t
 bfad_im_drv_version_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", BFAD_DRIVER_VERSION);
+	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_VERSION);
 }
 
 static ssize_t
@@ -882,7 +882,7 @@ bfad_im_optionrom_version_show(struct device *dev,
 	char optrom_ver[BFA_VERSION_LEN];
 
 	bfa_get_adapter_optrom_ver(&bfad->bfa, optrom_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", optrom_ver);
+	return sysfs_emit(buf, "%s\n", optrom_ver);
 }
 
 static ssize_t
@@ -896,7 +896,7 @@ bfad_im_fw_version_show(struct device *dev, struct device_attribute *attr,
 	char fw_ver[BFA_VERSION_LEN];
 
 	bfa_get_adapter_fw_ver(&bfad->bfa, fw_ver);
-	return snprintf(buf, PAGE_SIZE, "%s\n", fw_ver);
+	return sysfs_emit(buf, "%s\n", fw_ver);
 }
 
 static ssize_t
@@ -908,7 +908,7 @@ bfad_im_num_of_ports_show(struct device *dev, struct device_attribute *attr,
 			(struct bfad_im_port_s *) shost->hostdata[0];
 	struct bfad_s *bfad = im_port->bfad;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			bfa_get_nports(&bfad->bfa));
 }
 
@@ -916,7 +916,7 @@ static ssize_t
 bfad_im_drv_name_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", BFAD_DRIVER_NAME);
+	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_NAME);
 }
 
 static ssize_t
@@ -935,14 +935,14 @@ bfad_im_num_of_discovered_ports_show(struct device *dev,
 	rports = kzalloc(sizeof(struct bfa_rport_qualifier_s) * nrports,
 			 GFP_ATOMIC);
 	if (rports == NULL)
-		return snprintf(buf, PAGE_SIZE, "Failed\n");
+		return sysfs_emit(buf, "Failed\n");
 
 	spin_lock_irqsave(&bfad->bfad_lock, flags);
 	bfa_fcs_lport_get_rport_quals(port->fcs_port, rports, &nrports);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
 	kfree(rports);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", nrports);
+	return sysfs_emit(buf, "%d\n", nrports);
 }
 
 static          DEVICE_ATTR(serial_number, S_IRUGO,
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 5ed28111c3c3..569b662e19e7 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -43,7 +43,7 @@
 
 #define IBMVSCSIS_VERSION	"v0.2"
 
-#define	INITIAL_SRP_LIMIT	800
+#define	INITIAL_SRP_LIMIT	1024
 #define	DEFAULT_MAX_SECTORS	256
 #define MAX_TXU			1024 * 1024
 
diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index aac9c648df0c..175713770068 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -1663,6 +1663,7 @@ static void fc_exch_abts_resp(struct fc_exch *ep, struct fc_frame *fp)
 	if (cancel_delayed_work_sync(&ep->timeout_work)) {
 		FC_EXCH_DBG(ep, "Exchange timer canceled due to ABTS response\n");
 		fc_exch_release(ep);	/* release from pending timer hold */
+		return;
 	}
 
 	spin_lock_bh(&ep->ex_lock);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d75d3d11bc80..c05a3e16f615 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -220,7 +220,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 		task->total_xfer_len = qc->nbytes;
 		task->num_scatter = qc->n_elem;
 		task->data_dir = qc->dma_dir;
-	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
+	} else if (!ata_is_data(qc->tf.protocol)) {
 		task->data_dir = DMA_NONE;
 	} else {
 		for_each_sg(qc->sg, sg, qc->n_elem, si)
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 8280046fd1f0..359fd39c6345 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -679,6 +679,7 @@ static struct pci_device_id mvs_pci_table[] = {
 	{ PCI_VDEVICE(ARECA, PCI_DEVICE_ID_ARECA_1300), chip_1300 },
 	{ PCI_VDEVICE(ARECA, PCI_DEVICE_ID_ARECA_1320), chip_1320 },
 	{ PCI_VDEVICE(ADAPTEC2, 0x0450), chip_6440 },
+	{ PCI_VDEVICE(TTI, 0x2640), chip_6440 },
 	{ PCI_VDEVICE(TTI, 0x2710), chip_9480 },
 	{ PCI_VDEVICE(TTI, 0x2720), chip_9480 },
 	{ PCI_VDEVICE(TTI, 0x2721), chip_9480 },
@@ -730,7 +731,7 @@ static ssize_t
 mvs_show_driver_version(struct device *cdev,
 		struct device_attribute *attr,  char *buffer)
 {
-	return snprintf(buffer, PAGE_SIZE, "%s\n", DRV_VERSION);
+	return sysfs_emit(buffer, "%s\n", DRV_VERSION);
 }
 
 static DEVICE_ATTR(driver_version,
@@ -782,7 +783,7 @@ mvs_store_interrupt_coalescing(struct device *cdev,
 static ssize_t mvs_show_interrupt_coalescing(struct device *cdev,
 			struct device_attribute *attr, char *buffer)
 {
-	return snprintf(buffer, PAGE_SIZE, "%d\n", interrupt_coalescing);
+	return sysfs_emit(buffer, "%d\n", interrupt_coalescing);
 }
 
 static DEVICE_ATTR(interrupt_coalescing,
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index f374abfb7f1f..cc90b5c8d462 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1748,6 +1748,7 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	ccb->device = pm8001_ha_dev;
 	ccb->ccb_tag = ccb_tag;
 	ccb->task = task;
+	ccb->n_elem = 0;
 
 	circularQ = &pm8001_ha->inbnd_q_tbl[0];
 
@@ -1810,6 +1811,7 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
 	ccb->device = pm8001_ha_dev;
 	ccb->ccb_tag = ccb_tag;
 	ccb->task = task;
+	ccb->n_elem = 0;
 	pm8001_ha_dev->id |= NCQ_READ_LOG_FLAG;
 	pm8001_ha_dev->id |= NCQ_2ND_RLE_FLAG;
 
@@ -1826,7 +1828,7 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
 
 	sata_cmd.tag = cpu_to_le32(ccb_tag);
 	sata_cmd.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
-	sata_cmd.ncqtag_atap_dir_m |= ((0x1 << 7) | (0x5 << 9));
+	sata_cmd.ncqtag_atap_dir_m = cpu_to_le32((0x1 << 7) | (0x5 << 9));
 	memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
 
 	res = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &sata_cmd, 0);
@@ -3766,12 +3768,11 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	mb();
 
 	if (pm8001_dev->id & NCQ_ABORT_ALL_FLAG) {
-		pm8001_tag_free(pm8001_ha, tag);
 		sas_free_task(t);
-		/* clear the flag */
-		pm8001_dev->id &= 0xBFFFFFFF;
-	} else
+		pm8001_dev->id &= ~NCQ_ABORT_ALL_FLAG;
+	} else {
 		t->task_done(t);
+	}
 
 	return 0;
 }
@@ -4718,7 +4719,7 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
 	memcpy(sspTMCmd.lun, task->ssp_task.LUN, 8);
 	sspTMCmd.tag = cpu_to_le32(ccb->ccb_tag);
 	if (pm8001_ha->chip_id != chip_8001)
-		sspTMCmd.ds_ads_m = 0x08;
+		sspTMCmd.ds_ads_m = cpu_to_le32(0x08);
 	circularQ = &pm8001_ha->inbnd_q_tbl[0];
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &sspTMCmd, 0);
 	return ret;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index df5f0bc29587..4eae727ccfbc 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -870,9 +870,11 @@ pm80xx_set_thermal_config(struct pm8001_hba_info *pm8001_ha)
 	else
 		page_code = THERMAL_PAGE_CODE_8H;
 
-	payload.cfg_pg[0] = (THERMAL_LOG_ENABLE << 9) |
-				(THERMAL_ENABLE << 8) | page_code;
-	payload.cfg_pg[1] = (LTEMPHIL << 24) | (RTEMPHIL << 8);
+	payload.cfg_pg[0] =
+		cpu_to_le32((THERMAL_LOG_ENABLE << 9) |
+			    (THERMAL_ENABLE << 8) | page_code);
+	payload.cfg_pg[1] =
+		cpu_to_le32((LTEMPHIL << 24) | (RTEMPHIL << 8));
 
 	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload, 0);
 	if (rc)
@@ -1424,6 +1426,7 @@ static void pm80xx_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	ccb->device = pm8001_ha_dev;
 	ccb->ccb_tag = ccb_tag;
 	ccb->task = task;
+	ccb->n_elem = 0;
 
 	circularQ = &pm8001_ha->inbnd_q_tbl[0];
 
@@ -1504,7 +1507,7 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
 
 	sata_cmd.tag = cpu_to_le32(ccb_tag);
 	sata_cmd.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
-	sata_cmd.ncqtag_atap_dir_m_dad |= ((0x1 << 7) | (0x5 << 9));
+	sata_cmd.ncqtag_atap_dir_m_dad = cpu_to_le32(((0x1 << 7) | (0x5 << 9)));
 	memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
 
 	res = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &sata_cmd, 0);
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 6249c4b6f4be..15fcb148d175 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1618,6 +1618,7 @@ qla24xx_tm_iocb_entry(scsi_qla_host_t *vha, struct req_que *req, void *tsk)
 		iocb->u.tmf.data = QLA_FUNCTION_FAILED;
 	} else if ((le16_to_cpu(sts->scsi_status) &
 	    SS_RESPONSE_INFO_LEN_VALID)) {
+		host_to_fcp_swap(sts->data, sizeof(sts->data));
 		if (le32_to_cpu(sts->rsp_data_len) < 4) {
 			ql_log(ql_log_warn, fcport->vha, 0x503b,
 			    "Async-%s error - hdl=%x not enough response(%d).\n",
diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index e1b32ed0aa20..bdfe94c023dc 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -210,12 +210,11 @@ static void scsifront_gnttab_done(struct vscsifrnt_info *info, uint32_t id)
 		return;
 
 	for (i = 0; i < s->nr_grants; i++) {
-		if (unlikely(gnttab_query_foreign_access(s->gref[i]) != 0)) {
+		if (unlikely(!gnttab_try_end_foreign_access(s->gref[i]))) {
 			shost_printk(KERN_ALERT, info->host, KBUILD_MODNAME
 				     "grant still in use by backend\n");
 			BUG();
 		}
-		gnttab_end_foreign_access(s->gref[i], 0, 0UL);
 	}
 
 	kfree(s->sg);
diff --git a/drivers/scsi/zorro7xx.c b/drivers/scsi/zorro7xx.c
index aff31991aea9..ee6d97473853 100644
--- a/drivers/scsi/zorro7xx.c
+++ b/drivers/scsi/zorro7xx.c
@@ -158,6 +158,8 @@ static void zorro7xx_remove_one(struct zorro_dev *z)
 	scsi_remove_host(host);
 
 	NCR_700_release(host);
+	if (host->base > 0x01000000)
+		iounmap(hostdata->base);
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	zorro_release_device(z);
diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 7ae59abc7863..127a4a836e67 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -41,6 +41,8 @@ int par_io_init(struct device_node *np)
 	if (ret)
 		return ret;
 	par_io = ioremap(res.start, resource_size(&res));
+	if (!par_io)
+		return -ENOMEM;
 
 	num_ports = of_get_property(np, "num-ports", NULL);
 	if (num_ports)
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index fc33bfdc957c..ead96fe2e7f5 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -405,9 +405,9 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource\n");
-		return -ENXIO;
+		return irq;
 	}
 
 	ret = devm_request_irq(dev, irq, wkup_m3_txev_handler,
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d1ca8f619b82..89a3121f4f25 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1098,6 +1098,10 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->phys = r->start;
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0) {
+		ret = spi_irq;
+		goto exit_free_master;
+	}
 	tspi->irq = spi_irq;
 
 	tspi->clk = devm_clk_get(&pdev->dev, "spi");
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 88bfe7682a9e..b8a3a78730b5 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1016,14 +1016,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	struct resource		*r;
 	int ret, spi_irq;
 	const struct tegra_slink_chip_data *cdata = NULL;
-	const struct of_device_id *match;
 
-	match = of_match_device(tegra_slink_of_match, &pdev->dev);
-	if (!match) {
-		dev_err(&pdev->dev, "Error: No device match found\n");
-		return -ENODEV;
-	}
-	cdata = match->data;
+	cdata = of_device_get_match_data(&pdev->dev);
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
 	if (!master) {
diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 085e9872c46d..93bfde68f545 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -85,6 +85,8 @@ enum st7789v_command {
  */
 static int init_display(struct fbtft_par *par)
 {
+	par->fbtftops.reset(par);
+
 	/* turn off sleep mode */
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	mdelay(120);
diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 454e47424ade..463f920d3782 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -85,14 +85,15 @@ static void tx_complete(void *arg)
 
 static int gdm_lte_rx(struct sk_buff *skb, struct nic *nic, int nic_type)
 {
-	int ret;
+	int ret, len;
 
+	len = skb->len + ETH_HLEN;
 	ret = netif_rx_ni(skb);
 	if (ret == NET_RX_DROP) {
 		nic->stats.rx_dropped++;
 	} else {
 		nic->stats.rx_packets++;
-		nic->stats.rx_bytes += skb->len + ETH_HLEN;
+		nic->stats.rx_bytes += len;
 	}
 
 	return 0;
diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index d4c374cc4f74..a8a47013ba47 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -51,7 +51,7 @@ struct int3400_thermal_priv {
 	struct art *arts;
 	int trt_count;
 	struct trt *trts;
-	u8 uuid_bitmap;
+	u32 uuid_bitmap;
 	int rel_misc_dev_res;
 	int current_uuid_index;
 };
diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index 8b70a1627356..799bc191982c 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -1469,7 +1469,9 @@ static int __init hvc_iucv_init(void)
  */
 static	int __init hvc_iucv_config(char *val)
 {
-	 return kstrtoul(val, 10, &hvc_iucv_devices);
+	if (kstrtoul(val, 10, &hvc_iucv_devices))
+		pr_warn("hvc_iucv= invalid parameter value '%s'\n", val);
+	return 1;
 }
 
 
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 69294ae154be..ea7f4af85d58 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -860,6 +860,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	struct mxser_port *info = container_of(port, struct mxser_port, port);
 	unsigned long page;
 	unsigned long flags;
+	int ret;
 
 	page = __get_free_page(GFP_KERNEL);
 	if (!page)
@@ -869,9 +870,9 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 
 	if (!info->ioaddr || !info->type) {
 		set_bit(TTY_IO_ERROR, &tty->flags);
-		free_page(page);
 		spin_unlock_irqrestore(&info->slock, flags);
-		return 0;
+		ret = 0;
+		goto err_free_xmit;
 	}
 	info->port.xmit_buf = (unsigned char *) page;
 
@@ -897,8 +898,10 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 		if (capable(CAP_SYS_ADMIN)) {
 			set_bit(TTY_IO_ERROR, &tty->flags);
 			return 0;
-		} else
-			return -ENODEV;
+		}
+
+		ret = -ENODEV;
+		goto err_free_xmit;
 	}
 
 	/*
@@ -943,6 +946,10 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	return 0;
+err_free_xmit:
+	free_page(page);
+	info->port.xmit_buf = NULL;
+	return ret;
 }
 
 /*
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 67e5b587a106..2311f8a635a6 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -444,7 +444,7 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 		modembits |= MDM_RTR;
 	if (dlci->modem_tx & TIOCM_RI)
 		modembits |= MDM_IC;
-	if (dlci->modem_tx & TIOCM_CD)
+	if (dlci->modem_tx & TIOCM_CD || dlci->gsm->initiator)
 		modembits |= MDM_DV;
 	return modembits;
 }
@@ -1506,7 +1506,7 @@ static void gsm_dlci_t1(unsigned long data)
 			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
-			gsm_dlci_close(dlci);
+			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 
 		break;
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index f89dfde934a3..54ed7675e447 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -86,7 +86,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_warn(&ofdev->dev, "invalid address\n");
-		goto out;
+		goto err_unprepare;
 	}
 
 	spin_lock_init(&port->lock);
@@ -94,8 +94,17 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	port->mapsize = resource_size(&resource);
 
 	/* Check for shifted address mapping */
-	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
+	if (of_property_read_u32(np, "reg-offset", &prop) == 0) {
+		if (prop >= port->mapsize) {
+			dev_warn(&ofdev->dev, "reg-offset %u exceeds region size %pa\n",
+				 prop, &port->mapsize);
+			ret = -EINVAL;
+			goto err_unprepare;
+		}
+
 		port->mapbase += prop;
+		port->mapsize -= prop;
+	}
 
 	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. */
 	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
@@ -132,7 +141,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 			dev_warn(&ofdev->dev, "unsupported reg-io-width (%d)\n",
 				 prop);
 			ret = -EINVAL;
-			goto out;
+			goto err_dispose;
 		}
 	}
 
@@ -162,7 +171,9 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->handle_irq = fsl8250_handle_irq;
 
 	return 0;
-out:
+err_dispose:
+	irq_dispose_mapping(port->irq);
+err_unprepare:
 	if (info->clk)
 		clk_disable_unprepare(info->clk);
 	return ret;
@@ -194,7 +205,7 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	port_type = (unsigned long)match->data;
 	ret = of_platform_serial_setup(ofdev, port_type, &port, info);
 	if (ret)
-		goto out;
+		goto err_free;
 
 	switch (port_type) {
 	case PORT_8250 ... PORT_MAX_8250:
@@ -228,15 +239,18 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 		break;
 	}
 	if (ret < 0)
-		goto out;
+		goto err_dispose;
 
 	info->type = port_type;
 	info->line = ret;
 	platform_set_drvdata(ofdev, info);
 	return 0;
-out:
-	kfree(info);
+err_dispose:
 	irq_dispose_mapping(port.irq);
+	if (info->clk)
+		clk_disable_unprepare(info->clk);
+err_free:
+	kfree(info);
 	return ret;
 }
 
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 0314e78e31ff..72b89702d008 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -304,16 +304,16 @@ static int kgdboc_option_setup(char *opt)
 {
 	if (!opt) {
 		pr_err("config string not provided\n");
-		return -EINVAL;
+		return 1;
 	}
 
 	if (strlen(opt) >= MAX_CONFIG_LEN) {
 		pr_err("config string too long\n");
-		return -ENOSPC;
+		return 1;
 	}
 	strcpy(config, opt);
 
-	return 0;
+	return 1;
 }
 
 __setup("kgdboc=", kgdboc_option_setup);
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 8c89697c5357..15b9bf35457b 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -764,11 +764,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 		goto out;
 	}
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
-		spin_unlock(&port->lock);
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-		spin_lock(&port->lock);
-	}
 
 	if (uart_circ_empty(xmit))
 		s3c24xx_serial_stop_tx(port);
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 8e69150776f5..a08b29fbaa50 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -245,7 +245,7 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 		break;
 
 	case OMAP_DWC3_ID_FLOAT:
-		if (omap->vbus_reg)
+		if (omap->vbus_reg && regulator_is_enabled(omap->vbus_reg))
 			regulator_disable(omap->vbus_reg);
 		val = dwc3_omap_read_utmi_ctrl(omap);
 		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 58c4b745eae1..ccc47594064f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2904,9 +2904,11 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
+	local_bh_disable();
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = dwc3_process_event_buf(evt);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index a912b6b9153f..30eeaf9bc8ec 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -645,6 +645,7 @@ static int rndis_set_response(struct rndis_params *params,
 	BufLength = le32_to_cpu(buf->InformationBufferLength);
 	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
 	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
+	    (BufOffset > RNDIS_MAX_TOTAL_SIZE) ||
 	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
 		    return -EINVAL;
 
@@ -924,6 +925,7 @@ struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v)
 	params->resp_avail = resp_avail;
 	params->v = v;
 	INIT_LIST_HEAD(&params->resp_queue);
+	spin_lock_init(&params->resp_lock);
 	pr_debug("%s: configNr = %d\n", __func__, i);
 
 	return params;
@@ -1017,12 +1019,14 @@ void rndis_free_response(struct rndis_params *params, u8 *buf)
 {
 	rndis_resp_t *r, *n;
 
+	spin_lock(&params->resp_lock);
 	list_for_each_entry_safe(r, n, &params->resp_queue, list) {
 		if (r->buf == buf) {
 			list_del(&r->list);
 			kfree(r);
 		}
 	}
+	spin_unlock(&params->resp_lock);
 }
 EXPORT_SYMBOL_GPL(rndis_free_response);
 
@@ -1032,14 +1036,17 @@ u8 *rndis_get_next_response(struct rndis_params *params, u32 *length)
 
 	if (!length) return NULL;
 
+	spin_lock(&params->resp_lock);
 	list_for_each_entry_safe(r, n, &params->resp_queue, list) {
 		if (!r->send) {
 			r->send = 1;
 			*length = r->length;
+			spin_unlock(&params->resp_lock);
 			return r->buf;
 		}
 	}
 
+	spin_unlock(&params->resp_lock);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(rndis_get_next_response);
@@ -1056,7 +1063,9 @@ static rndis_resp_t *rndis_add_response(struct rndis_params *params, u32 length)
 	r->length = length;
 	r->send = 0;
 
+	spin_lock(&params->resp_lock);
 	list_add_tail(&r->list, &params->resp_queue);
+	spin_unlock(&params->resp_lock);
 	return r;
 }
 
diff --git a/drivers/usb/gadget/function/rndis.h b/drivers/usb/gadget/function/rndis.h
index ef92eb66d8ad..a389df725a29 100644
--- a/drivers/usb/gadget/function/rndis.h
+++ b/drivers/usb/gadget/function/rndis.h
@@ -194,6 +194,7 @@ typedef struct rndis_params
 	void			(*resp_avail)(void *v);
 	void			*v;
 	struct list_head	resp_queue;
+	spinlock_t		resp_lock;
 } rndis_params;
 
 /* RNDIS Message parser and other useless functions */
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 68e608389786..b2fc97dbda45 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1833,8 +1833,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	spin_lock_irq (&dev->lock);
 	value = -EINVAL;
 	if (dev->buf) {
+		spin_unlock_irq(&dev->lock);
 		kfree(kbuf);
-		goto fail;
+		return value;
 	}
 	dev->buf = kbuf;
 
@@ -1882,8 +1883,8 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 	value = usb_gadget_probe_driver(&gadgetfs_driver);
 	if (value != 0) {
-		kfree (dev->buf);
-		dev->buf = NULL;
+		spin_lock_irq(&dev->lock);
+		goto fail;
 	} else {
 		/* at this point "good" hardware has for the first time
 		 * let the USB the host see us.  alternatively, if users
@@ -1900,6 +1901,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	return value;
 
 fail:
+	dev->config = NULL;
+	dev->hs_config = NULL;
+	dev->dev = NULL;
 	spin_unlock_irq (&dev->lock);
 	pr_debug ("%s: %s fail %Zd, %p\n", shortname, __func__, value, dev);
 	kfree (dev->buf);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 34ad964d54d1..5d8c3fd2acc8 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1253,7 +1253,6 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 	usb_gadget_udc_stop(udc);
 
 	udc->driver = NULL;
-	udc->dev.driver = NULL;
 	udc->gadget->dev.driver = NULL;
 }
 
@@ -1301,7 +1300,6 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 			driver->function);
 
 	udc->driver = driver;
-	udc->dev.driver = &driver->driver;
 	udc->gadget->dev.driver = &driver->driver;
 
 	ret = driver->bind(udc->gadget, driver);
@@ -1321,7 +1319,6 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
 		dev_err(&udc->dev, "failed to start %s: %d\n",
 			udc->driver->function, ret);
 	udc->driver = NULL;
-	udc->dev.driver = NULL;
 	udc->gadget->dev.driver = NULL;
 	return ret;
 }
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 588e2531b8b8..b4cc04b6ae03 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1620,6 +1620,8 @@ static void xudc_getstatus(struct xusb_udc *udc)
 		break;
 	case USB_RECIP_ENDPOINT:
 		epnum = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (epnum >= XUSB_MAX_ENDPOINTS)
+			goto stall;
 		target_ep = &udc->ep[epnum];
 		epcfgreg = udc->read_fn(udc->addr + target_ep->offset);
 		halt = epcfgreg & XUSB_EP_CFG_STALL_MASK;
@@ -1687,6 +1689,10 @@ static void xudc_set_clear_feature(struct xusb_udc *udc)
 	case USB_RECIP_ENDPOINT:
 		if (!udc->setup.wValue) {
 			endpoint = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+			if (endpoint >= XUSB_MAX_ENDPOINTS) {
+				xudc_ep0_stall(udc);
+				return;
+			}
 			target_ep = &udc->ep[endpoint];
 			outinbit = udc->setup.wIndex & USB_ENDPOINT_DIR_MASK;
 			outinbit = outinbit >> 7;
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 2df61fff8ae3..a08369cb3462 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1397,9 +1397,12 @@ int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flags)
 	struct urb_priv	*urb_priv;
 	int size, i;
 
-	if (!urb || xhci_check_args(hcd, urb->dev, urb->ep,
-					true, true, __func__) <= 0)
+	if (!urb)
 		return -EINVAL;
+	ret = xhci_check_args(hcd, urb->dev, urb->ep,
+					true, true, __func__);
+	if (ret <= 0)
+		return ret ? ret : -EINVAL;
 
 	slot_id = urb->dev->slot_id;
 	ep_index = xhci_get_endpoint_index(&urb->ep->desc);
@@ -3031,7 +3034,7 @@ static int xhci_check_streams_endpoint(struct xhci_hcd *xhci,
 		return -EINVAL;
 	ret = xhci_check_args(xhci_to_hcd(xhci), udev, ep, 1, true, __func__);
 	if (ret <= 0)
-		return -EINVAL;
+		return ret ? ret : -EINVAL;
 	if (usb_ss_max_streams(&ep->ss_ep_comp) == 0) {
 		xhci_warn(xhci, "WARN: SuperSpeed Endpoint Companion"
 				" descriptor for ep 0x%x does not support streams\n",
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 77c3ebe860c5..b495bbecf809 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -65,6 +65,7 @@ config USB_SERIAL_SIMPLE
 		- Libtransistor USB console
 		- a number of Motorola phones
 		- Motorola Tetra devices
+		- Nokia mobile phones
 		- Novatel Wireless GPS receivers
 		- Siemens USB/MPI adapter.
 		- ViVOtech ViVOpay USB device.
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index a8573da2717a..a2337d15233f 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -70,7 +70,6 @@
 
 
 static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE(0x1a86, 0x5512) },
 	{ USB_DEVICE(0x1a86, 0x5523) },
 	{ USB_DEVICE(0x1a86, 0x7522) },
 	{ USB_DEVICE(0x1a86, 0x7523) },
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4c3ff0706554..c5d0d9e2bff2 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -201,6 +201,8 @@ static void option_instat_callback(struct urb *urb);
 
 #define DELL_PRODUCT_5821E			0x81d7
 #define DELL_PRODUCT_5821E_ESIM			0x81e0
+#define DELL_PRODUCT_5829E_ESIM			0x81e4
+#define DELL_PRODUCT_5829E			0x81e6
 
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
@@ -1058,6 +1060,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5821E_ESIM),
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
+	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E),
+	  .driver_info = RSVD(0) | RSVD(6) },
+	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
+	  .driver_info = RSVD(0) | RSVD(6) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },
@@ -1249,10 +1255,16 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x7011, 0xff),	/* Telit LE910-S1 (ECM) */
 	  .driver_info = NCTRL(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x701a, 0xff),	/* Telit LE910R1 (RNDIS) */
+	  .driver_info = NCTRL(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x701b, 0xff),	/* Telit LE910R1 (ECM) */
+	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9010),				/* Telit SBL FN980 flashing device */
 	  .driver_info = NCTRL(0) | ZLP },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9200),				/* Telit LE910S1 flashing device */
 	  .driver_info = NCTRL(0) | ZLP },
+	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9201),				/* Telit LE910R1 flashing device */
+	  .driver_info = NCTRL(0) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, ZTE_PRODUCT_MF622, 0xff, 0xff, 0xff) }, /* ZTE WCDMA products */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0002, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) },
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 3dd0bbb36dd2..c5fa5b704ec5 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -105,6 +105,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(ADLINK_VENDOR_ID, ADLINK_ND6530GC_PRODUCT_ID) },
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
+	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 62b8cd673aa1..908865495b48 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -33,6 +33,9 @@
 #define ATEN_PRODUCT_UC485	0x2021
 #define ATEN_PRODUCT_ID2	0x2118
 
+#define IBM_VENDOR_ID		0x04b3
+#define IBM_PRODUCT_ID		0x4016
+
 #define IODATA_VENDOR_ID	0x04bb
 #define IODATA_PRODUCT_ID	0x0a03
 #define IODATA_PRODUCT_ID_RSAQ5	0x0a0e
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 15e05ebf37ac..3681e6418262 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -94,6 +94,11 @@ DEVICE(moto_modem, MOTO_IDS);
 	{ USB_DEVICE(0x0cad, 0x9016) }	/* TPG2200 */
 DEVICE(motorola_tetra, MOTOROLA_TETRA_IDS);
 
+/* Nokia mobile phone driver */
+#define NOKIA_IDS()			\
+	{ USB_DEVICE(0x0421, 0x069a) }	/* Nokia 130 (RM-1035) */
+DEVICE(nokia, NOKIA_IDS);
+
 /* Novatel Wireless GPS driver */
 #define NOVATEL_IDS()			\
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
@@ -126,6 +131,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
+	&nokia_device,
 	&novatel_gps_device,
 	&hp4x_device,
 	&suunto_device,
@@ -143,6 +149,7 @@ static const struct usb_device_id id_table[] = {
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
+	NOKIA_IDS(),
 	NOVATEL_IDS(),
 	HP4X_IDS(),
 	SUUNTO_IDS(),
diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 4d6eb48b2c45..aa88ff70b078 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -251,36 +251,33 @@ static struct us_unusual_dev ene_ub6250_unusual_dev_list[] = {
 #define memstick_logaddr(logadr1, logadr0) ((((u16)(logadr1)) << 8) | (logadr0))
 
 
-struct SD_STATUS {
-	u8    Insert:1;
-	u8    Ready:1;
-	u8    MediaChange:1;
-	u8    IsMMC:1;
-	u8    HiCapacity:1;
-	u8    HiSpeed:1;
-	u8    WtP:1;
-	u8    Reserved:1;
-};
-
-struct MS_STATUS {
-	u8    Insert:1;
-	u8    Ready:1;
-	u8    MediaChange:1;
-	u8    IsMSPro:1;
-	u8    IsMSPHG:1;
-	u8    Reserved1:1;
-	u8    WtP:1;
-	u8    Reserved2:1;
-};
-
-struct SM_STATUS {
-	u8    Insert:1;
-	u8    Ready:1;
-	u8    MediaChange:1;
-	u8    Reserved:3;
-	u8    WtP:1;
-	u8    IsMS:1;
-};
+/* SD_STATUS bits */
+#define SD_Insert	BIT(0)
+#define SD_Ready	BIT(1)
+#define SD_MediaChange	BIT(2)
+#define SD_IsMMC	BIT(3)
+#define SD_HiCapacity	BIT(4)
+#define SD_HiSpeed	BIT(5)
+#define SD_WtP		BIT(6)
+			/* Bit 7 reserved */
+
+/* MS_STATUS bits */
+#define MS_Insert	BIT(0)
+#define MS_Ready	BIT(1)
+#define MS_MediaChange	BIT(2)
+#define MS_IsMSPro	BIT(3)
+#define MS_IsMSPHG	BIT(4)
+			/* Bit 5 reserved */
+#define MS_WtP		BIT(6)
+			/* Bit 7 reserved */
+
+/* SM_STATUS bits */
+#define SM_Insert	BIT(0)
+#define SM_Ready	BIT(1)
+#define SM_MediaChange	BIT(2)
+			/* Bits 3-5 reserved */
+#define SM_WtP		BIT(6)
+#define SM_IsMS		BIT(7)
 
 struct ms_bootblock_cis {
 	u8 bCistplDEVICE[6];    /* 0 */
@@ -451,9 +448,9 @@ struct ene_ub6250_info {
 	u8		*bbuf;
 
 	/* for 6250 code */
-	struct SD_STATUS	SD_Status;
-	struct MS_STATUS	MS_Status;
-	struct SM_STATUS	SM_Status;
+	u8		SD_Status;
+	u8		MS_Status;
+	u8		SM_Status;
 
 	/* ----- SD Control Data ---------------- */
 	/*SD_REGISTER SD_Regs; */
@@ -588,7 +585,7 @@ static int sd_scsi_test_unit_ready(struct us_data *us, struct scsi_cmnd *srb)
 {
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *) us->extra;
 
-	if (info->SD_Status.Insert && info->SD_Status.Ready)
+	if ((info->SD_Status & SD_Insert) && (info->SD_Status & SD_Ready))
 		return USB_STOR_TRANSPORT_GOOD;
 	else {
 		ene_sd_init(us);
@@ -620,7 +617,7 @@ static int sd_scsi_mode_sense(struct us_data *us, struct scsi_cmnd *srb)
 		0x0b, 0x00, 0x80, 0x08, 0x00, 0x00,
 		0x71, 0xc0, 0x00, 0x00, 0x02, 0x00 };
 
-	if (info->SD_Status.WtP)
+	if (info->SD_Status & SD_WtP)
 		usb_stor_set_xfer_buf(mediaWP, 12, srb);
 	else
 		usb_stor_set_xfer_buf(mediaNoWP, 12, srb);
@@ -639,9 +636,9 @@ static int sd_scsi_read_capacity(struct us_data *us, struct scsi_cmnd *srb)
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *) us->extra;
 
 	usb_stor_dbg(us, "sd_scsi_read_capacity\n");
-	if (info->SD_Status.HiCapacity) {
+	if (info->SD_Status & SD_HiCapacity) {
 		bl_len = 0x200;
-		if (info->SD_Status.IsMMC)
+		if (info->SD_Status & SD_IsMMC)
 			bl_num = info->HC_C_SIZE-1;
 		else
 			bl_num = (info->HC_C_SIZE + 1) * 1024 - 1;
@@ -691,7 +688,7 @@ static int sd_scsi_read(struct us_data *us, struct scsi_cmnd *srb)
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	if (info->SD_Status.HiCapacity)
+	if (info->SD_Status & SD_HiCapacity)
 		bnByte = bn;
 
 	/* set up the command wrapper */
@@ -731,7 +728,7 @@ static int sd_scsi_write(struct us_data *us, struct scsi_cmnd *srb)
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	if (info->SD_Status.HiCapacity)
+	if (info->SD_Status & SD_HiCapacity)
 		bnByte = bn;
 
 	/* set up the command wrapper */
@@ -1447,7 +1444,7 @@ static int ms_scsi_test_unit_ready(struct us_data *us, struct scsi_cmnd *srb)
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 
 	/* pr_info("MS_SCSI_Test_Unit_Ready\n"); */
-	if (info->MS_Status.Insert && info->MS_Status.Ready) {
+	if ((info->MS_Status & MS_Insert) && (info->MS_Status & MS_Ready)) {
 		return USB_STOR_TRANSPORT_GOOD;
 	} else {
 		ene_ms_init(us);
@@ -1480,7 +1477,7 @@ static int ms_scsi_mode_sense(struct us_data *us, struct scsi_cmnd *srb)
 		0x0b, 0x00, 0x80, 0x08, 0x00, 0x00,
 		0x71, 0xc0, 0x00, 0x00, 0x02, 0x00 };
 
-	if (info->MS_Status.WtP)
+	if (info->MS_Status & MS_WtP)
 		usb_stor_set_xfer_buf(mediaWP, 12, srb);
 	else
 		usb_stor_set_xfer_buf(mediaNoWP, 12, srb);
@@ -1499,7 +1496,7 @@ static int ms_scsi_read_capacity(struct us_data *us, struct scsi_cmnd *srb)
 
 	usb_stor_dbg(us, "ms_scsi_read_capacity\n");
 	bl_len = 0x200;
-	if (info->MS_Status.IsMSPro)
+	if (info->MS_Status & MS_IsMSPro)
 		bl_num = info->MSP_TotalBlock - 1;
 	else
 		bl_num = info->MS_Lib.NumberOfLogBlock * info->MS_Lib.blockSize * 2 - 1;
@@ -1654,7 +1651,7 @@ static int ms_scsi_read(struct us_data *us, struct scsi_cmnd *srb)
 	if (bn > info->bl_num)
 		return USB_STOR_TRANSPORT_ERROR;
 
-	if (info->MS_Status.IsMSPro) {
+	if (info->MS_Status & MS_IsMSPro) {
 		result = ene_load_bincode(us, MSP_RW_PATTERN);
 		if (result != USB_STOR_XFER_GOOD) {
 			usb_stor_dbg(us, "Load MPS RW pattern Fail !!\n");
@@ -1755,7 +1752,7 @@ static int ms_scsi_write(struct us_data *us, struct scsi_cmnd *srb)
 	if (bn > info->bl_num)
 		return USB_STOR_TRANSPORT_ERROR;
 
-	if (info->MS_Status.IsMSPro) {
+	if (info->MS_Status & MS_IsMSPro) {
 		result = ene_load_bincode(us, MSP_RW_PATTERN);
 		if (result != USB_STOR_XFER_GOOD) {
 			pr_info("Load MSP RW pattern Fail !!\n");
@@ -1863,12 +1860,12 @@ static int ene_get_card_status(struct us_data *us, u8 *buf)
 
 	tmpreg = (u16) reg4b;
 	reg4b = *(u32 *)(&buf[0x14]);
-	if (info->SD_Status.HiCapacity && !info->SD_Status.IsMMC)
+	if ((info->SD_Status & SD_HiCapacity) && !(info->SD_Status & SD_IsMMC))
 		info->HC_C_SIZE = (reg4b >> 8) & 0x3fffff;
 
 	info->SD_C_SIZE = ((tmpreg & 0x03) << 10) | (u16)(reg4b >> 22);
 	info->SD_C_SIZE_MULT = (u8)(reg4b >> 7)  & 0x07;
-	if (info->SD_Status.HiCapacity && info->SD_Status.IsMMC)
+	if ((info->SD_Status & SD_HiCapacity) && (info->SD_Status & SD_IsMMC))
 		info->HC_C_SIZE = *(u32 *)(&buf[0x100]);
 
 	if (info->SD_READ_BL_LEN > SD_BLOCK_LEN) {
@@ -2080,6 +2077,7 @@ static int ene_ms_init(struct us_data *us)
 	u16 MSP_BlockSize, MSP_UserAreaBlocks;
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *) us->extra;
 	u8 *bbuf = info->bbuf;
+	unsigned int s;
 
 	printk(KERN_INFO "transport --- ENE_MSInit\n");
 
@@ -2104,15 +2102,16 @@ static int ene_ms_init(struct us_data *us)
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 	/* the same part to test ENE */
-	info->MS_Status = *(struct MS_STATUS *) bbuf;
-
-	if (info->MS_Status.Insert && info->MS_Status.Ready) {
-		printk(KERN_INFO "Insert     = %x\n", info->MS_Status.Insert);
-		printk(KERN_INFO "Ready      = %x\n", info->MS_Status.Ready);
-		printk(KERN_INFO "IsMSPro    = %x\n", info->MS_Status.IsMSPro);
-		printk(KERN_INFO "IsMSPHG    = %x\n", info->MS_Status.IsMSPHG);
-		printk(KERN_INFO "WtP= %x\n", info->MS_Status.WtP);
-		if (info->MS_Status.IsMSPro) {
+	info->MS_Status = bbuf[0];
+
+	s = info->MS_Status;
+	if ((s & MS_Insert) && (s & MS_Ready)) {
+		printk(KERN_INFO "Insert     = %x\n", !!(s & MS_Insert));
+		printk(KERN_INFO "Ready      = %x\n", !!(s & MS_Ready));
+		printk(KERN_INFO "IsMSPro    = %x\n", !!(s & MS_IsMSPro));
+		printk(KERN_INFO "IsMSPHG    = %x\n", !!(s & MS_IsMSPHG));
+		printk(KERN_INFO "WtP= %x\n", !!(s & MS_WtP));
+		if (s & MS_IsMSPro) {
 			MSP_BlockSize      = (bbuf[6] << 8) | bbuf[7];
 			MSP_UserAreaBlocks = (bbuf[10] << 8) | bbuf[11];
 			info->MSP_TotalBlock = MSP_BlockSize * MSP_UserAreaBlocks;
@@ -2173,17 +2172,17 @@ static int ene_sd_init(struct us_data *us)
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	info->SD_Status =  *(struct SD_STATUS *) bbuf;
-	if (info->SD_Status.Insert && info->SD_Status.Ready) {
-		struct SD_STATUS *s = &info->SD_Status;
+	info->SD_Status = bbuf[0];
+	if ((info->SD_Status & SD_Insert) && (info->SD_Status & SD_Ready)) {
+		unsigned int s = info->SD_Status;
 
 		ene_get_card_status(us, bbuf);
-		usb_stor_dbg(us, "Insert     = %x\n", s->Insert);
-		usb_stor_dbg(us, "Ready      = %x\n", s->Ready);
-		usb_stor_dbg(us, "IsMMC      = %x\n", s->IsMMC);
-		usb_stor_dbg(us, "HiCapacity = %x\n", s->HiCapacity);
-		usb_stor_dbg(us, "HiSpeed    = %x\n", s->HiSpeed);
-		usb_stor_dbg(us, "WtP        = %x\n", s->WtP);
+		usb_stor_dbg(us, "Insert     = %x\n", !!(s & SD_Insert));
+		usb_stor_dbg(us, "Ready      = %x\n", !!(s & SD_Ready));
+		usb_stor_dbg(us, "IsMMC      = %x\n", !!(s & SD_IsMMC));
+		usb_stor_dbg(us, "HiCapacity = %x\n", !!(s & SD_HiCapacity));
+		usb_stor_dbg(us, "HiSpeed    = %x\n", !!(s & SD_HiSpeed));
+		usb_stor_dbg(us, "WtP        = %x\n", !!(s & SD_WtP));
 	} else {
 		usb_stor_dbg(us, "SD Card Not Ready --- %x\n", bbuf[0]);
 		return USB_STOR_TRANSPORT_ERROR;
@@ -2205,14 +2204,14 @@ static int ene_init(struct us_data *us)
 
 	misc_reg03 = bbuf[0];
 	if (misc_reg03 & 0x01) {
-		if (!info->SD_Status.Ready) {
+		if (!(info->SD_Status & SD_Ready)) {
 			result = ene_sd_init(us);
 			if (result != USB_STOR_XFER_GOOD)
 				return USB_STOR_TRANSPORT_ERROR;
 		}
 	}
 	if (misc_reg03 & 0x02) {
-		if (!info->MS_Status.Ready) {
+		if (!(info->MS_Status & MS_Ready)) {
 			result = ene_ms_init(us);
 			if (result != USB_STOR_XFER_GOOD)
 				return USB_STOR_TRANSPORT_ERROR;
@@ -2302,14 +2301,14 @@ static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 
 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready)))
+	if (unlikely(!(info->SD_Status & SD_Ready) || (info->MS_Status & MS_Ready)))
 		result = ene_init(us);
 	if (result == USB_STOR_XFER_GOOD) {
 		result = USB_STOR_TRANSPORT_ERROR;
-		if (info->SD_Status.Ready)
+		if (info->SD_Status & SD_Ready)
 			result = sd_scsi_irp(us, srb);
 
-		if (info->MS_Status.Ready)
+		if (info->MS_Status & MS_Ready)
 			result = ms_scsi_irp(us, srb);
 	}
 	return result;
@@ -2373,7 +2372,6 @@ static int ene_ub6250_probe(struct usb_interface *intf,
 
 static int ene_ub6250_resume(struct usb_interface *iface)
 {
-	u8 tmp = 0;
 	struct us_data *us = usb_get_intfdata(iface);
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 
@@ -2385,17 +2383,16 @@ static int ene_ub6250_resume(struct usb_interface *iface)
 	mutex_unlock(&us->dev_mutex);
 
 	info->Power_IsResum = true;
-	/*info->SD_Status.Ready = 0; */
-	info->SD_Status = *(struct SD_STATUS *)&tmp;
-	info->MS_Status = *(struct MS_STATUS *)&tmp;
-	info->SM_Status = *(struct SM_STATUS *)&tmp;
+	/* info->SD_Status &= ~SD_Ready; */
+	info->SD_Status = 0;
+	info->MS_Status = 0;
+	info->SM_Status = 0;
 
 	return 0;
 }
 
 static int ene_ub6250_reset_resume(struct usb_interface *iface)
 {
-	u8 tmp = 0;
 	struct us_data *us = usb_get_intfdata(iface);
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 
@@ -2407,10 +2404,10 @@ static int ene_ub6250_reset_resume(struct usb_interface *iface)
 	 * the device
 	 */
 	info->Power_IsResum = true;
-	/*info->SD_Status.Ready = 0; */
-	info->SD_Status = *(struct SD_STATUS *)&tmp;
-	info->MS_Status = *(struct MS_STATUS *)&tmp;
-	info->SM_Status = *(struct SM_STATUS *)&tmp;
+	/* info->SD_Status &= ~SD_Ready; */
+	info->SD_Status = 0;
+	info->MS_Status = 0;
+	info->SM_Status = 0;
 
 	return 0;
 }
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index d955761fce6f..d9d69637d614 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -377,7 +377,7 @@ static int rts51x_read_mem(struct us_data *us, u16 addr, u8 *data, u16 len)
 
 	buf = kmalloc(len, GFP_NOIO);
 	if (buf == NULL)
-		return USB_STOR_TRANSPORT_ERROR;
+		return -ENOMEM;
 
 	usb_stor_dbg(us, "addr = 0x%x, len = %d\n", addr, len);
 
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index e282e8174a5d..d054702c8fbe 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -484,16 +484,18 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	return ret;
 }
 
-static int vhost_vsock_stop(struct vhost_vsock *vsock)
+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
 {
 	size_t i;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&vsock->dev.mutex);
 
-	ret = vhost_dev_check_owner(&vsock->dev);
-	if (ret)
-		goto err;
+	if (check_owner) {
+		ret = vhost_dev_check_owner(&vsock->dev);
+		if (ret)
+			goto err;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		struct vhost_virtqueue *vq = &vsock->vqs[i];
@@ -611,7 +613,12 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	 * inefficient.  Room for improvement here. */
 	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
 
-	vhost_vsock_stop(vsock);
+	/* Don't check the owner, because we are in the release path, so we
+	 * need to stop the vsock device in any case.
+	 * vhost_vsock_stop() can not fail in this case, so we don't need to
+	 * check the return code.
+	 */
+	vhost_vsock_stop(vsock, false);
 	vhost_vsock_flush(vsock);
 	vhost_dev_stop(&vsock->dev);
 
@@ -709,7 +716,7 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
 		if (start)
 			return vhost_vsock_start(vsock);
 		else
-			return vhost_vsock_stop(vsock);
+			return vhost_vsock_stop(vsock, true);
 	case VHOST_GET_FEATURES:
 		features = VHOST_VSOCK_FEATURES;
 		if (copy_to_user(argp, &features, sizeof(features)))
diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index fcd2dd670a65..770f77055682 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -1713,9 +1713,9 @@ static int falcon_setcolreg(unsigned int regno, unsigned int red,
 			   ((blue & 0xfc00) >> 8));
 	if (regno < 16) {
 		shifter_tt.color_reg[regno] =
-			(((red & 0xe000) >> 13) | ((red & 0x1000) >> 12) << 8) |
-			(((green & 0xe000) >> 13) | ((green & 0x1000) >> 12) << 4) |
-			((blue & 0xe000) >> 13) | ((blue & 0x1000) >> 12);
+			((((red & 0xe000) >> 13)   | ((red & 0x1000) >> 12)) << 8)   |
+			((((green & 0xe000) >> 13) | ((green & 0x1000) >> 12)) << 4) |
+			   ((blue & 0xe000) >> 13) | ((blue & 0x1000) >> 12);
 		((u32 *)info->pseudo_palette)[regno] = ((red & 0xf800) |
 						       ((green & 0xfc00) >> 5) |
 						       ((blue & 0xf800) >> 11));
@@ -2001,9 +2001,9 @@ static int stste_setcolreg(unsigned int regno, unsigned int red,
 	green >>= 12;
 	if (ATARIHW_PRESENT(EXTD_SHIFTER))
 		shifter_tt.color_reg[regno] =
-			(((red & 0xe) >> 1) | ((red & 1) << 3) << 8) |
-			(((green & 0xe) >> 1) | ((green & 1) << 3) << 4) |
-			((blue & 0xe) >> 1) | ((blue & 1) << 3);
+			((((red & 0xe)   >> 1) | ((red & 1)   << 3)) << 8) |
+			((((green & 0xe) >> 1) | ((green & 1) << 3)) << 4) |
+			  ((blue & 0xe)  >> 1) | ((blue & 1)  << 3);
 	else
 		shifter_tt.color_reg[regno] =
 			((red & 0xe) << 7) |
diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index d992aa5eb3f0..a8f4967de798 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -470,7 +470,7 @@ static int cirrusfb_check_mclk(struct fb_info *info, long freq)
 	return 0;
 }
 
-static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
+static int cirrusfb_check_pixclock(struct fb_var_screeninfo *var,
 				   struct fb_info *info)
 {
 	long freq;
@@ -479,9 +479,7 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
 	unsigned maxclockidx = var->bits_per_pixel >> 3;
 
 	/* convert from ps to kHz */
-	freq = PICOS2KHZ(var->pixclock);
-
-	dev_dbg(info->device, "desired pixclock: %ld kHz\n", freq);
+	freq = PICOS2KHZ(var->pixclock ? : 1);
 
 	maxclock = cirrusfb_board_info[cinfo->btype].maxclock[maxclockidx];
 	cinfo->multiplexing = 0;
@@ -489,11 +487,13 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
 	/* If the frequency is greater than we can support, we might be able
 	 * to use multiplexing for the video mode */
 	if (freq > maxclock) {
-		dev_err(info->device,
-			"Frequency greater than maxclock (%ld kHz)\n",
-			maxclock);
-		return -EINVAL;
+		var->pixclock = KHZ2PICOS(maxclock);
+
+		while ((freq = PICOS2KHZ(var->pixclock)) > maxclock)
+			var->pixclock++;
 	}
+	dev_dbg(info->device, "desired pixclock: %ld kHz\n", freq);
+
 	/*
 	 * Additional constraint: 8bpp uses DAC clock doubling to allow maximum
 	 * pixel clock
diff --git a/drivers/video/fbdev/core/fbcvt.c b/drivers/video/fbdev/core/fbcvt.c
index 55d2bd0ce5c0..64843464c661 100644
--- a/drivers/video/fbdev/core/fbcvt.c
+++ b/drivers/video/fbdev/core/fbcvt.c
@@ -214,9 +214,11 @@ static u32 fb_cvt_aspect_ratio(struct fb_cvt_data *cvt)
 static void fb_cvt_print_name(struct fb_cvt_data *cvt)
 {
 	u32 pixcount, pixcount_mod;
-	int cnt = 255, offset = 0, read = 0;
-	u8 *buf = kzalloc(256, GFP_KERNEL);
+	int size = 256;
+	int off = 0;
+	u8 *buf;
 
+	buf = kzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return;
 
@@ -224,43 +226,30 @@ static void fb_cvt_print_name(struct fb_cvt_data *cvt)
 	pixcount_mod = (cvt->xres * (cvt->yres/cvt->interlace)) % 1000000;
 	pixcount_mod /= 1000;
 
-	read = snprintf(buf+offset, cnt, "fbcvt: %dx%d@%d: CVT Name - ",
-			cvt->xres, cvt->yres, cvt->refresh);
-	offset += read;
-	cnt -= read;
+	off += scnprintf(buf + off, size - off, "fbcvt: %dx%d@%d: CVT Name - ",
+			    cvt->xres, cvt->yres, cvt->refresh);
 
-	if (cvt->status)
-		snprintf(buf+offset, cnt, "Not a CVT standard - %d.%03d Mega "
-			 "Pixel Image\n", pixcount, pixcount_mod);
-	else {
-		if (pixcount) {
-			read = snprintf(buf+offset, cnt, "%d", pixcount);
-			cnt -= read;
-			offset += read;
-		}
+	if (cvt->status) {
+		off += scnprintf(buf + off, size - off,
+				 "Not a CVT standard - %d.%03d Mega Pixel Image\n",
+				 pixcount, pixcount_mod);
+	} else {
+		if (pixcount)
+			off += scnprintf(buf + off, size - off, "%d", pixcount);
 
-		read = snprintf(buf+offset, cnt, ".%03dM", pixcount_mod);
-		cnt -= read;
-		offset += read;
+		off += scnprintf(buf + off, size - off, ".%03dM", pixcount_mod);
 
 		if (cvt->aspect_ratio == 0)
-			read = snprintf(buf+offset, cnt, "3");
+			off += scnprintf(buf + off, size - off, "3");
 		else if (cvt->aspect_ratio == 3)
-			read = snprintf(buf+offset, cnt, "4");
+			off += scnprintf(buf + off, size - off, "4");
 		else if (cvt->aspect_ratio == 1 || cvt->aspect_ratio == 4)
-			read = snprintf(buf+offset, cnt, "9");
+			off += scnprintf(buf + off, size - off, "9");
 		else if (cvt->aspect_ratio == 2)
-			read = snprintf(buf+offset, cnt, "A");
-		else
-			read = 0;
-		cnt -= read;
-		offset += read;
-
-		if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK) {
-			read = snprintf(buf+offset, cnt, "-R");
-			cnt -= read;
-			offset += read;
-		}
+			off += scnprintf(buf + off, size - off, "A");
+
+		if (cvt->flags & FB_CVT_FLAG_REDUCED_BLANK)
+			off += scnprintf(buf + off, size - off, "-R");
 	}
 
 	printk(KERN_INFO "%s\n", buf);
diff --git a/drivers/video/fbdev/nvidia/nv_i2c.c b/drivers/video/fbdev/nvidia/nv_i2c.c
index d7994a173245..0b48965a6420 100644
--- a/drivers/video/fbdev/nvidia/nv_i2c.c
+++ b/drivers/video/fbdev/nvidia/nv_i2c.c
@@ -86,7 +86,7 @@ static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name,
 {
 	int rc;
 
-	strcpy(chan->adapter.name, name);
+	strscpy(chan->adapter.name, name, sizeof(chan->adapter.name));
 	chan->adapter.owner = THIS_MODULE;
 	chan->adapter.class = i2c_class;
 	chan->adapter.algo_data = &chan->algo;
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
index 06e1db34541e..41b0db0cc047 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
@@ -254,6 +254,7 @@ static int dvic_probe_of(struct platform_device *pdev)
 	adapter_node = of_parse_phandle(node, "ddc-i2c-bus", 0);
 	if (adapter_node) {
 		adapter = of_get_i2c_adapter_by_node(adapter_node);
+		of_node_put(adapter_node);
 		if (adapter == NULL) {
 			dev_err(&pdev->dev, "failed to parse ddc-i2c-bus\n");
 			omap_dss_put_device(ddata->in);
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index 8b810696a42b..6a8f0f0fa601 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -413,7 +413,7 @@ static ssize_t dsicm_num_errors_show(struct device *dev,
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", errors);
+	return sysfs_emit(buf, "%d\n", errors);
 }
 
 static ssize_t dsicm_hw_revision_show(struct device *dev,
@@ -444,7 +444,7 @@ static ssize_t dsicm_hw_revision_show(struct device *dev,
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x\n", id1, id2, id3);
+	return sysfs_emit(buf, "%02x.%02x.%02x\n", id1, id2, id3);
 }
 
 static ssize_t dsicm_store_ulps(struct device *dev,
@@ -494,7 +494,7 @@ static ssize_t dsicm_show_ulps(struct device *dev,
 	t = ddata->ulps_enabled;
 	mutex_unlock(&ddata->lock);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", t);
+	return sysfs_emit(buf, "%u\n", t);
 }
 
 static ssize_t dsicm_store_ulps_timeout(struct device *dev,
@@ -541,7 +541,7 @@ static ssize_t dsicm_show_ulps_timeout(struct device *dev,
 	t = ddata->ulps_timeout;
 	mutex_unlock(&ddata->lock);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", t);
+	return sysfs_emit(buf, "%u\n", t);
 }
 
 static DEVICE_ATTR(num_dsi_errors, S_IRUGO, dsicm_num_errors_show, NULL);
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
index 468560a6daae..0a1a82c68680 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
@@ -487,7 +487,7 @@ static ssize_t show_cabc_available_modes(struct device *dev,
 	int i;
 
 	if (!ddata->has_cabc)
-		return snprintf(buf, PAGE_SIZE, "%s\n", cabc_modes[0]);
+		return sysfs_emit(buf, "%s\n", cabc_modes[0]);
 
 	for (i = 0, len = 0;
 	     len < PAGE_SIZE && i < ARRAY_SIZE(cabc_modes); i++)
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 51e628b85f4a..2b8b6b5dc1aa 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -173,7 +173,7 @@ static ssize_t tpo_td043_vmirror_show(struct device *dev,
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ddata->vmirror);
+	return sysfs_emit(buf, "%d\n", ddata->vmirror);
 }
 
 static ssize_t tpo_td043_vmirror_store(struct device *dev,
@@ -203,7 +203,7 @@ static ssize_t tpo_td043_mode_show(struct device *dev,
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ddata->mode);
+	return sysfs_emit(buf, "%d\n", ddata->mode);
 }
 
 static ssize_t tpo_td043_mode_store(struct device *dev,
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 17efcdd4dc99..620f3152213a 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1046,7 +1046,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 	if (count + p > total_size)
 		count = total_size - p;
 
-	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -1058,25 +1058,14 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 	while (count) {
 		c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
 		dst = buffer;
-		for (i = c >> 2; i--;) {
-			*dst = fb_readl(src++);
-			*dst = big_swap(*dst);
+		for (i = (c + 3) >> 2; i--;) {
+			u32 val;
+
+			val = fb_readl(src);
+			*dst = big_swap(val);
+			src++;
 			dst++;
 		}
-		if (c & 3) {
-			u8 *dst8 = (u8 *)dst;
-			u8 __iomem *src8 = (u8 __iomem *)src;
-
-			for (i = c & 3; i--;) {
-				if (i & 1) {
-					*dst8++ = fb_readb(++src8);
-				} else {
-					*dst8++ = fb_readb(--src8);
-					src8 += 2;
-				}
-			}
-			src = (u32 __iomem *)src8;
-		}
 
 		if (copy_to_user(buf, buffer, c)) {
 			err = -EFAULT;
@@ -1129,7 +1118,7 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 		count = total_size - p;
 	}
 
-	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count, GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -1147,24 +1136,11 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 			break;
 		}
 
-		for (i = c >> 2; i--;) {
-			fb_writel(big_swap(*src), dst++);
+		for (i = (c + 3) >> 2; i--;) {
+			fb_writel(big_swap(*src), dst);
+			dst++;
 			src++;
 		}
-		if (c & 3) {
-			u8 *src8 = (u8 *)src;
-			u8 __iomem *dst8 = (u8 __iomem *)dst;
-
-			for (i = c & 3; i--;) {
-				if (i & 1) {
-					fb_writeb(*src8++, ++dst8);
-				} else {
-					fb_writeb(*src8++, --dst8);
-					dst8 += 2;
-				}
-			}
-			dst = (u32 __iomem *)dst8;
-		}
 
 		*ppos += c;
 		buf += c;
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index ec2e7e353685..aa387c5188e7 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1671,6 +1671,7 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	info->par = dev;
 	info->pseudo_palette = dev->pseudo_palette;
 	info->fbops = &ufx_ops;
+	INIT_LIST_HEAD(&info->modelist);
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
@@ -1681,8 +1682,6 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	INIT_DELAYED_WORK(&dev->free_framebuffer_work,
 			  ufx_free_framebuffer_work);
 
-	INIT_LIST_HEAD(&info->modelist);
-
 	retval = ufx_reg_read(dev, 0x3000, &id_rev);
 	check_warn_goto_error(retval, "error %d reading 0x3000 register from device", retval);
 	dev_dbg(dev->gdev, "ID_REV register value 0x%08x", id_rev);
diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 7bd4c27cfb14..b3b17b6adb7e 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -772,12 +772,18 @@ int w100fb_probe(struct platform_device *pdev)
 		fb_dealloc_cmap(&info->cmap);
 		kfree(info->pseudo_palette);
 	}
-	if (remapped_fbuf != NULL)
+	if (remapped_fbuf != NULL) {
 		iounmap(remapped_fbuf);
-	if (remapped_regs != NULL)
+		remapped_fbuf = NULL;
+	}
+	if (remapped_regs != NULL) {
 		iounmap(remapped_regs);
-	if (remapped_base != NULL)
+		remapped_regs = NULL;
+	}
+	if (remapped_base != NULL) {
 		iounmap(remapped_base);
+		remapped_base = NULL;
+	}
 	if (info)
 		framebuffer_release(info);
 	return err;
@@ -802,8 +808,11 @@ static int w100fb_remove(struct platform_device *pdev)
 	fb_dealloc_cmap(&info->cmap);
 
 	iounmap(remapped_base);
+	remapped_base = NULL;
 	iounmap(remapped_regs);
+	remapped_regs = NULL;
 	iounmap(remapped_fbuf);
+	remapped_fbuf = NULL;
 
 	framebuffer_release(info);
 
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 82611f197b0a..7d0e09867bc7 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -589,16 +589,20 @@ static ssize_t w1_seq_show(struct device *device,
 		if (sl->reg_num.id == reg_num->id)
 			seq = i;
 
+		if (w1_reset_bus(sl->master))
+			goto error;
+
+		/* Put the device into chain DONE state */
+		w1_write_8(sl->master, W1_MATCH_ROM);
+		w1_write_block(sl->master, (u8 *)&rn, 8);
 		w1_write_8(sl->master, W1_42_CHAIN);
 		w1_write_8(sl->master, W1_42_CHAIN_DONE);
 		w1_write_8(sl->master, W1_42_CHAIN_DONE_INV);
-		w1_read_block(sl->master, &ack, sizeof(ack));
 
 		/* check for acknowledgment */
 		ack = w1_read_8(sl->master);
 		if (ack != W1_42_SUCCESS_CONFIRM_BYTE)
 			goto error;
-
 	}
 
 	/* Exit from CHAIN state */
diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 7a47c4c9fb1b..24f8900eccad 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -166,20 +166,14 @@ static int add_grefs(struct ioctl_gntalloc_alloc_gref *op,
 		__del_gref(gref);
 	}
 
-	/* It's possible for the target domain to map the just-allocated grant
-	 * references by blindly guessing their IDs; if this is done, then
-	 * __del_gref will leave them in the queue_gref list. They need to be
-	 * added to the global list so that we can free them when they are no
-	 * longer referenced.
-	 */
-	if (unlikely(!list_empty(&queue_gref)))
-		list_splice_tail(&queue_gref, &gref_list);
 	mutex_unlock(&gref_mutex);
 	return rc;
 }
 
 static void __del_gref(struct gntalloc_gref *gref)
 {
+	unsigned long addr;
+
 	if (gref->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
 		uint8_t *tmp = kmap(gref->page);
 		tmp[gref->notify.pgoff] = 0;
@@ -193,21 +187,16 @@ static void __del_gref(struct gntalloc_gref *gref)
 	gref->notify.flags = 0;
 
 	if (gref->gref_id) {
-		if (gnttab_query_foreign_access(gref->gref_id))
-			return;
-
-		if (!gnttab_end_foreign_access_ref(gref->gref_id, 0))
-			return;
-
-		gnttab_free_grant_reference(gref->gref_id);
+		if (gref->page) {
+			addr = (unsigned long)page_to_virt(gref->page);
+			gnttab_end_foreign_access(gref->gref_id, 0, addr);
+		} else
+			gnttab_free_grant_reference(gref->gref_id);
 	}
 
 	gref_size--;
 	list_del(&gref->next_gref);
 
-	if (gref->page)
-		__free_page(gref->page);
-
 	kfree(gref);
 }
 
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 775d4195966c..02754b4923e9 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -114,12 +114,9 @@ struct gnttab_ops {
 	 */
 	unsigned long (*end_foreign_transfer_ref)(grant_ref_t ref);
 	/*
-	 * Query the status of a grant entry. Ref parameter is reference of
-	 * queried grant entry, return value is the status of queried entry.
-	 * Detailed status(writing/reading) can be gotten from the return value
-	 * by bit operations.
+	 * Read the frame number related to a given grant reference.
 	 */
-	int (*query_foreign_access)(grant_ref_t ref);
+	unsigned long (*read_frame)(grant_ref_t ref);
 };
 
 struct unmap_refs_callback_data {
@@ -254,17 +251,6 @@ int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
 }
 EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);
 
-static int gnttab_query_foreign_access_v1(grant_ref_t ref)
-{
-	return gnttab_shared.v1[ref].flags & (GTF_reading|GTF_writing);
-}
-
-int gnttab_query_foreign_access(grant_ref_t ref)
-{
-	return gnttab_interface->query_foreign_access(ref);
-}
-EXPORT_SYMBOL_GPL(gnttab_query_foreign_access);
-
 static int gnttab_end_foreign_access_ref_v1(grant_ref_t ref, int readonly)
 {
 	u16 flags, nflags;
@@ -295,6 +281,11 @@ int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly)
 }
 EXPORT_SYMBOL_GPL(gnttab_end_foreign_access_ref);
 
+static unsigned long gnttab_read_frame_v1(grant_ref_t ref)
+{
+	return gnttab_shared.v1[ref].frame;
+}
+
 struct deferred_entry {
 	struct list_head list;
 	grant_ref_t ref;
@@ -324,12 +315,9 @@ static void gnttab_handle_deferred(unsigned long unused)
 		spin_unlock_irqrestore(&gnttab_list_lock, flags);
 		if (_gnttab_end_foreign_access_ref(entry->ref, entry->ro)) {
 			put_free_entry(entry->ref);
-			if (entry->page) {
-				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
-					 entry->ref, page_to_pfn(entry->page));
-				put_page(entry->page);
-			} else
-				pr_info("freeing g.e. %#x\n", entry->ref);
+			pr_debug("freeing g.e. %#x (pfn %#lx)\n",
+				 entry->ref, page_to_pfn(entry->page));
+			put_page(entry->page);
 			kfree(entry);
 			entry = NULL;
 		} else {
@@ -354,9 +342,18 @@ static void gnttab_handle_deferred(unsigned long unused)
 static void gnttab_add_deferred(grant_ref_t ref, bool readonly,
 				struct page *page)
 {
-	struct deferred_entry *entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+	struct deferred_entry *entry;
+	gfp_t gfp = (in_atomic() || irqs_disabled()) ? GFP_ATOMIC : GFP_KERNEL;
 	const char *what = KERN_WARNING "leaking";
 
+	entry = kmalloc(sizeof(*entry), gfp);
+	if (!page) {
+		unsigned long gfn = gnttab_interface->read_frame(ref);
+
+		page = pfn_to_page(gfn_to_pfn(gfn));
+		get_page(page);
+	}
+
 	if (entry) {
 		unsigned long flags;
 
@@ -377,11 +374,21 @@ static void gnttab_add_deferred(grant_ref_t ref, bool readonly,
 	       what, ref, page ? page_to_pfn(page) : -1);
 }
 
+int gnttab_try_end_foreign_access(grant_ref_t ref)
+{
+	int ret = _gnttab_end_foreign_access_ref(ref, 0);
+
+	if (ret)
+		put_free_entry(ref);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gnttab_try_end_foreign_access);
+
 void gnttab_end_foreign_access(grant_ref_t ref, int readonly,
 			       unsigned long page)
 {
-	if (gnttab_end_foreign_access_ref(ref, readonly)) {
-		put_free_entry(ref);
+	if (gnttab_try_end_foreign_access(ref)) {
 		if (page != 0)
 			put_page(virt_to_page(page));
 	} else
@@ -1018,7 +1025,7 @@ static const struct gnttab_ops gnttab_v1_ops = {
 	.update_entry			= gnttab_update_entry_v1,
 	.end_foreign_access_ref		= gnttab_end_foreign_access_ref_v1,
 	.end_foreign_transfer_ref	= gnttab_end_foreign_transfer_ref_v1,
-	.query_foreign_access		= gnttab_query_foreign_access_v1,
+	.read_frame			= gnttab_read_frame_v1,
 };
 
 static void gnttab_request_version(void)
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 8bbd887ca422..5ee38e939165 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -387,7 +387,14 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 		      unsigned int nr_pages, grant_ref_t *grefs)
 {
 	int err;
-	int i, j;
+	unsigned int i;
+	grant_ref_t gref_head;
+
+	err = gnttab_alloc_grant_references(nr_pages, &gref_head);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "granting access to ring page");
+		return err;
+	}
 
 	for (i = 0; i < nr_pages; i++) {
 		unsigned long gfn;
@@ -397,23 +404,14 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 		else
 			gfn = virt_to_gfn(vaddr);
 
-		err = gnttab_grant_foreign_access(dev->otherend_id, gfn, 0);
-		if (err < 0) {
-			xenbus_dev_fatal(dev, err,
-					 "granting access to ring page");
-			goto fail;
-		}
-		grefs[i] = err;
+		grefs[i] = gnttab_claim_grant_reference(&gref_head);
+		gnttab_grant_foreign_access_ref(grefs[i], dev->otherend_id,
+						gfn, 0);
 
 		vaddr = vaddr + XEN_PAGE_SIZE;
 	}
 
 	return 0;
-
-fail:
-	for (j = 0; j < i; j++)
-		gnttab_end_foreign_access_ref(grefs[j], 0);
-	return err;
 }
 EXPORT_SYMBOL_GPL(xenbus_grant_ring);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b5bff1e760a3..8ded1d894100 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8457,6 +8457,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 out_free_delayed:
 	btrfs_free_delayed_extent_op(extent_op);
 out_free_buf:
+	btrfs_tree_unlock(buf);
 	free_extent_buffer(buf);
 out_free_reserved:
 	btrfs_free_reserved_extent(root, ins.objectid, ins.offset, 0);
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 375ccd209206..b85c283ad08b 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -746,6 +746,7 @@ cifs_do_mount(struct file_system_type *fs_type,
 
 out_super:
 	deactivate_locked_super(sb);
+	return root;
 out:
 	cifs_cleanup_volume_info(volume_info);
 	return root;
@@ -765,7 +766,7 @@ cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t rc;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (iocb->ki_filp->f_flags & O_DIRECT)
+	if (iocb->ki_flags & IOCB_DIRECT)
 		return cifs_user_readv(iocb, iter);
 
 	rc = cifs_revalidate_mapping(inode);
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 38d26cbcad07..0c49e2aa7ea4 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -119,6 +119,9 @@ parse_mf_symlink(const u8 *buf, unsigned int buf_len, unsigned int *_link_len,
 	if (rc != 1)
 		return -EINVAL;
 
+	if (link_len > CIFS_MF_SYMLINK_LINK_MAXLEN)
+		return -EINVAL;
+
 	rc = symlink_hash(link_len, link_str, md5_hash);
 	if (rc) {
 		cifs_dbg(FYI, "%s: MD5 hash failure: %d\n", __func__, rc);
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index c875f246cb0e..ccb49caed502 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -50,6 +50,14 @@ DECLARE_RWSEM(configfs_rename_sem);
  */
 DEFINE_SPINLOCK(configfs_dirent_lock);
 
+/*
+ * All of link_obj/unlink_obj/link_group/unlink_group require that
+ * subsys->su_mutex is held.
+ * But parent configfs_subsystem is NULL when config_item is root.
+ * Use this mutex when config_item is root.
+ */
+static DEFINE_MUTEX(configfs_subsystem_mutex);
+
 static void configfs_d_iput(struct dentry * dentry,
 			    struct inode * inode)
 {
@@ -1937,7 +1945,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
 
 	sd = root->d_fsdata;
+	mutex_lock(&configfs_subsystem_mutex);
 	link_group(to_config_group(sd->s_element), group);
+	mutex_unlock(&configfs_subsystem_mutex);
 
 	inode_lock_nested(d_inode(root), I_MUTEX_PARENT);
 
@@ -1962,7 +1972,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	inode_unlock(d_inode(root));
 
 	if (err) {
+		mutex_lock(&configfs_subsystem_mutex);
 		unlink_group(group);
+		mutex_unlock(&configfs_subsystem_mutex);
 		configfs_release_fs();
 	}
 	put_fragment(frag);
@@ -2008,7 +2020,9 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 
 	dput(dentry);
 
+	mutex_lock(&configfs_subsystem_mutex);
 	unlink_group(group);
+	mutex_unlock(&configfs_subsystem_mutex);
 	configfs_release_fs();
 }
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 186912c9bf56..5ca1f73958b0 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -743,8 +743,12 @@ static loff_t ext2_max_size(int bits)
 	res += 1LL << (bits-2);
 	res += 1LL << (2*(bits-2));
 	res += 1LL << (3*(bits-2));
+	/* Compute how many metadata blocks are needed */
+	meta_blocks = 1;
+	meta_blocks += 1 + ppb;
+	meta_blocks += 1 + ppb + ppb * ppb;
 	/* Does block tree limit file size? */
-	if (res < upper_limit)
+	if (res + meta_blocks <= upper_limit)
 		goto check_lfs;
 
 	res = upper_limit;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 79c067f74253..754b33828853 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2048,6 +2048,15 @@ static int ext4_writepage(struct page *page,
 	else
 		len = PAGE_SIZE;
 
+	/* Should never happen but for bugs in other kernel subsystems */
+	if (!page_has_buffers(page)) {
+		ext4_warning_inode(inode,
+		   "page %lu does not have buffers attached", page->index);
+		ClearPageDirty(page);
+		unlock_page(page);
+		return 0;
+	}
+
 	page_bufs = page_buffers(page);
 	/*
 	 * We cannot do block allocation or other extent handling in this
@@ -2608,6 +2617,22 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			wait_on_page_writeback(page);
 			BUG_ON(PageWriteback(page));
 
+			/*
+			 * Should never happen but for buggy code in
+			 * other subsystems that call
+			 * set_page_dirty() without properly warning
+			 * the file system first.  See [1] for more
+			 * information.
+			 *
+			 * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
+			 */
+			if (!page_has_buffers(page)) {
+				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
+				ClearPageDirty(page);
+				unlock_page(page);
+				continue;
+			}
+
 			if (mpd->map.m_len == 0)
 				mpd->first_page = page->index;
 			mpd->next_page = page->index + 1;
@@ -3955,7 +3980,8 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t first_block, stop_block;
 	struct address_space *mapping = inode->i_mapping;
-	loff_t first_block_offset, last_block_offset;
+	loff_t first_block_offset, last_block_offset, max_length;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	unsigned int credits;
 	int ret = 0;
@@ -4001,6 +4027,14 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 		   offset;
 	}
 
+	/*
+	 * For punch hole the length + offset needs to be within one block
+	 * before last range. Adjust the length if it goes beyond that limit.
+	 */
+	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
+	if (offset + length > max_length)
+		length = max_length - offset;
+
 	if (offset & (sb->s_blocksize - 1) ||
 	    (offset + length) & (sb->s_blocksize - 1)) {
 		/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e17a6396bde6..c50ba683a570 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3241,9 +3241,11 @@ static int count_overhead(struct super_block *sb, ext4_group_t grp,
 	ext4_fsblk_t		first_block, last_block, b;
 	ext4_group_t		i, ngroups = ext4_get_groups_count(sb);
 	int			s, j, count = 0;
+	int			has_super = ext4_bg_has_super(sb, grp);
 
 	if (!ext4_has_feature_bigalloc(sb))
-		return (ext4_bg_has_super(sb, grp) + ext4_bg_num_gdb(sb, grp) +
+		return (has_super + ext4_bg_num_gdb(sb, grp) +
+			(has_super ? le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) : 0) +
 			sbi->s_itb_per_group + 2);
 
 	first_block = le32_to_cpu(sbi->s_es->s_first_data_block) +
@@ -4162,9 +4164,18 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 * Get the # of file system overhead blocks from the
 	 * superblock if present.
 	 */
-	if (es->s_overhead_clusters)
-		sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
-	else {
+	sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
+	/* ignore the precalculated value if it is ridiculous */
+	if (sbi->s_overhead > ext4_blocks_count(es))
+		sbi->s_overhead = 0;
+	/*
+	 * If the bigalloc feature is not enabled recalculating the
+	 * overhead doesn't take long, so we might as well just redo
+	 * it to make sure we are using the correct value.
+	 */
+	if (!ext4_has_feature_bigalloc(sb))
+		sbi->s_overhead = 0;
+	if (sbi->s_overhead == 0) {
 		err = ext4_calculate_overhead(sb);
 		if (err)
 			goto failed_mount_wq;
diff --git a/fs/file.c b/fs/file.c
index 0e31a66207e8..be0792c0a231 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -692,28 +692,69 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+static inline struct file *__fget_files_rcu(struct files_struct *files,
+		unsigned int fd, fmode_t mask, unsigned int refs)
 {
-	struct files_struct *files = current->files;
-	struct file *file;
+	for (;;) {
+		struct file *file;
+		struct fdtable *fdt = rcu_dereference_raw(files->fdt);
+		struct file __rcu **fdentry;
 
-	rcu_read_lock();
-loop:
-	file = fcheck_files(files, fd);
-	if (file) {
-		/* File object ref couldn't be taken.
-		 * dup2() atomicity guarantee is the reason
-		 * we loop to catch the new file (or NULL pointer)
+		if (unlikely(fd >= fdt->max_fds))
+			return NULL;
+
+		fdentry = fdt->fd + array_index_nospec(fd, fdt->max_fds);
+		file = rcu_dereference_raw(*fdentry);
+		if (unlikely(!file))
+			return NULL;
+
+		if (unlikely(file->f_mode & mask))
+			return NULL;
+
+		/*
+		 * Ok, we have a file pointer. However, because we do
+		 * this all locklessly under RCU, we may be racing with
+		 * that file being closed.
+		 *
+		 * Such a race can take two forms:
+		 *
+		 *  (a) the file ref already went down to zero,
+		 *      and get_file_rcu_many() fails. Just try
+		 *      again:
+		 */
+		if (unlikely(!get_file_rcu_many(file, refs)))
+			continue;
+
+		/*
+		 *  (b) the file table entry has changed under us.
+		 *       Note that we don't need to re-check the 'fdt->fd'
+		 *       pointer having changed, because it always goes
+		 *       hand-in-hand with 'fdt'.
+		 *
+		 * If so, we need to put our refs and try again.
 		 */
-		if (file->f_mode & mask)
-			file = NULL;
-		else if (!get_file_rcu_many(file, refs))
-			goto loop;
-		else if (__fcheck_files(files, fd) != file) {
+		if (unlikely(rcu_dereference_raw(files->fdt) != fdt) ||
+		    unlikely(rcu_dereference_raw(*fdentry) != file)) {
 			fput_many(file, refs);
-			goto loop;
+			continue;
 		}
+
+		/*
+		 * Ok, we have a ref to the file, and checked that it
+		 * still exists.
+		 */
+		return file;
 	}
+}
+
+
+static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
+{
+	struct files_struct *files = current->files;
+	struct file *file;
+
+	rcu_read_lock();
+	file = __fget_files_rcu(files, fd, mask, refs);
 	rcu_read_unlock();
 
 	return file;
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 56a94535c246..9f83a4c602f9 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -917,15 +917,15 @@ static int read_rindex_entry(struct gfs2_inode *ip)
 	rgd->rd_bitbytes = be32_to_cpu(buf.ri_bitbytes);
 	spin_lock_init(&rgd->rd_rsspin);
 
-	error = compute_bitstructs(rgd);
-	if (error)
-		goto fail;
-
 	error = gfs2_glock_get(sdp, rgd->rd_addr,
 			       &gfs2_rgrp_glops, CREATE, &rgd->rd_gl);
 	if (error)
 		goto fail;
 
+	error = compute_bitstructs(rgd);
+	if (error)
+		goto fail_glock;
+
 	rgd->rd_rgl = (struct gfs2_rgrp_lvb *)rgd->rd_gl->gl_lksb.sb_lvbptr;
 	rgd->rd_flags &= ~(GFS2_RDF_UPTODATE | GFS2_RDF_PREFERRED);
 	if (rgd->rd_data > sdp->sd_max_rg_data)
@@ -942,6 +942,7 @@ static int read_rindex_entry(struct gfs2_inode *ip)
 	}
 
 	error = 0; /* someone else read in the rgrp; free it and ignore it */
+fail_glock:
 	gfs2_glock_put(rgd->rd_gl);
 
 fail:
@@ -1390,7 +1391,8 @@ int gfs2_fitrim(struct file *filp, void __user *argp)
 
 	start = r.start >> bs_shift;
 	end = start + (r.len >> bs_shift);
-	minlen = max_t(u64, r.minlen,
+	minlen = max_t(u64, r.minlen, sdp->sd_sb.sb_bsize);
+	minlen = max_t(u64, minlen,
 		       q->limits.discard_granularity) >> bs_shift;
 
 	if (end <= start || minlen > sdp->sd_max_rg_data)
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index b288c8ae1236..837cd55fd4c5 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -415,13 +415,15 @@ int jffs2_do_mount_fs(struct jffs2_sb_info *c)
 		jffs2_free_ino_caches(c);
 		jffs2_free_raw_node_refs(c);
 		ret = -EIO;
-		goto out_free;
+		goto out_sum_exit;
 	}
 
 	jffs2_calc_trigger_levels(c);
 
 	return 0;
 
+ out_sum_exit:
+	jffs2_sum_exit(c);
  out_free:
 	kvfree(c->blocks);
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index c9c47d03a690..d3c9e4c82e57 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -596,8 +596,8 @@ int jffs2_do_fill_super(struct super_block *sb, void *data, int silent)
 	jffs2_free_ino_caches(c);
 	jffs2_free_raw_node_refs(c);
 	kvfree(c->blocks);
- out_inohash:
 	jffs2_clear_xattr_subsystem(c);
+ out_inohash:
 	kfree(c->inocache_list);
  out_wbuf:
 	jffs2_flash_cleanup(c);
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 08813789fcf0..664384dac6e5 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -136,7 +136,7 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 		if (!s) {
 			JFFS2_WARNING("Can't allocate memory for summary\n");
 			ret = -ENOMEM;
-			goto out;
+			goto out_buf;
 		}
 	}
 
@@ -274,13 +274,15 @@ int jffs2_scan_medium(struct jffs2_sb_info *c)
 	}
 	ret = 0;
  out:
+	jffs2_sum_reset_collected(s);
+	kfree(s);
+ out_buf:
 	if (buf_size)
 		kfree(flashbuf);
 #ifndef __ECOS
 	else
 		mtd_unpoint(c->mtd, 0, c->mtd->size);
 #endif
-	kfree(s);
 	return ret;
 }
 
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 87b41edc800d..68779cc3609a 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -156,12 +156,13 @@ void jfs_evict_inode(struct inode *inode)
 		dquot_initialize(inode);
 
 		if (JFS_IP(inode)->fileset == FILESYSTEM_I) {
+			struct inode *ipimap = JFS_SBI(inode->i_sb)->ipimap;
 			truncate_inode_pages_final(&inode->i_data);
 
 			if (test_cflag(COMMIT_Freewmap, inode))
 				jfs_free_zero_link(inode);
 
-			if (JFS_SBI(inode->i_sb)->ipimap)
+			if (ipimap && JFS_IP(ipimap)->i_imap)
 				diFree(inode);
 
 			/*
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 9ff510a489cb..6dac48e29d28 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -161,6 +161,7 @@ static const s8 budtab[256] = {
  *	0	- success
  *	-ENOMEM	- insufficient memory
  *	-EIO	- i/o error
+ *	-EINVAL - wrong bmap data
  */
 int dbMount(struct inode *ipbmap)
 {
@@ -192,6 +193,12 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
+	if (!bmp->db_numag) {
+		release_metapage(mp);
+		kfree(bmp);
+		return -EINVAL;
+	}
+
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 67903eeb2ca4..00e58a42e637 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -319,10 +319,6 @@ __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
 	n = ntohl(*p++);
 	if (n <= 0)
 		goto out;
-	if (n > ULONG_MAX / sizeof(*args->devs)) {
-		status = htonl(NFS4ERR_BADXDR);
-		goto out;
-	}
 
 	args->devs = kmalloc_array(n, sizeof(*args->devs), GFP_KERNEL);
 	if (!args->devs) {
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 536009e50387..fd5bb6f7f5f7 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -207,7 +207,7 @@ nfsd_proc_write(struct svc_rqst *rqstp, struct nfsd_writeargs *argp,
 	int	stable = 1;
 	unsigned long cnt = argp->len;
 
-	dprintk("nfsd: WRITE    %s %d bytes at %d\n",
+	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
 		argp->len, argp->offset);
 
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 4f0481d63804..8c78b56a9350 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -32,7 +32,7 @@ struct nfsd_readargs {
 struct nfsd_writeargs {
 	svc_fh			fh;
 	__u32			offset;
-	int			len;
+	__u32			len;
 	int			vlen;
 };
 
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 8cd134750ebb..4150b3633f77 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1915,6 +1915,10 @@ int ntfs_read_inode_mount(struct inode *vi)
 		}
 		/* Now allocate memory for the attribute list. */
 		ni->attr_list_size = (u32)ntfs_attr_size(a);
+		if (!ni->attr_list_size) {
+			ntfs_error(sb, "Attr_list_size is zero");
+			goto put_err_out;
+		}
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
 		if (!ni->attr_list) {
 			ntfs_error(sb, "Not enough memory to allocate buffer "
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 300cdbdc8494..c41e7f51150f 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -565,8 +565,7 @@ int sysfs_emit(char *buf, const char *fmt, ...)
 	va_list args;
 	int len;
 
-	if (WARN(!buf || offset_in_page(buf),
-		 "invalid sysfs_emit: buf:%p\n", buf))
+	if (WARN(!buf, "invalid sysfs_emit: buf:%p\n", buf))
 		return 0;
 
 	va_start(args, fmt);
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e00594ad9972..b56d1cfe429e 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -265,7 +265,6 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 			if (!gid_valid(gid))
 				return -EINVAL;
 			opts->gid = gid;
-			set_gid(tracefs_mount->mnt_root, gid);
 			break;
 		case Opt_mode:
 			if (match_octal(&args[0], &option))
@@ -292,7 +291,9 @@ static int tracefs_apply_options(struct super_block *sb)
 	inode->i_mode |= opts->mode;
 
 	inode->i_uid = opts->uid;
-	inode->i_gid = opts->gid;
+
+	/* Set all the group ids to the mount option */
+	set_gid(sb->s_root, opts->gid);
 
 	return 0;
 }
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 56eed54633cf..89cebe1807d2 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -376,6 +376,8 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 	make_bad_inode(inode);
 	if (!instantiated)
 		iput(inode);
+	else if (whiteout)
+		iput(*whiteout);
 out_budg:
 	ubifs_release_budget(c, &req);
 	if (!instantiated)
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 3c7b29de0ca7..b5320eedec3b 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -105,7 +105,7 @@ static int setflags(struct inode *inode, int flags)
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
-					.dirtied_ino_d = ui->data_len };
+			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
 
 	err = ubifs_budget_space(c, &req);
 	if (err)
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 18863d56273c..040266891414 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -85,10 +85,33 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 0x7fff)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_3					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x3fff)
+
+#define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED	1
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
 #include <linux/types.h>
+
+enum arm_smccc_conduit {
+	SMCCC_CONDUIT_NONE,
+	SMCCC_CONDUIT_SMC,
+	SMCCC_CONDUIT_HVC,
+};
+
+/**
+ * arm_smccc_1_1_get_conduit()
+ *
+ * Returns the conduit to be used for SMCCCv1.1 or later.
+ *
+ * When SMCCCv1.1 is not present, returns SMCCC_CONDUIT_NONE.
+ */
+enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
@@ -311,5 +334,63 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 #define SMCCC_RET_NOT_SUPPORTED			-1
 #define SMCCC_RET_NOT_REQUIRED			-2
 
+/*
+ * Like arm_smccc_1_1* but always returns SMCCC_RET_NOT_SUPPORTED.
+ * Used when the SMCCC conduit is not defined. The empty asm statement
+ * avoids compiler warnings about unused variables.
+ */
+#define __fail_smccc_1_1(...)						\
+	do {								\
+		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
+		asm ("" __constraints(__count_args(__VA_ARGS__)));	\
+		if (___res)						\
+			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
+	} while (0)
+
+/*
+ * arm_smccc_1_1_invoke() - make an SMCCC v1.1 compliant call
+ *
+ * This is a variadic macro taking one to eight source arguments, and
+ * an optional return structure.
+ *
+ * @a0-a7: arguments passed in registers 0 to 7
+ * @res: result values from registers 0 to 3
+ *
+ * This macro will make either an HVC call or an SMC call depending on the
+ * current SMCCC conduit. If no valid conduit is available then -1
+ * (SMCCC_RET_NOT_SUPPORTED) is returned in @res.a0 (if supplied).
+ *
+ * The return value also provides the conduit that was used.
+ */
+#define arm_smccc_1_1_invoke(...) ({					\
+		int method = arm_smccc_1_1_get_conduit();		\
+		switch (method) {					\
+		case SMCCC_CONDUIT_HVC:					\
+			arm_smccc_1_1_hvc(__VA_ARGS__);			\
+			break;						\
+		case SMCCC_CONDUIT_SMC:					\
+			arm_smccc_1_1_smc(__VA_ARGS__);			\
+			break;						\
+		default:						\
+			__fail_smccc_1_1(__VA_ARGS__);			\
+			method = SMCCC_CONDUIT_NONE;			\
+			break;						\
+		}							\
+		method;							\
+	})
+
+/* Paravirtualised time calls (defined by ARM DEN0057A) */
+#define ARM_SMCCC_HV_PV_TIME_FEATURES				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x20)
+
+#define ARM_SMCCC_HV_PV_TIME_ST					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x21)
+
 #endif /*__ASSEMBLY__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index caba9253957f..555bf0c5946d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -50,6 +50,14 @@ struct pr_ops;
 
 typedef void (rq_end_io_fn)(struct request *, int);
 
+static inline int blk_validate_block_size(unsigned int bsize)
+{
+	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+		return -EINVAL;
+
+	return 0;
+}
+
 #define BLK_RL_SYNCFULL		(1U << 0)
 #define BLK_RL_ASYNCFULL	(1U << 1)
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7995940d4187..fe520d40597f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -295,6 +295,11 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 
 /* verify correctness of eBPF program */
 int bpf_check(struct bpf_prog **fp, union bpf_attr *attr);
+
+static inline bool unprivileged_ebpf_enabled(void)
+{
+	return !sysctl_unprivileged_bpf_disabled;
+}
 #else
 static inline void bpf_register_prog_type(struct bpf_prog_type_list *tl)
 {
@@ -322,6 +327,12 @@ static inline struct bpf_prog *bpf_prog_inc(struct bpf_prog *prog)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
+
+static inline bool unprivileged_ebpf_enabled(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_BPF_SYSCALL */
 
 /* verifier prototypes for helper functions called from eBPF programs */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d830eddacdc6..1c1ca4168516 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -107,7 +107,7 @@
 #define __weak		__attribute__((weak))
 #define __alias(symbol)	__attribute__((alias(#symbol)))
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 #define __noretpoline __attribute__((indirect_branch("keep")))
 #endif
 
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 6fec9e81bd70..1979298fdca9 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -125,7 +125,7 @@ static inline bool is_multicast_ether_addr(const u8 *addr)
 #endif
 }
 
-static inline bool is_multicast_ether_addr_64bits(const u8 addr[6+2])
+static inline bool is_multicast_ether_addr_64bits(const u8 *addr)
 {
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
 #ifdef __BIG_ENDIAN
@@ -339,8 +339,7 @@ static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
  * Please note that alignment of addr1 & addr2 are only guaranteed to be 16 bits.
  */
 
-static inline bool ether_addr_equal_64bits(const u8 addr1[6+2],
-					   const u8 addr2[6+2])
+static inline bool ether_addr_equal_64bits(const u8 *addr1, const u8 *addr2)
 {
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
 	u64 fold = (*(const u64 *)addr1) ^ (*(const u64 *)addr2);
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6dd276227217..5747174e0326 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -7327,8 +7327,8 @@ struct mlx5_ifc_bufferx_reg_bits {
 	u8         reserved_at_0[0x6];
 	u8         lossy[0x1];
 	u8         epsb[0x1];
-	u8         reserved_at_8[0xc];
-	u8         size[0xc];
+	u8         reserved_at_8[0x8];
+	u8         size[0x10];
 
 	u8         xoff_threshold[0x10];
 	u8         xon_threshold[0x10];
diff --git a/include/linux/module.h b/include/linux/module.h
index 88a79e17fad1..bf1512a8b8d9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -797,7 +797,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 extern bool retpoline_module_ok(bool has_retpoline);
 #else
 static inline bool retpoline_module_ok(bool has_retpoline)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index de7bfe2fabea..e051037887f0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3466,7 +3466,8 @@ void netdev_run_todo(void);
  */
 static inline void dev_put(struct net_device *dev)
 {
-	this_cpu_dec(*dev->pcpu_refcnt);
+	if (dev)
+		this_cpu_dec(*dev->pcpu_refcnt);
 }
 
 /**
@@ -3477,7 +3478,8 @@ static inline void dev_put(struct net_device *dev)
  */
 static inline void dev_hold(struct net_device *dev)
 {
-	this_cpu_inc(*dev->pcpu_refcnt);
+	if (dev)
+		this_cpu_inc(*dev->pcpu_refcnt);
 }
 
 /* Carrier loss detection, dial on demand. The functions netif_carrier_on
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 5c30891e84e5..5c59b6386dff 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -143,6 +143,11 @@ static inline void csum_replace2(__sum16 *sum, __be16 old, __be16 new)
 	*sum = ~csum16_add(csum16_sub(~(*sum), old), new);
 }
 
+static inline void csum_replace(__wsum *csum, __wsum old, __wsum new)
+{
+	*csum = csum_add(csum_sub(*csum, old), new);
+}
+
 struct sk_buff;
 void inet_proto_csum_replace4(__sum16 *sum, struct sk_buff *skb,
 			      __be32 from, __be32 to, bool pseudohdr);
diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 2280cfe86c56..faa535defddd 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -31,7 +31,7 @@ void nf_register_queue_handler(struct net *net, const struct nf_queue_handler *q
 void nf_unregister_queue_handler(struct net *net);
 void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict);
 
-void nf_queue_entry_get_refs(struct nf_queue_entry *entry);
+bool nf_queue_entry_get_refs(struct nf_queue_entry *entry);
 void nf_queue_entry_release_refs(struct nf_queue_entry *entry);
 
 static inline void init_hashrandom(u32 *jhash_initval)
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index b2a405c93a34..7415a9876987 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1595,13 +1595,16 @@ int xfrm_policy_walk(struct net *net, struct xfrm_policy_walk *walk,
 		     void *);
 void xfrm_policy_walk_done(struct xfrm_policy_walk *walk, struct net *net);
 int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl);
-struct xfrm_policy *xfrm_policy_bysel_ctx(struct net *net, u32 mark,
+struct xfrm_policy *xfrm_policy_bysel_ctx(struct net *net,
+					  const struct xfrm_mark *mark,
 					  u8 type, int dir,
 					  struct xfrm_selector *sel,
 					  struct xfrm_sec_ctx *ctx, int delete,
 					  int *err);
-struct xfrm_policy *xfrm_policy_byid(struct net *net, u32 mark, u8, int dir,
-				     u32 id, int delete, int *err);
+struct xfrm_policy *xfrm_policy_byid(struct net *net,
+				     const struct xfrm_mark *mark,
+				     u8 type, int dir, u32 id, int delete,
+				     int *err);
 int xfrm_policy_flush(struct net *net, u8 type, bool task_valid);
 void xfrm_policy_hash_rebuild(struct net *net);
 u32 xfrm_get_acqseq(void);
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index b584868e1b26..fd7cacbfc8c2 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -277,7 +277,8 @@
 #define KEY_PAUSECD		201
 #define KEY_PROG3		202
 #define KEY_PROG4		203
-#define KEY_DASHBOARD		204	/* AL Dashboard */
+#define KEY_ALL_APPLICATIONS	204	/* AC Desktop Show All Applications */
+#define KEY_DASHBOARD		KEY_ALL_APPLICATIONS
 #define KEY_SUSPEND		205
 #define KEY_CLOSE		206	/* AC Close */
 #define KEY_PLAY		207
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index f9d8aac170fb..c51ae64b6dcb 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -97,17 +97,32 @@ int gnttab_end_foreign_access_ref(grant_ref_t ref, int readonly);
  * access has been ended, free the given page too.  Access will be ended
  * immediately iff the grant entry is not in use, otherwise it will happen
  * some time later.  page may be 0, in which case no freeing will occur.
+ * Note that the granted page might still be accessed (read or write) by the
+ * other side after gnttab_end_foreign_access() returns, so even if page was
+ * specified as 0 it is not allowed to just reuse the page for other
+ * purposes immediately. gnttab_end_foreign_access() will take an additional
+ * reference to the granted page in this case, which is dropped only after
+ * the grant is no longer in use.
+ * This requires that multi page allocations for areas subject to
+ * gnttab_end_foreign_access() are done via alloc_pages_exact() (and freeing
+ * via free_pages_exact()) in order to avoid high order pages.
  */
 void gnttab_end_foreign_access(grant_ref_t ref, int readonly,
 			       unsigned long page);
 
+/*
+ * End access through the given grant reference, iff the grant entry is
+ * no longer in use.  In case of success ending foreign access, the
+ * grant reference is deallocated.
+ * Return 1 if the grant entry was freed, 0 if it is still in use.
+ */
+int gnttab_try_end_foreign_access(grant_ref_t ref);
+
 int gnttab_grant_foreign_transfer(domid_t domid, unsigned long pfn);
 
 unsigned long gnttab_end_foreign_transfer_ref(grant_ref_t ref);
 unsigned long gnttab_end_foreign_transfer(grant_ref_t ref);
 
-int gnttab_query_foreign_access(grant_ref_t ref);
-
 /*
  * operations on reserved batches of grant references
  */
diff --git a/init/main.c b/init/main.c
index be95e522fca8..89957e9e358a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -706,7 +706,7 @@ static int __init initcall_blacklist(char *str)
 		}
 	} while (str_entry);
 
-	return 0;
+	return 1;
 }
 
 static bool __init_or_module initcall_blacklisted(initcall_t fn)
@@ -922,7 +922,9 @@ static noinline void __init kernel_init_freeable(void);
 bool rodata_enabled __ro_after_init = true;
 static int __init set_debug_rodata(char *str)
 {
-	return strtobool(str, &rodata_enabled);
+	if (strtobool(str, &rodata_enabled))
+		pr_warn("Invalid option string for rodata: '%s'\n", str);
+	return 1;
 }
 __setup("rodata=", set_debug_rodata);
 #endif
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6f3134158375..fd1a6b82f557 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8307,8 +8307,11 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 			}
 
 			/* ready to consume more filters */
+			kfree(filename);
+			filename = NULL;
 			state = IF_STATE_ACTION;
 			filter = NULL;
+			kernel = 0;
 		}
 	}
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 8a406f53d211..785c37328451 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1199,7 +1199,7 @@ static int __init resumedelay_setup(char *str)
 	int rc = kstrtouint(str, 0, &resume_delay);
 
 	if (rc)
-		return rc;
+		pr_warn("resumedelay: bad option string '%s'\n", str);
 	return 1;
 }
 
diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index bdff5ed57f10..5476bd892183 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -158,22 +158,22 @@ static int __init setup_test_suspend(char *value)
 	value++;
 	suspend_type = strsep(&value, ",");
 	if (!suspend_type)
-		return 0;
+		return 1;
 
 	repeat = strsep(&value, ",");
 	if (repeat) {
 		if (kstrtou32(repeat, 0, &test_repeat_count_max))
-			return 0;
+			return 1;
 	}
 
 	for (i = 0; pm_labels[i]; i++)
 		if (!strcmp(pm_labels[i], suspend_type)) {
 			test_state_label = pm_labels[i];
-			return 0;
+			return 1;
 		}
 
 	printk(warn_bad_state, suspend_type);
-	return 0;
+	return 1;
 }
 __setup("test_suspend", setup_test_suspend);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3f1b762a0c30..b8954fc4b400 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -122,8 +122,10 @@ static int __control_devkmsg(char *str)
 
 static int __init control_devkmsg(char *str)
 {
-	if (__control_devkmsg(str) < 0)
+	if (__control_devkmsg(str) < 0) {
+		pr_warn("printk.devkmsg: bad option string '%s'\n", str);
 		return 1;
+	}
 
 	/*
 	 * Set sysctl string accordingly:
@@ -145,7 +147,7 @@ static int __init control_devkmsg(char *str)
 	 */
 	devkmsg_log |= DEVKMSG_LOG_MASK_LOCK;
 
-	return 0;
+	return 1;
 }
 __setup("printk.devkmsg=", control_devkmsg);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c738827f29f7..8f2bf81793c7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -385,6 +385,26 @@ bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 	return !err;
 }
 
+static int check_ptrace_options(unsigned long data)
+{
+	if (data & ~(unsigned long)PTRACE_O_MASK)
+		return -EINVAL;
+
+	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
+		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
+		    !IS_ENABLED(CONFIG_SECCOMP))
+			return -EINVAL;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		if (seccomp_mode(&current->seccomp) != SECCOMP_MODE_DISABLED ||
+		    current->ptrace & PT_SUSPEND_SECCOMP)
+			return -EPERM;
+	}
+	return 0;
+}
+
 static int ptrace_attach(struct task_struct *task, long request,
 			 unsigned long addr,
 			 unsigned long flags)
@@ -396,8 +416,16 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (seize) {
 		if (addr != 0)
 			goto out;
+		/*
+		 * This duplicates the check in check_ptrace_options() because
+		 * ptrace_attach() and ptrace_setoptions() have historically
+		 * used different error codes for unknown ptrace options.
+		 */
 		if (flags & ~(unsigned long)PTRACE_O_MASK)
 			goto out;
+		retval = check_ptrace_options(flags);
+		if (retval)
+			return retval;
 		flags = PT_PTRACED | PT_SEIZED | (flags << PT_OPT_FLAG_SHIFT);
 	} else {
 		flags = PT_PTRACED;
@@ -670,22 +698,11 @@ int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long ds
 static int ptrace_setoptions(struct task_struct *child, unsigned long data)
 {
 	unsigned flags;
+	int ret;
 
-	if (data & ~(unsigned long)PTRACE_O_MASK)
-		return -EINVAL;
-
-	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
-		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
-		    !IS_ENABLED(CONFIG_SECCOMP))
-			return -EINVAL;
-
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
-
-		if (seccomp_mode(&current->seccomp) != SECCOMP_MODE_DISABLED ||
-		    current->ptrace & PT_SUSPEND_SECCOMP)
-			return -EPERM;
-	}
+	ret = check_ptrace_options(data);
+	if (ret)
+		return ret;
 
 	/* Avoid intermediate state when all opts are cleared */
 	flags = child->ptrace;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 935224123441..5237566f2bad 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -839,25 +839,15 @@ void print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 {
 #ifdef CONFIG_NUMA_BALANCING
-	struct mempolicy *pol;
-
 	if (p->mm)
 		P(mm->numa_scan_seq);
 
-	task_lock(p);
-	pol = p->mempolicy;
-	if (pol && !(pol->flags & MPOL_F_MORON))
-		pol = NULL;
-	mpol_get(pol);
-	task_unlock(p);
-
 	P(numa_pages_migrated);
 	P(numa_preferred_nid);
 	P(total_numa_faults);
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
 	show_numa_stats(p, m);
-	mpol_put(pol);
 #endif
 }
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 399905fdfa3f..df9d5a64b0aa 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -209,7 +209,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
 	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
-		     !warned && !llist_empty(head))) {
+		     !warned && entry != NULL)) {
 		warned = true;
 		WARN(1, "IPI on offline CPU %d\n", smp_processor_id());
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 78b445562b81..184d462339e6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -222,6 +222,11 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 #endif
 
 #ifdef CONFIG_BPF_SYSCALL
+
+void __weak unpriv_ebpf_notify(int new_state)
+{
+}
+
 static int bpf_unpriv_handler(struct ctl_table *table, int write,
                              void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -239,6 +244,9 @@ static int bpf_unpriv_handler(struct ctl_table *table, int write,
 			return -EPERM;
 		*(int *)table->data = unpriv_enable;
 	}
+
+	unpriv_ebpf_notify(unpriv_enable);
+
 	return ret;
 }
 #endif
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b0975f35612c..1c801aeae9b2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1077,10 +1077,12 @@ static int __init set_buf_size(char *str)
 	if (!str)
 		return 0;
 	buf_size = memparse(str, &str);
-	/* nr_entries can not be zero */
-	if (buf_size == 0)
-		return 0;
-	trace_buf_size = buf_size;
+	/*
+	 * nr_entries can not be zero and the startup
+	 * tests require some buffer space. Therefore
+	 * ensure we have at least 4096 bytes of buffer.
+	 */
+	trace_buf_size = max(4096UL, buf_size);
 	return 1;
 }
 __setup("trace_buf_size=", set_buf_size);
diff --git a/lib/Kconfig b/lib/Kconfig
index b06becb3f477..b3b4f3045178 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -16,7 +16,6 @@ config BITREVERSE
 config HAVE_ARCH_BITREVERSE
 	bool
 	default n
-	depends on BITREVERSE
 	help
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
diff --git a/lib/raid6/test/test.c b/lib/raid6/test/test.c
index b07f4d8e6b03..a7e937248299 100644
--- a/lib/raid6/test/test.c
+++ b/lib/raid6/test/test.c
@@ -22,7 +22,6 @@
 #define NDISKS		16	/* Including P and Q */
 
 const char raid6_empty_zero_page[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
-struct raid6_calls raid6_call;
 
 char *dataptrs[NDISKS];
 char data[NDISKS][PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
diff --git a/localversion-rt b/localversion-rt
index 62fe25bd6258..58dccbc39d0a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt192
+-rt193
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 59bb2b9ec0e2..c1360b250919 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1130,7 +1130,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 			       gfp_t gfp)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_alloc(__va(phys), size, min_count, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
@@ -1141,7 +1141,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_free_part(__va(phys), size);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
@@ -1152,7 +1152,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_not_leak_phys(phys_addr_t phys)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_not_leak(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_not_leak_phys);
@@ -1163,7 +1163,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) < max_low_pfn)
+	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
 		kmemleak_ignore(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
diff --git a/mm/memblock.c b/mm/memblock.c
index e43065b13c08..9f4e78dd2aa1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -272,14 +272,20 @@ void __init memblock_discard(void)
 		addr = __pa(memblock.reserved.regions);
 		size = PAGE_ALIGN(sizeof(struct memblock_region) *
 				  memblock.reserved.max);
-		__memblock_free_late(addr, size);
+		if (memblock_reserved_in_slab)
+			kfree(memblock.reserved.regions);
+		else
+			__memblock_free_late(addr, size);
 	}
 
 	if (memblock.memory.regions != memblock_memory_init_regions) {
 		addr = __pa(memblock.memory.regions);
 		size = PAGE_ALIGN(sizeof(struct memblock_region) *
 				  memblock.memory.max);
-		__memblock_free_late(addr, size);
+		if (memblock_memory_in_slab)
+			kfree(memblock.memory.regions);
+		else
+			__memblock_free_late(addr, size);
 	}
 }
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 701c4aff44ad..6fa15f7a5532 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5843,7 +5843,7 @@ static int __init cgroup_memory(char *s)
 		if (!strcmp(token, "nokmem"))
 			cgroup_memory_nokmem = true;
 	}
-	return 0;
+	return 1;
 }
 __setup("cgroup.memory=", cgroup_memory);
 
diff --git a/mm/memory.c b/mm/memory.c
index 2b2cc69ddcce..1b31cdce936e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1113,6 +1113,17 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	return ret;
 }
 
+/* Whether we should zap all COWed (private) pages too */
+static inline bool should_zap_cows(struct zap_details *details)
+{
+	/* By default, zap all pages */
+	if (!details)
+		return true;
+
+	/* Or, we zap COWed pages only if the caller wants to */
+	return !details->check_mapping;
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1186,17 +1197,20 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			}
 			continue;
 		}
-		/* only check swap_entries if explicitly asked for in details */
-		if (unlikely(details && !details->check_swap_entries))
-			continue;
 
 		entry = pte_to_swp_entry(ptent);
-		if (!non_swap_entry(entry))
+		if (!non_swap_entry(entry)) {
+			/* Genuine swap entry, hence a private anon page */
+			if (!should_zap_cows(details))
+				continue;
 			rss[MM_SWAPENTS]--;
-		else if (is_migration_entry(entry)) {
+		} else if (is_migration_entry(entry)) {
 			struct page *page;
 
 			page = migration_entry_to_page(entry);
+			if (details && details->check_mapping &&
+			    details->check_mapping != page_rmapping(page))
+				continue;
 			rss[mm_counter(page)]--;
 		}
 		if (unlikely(!free_swap_and_cache(entry)))
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2f443767fd1b..6059f85546fe 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -734,7 +734,6 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	struct vm_area_struct *next;
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err = 0;
@@ -750,8 +749,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 	if (start > vma->vm_start)
 		prev = vma;
 
-	for (; vma && vma->vm_start < end; prev = vma, vma = next) {
-		next = vma->vm_next;
+	for (; vma && vma->vm_start < end; prev = vma, vma = vma->vm_next) {
 		vmstart = max(start, vma->vm_start);
 		vmend   = min(end, vma->vm_end);
 
@@ -765,10 +763,6 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 				 new_pol, vma->vm_userfaultfd_ctx);
 		if (prev) {
 			vma = prev;
-			next = vma->vm_next;
-			if (mpol_equal(vma_policy(vma), new_pol))
-				continue;
-			/* vma_merge() joined vma && vma->next, case 8 */
 			goto replace;
 		}
 		if (vma->vm_start != vmstart) {
@@ -2505,6 +2499,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
 	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
 	if (!mpol_new)
 		goto err_out;
+	atomic_set(&mpol_new->refcnt, 1);
 	goto restart;
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 7c8815636c48..18bd38ac1531 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2425,7 +2425,7 @@ static int __init cmdline_parse_stack_guard_gap(char *p)
 	if (!*endptr)
 		stack_guard_gap = val << PAGE_SHIFT;
 
-	return 0;
+	return 1;
 }
 __setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
 
diff --git a/mm/mremap.c b/mm/mremap.c
index b5d8d25173c6..058de6f8c9d5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -192,6 +192,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
 
+	if (!len)
+		return 0;
+
 	old_end = old_addr + len;
 	flush_cache_range(vma, old_addr, old_end);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d3aabbbb2b1..c138ea944591 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4560,7 +4560,7 @@ static int build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist,
 	do {
 		zone_type--;
 		zone = pgdat->node_zones + zone_type;
-		if (managed_zone(zone)) {
+		if (populated_zone(zone)) {
 			zoneref_set_zone(zone,
 				&zonelist->_zonerefs[nr_zones++]);
 			check_highest_zone(zone_type);
@@ -6324,10 +6324,17 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 
 out2:
 	/* Align start of ZONE_MOVABLE on all nids to MAX_ORDER_NR_PAGES */
-	for (nid = 0; nid < MAX_NUMNODES; nid++)
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		unsigned long start_pfn, end_pfn;
+
 		zone_movable_pfn[nid] =
 			roundup(zone_movable_pfn[nid], MAX_ORDER_NR_PAGES);
 
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (zone_movable_pfn[nid] >= end_pfn)
+			zone_movable_pfn[nid] = 0;
+	}
+
 out:
 	/* restore the node_state */
 	node_states[N_MEMORY] = saved_node_state;
@@ -6554,7 +6561,7 @@ void __init mem_init_print_info(const char *str)
 	 */
 #define adj_init_size(start, end, size, pos, adj) \
 	do { \
-		if (start <= pos && pos < end && size > adj) \
+		if (&start[0] <= &pos[0] && &pos[0] < &end[0] && size > adj) \
 			size -= adj; \
 	} while (0)
 
diff --git a/mm/rmap.c b/mm/rmap.c
index a7276d8c96f3..0a5310b76ec8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1638,11 +1638,36 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 */
 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
 
-		if (!PageDirty(page) && (flags & TTU_LZFREE)) {
-			/* It's a freeable page by MADV_FREE */
-			dec_mm_counter(mm, MM_ANONPAGES);
-			rp->lazyfreed++;
-			goto discard;
+		if (flags & TTU_LZFREE) {
+			int ref_count, map_count;
+
+			/*
+			 * Synchronize with gup_pte_range():
+			 * - clear PTE; barrier; read refcount
+			 * - inc refcount; barrier; read PTE
+			 */
+			smp_mb();
+
+			ref_count = page_ref_count(page);
+			map_count = page_mapcount(page);
+
+			/*
+			 * Order reads for page refcount and dirty flag
+			 * (see comments in __remove_mapping()).
+			 */
+			smp_rmb();
+
+			/*
+			 * The only page refs must be one from isolation
+			 * plus the rmap(s) (dropped by discard:).
+			 */
+			if (ref_count == 1 + map_count &&
+			    !PageDirty(page)) {
+				/* It's a freeable page by MADV_FREE */
+				dec_mm_counter(mm, MM_ANONPAGES);
+				rp->lazyfreed++;
+				goto discard;
+			}
 		}
 
 		if (swap_duplicate(entry) < 0) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 51aa13f59622..dffa36e6d1c4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2478,7 +2478,8 @@ static void shmem_tag_pins(struct address_space *mapping)
 				slot = radix_tree_iter_retry(&iter);
 				continue;
 			}
-		} else if (page_count(page) - page_mapcount(page) > 1) {
+		} else if (!PageTail(page) && page_count(page) !=
+			   hpage_nr_pages(page) + total_mapcount(page)) {
 			radix_tree_tag_set(&mapping->page_tree, iter.index,
 					   SHMEM_TAG_PINNED);
 		}
@@ -2538,8 +2539,8 @@ static int shmem_wait_for_pins(struct address_space *mapping)
 				page = NULL;
 			}
 
-			if (page &&
-			    page_count(page) - page_mapcount(page) != 1) {
+			if (page && page_count(page) !=
+			    hpage_nr_pages(page) + total_mapcount(page)) {
 				if (scan < LAST_SCAN)
 					goto continue_resched;
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index c4ef1be59cb1..839c4237d131 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -90,6 +90,13 @@ static void ax25_kill_by_device(struct net_device *dev)
 	ax25_for_each(s, &ax25_list) {
 		if (s->ax25_dev == ax25_dev) {
 			sk = s->sk;
+			if (!sk) {
+				spin_unlock_bh(&ax25_list_lock);
+				s->ax25_dev = NULL;
+				ax25_disconnect(s, ENETUNREACH);
+				spin_lock_bh(&ax25_list_lock);
+				goto again;
+			}
 			sock_hold(sk);
 			spin_unlock_bh(&ax25_list_lock);
 			lock_sock(sk);
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4f384abb4ced..eaf0a483211a 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -155,22 +155,25 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 	struct net *net = dev_net(net_dev);
 	struct net_device *parent_dev;
 	const struct net *parent_net;
+	int iflink;
 	bool ret;
 
 	/* check if this is a batman-adv mesh interface */
 	if (batadv_softif_is_valid(net_dev))
 		return true;
 
-	/* no more parents..stop recursion */
-	if (dev_get_iflink(net_dev) == 0 ||
-	    dev_get_iflink(net_dev) == net_dev->ifindex)
+	iflink = dev_get_iflink(net_dev);
+	if (iflink == 0)
 		return false;
 
 	parent_net = batadv_getlink_net(net_dev, net);
 
+	/* iflink to itself, most likely physical device */
+	if (net == parent_net && iflink == net_dev->ifindex)
+		return false;
+
 	/* recurse over the parent device */
-	parent_dev = __dev_get_by_index((struct net *)parent_net,
-					dev_get_iflink(net_dev));
+	parent_dev = __dev_get_by_index((struct net *)parent_net, iflink);
 	/* if we got a NULL parent_dev there is something broken.. */
 	if (!parent_dev) {
 		pr_err("Cannot find parent device\n");
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cff87c465bcb..8face15b42d8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4470,8 +4470,9 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	hcon = hci_conn_hash_lookup_handle(hdev, ev->phy_handle);
-	if (hcon) {
+	if (hcon && hcon->type == AMP_LINK) {
 		hcon->state = BT_CLOSED;
+		hci_disconn_cfm(hcon, ev->reason);
 		hci_conn_del(hcon);
 	}
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3fb5d8ecc849..e42df58b8876 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -198,7 +198,7 @@ static ssize_t speed_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev) && netif_device_present(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
 		if (!__ethtool_get_link_ksettings(netdev, &cmd))
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4e192c8bd8b1..9b7d01857ac4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1731,7 +1731,7 @@ unsigned char *__pskb_pull_tail(struct sk_buff *skb, int delta)
 		/* Free pulled out fragments. */
 		while ((list = skb_shinfo(skb)->frag_list) != insp) {
 			skb_shinfo(skb)->frag_list = list->next;
-			kfree_skb(list);
+			consume_skb(list);
 		}
 		/* And insert new clone at head. */
 		if (clone) {
@@ -4966,7 +4966,7 @@ static int pskb_carve_frag_list(struct sk_buff *skb,
 	/* Free pulled out fragments. */
 	while ((list = shinfo->frag_list) != insp) {
 		shinfo->frag_list = list->next;
-		kfree_skb(list);
+		consume_skb(list);
 	}
 	/* And insert new clone at head. */
 	if (clone) {
diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 2dbf5a0faad3..e32a520c3702 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1938,10 +1938,54 @@ int dcb_ieee_delapp(struct net_device *dev, struct dcb_app *del)
 }
 EXPORT_SYMBOL(dcb_ieee_delapp);
 
+static void dcbnl_flush_dev(struct net_device *dev)
+{
+	struct dcb_app_type *itr, *tmp;
+
+	spin_lock_bh(&dcb_lock);
+
+	list_for_each_entry_safe(itr, tmp, &dcb_app_list, list) {
+		if (itr->ifindex == dev->ifindex) {
+			list_del(&itr->list);
+			kfree(itr);
+		}
+	}
+
+	spin_unlock_bh(&dcb_lock);
+}
+
+static int dcbnl_netdevice_event(struct notifier_block *nb,
+				 unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	switch (event) {
+	case NETDEV_UNREGISTER:
+		if (!dev->dcbnl_ops)
+			return NOTIFY_DONE;
+
+		dcbnl_flush_dev(dev);
+
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block dcbnl_nb __read_mostly = {
+	.notifier_call  = dcbnl_netdevice_event,
+};
+
 static int __init dcbnl_init(void)
 {
+	int err;
+
 	INIT_LIST_HEAD(&dcb_app_list);
 
+	err = register_netdevice_notifier(&dcbnl_nb);
+	if (err)
+		return err;
+
 	rtnl_register(PF_UNSPEC, RTM_GETDCB, dcb_doit, NULL, NULL);
 	rtnl_register(PF_UNSPEC, RTM_SETDCB, dcb_doit, NULL, NULL);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a8563745980b..8f2fb14fd4f7 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1238,8 +1238,11 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	}
 
 	ops = rcu_dereference(inet_offloads[proto]);
-	if (likely(ops && ops->callbacks.gso_segment))
+	if (likely(ops && ops->callbacks.gso_segment)) {
 		segs = ops->callbacks.gso_segment(skb, features);
+		if (!segs)
+			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
+	}
 
 	if (IS_ERR_OR_NULL(segs))
 		goto out;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index aeda018e4c49..6dfb964e1ad8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1561,11 +1561,13 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 				if (!copied)
 					copied = used;
 				break;
-			} else if (used <= len) {
-				seq += used;
-				copied += used;
-				offset += used;
 			}
+			if (WARN_ON_ONCE(used > len))
+				used = len;
+			seq += used;
+			copied += used;
+			offset += used;
+
 			/* If recv_actor drops the lock (e.g. TCP splice
 			 * receive) the skb pointer might be invalid when
 			 * getting here: tcp_collapse might have deleted it
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index a36ae90bf613..87763302bce2 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -96,6 +96,8 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	if (likely(ops && ops->callbacks.gso_segment)) {
 		skb_reset_transport_header(skb);
 		segs = ops->callbacks.gso_segment(skb, features);
+		if (!segs)
+			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
 	}
 
 	if (IS_ERR_OR_NULL(segs))
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d93a98dfe52d..775901abe678 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1274,8 +1274,6 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 		if (np->frag_size)
 			mtu = np->frag_size;
 	}
-	if (mtu < IPV6_MIN_MTU)
-		return -EINVAL;
 	cork->base.fragsize = mtu;
 	if (dst_allfrag(rt->dst.path))
 		cork->base.flags |= IPCORK_ALLFRAG;
@@ -1324,8 +1322,6 @@ static int __ip6_append_data(struct sock *sk,
 
 	fragheaderlen = sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
 			(opt ? opt->opt_nflen : 0);
-	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
-		     sizeof(struct frag_hdr);
 
 	headersize = sizeof(struct ipv6hdr) +
 		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
@@ -1333,6 +1329,13 @@ static int __ip6_append_data(struct sock *sk,
 		      sizeof(struct frag_hdr) : 0) +
 		     rt->rt6i_nfheader_len;
 
+	if (mtu <= fragheaderlen ||
+	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
+		goto emsgsize;
+
+	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
+		     sizeof(struct frag_hdr);
+
 	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
 	 * the first fragment
 	 */
diff --git a/net/key/af_key.c b/net/key/af_key.c
index adc93329e6aa..c9cc9f75b099 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1726,7 +1726,7 @@ static int pfkey_register(struct sock *sk, struct sk_buff *skb, const struct sad
 
 	xfrm_probe_algs();
 
-	supp_skb = compose_sadb_supported(hdr, GFP_KERNEL);
+	supp_skb = compose_sadb_supported(hdr, GFP_KERNEL | __GFP_ZERO);
 	if (!supp_skb) {
 		if (hdr->sadb_msg_satype != SADB_SATYPE_UNSPEC)
 			pfk->registered &= ~(1<<hdr->sadb_msg_satype);
@@ -2434,7 +2434,7 @@ static int pfkey_spddelete(struct sock *sk, struct sk_buff *skb, const struct sa
 			return err;
 	}
 
-	xp = xfrm_policy_bysel_ctx(net, DUMMY_MARK, XFRM_POLICY_TYPE_MAIN,
+	xp = xfrm_policy_bysel_ctx(net, &dummy_mark, XFRM_POLICY_TYPE_MAIN,
 				   pol->sadb_x_policy_dir - 1, &sel, pol_ctx,
 				   1, &err);
 	security_xfrm_policy_free(pol_ctx);
@@ -2687,7 +2687,7 @@ static int pfkey_spdget(struct sock *sk, struct sk_buff *skb, const struct sadb_
 		return -EINVAL;
 
 	delete = (hdr->sadb_msg_type == SADB_X_SPDDELETE2);
-	xp = xfrm_policy_byid(net, DUMMY_MARK, XFRM_POLICY_TYPE_MAIN,
+	xp = xfrm_policy_byid(net, &dummy_mark, XFRM_POLICY_TYPE_MAIN,
 			      dir, pol->sadb_x_policy_id, delete, &err);
 	if (xp == NULL)
 		return -ENOENT;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index a8866455e8b2..b6dbec793ebb 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -274,6 +274,7 @@ static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
+	struct net_device *dev = NULL;
 	struct llc_sap *sap;
 	int rc = -EINVAL;
 
@@ -285,14 +286,14 @@ static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
 		goto out;
 	rc = -ENODEV;
 	if (sk->sk_bound_dev_if) {
-		llc->dev = dev_get_by_index(&init_net, sk->sk_bound_dev_if);
-		if (llc->dev && addr->sllc_arphrd != llc->dev->type) {
-			dev_put(llc->dev);
-			llc->dev = NULL;
+		dev = dev_get_by_index(&init_net, sk->sk_bound_dev_if);
+		if (dev && addr->sllc_arphrd != dev->type) {
+			dev_put(dev);
+			dev = NULL;
 		}
 	} else
-		llc->dev = dev_getfirstbyhwtype(&init_net, addr->sllc_arphrd);
-	if (!llc->dev)
+		dev = dev_getfirstbyhwtype(&init_net, addr->sllc_arphrd);
+	if (!dev)
 		goto out;
 	rc = -EUSERS;
 	llc->laddr.lsap = llc_ui_autoport();
@@ -302,6 +303,11 @@ static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
 	sap = llc_sap_open(llc->laddr.lsap, NULL);
 	if (!sap)
 		goto out;
+
+	/* Note: We do not expect errors from this point. */
+	llc->dev = dev;
+	dev = NULL;
+
 	memcpy(llc->laddr.mac, llc->dev->dev_addr, IFHWADDRLEN);
 	memcpy(&llc->addr, addr, sizeof(llc->addr));
 	/* assign new connection to its SAP */
@@ -309,6 +315,7 @@ static int llc_ui_autobind(struct socket *sock, struct sockaddr_llc *addr)
 	sock_reset_flag(sk, SOCK_ZAPPED);
 	rc = 0;
 out:
+	dev_put(dev);
 	return rc;
 }
 
@@ -331,6 +338,7 @@ static int llc_ui_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
 	struct sockaddr_llc *addr = (struct sockaddr_llc *)uaddr;
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
+	struct net_device *dev = NULL;
 	struct llc_sap *sap;
 	int rc = -EINVAL;
 
@@ -347,25 +355,26 @@ static int llc_ui_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
 	rc = -ENODEV;
 	rcu_read_lock();
 	if (sk->sk_bound_dev_if) {
-		llc->dev = dev_get_by_index_rcu(&init_net, sk->sk_bound_dev_if);
-		if (llc->dev) {
+		dev = dev_get_by_index_rcu(&init_net, sk->sk_bound_dev_if);
+		if (dev) {
 			if (is_zero_ether_addr(addr->sllc_mac))
-				memcpy(addr->sllc_mac, llc->dev->dev_addr,
+				memcpy(addr->sllc_mac, dev->dev_addr,
 				       IFHWADDRLEN);
-			if (addr->sllc_arphrd != llc->dev->type ||
+			if (addr->sllc_arphrd != dev->type ||
 			    !ether_addr_equal(addr->sllc_mac,
-					      llc->dev->dev_addr)) {
+					      dev->dev_addr)) {
 				rc = -EINVAL;
-				llc->dev = NULL;
+				dev = NULL;
 			}
 		}
-	} else
-		llc->dev = dev_getbyhwaddr_rcu(&init_net, addr->sllc_arphrd,
+	} else {
+		dev = dev_getbyhwaddr_rcu(&init_net, addr->sllc_arphrd,
 					   addr->sllc_mac);
-	if (llc->dev)
-		dev_hold(llc->dev);
+	}
+	if (dev)
+		dev_hold(dev);
 	rcu_read_unlock();
-	if (!llc->dev)
+	if (!dev)
 		goto out;
 	if (!addr->sllc_sap) {
 		rc = -EUSERS;
@@ -398,6 +407,11 @@ static int llc_ui_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
 			goto out_put;
 		}
 	}
+
+	/* Note: We do not expect errors from this point. */
+	llc->dev = dev;
+	dev = NULL;
+
 	llc->laddr.lsap = addr->sllc_sap;
 	memcpy(llc->laddr.mac, addr->sllc_mac, IFHWADDRLEN);
 	memcpy(&llc->addr, addr, sizeof(llc->addr));
@@ -408,6 +422,7 @@ static int llc_ui_bind(struct socket *sock, struct sockaddr *uaddr, int addrlen)
 out_put:
 	llc_sap_put(sap);
 out:
+	dev_put(dev);
 	release_sock(sk);
 	return rc;
 }
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f37fbc71fc1d..091ac3a7b186 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1776,13 +1776,11 @@ static int copy_mesh_setup(struct ieee80211_if_mesh *ifmsh,
 		const struct mesh_setup *setup)
 {
 	u8 *new_ie;
-	const u8 *old_ie;
 	struct ieee80211_sub_if_data *sdata = container_of(ifmsh,
 					struct ieee80211_sub_if_data, u.mesh);
 
 	/* allocate information elements */
 	new_ie = NULL;
-	old_ie = ifmsh->ie;
 
 	if (setup->ie_len) {
 		new_ie = kmemdup(setup->ie, setup->ie_len,
@@ -1792,7 +1790,6 @@ static int copy_mesh_setup(struct ieee80211_if_mesh *ifmsh,
 	}
 	ifmsh->ie_len = setup->ie_len;
 	ifmsh->ie = new_ie;
-	kfree(old_ie);
 
 	/* now copy the rest of the setup parameters */
 	ifmsh->mesh_id_len = setup->mesh_id_len;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 96b2333496b5..a3ac9f57a489 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2607,13 +2607,13 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 	    ether_addr_equal(sdata->vif.addr, hdr->addr3))
 		return RX_CONTINUE;
 
-	ac = ieee80211_select_queue_80211(sdata, skb, hdr);
+	ac = ieee802_1d_to_ac[skb->priority];
 	q = sdata->vif.hw_queue[ac];
 	if (ieee80211_queue_stopped(&local->hw, q)) {
 		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_congestion);
 		return RX_DROP_MONITOR;
 	}
-	skb_set_queue_mapping(skb, q);
+	skb_set_queue_mapping(skb, ac);
 
 	if (!--mesh_hdr->ttl) {
 		if (!is_multicast_ether_addr(hdr->addr1))
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 69f687740c76..9e9ce570bb9e 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -390,8 +390,8 @@ static void tcp_options(const struct sk_buff *skb,
 				 length, buff);
 	BUG_ON(ptr == NULL);
 
-	state->td_scale =
-	state->flags = 0;
+	state->td_scale = 0;
+	state->flags &= IP_CT_TCP_FLAG_BE_LIBERAL;
 
 	while (length > 0) {
 		int opcode=*ptr++;
@@ -806,6 +806,16 @@ static unsigned int *tcp_get_timeouts(struct net *net)
 	return tcp_pernet(net)->timeouts;
 }
 
+static void nf_ct_tcp_state_reset(struct ip_ct_tcp_state *state)
+{
+	state->td_end		= 0;
+	state->td_maxend	= 0;
+	state->td_maxwin	= 0;
+	state->td_maxack	= 0;
+	state->td_scale		= 0;
+	state->flags		&= IP_CT_TCP_FLAG_BE_LIBERAL;
+}
+
 /* Returns verdict for packet, or -1 for invalid. */
 static int tcp_packet(struct nf_conn *ct,
 		      const struct sk_buff *skb,
@@ -907,8 +917,7 @@ static int tcp_packet(struct nf_conn *ct,
 			ct->proto.tcp.last_flags &= ~IP_CT_EXP_CHALLENGE_ACK;
 			ct->proto.tcp.seen[ct->proto.tcp.last_dir].flags =
 				ct->proto.tcp.last_flags;
-			memset(&ct->proto.tcp.seen[dir], 0,
-			       sizeof(struct ip_ct_tcp_state));
+			nf_ct_tcp_state_reset(&ct->proto.tcp.seen[dir]);
 			break;
 		}
 		ct->proto.tcp.last_index = index;
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 8f08d759844a..333ea2368101 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -44,6 +44,15 @@ void nf_unregister_queue_handler(struct net *net)
 }
 EXPORT_SYMBOL(nf_unregister_queue_handler);
 
+static void nf_queue_sock_put(struct sock *sk)
+{
+#ifdef CONFIG_INET
+	sock_gen_put(sk);
+#else
+	sock_put(sk);
+#endif
+}
+
 void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 {
 	struct nf_hook_state *state = &entry->state;
@@ -54,7 +63,7 @@ void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 	if (state->out)
 		dev_put(state->out);
 	if (state->sk)
-		sock_put(state->sk);
+		nf_queue_sock_put(state->sk);
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	if (entry->skb->nf_bridge) {
 		struct net_device *physdev;
@@ -71,10 +80,13 @@ void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 EXPORT_SYMBOL_GPL(nf_queue_entry_release_refs);
 
 /* Bump dev refs so they don't vanish while packet is out */
-void nf_queue_entry_get_refs(struct nf_queue_entry *entry)
+bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 {
 	struct nf_hook_state *state = &entry->state;
 
+	if (state->sk && !atomic_inc_not_zero(&state->sk->sk_refcnt))
+		return false;
+
 	if (state->in)
 		dev_hold(state->in);
 	if (state->out)
@@ -93,6 +105,7 @@ void nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 			dev_hold(physdev);
 	}
 #endif
+	return true;
 }
 EXPORT_SYMBOL_GPL(nf_queue_entry_get_refs);
 
@@ -139,7 +152,11 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 		.size	= sizeof(*entry) + afinfo->route_key_size,
 	};
 
-	nf_queue_entry_get_refs(entry);
+	if (!nf_queue_entry_get_refs(entry)) {
+		kfree(entry);
+		return -ENOTCONN;
+	}
+
 	skb_dst_force(skb);
 	afinfo->saveroute(skb, entry);
 	status = qh->outfn(entry, queuenum);
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 9d593ecd8e87..fb14082151ce 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -127,7 +127,7 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 	const struct net *net = pkt->net;
 	const struct nft_rule *rule;
 	const struct nft_expr *expr, *last;
-	struct nft_regs regs;
+	struct nft_regs regs = {};
 	unsigned int stackptr = 0;
 	struct nft_jumpstack jumpstack[NFT_JUMP_STACK_SIZE];
 	struct nft_stats *stats;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index a35510565d4d..66814a9d030c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -673,9 +673,15 @@ static struct nf_queue_entry *
 nf_queue_entry_dup(struct nf_queue_entry *e)
 {
 	struct nf_queue_entry *entry = kmemdup(e, e->size, GFP_ATOMIC);
-	if (entry)
-		nf_queue_entry_get_refs(entry);
-	return entry;
+
+	if (!entry)
+		return NULL;
+
+	if (nf_queue_entry_get_refs(entry))
+		return entry;
+
+	kfree(entry);
+	return NULL;
 }
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 13d69cbd14c2..a8674e9ff37b 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -161,6 +161,8 @@ static const struct rhashtable_params netlink_rhashtable_params;
 
 static inline u32 netlink_group_mask(u32 group)
 {
+	if (group > 32)
+		return 0;
 	return group ? 1 << (group - 1) : 0;
 }
 
@@ -2192,6 +2194,13 @@ static int netlink_dump(struct sock *sk)
 	 * single netdev. The outcome is MSG_TRUNC error.
 	 */
 	skb_reserve(skb, skb_tailroom(skb) - alloc_size);
+
+	/* Make sure malicious BPF programs can not read unitialized memory
+	 * from skb->head -> skb->data
+	 */
+	skb_reset_network_header(skb);
+	skb_reset_mac_header(skb);
+
 	netlink_skb_set_owner_r(skb, sk);
 
 	if (nlk->dump_done_errno > 0)
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 84eedbd5716d..df90872fcf90 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -561,6 +561,10 @@ static int nci_close_device(struct nci_dev *ndev)
 	mutex_lock(&ndev->req_lock);
 
 	if (!test_and_clear_bit(NCI_UP, &ndev->flags)) {
+		/* Need to flush the cmd wq in case
+		 * there is a queued/running cmd_work
+		 */
+		flush_workqueue(ndev->cmd_wq);
 		del_timer_sync(&ndev->cmd_timer);
 		del_timer_sync(&ndev->data_timer);
 		mutex_unlock(&ndev->req_lock);
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 5fa7b2569a3a..4d9b9d959faf 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -391,12 +391,43 @@ static void set_ipv6_addr(struct sk_buff *skb, u8 l4_proto,
 	memcpy(addr, new_addr, sizeof(__be32[4]));
 }
 
-static void set_ipv6_fl(struct ipv6hdr *nh, u32 fl, u32 mask)
+static void set_ipv6_dsfield(struct sk_buff *skb, struct ipv6hdr *nh, u8 ipv6_tclass, u8 mask)
 {
+	u8 old_ipv6_tclass = ipv6_get_dsfield(nh);
+
+	ipv6_tclass = OVS_MASKED(old_ipv6_tclass, ipv6_tclass, mask);
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		csum_replace(&skb->csum, (__force __wsum)(old_ipv6_tclass << 12),
+			     (__force __wsum)(ipv6_tclass << 12));
+
+	ipv6_change_dsfield(nh, ~mask, ipv6_tclass);
+}
+
+static void set_ipv6_fl(struct sk_buff *skb, struct ipv6hdr *nh, u32 fl, u32 mask)
+{
+	u32 ofl;
+
+	ofl = nh->flow_lbl[0] << 16 |  nh->flow_lbl[1] << 8 |  nh->flow_lbl[2];
+	fl = OVS_MASKED(ofl, fl, mask);
+
 	/* Bits 21-24 are always unmasked, so this retains their values. */
-	OVS_SET_MASKED(nh->flow_lbl[0], (u8)(fl >> 16), (u8)(mask >> 16));
-	OVS_SET_MASKED(nh->flow_lbl[1], (u8)(fl >> 8), (u8)(mask >> 8));
-	OVS_SET_MASKED(nh->flow_lbl[2], (u8)fl, (u8)mask);
+	nh->flow_lbl[0] = (u8)(fl >> 16);
+	nh->flow_lbl[1] = (u8)(fl >> 8);
+	nh->flow_lbl[2] = (u8)fl;
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		csum_replace(&skb->csum, (__force __wsum)htonl(ofl), (__force __wsum)htonl(fl));
+}
+
+static void set_ipv6_ttl(struct sk_buff *skb, struct ipv6hdr *nh, u8 new_ttl, u8 mask)
+{
+	new_ttl = OVS_MASKED(nh->hop_limit, new_ttl, mask);
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		csum_replace(&skb->csum, (__force __wsum)(nh->hop_limit << 8),
+			     (__force __wsum)(new_ttl << 8));
+	nh->hop_limit = new_ttl;
 }
 
 static void set_ip_ttl(struct sk_buff *skb, struct iphdr *nh, u8 new_ttl,
@@ -514,18 +545,17 @@ static int set_ipv6(struct sk_buff *skb, struct sw_flow_key *flow_key,
 		}
 	}
 	if (mask->ipv6_tclass) {
-		ipv6_change_dsfield(nh, ~mask->ipv6_tclass, key->ipv6_tclass);
+		set_ipv6_dsfield(skb, nh, key->ipv6_tclass, mask->ipv6_tclass);
 		flow_key->ip.tos = ipv6_get_dsfield(nh);
 	}
 	if (mask->ipv6_label) {
-		set_ipv6_fl(nh, ntohl(key->ipv6_label),
+		set_ipv6_fl(skb, nh, ntohl(key->ipv6_label),
 			    ntohl(mask->ipv6_label));
 		flow_key->ipv6.label =
 		    *(__be32 *)nh & htonl(IPV6_FLOWINFO_FLOWLABEL);
 	}
 	if (mask->ipv6_hlimit) {
-		OVS_SET_MASKED(nh->hop_limit, key->ipv6_hlimit,
-			       mask->ipv6_hlimit);
+		set_ipv6_ttl(skb, nh, key->ipv6_hlimit, mask->ipv6_hlimit);
 		flow_key->ip.ttl = nh->hop_limit;
 	}
 	return 0;
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 50ea76180afa..26921f755f3a 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -1713,8 +1713,8 @@ static int __ovs_nla_put_key(const struct sw_flow_key *swkey,
 			icmpv6_key->icmpv6_type = ntohs(output->tp.src);
 			icmpv6_key->icmpv6_code = ntohs(output->tp.dst);
 
-			if (icmpv6_key->icmpv6_type == NDISC_NEIGHBOUR_SOLICITATION ||
-			    icmpv6_key->icmpv6_type == NDISC_NEIGHBOUR_ADVERTISEMENT) {
+			if (swkey->tp.src == htons(NDISC_NEIGHBOUR_SOLICITATION) ||
+			    swkey->tp.src == htons(NDISC_NEIGHBOUR_ADVERTISEMENT)) {
 				struct ovs_key_nd *nd_key;
 
 				nla = nla_reserve(skb, OVS_KEY_ATTR_ND, sizeof(*nd_key));
@@ -1863,7 +1863,7 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
 	new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
 
 	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
-		if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size) {
+		if ((next_offset + req_size) > MAX_ACTIONS_BUFSIZE) {
 			OVS_NLERR(log, "Flow action size exceeds max %u",
 				  MAX_ACTIONS_BUFSIZE);
 			return ERR_PTR(-EMSGSIZE);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4256ddf805a2..f242e2613346 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2245,8 +2245,11 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 					copy_skb = skb_get(skb);
 					skb_head = skb->data;
 				}
-				if (copy_skb)
+				if (copy_skb) {
+					memset(&PACKET_SKB_CB(copy_skb)->sa.ll, 0,
+					       sizeof(PACKET_SKB_CB(copy_skb)->sa.ll));
 					skb_set_owner_r(copy_skb, sk);
+				}
 			}
 			snaplen = po->rx_ring.frame_size - macoff;
 			if ((int)snaplen < 0) {
@@ -2806,8 +2809,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 
 		status = TP_STATUS_SEND_REQUEST;
 		err = po->xmit(skb);
-		if (unlikely(err > 0)) {
-			err = net_xmit_errno(err);
+		if (unlikely(err != 0)) {
+			if (err > 0)
+				err = net_xmit_errno(err);
 			if (err && __packet_get_status(po, ph) ==
 				   TP_STATUS_AVAILABLE) {
 				/* skb was destructed already */
@@ -3007,8 +3011,12 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		skb->no_fcs = 1;
 
 	err = po->xmit(skb);
-	if (err > 0 && (err = net_xmit_errno(err)) != 0)
-		goto out_unlock;
+	if (unlikely(err != 0)) {
+		if (err > 0)
+			err = net_xmit_errno(err);
+		if (err)
+			goto out_unlock;
+	}
 
 	dev_put(dev);
 
@@ -3423,6 +3431,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	sock_recv_ts_and_drops(msg, sk, skb);
 
 	if (msg->msg_name) {
+		const size_t max_len = min(sizeof(skb->cb),
+					   sizeof(struct sockaddr_storage));
 		int copy_len;
 
 		/* If the address length field is there to be filled
@@ -3445,6 +3455,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 				msg->msg_namelen = sizeof(struct sockaddr_ll);
 			}
 		}
+		if (WARN_ON_ONCE(copy_len > max_len)) {
+			copy_len = max_len;
+			msg->msg_namelen = copy_len;
+		}
 		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
 	}
 
diff --git a/net/sctp/sctp_diag.c b/net/sctp/sctp_diag.c
index e8f56b7c5afb..a044964fa802 100644
--- a/net/sctp/sctp_diag.c
+++ b/net/sctp/sctp_diag.c
@@ -45,10 +45,6 @@ static void inet_diag_msg_sctpasoc_fill(struct inet_diag_msg *r,
 		r->idiag_timer = SCTP_EVENT_TIMEOUT_T3_RTX;
 		r->idiag_retrans = asoc->rtx_data_chunks;
 		r->idiag_expires = jiffies_to_msecs(t3_rtx->expires - jiffies);
-	} else {
-		r->idiag_timer = 0;
-		r->idiag_retrans = 0;
-		r->idiag_expires = 0;
 	}
 }
 
@@ -128,13 +124,14 @@ static int inet_sctp_diag_fill(struct sock *sk, struct sctp_association *asoc,
 	r = nlmsg_data(nlh);
 	BUG_ON(!sk_fullsock(sk));
 
+	r->idiag_timer = 0;
+	r->idiag_retrans = 0;
+	r->idiag_expires = 0;
 	if (asoc) {
 		inet_diag_msg_sctpasoc_fill(r, sk, asoc);
 	} else {
 		inet_diag_msg_common_fill(r, sk);
 		r->idiag_state = sk->sk_state;
-		r->idiag_timer = 0;
-		r->idiag_retrans = 0;
 	}
 
 	if (inet_diag_msg_attrs_fill(sk, skb, r, ext, user_ns, net_admin))
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 00d95fefdc6f..ccb9fa5812d8 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -883,8 +883,10 @@ int rpc_malloc(struct rpc_task *task)
 	struct rpc_buffer *buf;
 	gfp_t gfp = GFP_NOIO | __GFP_NOWARN;
 
+	if (RPC_IS_ASYNC(task))
+		gfp = GFP_NOWAIT | __GFP_NOWARN;
 	if (RPC_IS_SWAPPER(task))
-		gfp = __GFP_MEMALLOC | GFP_NOWAIT | __GFP_NOWARN;
+		gfp |= __GFP_MEMALLOC;
 
 	size += sizeof(struct rpc_buffer);
 	if (size <= RPC_BUFFER_MAXSIZE)
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 9491fc81d50a..ff263ece44a7 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1446,7 +1446,14 @@ static void xprt_destroy(struct rpc_xprt *xprt)
 	/* Exclude transport connect/disconnect handlers */
 	wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_UNINTERRUPTIBLE);
 
+	/*
+	 * xprt_schedule_autodisconnect() can run after XPRT_LOCKED
+	 * is cleared.  We use ->transport_lock to ensure the mod_timer()
+	 * can only run *before* del_time_sync(), never after.
+	 */
+	spin_lock(&xprt->transport_lock);
 	del_timer_sync(&xprt->timer);
+	spin_unlock(&xprt->transport_lock);
 
 	rpc_xprt_debugfs_unregister(xprt);
 	rpc_destroy_wait_queue(&xprt->binding);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 3ea3bb64b6d5..f308f286e9aa 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -577,8 +577,10 @@ xprt_rdma_allocate(struct rpc_task *task)
 		return -ENOMEM;
 
 	flags = RPCRDMA_DEF_GFP;
+	if (RPC_IS_ASYNC(task))
+		flags = GFP_NOWAIT | __GFP_NOWARN;
 	if (RPC_IS_SWAPPER(task))
-		flags = __GFP_MEMALLOC | GFP_NOWAIT | __GFP_NOWARN;
+		flags |= __GFP_MEMALLOC;
 
 	if (!rpcrdma_get_rdmabuf(r_xprt, req, flags))
 		goto out_fail;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ab8bca39afa3..562e138deba2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14068,7 +14068,8 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	wdev->chandef = *chandef;
 	wdev->preset_chandef = *chandef;
 
-	if (wdev->iftype == NL80211_IFTYPE_STATION &&
+	if ((wdev->iftype == NL80211_IFTYPE_STATION ||
+	     wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
 	    !WARN_ON(!wdev->current_bss))
 		wdev->current_bss->pub.channel = chandef->chan;
 
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c23c04d38a82..cd0c800b9072 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1795,10 +1795,15 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 
 	write_lock_bh(&x25_list_lock);
 
-	sk_for_each(s, &x25_list)
-		if (x25_sk(s)->neighbour == nb)
+	sk_for_each(s, &x25_list) {
+		if (x25_sk(s)->neighbour == nb) {
+			write_unlock_bh(&x25_list_lock);
+			lock_sock(s);
 			x25_disconnect(s, ENETUNREACH, 0, 0);
-
+			release_sock(s);
+			write_lock_bh(&x25_list_lock);
+		}
+	}
 	write_unlock_bh(&x25_list_lock);
 
 	/* Remove any related forwards */
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index b00ed36b9aac..9179b47e8b61 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -754,14 +754,10 @@ static void xfrm_policy_requeue(struct xfrm_policy *old,
 	spin_unlock_bh(&pq->hold_queue.lock);
 }
 
-static bool xfrm_policy_mark_match(struct xfrm_policy *policy,
-				   struct xfrm_policy *pol)
+static inline bool xfrm_policy_mark_match(const struct xfrm_mark *mark,
+					  struct xfrm_policy *pol)
 {
-	if (policy->mark.v == pol->mark.v &&
-	    policy->priority == pol->priority)
-		return true;
-
-	return false;
+	return mark->v == pol->mark.v && mark->m == pol->mark.m;
 }
 
 int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
@@ -779,7 +775,7 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	hlist_for_each_entry(pol, chain, bydst) {
 		if (pol->type == policy->type &&
 		    !selector_cmp(&pol->selector, &policy->selector) &&
-		    xfrm_policy_mark_match(policy, pol) &&
+		    xfrm_policy_mark_match(&policy->mark, pol) &&
 		    xfrm_sec_ctx_match(pol->security, policy->security) &&
 		    !WARN_ON(delpol)) {
 			if (excl) {
@@ -830,8 +826,8 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 }
 EXPORT_SYMBOL(xfrm_policy_insert);
 
-struct xfrm_policy *xfrm_policy_bysel_ctx(struct net *net, u32 mark, u8 type,
-					  int dir, struct xfrm_selector *sel,
+struct xfrm_policy *xfrm_policy_bysel_ctx(struct net *net, const struct xfrm_mark *mark,
+					  u8 type, int dir, struct xfrm_selector *sel,
 					  struct xfrm_sec_ctx *ctx, int delete,
 					  int *err)
 {
@@ -844,7 +840,7 @@ struct xfrm_policy *xfrm_policy_bysel_ctx(struct net *net, u32 mark, u8 type,
 	ret = NULL;
 	hlist_for_each_entry(pol, chain, bydst) {
 		if (pol->type == type &&
-		    (mark & pol->mark.m) == pol->mark.v &&
+		    xfrm_policy_mark_match(mark, pol) &&
 		    !selector_cmp(sel, &pol->selector) &&
 		    xfrm_sec_ctx_match(ctx, pol->security)) {
 			xfrm_pol_hold(pol);
@@ -869,8 +865,8 @@ struct xfrm_policy *xfrm_policy_bysel_ctx(struct net *net, u32 mark, u8 type,
 }
 EXPORT_SYMBOL(xfrm_policy_bysel_ctx);
 
-struct xfrm_policy *xfrm_policy_byid(struct net *net, u32 mark, u8 type,
-				     int dir, u32 id, int delete, int *err)
+struct xfrm_policy *xfrm_policy_byid(struct net *net, const struct xfrm_mark *mark,
+					 u8 type, int dir, u32 id, int delete, int *err)
 {
 	struct xfrm_policy *pol, *ret;
 	struct hlist_head *chain;
@@ -885,7 +881,7 @@ struct xfrm_policy *xfrm_policy_byid(struct net *net, u32 mark, u8 type,
 	ret = NULL;
 	hlist_for_each_entry(pol, chain, byidx) {
 		if (pol->type == type && pol->index == id &&
-		    (mark & pol->mark.m) == pol->mark.v) {
+		    xfrm_policy_mark_match(mark, pol)) {
 			xfrm_pol_hold(pol);
 			if (delete) {
 				*err = security_xfrm_policy_delete(
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 4d19f2ff6e05..73b4e7c0d336 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1238,9 +1238,6 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig)
 
 	memcpy(&x->mark, &orig->mark, sizeof(x->mark));
 
-	if (xfrm_init_state(x) < 0)
-		goto error;
-
 	x->props.flags = orig->props.flags;
 	x->props.extra_flags = orig->props.extra_flags;
 
@@ -1317,6 +1314,11 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (!xc)
 		return NULL;
 
+	xc->props.family = m->new_family;
+
+	if (xfrm_init_state(xc) < 0)
+		goto error;
+
 	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
 	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 48139e1a0ac9..eaed74522197 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1777,7 +1777,6 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct km_event c;
 	int delete;
 	struct xfrm_mark m;
-	u32 mark = xfrm_mark_get(attrs, &m);
 
 	p = nlmsg_data(nlh);
 	delete = nlh->nlmsg_type == XFRM_MSG_DELPOLICY;
@@ -1790,8 +1789,10 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
+	xfrm_mark_get(attrs, &m);
+
 	if (p->index)
-		xp = xfrm_policy_byid(net, mark, type, p->dir, p->index, delete, &err);
+		xp = xfrm_policy_byid(net, &m, type, p->dir, p->index, delete, &err);
 	else {
 		struct nlattr *rt = attrs[XFRMA_SEC_CTX];
 		struct xfrm_sec_ctx *ctx;
@@ -1808,7 +1809,7 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 			if (err)
 				return err;
 		}
-		xp = xfrm_policy_bysel_ctx(net, mark, type, p->dir, &p->sel,
+		xp = xfrm_policy_bysel_ctx(net, &m, type, p->dir, &p->sel,
 					   ctx, delete, &err);
 		security_xfrm_policy_free(ctx);
 	}
@@ -2072,7 +2073,6 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u8 type = XFRM_POLICY_TYPE_MAIN;
 	int err = -ENOENT;
 	struct xfrm_mark m;
-	u32 mark = xfrm_mark_get(attrs, &m);
 
 	err = copy_from_user_policy_type(&type, attrs);
 	if (err)
@@ -2082,8 +2082,10 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 
+	xfrm_mark_get(attrs, &m);
+
 	if (p->index)
-		xp = xfrm_policy_byid(net, mark, type, p->dir, p->index, 0, &err);
+		xp = xfrm_policy_byid(net, &m, type, p->dir, p->index, 0, &err);
 	else {
 		struct nlattr *rt = attrs[XFRMA_SEC_CTX];
 		struct xfrm_sec_ctx *ctx;
@@ -2100,7 +2102,7 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 			if (err)
 				return err;
 		}
-		xp = xfrm_policy_bysel_ctx(net, mark, type, p->dir,
+		xp = xfrm_policy_bysel_ctx(net, &m, type, p->dir,
 					   &p->sel, ctx, 0, &err);
 		security_xfrm_policy_free(ctx);
 	}
diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index dff390f692a2..4435263766ac 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -86,25 +86,31 @@ static struct plugin_info latent_entropy_plugin_info = {
 	.help		= "disable\tturn off latent entropy instrumentation\n",
 };
 
-static unsigned HOST_WIDE_INT seed;
-/*
- * get_random_seed() (this is a GCC function) generates the seed.
- * This is a simple random generator without any cryptographic security because
- * the entropy doesn't come from here.
- */
+static unsigned HOST_WIDE_INT deterministic_seed;
+static unsigned HOST_WIDE_INT rnd_buf[32];
+static size_t rnd_idx = ARRAY_SIZE(rnd_buf);
+static int urandom_fd = -1;
+
 static unsigned HOST_WIDE_INT get_random_const(void)
 {
-	unsigned int i;
-	unsigned HOST_WIDE_INT ret = 0;
-
-	for (i = 0; i < 8 * sizeof(ret); i++) {
-		ret = (ret << 1) | (seed & 1);
-		seed >>= 1;
-		if (ret & 1)
-			seed ^= 0xD800000000000000ULL;
+	if (deterministic_seed) {
+		unsigned HOST_WIDE_INT w = deterministic_seed;
+		w ^= w << 13;
+		w ^= w >> 7;
+		w ^= w << 17;
+		deterministic_seed = w;
+		return deterministic_seed;
 	}
 
-	return ret;
+	if (urandom_fd < 0) {
+		urandom_fd = open("/dev/urandom", O_RDONLY);
+		gcc_assert(urandom_fd >= 0);
+	}
+	if (rnd_idx >= ARRAY_SIZE(rnd_buf)) {
+		gcc_assert(read(urandom_fd, rnd_buf, sizeof(rnd_buf)) == sizeof(rnd_buf));
+		rnd_idx = 0;
+	}
+	return rnd_buf[rnd_idx++];
 }
 
 static tree tree_get_random_const(tree type)
@@ -556,8 +562,6 @@ static void latent_entropy_start_unit(void *gcc_data __unused,
 	tree type, id;
 	int quals;
 
-	seed = get_random_seed(false);
-
 	if (in_lto_p)
 		return;
 
@@ -594,6 +598,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
 
 	struct register_pass_info latent_entropy_pass_info;
 
+	/*
+	 * Call get_random_seed() with noinit=true, so that this returns
+	 * 0 in the case where no seed has been passed via -frandom-seed.
+	 */
+	deterministic_seed = get_random_seed(true);
+
 	latent_entropy_pass_info.pass		= make_latent_entropy_pass();
 	latent_entropy_pass_info.reference_pass_name		= "optimized";
 	latent_entropy_pass_info.ref_pass_instance_number	= 1;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9abcdf2e8dfe..62b0552b7b71 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2147,7 +2147,7 @@ static void add_intree_flag(struct buffer *b, int is_intree)
 /* Cannot check for assembler */
 static void add_retpoline(struct buffer *b)
 {
-	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
 	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
 	buf_printf(b, "#endif\n");
 }
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 56e354fcdfc6..5304dd49e054 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -344,7 +344,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	int rc;
 	struct xfrm_sec_ctx *ctx;
 	char *ctx_str = NULL;
-	int str_len;
+	u32 str_len;
 
 	if (!polsec)
 		return 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 589c1c2ae6db..84ed47195cdd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2567,7 +2567,7 @@ static int smk_ipv6_check(struct smack_known *subject,
 #ifdef CONFIG_AUDIT
 	smk_ad_init_net(&ad, __func__, LSM_AUDIT_DATA_NET, &net);
 	ad.a.u.net->family = PF_INET6;
-	ad.a.u.net->dport = ntohs(address->sin6_port);
+	ad.a.u.net->dport = address->sin6_port;
 	if (act == SMK_RECEIVING)
 		ad.a.u.net->v6info.saddr = address->sin6_addr;
 	else
diff --git a/security/tomoyo/load_policy.c b/security/tomoyo/load_policy.c
index 078fac0bb4c5..6766b92cb572 100644
--- a/security/tomoyo/load_policy.c
+++ b/security/tomoyo/load_policy.c
@@ -23,7 +23,7 @@ static const char *tomoyo_loader;
 static int __init tomoyo_loader_setup(char *str)
 {
 	tomoyo_loader = str;
-	return 0;
+	return 1;
 }
 
 __setup("TOMOYO_loader=", tomoyo_loader_setup);
@@ -62,7 +62,7 @@ static const char *tomoyo_trigger;
 static int __init tomoyo_trigger_setup(char *str)
 {
 	tomoyo_trigger = str;
-	return 0;
+	return 1;
 }
 
 __setup("TOMOYO_trigger=", tomoyo_trigger_setup);
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 53dc37357bca..92519e0477c8 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -412,7 +412,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
 		return 0;
 	width = pcm_formats[(INT)format].phys; /* physical width */
 	pat = pcm_formats[(INT)format].silence;
-	if (! width)
+	if (!width || !pat)
 		return -EINVAL;
 	/* signed or 1 byte data */
 	if (pcm_formats[(INT)format].signd == 1 || width <= 8) {
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 6fa6c268c96d..67a446ce9d3d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1489,21 +1489,25 @@ static int snd_pcm_do_reset(struct snd_pcm_substream *substream, int state)
 	int err = substream->ops->ioctl(substream, SNDRV_PCM_IOCTL1_RESET, NULL);
 	if (err < 0)
 		return err;
+	snd_pcm_stream_lock_irq(substream);
 	runtime->hw_ptr_base = 0;
 	runtime->hw_ptr_interrupt = runtime->status->hw_ptr -
 		runtime->status->hw_ptr % runtime->period_size;
 	runtime->silence_start = runtime->status->hw_ptr;
 	runtime->silence_filled = 0;
+	snd_pcm_stream_unlock_irq(substream);
 	return 0;
 }
 
 static void snd_pcm_post_reset(struct snd_pcm_substream *substream, int state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_stream_lock_irq(substream);
 	runtime->control->appl_ptr = runtime->status->hw_ptr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    runtime->silence_size > 0)
 		snd_pcm_playback_silence(substream, ULONG_MAX);
+	snd_pcm_stream_unlock_irq(substream);
 }
 
 static const struct action_ops snd_pcm_action_reset = {
diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index cce19768f43d..8209856293d3 100644
--- a/sound/firewire/fcp.c
+++ b/sound/firewire/fcp.c
@@ -234,9 +234,7 @@ int fcp_avc_transaction(struct fw_unit *unit,
 	t.response_match_bytes = response_match_bytes;
 	t.state = STATE_PENDING;
 	init_waitqueue_head(&t.wait);
-
-	if (*(const u8 *)command == 0x00 || *(const u8 *)command == 0x03)
-		t.deferrable = true;
+	t.deferrable = (*(const u8 *)command == 0x00 || *(const u8 *)command == 0x03);
 
 	spin_lock_irq(&transactions_lock);
 	list_add_tail(&t.list, &transactions);
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index c67d379cb6d6..9d4a2c66ea16 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -557,7 +557,7 @@ static int snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
 	static int dev;
 	int err;
 	struct snd_card *card;
-	struct pnp_dev *cdev;
+	struct pnp_dev *cdev, *iter;
 	char cid[PNP_ID_LEN];
 
 	if (pnp_device_is_isapnp(pdev))
@@ -573,9 +573,11 @@ static int snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
 	strcpy(cid, pdev->id[0].id);
 	cid[5] = '1';
 	cdev = NULL;
-	list_for_each_entry(cdev, &(pdev->protocol->devices), protocol_list) {
-		if (!strcmp(cdev->id[0].id, cid))
+	list_for_each_entry(iter, &(pdev->protocol->devices), protocol_list) {
+		if (!strcmp(iter->id[0].id, cid)) {
+			cdev = iter;
 			break;
+		}
 	}
 	err = snd_cs423x_card_new(&pdev->dev, dev, &card);
 	if (err < 0)
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index c4840fda44b4..a7f1e4ef3f88 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -958,8 +958,8 @@ static int snd_ac97_ad18xx_pcm_get_volume(struct snd_kcontrol *kcontrol, struct
 	int codec = kcontrol->private_value & 3;
 	
 	mutex_lock(&ac97->page_mutex);
-	ucontrol->value.integer.value[0] = 31 - ((ac97->spec.ad18xx.pcmreg[codec] >> 0) & 31);
-	ucontrol->value.integer.value[1] = 31 - ((ac97->spec.ad18xx.pcmreg[codec] >> 8) & 31);
+	ucontrol->value.integer.value[0] = 31 - ((ac97->spec.ad18xx.pcmreg[codec] >> 8) & 31);
+	ucontrol->value.integer.value[1] = 31 - ((ac97->spec.ad18xx.pcmreg[codec] >> 0) & 31);
 	mutex_unlock(&ac97->page_mutex);
 	return 0;
 }
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 73f593526b2d..0024145a7b5b 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -315,7 +315,6 @@ MODULE_PARM_DESC(joystick_port, "Joystick port address.");
 #define CM_MICGAINZ		0x01	/* mic boost */
 #define CM_MICGAINZ_SHIFT	0
 
-#define CM_REG_MIXER3		0x24
 #define CM_REG_AUX_VOL		0x26
 #define CM_VAUXL_MASK		0xf0
 #define CM_VAUXR_MASK		0x0f
@@ -3323,7 +3322,7 @@ static void snd_cmipci_remove(struct pci_dev *pci)
  */
 static unsigned char saved_regs[] = {
 	CM_REG_FUNCTRL1, CM_REG_CHFORMAT, CM_REG_LEGACY_CTRL, CM_REG_MISC_CTRL,
-	CM_REG_MIXER0, CM_REG_MIXER1, CM_REG_MIXER2, CM_REG_MIXER3, CM_REG_PLL,
+	CM_REG_MIXER0, CM_REG_MIXER1, CM_REG_MIXER2, CM_REG_AUX_VOL, CM_REG_PLL,
 	CM_REG_CH0_FRAME1, CM_REG_CH0_FRAME2,
 	CM_REG_CH1_FRAME1, CM_REG_CH1_FRAME2, CM_REG_EXT_MISC,
 	CM_REG_INT_STATUS, CM_REG_INT_HLDCLR, CM_REG_FUNCTRL0,
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 16e459aedffe..5958aafac8eb 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -296,7 +296,10 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 
 	/* Enable PMC peripheral clock for this SSC */
 	pr_debug("atmel_ssc_dai: Starting clock\n");
-	clk_enable(ssc_p->ssc->clk);
+	ret = clk_enable(ssc_p->ssc->clk);
+	if (ret)
+		return ret;
+
 	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
 
 	/* Reset the SSC unless initialized to keep it in a clean state */
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index d7469cdd90dc..39365319c351 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -226,6 +226,7 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "dai and pcm info missing\n");
+		of_node_put(codec_np);
 		return -EINVAL;
 	}
 	at91sam9g20ek_dai.cpu_of_node = cpu_np;
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 2efc5b41ad0f..6d719392cdbe 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1536,18 +1536,38 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	wm8350_clear_bits(wm8350, WM8350_JACK_DETECT,
 			  WM8350_JDL_ENA | WM8350_JDR_ENA);
 
-	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L,
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L,
 			    wm8350_hpl_jack_handler, 0, "Left jack detect",
 			    priv);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R,
+	if (ret != 0)
+		goto err;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R,
 			    wm8350_hpr_jack_handler, 0, "Right jack detect",
 			    priv);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICSCD,
+	if (ret != 0)
+		goto free_jck_det_l;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICSCD,
 			    wm8350_mic_handler, 0, "Microphone short", priv);
-	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICD,
+	if (ret != 0)
+		goto free_jck_det_r;
+
+	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICD,
 			    wm8350_mic_handler, 0, "Microphone detect", priv);
+	if (ret != 0)
+		goto free_micscd;
 
 	return 0;
+
+free_micscd:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CODEC_MICSCD, priv);
+free_jck_det_r:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R, priv);
+free_jck_det_l:
+	wm8350_free_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L, priv);
+err:
+	return ret;
 }
 
 static int  wm8350_codec_remove(struct snd_soc_codec *codec)
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 384961651904..e5f61f1499c6 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -719,7 +719,9 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return -ENODEV;
-	clk_enable(dev->clk);
+	ret = clk_enable(dev->clk);
+	if (ret)
+		goto err_put_clk;
 
 	dev->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, dev);
@@ -741,6 +743,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	snd_soc_unregister_component(&pdev->dev);
 err_release_clk:
 	clk_disable(dev->clk);
+err_put_clk:
 	clk_put(dev->clk);
 	return ret;
 }
diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 20e7400e2611..5942f9901938 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -93,6 +93,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	if (int_port > MUX_PORT_MAX || int_port == 0) {
 		dev_err(dev, "mux-int-port: hardware only has %d mux ports\n",
 			MUX_PORT_MAX);
+		ret = -EINVAL;
 		goto fail;
 	}
 
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 13631003cb7c..5977a2011d9e 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -442,7 +442,10 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 		* basic clock which should be fast enough for the internal
 		* logic.
 		*/
-		clk_enable(saif->clk);
+		ret = clk_enable(saif->clk);
+		if (ret)
+			return ret;
+
 		ret = clk_set_rate(saif->clk, 24000000);
 		clk_disable(saif->clk);
 		if (ret)
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 2b23ffbac6b1..e8aa93a654e7 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -112,6 +112,9 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 	codec_np = of_parse_phandle(np, "audio-codec", 0);
 	if (!saif_np[0] || !saif_np[1] || !codec_np) {
 		dev_err(&pdev->dev, "phandle missing or invalid\n");
+		of_node_put(codec_np);
+		of_node_put(saif_np[0]);
+		of_node_put(saif_np[1]);
 		return -EINVAL;
 	}
 
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index ead520182e26..29be45285274 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -821,14 +821,27 @@ static int fsi_clk_enable(struct device *dev,
 			return ret;
 		}
 
-		clk_enable(clock->xck);
-		clk_enable(clock->ick);
-		clk_enable(clock->div);
+		ret = clk_enable(clock->xck);
+		if (ret)
+			goto err;
+		ret = clk_enable(clock->ick);
+		if (ret)
+			goto disable_xck;
+		ret = clk_enable(clock->div);
+		if (ret)
+			goto disable_ick;
 
 		clock->count++;
 	}
 
 	return ret;
+
+disable_ick:
+	clk_disable(clock->ick);
+disable_xck:
+	clk_disable(clock->xck);
+err:
+	return ret;
 }
 
 static int fsi_clk_disable(struct device *dev,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0344d4423167..81c3aa167038 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3799,7 +3799,7 @@ static int snd_soc_get_dai_name(struct of_phandle_args *args,
 		if (!component_of_node && pos->dev->parent)
 			component_of_node = pos->dev->parent->of_node;
 
-		if (component_of_node != args->np)
+		if (component_of_node != args->np || !pos->num_dai)
 			continue;
 
 		if (pos->driver->of_xlate_dai_name) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 21b0368c2a3b..878a4fc97f04 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1569,8 +1569,7 @@ static void dapm_seq_run(struct snd_soc_card *card,
 		switch (w->id) {
 		case snd_soc_dapm_pre:
 			if (!w->event)
-				list_for_each_entry_safe_continue(w, n, list,
-								  power_list);
+				continue;
 
 			if (event == SND_SOC_DAPM_STREAM_START)
 				ret = w->event(w,
@@ -1582,8 +1581,7 @@ static void dapm_seq_run(struct snd_soc_card *card,
 
 		case snd_soc_dapm_post:
 			if (!w->event)
-				list_for_each_entry_safe_continue(w, n, list,
-								  power_list);
+				continue;
 
 			if (event == SND_SOC_DAPM_STREAM_START)
 				ret = w->event(w,
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 67d22b4baeb0..61f0c9d6f6dc 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -98,10 +98,10 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	memset(&slave_config, 0, sizeof(slave_config));
 
-	if (!pcm->config)
-		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
-	else
+	if (pcm->config && pcm->config->prepare_slave_config)
 		prepare_slave_config = pcm->config->prepare_slave_config;
+	else
+		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
 
 	if (prepare_slave_config) {
 		ret = prepare_slave_config(substream, params, &slave_config);
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index e2c200c3c135..74968ddee49f 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -328,7 +328,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		mask = BIT(sign_bit + 1) - 1;
 
 	val = ucontrol->value.integer.value[0];
-	if (mc->platform_max && val > mc->platform_max)
+	if (mc->platform_max && ((int)val + min) > mc->platform_max)
 		return -EINVAL;
 	if (val > max - min)
 		return -EINVAL;
@@ -341,7 +341,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	val = val << shift;
 	if (snd_soc_volsw_is_stereo(mc)) {
 		val2 = ucontrol->value.integer.value[1];
-		if (mc->platform_max && val2 > mc->platform_max)
+		if (mc->platform_max && ((int)val2 + min) > mc->platform_max)
 			return -EINVAL;
 		if (val2 > max - min)
 			return -EINVAL;
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 6274a5002647..7528f0d4bddf 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -507,7 +507,8 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 
 	if (hdr->ops.info == SND_SOC_TPLG_CTL_BYTES
 		&& k->iface & SNDRV_CTL_ELEM_IFACE_MIXER
-		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
+		&& (k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READ
+		    || k->access & SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
 		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
 		struct soc_bytes_ext *sbe;
 		struct snd_soc_tplg_bytes_control *be;
diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index fac7e6eb9529..671b4516d930 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -221,7 +221,9 @@ static int snd_at73c213_pcm_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_at73c213_playback_hw;
 	chip->substream = substream;
 
-	clk_enable(chip->ssc->clk);
+	err = clk_enable(chip->ssc->clk);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -787,7 +789,9 @@ static int snd_at73c213_chip_init(struct snd_at73c213 *chip)
 		goto out;
 
 	/* Enable DAC master clock. */
-	clk_enable(chip->board->dac_clk);
+	retval = clk_enable(chip->board->dac_clk);
+	if (retval)
+		goto out;
 
 	/* Initialize at73c213 on SPI bus. */
 	retval = snd_at73c213_write_reg(chip, DAC_RST, 0x04);
@@ -900,7 +904,9 @@ static int snd_at73c213_dev_init(struct snd_card *card,
 	chip->card = card;
 	chip->irq = -1;
 
-	clk_enable(chip->ssc->clk);
+	retval = clk_enable(chip->ssc->clk);
+	if (retval)
+		return retval;
 
 	retval = request_irq(irq, snd_at73c213_interrupt, 0, "at73c213", chip);
 	if (retval) {
@@ -1019,7 +1025,9 @@ static int snd_at73c213_remove(struct spi_device *spi)
 	int retval;
 
 	/* Stop playback. */
-	clk_enable(chip->ssc->clk);
+	retval = clk_enable(chip->ssc->clk);
+	if (retval)
+		goto out;
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXDIS));
 	clk_disable(chip->ssc->clk);
 
@@ -1099,9 +1107,16 @@ static int snd_at73c213_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_at73c213 *chip = card->private_data;
+	int retval;
 
-	clk_enable(chip->board->dac_clk);
-	clk_enable(chip->ssc->clk);
+	retval = clk_enable(chip->board->dac_clk);
+	if (retval)
+		return retval;
+	retval = clk_enable(chip->ssc->clk);
+	if (retval) {
+		clk_disable(chip->board->dac_clk);
+		return retval;
+	}
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXEN));
 
 	return 0;
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index f0b41fee7130..83da676519a8 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1210,6 +1210,7 @@ static void snd_usbmidi_output_drain(struct snd_rawmidi_substream *substream)
 		} while (drain_urbs && timeout);
 		finish_wait(&ep->drain_wait, &wait);
 	}
+	port->active = 0;
 	spin_unlock_irq(&ep->buffer_lock);
 }
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1f2c69e599d9..c94068874ea8 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1879,9 +1879,10 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 		if (unitid == 7 && cval->control == UAC_FU_VOLUME)
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
-	/* lowest playback value is muted on C-Media devices */
-	case USB_ID(0x0d8c, 0x000c):
-	case USB_ID(0x0d8c, 0x0014):
+	/* lowest playback value is muted on some devices */
+	case USB_ID(0x0d8c, 0x000c): /* C-Media */
+	case USB_ID(0x0d8c, 0x0014): /* C-Media */
+	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
 		break;
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 62456a806bb4..4b8f1c46420d 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -22,7 +22,7 @@
  */
 
 /* handling of USB vendor/product ID pairs as 32-bit numbers */
-#define USB_ID(vendor, product) (((vendor) << 16) | (product))
+#define USB_ID(vendor, product) (((unsigned int)(vendor) << 16) | (product))
 #define USB_ID_VENDOR(id) ((id) >> 16)
 #define USB_ID_PRODUCT(id) ((u16)(id))
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index f6d1bc93589c..f032dfed00a9 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -194,7 +194,7 @@
 #define X86_FEATURE_PROC_FEEDBACK ( 7*32+ 9) /* AMD ProcFeedbackInterface */
 
 #define X86_FEATURE_RETPOLINE	( 7*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_AMD ( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_LFENCE	( 7*32+13) /* "" Use LFENCEs for Spectre variant 2 */
 
 #define X86_FEATURE_MSR_SPEC_CTRL ( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
 #define X86_FEATURE_SSBD	( 7*32+17) /* Speculative Store Bypass Disable */
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ac9c477a2a48..46af3bb56142 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -162,7 +162,7 @@ strip-libs = $(filter-out -l%,$(1))
 PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
 PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
-PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
+PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
 FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
 $(OUTPUT)test-libperl.bin:
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 26546892cd54..faab09215c88 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -373,6 +373,7 @@ static void mfd_fail_write(int fd)
 			printf("mmap()+mprotect() didn't fail as expected\n");
 			abort();
 		}
+		munmap(p, mfd_def_size);
 	}
 
 	/* verify PUNCH_HOLE fails */
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index d77ed41b2094..1f89d3dd8295 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -60,6 +60,7 @@
 #include <signal.h>
 #include <poll.h>
 #include <string.h>
+#include <linux/mman.h>
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
index 172d3293fb7b..356689c56397 100755
--- a/tools/testing/selftests/x86/check_cc.sh
+++ b/tools/testing/selftests/x86/check_cc.sh
@@ -7,7 +7,7 @@ CC="$1"
 TESTPROG="$2"
 shift 2
 
-if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
+if [ -n "$CC" ] && $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
     echo 1
 else
     echo 0
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d9b7001227e3..d251b718bf53 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -107,6 +107,8 @@ EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
 static int kvm_debugfs_num_entries;
 static const struct file_operations *stat_fops_per_vm[];
 
+static struct file_operations kvm_chardev_ops;
+
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
@@ -714,6 +716,16 @@ static struct kvm *kvm_create_vm(unsigned long type)
 
 	preempt_notifier_inc();
 
+	/*
+	 * When the fd passed to this ioctl() is opened it pins the module,
+	 * but try_module_get() also prevents getting a reference if the module
+	 * is in MODULE_STATE_GOING (e.g. if someone ran "rmmod --wait").
+	 */
+	if (!try_module_get(kvm_chardev_ops.owner)) {
+		r = -ENODEV;
+		goto out_err;
+	}
+
 	return kvm;
 
 out_err:
@@ -798,6 +810,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	preempt_notifier_dec();
 	hardware_disable_all();
 	mmdrop(mm);
+	module_put(kvm_chardev_ops.owner);
 }
 
 void kvm_get_kvm(struct kvm *kvm)
