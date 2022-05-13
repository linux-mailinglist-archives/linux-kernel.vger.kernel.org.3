Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29938525912
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359720AbiEMAqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359793AbiEMAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC765D27;
        Thu, 12 May 2022 17:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83B79620C0;
        Fri, 13 May 2022 00:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEC8C34113;
        Fri, 13 May 2022 00:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652402783;
        bh=0k+Odk5NVK2HKSKZ0PgKDxynudo39paTLxvWWZTpE2E=;
        h=Date:From:To:Subject:From;
        b=MOEI4+8ho51jNeuqQOWkMeMudvuizriKUcIHUhS6+KUIpzdOJK1UBWW5iqKBFvPPE
         9POkwdRoKHA9dPD8Ovmrn/lQ7PES2X7ajoBWuK1f5LRMZbmFfzMt2cmMSLRD8iuDS2
         Jl6womswgpK6H9zrLq8nLHUJpjnilHvpmYiJCXzrksVZkR6VhFcwLhltdE5hZ5d9gt
         sbcbN8k8/ezOSr5cq3EVpIzRStI6rkYSpPp/0wzYhqX7PNDhh0/GXaWrS74olLbAZh
         K2ovLM1UzWCm8YLKtsidgZ7sy0a7T+3HRAYeWLw35IDplEBkWNnNX3/2olCY+MuBOH
         QuN6va/bnoJJQ==
Date:   Thu, 12 May 2022 17:46:22 -0700
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
