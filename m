Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF50473B93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhLNDg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:36:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40050 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhLNDgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:36:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4485B817DC;
        Tue, 14 Dec 2021 03:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D23C34606;
        Tue, 14 Dec 2021 03:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639453011;
        bh=z2c80QcKklez/XqcVCsof2T8mVMCipGBcFXI1fHxyn8=;
        h=Date:From:To:Subject:From;
        b=ZglfcwZ0SFPxMxXXHVGUX+oKmD9OyhDvrTbclli6BuizTKU/fk2F0VANdRXBH1Ped
         OruC3uXaz5bSrfkaXIiErKSQnhTAw0WK9Etze4TJ2+jDvDxyvBDMW+QpDrKRuLhXy9
         RPceI+KJQNmyOqaWlFTsmdYKBheLcv8ZW1Ibzi5RWB57ZRstIVCaeDA7hwMqZkhoIW
         NdhlxN58W5mW2AwSDMXSsX9AgyqZ66KniZTY1oUcFdqvsFSdjgKVhkZryWsftfFjXW
         nGIiCeBcOpyCI+fozaN+vq7A5ck/priw+sqkP6lZdPRoFHUJ57n66zGvYBaZD2jtox
         WrmBx1RxTUClA==
Date:   Mon, 13 Dec 2021 19:36:49 -0800
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
Subject: [ANNOUNCE] 4.9.291-rt190
Message-ID: <163945186511.352879.8604906764716950082@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.291-rt190 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt-rebase
  Head SHA1: f9605f2ec75d68a5a0741e09bf87342668a24311

Or to build 4.9.291-rt190 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.291.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.291-rt190.patch.xz


You can also build from 4.9.286-rt189 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.286-rt189-rt190.patch.xz

Enjoy!
Mark Gross

Changes from v4.9.286-rt189:
---

Ahmad Fatoum (1):
      watchdog: f71808e_wdt: fix inaccurate report in WDIOC_GETTIMEOUT

Aleksander Jan Bajkowski (2):
      MIPS: lantiq: dma: add small delay after reset
      MIPS: lantiq: dma: reset correct number of channel

Aleksander Morgado (1):
      USB: serial: qcserial: add EM9191 QDL support

Alex Xu (Hello71) (1):
      drm/plane-helper: fix uninitialized variable reference

Alexander Antonov (2):
      perf/x86/intel/uncore: Fix filter_tid mask for CHA events on Skylake Server
      perf/x86/intel/uncore: Fix IIO event constraints for Skylake Server

Alok Prasad (1):
      RDMA/qedr: Fix NULL deref for query_qp on the GSI QP

Anand K Mistry (1):
      perf/x86: Reset destroy callback on event init failure

Anant Thazhemadam (1):
      media: usb: dvd-usb: fix uninit-value bug in dibusb_read_eeprom_byte()

Anatolij Gustschin (1):
      powerpc/5200: dts: fix memory node unit name

Andreas Kemnade (2):
      net: hso: register netdev later to avoid a race condition
      arm: dts: omap3-gta04a4: accelerometer irq fix

André Almeida (1):
      ACPI: battery: Accept charges over the design capacity as full

Andy Shevchenko (2):
      ptp_pch: Load module automatically if ID matches
      serial: 8250_dw: Drop wrong use of ACPI_PTR()

Anel Orazgaliyeva (1):
      cpuidle: Fix kobject memory leaks in error paths

Anssi Hannula (1):
      serial: xilinx_uartps: Fix race condition causing stuck TX

Antoine Tenart (1):
      netfilter: ipvs: make global sysctl readonly in non-init netns

Ard Biesheuvel (1):
      efi/cper: use stack buffer for error record decoding

Arnd Bergmann (9):
      cb710: avoid NULL pointer subtraction
      ethernet: s2io: fix setting mac address during resume
      ARM: 9134/1: remove duplicate memcpy() definition
      ARM: 9139/1: kprobes: fix arch_init_kprobes() prototype
      arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where needed
      hyperv/vmbus: include linux/bitops.h
      ARM: 9136/1: ARMv7-M uses BE-8, not BE-32
      memstick: avoid out-of-range warning
      ARM: 9156/1: drop cc-option fallbacks for architecture selection

Austin Kim (2):
      ALSA: synth: missing check for possible NULL after the call to kstrdup
      evm: mark evm_fixmode as __ro_after_init

Baptiste Lepers (1):
      pnfs/flexfiles: Fix misplaced barrier in nfs4_ff_layout_prepare_ds

Barnabás Pőcze (1):
      platform/x86: wmi: do not fail if disabling fails

Bart Van Assche (1):
      MIPS: sni: Fix the build

Ben Hutchings (1):
      Partially revert "usb: Kconfig: using select for USB_COMMON dependency"

Benjamin Coddington (1):
      NFSD: Keep existing listeners on portlist error

Benjamin Li (1):
      wcn36xx: handle connection loss indication

Brendan Grieve (1):
      ALSA: usb-audio: Provide quirk for Sennheiser GSP670 Headset

Chengfeng Ye (2):
      nfc: pn533: Fix double free when pn533_fill_fragment_skbs() fails
      ALSA: gus: fix null pointer dereference on pointer block

Christian Löhle (1):
      mmc: dw_mmc: Dont wait for DRTO on Write RSP error

Christophe JAILLET (6):
      iio: adc128s052: Fix the error handling path of 'adc128_probe()'
      media: mtk-vpu: Fix a resource leak in the error handling path of 'mtk_vpu_probe()'
      mmc: mxs-mmc: disable regulator on error and in the remove function
      soc/tegra: Fix an error handling path in tegra_powergate_power_up()
      i2c: xlr: Fix a resource leak in the error handling path of 'xlr_i2c_probe()'
      platform/x86: hp_accel: Fix an error handling path in 'lis3lv02d_probe()'

Christophe Leroy (1):
      video: fbdev: chipsfb: use memset_io() instead of memset()

Claudiu Beznea (1):
      dmaengine: at_xdmac: fix AT_XDMAC_CC_PERID() macro

Colin Ian King (2):
      scsi: virtio_scsi: Fix spelling mistake "Unsupport" -> "Unsupported"
      drm/msm: Fix null pointer dereference on pointer edp

Corentin Labbe (1):
      net: mdio-mux: fix unbalanced put_device

Damien Le Moal (1):
      libata: fix read log timeout value

Dan Carpenter (10):
      iio: ssp_sensors: add more range checking in ssp_parse_dataframe()
      iio: ssp_sensors: fix error code in ssp_print_mcu_debug()
      pata_legacy: fix a couple uninitialized variable bugs
      drm/msm/dsi: fix off by one in dsi_bus_clk_enable error handling
      b43legacy: fix a lower bounds test
      b43: fix a lower bounds test
      memstick: jmb38x_ms: use appropriate free function in jmb38x_ms_alloc_host()
      drm/msm: uninitialized variable in msm_gem_import()
      usb: gadget: hid: fix error code in do_config()
      scsi: csiostor: Uninitialized data in csio_ln_vnp_read_cbfn()

Daniel Jordan (1):
      crypto: pcrypt - Delay write to padata->info

Daniele Palmas (1):
      USB: serial: option: add Telit LE910Cx composition 0x1204

David Hildenbrand (1):
      s390/gmap: don't unconditionally call pte_unmap_unlock() in __gmap_zap()

Dirk Bender (1):
      media: mt9p031: Fix corrupted frame after restarting stream

Dmitry Osipenko (1):
      soc/tegra: pmc: Fix imbalanced clock disabling in error code path

Dongli Zhang (2):
      xen/netfront: stop tx queues during live migration
      vmxnet3: do not stop tx queues after netif_device_detach()

Dongliang Mu (3):
      usb: hso: fix error handling code of hso_create_net_device
      JFS: fix memleak in jfs_mount
      memory: fsl_ifc: fix leak of irq and nand_irq in fsl_ifc_ctrl_probe

Eiichi Tsukata (1):
      vsock: prevent unnecessary refcnt inc for nonblocking connect

Eric Badger (1):
      EDAC/sb_edac: Fix top-of-high-memory value for Broadwell/Haswell

Eric Dumazet (5):
      net_sched: fix NULL deref in fifo_set_limit()
      net: bridge: use nla_total_size_64bit() in br_get_linkxstats_size()
      netlink: annotate data races around nlk->bound
      rtnetlink: fix if_nlmsg_stats_size() under estimation
      llc: fix out-of-bound array index in llc_sk_dev_hash()

Eric W. Biederman (2):
      signal: Remove the bogus sigkill_pending in ptrace_stop
      signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT

Erik Ekman (1):
      sfc: Don't use netif_info before net_device setup

Evgeny Novikov (1):
      mtd: spi-nor: hisi-sfc: Remove excessive clk_disable_unprepare()

Filipe Manana (1):
      btrfs: fix lost error handling when replaying directory deletes

Florian Westphal (1):
      netfilter: nfnetlink_queue: fix OOB when mac header was cleared

Geert Uytterhoeven (2):
      usb: gadget: Mark USB_FSL_QE broken on 64-bit
      auxdisplay: img-ascii-lcd: Fix lock-up when displaying empty string

Giovanni Cabiddu (2):
      crypto: qat - detect PFVF collision after ACK
      crypto: qat - disregard spurious PFVF interrupts

Greg Kroah-Hartman (5):
      Linux 4.9.287
      Linux 4.9.288
      Linux 4.9.289
      Linux 4.9.290
      Linux 4.9.291

Guanghui Feng (1):
      tty: tty_buffer: Fix the softlockup issue in flush_to_ldisc

Guenter Roeck (2):
      xtensa: xtfpga: Try software restart before simulating CPU reset
      nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST

Guo Zhi (1):
      scsi: advansys: Fix kernel pointer leak

Gustavo A. R. Silva (1):
      IB/qib: Use struct_size() helper

Hans de Goede (2):
      power: supply: bq27xxx: Fix kernel crash on IRQ handler register error
      ACPI: PMIC: Fix intel_pmic_regs_handler() read accesses

Helge Deller (1):
      parisc: Fix ptrace check on syscall return

Henrik Grimler (1):
      power: supply: max17042_battery: use VFSOC for capacity when no rsns

Herve Codina (1):
      ARM: dts: spear3xx: Fix gmac node

Huang Guobin (1):
      bonding: Fix a use-after-free problem when bond_sysfs_slave_add() failed

Ingmar Klein (1):
      PCI: Mark Atheros QCA6174 to avoid bus reset

Jackie Liu (2):
      ARM: s3c: irq-s3c24xx: Fix return value check for s3c24xx_init_intc()
      MIPS: loongson64: make CPU_LOONGSON64 depends on MIPS_FP_SUPPORT

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the finding clock sample value

Jakob Hauser (1):
      power: supply: rt5033_battery: Change voltage values to µV

Jakub Kicinski (1):
      net: stream: don't purge sk_error_queue in sk_stream_kill_queues()

James Buren (1):
      usb-storage: Add compatibility quirk flags for iODD 2531/2541

James Smart (1):
      scsi: lpfc: Fix list_add() corruption in lpfc_drain_txq()

Jan Kara (3):
      ocfs2: fix data corruption after conversion from inline format
      isofs: Fix out of bound access for corrupted isofs image
      ocfs2: fix data corruption on truncate

Jeremy Sowden (1):
      netfilter: ip6_tables: zero-initialize fragment offset

Jia-Ju Bai (1):
      fs: orangefs: fix error return code of orangefs_revalidate_lookup()

Jiapeng Chong (1):
      scsi: ses: Fix unsigned comparison with less than zero

Jiri Benc (1):
      i40e: fix endless loop under rtnl

Jiri Valek - 2N (1):
      iio: light: opt3001: Fixed timeout error when 0 lux

Johan Hovold (22):
      USB: cdc-acm: fix racy tty buffer accesses
      USB: cdc-acm: fix break reporting
      mmc: vub300: fix control-message timeouts
      net: lan78xx: fix division by zero in send path
      comedi: dt9812: fix DMA buffers on stack
      comedi: ni_usb6501: fix NULL-deref in command paths
      comedi: vmk80xx: fix transfer-buffer overflows
      comedi: vmk80xx: fix bulk-buffer overflow
      comedi: vmk80xx: fix bulk and interrupt message timeouts
      staging: r8712u: fix control-message timeout
      staging: rtl8192u: fix control-message timeouts
      rsi: fix control-message timeout
      ALSA: ua101: fix division by zero at probe
      ALSA: 6fire: fix control and bulk message timeouts
      ALSA: line6: fix control and interrupt message timeouts
      mwifiex: fix division by zero in fw download path
      ath6kl: fix division by zero in send path
      ath6kl: fix control-message timeout
      rtl8187: fix control-message timeouts
      USB: iowarrior: fix control-message timeouts
      USB: chipidea: fix interrupt deadlock
      drm/udl: fix control-message timeout

Johannes Berg (1):
      iwlwifi: mvm: disable RX-diversity in powersave

Jonas Dreßler (2):
      mwifiex: Read a PCI register after writing the TX ring write pointer
      mwifiex: Send DELBA requests according to spec

Juergen Gross (1):
      Revert "x86/kvm: fix vcpu-id indexed array sizes"

Junji Wei (1):
      RDMA/rxe: Fix wrong port_cap_flags

Kai Vehmanen (1):
      ALSA: hda: avoid write to STATESTS if controller is in reset

Kalesh Singh (1):
      tracing/cfi: Fix cmp_entries_* functions signature mismatch

Kees Cook (1):
      media: si470x: Avoid card name truncation

Kirill A. Shutemov (1):
      mm/zsmalloc: Prepare to variable MAX_PHYSMEM_BITS

Krzysztof Kozlowski (3):
      nfc: port100: fix using -ERRNO as command type mask
      regulator: s5m8767: do not use reset value as DVS voltage if GPIO DVS is disabled
      regulator: dt-bindings: samsung,s5m8767: correct s5m8767,pmic-buck-default-dvs-idx property

Lars-Peter Clausen (1):
      dmaengine: dmaengine_desc_callback_valid(): Check for `callback_result`

Lasse Collin (2):
      lib/xz: Avoid overlapping memcpy() with invalid input with in-place decompression
      lib/xz: Validate the value before assigning it to an enum variable

Leon Romanovsky (1):
      RDMA/mlx4: Return missed an error if device doesn't support steering

Lin Ma (3):
      nfc: nci: fix the UAF of rf_conn_info object
      NFC: reorganize the functions in nci_request
      NFC: reorder the logic in nfc_{un,}register_device

Linus Lüssing (4):
      ath9k: Fix potential interrupt storm on queue reset
      batman-adv: Fix own OGM check in aggregated OGMs
      batman-adv: mcast: fix duplicate mcast packets in BLA backbone from LAN
      batman-adv: mcast: fix duplicate mcast packets from BLA backbone to mesh

Linus Torvalds (1):
      gup: document and work around "COW can break either way" issue

Loic Poulain (1):
      wcn36xx: Fix HT40 capability for 2Ghz band

Lorenz Bauer (1):
      bpf: Prevent increasing bpf_jit_limit above max

Lu Wei (1):
      maple: fix wrong return value of maple_bus_init().

Lukas Bulwahn (1):
      elfcore: correct reference to CONFIG_UML

Marek Behún (2):
      PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG
      PCI: aardvark: Don't spam about PIO Response Status

Mark Gross (2):
      Linux stable update merge from linux-stable.git v4.9.291 into rt-stable v4.9-rt  (4.9.286-rt189)
      Linux 4.9.291-rt190

Mark Rutland (1):
      irq: mips: avoid nested irq_enter()

Masami Hiramatsu (1):
      ARM: clang: Do not rely on lr register for stacktrace

Mathias Nyman (1):
      xhci: Fix USB 3.1 enumeration issues by increasing roothub power-on-good delay

Matthew Wilcox (Oracle) (1):
      vfs: check fd has read access in kernel_read_file_from_fd()

Max Filippov (2):
      xtensa: call irqchip_init only when CONFIG_USE_OF is selected
      xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF

Maxim Kiselev (1):
      net: davinci_emac: Fix interrupt pacing disable

Miaohe Lin (1):
      mm/zsmalloc.c: close race window between zs_pool_dec_isolated() and zs_unregister_migration()

Michael Cullen (1):
      Input: xpad - add support for another USB ID of Nacon GC-100

Michael Ellerman (1):
      powerpc/dcr: Use cmplwi instead of 3-argument cmpli

Michal Hocko (1):
      mm, oom: do not trigger out_of_memory from the #PF

Mike Christie (2):
      scsi: target: Fix ordered tag handling
      scsi: target: Fix alua_tg_pt_gps_count tracking

Mike Marciniszyn (1):
      IB/qib: Protect from buffer overflow in struct qib_user_sdma_pkt fields

Ming Lei (1):
      scsi: core: Put LLD module refcnt after SCSI device is released

Mizuho Mori (1):
      HID: apple: Fix logical maximum and usage maximum of Magic Keyboard JIS

Nanyong Sun (1):
      net: encx24j600: check error in devm_regmap_init_encx24j600

Nathan Chancellor (3):
      ARM: 8819/1: Remove '-p' from LDFLAGS
      platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
      hexagon: export raw I/O routines for modules

Naveen N. Rao (3):
      powerpc/bpf: Fix BPF_MOD when imm == 1
      powerpc/bpf: Validate branch ranges
      powerpc/bpf: Fix BPF_SUB when imm == 0x80000000

Nguyen Dinh Phi (1):
      cfg80211: call cfg80211_stop_ap when switch from P2P_GO type

Nick Desaulniers (3):
      ARM: 9122/1: select HAVE_FUTEX_CMPXCHG
      ARM: 9133/1: mm: proc-macros: ensure *_tlb_fns are 4B aligned
      sh: check return code of request_irq

Nicolas Dichtel (1):
      tun: fix bonding active backup with arp monitoring

Nikolay Borisov (1):
      btrfs: fix memory ordering between normal and ordered work functions

Nikolay Martynov (1):
      xhci: Enable trust tx length quirk for Fresco FL11 USB controller

Oleksij Rempel (1):
      ARM: imx6: disable the GIC CPU interface before calling stby-poweroff sequence

Oliver Neukum (1):
      usbnet: sanity check for maxpacket

Pali Rohár (3):
      powerpc/fsl/dts: Fix phy-connection-type for fm1mac3
      serial: core: Fix initializing and restoring termios speed
      PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros

Pavel Skripkin (6):
      phy: mdio: fix memory leak
      Revert "net: mdiobus: Fix memory leak in __mdiobus_register"
      net: batman-adv: fix error handling
      ALSA: mixer: fix deadlock in snd_mixer_oss_set_volume
      media: dvb-usb: fix ununit-value in az6027_rc_query
      net: bnx2x: fix variable dereferenced before check

Pawan Gupta (1):
      smackfs: Fix use-after-free in netlbl_catmap_walk()

Pekka Korpinen (1):
      iio: dac: ad5446: Fix ad5622_write() return value

Peter Zijlstra (2):
      locking/lockdep: Avoid RCU-induced noinstr fail
      x86: Increase exception stack sizes

Petr Mladek (1):
      printk/console: Allow to disable console output by using console="" or console=null

Phoenix Huang (1):
      Input: elantench - fix misreporting trackpoint coordinates

Prashant Malani (1):
      platform/x86: intel_scu_ipc: Update timeout value in comment

Quinn Tran (1):
      scsi: qla2xxx: Turn off target reset during issue_lip

Rafael J. Wysocki (1):
      ACPICA: Avoid evaluating methods too early during system resume

Rajat Asthana (1):
      media: mceusb: return without resubmitting URB in case of -EPROTO error.

Randy Dunlap (8):
      NIOS2: irqflags: rename a redefined register name
      mmc: winbond: don't build on M68K
      ia64: don't do IA64_CMPXCHG_DEBUG without CONFIG_PRINTK
      m68k: set a default value for MEMORY_RESERVE
      sh: fix kconfig unmet dependency warning for FRAME_POINTER
      sh: define __BIG_ENDIAN for math-emu
      mips: BCM63XX: ensure that CPU_SUPPORTS_32BIT_KERNEL is set
      mips: bcm63xx: add support for clk_get_parent()

Ricardo Ribalda (1):
      media: uvcvideo: Set capability in s_param

Roberto Sassu (1):
      s390: fix strrchr() implementation

Roger Quadros (2):
      ARM: dts: omap3430-sdp: Fix NAND device node
      ARM: dts: omap: fix gpmc,mux-add-data type

Rustam Kovhaev (1):
      mm: kmemleak: slob: respect SLAB_NOLEAKTRACE flag

Sean Christopherson (1):
      x86/irq: Ensure PI wakeup handler is unregistered before module unload

Sean Young (1):
      media: ite-cir: IR receiver stop working after receive overflow

Sebastian Krzyszkowiak (1):
      power: supply: max17042_battery: Prevent int underflow in set_soc_threshold

Shawn Guo (1):
      mmc: sdhci: Map more voltage level to SDHCI_POWER_330

Stefan Agner (1):
      phy: micrel: ksz8041nl: do not use power down mode

Stephane Grosjean (1):
      can: peak_usb: pcan_usb_fd_decode_status(): fix back to ERROR_ACTIVE state notification

Stephen Boyd (1):
      nvmem: Fix shift-out-of-bound (UBSAN) with byte size cells

Steven Rostedt (VMware) (2):
      tracing: Have all levels of checks prevent recursion
      tracefs: Have tracefs directories not set OTH permission bits by default

Surabhi Boob (1):
      iavf: Fix for the false positive ASQ/ARQ errors while issuing VF reset

Sven Eckelmann (5):
      ath10k: fix max antenna gain unit
      batman-adv: Keep fragments equally sized
      batman-adv: Consider fragmentation for needed_headroom
      batman-adv: Reserve needed_*room for fragments
      batman-adv: Don't always reallocate the fragmentation skb head

Sven Schnelle (4):
      parisc: fix warning in flush_tlb_all
      parisc/kgdb: add kgdb_roundup() to make kgdb work with idle polling
      parisc/entry: fix trace test in syscall exit path
      parisc/sticon: fix reverse colors

Takashi Iwai (7):
      ALSA: seq: Fix a potential UAF by wrong private_free call order
      ASoC: DAPM: Fix missing kctl change notifications
      Input: i8042 - Add quirk for Fujitsu Lifebook T725
      ALSA: timer: Unconditionally unlink slave instances, too
      ALSA: mixer: oss: Fix racy access to slots
      Bluetooth: sco: Fix lock_sock() blockage by memcpy_from_msg()
      ASoC: DAPM: Cover regression by kctl change notification fix

Tatsuhiko Yasumatsu (1):
      bpf: Fix integer overflow in prealloc_elems_and_freelist()

Tetsuo Handa (2):
      smackfs: use __GFP_NOFAIL for smk_cipso_doi()
      smackfs: use netlbl_cfg_cipsov4_del() for deleting cipso_v4_doi

Thomas Gleixner (1):
      PCI/MSI: Destroy sysfs before freeing entries

Thomas Perrot (1):
      spi: spl022: fix Microwire full duplex mode

Tiezhu Yang (1):
      samples/kretprobes: Fix return value if register_kretprobe() failed

Todd Kjos (2):
      binder: use euid from cred instead of using task
      binder: use cred instead of task for selinux checks

Tong Zhang (1):
      scsi: dc395: Fix error case unwinding

Trevor Woerner (1):
      net: nxp: lpc_eth.c: avoid hang when bringing interface down

Trond Myklebust (1):
      nfsd4: Handle the NFSv4 READDIR 'dircount' hint being zero

Tuo Li (2):
      media: s5p-mfc: fix possible null-pointer dereference in s5p_mfc_probe()
      ath: dfs_pattern_detector: Fix possible null-pointer dereference in channel_detector_create()

Uwe Kleine-König (1):
      usb: max-3421: Use driver data instead of maintaining a list of bound devices

Valentin Vidic (1):
      ocfs2: mount fails with buffer overflow in strlen

Vasily Averin (1):
      mm, oom: pagefault_out_of_memory: don't force global OOM for dying tasks

Vegard Nossum (4):
      net: arc: select CRC32
      net: korina: select CRC32
      r8152: select CRC32 and CRYPTO/CRYPTO_HASH/CRYPTO_SHA256
      netfilter: Kconfig: use 'default y' instead of 'm' for bool config option

Vincent Donnefort (1):
      sched/core: Mitigate race cpus_share_cache()/update_top_cache_domain()

Viraj Shah (1):
      usb: musb: Balance list entry in musb_gadget_queue

Waiman Long (1):
      cgroup: Make rebind_subsystems() disable v2 controllers all at once

Walter Stoll (1):
      watchdog: Fix OMAP watchdog early handling

Wang Hai (4):
      usbnet: fix error return code in usbnet_probe()
      USB: serial: keyspan: fix memleak on probe errors
      libertas_tf: Fix possible memory leak in probe and disconnect
      libertas: Fix possible memory leak in probe and disconnect

Wang Kefeng (1):
      ARM: 9120/1: Revert "amba: make use of -1 IRQs warn"

Wang ShaoBo (1):
      Bluetooth: fix use-after-free error in lock_sock_nested()

Wang Wensheng (1):
      ALSA: timer: Fix use-after-free problem

Xiaolong Huang (1):
      isdn: cpai: check ctr->cnr to avoid array index out of bound

Xiaoming Ni (1):
      powerpc/85xx: Fix oops when mpc85xx_smp_guts_ids node cannot be found

Xin Long (2):
      sctp: use init_tag from inithdr for ABORT chunk
      sctp: add vtag check in sctp_sf_violation

Yanfei Xu (1):
      net: mdiobus: Fix memory leak in __mdiobus_register

Yang Yingliang (6):
      drm/nouveau/debugfs: fix file release memory leak
      regmap: Fix possible double-free in regcache_rbtree_exit()
      spi: bcm-qspi: Fix missing clk_disable_unprepare() on error in bcm_qspi_probe()
      hwmon: Fix possible memleak in __hwmon_device_register()
      usb: musb: tusb6010: check return value after calling platform_get_resource()
      usb: host: ohci-tmio: check return value after calling platform_get_resource()

Ye Bin (1):
      PM: hibernate: Get block device exclusively in swsusp_check()

Yoshihiro Shimoda (1):
      can: rcar_can: fix suspend/resume

YueHaibing (2):
      mac80211: Drop frames from invalid MAC address in ad-hoc mode
      xen-pciback: Fix return in pm_ctrl_init()

Zev Weiss (1):
      hwmon: (pmbus/lm25066) Add offset coefficients

Zhang Jianhua (1):
      efi: Change down_interruptible() in virt_efi_reset_system() to down_trylock()

Zhang Yi (2):
      quota: check block number when reading the block in quota file
      quota: correct error number in free_dqentry()

Zheng Liang (1):
      ovl: fix missing negative dentry check in ovl_rename()

Zheyu Ma (6):
      can: peak_pci: peak_pci_remove(): fix UAF
      isdn: mISDN: Fix sleeping function called from invalid context
      ata: sata_mv: Fix the error handling of mv_chip_id()
      media: netup_unidvb: handle interrupt properly according to the firmware
      memstick: r592: Fix a UAF bug when removing the driver
      mwl8k: Fix use-after-free in mwl8k_fw_state_machine()

Ziyang Xuan (3):
      nfc: fix error handling of nfc_proto_register()
      NFC: digital: fix possible memory leak in digital_tg_listen_mdaa()
      NFC: digital: fix possible memory leak in digital_in_send_sdd_req()

hongao (1):
      drm/amdgpu: fix set scaling mode Full/Full aspect/Center not works on vga and dvi connectors
---
.../bindings/regulator/samsung,s5m8767.txt         |  23 ++---
 Makefile                                           |   2 +-
 arch/arc/include/asm/pgtable.h                     |   2 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/Makefile                                  |  24 ++---
 arch/arm/boot/bootp/Makefile                       |   2 +-
 arch/arm/boot/compressed/Makefile                  |   2 -
 arch/arm/boot/compressed/decompress.c              |   3 +
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi          |   2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi  |   2 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
 arch/arm/boot/dts/spear3xx.dtsi                    |   2 +-
 arch/arm/include/asm/pgtable-2level.h              |   2 +
 arch/arm/include/asm/pgtable-3level.h              |   2 +
 arch/arm/kernel/stacktrace.c                       |   3 +-
 arch/arm/mach-imx/pm-imx6.c                        |   2 +
 arch/arm/mm/Kconfig                                |   2 +-
 arch/arm/mm/proc-macros.S                          |   1 +
 arch/arm/probes/kprobes/core.c                     |   2 +-
 arch/hexagon/lib/io.c                              |   4 +
 arch/ia64/Kconfig.debug                            |   2 +-
 arch/m68k/Kconfig.machine                          |   1 +
 arch/mips/Kconfig                                  |   4 +
 arch/mips/bcm63xx/clk.c                            |   6 ++
 arch/mips/include/asm/pgtable-32.h                 |   3 +
 arch/mips/kernel/r2300_fpu.S                       |   4 +-
 arch/mips/kernel/syscall.c                         |   9 --
 arch/mips/lantiq/xway/dma.c                        |  14 ++-
 arch/mips/sni/time.c                               |   4 +-
 arch/nios2/include/asm/irqflags.h                  |   4 +-
 arch/nios2/include/asm/registers.h                 |   2 +-
 arch/nios2/platform/Kconfig.platform               |   1 +
 arch/parisc/kernel/entry.S                         |   4 +-
 arch/parisc/kernel/smp.c                           |  19 +++-
 arch/parisc/mm/init.c                              |   4 +-
 arch/powerpc/boot/dts/charon.dts                   |   2 +-
 arch/powerpc/boot/dts/digsy_mtc.dts                |   2 +-
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |   2 +-
 arch/powerpc/boot/dts/lite5200.dts                 |   2 +-
 arch/powerpc/boot/dts/lite5200b.dts                |   2 +-
 arch/powerpc/boot/dts/media5200.dts                |   2 +-
 arch/powerpc/boot/dts/mpc5200b.dtsi                |   2 +-
 arch/powerpc/boot/dts/o2d.dts                      |   2 +-
 arch/powerpc/boot/dts/o2d.dtsi                     |   2 +-
 arch/powerpc/boot/dts/o2dnt2.dts                   |   2 +-
 arch/powerpc/boot/dts/o3dnt.dts                    |   2 +-
 arch/powerpc/boot/dts/pcm032.dts                   |   2 +-
 arch/powerpc/boot/dts/tqm5200.dts                  |   2 +-
 arch/powerpc/include/asm/pte-common.h              |   2 +
 arch/powerpc/net/bpf_jit.h                         |  25 +++--
 arch/powerpc/net/bpf_jit_comp64.c                  |  47 ++++++---
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c       |   3 +-
 arch/powerpc/sysdev/dcr-low.S                      |   2 +-
 arch/s390/lib/string.c                             |  15 ++-
 arch/s390/mm/gmap.c                                |   5 +-
 arch/sh/Kconfig.debug                              |   1 +
 arch/sh/include/asm/sfp-machine.h                  |   8 ++
 arch/sh/kernel/cpu/sh4a/smp-shx3.c                 |   5 +-
 arch/x86/events/core.c                             |   1 +
 arch/x86/events/intel/uncore_snbep.c               |   4 +
 arch/x86/include/asm/page_64_types.h               |   2 +-
 arch/x86/include/asm/pgtable-3level_types.h        |   1 +
 arch/x86/kernel/irq.c                              |   4 +-
 arch/x86/kvm/ioapic.c                              |   2 +-
 arch/x86/kvm/ioapic.h                              |   4 +-
 arch/xtensa/kernel/irq.c                           |   2 +-
 arch/xtensa/platforms/xtfpga/setup.c               |  12 ++-
 crypto/pcrypt.c                                    |  12 ++-
 drivers/acpi/acpica/acglobal.h                     |   2 +
 drivers/acpi/acpica/hwesleep.c                     |   8 +-
 drivers/acpi/acpica/hwsleep.c                      |  11 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   7 ++
 drivers/acpi/battery.c                             |   2 +-
 drivers/acpi/pmic/intel_pmic.c                     |  51 ++++-----
 drivers/amba/bus.c                                 |   3 -
 drivers/android/binder.c                           |  23 +++--
 drivers/ata/libata-eh.c                            |   8 ++
 drivers/ata/pata_legacy.c                          |   6 +-
 drivers/ata/sata_mv.c                              |   4 +-
 drivers/auxdisplay/img-ascii-lcd.c                 |  10 ++
 drivers/base/regmap/regcache-rbtree.c              |   7 +-
 drivers/cpuidle/sysfs.c                            |   5 +-
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c      |  13 +++
 drivers/crypto/qat/qat_common/adf_vf_isr.c         |   6 ++
 drivers/dma/at_xdmac.c                             |   2 +-
 drivers/dma/dmaengine.h                            |   2 +-
 drivers/edac/sb_edac.c                             |   2 +-
 drivers/firmware/efi/cper.c                        |   4 +-
 drivers/firmware/efi/runtime-wrappers.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   1 +
 drivers/gpu/drm/drm_plane_helper.c                 |   1 -
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   2 +-
 drivers/gpu/drm/msm/edp/edp_ctrl.c                 |   3 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   4 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |   1 +
 drivers/gpu/drm/udl/udl_connector.c                |   2 +-
 drivers/hid/hid-apple.c                            |   7 ++
 drivers/hv/hyperv_vmbus.h                          |   1 +
 drivers/hwmon/hwmon.c                              |   6 +-
 drivers/hwmon/pmbus/lm25066.c                      |  23 +++++
 drivers/i2c/busses/i2c-xlr.c                       |   6 +-
 drivers/iio/adc/ti-adc128s052.c                    |   6 ++
 drivers/iio/common/ssp_sensors/ssp_spi.c           |  11 +-
 drivers/iio/dac/ad5446.c                           |   9 +-
 drivers/iio/light/opt3001.c                        |   6 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   4 +-
 drivers/infiniband/hw/qedr/verbs.c                 |  15 +--
 drivers/infiniband/hw/qib/qib_user_sdma.c          |  35 +++++--
 drivers/infiniband/sw/rxe/rxe_param.h              |   2 +-
 drivers/input/joystick/xpad.c                      |   2 +
 drivers/input/mouse/elantech.c                     |  13 +++
 drivers/input/serio/i8042-x86ia64io.h              |  14 +++
 drivers/irqchip/irq-bcm6345-l1.c                   |   2 +-
 drivers/irqchip/irq-s3c24xx.c                      |  22 +++-
 drivers/isdn/capi/kcapi.c                          |   5 +
 drivers/isdn/hardware/mISDN/netjet.c               |   2 +-
 drivers/media/i2c/mt9p031.c                        |  28 ++++-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |  27 +++--
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |   5 +-
 drivers/media/platform/s5p-mfc/s5p_mfc.c           |   2 +-
 drivers/media/radio/si470x/radio-si470x-i2c.c      |   2 +-
 drivers/media/radio/si470x/radio-si470x-usb.c      |   2 +-
 drivers/media/rc/ite-cir.c                         |   2 +-
 drivers/media/rc/mceusb.c                          |   1 +
 drivers/media/usb/dvb-usb/az6027.c                 |   1 +
 drivers/media/usb/dvb-usb/dibusb-common.c          |   2 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |   7 +-
 drivers/memory/fsl_ifc.c                           |  13 ++-
 drivers/memstick/core/ms_block.c                   |   2 +-
 drivers/memstick/host/jmb38x_ms.c                  |   2 +-
 drivers/memstick/host/r592.c                       |   8 +-
 drivers/misc/cb710/sgbuf2.c                        |   2 +-
 drivers/mmc/host/Kconfig                           |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  14 +++
 drivers/mmc/host/dw_mmc.c                          |   3 +-
 drivers/mmc/host/mxs-mmc.c                         |  10 ++
 drivers/mmc/host/sdhci.c                           |   6 ++
 drivers/mmc/host/vub300.c                          |  18 ++--
 drivers/mtd/spi-nor/hisi-sfc.c                     |   1 -
 drivers/net/bonding/bond_sysfs_slave.c             |  36 ++-----
 drivers/net/can/rcar/rcar_can.c                    |  20 ++--
 drivers/net/can/sja1000/peak_pci.c                 |   9 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c         |   5 +-
 drivers/net/ethernet/Kconfig                       |   1 +
 drivers/net/ethernet/arc/Kconfig                   |   1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_init_ops.h   |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   2 +-
 drivers/net/ethernet/microchip/encx24j600-regmap.c |  10 +-
 drivers/net/ethernet/microchip/encx24j600.c        |   5 +-
 drivers/net/ethernet/microchip/encx24j600_hw.h     |   4 +-
 drivers/net/ethernet/neterion/s2io.c               |   2 +-
 drivers/net/ethernet/nxp/lpc_eth.c                 |   5 +-
 drivers/net/ethernet/sfc/ptp.c                     |   4 +-
 drivers/net/ethernet/sfc/siena_sriov.c             |   2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |  16 ++-
 drivers/net/phy/mdio-mux.c                         |   6 +-
 drivers/net/phy/mdio_bus.c                         |   7 ++
 drivers/net/phy/micrel.c                           |   5 +-
 drivers/net/tun.c                                  |   5 +
 drivers/net/usb/Kconfig                            |   4 +
 drivers/net/usb/hso.c                              |  45 +++++---
 drivers/net/usb/lan78xx.c                          |   6 ++
 drivers/net/usb/usbnet.c                           |   5 +
 drivers/net/vmxnet3/vmxnet3_drv.c                  |   1 -
 drivers/net/wireless/ath/ath10k/mac.c              |   6 +-
 drivers/net/wireless/ath/ath10k/wmi.h              |   3 +
 drivers/net/wireless/ath/ath6kl/usb.c              |   7 +-
 drivers/net/wireless/ath/ath9k/main.c              |   4 +-
 drivers/net/wireless/ath/dfs_pattern_detector.c    |  10 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |   4 +-
 drivers/net/wireless/ath/wcn36xx/smd.c             |  44 ++++++--
 drivers/net/wireless/broadcom/b43/phy_g.c          |   2 +-
 drivers/net/wireless/broadcom/b43legacy/radio.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   3 +
 drivers/net/wireless/marvell/libertas/if_usb.c     |   2 +
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   2 +
 drivers/net/wireless/marvell/mwifiex/11n.c         |   5 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |   8 ++
 drivers/net/wireless/marvell/mwifiex/usb.c         |  16 +++
 drivers/net/wireless/marvell/mwl8k.c               |   2 +-
 .../net/wireless/realtek/rtl818x/rtl8187/rtl8225.c |  14 +--
 drivers/net/wireless/rsi/rsi_91x_usb.c             |   2 +-
 drivers/net/xen-netfront.c                         |   8 ++
 drivers/nfc/pn533/pn533.c                          |   6 +-
 drivers/nfc/port100.c                              |   4 +-
 drivers/nvmem/core.c                               |   3 +-
 drivers/pci/host/pci-aardvark.c                    |   9 +-
 drivers/pci/msi.c                                  |  24 ++---
 drivers/pci/quirks.c                               |   1 +
 drivers/platform/x86/hp_accel.c                    |   2 +
 drivers/platform/x86/intel_scu_ipc.c               |   2 +-
 drivers/platform/x86/thinkpad_acpi.c               |   2 +-
 drivers/platform/x86/wmi.c                         |   9 +-
 drivers/power/supply/bq27xxx_battery_i2c.c         |   3 +-
 drivers/power/supply/max17042_battery.c            |   8 +-
 drivers/power/supply/rt5033_battery.c              |   2 +-
 drivers/ptp/ptp_pch.c                              |   1 +
 drivers/regulator/s5m8767.c                        |  21 ++--
 drivers/scsi/advansys.c                            |   4 +-
 drivers/scsi/csiostor/csio_lnode.c                 |   2 +-
 drivers/scsi/dc395x.c                              |   1 +
 drivers/scsi/lpfc/lpfc_sli.c                       |   1 +
 drivers/scsi/qla2xxx/qla_gbl.h                     |   2 -
 drivers/scsi/qla2xxx/qla_mr.c                      |  23 -----
 drivers/scsi/qla2xxx/qla_os.c                      |  27 +----
 drivers/scsi/scsi.c                                |   4 +-
 drivers/scsi/scsi_sysfs.c                          |   9 ++
 drivers/scsi/ses.c                                 |   2 +-
 drivers/scsi/virtio_scsi.c                         |   4 +-
 drivers/sh/maple/maple.c                           |   5 +-
 drivers/soc/tegra/pmc.c                            |   4 +-
 drivers/spi/spi-bcm-qspi.c                         |   5 +-
 drivers/spi/spi-pl022.c                            |   5 +-
 drivers/staging/comedi/drivers/dt9812.c            | 115 +++++++++++++++------
 drivers/staging/comedi/drivers/ni_usb6501.c        |  10 ++
 drivers/staging/comedi/drivers/vmk80xx.c           |  28 ++---
 drivers/staging/rtl8192u/r8192U_core.c             |  18 ++--
 drivers/staging/rtl8712/usb_ops_linux.c            |   2 +-
 drivers/target/target_core_alua.c                  |   1 -
 drivers/target/target_core_device.c                |   2 +
 drivers/target/target_core_internal.h              |   1 +
 drivers/target/target_core_transport.c             |  76 ++++++++++----
 drivers/tty/serial/8250/8250_dw.c                  |   2 +-
 drivers/tty/serial/serial_core.c                   |  16 ++-
 drivers/tty/serial/xilinx_uartps.c                 |   3 +-
 drivers/tty/tty_buffer.c                           |   3 +
 drivers/usb/Kconfig                                |   3 +-
 drivers/usb/chipidea/core.c                        |  21 ++--
 drivers/usb/class/cdc-acm.c                        |   8 ++
 drivers/usb/gadget/legacy/hid.c                    |   4 +-
 drivers/usb/gadget/udc/Kconfig                     |   1 +
 drivers/usb/host/max3421-hcd.c                     |  25 +----
 drivers/usb/host/ohci-tmio.c                       |   2 +-
 drivers/usb/host/xhci-hub.c                        |   3 +-
 drivers/usb/host/xhci-pci.c                        |   2 +
 drivers/usb/misc/iowarrior.c                       |   8 +-
 drivers/usb/musb/musb_gadget.c                     |   4 +-
 drivers/usb/musb/tusb6010.c                        |   5 +
 drivers/usb/serial/keyspan.c                       |  15 ++-
 drivers/usb/serial/option.c                        |   2 +
 drivers/usb/serial/qcserial.c                      |   1 +
 drivers/usb/storage/unusual_devs.h                 |  10 ++
 drivers/video/console/sticon.c                     |  12 +--
 drivers/video/fbdev/chipsfb.c                      |   2 +-
 drivers/watchdog/f71808e_wdt.c                     |   4 +-
 drivers/watchdog/omap_wdt.c                        |   6 +-
 drivers/xen/xen-pciback/conf_space_capability.c    |   2 +-
 fs/btrfs/async-thread.c                            |  14 +++
 fs/btrfs/tree-log.c                                |   4 +-
 fs/exec.c                                          |   2 +-
 fs/isofs/inode.c                                   |   2 +
 fs/jfs/jfs_mount.c                                 |  51 ++++-----
 fs/nfs/flexfilelayout/flexfilelayoutdev.c          |   4 +-
 fs/nfs/pnfs_nfs.c                                  |   4 +-
 fs/nfsd/nfs4xdr.c                                  |  19 ++--
 fs/nfsd/nfsctl.c                                   |   5 +-
 fs/ocfs2/alloc.c                                   |  46 +++------
 fs/ocfs2/file.c                                    |   8 +-
 fs/ocfs2/super.c                                   |  14 ++-
 fs/orangefs/dcache.c                               |   4 +-
 fs/overlayfs/dir.c                                 |  10 +-
 fs/quota/quota_tree.c                              |  15 +++
 fs/tracefs/inode.c                                 |   3 +-
 include/asm-generic/pgtable.h                      |  13 +++
 include/linux/console.h                            |   2 +
 include/linux/elfcore.h                            |   2 +-
 include/linux/filter.h                             |   1 +
 include/linux/libata.h                             |   2 +-
 include/linux/lsm_hooks.h                          |  32 +++---
 include/linux/security.h                           |  28 ++---
 include/net/llc.h                                  |   4 +-
 include/target/target_core_base.h                  |   6 +-
 include/uapi/linux/pci_regs.h                      |   6 ++
 kernel/bpf/core.c                                  |   4 +-
 kernel/bpf/stackmap.c                              |   3 +-
 kernel/cgroup.c                                    |  31 +++++-
 kernel/locking/lockdep.c                           |   2 +-
 kernel/power/swap.c                                |   5 +-
 kernel/printk/printk.c                             |   9 +-
 kernel/sched/core.c                                |   3 +
 kernel/signal.c                                    |  17 +--
 kernel/trace/ftrace.c                              |   4 +-
 kernel/trace/trace.h                               |  64 ++++--------
 kernel/trace/trace_functions.c                     |   2 +-
 kernel/trace/tracing_map.c                         |  40 ++++---
 lib/decompress_unxz.c                              |   2 +-
 lib/xz/xz_dec_lzma2.c                              |  21 +++-
 lib/xz/xz_dec_stream.c                             |   6 +-
 localversion-rt                                    |   2 +-
 mm/gup.c                                           |  48 +++++++--
 mm/huge_memory.c                                   |   7 +-
 mm/oom_kill.c                                      |  23 ++---
 mm/slab.h                                          |   2 +-
 mm/zsmalloc.c                                      |  20 ++--
 net/batman-adv/bat_v_ogm.c                         |  11 +-
 net/batman-adv/bridge_loop_avoidance.c             | 111 ++++++++++++++++----
 net/batman-adv/fragmentation.c                     |  42 +++++---
 net/batman-adv/hard-interface.c                    |   3 +
 net/batman-adv/main.c                              |  56 +++++++---
 net/batman-adv/multicast.c                         |  31 ++++++
 net/batman-adv/multicast.h                         |  15 +++
 net/batman-adv/network-coding.c                    |   4 +-
 net/batman-adv/soft-interface.c                    |   5 +-
 net/batman-adv/translation-table.c                 |   4 +-
 net/bluetooth/l2cap_sock.c                         |  10 +-
 net/bluetooth/sco.c                                |  24 +++--
 net/bridge/br_netlink.c                            |   2 +-
 net/core/rtnetlink.c                               |   2 +-
 net/core/stream.c                                  |   3 -
 net/core/sysctl_net_core.c                         |   2 +-
 net/ipv6/netfilter/ip6_tables.c                    |   1 +
 net/mac80211/rx.c                                  |   3 +-
 net/netfilter/Kconfig                              |   2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   5 +
 net/netfilter/nfnetlink_queue.c                    |   2 +-
 net/netlink/af_netlink.c                           |  14 ++-
 net/nfc/af_nfc.c                                   |   3 +
 net/nfc/core.c                                     |  32 +++---
 net/nfc/digital_core.c                             |   9 +-
 net/nfc/digital_technology.c                       |   8 +-
 net/nfc/nci/core.c                                 |  11 +-
 net/nfc/nci/rsp.c                                  |   2 +
 net/sched/sch_fifo.c                               |   3 +
 net/sctp/sm_statefuns.c                            |   4 +
 net/vmw_vsock/af_vsock.c                           |   2 +
 net/wireless/util.c                                |   1 +
 samples/kprobes/kretprobe_example.c                |   2 +-
 security/integrity/evm/evm_main.c                  |   2 +-
 security/security.c                                |  14 +--
 security/selinux/hooks.c                           |  31 +++---
 security/smack/smackfs.c                           |  11 +-
 sound/core/oss/mixer_oss.c                         |  43 ++++++--
 sound/core/seq/seq_device.c                        |   8 +-
 sound/core/timer.c                                 |  17 ++-
 sound/hda/hdac_controller.c                        |   5 +-
 sound/isa/gus/gus_dma.c                            |   2 +
 sound/soc/soc-dapm.c                               |  38 +++++--
 sound/synth/emux/emux.c                            |   2 +-
 sound/usb/6fire/comm.c                             |   2 +-
 sound/usb/6fire/firmware.c                         |   6 +-
 sound/usb/line6/driver.c                           |  14 +--
 sound/usb/line6/driver.h                           |   2 +-
 sound/usb/line6/podhd.c                            |   6 +-
 sound/usb/line6/toneport.c                         |   2 +-
 sound/usb/misc/ua101.c                             |   4 +-
 sound/usb/quirks-table.h                           |  32 ++++++
 348 files changed, 2072 insertions(+), 1076 deletions(-)
---
diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
index 093edda0c8dfc..6cd83d920155f 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
+++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
@@ -13,6 +13,14 @@ common regulator binding documented in:
 
 
 Required properties of the main device node (the parent!):
+ - s5m8767,pmic-buck-ds-gpios: GPIO specifiers for three host gpio's used
+   for selecting GPIO DVS lines. It is one-to-one mapped to dvs gpio lines.
+
+ [1] If either of the 's5m8767,pmic-buck[2/3/4]-uses-gpio-dvs' optional
+     property is specified, then all the eight voltage values for the
+     's5m8767,pmic-buck[2/3/4]-dvs-voltage' should be specified.
+
+Optional properties of the main device node (the parent!):
  - s5m8767,pmic-buck2-dvs-voltage: A set of 8 voltage values in micro-volt (uV)
    units for buck2 when changing voltage using gpio dvs. Refer to [1] below
    for additional information.
@@ -25,26 +33,13 @@ Required properties of the main device node (the parent!):
    units for buck4 when changing voltage using gpio dvs. Refer to [1] below
    for additional information.
 
- - s5m8767,pmic-buck-ds-gpios: GPIO specifiers for three host gpio's used
-   for selecting GPIO DVS lines. It is one-to-one mapped to dvs gpio lines.
-
- [1] If none of the 's5m8767,pmic-buck[2/3/4]-uses-gpio-dvs' optional
-     property is specified, the 's5m8767,pmic-buck[2/3/4]-dvs-voltage'
-     property should specify atleast one voltage level (which would be a
-     safe operating voltage).
-
-     If either of the 's5m8767,pmic-buck[2/3/4]-uses-gpio-dvs' optional
-     property is specified, then all the eight voltage values for the
-     's5m8767,pmic-buck[2/3/4]-dvs-voltage' should be specified.
-
-Optional properties of the main device node (the parent!):
  - s5m8767,pmic-buck2-uses-gpio-dvs: 'buck2' can be controlled by gpio dvs.
  - s5m8767,pmic-buck3-uses-gpio-dvs: 'buck3' can be controlled by gpio dvs.
  - s5m8767,pmic-buck4-uses-gpio-dvs: 'buck4' can be controlled by gpio dvs.
 
 Additional properties required if either of the optional properties are used:
 
- - s5m8767,pmic-buck234-default-dvs-idx: Default voltage setting selected from
+ - s5m8767,pmic-buck-default-dvs-idx: Default voltage setting selected from
    the possible 8 options selectable by the dvs gpios. The value of this
    property should be between 0 and 7. If not specified or if out of range, the
    default value of this property is set to 0.
diff --git a/Makefile b/Makefile
index 68f2c6f3869e2..fa41ff3c7cc38 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 286
+SUBLEVEL = 291
 EXTRAVERSION =
 NAME = Roaring Lionus
 
diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index c10f5cb203e61..81198a6773c60 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -137,8 +137,10 @@
 
 #ifdef CONFIG_ARC_HAS_PAE40
 #define PTE_BITS_NON_RWX_IN_PD1	(0xff00000000 | PAGE_MASK | _PAGE_CACHEABLE)
+#define MAX_POSSIBLE_PHYSMEM_BITS 40
 #else
 #define PTE_BITS_NON_RWX_IN_PD1	(PAGE_MASK | _PAGE_CACHEABLE)
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
 #endif
 
 /**************************************************************************
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c11b811ace4d4..d60ade16ef513 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -55,6 +55,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
+	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 975b110e7d87a..1f9747cbc86c0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -13,7 +13,7 @@
 # Ensure linker flags are correct
 LDFLAGS		:=
 
-LDFLAGS_vmlinux	:=-p --no-undefined -X --pic-veneer
+LDFLAGS_vmlinux	:= --no-undefined -X --pic-veneer
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux	+= --be8
 LDFLAGS_MODULE	+= --be8
@@ -64,15 +64,15 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
-arch-$(CONFIG_CPU_32v7M)	=-D__LINUX_ARM_ARCH__=7 -march=armv7-m -Wa,-march=armv7-m
-arch-$(CONFIG_CPU_32v7)		=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
-arch-$(CONFIG_CPU_32v6)		=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
+arch-$(CONFIG_CPU_32v7M)	=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
+arch-$(CONFIG_CPU_32v7)		=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
+arch-$(CONFIG_CPU_32v6)		=-D__LINUX_ARM_ARCH__=6 -march=armv6
 # Only override the compiler option if ARMv6. The ARMv6K extensions are
 # always available in ARMv7
 ifeq ($(CONFIG_CPU_32v6),y)
-arch-$(CONFIG_CPU_32v6K)	=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6k,-march=armv5t -Wa$(comma)-march=armv6k)
+arch-$(CONFIG_CPU_32v6K)	=-D__LINUX_ARM_ARCH__=6 -march=armv6k
 endif
-arch-$(CONFIG_CPU_32v5)		=-D__LINUX_ARM_ARCH__=5 $(call cc-option,-march=armv5te,-march=armv4t)
+arch-$(CONFIG_CPU_32v5)		=-D__LINUX_ARM_ARCH__=5 -march=armv5te
 arch-$(CONFIG_CPU_32v4T)	=-D__LINUX_ARM_ARCH__=4 -march=armv4t
 arch-$(CONFIG_CPU_32v4)		=-D__LINUX_ARM_ARCH__=4 -march=armv4
 arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3
@@ -86,7 +86,7 @@ tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM740T)	=-mtune=arm7tdmi
 tune-$(CONFIG_CPU_ARM9TDMI)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM940T)	=-mtune=arm9tdmi
-tune-$(CONFIG_CPU_ARM946E)	=$(call cc-option,-mtune=arm9e,-mtune=arm9tdmi)
+tune-$(CONFIG_CPU_ARM946E)	=-mtune=arm9e
 tune-$(CONFIG_CPU_ARM920T)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM922T)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_ARM925T)	=-mtune=arm9tdmi
@@ -94,11 +94,11 @@ tune-$(CONFIG_CPU_ARM926T)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_FA526)	=-mtune=arm9tdmi
 tune-$(CONFIG_CPU_SA110)	=-mtune=strongarm110
 tune-$(CONFIG_CPU_SA1100)	=-mtune=strongarm1100
-tune-$(CONFIG_CPU_XSCALE)	=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
-tune-$(CONFIG_CPU_XSC3)		=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
-tune-$(CONFIG_CPU_FEROCEON)	=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
-tune-$(CONFIG_CPU_V6)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
-tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
+tune-$(CONFIG_CPU_XSCALE)	=-mtune=xscale
+tune-$(CONFIG_CPU_XSC3)		=-mtune=xscale
+tune-$(CONFIG_CPU_FEROCEON)	=-mtune=xscale
+tune-$(CONFIG_CPU_V6)		=-mtune=arm1136j-s
+tune-$(CONFIG_CPU_V6K)		=-mtune=arm1136j-s
 
 # Evaluate tune cc-option calls now
 tune-y := $(tune-y)
diff --git a/arch/arm/boot/bootp/Makefile b/arch/arm/boot/bootp/Makefile
index 5e4acd253b300..8d1e31b4ba941 100644
--- a/arch/arm/boot/bootp/Makefile
+++ b/arch/arm/boot/bootp/Makefile
@@ -7,7 +7,7 @@
 
 GCOV_PROFILE	:= n
 
-LDFLAGS_bootp	:=-p --no-undefined -X \
+LDFLAGS_bootp	:= --no-undefined -X \
 		 --defsym initrd_phys=$(INITRD_PHYS) \
 		 --defsym params_phys=$(PARAMS_PHYS) -T
 AFLAGS_initrd.o :=-DINITRD=\"$(INITRD)\"
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2f3ba4d9683c3..561dbc0ee2ba0 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -128,8 +128,6 @@ endif
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
-# ?
-LDFLAGS_vmlinux += -p
 # Report unresolved symbol references
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index a0765e7ed6c7d..b0255cbf3b766 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -46,7 +46,10 @@ extern char * strstr(const char * s1, const char *s2);
 #endif
 
 #ifdef CONFIG_KERNEL_XZ
+/* Prevent KASAN override of string helpers in decompressor */
+#undef memmove
 #define memmove memmove
+#undef memcpy
 #define memcpy memcpy
 #include "../../../../lib/decompress_unxz.c"
 #endif
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
index 73e272fadc202..58d288fddd9c2 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
@@ -28,7 +28,7 @@
 		compatible = "smsc,lan9221","smsc,lan9115";
 		bank-width = <2>;
 
-		gpmc,mux-add-data;
+		gpmc,mux-add-data = <0>;
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <42>;
 		gpmc,cs-wr-off-ns = <36>;
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 7191506934494..338ee6bd0e0c0 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -352,7 +352,7 @@
 		compatible = "bosch,bma180";
 		reg = <0x41>;
 		pinctrl-names = "default";
-		pintcrl-0 = <&bma180_pins>;
+		pinctrl-0 = <&bma180_pins>;
 		interrupt-parent = <&gpio4>;
 		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>; /* GPIO_115 */
 	};
diff --git a/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
index 82e98ee3023ad..3dbeb7a6c569c 100644
--- a/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
@@ -25,7 +25,7 @@
 		compatible = "smsc,lan9221","smsc,lan9115";
 		bank-width = <2>;
 
-		gpmc,mux-add-data;
+		gpmc,mux-add-data = <0>;
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <42>;
 		gpmc,cs-wr-off-ns = <36>;
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index abd6921143beb..e0ba97bd41b79 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -104,7 +104,7 @@
 
 	nand@1,0 {
 		compatible = "ti,omap2-nand";
-		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		reg = <1 0 4>; /* CS1, offset 0, IO size 4 */
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
diff --git a/arch/arm/boot/dts/spear3xx.dtsi b/arch/arm/boot/dts/spear3xx.dtsi
index 118135d758990..4e4166d96b264 100644
--- a/arch/arm/boot/dts/spear3xx.dtsi
+++ b/arch/arm/boot/dts/spear3xx.dtsi
@@ -53,7 +53,7 @@
 		};
 
 		gmac: eth@e0800000 {
-			compatible = "st,spear600-gmac";
+			compatible = "snps,dwmac-3.40a";
 			reg = <0xe0800000 0x8000>;
 			interrupts = <23 22>;
 			interrupt-names = "macirq", "eth_wake_irq";
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 92fd2c8a9af06..6154902bed83d 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -78,6 +78,8 @@
 #define PTE_HWTABLE_OFF		(PTE_HWTABLE_PTRS * sizeof(pte_t))
 #define PTE_HWTABLE_SIZE	(PTRS_PER_PTE * sizeof(u32))
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	32
+
 /*
  * PMD_SHIFT determines the size of the area a second-level page table can map
  * PGDIR_SHIFT determines what a third-level page table entry can map
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 2a029bceaf2f8..35807e611b6e0 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -37,6 +37,8 @@
 #define PTE_HWTABLE_OFF		(0)
 #define PTE_HWTABLE_SIZE	(PTRS_PER_PTE * sizeof(u64))
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 40
+
 /*
  * PGDIR_SHIFT determines the size a top-level page table entry can map.
  */
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 6e8a50de40e2b..c10c1de244eba 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -51,8 +51,7 @@ int notrace unwind_frame(struct stackframe *frame)
 
 	frame->sp = frame->fp;
 	frame->fp = *(unsigned long *)(fp);
-	frame->pc = frame->lr;
-	frame->lr = *(unsigned long *)(fp + 4);
+	frame->pc = *(unsigned long *)(fp + 4);
 #else
 	/* check current frame pointer is within bounds */
 	if (fp < low + 12 || fp > high - 4)
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 6da26692f2fde..950c9f2ffe005 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/genalloc.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/of.h>
@@ -606,6 +607,7 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 
 static void imx6_pm_stby_poweroff(void)
 {
+	gic_cpu_if_down(0);
 	imx6_set_lpm(STOP_POWER_OFF);
 	imx6q_suspend_finish(0);
 
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7f3760fa9c154..93623627a0b68 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -731,7 +731,7 @@ config CPU_BIG_ENDIAN
 config CPU_ENDIAN_BE8
 	bool
 	depends on CPU_BIG_ENDIAN
-	default CPU_V6 || CPU_V6K || CPU_V7
+	default CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
 	help
 	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.
 
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 796e8f675a936..422162f1b9802 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -343,6 +343,7 @@ ENTRY(\name\()_cache_fns)
 
 .macro define_tlb_functions name:req, flags_up:req, flags_smp
 	.type	\name\()_tlb_fns, #object
+	.align 2
 ENTRY(\name\()_tlb_fns)
 	.long	\name\()_flush_user_tlb_range
 	.long	\name\()_flush_kern_tlb_range
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index c3362ddd6c4cb..bc7a5dbaf423f 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -666,7 +666,7 @@ static struct undef_hook kprobes_arm_break_hook = {
 
 #endif /* !CONFIG_THUMB2_KERNEL */
 
-int __init arch_init_kprobes()
+int __init arch_init_kprobes(void)
 {
 	arm_probes_decode_init();
 #ifdef CONFIG_THUMB2_KERNEL
diff --git a/arch/hexagon/lib/io.c b/arch/hexagon/lib/io.c
index 885c9626d5e08..e5dfed1cf151b 100644
--- a/arch/hexagon/lib/io.c
+++ b/arch/hexagon/lib/io.c
@@ -40,6 +40,7 @@ void __raw_readsw(const void __iomem *addr, void *data, int len)
 		*dst++ = *src;
 
 }
+EXPORT_SYMBOL(__raw_readsw);
 
 /*
  * __raw_writesw - read words a short at a time
@@ -60,6 +61,7 @@ void __raw_writesw(void __iomem *addr, const void *data, int len)
 
 
 }
+EXPORT_SYMBOL(__raw_writesw);
 
 /*  Pretty sure len is pre-adjusted for the length of the access already */
 void __raw_readsl(const void __iomem *addr, void *data, int len)
@@ -75,6 +77,7 @@ void __raw_readsl(const void __iomem *addr, void *data, int len)
 
 
 }
+EXPORT_SYMBOL(__raw_readsl);
 
 void __raw_writesl(void __iomem *addr, const void *data, int len)
 {
@@ -89,3 +92,4 @@ void __raw_writesl(void __iomem *addr, const void *data, int len)
 
 
 }
+EXPORT_SYMBOL(__raw_writesl);
diff --git a/arch/ia64/Kconfig.debug b/arch/ia64/Kconfig.debug
index de9d507ba0fd4..ee6c7f75f479d 100644
--- a/arch/ia64/Kconfig.debug
+++ b/arch/ia64/Kconfig.debug
@@ -41,7 +41,7 @@ config DISABLE_VHPT
 
 config IA64_DEBUG_CMPXCHG
 	bool "Turn on compare-and-exchange bug checking (slow!)"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  Selecting this option turns on bug checking for the IA-64
 	  compare-and-exchange instructions.  This is slow!  Itaniums
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 2a5c7abb2896e..f622c3ccafc31 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -184,6 +184,7 @@ config INIT_LCD
 config MEMORY_RESERVE
 	int "Memory reservation (MiB)"
 	depends on (UCSIMM || UCDIMM)
+	default 0
 	help
 	  Reserve certain memory regions on 68x328 based boards.
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ef0a95d46d592..8a7d2f1f40d0a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -267,6 +267,9 @@ config BCM63XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
+	select SYS_HAS_CPU_BMIPS32_3300
+	select SYS_HAS_CPU_BMIPS4350
+	select SYS_HAS_CPU_BMIPS4380
 	select SWAP_IO_SPACE
 	select GPIOLIB
 	select HAVE_CLK
@@ -1373,6 +1376,7 @@ config CPU_LOONGSON3
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_PGD_C0_CONTEXT
 	select MIPS_L1_CACHE_SHIFT_6
+	select MIPS_FP_SUPPORT
 	select GPIOLIB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index b49fc9cb9cad2..4f375050ab8e9 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -336,6 +336,12 @@ void clk_disable(struct clk *clk)
 
 EXPORT_SYMBOL(clk_disable);
 
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
 unsigned long clk_get_rate(struct clk *clk)
 {
 	return clk->rate;
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index c0be540e83cb3..2c6df5a92e1e4 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -110,6 +110,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 #if defined(CONFIG_XPA)
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 40
 #define pte_pfn(x)		(((unsigned long)((x).pte_high >> _PFN_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
 static inline pte_t
 pfn_pte(unsigned long pfn, pgprot_t prot)
@@ -125,6 +126,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 
 #elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 36
 #define pte_pfn(x)		((unsigned long)((x).pte_high >> 6))
 
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
@@ -139,6 +141,7 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 
 #else
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
 #ifdef CONFIG_CPU_VR41XX
 #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index 918f2f6d3861a..ca34767280791 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -27,8 +27,8 @@
 #define EX2(a,b)						\
 9:	a,##b;							\
 	.section __ex_table,"a";				\
-	PTR	9b,bad_stack;					\
-	PTR	9b+4,bad_stack;					\
+	PTR	9b,fault;					\
+	PTR	9b+4,fault;					\
 	.previous
 
 	.set	noreorder
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 4234b2d726c55..67d3cba60c9fa 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -244,12 +244,3 @@ SYSCALL_DEFINE3(cachectl, char *, addr, int, nbytes, int, op)
 {
 	return -ENOSYS;
 }
-
-/*
- * If we ever come here the user sp is bad.  Zap the process right away.
- * Due to the bad stack signaling wouldn't work.
- */
-asmlinkage void bad_stack(void)
-{
-	do_exit(SIGSEGV);
-}
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index cef811755123f..fc9eff29d8ff0 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 
 #include <lantiq_soc.h>
@@ -39,6 +40,7 @@
 #define LTQ_DMA_PCTRL		0x44
 #define LTQ_DMA_IRNEN		0xf4
 
+#define DMA_ID_CHNR		GENMASK(26, 20)	/* channel number */
 #define DMA_DESCPT		BIT(3)		/* descriptor complete irq */
 #define DMA_TX			BIT(8)		/* TX channel direction */
 #define DMA_CHAN_ON		BIT(0)		/* channel on / off bit */
@@ -49,7 +51,6 @@
 #define DMA_POLL		BIT(31)		/* turn on channel polling */
 #define DMA_CLK_DIV4		BIT(6)		/* polling clock divider */
 #define DMA_2W_BURST		BIT(1)		/* 2 word burst length */
-#define DMA_MAX_CHANNEL		20		/* the soc has 20 channels */
 #define DMA_ETOP_ENDIANNESS	(0xf << 8) /* endianness swap etop channels */
 #define DMA_WEIGHT	(BIT(17) | BIT(16))	/* default channel wheight */
 
@@ -216,7 +217,7 @@ ltq_dma_init(struct platform_device *pdev)
 {
 	struct clk *clk;
 	struct resource *res;
-	unsigned id;
+	unsigned int id, nchannels;
 	int i;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -232,21 +233,24 @@ ltq_dma_init(struct platform_device *pdev)
 	clk_enable(clk);
 	ltq_dma_w32_mask(0, DMA_RESET, LTQ_DMA_CTRL);
 
+	usleep_range(1, 10);
+
 	/* disable all interrupts */
 	ltq_dma_w32(0, LTQ_DMA_IRNEN);
 
 	/* reset/configure each channel */
-	for (i = 0; i < DMA_MAX_CHANNEL; i++) {
+	id = ltq_dma_r32(LTQ_DMA_ID);
+	nchannels = ((id & DMA_ID_CHNR) >> 20);
+	for (i = 0; i < nchannels; i++) {
 		ltq_dma_w32(i, LTQ_DMA_CS);
 		ltq_dma_w32(DMA_CHAN_RST, LTQ_DMA_CCTRL);
 		ltq_dma_w32(DMA_POLL | DMA_CLK_DIV4, LTQ_DMA_CPOLL);
 		ltq_dma_w32_mask(DMA_CHAN_ON, 0, LTQ_DMA_CCTRL);
 	}
 
-	id = ltq_dma_r32(LTQ_DMA_ID);
 	dev_info(&pdev->dev,
 		"Init done - hw rev: %X, ports: %d, channels: %d\n",
-		id & 0x1f, (id >> 16) & 0xf, id >> 20);
+		id & 0x1f, (id >> 16) & 0xf, nchannels);
 
 	return 0;
 }
diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 7ee14f41fc25d..1ea060f08ffea 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -17,14 +17,14 @@ static int a20r_set_periodic(struct clock_event_device *evt)
 {
 	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 12) = 0x34;
 	wmb();
-	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 0) = SNI_COUNTER0_DIV;
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 0) = SNI_COUNTER0_DIV & 0xff;
 	wmb();
 	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 0) = SNI_COUNTER0_DIV >> 8;
 	wmb();
 
 	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 12) = 0xb4;
 	wmb();
-	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 8) = SNI_COUNTER2_DIV;
+	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 8) = SNI_COUNTER2_DIV & 0xff;
 	wmb();
 	*(volatile u8 *)(A20R_PT_CLOCK_BASE + 8) = SNI_COUNTER2_DIV >> 8;
 	wmb();
diff --git a/arch/nios2/include/asm/irqflags.h b/arch/nios2/include/asm/irqflags.h
index 75ab92e639f85..0338fcb88203c 100644
--- a/arch/nios2/include/asm/irqflags.h
+++ b/arch/nios2/include/asm/irqflags.h
@@ -22,7 +22,7 @@
 
 static inline unsigned long arch_local_save_flags(void)
 {
-	return RDCTL(CTL_STATUS);
+	return RDCTL(CTL_FSTATUS);
 }
 
 /*
@@ -31,7 +31,7 @@ static inline unsigned long arch_local_save_flags(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	WRCTL(CTL_STATUS, flags);
+	WRCTL(CTL_FSTATUS, flags);
 }
 
 static inline void arch_local_irq_disable(void)
diff --git a/arch/nios2/include/asm/registers.h b/arch/nios2/include/asm/registers.h
index 615bce19b546e..33824f2ad1ab7 100644
--- a/arch/nios2/include/asm/registers.h
+++ b/arch/nios2/include/asm/registers.h
@@ -24,7 +24,7 @@
 #endif
 
 /* control register numbers */
-#define CTL_STATUS	0
+#define CTL_FSTATUS	0
 #define CTL_ESTATUS	1
 #define CTL_BSTATUS	2
 #define CTL_IENABLE	3
diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
index d3e5df9fb36bd..78ffc0bf4ebed 100644
--- a/arch/nios2/platform/Kconfig.platform
+++ b/arch/nios2/platform/Kconfig.platform
@@ -37,6 +37,7 @@ config NIOS2_DTB_PHYS_ADDR
 
 config NIOS2_DTB_SOURCE_BOOL
 	bool "Compile and link device tree into kernel image"
+	depends on !COMPILE_TEST
 	default n
 	help
 	  This allows you to specify a dts (device tree source) file
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index 63b140bde2a3a..ad20414b7fb5d 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -1849,8 +1849,8 @@ syscall_restore:
 	LDREG	TI_TASK-THREAD_SZ_ALGN-FRAME_SIZE(%r30),%r1
 
 	/* Are we being ptraced? */
-	ldw	TASK_FLAGS(%r1),%r19
-	ldi	_TIF_SYSCALL_TRACE_MASK,%r2
+	LDREG	TI_FLAGS-THREAD_SZ_ALGN-FRAME_SIZE(%r30),%r19
+	ldi	_TIF_SINGLESTEP|_TIF_BLOCKSTEP,%r2
 	and,COND(=)	%r19,%r2,%r0
 	b,n	syscall_restore_rfi
 
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index 75dab2871346c..af966c1c922ff 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/bitops.h>
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
+#include <linux/kgdb.h>
 
 #include <linux/atomic.h>
 #include <asm/current.h>
@@ -74,7 +75,10 @@ enum ipi_message_type {
 	IPI_CALL_FUNC,
 	IPI_CPU_START,
 	IPI_CPU_STOP,
-	IPI_CPU_TEST
+	IPI_CPU_TEST,
+#ifdef CONFIG_KGDB
+	IPI_ENTER_KGDB,
+#endif
 };
 
 
@@ -170,7 +174,12 @@ ipi_interrupt(int irq, void *dev_id)
 			case IPI_CPU_TEST:
 				smp_debug(100, KERN_DEBUG "CPU%d is alive!\n", this_cpu);
 				break;
-
+#ifdef CONFIG_KGDB
+			case IPI_ENTER_KGDB:
+				smp_debug(100, KERN_DEBUG "CPU%d ENTER_KGDB\n", this_cpu);
+				kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
+				break;
+#endif
 			default:
 				printk(KERN_CRIT "Unknown IPI num on CPU%d: %lu\n",
 					this_cpu, which);
@@ -226,6 +235,12 @@ send_IPI_allbutself(enum ipi_message_type op)
 	}
 }
 
+#ifdef CONFIG_KGDB
+void kgdb_roundup_cpus(void)
+{
+	send_IPI_allbutself(IPI_ENTER_KGDB);
+}
+#endif
 
 inline void 
 smp_send_stop(void)	{ send_IPI_allbutself(IPI_CPU_STOP); }
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index dbbe3932f833c..7bdc449615e85 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -940,9 +940,9 @@ void flush_tlb_all(void)
 {
 	int do_recycle;
 
-	__inc_irq_stat(irq_tlb_count);
 	do_recycle = 0;
 	spin_lock(&sid_lock);
+	__inc_irq_stat(irq_tlb_count);
 	if (dirty_space_ids > RECYCLE_THRESHOLD) {
 	    BUG_ON(recycle_inuse);  /* FIXME: Use a semaphore/wait queue here */
 	    get_dirty_sids(&recycle_ndirty,recycle_dirty_array);
@@ -961,8 +961,8 @@ void flush_tlb_all(void)
 #else
 void flush_tlb_all(void)
 {
-	__inc_irq_stat(irq_tlb_count);
 	spin_lock(&sid_lock);
+	__inc_irq_stat(irq_tlb_count);
 	flush_tlb_all_local(NULL);
 	recycle_sids();
 	spin_unlock(&sid_lock);
diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/charon.dts
index 0e00e508eaa6a..1c8fe20752e6a 100644
--- a/arch/powerpc/boot/dts/charon.dts
+++ b/arch/powerpc/boot/dts/charon.dts
@@ -39,7 +39,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>;	// 128MB
 	};
diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 955bff629df3c..bf511255f3ae8 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -20,7 +20,7 @@
 	model = "intercontrol,digsy-mtc";
 	compatible = "intercontrol,digsy-mtc";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x02000000>;	// 32MB
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t1023rdb.dts b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
index 29757623e5baf..f5f8f969dd586 100644
--- a/arch/powerpc/boot/dts/fsl/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
@@ -125,7 +125,7 @@
 
 			fm1mac3: ethernet@e4000 {
 				phy-handle = <&sgmii_aqr_phy3>;
-				phy-connection-type = "sgmii-2500";
+				phy-connection-type = "2500base-x";
 				sleep = <&rcpm 0x20000000>;
 			};
 
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 179a1785d6454..18d137a3393f0 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -36,7 +36,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 5abb46c5cc951..29419cf81e044 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -35,7 +35,7 @@
 		led4 { gpios = <&gpio_simple 2 1>; };
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x10000000>;	// 256MB
 	};
 
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
index b5413cb85f134..3d57463bc49da 100644
--- a/arch/powerpc/boot/dts/media5200.dts
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -36,7 +36,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;	// 128MB RAM
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc5200b.dtsi b/arch/powerpc/boot/dts/mpc5200b.dtsi
index 969b2200b2f97..ecfba675b5611 100644
--- a/arch/powerpc/boot/dts/mpc5200b.dtsi
+++ b/arch/powerpc/boot/dts/mpc5200b.dtsi
@@ -37,7 +37,7 @@
 		};
 	};
 
-	memory: memory {
+	memory: memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
diff --git a/arch/powerpc/boot/dts/o2d.dts b/arch/powerpc/boot/dts/o2d.dts
index 9f6dd4d889b32..5a676e8141caf 100644
--- a/arch/powerpc/boot/dts/o2d.dts
+++ b/arch/powerpc/boot/dts/o2d.dts
@@ -16,7 +16,7 @@
 	model = "ifm,o2d";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;  // 128MB
 	};
 
diff --git a/arch/powerpc/boot/dts/o2d.dtsi b/arch/powerpc/boot/dts/o2d.dtsi
index cf073e693f24d..1b4df5f64b580 100644
--- a/arch/powerpc/boot/dts/o2d.dtsi
+++ b/arch/powerpc/boot/dts/o2d.dtsi
@@ -23,7 +23,7 @@
 	model = "ifm,o2d";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
 
diff --git a/arch/powerpc/boot/dts/o2dnt2.dts b/arch/powerpc/boot/dts/o2dnt2.dts
index a0f5b97a4f06e..5184c461a205f 100644
--- a/arch/powerpc/boot/dts/o2dnt2.dts
+++ b/arch/powerpc/boot/dts/o2dnt2.dts
@@ -16,7 +16,7 @@
 	model = "ifm,o2dnt2";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;  // 128MB
 	};
 
diff --git a/arch/powerpc/boot/dts/o3dnt.dts b/arch/powerpc/boot/dts/o3dnt.dts
index acce49326491b..045b901719245 100644
--- a/arch/powerpc/boot/dts/o3dnt.dts
+++ b/arch/powerpc/boot/dts/o3dnt.dts
@@ -16,7 +16,7 @@
 	model = "ifm,o3dnt";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x04000000>;  // 64MB
 	};
 
diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
index 96b139bf50e9c..ac3f53c1a1f5b 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -26,7 +26,7 @@
 	model = "phytec,pcm032";
 	compatible = "phytec,pcm032";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;	// 128MB
 	};
 
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 1db07f6cf133c..68b9e8240fb5b 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -36,7 +36,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 4ba26dd259fd8..0d81cd9dd60e9 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -101,8 +101,10 @@ static inline bool pte_user(pte_t pte)
  */
 #if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
 #define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
+#define MAX_POSSIBLE_PHYSMEM_BITS 36
 #else
 #define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
 #endif
 
 /* _PAGE_CHG_MASK masks of bits that are to be preserved across
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 83e5b255d1423..89e61b109c17f 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -177,13 +177,26 @@
 #define PPC_NEG(d, a)		EMIT(PPC_INST_NEG | ___PPC_RT(d) | ___PPC_RA(a))
 
 /* Long jump; (unconditional 'branch') */
-#define PPC_JMP(dest)		EMIT(PPC_INST_BRANCH |			      \
-				     (((dest) - (ctx->idx * 4)) & 0x03fffffc))
+#define PPC_JMP(dest)							      \
+	do {								      \
+		long offset = (long)(dest) - (ctx->idx * 4);		      \
+		if (offset < -0x2000000 || offset > 0x1fffffc || offset & 0x3) {						\
+			pr_err_ratelimited("Branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);			\
+			return -ERANGE;					      \
+		}							      \
+		EMIT(PPC_INST_BRANCH | (offset & 0x03fffffc));		      \
+	} while (0)
 /* "cond" here covers BO:BI fields. */
-#define PPC_BCC_SHORT(cond, dest)	EMIT(PPC_INST_BRANCH_COND |	      \
-					     (((cond) & 0x3ff) << 16) |	      \
-					     (((dest) - (ctx->idx * 4)) &     \
-					      0xfffc))
+#define PPC_BCC_SHORT(cond, dest)					      \
+	do {								      \
+		long offset = (long)(dest) - (ctx->idx * 4);		      \
+		if (offset < -0x8000 || offset > 0x7fff || offset & 0x3) {							\
+			pr_err_ratelimited("Conditional branch offset 0x%lx (@%u) out of range\n", offset, ctx->idx);		\
+			return -ERANGE;					      \
+		}							      \
+		EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | (offset & 0xfffc));					\
+	} while (0)
+
 /* Sign-extended 32-bit immediate load */
 #define PPC_LI32(d, i)		do {					      \
 		if ((int)(uintptr_t)(i) >= -32768 &&			      \
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 888ee95340da2..5a834e34c5b4d 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -239,7 +239,7 @@ static void bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64
 	PPC_BLRL();
 }
 
-static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
+static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
 {
 	/*
 	 * By now, the eBPF program has already setup parameters in r3, r4 and r5
@@ -300,7 +300,9 @@ static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32
 	bpf_jit_emit_common_epilogue(image, ctx);
 
 	PPC_BCTR();
+
 	/* out: */
+	return 0;
 }
 
 /* Assemble the body code between the prologue & epilogue */
@@ -310,7 +312,7 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 {
 	const struct bpf_insn *insn = fp->insnsi;
 	int flen = fp->len;
-	int i;
+	int i, ret;
 
 	/* Start of epilogue code - will only be valid 2nd pass onwards */
 	u32 exit_addr = addrs[flen];
@@ -361,18 +363,25 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 			PPC_SUB(dst_reg, dst_reg, src_reg);
 			goto bpf_alu32_trunc;
 		case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
-		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
 		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
+			if (!imm) {
+				goto bpf_alu32_trunc;
+			} else if (imm >= -32768 && imm < 32768) {
+				PPC_ADDI(dst_reg, dst_reg, IMM_L(imm));
+			} else {
+				PPC_LI32(b2p[TMP_REG_1], imm);
+				PPC_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]);
+			}
+			goto bpf_alu32_trunc;
+		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
 		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
-			if (BPF_OP(code) == BPF_SUB)
-				imm = -imm;
-			if (imm) {
-				if (imm >= -32768 && imm < 32768)
-					PPC_ADDI(dst_reg, dst_reg, IMM_L(imm));
-				else {
-					PPC_LI32(b2p[TMP_REG_1], imm);
-					PPC_ADD(dst_reg, dst_reg, b2p[TMP_REG_1]);
-				}
+			if (!imm) {
+				goto bpf_alu32_trunc;
+			} else if (imm > -32768 && imm <= 32768) {
+				PPC_ADDI(dst_reg, dst_reg, IMM_L(-imm));
+			} else {
+				PPC_LI32(b2p[TMP_REG_1], imm);
+				PPC_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]);
 			}
 			goto bpf_alu32_trunc;
 		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
@@ -430,8 +439,14 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
 			if (imm == 0)
 				return -EINVAL;
-			else if (imm == 1)
-				goto bpf_alu32_trunc;
+			if (imm == 1) {
+				if (BPF_OP(code) == BPF_DIV) {
+					goto bpf_alu32_trunc;
+				} else {
+					PPC_LI(dst_reg, 0);
+					break;
+				}
+			}
 
 			PPC_LI32(b2p[TMP_REG_1], imm);
 			switch (BPF_CLASS(code)) {
@@ -932,7 +947,9 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 		 */
 		case BPF_JMP | BPF_CALL | BPF_X:
 			ctx->seen |= SEEN_TAILCALL;
-			bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
+			ret = bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
+			if (ret < 0)
+				return ret;
 			break;
 
 		default:
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
index f05325f0cc03b..ddd2953965aa1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
@@ -98,9 +98,8 @@ int __init mpc85xx_setup_pmc(void)
 			pr_err("Could not map guts node address\n");
 			return -ENOMEM;
 		}
+		qoriq_pm_ops = &mpc85xx_pm_ops;
 	}
 
-	qoriq_pm_ops = &mpc85xx_pm_ops;
-
 	return 0;
 }
diff --git a/arch/powerpc/sysdev/dcr-low.S b/arch/powerpc/sysdev/dcr-low.S
index e687bb2003ff0..5589fbe48bbdc 100644
--- a/arch/powerpc/sysdev/dcr-low.S
+++ b/arch/powerpc/sysdev/dcr-low.S
@@ -15,7 +15,7 @@
 #include <asm/export.h>
 
 #define DCR_ACCESS_PROLOG(table) \
-	cmpli	cr0,r3,1024;	 \
+	cmplwi	cr0,r3,1024;	 \
 	rlwinm  r3,r3,4,18,27;   \
 	lis     r5,table@h;      \
 	ori     r5,r5,table@l;   \
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 48352bffbc929..a82335215d54d 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -225,14 +225,13 @@ EXPORT_SYMBOL(strcmp);
  */
 char * strrchr(const char * s, int c)
 {
-       size_t len = __strend(s) - s;
-
-       if (len)
-	       do {
-		       if (s[len] == (char) c)
-			       return (char *) s + len;
-	       } while (--len > 0);
-       return NULL;
+	ssize_t len = __strend(s) - s;
+
+	do {
+		if (s[len] == (char)c)
+			return (char *)s + len;
+	} while (--len >= 0);
+	return NULL;
 }
 EXPORT_SYMBOL(strrchr);
 
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 0195c3983f540..65f802f705475 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -662,9 +662,10 @@ void __gmap_zap(struct gmap *gmap, unsigned long gaddr)
 		vmaddr |= gaddr & ~PMD_MASK;
 		/* Get pointer to the page table entry */
 		ptep = get_locked_pte(gmap->mm, vmaddr, &ptl);
-		if (likely(ptep))
+		if (likely(ptep)) {
 			ptep_zap_unused(gmap->mm, vmaddr, ptep, 0);
-		pte_unmap_unlock(ptep, ptl);
+			pte_unmap_unlock(ptep, ptl);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(__gmap_zap);
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 5f2bb4242c0f7..c50c397cbcf75 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -60,6 +60,7 @@ config DUMP_CODE
 
 config DWARF_UNWINDER
 	bool "Enable the DWARF unwinder for stacktraces"
+	depends on DEBUG_KERNEL
 	select FRAME_POINTER
 	depends on SUPERH32
 	default n
diff --git a/arch/sh/include/asm/sfp-machine.h b/arch/sh/include/asm/sfp-machine.h
index d3c548443f2a6..dd195c6f3b9d8 100644
--- a/arch/sh/include/asm/sfp-machine.h
+++ b/arch/sh/include/asm/sfp-machine.h
@@ -25,6 +25,14 @@
 #ifndef _SFP_MACHINE_H
 #define _SFP_MACHINE_H
 
+#ifdef __BIG_ENDIAN__
+#define __BYTE_ORDER __BIG_ENDIAN
+#define __LITTLE_ENDIAN 0
+#else
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#define __BIG_ENDIAN 0
+#endif
+
 #define _FP_W_TYPE_SIZE		32
 #define _FP_W_TYPE		unsigned long
 #define _FP_WS_TYPE		signed long
diff --git a/arch/sh/kernel/cpu/sh4a/smp-shx3.c b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
index 0d3637c494bfe..c1f66c35e0c12 100644
--- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
@@ -76,8 +76,9 @@ static void shx3_prepare_cpus(unsigned int max_cpus)
 	BUILD_BUG_ON(SMP_MSG_NR >= 8);
 
 	for (i = 0; i < SMP_MSG_NR; i++)
-		request_irq(104 + i, ipi_interrupt_handler,
-			    IRQF_PERCPU, "IPI", (void *)(long)i);
+		if (request_irq(104 + i, ipi_interrupt_handler,
+			    IRQF_PERCPU, "IPI", (void *)(long)i))
+			pr_err("Failed to request irq %d\n", i);
 
 	for (i = 0; i < max_cpus; i++)
 		set_cpu_present(i, true);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c26cca506f646..c20df6a3540c2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2075,6 +2075,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 	if (err) {
 		if (event->destroy)
 			event->destroy(event);
+		event->destroy = NULL;
 	}
 
 	if (ACCESS_ONCE(x86_pmu.attr_rdpmc))
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 686dd4339370f..e94d547e9d248 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3363,6 +3363,9 @@ static int skx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
 	struct extra_reg *er;
 	int idx = 0;
+	/* Any of the CHA events may be filtered by Thread/Core-ID.*/
+	if (event->hw.config & SNBEP_CBO_PMON_CTL_TID_EN)
+		idx = SKX_CHA_MSR_PMON_BOX_FILTER_TID;
 
 	for (er = skx_uncore_cha_extra_regs; er->msr; er++) {
 		if (er->event != (event->hw.config & er->config_mask))
@@ -3430,6 +3433,7 @@ static struct event_constraint skx_uncore_iio_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xd4, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
 	EVENT_CONSTRAINT_END
 };
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 390fdd39e0e21..5a69eee673536 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -19,7 +19,7 @@
 #define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
 #define CURRENT_MASK (~(THREAD_SIZE - 1))
 
-#define EXCEPTION_STACK_ORDER (0 + KASAN_STACK_ORDER)
+#define EXCEPTION_STACK_ORDER (1 + KASAN_STACK_ORDER)
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
 
 #define DEBUG_STACK_ORDER (EXCEPTION_STACK_ORDER + 1)
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index bcc89625ebe53..f3f719d59e61b 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -42,5 +42,6 @@ typedef union {
  */
 #define PTRS_PER_PTE	512
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	36
 
 #endif /* _ASM_X86_PGTABLE_3LEVEL_DEFS_H */
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c6f0ef1d9ab78..a1aecdc305da3 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -284,8 +284,10 @@ void kvm_set_posted_intr_wakeup_handler(void (*handler)(void))
 {
 	if (handler)
 		kvm_posted_intr_wakeup_handler = handler;
-	else
+	else {
 		kvm_posted_intr_wakeup_handler = dummy_handler;
+		synchronize_rcu();
+	}
 }
 EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wakeup_handler);
 
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index a069d0dd3ded4..aa34b16e62c24 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -96,7 +96,7 @@ static unsigned long ioapic_read_indirect(struct kvm_ioapic *ioapic,
 static void rtc_irq_eoi_tracking_reset(struct kvm_ioapic *ioapic)
 {
 	ioapic->rtc_status.pending_eoi = 0;
-	bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_ID + 1);
+	bitmap_zero(ioapic->rtc_status.dest_map.map, KVM_MAX_VCPU_ID);
 }
 
 static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic);
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 2f3df43489f22..1cc6e54436dba 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -42,13 +42,13 @@ struct kvm_vcpu;
 
 struct dest_map {
 	/* vcpu bitmap where IRQ has been sent */
-	DECLARE_BITMAP(map, KVM_MAX_VCPU_ID + 1);
+	DECLARE_BITMAP(map, KVM_MAX_VCPU_ID);
 
 	/*
 	 * Vector sent to a given vcpu, only valid when
 	 * the vcpu's bit in map is set
 	 */
-	u8 vectors[KVM_MAX_VCPU_ID + 1];
+	u8 vectors[KVM_MAX_VCPU_ID];
 };
 
 
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 441694464b1e4..fbbc24b914e30 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -144,7 +144,7 @@ unsigned xtensa_get_ext_irq_no(unsigned irq)
 
 void __init init_IRQ(void)
 {
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 	irqchip_init();
 #else
 #ifdef CONFIG_HAVE_SMP
diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 42285f35d3135..db5122765f166 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -54,8 +54,12 @@ void platform_power_off(void)
 
 void platform_restart(void)
 {
-	/* Flush and reset the mmu, simulate a processor reset, and
-	 * jump to the reset vector. */
+	/* Try software reset first. */
+	WRITE_ONCE(*(u32 *)XTFPGA_SWRST_VADDR, 0xdead);
+
+	/* If software reset did not work, flush and reset the mmu,
+	 * simulate a processor reset, and jump to the reset vector.
+	 */
 	cpu_reset();
 	/* control never gets here */
 }
@@ -85,7 +89,7 @@ void __init platform_calibrate_ccount(void)
 
 #endif
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 
 static void __init xtfpga_clk_setup(struct device_node *np)
 {
@@ -303,4 +307,4 @@ static int __init xtavnet_init(void)
  */
 arch_initcall(xtavnet_init);
 
-#endif /* CONFIG_OF */
+#endif /* CONFIG_USE_OF */
diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 85082574c5154..62e11835f220e 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -138,12 +138,14 @@ static void pcrypt_aead_enc(struct padata_priv *padata)
 {
 	struct pcrypt_request *preq = pcrypt_padata_request(padata);
 	struct aead_request *req = pcrypt_request_ctx(preq);
+	int ret;
 
-	padata->info = crypto_aead_encrypt(req);
+	ret = crypto_aead_encrypt(req);
 
-	if (padata->info == -EINPROGRESS)
+	if (ret == -EINPROGRESS)
 		return;
 
+	padata->info = ret;
 	padata_do_serial(padata);
 }
 
@@ -180,12 +182,14 @@ static void pcrypt_aead_dec(struct padata_priv *padata)
 {
 	struct pcrypt_request *preq = pcrypt_padata_request(padata);
 	struct aead_request *req = pcrypt_request_ctx(preq);
+	int ret;
 
-	padata->info = crypto_aead_decrypt(req);
+	ret = crypto_aead_decrypt(req);
 
-	if (padata->info == -EINPROGRESS)
+	if (ret == -EINPROGRESS)
 		return;
 
+	padata->info = ret;
 	padata_do_serial(padata);
 }
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 441edf51484ac..4e12e12662467 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -259,6 +259,8 @@ extern struct acpi_bit_register_info
 
 ACPI_GLOBAL(u8, acpi_gbl_sleep_type_a);
 ACPI_GLOBAL(u8, acpi_gbl_sleep_type_b);
+ACPI_GLOBAL(u8, acpi_gbl_sleep_type_a_s0);
+ACPI_GLOBAL(u8, acpi_gbl_sleep_type_b_s0);
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 3f2fb4b31fdc0..7e2f9b0e66eea 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -184,17 +184,13 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 
 acpi_status acpi_hw_extended_wake_prep(u8 sleep_state)
 {
-	acpi_status status;
 	u8 sleep_type_value;
 
 	ACPI_FUNCTION_TRACE(hw_extended_wake_prep);
 
-	status = acpi_get_sleep_type_data(ACPI_STATE_S0,
-					  &acpi_gbl_sleep_type_a,
-					  &acpi_gbl_sleep_type_b);
-	if (ACPI_SUCCESS(status)) {
+	if (acpi_gbl_sleep_type_a_s0 != ACPI_SLEEP_TYPE_INVALID) {
 		sleep_type_value =
-		    ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
+		    ((acpi_gbl_sleep_type_a_s0 << ACPI_X_SLEEP_TYPE_POSITION) &
 		     ACPI_X_SLEEP_TYPE_MASK);
 
 		(void)acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_ENABLE),
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index d00c9810845b2..ddf198de87295 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -217,7 +217,7 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 
 acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
 	u32 pm1a_control;
@@ -230,10 +230,7 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state)
 	 * This is unclear from the ACPI Spec, but it is required
 	 * by some machines.
 	 */
-	status = acpi_get_sleep_type_data(ACPI_STATE_S0,
-					  &acpi_gbl_sleep_type_a,
-					  &acpi_gbl_sleep_type_b);
-	if (ACPI_SUCCESS(status)) {
+	if (acpi_gbl_sleep_type_a_s0 != ACPI_SLEEP_TYPE_INVALID) {
 		sleep_type_reg_info =
 		    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE);
 		sleep_enable_reg_info =
@@ -254,9 +251,9 @@ acpi_status acpi_hw_legacy_wake_prep(u8 sleep_state)
 
 			/* Insert the SLP_TYP bits */
 
-			pm1a_control |= (acpi_gbl_sleep_type_a <<
+			pm1a_control |= (acpi_gbl_sleep_type_a_s0 <<
 					 sleep_type_reg_info->bit_position);
-			pm1b_control |= (acpi_gbl_sleep_type_b <<
+			pm1b_control |= (acpi_gbl_sleep_type_b_s0 <<
 					 sleep_type_reg_info->bit_position);
 
 			/* Write the control registers and ignore any errors */
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index f76e0eab32b8e..53f9f4c359579 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -315,6 +315,13 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 
+	status = acpi_get_sleep_type_data(ACPI_STATE_S0,
+					  &acpi_gbl_sleep_type_a_s0,
+					  &acpi_gbl_sleep_type_b_s0);
+	if (ACPI_FAILURE(status)) {
+		acpi_gbl_sleep_type_a_s0 = ACPI_SLEEP_TYPE_INVALID;
+	}
+
 	/* Execute the _PTS method (Prepare To Sleep) */
 
 	arg_list.count = 1;
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 93ecae55fe6a0..69c6f02f16b5b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -187,7 +187,7 @@ static int acpi_battery_is_charged(struct acpi_battery *battery)
 		return 1;
 
 	/* fallback to using design values for broken batteries */
-	if (battery->design_capacity == battery->capacity_now)
+	if (battery->design_capacity <= battery->capacity_now)
 		return 1;
 
 	/* we don't do any sort of metric based on percentages */
diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index ca18e0d23df97..db63d3463617a 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -216,31 +216,36 @@ static acpi_status intel_pmic_regs_handler(u32 function,
 		void *handler_context, void *region_context)
 {
 	struct intel_pmic_opregion *opregion = region_context;
-	int result = 0;
+	int result = -EINVAL;
+
+	if (function == ACPI_WRITE) {
+		switch (address) {
+		case 0:
+			return AE_OK;
+		case 1:
+			opregion->ctx.addr |= (*value64 & 0xff) << 8;
+			return AE_OK;
+		case 2:
+			opregion->ctx.addr |= *value64 & 0xff;
+			return AE_OK;
+		case 3:
+			opregion->ctx.val = *value64 & 0xff;
+			return AE_OK;
+		case 4:
+			if (*value64) {
+				result = regmap_write(opregion->regmap, opregion->ctx.addr,
+						      opregion->ctx.val);
+			} else {
+				result = regmap_read(opregion->regmap, opregion->ctx.addr,
+						     &opregion->ctx.val);
+			}
+			opregion->ctx.addr = 0;
+		}
+	}
 
-	switch (address) {
-	case 0:
-		return AE_OK;
-	case 1:
-		opregion->ctx.addr |= (*value64 & 0xff) << 8;
+	if (function == ACPI_READ && address == 3) {
+		*value64 = opregion->ctx.val;
 		return AE_OK;
-	case 2:
-		opregion->ctx.addr |= *value64 & 0xff;
-		return AE_OK;
-	case 3:
-		opregion->ctx.val = *value64 & 0xff;
-		return AE_OK;
-	case 4:
-		if (*value64) {
-			result = regmap_write(opregion->regmap, opregion->ctx.addr,
-					      opregion->ctx.val);
-		} else {
-			result = regmap_read(opregion->regmap, opregion->ctx.addr,
-					     &opregion->ctx.val);
-			if (result == 0)
-				*value64 = opregion->ctx.val;
-		}
-		memset(&opregion->ctx, 0x00, sizeof(opregion->ctx));
 	}
 
 	if (result < 0) {
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 5bc8d588d1460..22bf8133fd2af 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -356,9 +356,6 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 	void __iomem *tmp;
 	int i, ret;
 
-	WARN_ON(dev->irq[0] == (unsigned int)-1);
-	WARN_ON(dev->irq[1] == (unsigned int)-1);
-
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		goto err_out;
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f4c0b62959450..f78f7d06ad9fc 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -303,6 +303,7 @@ struct binder_proc {
 	struct task_struct *tsk;
 	struct files_struct *files;
 	struct mutex files_lock;
+	const struct cred *cred;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	void *buffer;
@@ -1431,8 +1432,8 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error = BR_FAILED_REPLY;
 			goto err_invalid_target_handle;
 		}
-		if (security_binder_transaction(proc->tsk,
-						target_proc->tsk) < 0) {
+		if (security_binder_transaction(proc->cred,
+						target_proc->cred) < 0) {
 			return_error = BR_FAILED_REPLY;
 			goto err_invalid_target_handle;
 		}
@@ -1505,7 +1506,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
@@ -1593,8 +1594,8 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_for_node_failed;
 			}
-			if (security_binder_transfer_binder(proc->tsk,
-							    target_proc->tsk)) {
+			if (security_binder_transfer_binder(proc->cred,
+							    target_proc->cred)) {
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_for_node_failed;
 			}
@@ -1633,8 +1634,8 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_failed;
 			}
-			if (security_binder_transfer_binder(proc->tsk,
-							    target_proc->tsk)) {
+			if (security_binder_transfer_binder(proc->cred,
+							    target_proc->cred)) {
 				return_error = BR_FAILED_REPLY;
 				goto err_binder_get_ref_failed;
 			}
@@ -1697,8 +1698,8 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error = BR_FAILED_REPLY;
 				goto err_fget_failed;
 			}
-			if (security_binder_transfer_file(proc->tsk,
-							  target_proc->tsk,
+			if (security_binder_transfer_file(proc->cred,
+							  target_proc->cred,
 							  file) < 0) {
 				fput(file);
 				return_error = BR_FAILED_REPLY;
@@ -2780,7 +2781,7 @@ static int binder_ioctl_set_ctx_mgr(struct file *filp)
 		ret = -EBUSY;
 		goto out;
 	}
-	ret = security_binder_set_context_mgr(proc->tsk);
+	ret = security_binder_set_context_mgr(proc->cred);
 	if (ret < 0)
 		goto out;
 	if (uid_valid(binder_context_mgr_uid)) {
@@ -3036,6 +3037,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
 	mutex_init(&proc->files_lock);
+	proc->cred = get_cred(filp->f_cred);
 	INIT_LIST_HEAD(&proc->todo);
 	init_waitqueue_head(&proc->wait);
 	proc->default_priority = task_nice(current);
@@ -3241,6 +3243,7 @@ static void binder_deferred_release(struct binder_proc *proc)
 	}
 
 	put_task_struct(proc->tsk);
+	put_cred(proc->cred);
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
 		     "%s: %d threads %d, nodes %d (ref %d), refs %d, active transactions %d, buffers %d, pages %d\n",
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 16f8fda899815..07f96a0321498 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -114,6 +114,12 @@ static const unsigned long ata_eh_identify_timeouts[] = {
 	ULONG_MAX,
 };
 
+static const unsigned long ata_eh_revalidate_timeouts[] = {
+	15000,	/* Some drives are slow to read log pages when waking-up */
+	15000,  /* combined time till here is enough even for media access */
+	ULONG_MAX,
+};
+
 static const unsigned long ata_eh_flush_timeouts[] = {
 	15000,	/* be generous with flush */
 	15000,  /* ditto */
@@ -150,6 +156,8 @@ static const struct ata_eh_cmd_timeout_ent
 ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
 	{ .commands = CMDS(ATA_CMD_ID_ATA, ATA_CMD_ID_ATAPI),
 	  .timeouts = ata_eh_identify_timeouts, },
+	{ .commands = CMDS(ATA_CMD_READ_LOG_EXT, ATA_CMD_READ_LOG_DMA_EXT),
+	  .timeouts = ata_eh_revalidate_timeouts, },
 	{ .commands = CMDS(ATA_CMD_READ_NATIVE_MAX, ATA_CMD_READ_NATIVE_MAX_EXT),
 	  .timeouts = ata_eh_other_timeouts, },
 	{ .commands = CMDS(ATA_CMD_SET_MAX, ATA_CMD_SET_MAX_EXT),
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index bce2a8ca4678a..55fcdb798002b 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -328,7 +328,8 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			__le32 pad;
+			__le32 pad = 0;
+
 			if (rw == READ) {
 				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
@@ -716,7 +717,8 @@ static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			__le32 pad;
+			__le32 pad = 0;
+
 			if (rw == WRITE) {
 				memcpy(&pad, buf + buflen - slop, slop);
 				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ded3a66049d2c..6007ebb80f886 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3907,8 +3907,8 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 		break;
 
 	default:
-		dev_err(host->dev, "BUG: invalid board index %u\n", board_idx);
-		return 1;
+		dev_alert(host->dev, "BUG: invalid board index %u\n", board_idx);
+		return -EINVAL;
 	}
 
 	hpriv->hp_flags = hp_flags;
diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 6e8eaa7fe7a6f..b5f849d2f7623 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -283,6 +283,16 @@ static int img_ascii_lcd_display(struct img_ascii_lcd_ctx *ctx,
 	if (msg[count - 1] == '\n')
 		count--;
 
+	if (!count) {
+		/* clear the LCD */
+		devm_kfree(&ctx->pdev->dev, ctx->message);
+		ctx->message = NULL;
+		ctx->message_len = 0;
+		memset(ctx->curr, ' ', ctx->cfg->num_chars);
+		ctx->cfg->update(ctx);
+		return 0;
+	}
+
 	new_msg = devm_kmalloc(&ctx->pdev->dev, count + 1, GFP_KERNEL);
 	if (!new_msg)
 		return -ENOMEM;
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index b11af3f2c1dbf..c0fdbb3927586 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -296,14 +296,14 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 	if (!blk)
 		return -ENOMEM;
 
+	rbnode->block = blk;
+
 	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
 		present = krealloc(rbnode->cache_present,
 				   BITS_TO_LONGS(blklen) * sizeof(*present),
 				   GFP_KERNEL);
-		if (!present) {
-			kfree(blk);
+		if (!present)
 			return -ENOMEM;
-		}
 
 		memset(present + BITS_TO_LONGS(rbnode->blklen), 0,
 		       (BITS_TO_LONGS(blklen) - BITS_TO_LONGS(rbnode->blklen))
@@ -320,7 +320,6 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 	}
 
 	/* update the rbnode block, its size and the base register */
-	rbnode->block = blk;
 	rbnode->blklen = blklen;
 	rbnode->base_reg = base_reg;
 	rbnode->cache_present = present;
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index e7e92ed34f0c6..34c4a61a954fc 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -413,6 +413,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 					   &kdev->kobj, "state%d", i);
 		if (ret) {
 			kobject_put(&kobj->kobj);
+			kfree(kobj);
 			goto error_state;
 		}
 		kobject_uevent(&kobj->kobj, KOBJ_ADD);
@@ -543,6 +544,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 				   &kdev->kobj, "driver");
 	if (ret) {
 		kobject_put(&kdrv->kobj);
+		kfree(kdrv);
 		return ret;
 	}
 
@@ -629,7 +631,6 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 	if (!kdev)
 		return -ENOMEM;
 	kdev->dev = dev;
-	dev->kobj_dev = kdev;
 
 	init_completion(&kdev->kobj_unregister);
 
@@ -637,9 +638,11 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 				   "cpuidle");
 	if (error) {
 		kobject_put(&kdev->kobj);
+		kfree(kdev);
 		return error;
 	}
 
+	dev->kobj_dev = kdev;
 	kobject_uevent(&kdev->kobj, KOBJ_ADD);
 
 	return 0;
diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
index c64481160b711..180016e157771 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -195,6 +195,13 @@ static int __adf_iov_putmsg(struct adf_accel_dev *accel_dev, u32 msg, u8 vf_nr)
 		val = ADF_CSR_RD(pmisc_bar_addr, pf2vf_offset);
 	} while ((val & int_bit) && (count++ < ADF_IOV_MSG_ACK_MAX_RETRY));
 
+	if (val != msg) {
+		dev_dbg(&GET_DEV(accel_dev),
+			"Collision - PFVF CSR overwritten by remote function\n");
+		ret = -EIO;
+		goto out;
+	}
+
 	if (val & int_bit) {
 		dev_dbg(&GET_DEV(accel_dev), "ACK not received from remote\n");
 		val &= ~int_bit;
@@ -243,6 +250,11 @@ void adf_vf2pf_req_hndl(struct adf_accel_vf_info *vf_info)
 
 	/* Read message from the VF */
 	msg = ADF_CSR_RD(pmisc_addr, hw_data->get_pf2vf_offset(vf_nr));
+	if (!(msg & ADF_VF2PF_INT)) {
+		dev_info(&GET_DEV(accel_dev),
+			 "Spurious VF2PF interrupt, msg %X. Ignored\n", msg);
+		goto out;
+	}
 
 	/* To ACK, clear the VF2PFINT bit */
 	msg &= ~ADF_VF2PF_INT;
@@ -326,6 +338,7 @@ void adf_vf2pf_req_hndl(struct adf_accel_vf_info *vf_info)
 	if (resp && adf_iov_putmsg(accel_dev, resp, vf_nr))
 		dev_err(&GET_DEV(accel_dev), "Failed to send response to VF\n");
 
+out:
 	/* re-enable interrupt on PF from this VF */
 	adf_enable_vf2pf_interrupts(accel_dev, (1 << vf_nr));
 	return;
diff --git a/drivers/crypto/qat/qat_common/adf_vf_isr.c b/drivers/crypto/qat/qat_common/adf_vf_isr.c
index 36db3c443e7e4..6fa1447d05829 100644
--- a/drivers/crypto/qat/qat_common/adf_vf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_vf_isr.c
@@ -123,6 +123,11 @@ static void adf_pf2vf_bh_handler(void *data)
 
 	/* Read the message from PF */
 	msg = ADF_CSR_RD(pmisc_bar_addr, hw_data->get_pf2vf_offset(0));
+	if (!(msg & ADF_PF2VF_INT)) {
+		dev_info(&GET_DEV(accel_dev),
+			 "Spurious PF2VF interrupt, msg %X. Ignored\n", msg);
+		goto out;
+	}
 
 	if (!(msg & ADF_PF2VF_MSGORIGIN_SYSTEM))
 		/* Ignore legacy non-system (non-kernel) PF2VF messages */
@@ -171,6 +176,7 @@ static void adf_pf2vf_bh_handler(void *data)
 	msg &= ~BIT(0);
 	ADF_CSR_WR(pmisc_bar_addr, hw_data->get_pf2vf_offset(0), msg);
 
+out:
 	/* Re-enable PF2VF interrupts */
 	adf_enable_pf2vf_interrupts(accel_dev);
 	return;
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 12d9048293245..a505be9ef96da 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -156,7 +156,7 @@
 #define		AT_XDMAC_CC_WRIP	(0x1 << 23)	/* Write in Progress (read only) */
 #define			AT_XDMAC_CC_WRIP_DONE		(0x0 << 23)
 #define			AT_XDMAC_CC_WRIP_IN_PROGRESS	(0x1 << 23)
-#define		AT_XDMAC_CC_PERID(i)	(0x7f & (i) << 24)	/* Channel Peripheral Identifier */
+#define		AT_XDMAC_CC_PERID(i)	((0x7f & (i)) << 24)	/* Channel Peripheral Identifier */
 #define AT_XDMAC_CDS_MSP	0x2C	/* Channel Data Stride Memory Set Pattern */
 #define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
 #define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 882ff9448c3ba..6537b8ec03934 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -167,7 +167,7 @@ dmaengine_desc_get_callback_invoke(struct dma_async_tx_descriptor *tx,
 static inline bool
 dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 {
-	return (cb->callback) ? true : false;
+	return cb->callback || cb->callback_result;
 }
 
 #endif
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index e9391950a8437..94194ead73636 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1009,7 +1009,7 @@ static u64 haswell_get_tohm(struct sbridge_pvt *pvt)
 	pci_read_config_dword(pvt->info.pci_vtd, HASWELL_TOHM_1, &reg);
 	rc = ((reg << 6) | rc) << 26;
 
-	return rc | 0x1ffffff;
+	return rc | 0x3ffffff;
 }
 
 static u64 knl_get_tolm(struct sbridge_pvt *pvt)
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index dc8d2603612ed..91dbc6ae56cf9 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -35,8 +35,6 @@
 
 #define INDENT_SP	" "
 
-static char rcd_decode_str[CPER_REC_LEN];
-
 /*
  * CPER record ID need to be unique even after reboot, because record
  * ID is used as index for ERST storage, while CPER records from
@@ -293,6 +291,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
 				struct cper_mem_err_compact *cmem)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
+	char rcd_decode_str[CPER_REC_LEN];
 
 	if (cper_mem_err_location(cmem, rcd_decode_str))
 		trace_seq_printf(p, "%s", rcd_decode_str);
@@ -307,6 +306,7 @@ static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 	int len)
 {
 	struct cper_mem_err_compact cmem;
+	char rcd_decode_str[CPER_REC_LEN];
 
 	/* Don't trust UEFI 2.1/2.2 structure with bad validation bits */
 	if (len == sizeof(struct cper_sec_mem_err_old) &&
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index dd7f63354ca06..60a32440daffe 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -259,7 +259,7 @@ static void virt_efi_reset_system(int reset_type,
 				  unsigned long data_size,
 				  efi_char16_t *data)
 {
-	if (down_interruptible(&efi_runtime_lock)) {
+	if (down_trylock(&efi_runtime_lock)) {
 		pr_warn("failed to invoke the reset_system() runtime service:\n"
 			"could not get exclusive access to the firmware\n");
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 694f631d9c90d..eb79d0d3d34f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -844,6 +844,7 @@ static int amdgpu_connector_vga_get_modes(struct drm_connector *connector)
 
 	amdgpu_connector_get_edid(connector);
 	ret = amdgpu_connector_ddc_get_modes(connector);
+	amdgpu_get_native_mode(connector);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
index 7899fc1dcdb08..c4fd742ff917a 100644
--- a/drivers/gpu/drm/drm_plane_helper.c
+++ b/drivers/gpu/drm/drm_plane_helper.c
@@ -246,7 +246,6 @@ int drm_plane_helper_check_update(struct drm_plane *plane,
 		.crtc_w = drm_rect_width(dst),
 		.crtc_h = drm_rect_height(dst),
 		.rotation = rotation,
-		.visible = *visible,
 	};
 	int ret;
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index e49b414c012c6..246336a9f47d6 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -439,7 +439,7 @@ static int dsi_bus_clk_enable(struct msm_dsi_host *msm_host)
 
 	return 0;
 err:
-	for (; i > 0; i--)
+	while (--i >= 0)
 		clk_disable_unprepare(msm_host->bus_clks[i]);
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/edp/edp_ctrl.c b/drivers/gpu/drm/msm/edp/edp_ctrl.c
index 149bfe7ddd82d..090ce0a46f068 100644
--- a/drivers/gpu/drm/msm/edp/edp_ctrl.c
+++ b/drivers/gpu/drm/msm/edp/edp_ctrl.c
@@ -1090,7 +1090,7 @@ void msm_edp_ctrl_power(struct edp_ctrl *ctrl, bool on)
 int msm_edp_ctrl_init(struct msm_edp *edp)
 {
 	struct edp_ctrl *ctrl = NULL;
-	struct device *dev = &edp->pdev->dev;
+	struct device *dev;
 	int ret;
 
 	if (!edp) {
@@ -1098,6 +1098,7 @@ int msm_edp_ctrl_init(struct msm_edp *edp)
 		return -EINVAL;
 	}
 
+	dev = &edp->pdev->dev;
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 983ce7965c7ff..dfce39f02f8d4 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -871,7 +871,7 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev,
 
 	ret = msm_gem_new_impl(dev, size, flags, NULL, &obj);
 	if (ret)
-		goto fail;
+		return ERR_PTR(ret);
 
 	if (use_pages(obj)) {
 		ret = drm_gem_object_init(dev, obj, size);
@@ -910,7 +910,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	mutex_unlock(&dev->struct_mutex);
 
 	if (ret)
-		goto fail;
+		return ERR_PTR(ret);
 
 	drm_gem_private_object_init(dev, obj, size);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 411c12cdb2499..bb516eb124213 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -178,6 +178,7 @@ static const struct file_operations nouveau_pstate_fops = {
 	.open = nouveau_debugfs_pstate_open,
 	.read = seq_read,
 	.write = nouveau_debugfs_pstate_set,
+	.release = single_release,
 };
 
 static struct drm_info_list nouveau_debugfs_list[] = {
diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/udl_connector.c
index d2f57c52f7db2..c001ed8e7dd90 100644
--- a/drivers/gpu/drm/udl/udl_connector.c
+++ b/drivers/gpu/drm/udl/udl_connector.c
@@ -37,7 +37,7 @@ static u8 *udl_get_edid(struct udl_device *udl)
 		ret = usb_control_msg(udl->udev,
 				      usb_rcvctrlpipe(udl->udev, 0), (0x02),
 				      (0x80 | (0x02 << 5)), i << 8, 0xA1, rbuf, 2,
-				      HZ);
+				      1000);
 		if (ret < 1) {
 			DRM_ERROR("Read EDID byte %d failed err %x\n", i, ret);
 			goto error;
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 959a9e38b4f54..149902619cbc8 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -302,12 +302,19 @@ static int apple_event(struct hid_device *hdev, struct hid_field *field,
 
 /*
  * MacBook JIS keyboard has wrong logical maximum
+ * Magic Keyboard JIS has wrong logical maximum
  */
 static __u8 *apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
+	if(*rsize >=71 && rdesc[70] == 0x65 && rdesc[64] == 0x65) {
+		hid_info(hdev,
+			 "fixing up Magic Keyboard JIS report descriptor\n");
+		rdesc[64] = rdesc[70] = 0xe7;
+	}
+
 	if ((asc->quirks & APPLE_RDESC_JIS) && *rsize >= 60 &&
 			rdesc[53] == 0x65 && rdesc[59] == 0x65) {
 		hid_info(hdev,
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 8d7f865c1133f..9d3605df1f489 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -26,6 +26,7 @@
 #define _HYPERV_VMBUS_H
 
 #include <linux/list.h>
+#include <linux/bitops.h>
 #include <asm/sync_bitops.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index e0a1a118514f9..8b11d2fdf80ab 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -592,8 +592,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	dev_set_drvdata(hdev, drvdata);
 	dev_set_name(hdev, HWMON_ID_FORMAT, id);
 	err = device_register(hdev);
-	if (err)
-		goto free_hwmon;
+	if (err) {
+		put_device(hdev);
+		goto ida_remove;
+	}
 
 	if (chip && chip->ops->is_visible && chip->ops->read &&
 	    chip->info[0]->type == hwmon_chip &&
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index a3d912cd3b8d7..5081fd7e8fddc 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -69,22 +69,27 @@ static struct __coeff lm25066_coeff[5][PSC_NUM_CLASSES + 2] = {
 	[lm25056] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 16296,
+			.b = 1343,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 13797,
+			.b = -1833,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 6726,
+			.b = -537,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 5501,
+			.b = -2908,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
 			.m = 26882,
+			.b = -5646,
 			.R = -4,
 		},
 		[PSC_TEMPERATURE] = {
@@ -96,26 +101,32 @@ static struct __coeff lm25066_coeff[5][PSC_NUM_CLASSES + 2] = {
 	[lm25066] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 22070,
+			.b = -1800,
 			.R = -2,
 		},
 		[PSC_VOLTAGE_OUT] = {
 			.m = 22070,
+			.b = -1800,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 13661,
+			.b = -5200,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 6852,
+			.b = -3100,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 736,
+			.b = -3300,
 			.R = -2,
 		},
 		[PSC_POWER_L] = {
 			.m = 369,
+			.b = -1900,
 			.R = -2,
 		},
 		[PSC_TEMPERATURE] = {
@@ -155,26 +166,32 @@ static struct __coeff lm25066_coeff[5][PSC_NUM_CLASSES + 2] = {
 	[lm5064] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 4611,
+			.b = -642,
 			.R = -2,
 		},
 		[PSC_VOLTAGE_OUT] = {
 			.m = 4621,
+			.b = 423,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 10742,
+			.b = 1552,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 5456,
+			.b = 2118,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 1204,
+			.b = 8524,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
 			.m = 612,
+			.b = 11202,
 			.R = -3,
 		},
 		[PSC_TEMPERATURE] = {
@@ -184,26 +201,32 @@ static struct __coeff lm25066_coeff[5][PSC_NUM_CLASSES + 2] = {
 	[lm5066] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 4587,
+			.b = -1200,
 			.R = -2,
 		},
 		[PSC_VOLTAGE_OUT] = {
 			.m = 4587,
+			.b = -2400,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
 			.m = 10753,
+			.b = -1200,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
 			.m = 5405,
+			.b = -600,
 			.R = -2,
 		},
 		[PSC_POWER] = {
 			.m = 1204,
+			.b = -6000,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
 			.m = 605,
+			.b = -8000,
 			.R = -3,
 		},
 		[PSC_TEMPERATURE] = {
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
index ad17d88d85736..63f47e07345c0 100644
--- a/drivers/i2c/busses/i2c-xlr.c
+++ b/drivers/i2c/busses/i2c-xlr.c
@@ -434,11 +434,15 @@ static int xlr_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&priv->adap, priv);
 	ret = i2c_add_numbered_adapter(&priv->adap);
 	if (ret < 0)
-		return ret;
+		goto err_unprepare_clk;
 
 	platform_set_drvdata(pdev, priv);
 	dev_info(&priv->adap.dev, "Added I2C Bus.\n");
 	return 0;
+
+err_unprepare_clk:
+	clk_unprepare(clk);
+	return ret;
 }
 
 static int xlr_i2c_remove(struct platform_device *pdev)
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 89dfbd31be5c8..b7c7cba2dc092 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -169,7 +169,13 @@ static int adc128_probe(struct spi_device *spi)
 	mutex_init(&adc->lock);
 
 	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_disable_regulator;
 
+	return 0;
+
+err_disable_regulator:
+	regulator_disable(adc->reg);
 	return ret;
 }
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 704284a475aec..645749b90ec07 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -147,7 +147,7 @@ static int ssp_print_mcu_debug(char *data_frame, int *data_index,
 	if (length > received_len - *data_index || length <= 0) {
 		ssp_dbg("[SSP]: MSG From MCU-invalid debug length(%d/%d)\n",
 			length, received_len);
-		return length ? length : -EPROTO;
+		return -EPROTO;
 	}
 
 	ssp_dbg("[SSP]: MSG From MCU - %s\n", &data_frame[*data_index]);
@@ -286,6 +286,8 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 	for (idx = 0; idx < len;) {
 		switch (dataframe[idx++]) {
 		case SSP_MSG2AP_INST_BYPASS_DATA:
+			if (idx >= len)
+				return -EPROTO;
 			sd = dataframe[idx++];
 			if (sd < 0 || sd >= SSP_SENSOR_MAX) {
 				dev_err(SSP_DEV,
@@ -295,10 +297,13 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 
 			if (indio_devs[sd]) {
 				spd = iio_priv(indio_devs[sd]);
-				if (spd->process_data)
+				if (spd->process_data) {
+					if (idx >= len)
+						return -EPROTO;
 					spd->process_data(indio_devs[sd],
 							  &dataframe[idx],
 							  data->timestamp);
+				}
 			} else {
 				dev_err(SSP_DEV, "no client for frame\n");
 			}
@@ -306,6 +311,8 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 			idx += ssp_offset_map[sd];
 			break;
 		case SSP_MSG2AP_INST_DEBUG_DATA:
+			if (idx >= len)
+				return -EPROTO;
 			sd = ssp_print_mcu_debug(dataframe, &idx, len);
 			if (sd) {
 				dev_err(SSP_DEV,
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index b555552a0d803..d3a3d62869d83 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -510,8 +510,15 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
 {
 	struct i2c_client *client = to_i2c_client(st->dev);
 	__be16 data = cpu_to_be16(val);
+	int ret;
+
+	ret = i2c_master_send(client, (char *)&data, sizeof(data));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(data))
+		return -EIO;
 
-	return i2c_master_send(client, (char *)&data, sizeof(data));
+	return 0;
 }
 
 /**
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index be55477de2acc..0a0e52c95ff2d 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -283,6 +283,8 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		ret = wait_event_timeout(opt->result_ready_queue,
 				opt->result_ready,
 				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
+		if (ret == 0)
+			return -ETIMEDOUT;
 	} else {
 		/* Sleep for result ready time */
 		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
@@ -319,9 +321,7 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		/* Disallow IRQ to access the device while lock is active */
 		opt->ok_to_ignore_lock = false;
 
-	if (ret == 0)
-		return -ETIMEDOUT;
-	else if (ret < 0)
+	if (ret < 0)
 		return ret;
 
 	if (opt->use_irq) {
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 7284a9176844e..718d817265795 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -773,8 +773,10 @@ static int create_qp_common(struct mlx4_ib_dev *dev, struct ib_pd *pd,
 			if (dev->steering_support ==
 			    MLX4_STEERING_MODE_DEVICE_MANAGED)
 				qp->flags |= MLX4_IB_QP_NETIF;
-			else
+			else {
+				err = -EINVAL;
 				goto err;
+			}
 		}
 
 		memcpy(&backup_cap, &init_attr->cap, sizeof(backup_cap));
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 7603a1641c7d8..38c651f1a606b 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2015,15 +2015,18 @@ int qedr_query_qp(struct ib_qp *ibqp,
 	int rc = 0;
 
 	memset(&params, 0, sizeof(params));
-
-	rc = dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
-	if (rc)
-		goto err;
-
 	memset(qp_attr, 0, sizeof(*qp_attr));
 	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
 
-	qp_attr->qp_state = qedr_get_ibqp_state(params.state);
+	if (qp->qp_type != IB_QPT_GSI) {
+		rc = dev->ops->rdma_query_qp(dev->rdma_ctx, qp->qed_qp, &params);
+		if (rc)
+			goto err;
+		qp_attr->qp_state = qedr_get_ibqp_state(params.state);
+	} else {
+		qp_attr->qp_state = qedr_get_ibqp_state(QED_ROCE_QP_STATE_RTS);
+	}
+
 	qp_attr->cur_qp_state = qedr_get_ibqp_state(params.state);
 	qp_attr->path_mtu = iboe_get_mtu(params.mtu);
 	qp_attr->path_mig_state = IB_MIG_MIGRATED;
diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index 3e0677c512768..0dc15f95e7626 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -41,6 +41,7 @@
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
+#include <linux/overflow.h>
 
 #include "qib.h"
 #include "qib_user_sdma.h"
@@ -606,7 +607,7 @@ static int qib_user_sdma_coalesce(const struct qib_devdata *dd,
 /*
  * How many pages in this iovec element?
  */
-static int qib_user_sdma_num_pages(const struct iovec *iov)
+static size_t qib_user_sdma_num_pages(const struct iovec *iov)
 {
 	const unsigned long addr  = (unsigned long) iov->iov_base;
 	const unsigned long  len  = iov->iov_len;
@@ -662,7 +663,7 @@ static void qib_user_sdma_free_pkt_frag(struct device *dev,
 static int qib_user_sdma_pin_pages(const struct qib_devdata *dd,
 				   struct qib_user_sdma_queue *pq,
 				   struct qib_user_sdma_pkt *pkt,
-				   unsigned long addr, int tlen, int npages)
+				   unsigned long addr, int tlen, size_t npages)
 {
 	struct page *pages[8];
 	int i, j;
@@ -726,7 +727,7 @@ static int qib_user_sdma_pin_pkt(const struct qib_devdata *dd,
 	unsigned long idx;
 
 	for (idx = 0; idx < niov; idx++) {
-		const int npages = qib_user_sdma_num_pages(iov + idx);
+		const size_t npages = qib_user_sdma_num_pages(iov + idx);
 		const unsigned long addr = (unsigned long) iov[idx].iov_base;
 
 		ret = qib_user_sdma_pin_pages(dd, pq, pkt, addr,
@@ -828,8 +829,8 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		unsigned pktnw;
 		unsigned pktnwc;
 		int nfrags = 0;
-		int npages = 0;
-		int bytes_togo = 0;
+		size_t npages = 0;
+		size_t bytes_togo = 0;
 		int tiddma = 0;
 		int cfur;
 
@@ -889,7 +890,11 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 
 			npages += qib_user_sdma_num_pages(&iov[idx]);
 
-			bytes_togo += slen;
+			if (check_add_overflow(bytes_togo, slen, &bytes_togo) ||
+			    bytes_togo > type_max(typeof(pkt->bytes_togo))) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
 			pktnwc += slen >> 2;
 			idx++;
 			nfrags++;
@@ -908,10 +913,10 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		}
 
 		if (frag_size) {
-			int pktsize, tidsmsize, n;
+			size_t tidsmsize, n, pktsize, sz, addrlimit;
 
 			n = npages*((2*PAGE_SIZE/frag_size)+1);
-			pktsize = sizeof(*pkt) + sizeof(pkt->addr[0])*n;
+			pktsize = struct_size(pkt, addr, n);
 
 			/*
 			 * Determine if this is tid-sdma or just sdma.
@@ -926,14 +931,24 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 			else
 				tidsmsize = 0;
 
-			pkt = kmalloc(pktsize+tidsmsize, GFP_KERNEL);
+			if (check_add_overflow(pktsize, tidsmsize, &sz)) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
+			pkt = kmalloc(sz, GFP_KERNEL);
 			if (!pkt) {
 				ret = -ENOMEM;
 				goto free_pbc;
 			}
 			pkt->largepkt = 1;
 			pkt->frag_size = frag_size;
-			pkt->addrlimit = n + ARRAY_SIZE(pkt->addr);
+			if (check_add_overflow(n, ARRAY_SIZE(pkt->addr),
+					       &addrlimit) ||
+			    addrlimit > type_max(typeof(pkt->addrlimit))) {
+				ret = -EINVAL;
+				goto free_pbc;
+			}
+			pkt->addrlimit = addrlimit;
 
 			if (tiddma) {
 				char *tidsm = (char *)pkt + pktsize;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 13ed2cc6eaa2a..9f7817e12775a 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -144,7 +144,7 @@ enum rxe_port_param {
 	RXE_PORT_MAX_MTU		= IB_MTU_4096,
 	RXE_PORT_ACTIVE_MTU		= IB_MTU_256,
 	RXE_PORT_GID_TBL_LEN		= 1024,
-	RXE_PORT_PORT_CAP_FLAGS		= RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
+	RXE_PORT_PORT_CAP_FLAGS		= IB_PORT_CM_SUP,
 	RXE_PORT_MAX_MSG_SZ		= 0x800000,
 	RXE_PORT_BAD_PKEY_CNTR		= 0,
 	RXE_PORT_QKEY_VIOL_CNTR		= 0,
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4168ed0ef187e..f8f6bd92e314c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -348,6 +348,7 @@ static const struct xpad_device {
 	{ 0x24c6, 0x5b03, "Thrustmaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0xfafe, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
@@ -464,6 +465,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
 	XPAD_XBOXONE_VENDOR(0x2e24),		/* Hyperkin Duke X-Box One pad */
 	XPAD_XBOX360_VENDOR(0x2f24),		/* GameSir Controllers */
+	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
 	{ }
 };
 
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 15be3ee6cc501..4aba40c881a73 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -431,6 +431,19 @@ static void elantech_report_trackpoint(struct psmouse *psmouse,
 	case 0x16008020U:
 	case 0x26800010U:
 	case 0x36808000U:
+
+		/*
+		 * This firmware misreport coordinates for trackpoint
+		 * occasionally. Discard packets outside of [-127, 127] range
+		 * to prevent cursor jumps.
+		 */
+		if (packet[4] == 0x80 || packet[5] == 0x80 ||
+		    packet[1] >> 7 == packet[4] >> 7 ||
+		    packet[2] >> 7 == packet[5] >> 7) {
+			elantech_debug("discarding packet [%6ph]\n", packet);
+			break;
+
+		}
 		x = packet[4] - (int)((packet[1]^0x80) << 1);
 		y = (int)((packet[2]^0x80) << 1) - packet[5];
 
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 3049bccf24227..323b86b38b3a3 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -276,6 +276,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
 		},
 	},
+	{
+		/* Fujitsu Lifebook T725 laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
+		},
+	},
 	{
 		/* Fujitsu Lifebook U745 */
 		.matches = {
@@ -916,6 +923,13 @@ static const struct dmi_system_id __initconst i8042_dmi_notimeout_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK AH544"),
 		},
 	},
+	{
+		/* Fujitsu Lifebook T725 laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
+		},
+	},
 	{
 		/* Fujitsu U574 laptop */
 		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index daa4ae89e466e..7ed976d436b25 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -143,7 +143,7 @@ static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
 			irq = irq_linear_revmap(intc->domain, base + hwirq);
 			if (irq)
-				do_IRQ(irq);
+				generic_handle_irq(irq);
 			else
 				spurious_interrupt();
 		}
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index c25ce5af091ad..e92ab62cc87d9 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -368,11 +368,25 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
 {
 	do {
-		if (likely(s3c_intc[0]))
-			if (s3c24xx_handle_intc(s3c_intc[0], regs, 0))
-				continue;
+		/*
+		 * For platform based machines, neither ERR nor NULL can happen here.
+		 * The s3c24xx_handle_irq() will be set as IRQ handler iff this succeeds:
+		 *
+		 *    s3c_intc[0] = s3c24xx_init_intc()
+		 *
+		 * If this fails, the next calls to s3c24xx_init_intc() won't be executed.
+		 *
+		 * For DT machine, s3c_init_intc_of() could set the IRQ handler without
+		 * setting s3c_intc[0] only if it was called with num_ctrl=0. There is no
+		 * such code path, so again the s3c_intc[0] will have a valid pointer if
+		 * set_handle_irq() is called.
+		 *
+		 * Therefore in s3c24xx_handle_irq(), the s3c_intc[0] is always something.
+		 */
+		if (s3c24xx_handle_intc(s3c_intc[0], regs, 0))
+			continue;
 
-		if (s3c_intc[2])
+		if (!IS_ERR_OR_NULL(s3c_intc[2]))
 			if (s3c24xx_handle_intc(s3c_intc[2], regs, 64))
 				continue;
 
diff --git a/drivers/isdn/capi/kcapi.c b/drivers/isdn/capi/kcapi.c
index 9de62c3b8bf9f..658e116d8fe66 100644
--- a/drivers/isdn/capi/kcapi.c
+++ b/drivers/isdn/capi/kcapi.c
@@ -564,6 +564,11 @@ int detach_capi_ctr(struct capi_ctr *ctr)
 
 	ctr_down(ctr, CAPI_CTR_DETACHED);
 
+	if (ctr->cnr < 1 || ctr->cnr - 1 >= CAPI_MAXCONTR) {
+		err = -EINVAL;
+		goto unlock_out;
+	}
+
 	if (capi_controller[ctr->cnr - 1] != ctr) {
 		err = -EINVAL;
 		goto unlock_out;
diff --git a/drivers/isdn/hardware/mISDN/netjet.c b/drivers/isdn/hardware/mISDN/netjet.c
index 6dea4c180c494..feada9d7cbcc2 100644
--- a/drivers/isdn/hardware/mISDN/netjet.c
+++ b/drivers/isdn/hardware/mISDN/netjet.c
@@ -963,8 +963,8 @@ nj_release(struct tiger_hw *card)
 		nj_disable_hwirq(card);
 		mode_tiger(&card->bc[0], ISDN_P_NONE);
 		mode_tiger(&card->bc[1], ISDN_P_NONE);
-		card->isac.release(&card->isac);
 		spin_unlock_irqrestore(&card->lock, flags);
+		card->isac.release(&card->isac);
 		release_region(card->base, card->base_s);
 		card->base_s = 0;
 	}
diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
index 237737fec09c1..e6159faff45af 100644
--- a/drivers/media/i2c/mt9p031.c
+++ b/drivers/media/i2c/mt9p031.c
@@ -81,7 +81,9 @@
 #define		MT9P031_PIXEL_CLOCK_INVERT		(1 << 15)
 #define		MT9P031_PIXEL_CLOCK_SHIFT(n)		((n) << 8)
 #define		MT9P031_PIXEL_CLOCK_DIVIDE(n)		((n) << 0)
-#define MT9P031_FRAME_RESTART				0x0b
+#define MT9P031_RESTART					0x0b
+#define		MT9P031_FRAME_PAUSE_RESTART		(1 << 1)
+#define		MT9P031_FRAME_RESTART			(1 << 0)
 #define MT9P031_SHUTTER_DELAY				0x0c
 #define MT9P031_RST					0x0d
 #define		MT9P031_RST_ENABLE			1
@@ -448,9 +450,23 @@ static int mt9p031_set_params(struct mt9p031 *mt9p031)
 static int mt9p031_s_stream(struct v4l2_subdev *subdev, int enable)
 {
 	struct mt9p031 *mt9p031 = to_mt9p031(subdev);
+	struct i2c_client *client = v4l2_get_subdevdata(subdev);
+	int val;
 	int ret;
 
 	if (!enable) {
+		/* enable pause restart */
+		val = MT9P031_FRAME_PAUSE_RESTART;
+		ret = mt9p031_write(client, MT9P031_RESTART, val);
+		if (ret < 0)
+			return ret;
+
+		/* enable restart + keep pause restart set */
+		val |= MT9P031_FRAME_RESTART;
+		ret = mt9p031_write(client, MT9P031_RESTART, val);
+		if (ret < 0)
+			return ret;
+
 		/* Stop sensor readout */
 		ret = mt9p031_set_output_control(mt9p031,
 						 MT9P031_OUTPUT_CONTROL_CEN, 0);
@@ -470,6 +486,16 @@ static int mt9p031_s_stream(struct v4l2_subdev *subdev, int enable)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * - clear pause restart
+	 * - don't clear restart as clearing restart manually can cause
+	 *   undefined behavior
+	 */
+	val = MT9P031_FRAME_RESTART;
+	ret = mt9p031_write(client, MT9P031_RESTART, val);
+	if (ret < 0)
+		return ret;
+
 	return mt9p031_pll_enable(mt9p031);
 }
 
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index b078ac2a682cf..48e1f4a128019 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -266,19 +266,24 @@ static irqreturn_t netup_unidvb_isr(int irq, void *dev_id)
 	if ((reg40 & AVL_IRQ_ASSERTED) != 0) {
 		/* IRQ is being signaled */
 		reg_isr = readw(ndev->bmmio0 + REG_ISR);
-		if (reg_isr & NETUP_UNIDVB_IRQ_I2C0) {
-			iret = netup_i2c_interrupt(&ndev->i2c[0]);
-		} else if (reg_isr & NETUP_UNIDVB_IRQ_I2C1) {
-			iret = netup_i2c_interrupt(&ndev->i2c[1]);
-		} else if (reg_isr & NETUP_UNIDVB_IRQ_SPI) {
+		if (reg_isr & NETUP_UNIDVB_IRQ_SPI)
 			iret = netup_spi_interrupt(ndev->spi);
-		} else if (reg_isr & NETUP_UNIDVB_IRQ_DMA1) {
-			iret = netup_dma_interrupt(&ndev->dma[0]);
-		} else if (reg_isr & NETUP_UNIDVB_IRQ_DMA2) {
-			iret = netup_dma_interrupt(&ndev->dma[1]);
-		} else if (reg_isr & NETUP_UNIDVB_IRQ_CI) {
-			iret = netup_ci_interrupt(ndev);
+		else if (!ndev->old_fw) {
+			if (reg_isr & NETUP_UNIDVB_IRQ_I2C0) {
+				iret = netup_i2c_interrupt(&ndev->i2c[0]);
+			} else if (reg_isr & NETUP_UNIDVB_IRQ_I2C1) {
+				iret = netup_i2c_interrupt(&ndev->i2c[1]);
+			} else if (reg_isr & NETUP_UNIDVB_IRQ_DMA1) {
+				iret = netup_dma_interrupt(&ndev->dma[0]);
+			} else if (reg_isr & NETUP_UNIDVB_IRQ_DMA2) {
+				iret = netup_dma_interrupt(&ndev->dma[1]);
+			} else if (reg_isr & NETUP_UNIDVB_IRQ_CI) {
+				iret = netup_ci_interrupt(ndev);
+			} else {
+				goto err;
+			}
 		} else {
+err:
 			dev_err(&pci_dev->dev,
 				"%s(): unknown interrupt 0x%x\n",
 				__func__, reg_isr);
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index c9bf58c978780..9c332ce8cdfec 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -801,7 +801,8 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 	vpu->wdt.wq = create_singlethread_workqueue("vpu_wdt");
 	if (!vpu->wdt.wq) {
 		dev_err(dev, "initialize wdt workqueue failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto clk_unprepare;
 	}
 	INIT_WORK(&vpu->wdt.ws, vpu_wdt_reset_func);
 	mutex_init(&vpu->vpu_mutex);
@@ -900,6 +901,8 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 	vpu_clock_disable(vpu);
 workqueue_destroy:
 	destroy_workqueue(vpu->wdt.wq);
+clk_unprepare:
+	clk_unprepare(vpu->clk);
 
 	return ret;
 }
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 8051c13456922..0ff972b8d9671 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1160,7 +1160,7 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 	spin_lock_init(&dev->condlock);
 	dev->plat_dev = pdev;
 	if (!dev->plat_dev) {
-		dev_err(&pdev->dev, "No platform data specified\n");
+		mfc_err("No platform data specified\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index 8f3086773db46..6162aa5758428 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -24,7 +24,7 @@
 
 /* driver definitions */
 #define DRIVER_AUTHOR "Joonyoung Shim <jy0922.shim@samsung.com>";
-#define DRIVER_CARD "Silicon Labs Si470x FM Radio Receiver"
+#define DRIVER_CARD "Silicon Labs Si470x FM Radio"
 #define DRIVER_DESC "I2C radio driver for Si470x FM Radio Receivers"
 #define DRIVER_VERSION "1.0.2"
 
diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index 1d045a8c29e21..a8a0ff9a1f838 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -29,7 +29,7 @@
 
 /* driver definitions */
 #define DRIVER_AUTHOR "Tobias Lorenz <tobias.lorenz@gmx.net>"
-#define DRIVER_CARD "Silicon Labs Si470x FM Radio Receiver"
+#define DRIVER_CARD "Silicon Labs Si470x FM Radio"
 #define DRIVER_DESC "USB radio driver for Si470x FM Radio Receivers"
 #define DRIVER_VERSION "1.0.10"
 
diff --git a/drivers/media/rc/ite-cir.c b/drivers/media/rc/ite-cir.c
index 7d3e50d94d86a..e8bc02ce9b2ff 100644
--- a/drivers/media/rc/ite-cir.c
+++ b/drivers/media/rc/ite-cir.c
@@ -299,7 +299,7 @@ static irqreturn_t ite_cir_isr(int irq, void *data)
 	}
 
 	/* check for the receive interrupt */
-	if (iflags & ITE_IRQ_RX_FIFO) {
+	if (iflags & (ITE_IRQ_RX_FIFO | ITE_IRQ_RX_FIFO_OVERRUN)) {
 		/* read the FIFO bytes */
 		rx_bytes =
 			dev->params.get_rx_bytes(dev, rx_buf,
diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index d9f88a4a96bd1..b78d70685b1c3 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -1090,6 +1090,7 @@ static void mceusb_dev_recv(struct urb *urb)
 	case -ECONNRESET:
 	case -ENOENT:
 	case -EILSEQ:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		usb_unlink_urb(urb);
 		return;
diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index 2e711362847e4..382c8075ef524 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -394,6 +394,7 @@ static struct rc_map_table rc_map_az6027_table[] = {
 /* remote control stuff (does not work with my box) */
 static int az6027_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
 {
+	*state = REMOTE_NO_KEY_PRESSED;
 	return 0;
 }
 
diff --git a/drivers/media/usb/dvb-usb/dibusb-common.c b/drivers/media/usb/dvb-usb/dibusb-common.c
index bcacb0f220282..3e45642ae186b 100644
--- a/drivers/media/usb/dvb-usb/dibusb-common.c
+++ b/drivers/media/usb/dvb-usb/dibusb-common.c
@@ -226,7 +226,7 @@ int dibusb_read_eeprom_byte(struct dvb_usb_device *d, u8 offs, u8 *val)
 	u8 *buf;
 	int rc;
 
-	buf = kmalloc(2, GFP_KERNEL);
+	buf = kzalloc(2, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 4a270f88aa18c..2b1e06e825f0d 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -451,10 +451,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	uvc_simplify_fraction(&timeperframe.numerator,
 		&timeperframe.denominator, 8, 333);
 
-	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		parm->parm.capture.timeperframe = timeperframe;
-	else
+		parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	} else {
 		parm->parm.output.timeperframe = timeperframe;
+		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	}
 
 	return 0;
 }
diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 38b945eb410f3..9c0e70b047c39 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -276,7 +276,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 
 	ret = fsl_ifc_ctrl_init(fsl_ifc_ctrl_dev);
 	if (ret < 0)
-		goto err;
+		goto err_unmap_nandirq;
 
 	init_waitqueue_head(&fsl_ifc_ctrl_dev->nand_wait);
 
@@ -285,7 +285,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 	if (ret != 0) {
 		dev_err(&dev->dev, "failed to install irq (%d)\n",
 			fsl_ifc_ctrl_dev->irq);
-		goto err_irq;
+		goto err_unmap_nandirq;
 	}
 
 	if (fsl_ifc_ctrl_dev->nand_irq) {
@@ -294,17 +294,16 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 		if (ret != 0) {
 			dev_err(&dev->dev, "failed to install irq (%d)\n",
 				fsl_ifc_ctrl_dev->nand_irq);
-			goto err_nandirq;
+			goto err_free_irq;
 		}
 	}
 
 	return 0;
 
-err_nandirq:
-	free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
-	irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
-err_irq:
+err_free_irq:
 	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
+err_unmap_nandirq:
+	irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
 	irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
 err:
 	iounmap(fsl_ifc_ctrl_dev->gregs);
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index aacf584f2a42e..45136b700d2c4 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1730,7 +1730,7 @@ static int msb_init_card(struct memstick_dev *card)
 	msb->pages_in_block = boot_block->attr.block_size * 2;
 	msb->block_size = msb->page_size * msb->pages_in_block;
 
-	if (msb->page_size > PAGE_SIZE) {
+	if ((size_t)msb->page_size > PAGE_SIZE) {
 		/* this isn't supported by linux at all, anyway*/
 		dbg("device page %d size isn't supported", msb->page_size);
 		return -EINVAL;
diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 08fa6400d2558..ba6cd576e9979 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -905,7 +905,7 @@ static struct memstick_host *jmb38x_ms_alloc_host(struct jmb38x_ms *jm, int cnt)
 
 	iounmap(host->addr);
 err_out_free:
-	kfree(msh);
+	memstick_free_host(msh);
 	return NULL;
 }
 
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 2539984c1db1c..256634ec58b63 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -841,15 +841,15 @@ static void r592_remove(struct pci_dev *pdev)
 	}
 	memstick_remove_host(dev->host);
 
+	if (dev->dummy_dma_page)
+		dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
+			dev->dummy_dma_page_physical_address);
+
 	free_irq(dev->irq, dev);
 	iounmap(dev->mmio);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	memstick_free_host(dev->host);
-
-	if (dev->dummy_dma_page)
-		dma_free_coherent(&pdev->dev, PAGE_SIZE, dev->dummy_dma_page,
-			dev->dummy_dma_page_physical_address);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/misc/cb710/sgbuf2.c b/drivers/misc/cb710/sgbuf2.c
index 2a40d0efdff5d..4d2a72a537d42 100644
--- a/drivers/misc/cb710/sgbuf2.c
+++ b/drivers/misc/cb710/sgbuf2.c
@@ -50,7 +50,7 @@ static inline bool needs_unaligned_copy(const void *ptr)
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	return false;
 #else
-	return ((ptr - NULL) & 3) != 0;
+	return ((uintptr_t)ptr & 3) != 0;
 #endif
 }
 
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5274f503a39ad..5c0bc817019f7 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -367,7 +367,7 @@ config MMC_OMAP_HS
 
 config MMC_WBSD
 	tristate "Winbond W83L51xD SD/MMC Card Interface support"
-	depends on ISA_DMA_API
+	depends on ISA_DMA_API && !M68K
 	help
 	  This selects the Winbond(R) W83L51xD Secure digital and
           Multimedia card Interface.
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 7ab3d749b5aee..48aed0dc84a58 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -440,6 +440,18 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
 		}
 	}
 
+	/*
+	 * If there is no cadiates value, then it needs to return -EIO.
+	 * If there are candiates values and don't find bset clk sample value,
+	 * then use a first candiates clock sample value.
+	 */
+	for (i = 0; i < iter; i++) {
+		__c = ror8(candiates, i);
+		if ((__c & 0x1) == 0x1) {
+			loc = i;
+			goto out;
+		}
+	}
 out:
 	return loc;
 }
@@ -470,6 +482,8 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		priv->tuned_sample = found;
 	} else {
 		ret = -EIO;
+		dev_warn(&mmc->class_dev,
+			"There is no candiates value about clksmpl!\n");
 	}
 
 	return ret;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 209bdf0317b34..1c80717af333e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1862,7 +1862,8 @@ static void dw_mci_tasklet_func(unsigned long priv)
 				 * delayed. Allowing the transfer to take place
 				 * avoids races and keeps things simple.
 				 */
-				if (err != -ETIMEDOUT) {
+				if (err != -ETIMEDOUT &&
+				    host->dir_status == DW_MCI_RECV_STATUS) {
 					state = STATE_SENDING_DATA;
 					continue;
 				}
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 687fd68fbbcd1..77a03301b2a58 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -571,6 +571,11 @@ static const struct of_device_id mxs_mmc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
 
+static void mxs_mmc_regulator_disable(void *regulator)
+{
+	regulator_disable(regulator);
+}
+
 static int mxs_mmc_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -614,6 +619,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 				"Failed to enable vmmc regulator: %d\n", ret);
 			goto out_mmc_free;
 		}
+
+		ret = devm_add_action_or_reset(&pdev->dev, mxs_mmc_regulator_disable,
+					       reg_vmmc);
+		if (ret)
+			goto out_mmc_free;
 	}
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0325083b10493..560b2996911ac 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1421,6 +1421,12 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			break;
 		case MMC_VDD_32_33:
 		case MMC_VDD_33_34:
+		/*
+		 * 3.4 ~ 3.6V are valid only for those platforms where it's
+		 * known that the voltage range is supported by hardware.
+		 */
+		case MMC_VDD_34_35:
+		case MMC_VDD_35_36:
 			pwr = SDHCI_POWER_330;
 			break;
 		default:
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index a3e4288e5391b..875e438ab9738 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -579,7 +579,7 @@ static void check_vub300_port_status(struct vub300_mmc_host *vub300)
 				GET_SYSTEM_PORT_STATUS,
 				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				0x0000, 0x0000, &vub300->system_port_status,
-				sizeof(vub300->system_port_status), HZ);
+				sizeof(vub300->system_port_status), 1000);
 	if (sizeof(vub300->system_port_status) == retval)
 		new_system_port_status(vub300);
 }
@@ -1245,7 +1245,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 						SET_INTERRUPT_PSEUDOCODE,
 						USB_DIR_OUT | USB_TYPE_VENDOR |
 						USB_RECIP_DEVICE, 0x0000, 0x0000,
-						xfer_buffer, xfer_length, HZ);
+						xfer_buffer, xfer_length, 1000);
 			kfree(xfer_buffer);
 			if (retval < 0) {
 				strncpy(vub300->vub_name,
@@ -1292,7 +1292,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 						SET_TRANSFER_PSEUDOCODE,
 						USB_DIR_OUT | USB_TYPE_VENDOR |
 						USB_RECIP_DEVICE, 0x0000, 0x0000,
-						xfer_buffer, xfer_length, HZ);
+						xfer_buffer, xfer_length, 1000);
 			kfree(xfer_buffer);
 			if (retval < 0) {
 				strncpy(vub300->vub_name,
@@ -1998,7 +1998,7 @@ static void __set_clock_speed(struct vub300_mmc_host *vub300, u8 buf[8],
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_CLOCK_SPEED,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x00, 0x00, buf, buf_array_size, HZ);
+				0x00, 0x00, buf, buf_array_size, 1000);
 	if (retval != 8) {
 		dev_err(&vub300->udev->dev, "SET_CLOCK_SPEED"
 			" %dkHz failed with retval=%d\n", kHzClock, retval);
@@ -2020,14 +2020,14 @@ static void vub300_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_SD_POWER,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x0000, 0x0000, NULL, 0, HZ);
+				0x0000, 0x0000, NULL, 0, 1000);
 		/* must wait for the VUB300 u-proc to boot up */
 		msleep(600);
 	} else if ((ios->power_mode == MMC_POWER_UP) && !vub300->card_powered) {
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_SD_POWER,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x0001, 0x0000, NULL, 0, HZ);
+				0x0001, 0x0000, NULL, 0, 1000);
 		msleep(600);
 		vub300->card_powered = 1;
 	} else if (ios->power_mode == MMC_POWER_ON) {
@@ -2288,14 +2288,14 @@ static int vub300_probe(struct usb_interface *interface,
 				GET_HC_INF0,
 				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				0x0000, 0x0000, &vub300->hc_info,
-				sizeof(vub300->hc_info), HZ);
+				sizeof(vub300->hc_info), 1000);
 	if (retval < 0)
 		goto error5;
 	retval =
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_ROM_WAIT_STATES,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				firmware_rom_wait_states, 0x0000, NULL, 0, HZ);
+				firmware_rom_wait_states, 0x0000, NULL, 0, 1000);
 	if (retval < 0)
 		goto error5;
 	dev_info(&vub300->udev->dev,
@@ -2310,7 +2310,7 @@ static int vub300_probe(struct usb_interface *interface,
 				GET_SYSTEM_PORT_STATUS,
 				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				0x0000, 0x0000, &vub300->system_port_status,
-				sizeof(vub300->system_port_status), HZ);
+				sizeof(vub300->system_port_status), 1000);
 	if (retval < 0) {
 		goto error4;
 	} else if (sizeof(vub300->system_port_status) == retval) {
diff --git a/drivers/mtd/spi-nor/hisi-sfc.c b/drivers/mtd/spi-nor/hisi-sfc.c
index 68be79ba571df..a0c2101f0b486 100644
--- a/drivers/mtd/spi-nor/hisi-sfc.c
+++ b/drivers/mtd/spi-nor/hisi-sfc.c
@@ -467,7 +467,6 @@ static int hisi_spi_nor_remove(struct platform_device *pdev)
 
 	hisi_spi_nor_unregister_all(host);
 	mutex_destroy(&host->lock);
-	clk_disable_unprepare(host->clk);
 	return 0;
 }
 
diff --git a/drivers/net/bonding/bond_sysfs_slave.c b/drivers/net/bonding/bond_sysfs_slave.c
index 68bbac4715c35..1e1e77a40f182 100644
--- a/drivers/net/bonding/bond_sysfs_slave.c
+++ b/drivers/net/bonding/bond_sysfs_slave.c
@@ -112,15 +112,15 @@ static ssize_t ad_partner_oper_port_state_show(struct slave *slave, char *buf)
 }
 static SLAVE_ATTR_RO(ad_partner_oper_port_state);
 
-static const struct slave_attribute *slave_attrs[] = {
-	&slave_attr_state,
-	&slave_attr_mii_status,
-	&slave_attr_link_failure_count,
-	&slave_attr_perm_hwaddr,
-	&slave_attr_queue_id,
-	&slave_attr_ad_aggregator_id,
-	&slave_attr_ad_actor_oper_port_state,
-	&slave_attr_ad_partner_oper_port_state,
+static const struct attribute *slave_attrs[] = {
+	&slave_attr_state.attr,
+	&slave_attr_mii_status.attr,
+	&slave_attr_link_failure_count.attr,
+	&slave_attr_perm_hwaddr.attr,
+	&slave_attr_queue_id.attr,
+	&slave_attr_ad_aggregator_id.attr,
+	&slave_attr_ad_actor_oper_port_state.attr,
+	&slave_attr_ad_partner_oper_port_state.attr,
 	NULL
 };
 
@@ -141,24 +141,10 @@ const struct sysfs_ops slave_sysfs_ops = {
 
 int bond_sysfs_slave_add(struct slave *slave)
 {
-	const struct slave_attribute **a;
-	int err;
-
-	for (a = slave_attrs; *a; ++a) {
-		err = sysfs_create_file(&slave->kobj, &((*a)->attr));
-		if (err) {
-			kobject_put(&slave->kobj);
-			return err;
-		}
-	}
-
-	return 0;
+	return sysfs_create_files(&slave->kobj, slave_attrs);
 }
 
 void bond_sysfs_slave_del(struct slave *slave)
 {
-	const struct slave_attribute **a;
-
-	for (a = slave_attrs; *a; ++a)
-		sysfs_remove_file(&slave->kobj, &((*a)->attr));
+	sysfs_remove_files(&slave->kobj, slave_attrs);
 }
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 9b2c3bd00f8b4..2ac33ee1067eb 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -858,10 +858,12 @@ static int __maybe_unused rcar_can_suspend(struct device *dev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	u16 ctlr;
 
-	if (netif_running(ndev)) {
-		netif_stop_queue(ndev);
-		netif_device_detach(ndev);
-	}
+	if (!netif_running(ndev))
+		return 0;
+
+	netif_stop_queue(ndev);
+	netif_device_detach(ndev);
+
 	ctlr = readw(&priv->regs->ctlr);
 	ctlr |= RCAR_CAN_CTLR_CANM_HALT;
 	writew(ctlr, &priv->regs->ctlr);
@@ -880,6 +882,9 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 	u16 ctlr;
 	int err;
 
+	if (!netif_running(ndev))
+		return 0;
+
 	err = clk_enable(priv->clk);
 	if (err) {
 		netdev_err(ndev, "clk_enable() failed, error %d\n", err);
@@ -893,10 +898,9 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 	writew(ctlr, &priv->regs->ctlr);
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	if (netif_running(ndev)) {
-		netif_device_attach(ndev);
-		netif_start_queue(ndev);
-	}
+	netif_device_attach(ndev);
+	netif_start_queue(ndev);
+
 	return 0;
 }
 
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 131026fbc2d77..e12fc5d88382d 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -736,16 +736,15 @@ static void peak_pci_remove(struct pci_dev *pdev)
 		struct net_device *prev_dev = chan->prev_dev;
 
 		dev_info(&pdev->dev, "removing device %s\n", dev->name);
+		/* do that only for first channel */
+		if (!prev_dev && chan->pciec_card)
+			peak_pciec_remove(chan->pciec_card);
 		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
 		dev = prev_dev;
 
-		if (!dev) {
-			/* do that only for first channel */
-			if (chan->pciec_card)
-				peak_pciec_remove(chan->pciec_card);
+		if (!dev)
 			break;
-		}
 		priv = netdev_priv(dev);
 		chan = priv->priv;
 	}
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index d314e73f3d061..e7ffc073fbd68 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -559,11 +559,10 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	} else if (sm->channel_p_w_b & PUCAN_BUS_WARNING) {
 		new_state = CAN_STATE_ERROR_WARNING;
 	} else {
-		/* no error bit (so, no error skb, back to active state) */
-		dev->can.state = CAN_STATE_ERROR_ACTIVE;
+		/* back to (or still in) ERROR_ACTIVE state */
+		new_state = CAN_STATE_ERROR_ACTIVE;
 		pdev->bec.txerr = 0;
 		pdev->bec.rxerr = 0;
-		return 0;
 	}
 
 	/* state hasn't changed */
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 8cc7467b6c1f6..8c80ca4b8ae18 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -96,6 +96,7 @@ config JME
 config KORINA
 	tristate "Korina (IDT RC32434) Ethernet support"
 	depends on MIKROTIK_RB532
+	select CRC32
 	---help---
 	  If you have a Mikrotik RouterBoard 500 or IDT RC32434
 	  based system say Y. Otherwise say N.
diff --git a/drivers/net/ethernet/arc/Kconfig b/drivers/net/ethernet/arc/Kconfig
index 689045186064a..ef4988716cf44 100644
--- a/drivers/net/ethernet/arc/Kconfig
+++ b/drivers/net/ethernet/arc/Kconfig
@@ -19,6 +19,7 @@ config ARC_EMAC_CORE
 	tristate
 	select MII
 	select PHYLIB
+	select CRC32
 
 config ARC_EMAC
 	tristate "ARC EMAC support"
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init_ops.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init_ops.h
index 1835d2e451c01..fc7fce642666c 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init_ops.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_init_ops.h
@@ -635,11 +635,13 @@ static int bnx2x_ilt_client_mem_op(struct bnx2x *bp, int cli_num,
 {
 	int i, rc;
 	struct bnx2x_ilt *ilt = BP_ILT(bp);
-	struct ilt_client_info *ilt_cli = &ilt->clients[cli_num];
+	struct ilt_client_info *ilt_cli;
 
 	if (!ilt || !ilt->lines)
 		return -1;
 
+	ilt_cli = &ilt->clients[cli_num];
+
 	if (ilt_cli->flags & (ILT_CLIENT_SKIP_INIT | ILT_CLIENT_SKIP_MEM))
 		return 0;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 832fffed4a1fa..e7585f6c4665b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6646,7 +6646,7 @@ static int i40e_get_capabilities(struct i40e_pf *pf)
 		if (pf->hw.aq.asq_last_status == I40E_AQ_RC_ENOMEM) {
 			/* retry with a larger buffer */
 			buf_len = data_size;
-		} else if (pf->hw.aq.asq_last_status != I40E_AQ_RC_OK) {
+		} else if (pf->hw.aq.asq_last_status != I40E_AQ_RC_OK || err) {
 			dev_info(&pf->pdev->dev,
 				 "capability discovery failed, err %s aq_err %s\n",
 				 i40e_stat_str(&pf->hw, err),
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 537776a3e5de1..9ba36425a3ddd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1889,7 +1889,7 @@ static void i40evf_adminq_task(struct work_struct *work)
 
 	/* check for error indications */
 	val = rd32(hw, hw->aq.arq.len);
-	if (val == 0xdeadbeef) /* indicates device in reset */
+	if (val == 0xdeadbeef || val == 0xffffffff) /* device in reset */
 		goto freedom;
 	oldval = val;
 	if (val & I40E_VF_ARQLEN1_ARQVFE_MASK) {
diff --git a/drivers/net/ethernet/microchip/encx24j600-regmap.c b/drivers/net/ethernet/microchip/encx24j600-regmap.c
index f3bb9055a2927..b5de665ce7189 100644
--- a/drivers/net/ethernet/microchip/encx24j600-regmap.c
+++ b/drivers/net/ethernet/microchip/encx24j600-regmap.c
@@ -500,13 +500,19 @@ static struct regmap_bus phymap_encx24j600 = {
 	.reg_read = regmap_encx24j600_phy_reg_read,
 };
 
-void devm_regmap_init_encx24j600(struct device *dev,
-				 struct encx24j600_context *ctx)
+int devm_regmap_init_encx24j600(struct device *dev,
+				struct encx24j600_context *ctx)
 {
 	mutex_init(&ctx->mutex);
 	regcfg.lock_arg = ctx;
 	ctx->regmap = devm_regmap_init(dev, &regmap_encx24j600, ctx, &regcfg);
+	if (IS_ERR(ctx->regmap))
+		return PTR_ERR(ctx->regmap);
 	ctx->phymap = devm_regmap_init(dev, &phymap_encx24j600, ctx, &phycfg);
+	if (IS_ERR(ctx->phymap))
+		return PTR_ERR(ctx->phymap);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(devm_regmap_init_encx24j600);
 
diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index ad661d1979c78..906751f78ef6c 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -1015,10 +1015,13 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 	priv->speed = SPEED_100;
 
 	priv->ctx.spi = spi;
-	devm_regmap_init_encx24j600(&spi->dev, &priv->ctx);
 	ndev->irq = spi->irq;
 	ndev->netdev_ops = &encx24j600_netdev_ops;
 
+	ret = devm_regmap_init_encx24j600(&spi->dev, &priv->ctx);
+	if (ret)
+		goto out_free;
+
 	mutex_init(&priv->lock);
 
 	/* Reset device and check if it is connected */
diff --git a/drivers/net/ethernet/microchip/encx24j600_hw.h b/drivers/net/ethernet/microchip/encx24j600_hw.h
index 4be73d5553f89..c9b17ccf749ce 100644
--- a/drivers/net/ethernet/microchip/encx24j600_hw.h
+++ b/drivers/net/ethernet/microchip/encx24j600_hw.h
@@ -14,8 +14,8 @@ struct encx24j600_context {
 	int bank;
 };
 
-void devm_regmap_init_encx24j600(struct device *dev,
-				 struct encx24j600_context *ctx);
+int devm_regmap_init_encx24j600(struct device *dev,
+				struct encx24j600_context *ctx);
 
 /* Single-byte instructions */
 #define BANK_SELECT(bank) (0xC0 | ((bank & (BANK_MASK >> BANK_SHIFT)) << 1))
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index eaa37c079a7cd..a1447d7ff48b5 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -8618,7 +8618,7 @@ static void s2io_io_resume(struct pci_dev *pdev)
 			return;
 		}
 
-		if (s2io_set_mac_addr(netdev, netdev->dev_addr) == FAILURE) {
+		if (do_s2io_prog_unicast(netdev, netdev->dev_addr) == FAILURE) {
 			s2io_card_down(sp);
 			pr_err("Can't restore mac addr after reset.\n");
 			return;
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 9b98ec3dcb82e..ad7b9772a4b27 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1039,9 +1039,6 @@ static int lpc_eth_close(struct net_device *ndev)
 	napi_disable(&pldat->napi);
 	netif_stop_queue(ndev);
 
-	if (ndev->phydev)
-		phy_stop(ndev->phydev);
-
 	spin_lock_irqsave(&pldat->lock, flags);
 	__lpc_eth_reset(pldat);
 	netif_carrier_off(ndev);
@@ -1049,6 +1046,8 @@ static int lpc_eth_close(struct net_device *ndev)
 	writel(0, LPC_ENET_MAC2(pldat->net_base));
 	spin_unlock_irqrestore(&pldat->lock, flags);
 
+	if (ndev->phydev)
+		phy_stop(ndev->phydev);
 	clk_disable_unprepare(pldat->clk);
 
 	return 0;
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 04cbff7f1b23d..a48ff6fc66b44 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -494,7 +494,7 @@ static int efx_ptp_get_attributes(struct efx_nic *efx)
 	} else if (rc == -EINVAL) {
 		fmt = MC_CMD_PTP_OUT_GET_ATTRIBUTES_SECONDS_NANOSECONDS;
 	} else if (rc == -EPERM) {
-		netif_info(efx, probe, efx->net_dev, "no PTP support\n");
+		pci_info(efx->pci_dev, "no PTP support\n");
 		return rc;
 	} else {
 		efx_mcdi_display_error(efx, MC_CMD_PTP, sizeof(inbuf),
@@ -613,7 +613,7 @@ static int efx_ptp_disable(struct efx_nic *efx)
 	 * should only have been called during probe.
 	 */
 	if (rc == -ENOSYS || rc == -EPERM)
-		netif_info(efx, probe, efx->net_dev, "no PTP support\n");
+		pci_info(efx->pci_dev, "no PTP support\n");
 	else if (rc)
 		efx_mcdi_display_error(efx, MC_CMD_PTP,
 				       MC_CMD_PTP_IN_DISABLE_LEN,
diff --git a/drivers/net/ethernet/sfc/siena_sriov.c b/drivers/net/ethernet/sfc/siena_sriov.c
index da7b94f346049..30d58f72725df 100644
--- a/drivers/net/ethernet/sfc/siena_sriov.c
+++ b/drivers/net/ethernet/sfc/siena_sriov.c
@@ -1059,7 +1059,7 @@ void efx_siena_sriov_probe(struct efx_nic *efx)
 		return;
 
 	if (efx_siena_sriov_cmd(efx, false, &efx->vi_scale, &count)) {
-		netif_info(efx, probe, efx->net_dev, "no SR-IOV VFs probed\n");
+		pci_info(efx->pci_dev, "no SR-IOV VFs probed\n");
 		return;
 	}
 	if (count > 0 && count > max_vfs)
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 8b7596fef42a6..37162492e2635 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -426,8 +426,20 @@ static int emac_set_coalesce(struct net_device *ndev,
 	u32 int_ctrl, num_interrupts = 0;
 	u32 prescale = 0, addnl_dvdr = 1, coal_intvl = 0;
 
-	if (!coal->rx_coalesce_usecs)
-		return -EINVAL;
+	if (!coal->rx_coalesce_usecs) {
+		priv->coal_intvl = 0;
+
+		switch (priv->version) {
+		case EMAC_VERSION_2:
+			emac_ctrl_write(EMAC_DM646X_CMINTCTRL, 0);
+			break;
+		default:
+			emac_ctrl_write(EMAC_CTRL_EWINTTCNT, 0);
+			break;
+		}
+
+		return 0;
+	}
 
 	coal_intvl = coal->rx_coalesce_usecs;
 
diff --git a/drivers/net/phy/mdio-mux.c b/drivers/net/phy/mdio-mux.c
index 599ce24c514f1..456b64248e5da 100644
--- a/drivers/net/phy/mdio-mux.c
+++ b/drivers/net/phy/mdio-mux.c
@@ -117,6 +117,7 @@ int mdio_mux_init(struct device *dev,
 	} else {
 		parent_bus_node = NULL;
 		parent_bus = mux_bus;
+		get_device(&parent_bus->dev);
 	}
 
 	pb = devm_kzalloc(dev, sizeof(*pb), GFP_KERNEL);
@@ -182,9 +183,7 @@ int mdio_mux_init(struct device *dev,
 
 	devm_kfree(dev, pb);
 err_pb_kz:
-	/* balance the reference of_mdio_find_bus() took */
-	if (!mux_bus)
-		put_device(&parent_bus->dev);
+	put_device(&parent_bus->dev);
 err_parent_bus:
 	of_node_put(parent_bus_node);
 	return ret_val;
@@ -202,7 +201,6 @@ void mdio_mux_uninit(void *mux_handle)
 		cb = cb->next;
 	}
 
-	/* balance the reference of_mdio_find_bus() in mdio_mux_init() took */
 	put_device(&pb->mii_bus->dev);
 }
 EXPORT_SYMBOL_GPL(mdio_mux_uninit);
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 8cc7563ab103b..92fb664b56fbb 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -316,6 +316,13 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	bus->dev.groups = NULL;
 	dev_set_name(&bus->dev, "%s", bus->id);
 
+	/* We need to set state to MDIOBUS_UNREGISTERED to correctly release
+	 * the device in mdiobus_free()
+	 *
+	 * State will be updated later in this function in case of success
+	 */
+	bus->state = MDIOBUS_UNREGISTERED;
+
 	err = device_register(&bus->dev);
 	if (err) {
 		pr_err("mii_bus %s failed to register\n", bus->id);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 1704d9e2ca8d1..c21328e1e3cca 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -876,8 +876,9 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
-	.resume		= genphy_resume,
+	/* No suspend/resume callbacks because of errata DS80000700A,
+	 * receiver error following software power down.
+	 */
 }, {
 	.phy_id		= PHY_ID_KSZ8041RNLI,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dc0349d13f86a..966e2f03c1296 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -855,6 +855,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct tun_struct *tun = netdev_priv(dev);
 	int txq = skb->queue_mapping;
+	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	u32 numqueues = 0;
 
@@ -920,6 +921,10 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_array_produce(&tfile->tx_array, skb))
 		goto drop;
 
+	/* NETIF_F_LLTX requires to do our own update of trans_start */
+	queue = netdev_get_tx_queue(dev, txq);
+	queue->trans_start = jiffies;
+
 	/* Notify and wake up reader process */
 	if (tfile->flags & TUN_FASYNC)
 		kill_fasync(&tfile->fasync, SIGIO, POLL_IN);
diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 3a7286256db09..9272d0f938190 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -98,6 +98,10 @@ config USB_RTL8150
 config USB_RTL8152
 	tristate "Realtek RTL8152/RTL8153 Based USB Ethernet Adapters"
 	select MII
+	select CRC32
+	select CRYPTO
+	select CRYPTO_HASH
+	select CRYPTO_SHA256
 	help
 	  This option adds support for Realtek RTL8152 based USB 2.0
 	  10/100 Ethernet adapters and RTL8153 based USB 3.0 10/100/1000
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index bde19425e9c10..a3a3d4b40a7cc 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2512,7 +2512,7 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 			   hso_net_init);
 	if (!net) {
 		dev_err(&interface->dev, "Unable to create ethernet device\n");
-		goto exit;
+		goto err_hso_dev;
 	}
 
 	hso_net = netdev_priv(net);
@@ -2525,50 +2525,63 @@ static struct hso_device *hso_create_net_device(struct usb_interface *interface,
 				      USB_DIR_IN);
 	if (!hso_net->in_endp) {
 		dev_err(&interface->dev, "Can't find BULK IN endpoint\n");
-		goto exit;
+		goto err_net;
 	}
 	hso_net->out_endp = hso_get_ep(interface, USB_ENDPOINT_XFER_BULK,
 				       USB_DIR_OUT);
 	if (!hso_net->out_endp) {
 		dev_err(&interface->dev, "Can't find BULK OUT endpoint\n");
-		goto exit;
+		goto err_net;
 	}
 	SET_NETDEV_DEV(net, &interface->dev);
 	SET_NETDEV_DEVTYPE(net, &hso_type);
 
-	/* registering our net device */
-	result = register_netdev(net);
-	if (result) {
-		dev_err(&interface->dev, "Failed to register device\n");
-		goto exit;
-	}
-
 	/* start allocating */
 	for (i = 0; i < MUX_BULK_RX_BUF_COUNT; i++) {
 		hso_net->mux_bulk_rx_urb_pool[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!hso_net->mux_bulk_rx_urb_pool[i])
-			goto exit;
+			goto err_mux_bulk_rx;
 		hso_net->mux_bulk_rx_buf_pool[i] = kzalloc(MUX_BULK_RX_BUF_SIZE,
 							   GFP_KERNEL);
 		if (!hso_net->mux_bulk_rx_buf_pool[i])
-			goto exit;
+			goto err_mux_bulk_rx;
 	}
 	hso_net->mux_bulk_tx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!hso_net->mux_bulk_tx_urb)
-		goto exit;
+		goto err_mux_bulk_rx;
 	hso_net->mux_bulk_tx_buf = kzalloc(MUX_BULK_TX_BUF_SIZE, GFP_KERNEL);
 	if (!hso_net->mux_bulk_tx_buf)
-		goto exit;
+		goto err_free_tx_urb;
 
 	add_net_device(hso_dev);
 
+	/* registering our net device */
+	result = register_netdev(net);
+	if (result) {
+		dev_err(&interface->dev, "Failed to register device\n");
+		goto err_free_tx_buf;
+	}
+
 	hso_log_port(hso_dev);
 
 	hso_create_rfkill(hso_dev, interface);
 
 	return hso_dev;
-exit:
-	hso_free_net_device(hso_dev);
+
+err_free_tx_buf:
+	remove_net_device(hso_dev);
+	kfree(hso_net->mux_bulk_tx_buf);
+err_free_tx_urb:
+	usb_free_urb(hso_net->mux_bulk_tx_urb);
+err_mux_bulk_rx:
+	for (i = 0; i < MUX_BULK_RX_BUF_COUNT; i++) {
+		usb_free_urb(hso_net->mux_bulk_rx_urb_pool[i]);
+		kfree(hso_net->mux_bulk_rx_buf_pool[i]);
+	}
+err_net:
+	free_netdev(net);
+err_hso_dev:
+	kfree(hso_dev);
 	return NULL;
 }
 
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index bca6237597233..bce898ad6e96f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3370,6 +3370,12 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	dev->maxpacket = usb_maxpacket(dev->udev, dev->pipe_out, 1);
 
+	/* Reject broken descriptors. */
+	if (dev->maxpacket == 0) {
+		ret = -ENODEV;
+		goto out3;
+	}
+
 	/* driver requires remote-wakeup capability during autosuspend. */
 	intf->needs_remote_wakeup = 1;
 
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 0b5fd1499ac06..6a004742ec71a 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1740,6 +1740,11 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	if (!dev->rx_urb_size)
 		dev->rx_urb_size = dev->hard_mtu;
 	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
+	if (dev->maxpacket == 0) {
+		/* that is a broken device */
+		status = -ENODEV;
+		goto out4;
+	}
 
 	/* let userspace know we have a random address */
 	if (ether_addr_equal(net->dev_addr, node_id))
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index c999b10531c59..56a8031b56b37 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3622,7 +3622,6 @@ vmxnet3_suspend(struct device *device)
 	vmxnet3_free_intr_resources(adapter);
 
 	netif_device_detach(netdev);
-	netif_tx_stop_all_queues(netdev);
 
 	/* Create wake-up filters. */
 	pmConf = adapter->pm_conf;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 314cac2ce0879..41fb17cece622 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -980,7 +980,7 @@ static int ath10k_monitor_vdev_start(struct ath10k *ar, int vdev_id)
 	arg.channel.min_power = 0;
 	arg.channel.max_power = channel->max_power * 2;
 	arg.channel.max_reg_power = channel->max_reg_power * 2;
-	arg.channel.max_antenna_gain = channel->max_antenna_gain * 2;
+	arg.channel.max_antenna_gain = channel->max_antenna_gain;
 
 	reinit_completion(&ar->vdev_setup_done);
 
@@ -1416,7 +1416,7 @@ static int ath10k_vdev_start_restart(struct ath10k_vif *arvif,
 	arg.channel.min_power = 0;
 	arg.channel.max_power = chandef->chan->max_power * 2;
 	arg.channel.max_reg_power = chandef->chan->max_reg_power * 2;
-	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
+	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain;
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		arg.ssid = arvif->u.ap.ssid;
@@ -3019,7 +3019,7 @@ static int ath10k_update_channel_list(struct ath10k *ar)
 			ch->min_power = 0;
 			ch->max_power = channel->max_power * 2;
 			ch->max_reg_power = channel->max_reg_power * 2;
-			ch->max_antenna_gain = channel->max_antenna_gain * 2;
+			ch->max_antenna_gain = channel->max_antenna_gain;
 			ch->reg_class_id = 0; /* FIXME */
 
 			/* FIXME: why use only legacy modes, why not any
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index cce028ea9b57d..5f718210ce682 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -1802,7 +1802,9 @@ struct wmi_channel {
 	union {
 		__le32 reginfo1;
 		struct {
+			/* note: power unit is 1 dBm */
 			u8 antenna_max;
+			/* note: power unit is 0.5 dBm */
 			u8 max_tx_power;
 		} __packed;
 	} __packed;
@@ -1821,6 +1823,7 @@ struct wmi_channel_arg {
 	u32 min_power;
 	u32 max_power;
 	u32 max_reg_power;
+	/* note: power unit is 1 dBm */
 	u32 max_antenna_gain;
 	u32 reg_class_id;
 	enum wmi_phy_mode mode;
diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index fc22c5f479276..3d0dfcf2c2462 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -340,6 +340,11 @@ static int ath6kl_usb_setup_pipe_resources(struct ath6kl_usb *ar_usb)
 				   le16_to_cpu(endpoint->wMaxPacketSize),
 				   endpoint->bInterval);
 		}
+
+		/* Ignore broken descriptors. */
+		if (usb_endpoint_maxp(endpoint) == 0)
+			continue;
+
 		urbcount = 0;
 
 		pipe_num =
@@ -907,7 +912,7 @@ static int ath6kl_usb_submit_ctrl_in(struct ath6kl_usb *ar_usb,
 				 req,
 				 USB_DIR_IN | USB_TYPE_VENDOR |
 				 USB_RECIP_DEVICE, value, index, buf,
-				 size, 2 * HZ);
+				 size, 2000);
 
 	if (ret < 0) {
 		ath6kl_warn("Failed to read usb control message: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index 7776f4a8630e4..ca0877f0e6392 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -528,8 +528,10 @@ irqreturn_t ath_isr(int irq, void *dev)
 	ath9k_debug_sync_cause(sc, sync_cause);
 	status &= ah->imask;	/* discard unasked-for bits */
 
-	if (test_bit(ATH_OP_HW_RESET, &common->op_flags))
+	if (test_bit(ATH_OP_HW_RESET, &common->op_flags)) {
+		ath9k_hw_kill_interrupts(sc->sc_ah);
 		return IRQ_HANDLED;
+	}
 
 	/*
 	 * If there are no status bits set, then this interrupt was not
diff --git a/drivers/net/wireless/ath/dfs_pattern_detector.c b/drivers/net/wireless/ath/dfs_pattern_detector.c
index 78146607f16e8..acd85e5069346 100644
--- a/drivers/net/wireless/ath/dfs_pattern_detector.c
+++ b/drivers/net/wireless/ath/dfs_pattern_detector.c
@@ -182,10 +182,12 @@ static void channel_detector_exit(struct dfs_pattern_detector *dpd,
 	if (cd == NULL)
 		return;
 	list_del(&cd->head);
-	for (i = 0; i < dpd->num_radar_types; i++) {
-		struct pri_detector *de = cd->detectors[i];
-		if (de != NULL)
-			de->exit(de);
+	if (cd->detectors) {
+		for (i = 0; i < dpd->num_radar_types; i++) {
+			struct pri_detector *de = cd->detectors[i];
+			if (de != NULL)
+				de->exit(de);
+		}
 	}
 	kfree(cd->detectors);
 	kfree(cd);
diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 86beadf0f2493..b5a885a8301cc 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -129,7 +129,9 @@ static struct ieee80211_supported_band wcn_band_2ghz = {
 		.cap =	IEEE80211_HT_CAP_GRN_FLD |
 			IEEE80211_HT_CAP_SGI_20 |
 			IEEE80211_HT_CAP_DSSSCCK40 |
-			IEEE80211_HT_CAP_LSIG_TXOP_PROT,
+			IEEE80211_HT_CAP_LSIG_TXOP_PROT |
+			IEEE80211_HT_CAP_SGI_40 |
+			IEEE80211_HT_CAP_SUP_WIDTH_20_40,
 		.ht_supported = true,
 		.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K,
 		.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index a443992320f2e..914c210c9e605 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2081,30 +2081,52 @@ static int wcn36xx_smd_delete_sta_context_ind(struct wcn36xx *wcn,
 					      size_t len)
 {
 	struct wcn36xx_hal_delete_sta_context_ind_msg *rsp = buf;
-	struct wcn36xx_vif *tmp;
+	struct wcn36xx_vif *vif_priv;
+	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *bss_conf;
 	struct ieee80211_sta *sta;
+	bool found = false;
 
 	if (len != sizeof(*rsp)) {
 		wcn36xx_warn("Corrupted delete sta indication\n");
 		return -EIO;
 	}
 
-	wcn36xx_dbg(WCN36XX_DBG_HAL, "delete station indication %pM index %d\n",
-		    rsp->addr2, rsp->sta_id);
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "delete station indication %pM index %d reason %d\n",
+		    rsp->addr2, rsp->sta_id, rsp->reason_code);
 
-	list_for_each_entry(tmp, &wcn->vif_list, list) {
+	list_for_each_entry(vif_priv, &wcn->vif_list, list) {
 		rcu_read_lock();
-		sta = ieee80211_find_sta(wcn36xx_priv_to_vif(tmp), rsp->addr2);
-		if (sta)
-			ieee80211_report_low_ack(sta, 0);
+		vif = wcn36xx_priv_to_vif(vif_priv);
+
+		if (vif->type == NL80211_IFTYPE_STATION) {
+			/* We could call ieee80211_find_sta too, but checking
+			 * bss_conf is clearer.
+			 */
+			bss_conf = &vif->bss_conf;
+			if (vif_priv->sta_assoc &&
+			    !memcmp(bss_conf->bssid, rsp->addr2, ETH_ALEN)) {
+				found = true;
+				wcn36xx_dbg(WCN36XX_DBG_HAL,
+					    "connection loss bss_index %d\n",
+					    vif_priv->bss_index);
+				ieee80211_connection_loss(vif);
+			}
+		} else {
+			sta = ieee80211_find_sta(vif, rsp->addr2);
+			if (sta) {
+				found = true;
+				ieee80211_report_low_ack(sta, 0);
+			}
+		}
+
 		rcu_read_unlock();
-		if (sta)
+		if (found)
 			return 0;
 	}
 
-	wcn36xx_warn("STA with addr %pM and index %d not found\n",
-		     rsp->addr2,
-		     rsp->sta_id);
+	wcn36xx_warn("BSS or STA with addr %pM not found\n", rsp->addr2);
 	return -ENOENT;
 }
 
diff --git a/drivers/net/wireless/broadcom/b43/phy_g.c b/drivers/net/wireless/broadcom/b43/phy_g.c
index 822dcaa8ace63..35ff139b1496e 100644
--- a/drivers/net/wireless/broadcom/b43/phy_g.c
+++ b/drivers/net/wireless/broadcom/b43/phy_g.c
@@ -2310,7 +2310,7 @@ static u8 b43_gphy_aci_scan(struct b43_wldev *dev)
 	b43_phy_mask(dev, B43_PHY_G_CRS, 0x7FFF);
 	b43_set_all_gains(dev, 3, 8, 1);
 
-	start = (channel - 5 > 0) ? channel - 5 : 1;
+	start = (channel > 5) ? channel - 5 : 1;
 	end = (channel + 5 < 14) ? channel + 5 : 13;
 
 	for (i = start; i <= end; i++) {
diff --git a/drivers/net/wireless/broadcom/b43legacy/radio.c b/drivers/net/wireless/broadcom/b43legacy/radio.c
index 9501420340a91..5b1e8890305c1 100644
--- a/drivers/net/wireless/broadcom/b43legacy/radio.c
+++ b/drivers/net/wireless/broadcom/b43legacy/radio.c
@@ -299,7 +299,7 @@ u8 b43legacy_radio_aci_scan(struct b43legacy_wldev *dev)
 			    & 0x7FFF);
 	b43legacy_set_all_gains(dev, 3, 8, 1);
 
-	start = (channel - 5 > 0) ? channel - 5 : 1;
+	start = (channel > 5) ? channel - 5 : 1;
 	end = (channel + 5 < 14) ? channel + 5 : 13;
 
 	for (i = start; i <= end; i++) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index ff5ce1ed03c42..4746f4b096c56 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -913,6 +913,9 @@ bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm)
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (iwlmvm_mod_params.power_scheme != IWL_POWER_SCHEME_CAM)
+		return false;
+
 	if (num_of_ant(iwl_mvm_get_valid_rx_ant(mvm)) == 1)
 		return false;
 
diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 9d147b11ee516..9f19fd5c18d07 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -292,6 +292,7 @@ static int if_usb_probe(struct usb_interface *intf,
 	if_usb_reset_device(cardp);
 dealloc:
 	if_usb_free(cardp);
+	kfree(cardp);
 
 error:
 	return r;
@@ -318,6 +319,7 @@ static void if_usb_disconnect(struct usb_interface *intf)
 
 	/* Unlink and free urb */
 	if_usb_free(cardp);
+	kfree(cardp);
 
 	usb_set_intfdata(intf, NULL);
 	usb_put_dev(interface_to_usbdev(intf));
diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index 4b539209999b4..aaba324dbc39b 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -234,6 +234,7 @@ static int if_usb_probe(struct usb_interface *intf,
 
 dealloc:
 	if_usb_free(cardp);
+	kfree(cardp);
 error:
 lbtf_deb_leave(LBTF_DEB_MAIN);
 	return -ENOMEM;
@@ -258,6 +259,7 @@ static void if_usb_disconnect(struct usb_interface *intf)
 
 	/* Unlink and free urb */
 	if_usb_free(cardp);
+	kfree(cardp);
 
 	usb_set_intfdata(intf, NULL);
 	usb_put_dev(interface_to_usbdev(intf));
diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index c174e79e6df2b..b70eac7d2dd79 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -630,14 +630,15 @@ int mwifiex_send_delba(struct mwifiex_private *priv, int tid, u8 *peer_mac,
 	uint16_t del_ba_param_set;
 
 	memset(&delba, 0, sizeof(delba));
-	delba.del_ba_param_set = cpu_to_le16(tid << DELBA_TID_POS);
 
-	del_ba_param_set = le16_to_cpu(delba.del_ba_param_set);
+	del_ba_param_set = tid << DELBA_TID_POS;
+
 	if (initiator)
 		del_ba_param_set |= IEEE80211_DELBA_PARAM_INITIATOR_MASK;
 	else
 		del_ba_param_set &= ~IEEE80211_DELBA_PARAM_INITIATOR_MASK;
 
+	delba.del_ba_param_set = cpu_to_le16(del_ba_param_set);
 	memcpy(&delba.peer_mac_addr, peer_mac, ETH_ALEN);
 
 	/* We don't wait for the response of this command */
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index d0743bd25ba95..aaabd8454794e 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -1265,6 +1265,14 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 			ret = -1;
 			goto done_unmap;
 		}
+
+		/* The firmware (latest version 15.68.19.p21) of the 88W8897 PCIe+USB card
+		 * seems to crash randomly after setting the TX ring write pointer when
+		 * ASPM powersaving is enabled. A workaround seems to be keeping the bus
+		 * busy by reading a random register afterwards.
+		 */
+		mwifiex_read_reg(adapter, PCI_VENDOR_ID, &rx_val);
+
 		if ((mwifiex_pcie_txbd_not_full(card)) &&
 		    tx_param->next_pkt_len) {
 			/* have more packets and TxBD still can hold more */
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 09185a1f7379c..2c4225e57c396 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -473,6 +473,22 @@ static int mwifiex_usb_probe(struct usb_interface *intf,
 		}
 	}
 
+	switch (card->usb_boot_state) {
+	case USB8XXX_FW_DNLD:
+		/* Reject broken descriptors. */
+		if (!card->rx_cmd_ep || !card->tx_cmd_ep)
+			return -ENODEV;
+		if (card->bulk_out_maxpktsize == 0)
+			return -ENODEV;
+		break;
+	case USB8XXX_FW_READY:
+		/* Assume the driver can handle missing endpoints for now. */
+		break;
+	default:
+		WARN_ON(1);
+		return -ENODEV;
+	}
+
 	usb_set_intfdata(intf, card);
 
 	ret = mwifiex_add_card(card, &add_remove_card_sem, &usb_ops,
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 66cd38d4f199b..c6f008796ff16 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -5783,8 +5783,8 @@ static void mwl8k_fw_state_machine(const struct firmware *fw, void *context)
 fail:
 	priv->fw_state = FW_STATE_ERROR;
 	complete(&priv->firmware_loading_complete);
-	device_release_driver(&priv->pdev->dev);
 	mwl8k_release_firmware(priv);
+	device_release_driver(&priv->pdev->dev);
 }
 
 #define MAX_RESTART_ATTEMPTS 1
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
index e6668ffb77e65..49fb8bba3d91a 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
@@ -31,7 +31,7 @@ u8 rtl818x_ioread8_idx(struct rtl8187_priv *priv,
 	usb_control_msg(priv->udev, usb_rcvctrlpipe(priv->udev, 0),
 			RTL8187_REQ_GET_REG, RTL8187_REQT_READ,
 			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits8, sizeof(val), HZ / 2);
+			&priv->io_dmabuf->bits8, sizeof(val), 500);
 
 	val = priv->io_dmabuf->bits8;
 	mutex_unlock(&priv->io_mutex);
@@ -48,7 +48,7 @@ u16 rtl818x_ioread16_idx(struct rtl8187_priv *priv,
 	usb_control_msg(priv->udev, usb_rcvctrlpipe(priv->udev, 0),
 			RTL8187_REQ_GET_REG, RTL8187_REQT_READ,
 			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits16, sizeof(val), HZ / 2);
+			&priv->io_dmabuf->bits16, sizeof(val), 500);
 
 	val = priv->io_dmabuf->bits16;
 	mutex_unlock(&priv->io_mutex);
@@ -65,7 +65,7 @@ u32 rtl818x_ioread32_idx(struct rtl8187_priv *priv,
 	usb_control_msg(priv->udev, usb_rcvctrlpipe(priv->udev, 0),
 			RTL8187_REQ_GET_REG, RTL8187_REQT_READ,
 			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits32, sizeof(val), HZ / 2);
+			&priv->io_dmabuf->bits32, sizeof(val), 500);
 
 	val = priv->io_dmabuf->bits32;
 	mutex_unlock(&priv->io_mutex);
@@ -82,7 +82,7 @@ void rtl818x_iowrite8_idx(struct rtl8187_priv *priv,
 	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
 			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
 			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits8, sizeof(val), HZ / 2);
+			&priv->io_dmabuf->bits8, sizeof(val), 500);
 
 	mutex_unlock(&priv->io_mutex);
 }
@@ -96,7 +96,7 @@ void rtl818x_iowrite16_idx(struct rtl8187_priv *priv,
 	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
 			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
 			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits16, sizeof(val), HZ / 2);
+			&priv->io_dmabuf->bits16, sizeof(val), 500);
 
 	mutex_unlock(&priv->io_mutex);
 }
@@ -110,7 +110,7 @@ void rtl818x_iowrite32_idx(struct rtl8187_priv *priv,
 	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
 			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
 			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits32, sizeof(val), HZ / 2);
+			&priv->io_dmabuf->bits32, sizeof(val), 500);
 
 	mutex_unlock(&priv->io_mutex);
 }
@@ -186,7 +186,7 @@ static void rtl8225_write_8051(struct ieee80211_hw *dev, u8 addr, __le16 data)
 	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
 			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
 			addr, 0x8225, &priv->io_dmabuf->bits16, sizeof(data),
-			HZ / 2);
+			500);
 
 	mutex_unlock(&priv->io_mutex);
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index 974387ad1e8c5..83cbaac877ea3 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -42,7 +42,7 @@ static int rsi_usb_card_write(struct rsi_hw *adapter,
 			      buf,
 			      len,
 			      &transfer,
-			      HZ * 5);
+			      USB_CTRL_SET_TIMEOUT);
 
 	if (status < 0) {
 		rsi_dbg(ERR_ZONE,
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index ceaf6b30d683d..0971c09363cbf 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1460,6 +1460,10 @@ static int netfront_resume(struct xenbus_device *dev)
 
 	dev_dbg(&dev->dev, "%s\n", dev->nodename);
 
+	netif_tx_lock_bh(info->netdev);
+	netif_device_detach(info->netdev);
+	netif_tx_unlock_bh(info->netdev);
+
 	xennet_disconnect_backend(info);
 	return 0;
 }
@@ -2020,6 +2024,10 @@ static int xennet_connect(struct net_device *dev)
 	 * domain a kick because we've probably just requeued some
 	 * packets.
 	 */
+	netif_tx_lock_bh(np->netdev);
+	netif_device_attach(np->netdev);
+	netif_tx_unlock_bh(np->netdev);
+
 	netif_carrier_on(np->netdev);
 	for (j = 0; j < num_queues; ++j) {
 		queue = &np->queues[j];
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index 6c495664d2cb7..806309ee41657 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2075,7 +2075,7 @@ static int pn533_fill_fragment_skbs(struct pn533 *dev, struct sk_buff *skb)
 		frag = pn533_alloc_skb(dev, frag_size);
 		if (!frag) {
 			skb_queue_purge(&dev->fragment_skb);
-			break;
+			return -ENOMEM;
 		}
 
 		if (!dev->tgt_mode) {
@@ -2145,7 +2145,7 @@ static int pn533_transceive(struct nfc_dev *nfc_dev,
 		/* jumbo frame ? */
 		if (skb->len > PN533_CMD_DATAEXCH_DATA_MAXLEN) {
 			rc = pn533_fill_fragment_skbs(dev, skb);
-			if (rc <= 0)
+			if (rc < 0)
 				goto error;
 
 			skb = skb_dequeue(&dev->fragment_skb);
@@ -2217,7 +2217,7 @@ static int pn533_tm_send(struct nfc_dev *nfc_dev, struct sk_buff *skb)
 	/* let's split in multiple chunks if size's too big */
 	if (skb->len > PN533_CMD_DATAEXCH_DATA_MAXLEN) {
 		rc = pn533_fill_fragment_skbs(dev, skb);
-		if (rc <= 0)
+		if (rc < 0)
 			goto error;
 
 		/* get the first skb */
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 151b220381f95..ed65993aae96a 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1011,11 +1011,11 @@ static u64 port100_get_command_type_mask(struct port100 *dev)
 
 	skb = port100_alloc_skb(dev, 0);
 	if (!skb)
-		return -ENOMEM;
+		return 0;
 
 	resp = port100_send_cmd_sync(dev, PORT100_CMD_GET_COMMAND_TYPE, skb);
 	if (IS_ERR(resp))
-		return PTR_ERR(resp);
+		return 0;
 
 	if (resp->len < 8)
 		mask = 0;
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2a0c5f3b0e509..286196e3a35d3 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -967,7 +967,8 @@ static inline void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell,
 		*p-- = 0;
 
 	/* clear msb bits if any leftover in the last byte */
-	*p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
+	if (cell->nbits % BITS_PER_BYTE)
+		*p &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 736d9f58438ec..08375e68f1c30 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -110,6 +110,7 @@
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
+#define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
 
 /* PCIe window configuration */
 #define OB_WIN_BASE_ADDR			0x4c00
@@ -404,7 +405,7 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
 	else
 		str_posted = "Posted";
 
-	dev_err(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
+	dev_dbg(dev, "%s PIO Response Status: %s, %#x @ %#x\n",
 		str_posted, strcomp_status, reg, advk_readl(pcie, PIO_ADDR_LS));
 }
 
@@ -785,8 +786,12 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
+		/*
+		 * msi_idx contains bits [4:0] of the msi_data and msi_data
+		 * contains 16bit MSI interrupt number
+		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & 0xFF;
+		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
 		generic_handle_irq(msi_data);
 	}
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 97c3515e3b543..be2f1402c84c2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -391,18 +391,6 @@ static void free_msi_irqs(struct pci_dev *dev)
 			for (i = 0; i < entry->nvec_used; i++)
 				BUG_ON(irq_has_action(entry->irq + i));
 
-	pci_msi_teardown_msi_irqs(dev);
-
-	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		if (entry->msi_attrib.is_msix) {
-			if (list_is_last(&entry->list, msi_list))
-				iounmap(entry->mask_base);
-		}
-
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
 	if (dev->msi_irq_groups) {
 		sysfs_remove_groups(&dev->dev.kobj, dev->msi_irq_groups);
 		msi_attrs = dev->msi_irq_groups[0]->attrs;
@@ -418,6 +406,18 @@ static void free_msi_irqs(struct pci_dev *dev)
 		kfree(dev->msi_irq_groups);
 		dev->msi_irq_groups = NULL;
 	}
+
+	pci_msi_teardown_msi_irqs(dev);
+
+	list_for_each_entry_safe(entry, tmp, msi_list, list) {
+		if (entry->msi_attrib.is_msix) {
+			if (list_is_last(&entry->list, msi_list))
+				iounmap(entry->mask_base);
+		}
+
+		list_del(&entry->list);
+		free_msi_entry(entry);
+	}
 }
 
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 66e5bb7bfb67b..3ff2971102b61 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3370,6 +3370,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
 
 /*
  * Some TI KeyStone C667X devices do not support bus/hot reset.  The PCIESS
diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index 403d966223ee9..76cb361b623cb 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -382,9 +382,11 @@ static int lis3lv02d_add(struct acpi_device *device)
 	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
 	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
 	if (ret) {
+		i8042_remove_filter(hp_accel_i8042_filter);
 		lis3lv02d_joystick_disable(&lis3_dev);
 		lis3lv02d_poweroff(&lis3_dev);
 		flush_work(&hpled_led.work);
+		lis3lv02d_remove_fs(&lis3_dev);
 		return ret;
 	}
 
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index e81daff65f622..238ee4275f5c8 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -187,7 +187,7 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 	return 0;
 }
 
-/* Wait till ipc ioc interrupt is received or timeout in 3 HZ */
+/* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
 static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 84bfecded84d9..9c929b5ce58e2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8884,7 +8884,7 @@ static int fan_write_cmd_level(const char *cmd, int *rc)
 
 	if (strlencmp(cmd, "level auto") == 0)
 		level = TP_EC_FAN_AUTO;
-	else if ((strlencmp(cmd, "level disengaged") == 0) |
+	else if ((strlencmp(cmd, "level disengaged") == 0) ||
 			(strlencmp(cmd, "level full-speed") == 0))
 		level = TP_EC_FAN_FULLSPEED;
 	else if (sscanf(cmd, "level %d", &level) != 1)
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 00d82e8443bdd..da06284c455dc 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -289,7 +289,14 @@ struct acpi_buffer *out)
 	 * the WQxx method failed - we should disable collection anyway.
 	 */
 	if ((block->flags & ACPI_WMI_EXPENSIVE) && ACPI_SUCCESS(wc_status)) {
-		status = acpi_execute_simple_method(handle, wc_method, 0);
+		/*
+		 * Ignore whether this WCxx call succeeds or not since
+		 * the previously executed WQxx method call might have
+		 * succeeded, and returning the failing status code
+		 * of this call would throw away the result of the WQxx
+		 * call, potentially leaking memory.
+		 */
+		acpi_execute_simple_method(handle, wc_method, 0);
 	}
 
 	return status;
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 5c5c3a6f99234..91fabe9e6efd0 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -115,7 +115,8 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Unable to register IRQ %d error %d\n",
 				client->irq, ret);
-			return ret;
+			bq27xxx_battery_teardown(di);
+			goto err_failed;
 		}
 	}
 
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index f18d845b3b92d..01ca03c809d05 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -246,7 +246,10 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = regmap_read(map, MAX17042_RepSOC, &data);
+		if (chip->pdata->enable_current_sense)
+			ret = regmap_read(map, MAX17042_RepSOC, &data);
+		else
+			ret = regmap_read(map, MAX17042_VFSOC, &data);
 		if (ret < 0)
 			return ret;
 
@@ -752,7 +755,8 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	regmap_read(map, MAX17042_RepSOC, &soc);
 	soc >>= 8;
 	soc_tr = (soc + off) << 8;
-	soc_tr |= (soc - off);
+	if (off < soc)
+		soc_tr |= soc - off;
 	regmap_write(map, MAX17042_SALRT_Th, soc_tr);
 }
 
diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 9310b85f3405e..7eec7014086d8 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -63,7 +63,7 @@ static int rt5033_battery_get_watt_prop(struct i2c_client *client,
 	regmap_read(battery->regmap, regh, &msb);
 	regmap_read(battery->regmap, regl, &lsb);
 
-	ret = ((msb << 4) + (lsb >> 4)) * 1250 / 1000;
+	ret = ((msb << 4) + (lsb >> 4)) * 1250;
 
 	return ret;
 }
diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index 3aa22ae4d94c0..a911325fc0b4f 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -698,6 +698,7 @@ static const struct pci_device_id pch_ieee1588_pcidev_id[] = {
 	 },
 	{0}
 };
+MODULE_DEVICE_TABLE(pci, pch_ieee1588_pcidev_id);
 
 static struct pci_driver pch_driver = {
 	.name = KBUILD_MODNAME,
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 27343e1c43ef8..45fad246c27e3 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -845,18 +845,15 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 	/* DS4 GPIO */
 	gpio_direction_output(pdata->buck_ds[2], 0x0);
 
-	if (pdata->buck2_gpiodvs || pdata->buck3_gpiodvs ||
-	   pdata->buck4_gpiodvs) {
-		regmap_update_bits(s5m8767->iodev->regmap_pmic,
-				S5M8767_REG_BUCK2CTRL, 1 << 1,
-				(pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1));
-		regmap_update_bits(s5m8767->iodev->regmap_pmic,
-				S5M8767_REG_BUCK3CTRL, 1 << 1,
-				(pdata->buck3_gpiodvs) ? (1 << 1) : (0 << 1));
-		regmap_update_bits(s5m8767->iodev->regmap_pmic,
-				S5M8767_REG_BUCK4CTRL, 1 << 1,
-				(pdata->buck4_gpiodvs) ? (1 << 1) : (0 << 1));
-	}
+	regmap_update_bits(s5m8767->iodev->regmap_pmic,
+			   S5M8767_REG_BUCK2CTRL, 1 << 1,
+			   (pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1));
+	regmap_update_bits(s5m8767->iodev->regmap_pmic,
+			   S5M8767_REG_BUCK3CTRL, 1 << 1,
+			   (pdata->buck3_gpiodvs) ? (1 << 1) : (0 << 1));
+	regmap_update_bits(s5m8767->iodev->regmap_pmic,
+			   S5M8767_REG_BUCK4CTRL, 1 << 1,
+			   (pdata->buck4_gpiodvs) ? (1 << 1) : (0 << 1));
 
 	/* Initialize GPIO DVS registers */
 	for (i = 0; i < 8; i++) {
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 24e57e770432b..6efd17692a55a 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -3370,8 +3370,8 @@ static void asc_prt_adv_board_info(struct seq_file *m, struct Scsi_Host *shost)
 		   shost->host_no);
 
 	seq_printf(m,
-		   " iop_base 0x%lx, cable_detect: %X, err_code %u\n",
-		   (unsigned long)v->iop_base,
+		   " iop_base 0x%p, cable_detect: %X, err_code %u\n",
+		   v->iop_base,
 		   AdvReadWordRegister(iop_base,IOPW_SCSI_CFG1) & CABLE_DETECT,
 		   v->err_code);
 
diff --git a/drivers/scsi/csiostor/csio_lnode.c b/drivers/scsi/csiostor/csio_lnode.c
index 957767d383610..d1df694d9ed00 100644
--- a/drivers/scsi/csiostor/csio_lnode.c
+++ b/drivers/scsi/csiostor/csio_lnode.c
@@ -611,7 +611,7 @@ csio_ln_vnp_read_cbfn(struct csio_hw *hw, struct csio_mb *mbp)
 	struct fc_els_csp *csp;
 	struct fc_els_cssp *clsp;
 	enum fw_retval retval;
-	__be32 nport_id;
+	__be32 nport_id = 0;
 
 	retval = FW_CMD_RETVAL_G(ntohl(rsp->alloc_to_len16));
 	if (retval != FW_SUCCESS) {
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 830b2d2dcf206..8490d0ff04ca7 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -4809,6 +4809,7 @@ static int dc395x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	/* initialise the adapter and everything we need */
  	if (adapter_init(acb, io_port_base, io_port_len, irq)) {
 		dprintkl(KERN_INFO, "adapter init failed\n");
+		acb = NULL;
 		goto fail;
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 0e7915ecb85a5..5c847ef459cd1 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -17274,6 +17274,7 @@ lpfc_drain_txq(struct lpfc_hba *phba)
 					fail_msg,
 					piocbq->iotag, piocbq->sli4_xritag);
 			list_add_tail(&piocbq->list, &completions);
+			fail_msg = NULL;
 		}
 		spin_unlock_irqrestore(&pring->ring_lock, iflags);
 	}
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 6ca00813c71f0..4a1a16e6a8204 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -115,7 +115,6 @@ extern int ql2xasynctmfenable;
 extern int ql2xgffidenable;
 extern int ql2xenabledif;
 extern int ql2xenablehba_err_chk;
-extern int ql2xtargetreset;
 extern int ql2xdontresethba;
 extern uint64_t ql2xmaxlun;
 extern int ql2xmdcapmask;
@@ -655,7 +654,6 @@ extern void qlafx00_abort_iocb(srb_t *, struct abort_iocb_entry_fx00 *);
 extern void qlafx00_fxdisc_iocb(srb_t *, struct fxdisc_entry_fx00 *);
 extern void qlafx00_timer_routine(scsi_qla_host_t *);
 extern int qlafx00_rescan_isp(scsi_qla_host_t *);
-extern int qlafx00_loop_reset(scsi_qla_host_t *vha);
 
 /* qla82xx related functions */
 
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 15dff7099955b..b72cc4b1287d9 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -738,29 +738,6 @@ qlafx00_lun_reset(fc_port_t *fcport, uint64_t l, int tag)
 	return qla2x00_async_tm_cmd(fcport, TCF_LUN_RESET, l, tag);
 }
 
-int
-qlafx00_loop_reset(scsi_qla_host_t *vha)
-{
-	int ret;
-	struct fc_port *fcport;
-	struct qla_hw_data *ha = vha->hw;
-
-	if (ql2xtargetreset) {
-		list_for_each_entry(fcport, &vha->vp_fcports, list) {
-			if (fcport->port_type != FCT_TARGET)
-				continue;
-
-			ret = ha->isp_ops->target_reset(fcport, 0, 0);
-			if (ret != QLA_SUCCESS) {
-				ql_dbg(ql_dbg_taskm, vha, 0x803d,
-				    "Bus Reset failed: Reset=%d "
-				    "d_id=%x.\n", ret, fcport->d_id.b24);
-			}
-		}
-	}
-	return QLA_SUCCESS;
-}
-
 int
 qlafx00_iospace_config(struct qla_hw_data *ha)
 {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 65bbca715f57d..274b61ddee04a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -180,12 +180,6 @@ MODULE_PARM_DESC(ql2xdbwr,
 		" 0 -- Regular doorbell.\n"
 		" 1 -- CAMRAM doorbell (faster).\n");
 
-int ql2xtargetreset = 1;
-module_param(ql2xtargetreset, int, S_IRUGO);
-MODULE_PARM_DESC(ql2xtargetreset,
-		 "Enable target reset."
-		 "Default is 1 - use hw defaults.");
-
 int ql2xgffidenable;
 module_param(ql2xgffidenable, int, S_IRUGO);
 MODULE_PARM_DESC(ql2xgffidenable,
@@ -1401,27 +1395,10 @@ int
 qla2x00_loop_reset(scsi_qla_host_t *vha)
 {
 	int ret;
-	struct fc_port *fcport;
 	struct qla_hw_data *ha = vha->hw;
 
-	if (IS_QLAFX00(ha)) {
-		return qlafx00_loop_reset(vha);
-	}
-
-	if (ql2xtargetreset == 1 && ha->flags.enable_target_reset) {
-		list_for_each_entry(fcport, &vha->vp_fcports, list) {
-			if (fcport->port_type != FCT_TARGET)
-				continue;
-
-			ret = ha->isp_ops->target_reset(fcport, 0, 0);
-			if (ret != QLA_SUCCESS) {
-				ql_dbg(ql_dbg_taskm, vha, 0x802c,
-				    "Bus Reset failed: Reset=%d "
-				    "d_id=%x.\n", ret, fcport->d_id.b24);
-			}
-		}
-	}
-
+	if (IS_QLAFX00(ha))
+		return QLA_SUCCESS;
 
 	if (ha->flags.enable_lip_full_login && !IS_CNA_CAPABLE(ha)) {
 		atomic_set(&vha->loop_state, LOOP_DOWN);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1deb6adc411f7..4c9c1a8db8c30 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -951,8 +951,10 @@ EXPORT_SYMBOL(scsi_device_get);
  */
 void scsi_device_put(struct scsi_device *sdev)
 {
-	module_put(sdev->host->hostt->module);
+	struct module *mod = sdev->host->hostt->module;
+
 	put_device(&sdev->sdev_gendev);
+	module_put(mod);
 }
 EXPORT_SYMBOL(scsi_device_put);
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 38830818bfb6f..eae43a85e9b0e 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -427,9 +427,12 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	struct device *parent;
 	struct list_head *this, *tmp;
 	unsigned long flags;
+	struct module *mod;
 
 	sdev = container_of(work, struct scsi_device, ew.work);
 
+	mod = sdev->host->hostt->module;
+
 	scsi_dh_release_device(sdev);
 
 	parent = sdev->sdev_gendev.parent;
@@ -461,11 +464,17 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 
 	if (parent)
 		put_device(parent);
+	module_put(mod);
 }
 
 static void scsi_device_dev_release(struct device *dev)
 {
 	struct scsi_device *sdp = to_scsi_device(dev);
+
+	/* Set module pointer as NULL in case of module unloading */
+	if (!try_module_get(sdp->host->hostt->module))
+		sdp->host->hostt->module = NULL;
+
 	execute_in_process_context(scsi_device_dev_release_usercontext,
 				   &sdp->ew);
 }
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 69046d342bc5d..39396548f9b55 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -120,7 +120,7 @@ static int ses_recv_diag(struct scsi_device *sdev, int page_code,
 static int ses_send_diag(struct scsi_device *sdev, int page_code,
 			 void *buf, int bufflen)
 {
-	u32 result;
+	int result;
 
 	unsigned char cmd[] = {
 		SEND_DIAGNOSTIC,
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 7ba0031d3a738..d5575869a25c7 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -343,7 +343,7 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
 		}
 		break;
 	default:
-		pr_info("Unsupport virtio scsi event reason %x\n", event->reason);
+		pr_info("Unsupported virtio scsi event reason %x\n", event->reason);
 	}
 }
 
@@ -396,7 +396,7 @@ static void virtscsi_handle_event(struct work_struct *work)
 		virtscsi_handle_param_change(vscsi, event);
 		break;
 	default:
-		pr_err("Unsupport virtio scsi event %x\n", event->event);
+		pr_err("Unsupported virtio scsi event %x\n", event->event);
 	}
 	virtscsi_kick_event(vscsi, event_node);
 }
diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index bec81c2404f78..1682fa3671bc3 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -835,8 +835,10 @@ static int __init maple_bus_init(void)
 
 	maple_queue_cache = KMEM_CACHE(maple_buffer, SLAB_HWCACHE_ALIGN);
 
-	if (!maple_queue_cache)
+	if (!maple_queue_cache) {
+		retval = -ENOMEM;
 		goto cleanup_bothirqs;
+	}
 
 	INIT_LIST_HEAD(&maple_waitq);
 	INIT_LIST_HEAD(&maple_sentq);
@@ -849,6 +851,7 @@ static int __init maple_bus_init(void)
 		if (!mdev[i]) {
 			while (i-- > 0)
 				maple_free_dev(mdev[i]);
+			retval = -ENOMEM;
 			goto cleanup_cache;
 		}
 		baseunits[i] = mdev[i];
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index a12710c917a14..93da935130397 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -384,7 +384,7 @@ static int tegra_powergate_power_up(struct tegra_powergate *pg,
 
 	err = tegra_powergate_enable_clocks(pg);
 	if (err)
-		goto disable_clks;
+		goto powergate_off;
 
 	usleep_range(10, 20);
 
@@ -396,7 +396,7 @@ static int tegra_powergate_power_up(struct tegra_powergate *pg,
 
 	err = tegra_powergate_reset_deassert(pg);
 	if (err)
-		goto powergate_off;
+		goto disable_clks;
 
 	usleep_range(10, 20);
 
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 5453910d8abc3..d521adf6ac245 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1266,7 +1266,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 					       &qspi->dev_ids[val]);
 			if (ret < 0) {
 				dev_err(&pdev->dev, "IRQ %s not found\n", name);
-				goto qspi_probe_err;
+				goto qspi_unprepare_err;
 			}
 
 			qspi->dev_ids[val].dev = qspi;
@@ -1281,7 +1281,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	if (!num_ints) {
 		dev_err(&pdev->dev, "no IRQs registered, cannot init driver\n");
 		ret = -EINVAL;
-		goto qspi_probe_err;
+		goto qspi_unprepare_err;
 	}
 
 	/*
@@ -1332,6 +1332,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 
 qspi_reg_err:
 	bcm_qspi_hw_uninit(qspi);
+qspi_unprepare_err:
 	clk_disable_unprepare(qspi->clk);
 qspi_probe_err:
 	kfree(qspi->dev_ids);
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f7f7ba17b40e9..27cf77dfc6038 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1703,12 +1703,13 @@ static int verify_controller_parameters(struct pl022 *pl022,
 				return -EINVAL;
 			}
 		} else {
-			if (chip_info->duplex != SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
+			if (chip_info->duplex != SSP_MICROWIRE_CHANNEL_FULL_DUPLEX) {
 				dev_err(&pl022->adev->dev,
 					"Microwire half duplex mode requested,"
 					" but this is only available in the"
 					" ST version of PL022\n");
-			return -EINVAL;
+				return -EINVAL;
+			}
 		}
 	}
 	return 0;
diff --git a/drivers/staging/comedi/drivers/dt9812.c b/drivers/staging/comedi/drivers/dt9812.c
index 7ebca862ecaa3..e758eb3d2d19f 100644
--- a/drivers/staging/comedi/drivers/dt9812.c
+++ b/drivers/staging/comedi/drivers/dt9812.c
@@ -41,6 +41,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
 
 #include "../comedi_usb.h"
@@ -246,22 +247,42 @@ static int dt9812_read_info(struct comedi_device *dev,
 {
 	struct usb_device *usb = comedi_to_usb_dev(dev);
 	struct dt9812_private *devpriv = dev->private;
-	struct dt9812_usb_cmd cmd;
+	struct dt9812_usb_cmd *cmd;
+	size_t tbuf_size;
 	int count, ret;
+	void *tbuf;
 
-	cmd.cmd = cpu_to_le32(DT9812_R_FLASH_DATA);
-	cmd.u.flash_data_info.address =
+	tbuf_size = max(sizeof(*cmd), buf_size);
+
+	tbuf = kzalloc(tbuf_size, GFP_KERNEL);
+	if (!tbuf)
+		return -ENOMEM;
+
+	cmd = tbuf;
+
+	cmd->cmd = cpu_to_le32(DT9812_R_FLASH_DATA);
+	cmd->u.flash_data_info.address =
 	    cpu_to_le16(DT9812_DIAGS_BOARD_INFO_ADDR + offset);
-	cmd.u.flash_data_info.numbytes = cpu_to_le16(buf_size);
+	cmd->u.flash_data_info.numbytes = cpu_to_le16(buf_size);
 
 	/* DT9812 only responds to 32 byte writes!! */
 	ret = usb_bulk_msg(usb, usb_sndbulkpipe(usb, devpriv->cmd_wr.addr),
-			   &cmd, 32, &count, DT9812_USB_TIMEOUT);
+			   cmd, sizeof(*cmd), &count, DT9812_USB_TIMEOUT);
 	if (ret)
-		return ret;
+		goto out;
+
+	ret = usb_bulk_msg(usb, usb_rcvbulkpipe(usb, devpriv->cmd_rd.addr),
+			   tbuf, buf_size, &count, DT9812_USB_TIMEOUT);
+	if (!ret) {
+		if (count == buf_size)
+			memcpy(buf, tbuf, buf_size);
+		else
+			ret = -EREMOTEIO;
+	}
+out:
+	kfree(tbuf);
 
-	return usb_bulk_msg(usb, usb_rcvbulkpipe(usb, devpriv->cmd_rd.addr),
-			    buf, buf_size, &count, DT9812_USB_TIMEOUT);
+	return ret;
 }
 
 static int dt9812_read_multiple_registers(struct comedi_device *dev,
@@ -270,22 +291,42 @@ static int dt9812_read_multiple_registers(struct comedi_device *dev,
 {
 	struct usb_device *usb = comedi_to_usb_dev(dev);
 	struct dt9812_private *devpriv = dev->private;
-	struct dt9812_usb_cmd cmd;
+	struct dt9812_usb_cmd *cmd;
 	int i, count, ret;
+	size_t buf_size;
+	void *buf;
 
-	cmd.cmd = cpu_to_le32(DT9812_R_MULTI_BYTE_REG);
-	cmd.u.read_multi_info.count = reg_count;
+	buf_size = max_t(size_t, sizeof(*cmd), reg_count);
+
+	buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	cmd = buf;
+
+	cmd->cmd = cpu_to_le32(DT9812_R_MULTI_BYTE_REG);
+	cmd->u.read_multi_info.count = reg_count;
 	for (i = 0; i < reg_count; i++)
-		cmd.u.read_multi_info.address[i] = address[i];
+		cmd->u.read_multi_info.address[i] = address[i];
 
 	/* DT9812 only responds to 32 byte writes!! */
 	ret = usb_bulk_msg(usb, usb_sndbulkpipe(usb, devpriv->cmd_wr.addr),
-			   &cmd, 32, &count, DT9812_USB_TIMEOUT);
+			   cmd, sizeof(*cmd), &count, DT9812_USB_TIMEOUT);
 	if (ret)
-		return ret;
+		goto out;
+
+	ret = usb_bulk_msg(usb, usb_rcvbulkpipe(usb, devpriv->cmd_rd.addr),
+			   buf, reg_count, &count, DT9812_USB_TIMEOUT);
+	if (!ret) {
+		if (count == reg_count)
+			memcpy(value, buf, reg_count);
+		else
+			ret = -EREMOTEIO;
+	}
+out:
+	kfree(buf);
 
-	return usb_bulk_msg(usb, usb_rcvbulkpipe(usb, devpriv->cmd_rd.addr),
-			    value, reg_count, &count, DT9812_USB_TIMEOUT);
+	return ret;
 }
 
 static int dt9812_write_multiple_registers(struct comedi_device *dev,
@@ -294,19 +335,27 @@ static int dt9812_write_multiple_registers(struct comedi_device *dev,
 {
 	struct usb_device *usb = comedi_to_usb_dev(dev);
 	struct dt9812_private *devpriv = dev->private;
-	struct dt9812_usb_cmd cmd;
+	struct dt9812_usb_cmd *cmd;
 	int i, count;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
 
-	cmd.cmd = cpu_to_le32(DT9812_W_MULTI_BYTE_REG);
-	cmd.u.read_multi_info.count = reg_count;
+	cmd->cmd = cpu_to_le32(DT9812_W_MULTI_BYTE_REG);
+	cmd->u.read_multi_info.count = reg_count;
 	for (i = 0; i < reg_count; i++) {
-		cmd.u.write_multi_info.write[i].address = address[i];
-		cmd.u.write_multi_info.write[i].value = value[i];
+		cmd->u.write_multi_info.write[i].address = address[i];
+		cmd->u.write_multi_info.write[i].value = value[i];
 	}
 
 	/* DT9812 only responds to 32 byte writes!! */
-	return usb_bulk_msg(usb, usb_sndbulkpipe(usb, devpriv->cmd_wr.addr),
-			    &cmd, 32, &count, DT9812_USB_TIMEOUT);
+	ret = usb_bulk_msg(usb, usb_sndbulkpipe(usb, devpriv->cmd_wr.addr),
+			   cmd, sizeof(*cmd), &count, DT9812_USB_TIMEOUT);
+	kfree(cmd);
+
+	return ret;
 }
 
 static int dt9812_rmw_multiple_registers(struct comedi_device *dev,
@@ -315,17 +364,25 @@ static int dt9812_rmw_multiple_registers(struct comedi_device *dev,
 {
 	struct usb_device *usb = comedi_to_usb_dev(dev);
 	struct dt9812_private *devpriv = dev->private;
-	struct dt9812_usb_cmd cmd;
+	struct dt9812_usb_cmd *cmd;
 	int i, count;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
 
-	cmd.cmd = cpu_to_le32(DT9812_RMW_MULTI_BYTE_REG);
-	cmd.u.rmw_multi_info.count = reg_count;
+	cmd->cmd = cpu_to_le32(DT9812_RMW_MULTI_BYTE_REG);
+	cmd->u.rmw_multi_info.count = reg_count;
 	for (i = 0; i < reg_count; i++)
-		cmd.u.rmw_multi_info.rmw[i] = rmw[i];
+		cmd->u.rmw_multi_info.rmw[i] = rmw[i];
 
 	/* DT9812 only responds to 32 byte writes!! */
-	return usb_bulk_msg(usb, usb_sndbulkpipe(usb, devpriv->cmd_wr.addr),
-			    &cmd, 32, &count, DT9812_USB_TIMEOUT);
+	ret = usb_bulk_msg(usb, usb_sndbulkpipe(usb, devpriv->cmd_wr.addr),
+			   cmd, sizeof(*cmd), &count, DT9812_USB_TIMEOUT);
+	kfree(cmd);
+
+	return ret;
 }
 
 static int dt9812_digital_in(struct comedi_device *dev, u8 *bits)
diff --git a/drivers/staging/comedi/drivers/ni_usb6501.c b/drivers/staging/comedi/drivers/ni_usb6501.c
index 2f174a34d9e9b..7f647d80ec050 100644
--- a/drivers/staging/comedi/drivers/ni_usb6501.c
+++ b/drivers/staging/comedi/drivers/ni_usb6501.c
@@ -153,6 +153,10 @@ static const u8 READ_COUNTER_RESPONSE[]	= {0x00, 0x01, 0x00, 0x10,
 					   0x00, 0x00, 0x00, 0x02,
 					   0x00, 0x00, 0x00, 0x00};
 
+/* Largest supported packets */
+static const size_t TX_MAX_SIZE	= sizeof(SET_PORT_DIR_REQUEST);
+static const size_t RX_MAX_SIZE	= sizeof(READ_PORT_RESPONSE);
+
 enum commands {
 	READ_PORT,
 	WRITE_PORT,
@@ -510,6 +514,12 @@ static int ni6501_find_endpoints(struct comedi_device *dev)
 	if (!devpriv->ep_rx || !devpriv->ep_tx)
 		return -ENODEV;
 
+	if (usb_endpoint_maxp(devpriv->ep_rx) < RX_MAX_SIZE)
+		return -ENODEV;
+
+	if (usb_endpoint_maxp(devpriv->ep_tx) < TX_MAX_SIZE)
+		return -ENODEV;
+
 	return 0;
 }
 
diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/staging/comedi/drivers/vmk80xx.c
index cdf86284dd047..36470ee065967 100644
--- a/drivers/staging/comedi/drivers/vmk80xx.c
+++ b/drivers/staging/comedi/drivers/vmk80xx.c
@@ -99,6 +99,9 @@ enum {
 #define IC3_VERSION		BIT(0)
 #define IC6_VERSION		BIT(1)
 
+#define MIN_BUF_SIZE		64
+#define PACKET_TIMEOUT		10000	/* ms */
+
 enum vmk80xx_model {
 	VMK8055_MODEL,
 	VMK8061_MODEL
@@ -166,22 +169,21 @@ static void vmk80xx_do_bulk_msg(struct comedi_device *dev)
 	__u8 rx_addr;
 	unsigned int tx_pipe;
 	unsigned int rx_pipe;
-	size_t size;
+	size_t tx_size;
+	size_t rx_size;
 
 	tx_addr = devpriv->ep_tx->bEndpointAddress;
 	rx_addr = devpriv->ep_rx->bEndpointAddress;
 	tx_pipe = usb_sndbulkpipe(usb, tx_addr);
 	rx_pipe = usb_rcvbulkpipe(usb, rx_addr);
+	tx_size = usb_endpoint_maxp(devpriv->ep_tx);
+	rx_size = usb_endpoint_maxp(devpriv->ep_rx);
 
-	/*
-	 * The max packet size attributes of the K8061
-	 * input/output endpoints are identical
-	 */
-	size = usb_endpoint_maxp(devpriv->ep_tx);
+	usb_bulk_msg(usb, tx_pipe, devpriv->usb_tx_buf, tx_size, NULL,
+		     PACKET_TIMEOUT);
 
-	usb_bulk_msg(usb, tx_pipe, devpriv->usb_tx_buf,
-		     size, NULL, devpriv->ep_tx->bInterval);
-	usb_bulk_msg(usb, rx_pipe, devpriv->usb_rx_buf, size, NULL, HZ * 10);
+	usb_bulk_msg(usb, rx_pipe, devpriv->usb_rx_buf, rx_size, NULL,
+		     PACKET_TIMEOUT);
 }
 
 static int vmk80xx_read_packet(struct comedi_device *dev)
@@ -200,7 +202,7 @@ static int vmk80xx_read_packet(struct comedi_device *dev)
 	pipe = usb_rcvintpipe(usb, ep->bEndpointAddress);
 	return usb_interrupt_msg(usb, pipe, devpriv->usb_rx_buf,
 				 usb_endpoint_maxp(ep), NULL,
-				 HZ * 10);
+				 PACKET_TIMEOUT);
 }
 
 static int vmk80xx_write_packet(struct comedi_device *dev, int cmd)
@@ -221,7 +223,7 @@ static int vmk80xx_write_packet(struct comedi_device *dev, int cmd)
 	pipe = usb_sndintpipe(usb, ep->bEndpointAddress);
 	return usb_interrupt_msg(usb, pipe, devpriv->usb_tx_buf,
 				 usb_endpoint_maxp(ep), NULL,
-				 HZ * 10);
+				 PACKET_TIMEOUT);
 }
 
 static int vmk80xx_reset_device(struct comedi_device *dev)
@@ -687,12 +689,12 @@ static int vmk80xx_alloc_usb_buffers(struct comedi_device *dev)
 	struct vmk80xx_private *devpriv = dev->private;
 	size_t size;
 
-	size = usb_endpoint_maxp(devpriv->ep_rx);
+	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
 	devpriv->usb_rx_buf = kzalloc(size, GFP_KERNEL);
 	if (!devpriv->usb_rx_buf)
 		return -ENOMEM;
 
-	size = usb_endpoint_maxp(devpriv->ep_tx);
+	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
 	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
 	if (!devpriv->usb_tx_buf)
 		return -ENOMEM;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 53b77c8ae328a..95cbf7cf55e61 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -266,7 +266,7 @@ int write_nic_byte_E(struct net_device *dev, int indx, u8 data)
 
 	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
-				 indx | 0xfe00, 0, usbdata, 1, HZ / 2);
+				 indx | 0xfe00, 0, usbdata, 1, 500);
 	kfree(usbdata);
 
 	if (status < 0){
@@ -289,7 +289,7 @@ int read_nic_byte_E(struct net_device *dev, int indx, u8 *data)
 
 	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
-				 indx | 0xfe00, 0, usbdata, 1, HZ / 2);
+				 indx | 0xfe00, 0, usbdata, 1, 500);
 	*data = *usbdata;
 	kfree(usbdata);
 
@@ -317,7 +317,7 @@ int write_nic_byte(struct net_device *dev, int indx, u8 data)
 	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
 				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 1, HZ / 2);
+				 usbdata, 1, 500);
 	kfree(usbdata);
 
 	if (status < 0) {
@@ -344,7 +344,7 @@ int write_nic_word(struct net_device *dev, int indx, u16 data)
 	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
 				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 2, HZ / 2);
+				 usbdata, 2, 500);
 	kfree(usbdata);
 
 	if (status < 0) {
@@ -371,7 +371,7 @@ int write_nic_dword(struct net_device *dev, int indx, u32 data)
 	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
 				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 4, HZ / 2);
+				 usbdata, 4, 500);
 	kfree(usbdata);
 
 
@@ -399,7 +399,7 @@ int read_nic_byte(struct net_device *dev, int indx, u8 *data)
 	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
 				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 1, HZ / 2);
+				 usbdata, 1, 500);
 	*data = *usbdata;
 	kfree(usbdata);
 
@@ -426,7 +426,7 @@ int read_nic_word(struct net_device *dev, int indx, u16 *data)
 	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
 				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 2, HZ / 2);
+				 usbdata, 2, 500);
 	*data = *usbdata;
 	kfree(usbdata);
 
@@ -450,7 +450,7 @@ static int read_nic_word_E(struct net_device *dev, int indx, u16 *data)
 
 	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
-				 indx | 0xfe00, 0, usbdata, 2, HZ / 2);
+				 indx | 0xfe00, 0, usbdata, 2, 500);
 	*data = *usbdata;
 	kfree(usbdata);
 
@@ -476,7 +476,7 @@ int read_nic_dword(struct net_device *dev, int indx, u32 *data)
 	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
 				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 4, HZ / 2);
+				 usbdata, 4, 500);
 	*data = *usbdata;
 	kfree(usbdata);
 
diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index fc6bb0be2a28c..2919498fd8089 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -504,7 +504,7 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
 		memcpy(pIo_buf, pdata, len);
 	}
 	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
-				 pIo_buf, len, HZ / 2);
+				 pIo_buf, len, 500);
 	if (status > 0) {  /* Success this control transfer. */
 		if (requesttype == 0x01) {
 			/* For Control read transfer, we have to copy the read
diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index ee5b29aed54bd..fa28fd89add6c 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -1735,7 +1735,6 @@ int core_alua_set_tg_pt_gp_id(
 		pr_err("Maximum ALUA alua_tg_pt_gps_count:"
 			" 0x0000ffff reached\n");
 		spin_unlock(&dev->t10_alua.tg_pt_gps_lock);
-		kmem_cache_free(t10_alua_tg_pt_gp_cache, tg_pt_gp);
 		return -ENOSPC;
 	}
 again:
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index c3d576ed6f135..d8c3c72da7464 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -787,6 +787,8 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	INIT_LIST_HEAD(&dev->t10_alua.lba_map_list);
 	spin_lock_init(&dev->t10_alua.lba_map_lock);
 
+	INIT_WORK(&dev->delayed_cmd_work, target_do_delayed_work);
+
 	dev->t10_wwn.t10_dev = dev;
 	dev->t10_alua.t10_dev = dev;
 
diff --git a/drivers/target/target_core_internal.h b/drivers/target/target_core_internal.h
index be52838cc1a88..48a631ab449e9 100644
--- a/drivers/target/target_core_internal.h
+++ b/drivers/target/target_core_internal.h
@@ -144,6 +144,7 @@ void	transport_clear_lun_ref(struct se_lun *);
 void	transport_send_task_abort(struct se_cmd *);
 sense_reason_t	target_cmd_size_check(struct se_cmd *cmd, unsigned int size);
 void	target_qf_do_work(struct work_struct *work);
+void	target_do_delayed_work(struct work_struct *work);
 bool	target_check_wce(struct se_device *dev);
 bool	target_check_fua(struct se_device *dev);
 void	__target_execute_cmd(struct se_cmd *, bool);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 6afb65387be6c..0e9383fbdd4dc 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1883,32 +1883,35 @@ static bool target_handle_task_attr(struct se_cmd *cmd)
 	 */
 	switch (cmd->sam_task_attr) {
 	case TCM_HEAD_TAG:
+		atomic_inc_mb(&dev->non_ordered);
 		pr_debug("Added HEAD_OF_QUEUE for CDB: 0x%02x\n",
 			 cmd->t_task_cdb[0]);
 		return false;
 	case TCM_ORDERED_TAG:
-		atomic_inc_mb(&dev->dev_ordered_sync);
+		atomic_inc_mb(&dev->delayed_cmd_count);
 
 		pr_debug("Added ORDERED for CDB: 0x%02x to ordered list\n",
 			 cmd->t_task_cdb[0]);
-
-		/*
-		 * Execute an ORDERED command if no other older commands
-		 * exist that need to be completed first.
-		 */
-		if (!atomic_read(&dev->simple_cmds))
-			return false;
 		break;
 	default:
 		/*
 		 * For SIMPLE and UNTAGGED Task Attribute commands
 		 */
-		atomic_inc_mb(&dev->simple_cmds);
+		atomic_inc_mb(&dev->non_ordered);
+
+		if (atomic_read(&dev->delayed_cmd_count) == 0)
+			return false;
 		break;
 	}
 
-	if (atomic_read(&dev->dev_ordered_sync) == 0)
-		return false;
+	if (cmd->sam_task_attr != TCM_ORDERED_TAG) {
+		atomic_inc_mb(&dev->delayed_cmd_count);
+		/*
+		 * We will account for this when we dequeue from the delayed
+		 * list.
+		 */
+		atomic_dec_mb(&dev->non_ordered);
+	}
 
 	spin_lock(&dev->delayed_cmd_lock);
 	list_add_tail(&cmd->se_delayed_node, &dev->delayed_cmd_list);
@@ -1916,6 +1919,12 @@ static bool target_handle_task_attr(struct se_cmd *cmd)
 
 	pr_debug("Added CDB: 0x%02x Task Attr: 0x%02x to delayed CMD listn",
 		cmd->t_task_cdb[0], cmd->sam_task_attr);
+	/*
+	 * We may have no non ordered cmds when this function started or we
+	 * could have raced with the last simple/head cmd completing, so kick
+	 * the delayed handler here.
+	 */
+	schedule_work(&dev->delayed_cmd_work);
 	return true;
 }
 
@@ -1966,29 +1975,48 @@ EXPORT_SYMBOL(target_execute_cmd);
  * Process all commands up to the last received ORDERED task attribute which
  * requires another blocking boundary
  */
-static void target_restart_delayed_cmds(struct se_device *dev)
+void target_do_delayed_work(struct work_struct *work)
 {
-	for (;;) {
+	struct se_device *dev = container_of(work, struct se_device,
+					     delayed_cmd_work);
+
+	spin_lock(&dev->delayed_cmd_lock);
+	while (!dev->ordered_sync_in_progress) {
 		struct se_cmd *cmd;
 
-		spin_lock(&dev->delayed_cmd_lock);
-		if (list_empty(&dev->delayed_cmd_list)) {
-			spin_unlock(&dev->delayed_cmd_lock);
+		if (list_empty(&dev->delayed_cmd_list))
 			break;
-		}
 
 		cmd = list_entry(dev->delayed_cmd_list.next,
 				 struct se_cmd, se_delayed_node);
+
+		if (cmd->sam_task_attr == TCM_ORDERED_TAG) {
+			/*
+			 * Check if we started with:
+			 * [ordered] [simple] [ordered]
+			 * and we are now at the last ordered so we have to wait
+			 * for the simple cmd.
+			 */
+			if (atomic_read(&dev->non_ordered) > 0)
+				break;
+
+			dev->ordered_sync_in_progress = true;
+		}
+
 		list_del(&cmd->se_delayed_node);
+		atomic_dec_mb(&dev->delayed_cmd_count);
 		spin_unlock(&dev->delayed_cmd_lock);
 
+		if (cmd->sam_task_attr != TCM_ORDERED_TAG)
+			atomic_inc_mb(&dev->non_ordered);
+
 		cmd->transport_state |= CMD_T_SENT;
 
 		__target_execute_cmd(cmd, true);
 
-		if (cmd->sam_task_attr == TCM_ORDERED_TAG)
-			break;
+		spin_lock(&dev->delayed_cmd_lock);
 	}
+	spin_unlock(&dev->delayed_cmd_lock);
 }
 
 /*
@@ -2006,16 +2034,19 @@ static void transport_complete_task_attr(struct se_cmd *cmd)
 		goto restart;
 
 	if (cmd->sam_task_attr == TCM_SIMPLE_TAG) {
-		atomic_dec_mb(&dev->simple_cmds);
+		atomic_dec_mb(&dev->non_ordered);
 		dev->dev_cur_ordered_id++;
 		pr_debug("Incremented dev->dev_cur_ordered_id: %u for SIMPLE\n",
 			 dev->dev_cur_ordered_id);
 	} else if (cmd->sam_task_attr == TCM_HEAD_TAG) {
+		atomic_dec_mb(&dev->non_ordered);
 		dev->dev_cur_ordered_id++;
 		pr_debug("Incremented dev_cur_ordered_id: %u for HEAD_OF_QUEUE\n",
 			 dev->dev_cur_ordered_id);
 	} else if (cmd->sam_task_attr == TCM_ORDERED_TAG) {
-		atomic_dec_mb(&dev->dev_ordered_sync);
+		spin_lock(&dev->delayed_cmd_lock);
+		dev->ordered_sync_in_progress = false;
+		spin_unlock(&dev->delayed_cmd_lock);
 
 		dev->dev_cur_ordered_id++;
 		pr_debug("Incremented dev_cur_ordered_id: %u for ORDERED\n",
@@ -2024,7 +2055,8 @@ static void transport_complete_task_attr(struct se_cmd *cmd)
 	cmd->se_cmd_flags &= ~SCF_TASK_ATTR_SET;
 
 restart:
-	target_restart_delayed_cmds(dev);
+	if (atomic_read(&dev->delayed_cmd_count) > 0)
+		schedule_work(&dev->delayed_cmd_work);
 }
 
 static void transport_complete_qf(struct se_cmd *cmd)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 22d65a33059e1..aa9cc5e1c91cc 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -637,7 +637,7 @@ static struct platform_driver dw8250_platform_driver = {
 		.name		= "dw-apb-uart",
 		.pm		= &dw8250_pm_ops,
 		.of_match_table	= dw8250_of_match,
-		.acpi_match_table = ACPI_PTR(dw8250_acpi_match),
+		.acpi_match_table = dw8250_acpi_match,
 	},
 	.probe			= dw8250_probe,
 	.remove			= dw8250_remove,
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74a1a97a77b28..bbba2174d6e75 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -209,7 +209,11 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (retval == 0) {
 		if (uart_console(uport) && uport->cons->cflag) {
 			tty->termios.c_cflag = uport->cons->cflag;
+			tty->termios.c_ispeed = uport->cons->ispeed;
+			tty->termios.c_ospeed = uport->cons->ospeed;
 			uport->cons->cflag = 0;
+			uport->cons->ispeed = 0;
+			uport->cons->ospeed = 0;
 		}
 		/*
 		 * Initialise the hardware port settings.
@@ -277,8 +281,11 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (uport && uart_console(uport) && tty)
+		if (uport && uart_console(uport) && tty) {
 			uport->cons->cflag = tty->termios.c_cflag;
+			uport->cons->ispeed = tty->termios.c_ispeed;
+			uport->cons->ospeed = tty->termios.c_ospeed;
+		}
 
 		if (!tty || C_HUPCL(tty))
 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
@@ -2059,8 +2066,11 @@ uart_set_options(struct uart_port *port, struct console *co,
 	 * Allow the setting of the UART parameters with a NULL console
 	 * too:
 	 */
-	if (co)
+	if (co) {
 		co->cflag = termios.c_cflag;
+		co->ispeed = termios.c_ispeed;
+		co->ospeed = termios.c_ospeed;
+	}
 
 	return 0;
 }
@@ -2198,6 +2208,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		 */
 		memset(&termios, 0, sizeof(struct ktermios));
 		termios.c_cflag = uport->cons->cflag;
+		termios.c_ispeed = uport->cons->ispeed;
+		termios.c_ospeed = uport->cons->ospeed;
 
 		/*
 		 * If that's unset, use the tty termios setting.
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index eb61a07fcbbc3..b92700fdfd512 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -589,9 +589,10 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	if (uart_circ_empty(&port->state->xmit))
 		return;
 
+	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
+
 	cdns_uart_handle_tx(port);
 
-	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 	/* Enable the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
 }
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ca9c82ee6c35d..dfccc102c1ddd 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -536,6 +536,9 @@ static void flush_to_ldisc(struct work_struct *work)
 		if (!count)
 			break;
 		head->read += count;
+
+		if (need_resched())
+			cond_resched();
 	}
 
 	mutex_unlock(&buf->lock);
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 0103f777b97ad..bff5a15e59c00 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -160,8 +160,7 @@ source "drivers/usb/gadget/Kconfig"
 
 config USB_LED_TRIG
 	bool "USB LED Triggers"
-	depends on LEDS_CLASS && LEDS_TRIGGERS
-	select USB_COMMON
+	depends on LEDS_CLASS && USB_COMMON && LEDS_TRIGGERS
 	help
 	  This option adds LED triggers for USB host and/or gadget activity.
 
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 6062a5d816a63..f4b13f0637ea3 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -516,7 +516,7 @@ int hw_device_reset(struct ci_hdrc *ci)
 	return 0;
 }
 
-static irqreturn_t ci_irq(int irq, void *data)
+static irqreturn_t ci_irq_handler(int irq, void *data)
 {
 	struct ci_hdrc *ci = data;
 	irqreturn_t ret = IRQ_NONE;
@@ -569,6 +569,15 @@ static irqreturn_t ci_irq(int irq, void *data)
 	return ret;
 }
 
+static void ci_irq(struct ci_hdrc *ci)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ci_irq_handler(ci->irq, ci);
+	local_irq_restore(flags);
+}
+
 static int ci_vbus_notifier(struct notifier_block *nb, unsigned long event,
 			    void *ptr)
 {
@@ -582,7 +591,7 @@ static int ci_vbus_notifier(struct notifier_block *nb, unsigned long event,
 
 	vbus->changed = true;
 
-	ci_irq(ci->irq, ci);
+	ci_irq(ci);
 	return NOTIFY_DONE;
 }
 
@@ -599,7 +608,7 @@ static int ci_id_notifier(struct notifier_block *nb, unsigned long event,
 
 	id->changed = true;
 
-	ci_irq(ci->irq, ci);
+	ci_irq(ci);
 	return NOTIFY_DONE;
 }
 
@@ -1011,7 +1020,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, ci);
-	ret = devm_request_irq(dev, ci->irq, ci_irq, IRQF_SHARED,
+	ret = devm_request_irq(dev, ci->irq, ci_irq_handler, IRQF_SHARED,
 			ci->platdata->name, ci);
 	if (ret)
 		goto stop;
@@ -1126,11 +1135,11 @@ static void ci_extcon_wakeup_int(struct ci_hdrc *ci)
 
 	if (!IS_ERR(cable_id->edev) && ci->is_otg &&
 		(otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS))
-		ci_irq(ci->irq, ci);
+		ci_irq(ci);
 
 	if (!IS_ERR(cable_vbus->edev) && ci->is_otg &&
 		(otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS))
-		ci_irq(ci->irq, ci);
+		ci_irq(ci);
 }
 
 static int ci_controller_resume(struct device *dev)
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 23df1549eb0d8..b7b83ca83ba0d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -349,6 +349,9 @@ static void acm_ctrl_irq(struct urb *urb)
 			acm->iocount.overrun++;
 		spin_unlock(&acm->read_lock);
 
+		if (newctrl & ACM_CTRL_BRK)
+			tty_flip_buffer_push(&acm->port);
+
 		if (difference)
 			wake_up_all(&acm->wioctl);
 
@@ -408,11 +411,16 @@ static int acm_submit_read_urbs(struct acm *acm, gfp_t mem_flags)
 
 static void acm_process_read_urb(struct acm *acm, struct urb *urb)
 {
+	unsigned long flags;
+
 	if (!urb->actual_length)
 		return;
 
+	spin_lock_irqsave(&acm->read_lock, flags);
 	tty_insert_flip_string(&acm->port, urb->transfer_buffer,
 			urb->actual_length);
+	spin_unlock_irqrestore(&acm->read_lock, flags);
+
 	tty_flip_buffer_push(&acm->port);
 }
 
diff --git a/drivers/usb/gadget/legacy/hid.c b/drivers/usb/gadget/legacy/hid.c
index cccbb948821b2..a55d3761d777c 100644
--- a/drivers/usb/gadget/legacy/hid.c
+++ b/drivers/usb/gadget/legacy/hid.c
@@ -103,8 +103,10 @@ static int do_config(struct usb_configuration *c)
 
 	list_for_each_entry(e, &hidg_func_list, node) {
 		e->f = usb_get_function(e->fi);
-		if (IS_ERR(e->f))
+		if (IS_ERR(e->f)) {
+			status = PTR_ERR(e->f);
 			goto put;
+		}
 		status = usb_add_function(c, e->f);
 		if (status < 0) {
 			usb_put_function(e->f);
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 658b8da609152..cff7dae51aabb 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -278,6 +278,7 @@ config USB_AMD5536UDC
 config USB_FSL_QE
 	tristate "Freescale QE/CPM USB Device Controller"
 	depends on FSL_SOC && (QUICC_ENGINE || CPM)
+	depends on !64BIT || BROKEN
 	help
 	   Some of Freescale PowerPC processors have a Full Speed
 	   QE/CPM2 USB controller, which support device mode with 4
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 1654a1bc64141..88aa5acac6fd9 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -121,8 +121,6 @@ struct max3421_hcd {
 
 	struct task_struct *spi_thread;
 
-	struct max3421_hcd *next;
-
 	enum max3421_rh_state rh_state;
 	/* lower 16 bits contain port status, upper 16 bits the change mask: */
 	u32 port_status;
@@ -170,8 +168,6 @@ struct max3421_ep {
 	u8 retransmit;			/* packet needs retransmission */
 };
 
-static struct max3421_hcd *max3421_hcd_list;
-
 #define MAX3421_FIFO_SIZE	64
 
 #define MAX3421_SPI_DIR_RD	0	/* read register from MAX3421 */
@@ -1835,9 +1831,8 @@ max3421_probe(struct spi_device *spi)
 	}
 	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	max3421_hcd = hcd_to_max3421(hcd);
-	max3421_hcd->next = max3421_hcd_list;
-	max3421_hcd_list = max3421_hcd;
 	INIT_LIST_HEAD(&max3421_hcd->ep_list);
+	spi_set_drvdata(spi, max3421_hcd);
 
 	max3421_hcd->tx = kmalloc(sizeof(*max3421_hcd->tx), GFP_KERNEL);
 	if (!max3421_hcd->tx)
@@ -1882,28 +1877,18 @@ max3421_probe(struct spi_device *spi)
 static int
 max3421_remove(struct spi_device *spi)
 {
-	struct max3421_hcd *max3421_hcd = NULL, **prev;
-	struct usb_hcd *hcd = NULL;
+	struct max3421_hcd *max3421_hcd;
+	struct usb_hcd *hcd;
 	unsigned long flags;
 
-	for (prev = &max3421_hcd_list; *prev; prev = &(*prev)->next) {
-		max3421_hcd = *prev;
-		hcd = max3421_to_hcd(max3421_hcd);
-		if (hcd->self.controller == &spi->dev)
-			break;
-	}
-	if (!max3421_hcd) {
-		dev_err(&spi->dev, "no MAX3421 HCD found for SPI device %p\n",
-			spi);
-		return -ENODEV;
-	}
+	max3421_hcd = spi_get_drvdata(spi);
+	hcd = max3421_to_hcd(max3421_hcd);
 
 	usb_remove_hcd(hcd);
 
 	spin_lock_irqsave(&max3421_hcd->lock, flags);
 
 	kthread_stop(max3421_hcd->spi_thread);
-	*prev = max3421_hcd->next;
 
 	spin_unlock_irqrestore(&max3421_hcd->lock, flags);
 
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 9c9e97294c18d..4d42ae3b2fd6d 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -199,7 +199,7 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (!cell)
+	if (!cell || !regs || !config || !sram)
 		return -EINVAL;
 
 	if (irq < 0)
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index dc8f54a68bdbc..9708dbb52b702 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -174,7 +174,6 @@ static void xhci_common_hub_descriptor(struct xhci_hcd *xhci,
 {
 	u16 temp;
 
-	desc->bPwrOn2PwrGood = 10;	/* xhci section 5.4.9 says 20ms max */
 	desc->bHubContrCurrent = 0;
 
 	desc->bNbrPorts = ports;
@@ -208,6 +207,7 @@ static void xhci_usb2_hub_descriptor(struct usb_hcd *hcd, struct xhci_hcd *xhci,
 	desc->bDescriptorType = USB_DT_HUB;
 	temp = 1 + (ports / 8);
 	desc->bDescLength = USB_DT_HUB_NONVAR_SIZE + 2 * temp;
+	desc->bPwrOn2PwrGood = 10;	/* xhci section 5.4.8 says 20ms */
 
 	/* The Device Removable bits are reported on a byte granularity.
 	 * If the port doesn't exist within that byte, the bit is set to 0.
@@ -258,6 +258,7 @@ static void xhci_usb3_hub_descriptor(struct usb_hcd *hcd, struct xhci_hcd *xhci,
 	xhci_common_hub_descriptor(xhci, desc, ports);
 	desc->bDescriptorType = USB_DT_SS_HUB;
 	desc->bDescLength = USB_DT_SS_HUB_SIZE;
+	desc->bPwrOn2PwrGood = 50;	/* usb 3.1 may fail if less than 100ms */
 
 	/* header decode latency should be zero for roothubs,
 	 * see section 4.23.5.2.
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index bb63cc5cbca05..ae67f6383ca32 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -38,6 +38,7 @@
 #define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
 #define PCI_DEVICE_ID_FRESCO_LOGIC_PDK	0x1000
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1009	0x1009
+#define PCI_DEVICE_ID_FRESCO_LOGIC_FL1100	0x1100
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
@@ -91,6 +92,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	/* Look for vendor-specific quirks */
 	if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
 			(pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_PDK ||
+			 pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1100 ||
 			 pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1400)) {
 		if (pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_PDK &&
 				pdev->revision == 0x0) {
diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 1b83946bfb18d..1ea48590bf3b1 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -96,10 +96,6 @@ struct iowarrior {
 /*    globals   */
 /*--------------*/
 
-/*
- *  USB spec identifies 5 second timeouts.
- */
-#define GET_TIMEOUT 5
 #define USB_REQ_GET_REPORT  0x01
 //#if 0
 static int usb_get_report(struct usb_device *dev,
@@ -111,7 +107,7 @@ static int usb_get_report(struct usb_device *dev,
 			       USB_DIR_IN | USB_TYPE_CLASS |
 			       USB_RECIP_INTERFACE, (type << 8) + id,
 			       inter->desc.bInterfaceNumber, buf, size,
-			       GET_TIMEOUT*HZ);
+			       USB_CTRL_GET_TIMEOUT);
 }
 //#endif
 
@@ -126,7 +122,7 @@ static int usb_set_report(struct usb_interface *intf, unsigned char type,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE,
 			       (type << 8) + id,
 			       intf->cur_altsetting->desc.bInterfaceNumber, buf,
-			       size, HZ);
+			       size, 1000);
 }
 
 /*---------------------*/
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 60540a8ac431d..8eb3a291ca9d8 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1284,9 +1284,11 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 		status = musb_queue_resume_work(musb,
 						musb_ep_restart_resume_work,
 						request);
-		if (status < 0)
+		if (status < 0) {
 			dev_err(musb->controller, "%s resume work: %i\n",
 				__func__, status);
+			list_del(&request->list);
+		}
 	}
 
 unlock:
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 7e9204fdba4a8..fb4239b5286fb 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1120,6 +1120,11 @@ static int tusb_musb_init(struct musb *musb)
 
 	/* dma address for async dma */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		pr_debug("no async dma resource?\n");
+		ret = -ENODEV;
+		goto done;
+	}
 	musb->async = mem->start;
 
 	/* dma address for sync dma */
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index e08755e9b6129..9c825d4e564e8 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -2419,22 +2419,22 @@ static int keyspan_port_probe(struct usb_serial_port *port)
 	for (i = 0; i < ARRAY_SIZE(p_priv->in_buffer); ++i) {
 		p_priv->in_buffer[i] = kzalloc(IN_BUFLEN, GFP_KERNEL);
 		if (!p_priv->in_buffer[i])
-			goto err_in_buffer;
+			goto err_free_in_buffer;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(p_priv->out_buffer); ++i) {
 		p_priv->out_buffer[i] = kzalloc(OUT_BUFLEN, GFP_KERNEL);
 		if (!p_priv->out_buffer[i])
-			goto err_out_buffer;
+			goto err_free_out_buffer;
 	}
 
 	p_priv->inack_buffer = kzalloc(INACK_BUFLEN, GFP_KERNEL);
 	if (!p_priv->inack_buffer)
-		goto err_inack_buffer;
+		goto err_free_out_buffer;
 
 	p_priv->outcont_buffer = kzalloc(OUTCONT_BUFLEN, GFP_KERNEL);
 	if (!p_priv->outcont_buffer)
-		goto err_outcont_buffer;
+		goto err_free_inack_buffer;
 
 	p_priv->device_details = d_details;
 
@@ -2480,15 +2480,14 @@ static int keyspan_port_probe(struct usb_serial_port *port)
 
 	return 0;
 
-err_outcont_buffer:
+err_free_inack_buffer:
 	kfree(p_priv->inack_buffer);
-err_inack_buffer:
+err_free_out_buffer:
 	for (i = 0; i < ARRAY_SIZE(p_priv->out_buffer); ++i)
 		kfree(p_priv->out_buffer[i]);
-err_out_buffer:
+err_free_in_buffer:
 	for (i = 0; i < ARRAY_SIZE(p_priv->in_buffer); ++i)
 		kfree(p_priv->in_buffer[i]);
-err_in_buffer:
 	kfree(p_priv);
 
 	return -ENOMEM;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index ec8ad931f41e3..9a0f8ee8cbd9f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1209,6 +1209,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1203, 0xff),	/* Telit LE910Cx (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1204, 0xff),	/* Telit LE910Cx (MBIM) */
+	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE920),
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 11fb4d78e2dbc..f0bd6a66f551e 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -169,6 +169,7 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x907b)},	/* Sierra Wireless EM74xx */
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
+	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index ed94496cdc5b3..ec2b7f5c900c2 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -425,6 +425,16 @@ UNUSUAL_DEV(  0x04b8, 0x0602, 0x0110, 0x0110,
 		"785EPX Storage",
 		USB_SC_SCSI, USB_PR_BULK, NULL, US_FL_SINGLE_LUN),
 
+/*
+ * Reported by James Buren <braewoods+lkml@braewoods.net>
+ * Virtual ISOs cannot be remounted if ejected while the device is locked
+ * Disable locking to mimic Windows behavior that bypasses the issue
+ */
+UNUSUAL_DEV(  0x04c5, 0x2028, 0x0001, 0x0001,
+		"iODD",
+		"2531/2541",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE),
+
 /*
  * Not sure who reported this originally but
  * Pavel Machek <pavel@ucw.cz> reported that the extra US_FL_SINGLE_LUN
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 3a10ac19598fa..8827e0ec5995c 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -290,13 +290,13 @@ static unsigned long sticon_getxy(struct vc_data *conp, unsigned long pos,
 static u8 sticon_build_attr(struct vc_data *conp, u8 color, u8 intens,
 			    u8 blink, u8 underline, u8 reverse, u8 italic)
 {
-    u8 attr = ((color & 0x70) >> 1) | ((color & 7));
+	u8 fg = color & 7;
+	u8 bg = (color & 0x70) >> 4;
 
-    if (reverse) {
-	color = ((color >> 3) & 0x7) | ((color & 0x7) << 3);
-    }
-
-    return attr;
+	if (reverse)
+		return (fg << 3) | bg;
+	else
+		return (bg << 3) | fg;
 }
 
 static void sticon_invert_region(struct vc_data *conp, u16 *p, int count)
diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 314b7eceb81c5..84a3778552eba 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -332,7 +332,7 @@ static struct fb_var_screeninfo chipsfb_var = {
 
 static void init_chips(struct fb_info *p, unsigned long addr)
 {
-	memset(p->screen_base, 0, 0x100000);
+	fb_memset(p->screen_base, 0, 0x100000);
 
 	p->fix = chipsfb_fix;
 	p->fix.smem_start = addr;
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index ae4974701e5c7..6fe9daf2367b5 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -237,15 +237,17 @@ static int watchdog_set_timeout(int timeout)
 
 	mutex_lock(&watchdog.lock);
 
-	watchdog.timeout = timeout;
 	if (timeout > 0xff) {
 		watchdog.timer_val = DIV_ROUND_UP(timeout, 60);
 		watchdog.minutes_mode = true;
+		timeout = watchdog.timer_val * 60;
 	} else {
 		watchdog.timer_val = timeout;
 		watchdog.minutes_mode = false;
 	}
 
+	watchdog.timeout = timeout;
+
 	mutex_unlock(&watchdog.lock);
 
 	return 0;
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1b02bfa81b296..40c006ee8492d 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -271,8 +271,12 @@ static int omap_wdt_probe(struct platform_device *pdev)
 			wdev->wdog.bootstatus = WDIOF_CARDRESET;
 	}
 
-	if (!early_enable)
+	if (early_enable) {
+		omap_wdt_start(&wdev->wdog);
+		set_bit(WDOG_HW_RUNNING, &wdev->wdog.status);
+	} else {
 		omap_wdt_disable(wdev);
+	}
 
 	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index b1a1d7de0894e..daa2e89a50fa3 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -159,7 +159,7 @@ static void *pm_ctrl_init(struct pci_dev *dev, int offset)
 	}
 
 out:
-	return ERR_PTR(err);
+	return err ? ERR_PTR(err) : NULL;
 }
 
 static const struct config_field caplist_pm[] = {
diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 5456937836b86..033cb85ce9b51 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -283,6 +283,13 @@ static void run_ordered_work(struct __btrfs_workqueue *wq,
 				  ordered_list);
 		if (!test_bit(WORK_DONE_BIT, &work->flags))
 			break;
+		/*
+		 * Orders all subsequent loads after reading WORK_DONE_BIT,
+		 * paired with the smp_mb__before_atomic in btrfs_work_helper
+		 * this guarantees that the ordered function will see all
+		 * updates from ordinary work function.
+		 */
+		smp_rmb();
 
 		/*
 		 * we are going to call the ordered done function, but
@@ -368,6 +375,13 @@ static void normal_work_helper(struct btrfs_work *work)
 	thresh_exec_hook(wq);
 	work->func(work);
 	if (need_order) {
+		/*
+		 * Ensures all memory accesses done in the work function are
+		 * ordered before setting the WORK_DONE_BIT. Ensuring the thread
+		 * which is going to executed the ordered work sees them.
+		 * Pairs with the smp_rmb in run_ordered_work.
+		 */
+		smp_mb__before_atomic();
 		set_bit(WORK_DONE_BIT, &work->flags);
 		run_ordered_work(wq, work);
 	}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 11ecd798864c8..cc91b0c564a38 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2225,7 +2225,9 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 		else {
 			ret = find_dir_range(log, path, dirid, key_type,
 					     &range_start, &range_end);
-			if (ret != 0)
+			if (ret < 0)
+				goto out;
+			else if (ret > 0)
 				break;
 		}
 
diff --git a/fs/exec.c b/fs/exec.c
index efcc72dbbf267..34843a6a2783f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -994,7 +994,7 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 	struct fd f = fdget(fd);
 	int ret = -EBADF;
 
-	if (!f.file)
+	if (!f.file || !(f.file->f_mode & FMODE_READ))
 		goto out;
 
 	ret = kernel_read_file(f.file, buf, size, max_size, id);
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 871c8b3920991..2d1d41c94e376 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1265,6 +1265,8 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 
 	de = (struct iso_directory_record *) (bh->b_data + offset);
 	de_len = *(unsigned char *) de;
+	if (de_len < sizeof(struct iso_directory_record))
+		goto fail;
 
 	if (offset + de_len > bufsize) {
 		int frag1 = bufsize - offset;
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 103788ecc28c1..0c2aabba1fdbb 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -93,14 +93,14 @@ int jfs_mount(struct super_block *sb)
 	 * (initialize mount inode from the superblock)
 	 */
 	if ((rc = chkSuper(sb))) {
-		goto errout20;
+		goto out;
 	}
 
 	ipaimap = diReadSpecial(sb, AGGREGATE_I, 0);
 	if (ipaimap == NULL) {
 		jfs_err("jfs_mount: Failed to read AGGREGATE_I");
 		rc = -EIO;
-		goto errout20;
+		goto out;
 	}
 	sbi->ipaimap = ipaimap;
 
@@ -111,7 +111,7 @@ int jfs_mount(struct super_block *sb)
 	 */
 	if ((rc = diMount(ipaimap))) {
 		jfs_err("jfs_mount: diMount(ipaimap) failed w/rc = %d", rc);
-		goto errout21;
+		goto err_ipaimap;
 	}
 
 	/*
@@ -120,7 +120,7 @@ int jfs_mount(struct super_block *sb)
 	ipbmap = diReadSpecial(sb, BMAP_I, 0);
 	if (ipbmap == NULL) {
 		rc = -EIO;
-		goto errout22;
+		goto err_umount_ipaimap;
 	}
 
 	jfs_info("jfs_mount: ipbmap:0x%p", ipbmap);
@@ -132,7 +132,7 @@ int jfs_mount(struct super_block *sb)
 	 */
 	if ((rc = dbMount(ipbmap))) {
 		jfs_err("jfs_mount: dbMount failed w/rc = %d", rc);
-		goto errout22;
+		goto err_ipbmap;
 	}
 
 	/*
@@ -151,7 +151,7 @@ int jfs_mount(struct super_block *sb)
 		if (!ipaimap2) {
 			jfs_err("jfs_mount: Failed to read AGGREGATE_I");
 			rc = -EIO;
-			goto errout35;
+			goto err_umount_ipbmap;
 		}
 		sbi->ipaimap2 = ipaimap2;
 
@@ -163,7 +163,7 @@ int jfs_mount(struct super_block *sb)
 		if ((rc = diMount(ipaimap2))) {
 			jfs_err("jfs_mount: diMount(ipaimap2) failed, rc = %d",
 				rc);
-			goto errout35;
+			goto err_ipaimap2;
 		}
 	} else
 		/* Secondary aggregate inode table is not valid */
@@ -180,7 +180,7 @@ int jfs_mount(struct super_block *sb)
 		jfs_err("jfs_mount: Failed to read FILESYSTEM_I");
 		/* open fileset secondary inode allocation map */
 		rc = -EIO;
-		goto errout40;
+		goto err_umount_ipaimap2;
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
@@ -190,41 +190,34 @@ int jfs_mount(struct super_block *sb)
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
-		goto errout41;
+		goto err_ipimap;
 	}
 
-	goto out;
+	return rc;
 
 	/*
 	 *	unwind on error
 	 */
-      errout41:		/* close fileset inode allocation map inode */
+err_ipimap:
+	/* close fileset inode allocation map inode */
 	diFreeSpecial(ipimap);
-
-      errout40:		/* fileset closed */
-
+err_umount_ipaimap2:
 	/* close secondary aggregate inode allocation map */
-	if (ipaimap2) {
+	if (ipaimap2)
 		diUnmount(ipaimap2, 1);
+err_ipaimap2:
+	/* close aggregate inodes */
+	if (ipaimap2)
 		diFreeSpecial(ipaimap2);
-	}
-
-      errout35:
-
-	/* close aggregate block allocation map */
+err_umount_ipbmap:	/* close aggregate block allocation map */
 	dbUnmount(ipbmap, 1);
+err_ipbmap:		/* close aggregate inodes */
 	diFreeSpecial(ipbmap);
-
-      errout22:		/* close aggregate inode allocation map */
-
+err_umount_ipaimap:	/* close aggregate inode allocation map */
 	diUnmount(ipaimap, 1);
-
-      errout21:		/* close aggregate inodes */
+err_ipaimap:		/* close aggregate inodes */
 	diFreeSpecial(ipaimap);
-      errout20:		/* aggregate closed */
-
-      out:
-
+out:
 	if (rc)
 		jfs_err("Mount JFS Failure: %d", rc);
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c8863563c6350..287ed99a7e513 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -383,10 +383,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg, u32 ds_idx,
 		goto out_fail;
 
 	ds = mirror->mirror_ds->ds;
+	if (READ_ONCE(ds->ds_clp))
+		goto out;
 	/* matching smp_wmb() in _nfs4_pnfs_v3/4_ds_connect */
 	smp_rmb();
-	if (ds->ds_clp)
-		goto out;
 
 	/* FIXME: For now we assume the server sent only one version of NFS
 	 * to use for the DS.
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 53b4705abcc76..1f2da20946640 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -666,7 +666,7 @@ static int _nfs4_pnfs_v3_ds_connect(struct nfs_server *mds_srv,
 	}
 
 	smp_wmb();
-	ds->ds_clp = clp;
+	WRITE_ONCE(ds->ds_clp, clp);
 	dprintk("%s [new] addr: %s\n", __func__, ds->ds_remotestr);
 out:
 	return status;
@@ -742,7 +742,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 	}
 
 	smp_wmb();
-	ds->ds_clp = clp;
+	WRITE_ONCE(ds->ds_clp, clp);
 	dprintk("%s [new] addr: %s\n", __func__, ds->ds_remotestr);
 out:
 	return status;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index b16a6c0363527..dc51011d670df 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3028,15 +3028,18 @@ nfsd4_encode_dirent(void *ccdv, const char *name, int namlen,
 		goto fail;
 	cd->rd_maxcount -= entry_bytes;
 	/*
-	 * RFC 3530 14.2.24 describes rd_dircount as only a "hint", so
-	 * let's always let through the first entry, at least:
+	 * RFC 3530 14.2.24 describes rd_dircount as only a "hint", and
+	 * notes that it could be zero. If it is zero, then the server
+	 * should enforce only the rd_maxcount value.
 	 */
-	if (!cd->rd_dircount)
-		goto fail;
-	name_and_cookie = 4 + 4 * XDR_QUADLEN(namlen) + 8;
-	if (name_and_cookie > cd->rd_dircount && cd->cookie_offset)
-		goto fail;
-	cd->rd_dircount -= min(cd->rd_dircount, name_and_cookie);
+	if (cd->rd_dircount) {
+		name_and_cookie = 4 + 4 * XDR_QUADLEN(namlen) + 8;
+		if (name_and_cookie > cd->rd_dircount && cd->cookie_offset)
+			goto fail;
+		cd->rd_dircount -= min(cd->rd_dircount, name_and_cookie);
+		if (!cd->rd_dircount)
+			cd->rd_maxcount = 0;
+	}
 
 	cd->cookie_offset = cookie_offset;
 skip_entry:
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f704f90db36cd..2418b9d829ae1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -765,7 +765,10 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net)
 		svc_xprt_put(xprt);
 	}
 out_err:
-	nfsd_destroy(net);
+	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
+		nn->nfsd_serv->sv_nrthreads--;
+	 else
+		nfsd_destroy(net);
 	return err;
 }
 
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index dfb8a923921e0..04bb03b01f62d 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6891,7 +6891,7 @@ void ocfs2_set_inode_data_inline(struct inode *inode, struct ocfs2_dinode *di)
 int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 					 struct buffer_head *di_bh)
 {
-	int ret, i, has_data, num_pages = 0;
+	int ret, has_data, num_pages = 0;
 	int need_free = 0;
 	u32 bit_off, num;
 	handle_t *handle;
@@ -6900,26 +6900,17 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_alloc_context *data_ac = NULL;
-	struct page **pages = NULL;
-	loff_t end = osb->s_clustersize;
+	struct page *page = NULL;
 	struct ocfs2_extent_tree et;
 	int did_quota = 0;
 
 	has_data = i_size_read(inode) ? 1 : 0;
 
 	if (has_data) {
-		pages = kcalloc(ocfs2_pages_per_cluster(osb->sb),
-				sizeof(struct page *), GFP_NOFS);
-		if (pages == NULL) {
-			ret = -ENOMEM;
-			mlog_errno(ret);
-			return ret;
-		}
-
 		ret = ocfs2_reserve_clusters(osb, 1, &data_ac);
 		if (ret) {
 			mlog_errno(ret);
-			goto free_pages;
+			goto out;
 		}
 	}
 
@@ -6939,7 +6930,8 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 	}
 
 	if (has_data) {
-		unsigned int page_end;
+		unsigned int page_end = min_t(unsigned, PAGE_SIZE,
+							osb->s_clustersize);
 		u64 phys;
 
 		ret = dquot_alloc_space_nodirty(inode,
@@ -6963,15 +6955,8 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 		 */
 		block = phys = ocfs2_clusters_to_blocks(inode->i_sb, bit_off);
 
-		/*
-		 * Non sparse file systems zero on extend, so no need
-		 * to do that now.
-		 */
-		if (!ocfs2_sparse_alloc(osb) &&
-		    PAGE_SIZE < osb->s_clustersize)
-			end = PAGE_SIZE;
-
-		ret = ocfs2_grab_eof_pages(inode, 0, end, pages, &num_pages);
+		ret = ocfs2_grab_eof_pages(inode, 0, page_end, &page,
+					   &num_pages);
 		if (ret) {
 			mlog_errno(ret);
 			need_free = 1;
@@ -6982,20 +6967,15 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 		 * This should populate the 1st page for us and mark
 		 * it up to date.
 		 */
-		ret = ocfs2_read_inline_data(inode, pages[0], di_bh);
+		ret = ocfs2_read_inline_data(inode, page, di_bh);
 		if (ret) {
 			mlog_errno(ret);
 			need_free = 1;
 			goto out_unlock;
 		}
 
-		page_end = PAGE_SIZE;
-		if (PAGE_SIZE > osb->s_clustersize)
-			page_end = osb->s_clustersize;
-
-		for (i = 0; i < num_pages; i++)
-			ocfs2_map_and_dirty_page(inode, handle, 0, page_end,
-						 pages[i], i > 0, &phys);
+		ocfs2_map_and_dirty_page(inode, handle, 0, page_end, page, 0,
+					 &phys);
 	}
 
 	spin_lock(&oi->ip_lock);
@@ -7026,8 +7006,8 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 	}
 
 out_unlock:
-	if (pages)
-		ocfs2_unlock_and_free_pages(pages, num_pages);
+	if (page)
+		ocfs2_unlock_and_free_pages(&page, num_pages);
 
 out_commit:
 	if (ret < 0 && did_quota)
@@ -7051,8 +7031,6 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 out:
 	if (data_ac)
 		ocfs2_free_alloc_context(data_ac);
-free_pages:
-	kfree(pages);
 	return ret;
 }
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index d526e86cf5bbe..f584ef6e754a7 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -490,10 +490,11 @@ int ocfs2_truncate_file(struct inode *inode,
 	 * greater than page size, so we have to truncate them
 	 * anyway.
 	 */
-	unmap_mapping_range(inode->i_mapping, new_i_size + PAGE_SIZE - 1, 0, 1);
-	truncate_inode_pages(inode->i_mapping, new_i_size);
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		unmap_mapping_range(inode->i_mapping,
+				    new_i_size + PAGE_SIZE - 1, 0, 1);
+		truncate_inode_pages(inode->i_mapping, new_i_size);
 		status = ocfs2_truncate_inline(inode, di_bh, new_i_size,
 					       i_size_read(inode), 1);
 		if (status)
@@ -512,6 +513,9 @@ int ocfs2_truncate_file(struct inode *inode,
 		goto bail_unlock_sem;
 	}
 
+	unmap_mapping_range(inode->i_mapping, new_i_size + PAGE_SIZE - 1, 0, 1);
+	truncate_inode_pages(inode->i_mapping, new_i_size);
+
 	status = ocfs2_commit_truncate(osb, inode, di_bh);
 	if (status < 0) {
 		mlog_errno(status);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index e0fb62f5cf63d..454aad87b866c 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2189,11 +2189,17 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	}
 
 	if (ocfs2_clusterinfo_valid(osb)) {
+		/*
+		 * ci_stack and ci_cluster in ocfs2_cluster_info may not be null
+		 * terminated, so make sure no overflow happens here by using
+		 * memcpy. Destination strings will always be null terminated
+		 * because osb is allocated using kzalloc.
+		 */
 		osb->osb_stackflags =
 			OCFS2_RAW_SB(di)->s_cluster_info.ci_stackflags;
-		strlcpy(osb->osb_cluster_stack,
+		memcpy(osb->osb_cluster_stack,
 		       OCFS2_RAW_SB(di)->s_cluster_info.ci_stack,
-		       OCFS2_STACK_LABEL_LEN + 1);
+		       OCFS2_STACK_LABEL_LEN);
 		if (strlen(osb->osb_cluster_stack) != OCFS2_STACK_LABEL_LEN) {
 			mlog(ML_ERROR,
 			     "couldn't mount because of an invalid "
@@ -2202,9 +2208,9 @@ static int ocfs2_initialize_super(struct super_block *sb,
 			status = -EINVAL;
 			goto bail;
 		}
-		strlcpy(osb->osb_cluster_name,
+		memcpy(osb->osb_cluster_name,
 			OCFS2_RAW_SB(di)->s_cluster_info.ci_cluster,
-			OCFS2_CLUSTER_NAME_LEN + 1);
+			OCFS2_CLUSTER_NAME_LEN);
 	} else {
 		/* The empty string is identical with classic tools that
 		 * don't know about s_cluster_info. */
diff --git a/fs/orangefs/dcache.c b/fs/orangefs/dcache.c
index 5355efba4bc8c..1942f9946ab77 100644
--- a/fs/orangefs/dcache.c
+++ b/fs/orangefs/dcache.c
@@ -25,8 +25,10 @@ static int orangefs_revalidate_lookup(struct dentry *dentry)
 	gossip_debug(GOSSIP_DCACHE_DEBUG, "%s: attempting lookup.\n", __func__);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_LOOKUP);
-	if (!new_op)
+	if (!new_op) {
+		ret = -ENOMEM;
 		goto out_put_parent;
+	}
 
 	new_op->upcall.req.lookup.sym_follow = ORANGEFS_LOOKUP_LINK_NO_FOLLOW;
 	new_op->upcall.req.lookup.parent_refn = parent->refn;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 8546384a5fdfd..edd5979aca4f6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -926,9 +926,13 @@ static int ovl_rename2(struct inode *olddir, struct dentry *old,
 				goto out_dput;
 		}
 	} else {
-		if (!d_is_negative(newdentry) &&
-		    (!new_opaque || !ovl_is_whiteout(newdentry)))
-			goto out_dput;
+		if (!d_is_negative(newdentry)) {
+			if (!new_opaque || !ovl_is_whiteout(newdentry))
+				goto out_dput;
+		} else {
+			if (flags & RENAME_EXCHANGE)
+				goto out_dput;
+		}
 	}
 
 	if (olddentry == trap)
diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index ecd9887b0d1fe..8c7705b50e5dd 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -422,6 +422,7 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		quota_error(dquot->dq_sb, "Quota structure has offset to "
 			"other block (%u) than it should (%u)", blk,
 			(uint)(dquot->dq_off >> info->dqi_blocksize_bits));
+		ret = -EIO;
 		goto out_buf;
 	}
 	ret = read_blk(info, blk, buf);
@@ -487,6 +488,13 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		goto out_buf;
 	}
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
+	if (newblk < QT_TREEOFF || newblk >= info->dqi_blocks) {
+		quota_error(dquot->dq_sb, "Getting block too big (%u >= %u)",
+			    newblk, info->dqi_blocks);
+		ret = -EUCLEAN;
+		goto out_buf;
+	}
+
 	if (depth == info->dqi_qtree_depth - 1) {
 		ret = free_dqentry(info, dquot, newblk);
 		newblk = 0;
@@ -586,6 +594,13 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
 	if (!blk)	/* No reference? */
 		goto out_buf;
+	if (blk < QT_TREEOFF || blk >= info->dqi_blocks) {
+		quota_error(dquot->dq_sb, "Getting block too big (%u >= %u)",
+			    blk, info->dqi_blocks);
+		ret = -EUCLEAN;
+		goto out_buf;
+	}
+
 	if (depth < info->dqi_qtree_depth - 1)
 		ret = find_tree_dqentry(info, dquot, blk, depth+1);
 	else
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 21d36d2847356..985cccfcedad9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -429,7 +429,8 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	/* Do not set bits for OTH */
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
 	inode->i_op = ops;
 	inode->i_fop = &simple_dir_operations;
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 0a4c2d4d9f8d5..b43fa9d95a7a6 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -847,6 +847,19 @@ static inline bool arch_has_pfn_modify_check(void)
 #define io_remap_pfn_range remap_pfn_range
 #endif
 
+#if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+/*
+ * ZSMALLOC needs to know the highest PFN on 32-bit architectures
+ * with physical address space extension, but falls back to
+ * BITS_PER_LONG otherwise.
+ */
+#error Missing MAX_POSSIBLE_PHYSMEM_BITS definition
+#else
+#define MAX_POSSIBLE_PHYSMEM_BITS 32
+#endif
+#endif
+
 #ifndef has_transparent_hugepage
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define has_transparent_hugepage() 1
diff --git a/include/linux/console.h b/include/linux/console.h
index d530c4627e54e..118c33aa5ecfa 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -135,6 +135,8 @@ struct console {
 	short	flags;
 	short	index;
 	int	cflag;
+	uint	ispeed;
+	uint	ospeed;
 	void	*data;
 	struct	 console *next;
 };
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 4adf7faeaeb59..a65dadad65bf8 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -55,7 +55,7 @@ static inline int elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregse
 }
 #endif
 
-#if defined(CONFIG_UM) || defined(CONFIG_IA64)
+#if (defined(CONFIG_UML) && defined(CONFIG_X86_32)) || defined(CONFIG_IA64)
 /*
  * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
  * extra segments containing the gate DSO contents.  Dumping its
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 0837d904405a3..05be3d84655e4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -600,6 +600,7 @@ void bpf_warn_invalid_xdp_action(u32 act);
 extern int bpf_jit_enable;
 extern int bpf_jit_harden;
 extern long bpf_jit_limit;
+extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index de770d11a5c18..208534322bcdc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -404,7 +404,7 @@ enum {
 	/* This should match the actual table size of
 	 * ata_eh_cmd_timeout_table in libata-eh.c.
 	 */
-	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 6,
+	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 7,
 
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependent */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 558adfa5c8a87..53ac461f342bb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1147,22 +1147,22 @@
  *
  * @binder_set_context_mgr
  *	Check whether @mgr is allowed to be the binder context manager.
- *	@mgr contains the task_struct for the task being registered.
+ *	@mgr contains the struct cred for the current binder process.
  *	Return 0 if permission is granted.
  * @binder_transaction
  *	Check whether @from is allowed to invoke a binder transaction call
  *	to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_binder
+ *	@from contains the struct cred for the sending process.
+ *	@to contains the struct cred for the receiving process.
+ * @binder_transfer_binder:
  *	Check whether @from is allowed to transfer a binder reference to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_file
+ *	@from contains the struct cred for the sending process.
+ *	@to contains the struct cred for the receiving process.
+ * @binder_transfer_file:
  *	Check whether @from is allowed to transfer @file to @to.
- *	@from contains the task_struct for the sending task.
+ *	@from contains the struct cred for the sending process.
  *	@file contains the struct file being transferred.
- *	@to contains the task_struct for the receiving task.
+ *	@to contains the struct cred for the receiving process.
  *
  * @ptrace_access_check:
  *	Check permission before allowing the current process to trace the
@@ -1332,13 +1332,13 @@
  */
 
 union security_list_options {
-	int (*binder_set_context_mgr)(struct task_struct *mgr);
-	int (*binder_transaction)(struct task_struct *from,
-					struct task_struct *to);
-	int (*binder_transfer_binder)(struct task_struct *from,
-					struct task_struct *to);
-	int (*binder_transfer_file)(struct task_struct *from,
-					struct task_struct *to,
+	int (*binder_set_context_mgr)(const struct cred *mgr);
+	int (*binder_transaction)(const struct cred *from,
+					const struct cred *to);
+	int (*binder_transfer_binder)(const struct cred *from,
+					const struct cred *to);
+	int (*binder_transfer_file)(const struct cred *from,
+					const struct cred *to,
 					struct file *file);
 
 	int (*ptrace_access_check)(struct task_struct *child,
diff --git a/include/linux/security.h b/include/linux/security.h
index c2125e9093e8e..2f5d282bd3eca 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -184,13 +184,13 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 extern int security_init(void);
 
 /* Security operations */
-int security_binder_set_context_mgr(struct task_struct *mgr);
-int security_binder_transaction(struct task_struct *from,
-				struct task_struct *to);
-int security_binder_transfer_binder(struct task_struct *from,
-				    struct task_struct *to);
-int security_binder_transfer_file(struct task_struct *from,
-				  struct task_struct *to, struct file *file);
+int security_binder_set_context_mgr(const struct cred *mgr);
+int security_binder_transaction(const struct cred *from,
+				const struct cred *to);
+int security_binder_transfer_binder(const struct cred *from,
+				    const struct cred *to);
+int security_binder_transfer_file(const struct cred *from,
+				  const struct cred *to, struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(struct task_struct *target,
@@ -394,25 +394,25 @@ static inline int security_init(void)
 	return 0;
 }
 
-static inline int security_binder_set_context_mgr(struct task_struct *mgr)
+static inline int security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return 0;
 }
 
-static inline int security_binder_transaction(struct task_struct *from,
-					      struct task_struct *to)
+static inline int security_binder_transaction(const struct cred *from,
+					      const struct cred *to)
 {
 	return 0;
 }
 
-static inline int security_binder_transfer_binder(struct task_struct *from,
-						  struct task_struct *to)
+static inline int security_binder_transfer_binder(const struct cred *from,
+						  const struct cred *to)
 {
 	return 0;
 }
 
-static inline int security_binder_transfer_file(struct task_struct *from,
-						struct task_struct *to,
+static inline int security_binder_transfer_file(const struct cred *from,
+						const struct cred *to,
 						struct file *file)
 {
 	return 0;
diff --git a/include/net/llc.h b/include/net/llc.h
index 95e5ced4c1339..18dfd3e49a69f 100644
--- a/include/net/llc.h
+++ b/include/net/llc.h
@@ -72,7 +72,9 @@ struct llc_sap {
 static inline
 struct hlist_head *llc_sk_dev_hash(struct llc_sap *sap, int ifindex)
 {
-	return &sap->sk_dev_hash[ifindex % LLC_SK_DEV_HASH_ENTRIES];
+	u32 bucket = hash_32(ifindex, LLC_SK_DEV_HASH_BITS);
+
+	return &sap->sk_dev_hash[bucket];
 }
 
 static inline
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 8a70d38f13329..0c7dd6dd23957 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -779,8 +779,9 @@ struct se_device {
 	atomic_long_t		read_bytes;
 	atomic_long_t		write_bytes;
 	/* Active commands on this virtual SE device */
-	atomic_t		simple_cmds;
-	atomic_t		dev_ordered_sync;
+	atomic_t		non_ordered;
+	bool			ordered_sync_in_progress;
+	atomic_t		delayed_cmd_count;
 	atomic_t		dev_qf_count;
 	u32			export_count;
 	spinlock_t		delayed_cmd_lock;
@@ -803,6 +804,7 @@ struct se_device {
 	struct list_head	dev_tmr_list;
 	struct workqueue_struct *tmr_wq;
 	struct work_struct	qf_work_queue;
+	struct work_struct	delayed_cmd_work;
 	struct list_head	delayed_cmd_list;
 	struct list_head	state_list;
 	struct list_head	qf_cmd_list;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ecc8e01c56163..9d846dfb9e904 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -488,6 +488,12 @@
 #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
 #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
 #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
+#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
+#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
 #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
 #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index df2ebce927ec4..3ce69c0276c09 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -212,6 +212,7 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
 int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
+long bpf_jit_limit_max __read_mostly;
 
 static atomic_long_t bpf_jit_current;
 
@@ -231,7 +232,8 @@ u64 __weak bpf_jit_alloc_exec_limit(void)
 static int __init bpf_jit_charge_init(void)
 {
 	/* Only used as heuristic here to derive limit. */
-	bpf_jit_limit = min_t(u64, round_up(bpf_jit_alloc_exec_limit() >> 2,
+	bpf_jit_limit_max = bpf_jit_alloc_exec_limit();
+	bpf_jit_limit = min_t(u64, round_up(bpf_jit_limit_max >> 2,
 					    PAGE_SIZE), LONG_MAX);
 	return 0;
 }
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2fdf6f96f9762..6f09728cd1dd3 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -28,7 +28,8 @@ struct bpf_stack_map {
 
 static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
 {
-	u32 elem_size = sizeof(struct stack_map_bucket) + smap->map.value_size;
+	u64 elem_size = sizeof(struct stack_map_bucket) +
+			(u64)smap->map.value_size;
 	int err;
 
 	smap->elems = bpf_map_area_alloc(elem_size * smap->map.max_entries);
diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index f087fbe79e3a9..b750eb60fe795 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -1564,6 +1564,7 @@ static int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
 	int ssid, i, ret;
+	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -1580,8 +1581,28 @@ static int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		/* can't move between two non-dummy roots either */
 		if (ss->root != &cgrp_dfl_root && dst_root != &cgrp_dfl_root)
 			return -EBUSY;
+
+		/*
+		 * Collect ssid's that need to be disabled from default
+		 * hierarchy.
+		 */
+		if (ss->root == &cgrp_dfl_root)
+			dfl_disable_ss_mask |= 1 << ssid;
+
 	} while_each_subsys_mask();
 
+	if (dfl_disable_ss_mask) {
+		struct cgroup *scgrp = &cgrp_dfl_root.cgrp;
+
+		/*
+		 * Controllers from default hierarchy that need to be rebound
+		 * are all disabled together in one go.
+		 */
+		cgrp_dfl_root.subsys_mask &= ~dfl_disable_ss_mask;
+		WARN_ON(cgroup_apply_control(scgrp));
+		cgroup_finalize_control(scgrp, 0);
+	}
+
 	do_each_subsys_mask(ss, ssid, ss_mask) {
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
@@ -1590,10 +1611,12 @@ static int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
-		/* disable from the source */
-		src_root->subsys_mask &= ~(1 << ssid);
-		WARN_ON(cgroup_apply_control(scgrp));
-		cgroup_finalize_control(scgrp, 0);
+		if (src_root != &cgrp_dfl_root) {
+			/* disable from the source */
+			src_root->subsys_mask &= ~(1 << ssid);
+			WARN_ON(cgroup_apply_control(scgrp));
+			cgroup_finalize_control(scgrp, 0);
+		}
 
 		/* rebind */
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0069ccc49ccfe..c2458fd7f97b6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -709,7 +709,7 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu_notrace(class, hash_head, hash_entry) {
 		if (class->key == key) {
 			/*
 			 * Huh! same key, different name? Did someone trample
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index a3b1e617bcdc3..8009cd308fcc6 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1528,9 +1528,10 @@ int swsusp_read(unsigned int *flags_p)
 int swsusp_check(void)
 {
 	int error;
+	void *holder;
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    FMODE_READ, NULL);
+					    FMODE_READ | FMODE_EXCL, &holder);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
@@ -1552,7 +1553,7 @@ int swsusp_check(void)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, FMODE_READ);
+			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
 		else
 			pr_debug("PM: Image signature found, resuming\n");
 	} else {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 274bff6b45e37..3f1b762a0c307 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2124,8 +2124,15 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
-	if (str[0] == 0)
+	/*
+	 * console="" or console=null have been suggested as a way to
+	 * disable console output. Use ttynull that has been created
+	 * for exacly this purpose.
+	 */
+	if (str[0] == 0 || strcmp(str, "null") == 0) {
+		__add_preferred_console("ttynull", 0, NULL, NULL);
 		return 1;
+	}
 
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b2f929324e713..9c669a520f3e2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2034,6 +2034,9 @@ void wake_up_if_idle(int cpu)
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
 {
+	if (this_cpu == that_cpu)
+		return true;
+
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 #endif /* CONFIG_SMP */
diff --git a/kernel/signal.c b/kernel/signal.c
index aca4b4cd11a2c..6f30a87457757 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1919,16 +1919,6 @@ static inline int may_ptrace_stop(void)
 	return 1;
 }
 
-/*
- * Return non-zero if there is a SIGKILL that should be waking us up.
- * Called with the siglock held.
- */
-static int sigkill_pending(struct task_struct *tsk)
-{
-	return	sigismember(&tsk->pending.signal, SIGKILL) ||
-		sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
-}
-
 /*
  * This must be called with current->sighand->siglock held.
  *
@@ -1954,15 +1944,10 @@ static void ptrace_stop(int exit_code, int why, int clear_code, siginfo_t *info)
 		 * calling arch_ptrace_stop, so we must release it now.
 		 * To preserve proper semantics, we must do this before
 		 * any signal bookkeeping like checking group_stop_count.
-		 * Meanwhile, a SIGKILL could come in before we retake the
-		 * siglock.  That must prevent us from sleeping in TASK_TRACED.
-		 * So after regaining the lock, we must check for SIGKILL.
 		 */
 		spin_unlock_irq(&current->sighand->siglock);
 		arch_ptrace_stop(exit_code, info);
 		spin_lock_irq(&current->sighand->siglock);
-		if (sigkill_pending(current))
-			return;
 	}
 
 	/*
@@ -1971,6 +1956,8 @@ static void ptrace_stop(int exit_code, int why, int clear_code, siginfo_t *info)
 	 * Also, transition to TRACED and updates to ->jobctl should be
 	 * atomic with respect to siglock and should be done after the arch
 	 * hook as siglock is released and regrabbed across it.
+	 * schedule() will not sleep if there is a pending signal that
+	 * can awaken the task.
 	 */
 	set_current_state(TASK_TRACED);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 84f2caf6a6991..06841602025ef 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5288,7 +5288,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *op;
 	int bit;
 
-	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
+	bit = trace_test_and_set_recursion(TRACE_LIST_START);
 	if (bit < 0)
 		return;
 
@@ -5363,7 +5363,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 {
 	int bit;
 
-	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
+	bit = trace_test_and_set_recursion(TRACE_LIST_START);
 	if (bit < 0)
 		return;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ba97ed7bc9471..14578da6ffd1a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -448,23 +448,8 @@ struct tracer {
  *  When function tracing occurs, the following steps are made:
  *   If arch does not support a ftrace feature:
  *    call internal function (uses INTERNAL bits) which calls...
- *   If callback is registered to the "global" list, the list
- *    function is called and recursion checks the GLOBAL bits.
- *    then this function calls...
  *   The function callback, which can use the FTRACE bits to
  *    check for recursion.
- *
- * Now if the arch does not suppport a feature, and it calls
- * the global list function which calls the ftrace callback
- * all three of these steps will do a recursion protection.
- * There's no reason to do one if the previous caller already
- * did. The recursion that we are protecting against will
- * go through the same steps again.
- *
- * To prevent the multiple recursion checks, if a recursion
- * bit is set that is higher than the MAX bit of the current
- * check, then we know that the check was made by the previous
- * caller, and we can skip the current check.
  */
 enum {
 	TRACE_BUFFER_BIT,
@@ -477,12 +462,14 @@ enum {
 	TRACE_FTRACE_NMI_BIT,
 	TRACE_FTRACE_IRQ_BIT,
 	TRACE_FTRACE_SIRQ_BIT,
+	TRACE_FTRACE_TRANSITION_BIT,
 
-	/* INTERNAL_BITs must be greater than FTRACE_BITs */
+	/* Internal use recursion bits */
 	TRACE_INTERNAL_BIT,
 	TRACE_INTERNAL_NMI_BIT,
 	TRACE_INTERNAL_IRQ_BIT,
 	TRACE_INTERNAL_SIRQ_BIT,
+	TRACE_INTERNAL_TRANSITION_BIT,
 
 	TRACE_BRANCH_BIT,
 /*
@@ -493,12 +480,6 @@ enum {
  * can only be modified by current, we can reuse trace_recursion.
  */
 	TRACE_IRQ_BIT,
-
-	/*
-	 * When transitioning between context, the preempt_count() may
-	 * not be correct. Allow for a single recursion to cover this case.
-	 */
-	TRACE_TRANSITION_BIT,
 };
 
 #define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
@@ -508,12 +489,18 @@ enum {
 #define TRACE_CONTEXT_BITS	4
 
 #define TRACE_FTRACE_START	TRACE_FTRACE_BIT
-#define TRACE_FTRACE_MAX	((1 << (TRACE_FTRACE_START + TRACE_CONTEXT_BITS)) - 1)
 
 #define TRACE_LIST_START	TRACE_INTERNAL_BIT
-#define TRACE_LIST_MAX		((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
 
-#define TRACE_CONTEXT_MASK	TRACE_LIST_MAX
+#define TRACE_CONTEXT_MASK	((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
+
+enum {
+	TRACE_CTX_NMI,
+	TRACE_CTX_IRQ,
+	TRACE_CTX_SOFTIRQ,
+	TRACE_CTX_NORMAL,
+	TRACE_CTX_TRANSITION,
+};
 
 static __always_inline int trace_get_context_bit(void)
 {
@@ -521,59 +508,48 @@ static __always_inline int trace_get_context_bit(void)
 
 	if (in_interrupt()) {
 		if (in_nmi())
-			bit = 0;
+			bit = TRACE_CTX_NMI;
 
 		else if (in_irq())
-			bit = 1;
+			bit = TRACE_CTX_IRQ;
 		else
-			bit = 2;
+			bit = TRACE_CTX_SOFTIRQ;
 	} else
-		bit = 3;
+		bit = TRACE_CTX_NORMAL;
 
 	return bit;
 }
 
-static __always_inline int trace_test_and_set_recursion(int start, int max)
+static __always_inline int trace_test_and_set_recursion(int start)
 {
 	unsigned int val = current->trace_recursion;
 	int bit;
 
-	/* A previous recursion check was made */
-	if ((val & TRACE_CONTEXT_MASK) > max)
-		return 0;
-
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
 		/*
 		 * It could be that preempt_count has not been updated during
 		 * a switch between contexts. Allow for a single recursion.
 		 */
-		bit = TRACE_TRANSITION_BIT;
+		bit = start + TRACE_CTX_TRANSITION;
 		if (trace_recursion_test(bit))
 			return -1;
 		trace_recursion_set(bit);
 		barrier();
-		return bit + 1;
+		return bit;
 	}
 
-	/* Normal check passed, clear the transition to allow it again */
-	trace_recursion_clear(TRACE_TRANSITION_BIT);
-
 	val |= 1 << bit;
 	current->trace_recursion = val;
 	barrier();
 
-	return bit + 1;
+	return bit;
 }
 
 static __always_inline void trace_clear_recursion(int bit)
 {
 	unsigned int val = current->trace_recursion;
 
-	if (!bit)
-		return;
-
-	bit--;
 	bit = 1 << bit;
 	val &= ~bit;
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 0efa00d80623d..9434d2fe932f5 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -137,7 +137,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	pc = preempt_count();
 	preempt_disable_notrace();
 
-	bit = trace_test_and_set_recursion(TRACE_FTRACE_START, TRACE_FTRACE_MAX);
+	bit = trace_test_and_set_recursion(TRACE_FTRACE_START);
 	if (bit < 0)
 		goto out;
 
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 35b2ba07f3c6f..379db35838b64 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -703,29 +703,35 @@ int tracing_map_init(struct tracing_map *map)
 	return err;
 }
 
-static int cmp_entries_dup(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_dup(const void *A, const void *B)
 {
+	const struct tracing_map_sort_entry *a, *b;
 	int ret = 0;
 
-	if (memcmp((*a)->key, (*b)->key, (*a)->elt->map->key_size))
+	a = *(const struct tracing_map_sort_entry **)A;
+	b = *(const struct tracing_map_sort_entry **)B;
+
+	if (memcmp(a->key, b->key, a->elt->map->key_size))
 		ret = 1;
 
 	return ret;
 }
 
-static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_sum(const void *A, const void *B)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
+	const struct tracing_map_sort_entry *a, *b;
 	struct tracing_map_sort_key *sort_key;
 	struct tracing_map_field *field;
 	tracing_map_cmp_fn_t cmp_fn;
 	void *val_a, *val_b;
 	int ret = 0;
 
-	elt_a = (*a)->elt;
-	elt_b = (*b)->elt;
+	a = *(const struct tracing_map_sort_entry **)A;
+	b = *(const struct tracing_map_sort_entry **)B;
+
+	elt_a = a->elt;
+	elt_b = b->elt;
 
 	sort_key = &elt_a->map->sort_key;
 
@@ -742,18 +748,21 @@ static int cmp_entries_sum(const struct tracing_map_sort_entry **a,
 	return ret;
 }
 
-static int cmp_entries_key(const struct tracing_map_sort_entry **a,
-			   const struct tracing_map_sort_entry **b)
+static int cmp_entries_key(const void *A, const void *B)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
+	const struct tracing_map_sort_entry *a, *b;
 	struct tracing_map_sort_key *sort_key;
 	struct tracing_map_field *field;
 	tracing_map_cmp_fn_t cmp_fn;
 	void *val_a, *val_b;
 	int ret = 0;
 
-	elt_a = (*a)->elt;
-	elt_b = (*b)->elt;
+	a = *(const struct tracing_map_sort_entry **)A;
+	b = *(const struct tracing_map_sort_entry **)B;
+
+	elt_a = a->elt;
+	elt_b = b->elt;
 
 	sort_key = &elt_a->map->sort_key;
 
@@ -926,10 +935,8 @@ static void sort_secondary(struct tracing_map *map,
 			   struct tracing_map_sort_key *primary_key,
 			   struct tracing_map_sort_key *secondary_key)
 {
-	int (*primary_fn)(const struct tracing_map_sort_entry **,
-			  const struct tracing_map_sort_entry **);
-	int (*secondary_fn)(const struct tracing_map_sort_entry **,
-			    const struct tracing_map_sort_entry **);
+	int (*primary_fn)(const void *, const void *);
+	int (*secondary_fn)(const void *, const void *);
 	unsigned i, start = 0, n_sub = 1;
 
 	if (is_key(map, primary_key->field_idx))
@@ -998,8 +1005,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
 			     unsigned int n_sort_keys,
 			     struct tracing_map_sort_entry ***sort_entries)
 {
-	int (*cmp_entries_fn)(const struct tracing_map_sort_entry **,
-			      const struct tracing_map_sort_entry **);
+	int (*cmp_entries_fn)(const void *, const void *);
 	struct tracing_map_sort_entry *sort_entry, **entries;
 	int i, n_entries, ret;
 
diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 25d59a95bd668..abea25310ac73 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -167,7 +167,7 @@
  * memeq and memzero are not used much and any remotely sane implementation
  * is fast enough. memcpy/memmove speed matters in multi-call mode, but
  * the kernel image is decompressed in single-call mode, in which only
- * memcpy speed can matter and only if there is a lot of uncompressible data
+ * memmove speed can matter and only if there is a lot of uncompressible data
  * (LZMA2 stores uncompressible chunks in uncompressed form). Thus, the
  * functions below should just be kept small; it's probably not worth
  * optimizing for speed.
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 08c3c80499983..2c5197d6b944d 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -387,7 +387,14 @@ static void dict_uncompressed(struct dictionary *dict, struct xz_buf *b,
 
 		*left -= copy_size;
 
-		memcpy(dict->buf + dict->pos, b->in + b->in_pos, copy_size);
+		/*
+		 * If doing in-place decompression in single-call mode and the
+		 * uncompressed size of the file is larger than the caller
+		 * thought (i.e. it is invalid input!), the buffers below may
+		 * overlap and cause undefined behavior with memcpy().
+		 * With valid inputs memcpy() would be fine here.
+		 */
+		memmove(dict->buf + dict->pos, b->in + b->in_pos, copy_size);
 		dict->pos += copy_size;
 
 		if (dict->full < dict->pos)
@@ -397,7 +404,11 @@ static void dict_uncompressed(struct dictionary *dict, struct xz_buf *b,
 			if (dict->pos == dict->end)
 				dict->pos = 0;
 
-			memcpy(b->out + b->out_pos, b->in + b->in_pos,
+			/*
+			 * Like above but for multi-call mode: use memmove()
+			 * to avoid undefined behavior with invalid input.
+			 */
+			memmove(b->out + b->out_pos, b->in + b->in_pos,
 					copy_size);
 		}
 
@@ -421,6 +432,12 @@ static uint32_t dict_flush(struct dictionary *dict, struct xz_buf *b)
 		if (dict->pos == dict->end)
 			dict->pos = 0;
 
+		/*
+		 * These buffers cannot overlap even if doing in-place
+		 * decompression because in multi-call mode dict->buf
+		 * has been allocated by us in this file; it's not
+		 * provided by the caller like in single-call mode.
+		 */
 		memcpy(b->out + b->out_pos, dict->buf + dict->start,
 				copy_size);
 	}
diff --git a/lib/xz/xz_dec_stream.c b/lib/xz/xz_dec_stream.c
index ac809b1e64f78..9e5b9ab537fea 100644
--- a/lib/xz/xz_dec_stream.c
+++ b/lib/xz/xz_dec_stream.c
@@ -402,12 +402,12 @@ static enum xz_ret dec_stream_header(struct xz_dec *s)
 	 * we will accept other check types too, but then the check won't
 	 * be verified and a warning (XZ_UNSUPPORTED_CHECK) will be given.
 	 */
+	if (s->temp.buf[HEADER_MAGIC_SIZE + 1] > XZ_CHECK_MAX)
+		return XZ_OPTIONS_ERROR;
+
 	s->check_type = s->temp.buf[HEADER_MAGIC_SIZE + 1];
 
 #ifdef XZ_DEC_ANY_CHECK
-	if (s->check_type > XZ_CHECK_MAX)
-		return XZ_OPTIONS_ERROR;
-
 	if (s->check_type > XZ_CHECK_CRC32)
 		return XZ_UNSUPPORTED_CHECK;
 #else
diff --git a/localversion-rt b/localversion-rt
index 4897a28dc47fe..204b8d4c3b7d1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt189
+-rt190
diff --git a/mm/gup.c b/mm/gup.c
index 6bb7a8eb7f820..301dd96ef176c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -61,13 +61,22 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 }
 
 /*
- * FOLL_FORCE can write to even unwritable pte's, but only
- * after we've gone through a COW cycle and they are dirty.
+ * FOLL_FORCE or a forced COW break can write even to unwritable pte's,
+ * but only after we've gone through a COW cycle and they are dirty.
  */
 static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
 {
-	return pte_write(pte) ||
-		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
+	return pte_write(pte) || ((flags & FOLL_COW) && pte_dirty(pte));
+}
+
+/*
+ * A (separate) COW fault might break the page the other way and
+ * get_user_pages() would return the page from what is now the wrong
+ * VM. So we need to force a COW break at GUP time even for reads.
+ */
+static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
+{
+	return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
@@ -577,12 +586,18 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			if (!vma || check_vma_flags(vma, gup_flags))
 				return i ? : -EFAULT;
 			if (is_vm_hugetlb_page(vma)) {
+				if (should_force_cow_break(vma, foll_flags))
+					foll_flags |= FOLL_WRITE;
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
-						gup_flags);
+						foll_flags);
 				continue;
 			}
 		}
+
+		if (should_force_cow_break(vma, foll_flags))
+			foll_flags |= FOLL_WRITE;
+
 retry:
 		/*
 		 * If we have a pending SIGKILL, don't keep faulting pages and
@@ -1503,6 +1518,10 @@ static int gup_pud_range(pgd_t pgd, unsigned long addr, unsigned long end,
 /*
  * Like get_user_pages_fast() except it's IRQ-safe in that it won't fall back to
  * the regular GUP. It will only return non-negative values.
+ *
+ * Careful, careful! COW breaking can go either way, so a non-write
+ * access can get ambiguous page results. If you call this function without
+ * 'write' set, you'd better be sure that you're ok with that ambiguity.
  */
 int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
@@ -1532,6 +1551,12 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 *
 	 * We do not adopt an rcu_read_lock(.) here as we also want to
 	 * block IPIs that come from THPs splitting.
+	 *
+	 * NOTE! We allow read-only gup_fast() here, but you'd better be
+	 * careful about possible COW pages. You'll get _a_ COW page, but
+	 * not necessarily the one you intended to get depending on what
+	 * COW event happens after this. COW may break the page copy in a
+	 * random direction.
 	 */
 
 	local_irq_save(flags);
@@ -1542,15 +1567,22 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			break;
+		/*
+		 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
+		 * because get_user_pages() may need to cause an early COW in
+		 * order to avoid confusing the normal COW routines. So only
+		 * targets that are already writable are safe to do by just
+		 * looking at the page tables.
+		 */
 		if (unlikely(pgd_huge(pgd))) {
-			if (!gup_huge_pgd(pgd, pgdp, addr, next, write,
+			if (!gup_huge_pgd(pgd, pgdp, addr, next, 1,
 					  pages, &nr))
 				break;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
 			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
-					 PGDIR_SHIFT, next, write, pages, &nr))
+					 PGDIR_SHIFT, next, 1, pages, &nr))
 				break;
-		} else if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+		} else if (!gup_pud_range(pgd, addr, next, 1, pages, &nr))
 			break;
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_restore(flags);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 91f33bb43f178..3f3a86cc62b68 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1135,13 +1135,12 @@ int do_huge_pmd_wp_page(struct fault_env *fe, pmd_t orig_pmd)
 }
 
 /*
- * FOLL_FORCE can write to even unwritable pmd's, but only
- * after we've gone through a COW cycle and they are dirty.
+ * FOLL_FORCE or a forced COW break can write even to unwritable pmd's,
+ * but only after we've gone through a COW cycle and they are dirty.
  */
 static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
 {
-	return pmd_write(pmd) ||
-	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
+	return pmd_write(pmd) || ((flags & FOLL_COW) && pmd_dirty(pmd));
 }
 
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index d514eebad905e..c78a6abb6f2b6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1078,25 +1078,22 @@ bool out_of_memory(struct oom_control *oc)
 }
 
 /*
- * The pagefault handler calls here because it is out of memory, so kill a
- * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
- * killing is already in progress so do nothing.
+ * The pagefault handler calls here because some allocation has failed. We have
+ * to take care of the memcg OOM here because this is the only safe context without
+ * any locks held but let the oom killer triggered from the allocation context care
+ * about the global OOM.
  */
 void pagefault_out_of_memory(void)
 {
-	struct oom_control oc = {
-		.zonelist = NULL,
-		.nodemask = NULL,
-		.memcg = NULL,
-		.gfp_mask = 0,
-		.order = 0,
-	};
+	static DEFINE_RATELIMIT_STATE(pfoom_rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 
 	if (mem_cgroup_oom_synchronize(true))
 		return;
 
-	if (!mutex_trylock(&oom_lock))
+	if (fatal_signal_pending(current))
 		return;
-	out_of_memory(&oc);
-	mutex_unlock(&oom_lock);
+
+	if (__ratelimit(&pfoom_rs))
+		pr_warn("Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF\n");
 }
diff --git a/mm/slab.h b/mm/slab.h
index dfd281e43fbee..0cdef21a33b6d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -139,7 +139,7 @@ static inline unsigned long kmem_cache_flags(unsigned long object_size,
 #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
 			  SLAB_TEMPORARY | SLAB_NOTRACK | SLAB_ACCOUNT)
 #else
-#define SLAB_CACHE_FLAGS (0)
+#define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
 #endif
 
 #define CACHE_CREATE_MASK (SLAB_CORE_FLAGS | SLAB_DEBUG_FLAGS | SLAB_CACHE_FLAGS)
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b4bd01bf7770c..ed8fcd21e9cdf 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -97,18 +97,19 @@ struct zsmalloc_handle {
  * This is made more complicated by various memory models and PAE.
  */
 
-#ifndef MAX_PHYSMEM_BITS
-#ifdef CONFIG_HIGHMEM64G
-#define MAX_PHYSMEM_BITS 36
-#else /* !CONFIG_HIGHMEM64G */
+#ifndef MAX_POSSIBLE_PHYSMEM_BITS
+#ifdef MAX_PHYSMEM_BITS
+#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
+#else
 /*
  * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
  * be PAGE_SHIFT
  */
-#define MAX_PHYSMEM_BITS BITS_PER_LONG
+#define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
 #endif
 #endif
-#define _PFN_BITS		(MAX_PHYSMEM_BITS - PAGE_SHIFT)
+
+#define _PFN_BITS		(MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
 
 /*
  * Memory for allocating for handle keeps object position by
@@ -2029,10 +2030,11 @@ static inline void zs_pool_dec_isolated(struct zs_pool *pool)
 	VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
 	atomic_long_dec(&pool->isolated_pages);
 	/*
-	 * There's no possibility of racing, since wait_for_isolated_drain()
-	 * checks the isolated count under &class->lock after enqueuing
-	 * on migration_wait.
+	 * Checking pool->destroying must happen after atomic_long_dec()
+	 * for pool->isolated_pages above. Paired with the smp_mb() in
+	 * zs_unregister_migration().
 	 */
+	smp_mb__after_atomic();
 	if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
 		wake_up_all(&pool->migration_wait);
 }
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index d2e6885479cb1..cb94ac9886181 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -690,6 +690,12 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 		   ntohl(ogm_packet->seqno), ogm_throughput, ogm_packet->ttl,
 		   ogm_packet->version, ntohs(ogm_packet->tvlv_len));
 
+	if (batadv_is_my_mac(bat_priv, ogm_packet->orig)) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: originator packet from ourself\n");
+		return;
+	}
+
 	/* If the troughput metric is 0, immediately drop the packet. No need to
 	 * create orig_node / neigh_node for an unusable route.
 	 */
@@ -788,11 +794,6 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		return NET_RX_DROP;
 
-	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
-
-	if (batadv_is_my_mac(bat_priv, ogm_packet->orig))
-		return NET_RX_DROP;
-
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_RX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_RX_BYTES,
 			   skb->len + ETH_HLEN);
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 516c45771d59b..a087f559f93e5 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1569,10 +1569,14 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 		return 0;
 
 	bat_priv->bla.claim_hash = batadv_hash_new(128);
-	bat_priv->bla.backbone_hash = batadv_hash_new(32);
+	if (!bat_priv->bla.claim_hash)
+		return -ENOMEM;
 
-	if (!bat_priv->bla.claim_hash || !bat_priv->bla.backbone_hash)
+	bat_priv->bla.backbone_hash = batadv_hash_new(32);
+	if (!bat_priv->bla.backbone_hash) {
+		batadv_hash_destroy(bat_priv->bla.claim_hash);
 		return -ENOMEM;
+	}
 
 	batadv_hash_set_lock_class(bat_priv->bla.claim_hash,
 				   &batadv_claim_hash_lock_class_key);
@@ -1589,13 +1593,16 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_check_bcast_duplist - Check if a frame is in the broadcast dup.
+ * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the soft interface information
- * @skb: contains the bcast_packet to be checked
+ * @skb: contains the multicast packet to be checked
+ * @payload_ptr: pointer to position inside the head buffer of the skb
+ *  marking the start of the data to be CRC'ed
+ * @orig: originator mac address, NULL if unknown
  *
- * check if it is on our broadcast list. Another gateway might
- * have sent the same packet because it is connected to the same backbone,
- * so we have to remove this duplicate.
+ * Check if it is on our broadcast list. Another gateway might have sent the
+ * same packet because it is connected to the same backbone, so we have to
+ * remove this duplicate.
  *
  * This is performed by checking the CRC, which will tell us
  * with a good chance that it is the same packet. If it is furthermore
@@ -1604,19 +1611,17 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
  *
  * Return: true if a packet is in the duplicate list, false otherwise.
  */
-bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
-				    struct sk_buff *skb)
+static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb, u8 *payload_ptr,
+				     const u8 *orig)
 {
-	int i, curr;
-	__be32 crc;
-	struct batadv_bcast_packet *bcast_packet;
 	struct batadv_bcast_duplist_entry *entry;
 	bool ret = false;
-
-	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+	int i, curr;
+	__be32 crc;
 
 	/* calculate the crc ... */
-	crc = batadv_skb_crc32(skb, (u8 *)(bcast_packet + 1));
+	crc = batadv_skb_crc32(skb, payload_ptr);
 
 	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1635,8 +1640,21 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 		if (entry->crc != crc)
 			continue;
 
-		if (batadv_compare_eth(entry->orig, bcast_packet->orig))
-			continue;
+		/* are the originators both known and not anonymous? */
+		if (orig && !is_zero_ether_addr(orig) &&
+		    !is_zero_ether_addr(entry->orig)) {
+			/* If known, check if the new frame came from
+			 * the same originator:
+			 * We are safe to take identical frames from the
+			 * same orig, if known, as multiplications in
+			 * the mesh are detected via the (orig, seqno) pair.
+			 * So we can be a bit more liberal here and allow
+			 * identical frames from the same orig which the source
+			 * host might have sent multiple times on purpose.
+			 */
+			if (batadv_compare_eth(entry->orig, orig))
+				continue;
+		}
 
 		/* this entry seems to match: same crc, not too old,
 		 * and from another gw. therefore return true to forbid it.
@@ -1652,7 +1670,14 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	entry = &bat_priv->bla.bcast_duplist[curr];
 	entry->crc = crc;
 	entry->entrytime = jiffies;
-	ether_addr_copy(entry->orig, bcast_packet->orig);
+
+	/* known originator */
+	if (orig)
+		ether_addr_copy(entry->orig, orig);
+	/* anonymous originator */
+	else
+		eth_zero_addr(entry->orig);
+
 	bat_priv->bla.bcast_duplist_curr = curr;
 
 out:
@@ -1661,6 +1686,48 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	return ret;
 }
 
+/**
+ * batadv_bla_check_ucast_duplist() - Check if a frame is in the broadcast dup.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: contains the multicast packet to be checked, decapsulated from a
+ *  unicast_packet
+ *
+ * Check if it is on our broadcast list. Another gateway might have sent the
+ * same packet because it is connected to the same backbone, so we have to
+ * remove this duplicate.
+ *
+ * Return: true if a packet is in the duplicate list, false otherwise.
+ */
+static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
+					   struct sk_buff *skb)
+{
+	return batadv_bla_check_duplist(bat_priv, skb, (u8 *)skb->data, NULL);
+}
+
+/**
+ * batadv_bla_check_bcast_duplist() - Check if a frame is in the broadcast dup.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: contains the bcast_packet to be checked
+ *
+ * Check if it is on our broadcast list. Another gateway might have sent the
+ * same packet because it is connected to the same backbone, so we have to
+ * remove this duplicate.
+ *
+ * Return: true if a packet is in the duplicate list, false otherwise.
+ */
+bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb)
+{
+	struct batadv_bcast_packet *bcast_packet;
+	u8 *payload_ptr;
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+	payload_ptr = (u8 *)(bcast_packet + 1);
+
+	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
+					bcast_packet->orig);
+}
+
 /**
  * batadv_bla_is_backbone_gw_orig - Check if the originator is a gateway for
  *  the VLAN identified by vid.
@@ -1875,6 +1942,14 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			    packet_type == BATADV_UNICAST)
 				goto handled;
 
+	/* potential duplicates from foreign BLA backbone gateways via
+	 * multicast-in-unicast packets
+	 */
+	if (is_multicast_ether_addr(ethhdr->h_dest) &&
+	    packet_type == BATADV_UNICAST &&
+	    batadv_bla_check_ucast_duplist(bat_priv, skb))
+		goto handled;
+
 	ether_addr_copy(search_claim.addr, ethhdr->h_source);
 	search_claim.vid = vid;
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index fef21f75892e4..343f4fc5909d7 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -394,9 +394,10 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 
 /**
  * batadv_frag_create - create a fragment from skb
+ * @net_dev: outgoing device for fragment
  * @skb: skb to create fragment from
  * @frag_head: header to use in new fragment
- * @mtu: size of new fragment
+ * @fragment_size: size of new fragment
  *
  * Split the passed skb into two fragments: A new one with size matching the
  * passed mtu and the old one with the rest. The new skb contains data from the
@@ -404,22 +405,25 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
  *
  * Return: the new fragment, NULL on error.
  */
-static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
+static struct sk_buff *batadv_frag_create(struct net_device *net_dev,
+					  struct sk_buff *skb,
 					  struct batadv_frag_packet *frag_head,
-					  unsigned int mtu)
+					  unsigned int fragment_size)
 {
+	unsigned int ll_reserved = LL_RESERVED_SPACE(net_dev);
+	unsigned int tailroom = net_dev->needed_tailroom;
 	struct sk_buff *skb_fragment;
 	unsigned int header_size = sizeof(*frag_head);
-	unsigned int fragment_size = mtu - header_size;
+	unsigned int mtu = fragment_size + header_size;
 
-	skb_fragment = netdev_alloc_skb(NULL, mtu + ETH_HLEN);
+	skb_fragment = dev_alloc_skb(ll_reserved + mtu + tailroom);
 	if (!skb_fragment)
 		goto err;
 
 	skb_fragment->priority = skb->priority;
 
 	/* Eat the last mtu-bytes of the skb */
-	skb_reserve(skb_fragment, header_size + ETH_HLEN);
+	skb_reserve(skb_fragment, ll_reserved + header_size);
 	skb_split(skb, skb_fragment, skb->len - fragment_size);
 
 	/* Add the header */
@@ -443,13 +447,14 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
 			    struct batadv_neigh_node *neigh_node)
 {
+	struct net_device *net_dev = neigh_node->if_incoming->net_dev;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_frag_packet frag_header;
 	struct sk_buff *skb_fragment;
-	unsigned int mtu = neigh_node->if_incoming->net_dev->mtu;
+	unsigned int mtu = net_dev->mtu;
 	unsigned int header_size = sizeof(frag_header);
-	unsigned int max_fragment_size, max_packet_size;
+	unsigned int max_fragment_size, num_fragments;
 	int ret = -1;
 
 	/* To avoid merge and refragmentation at next-hops we never send
@@ -457,10 +462,15 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	 */
 	mtu = min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	max_fragment_size = mtu - header_size;
-	max_packet_size = max_fragment_size * BATADV_FRAG_MAX_FRAGMENTS;
+
+	if (skb->len == 0 || max_fragment_size == 0)
+		return -EINVAL;
+
+	num_fragments = (skb->len - 1) / max_fragment_size + 1;
+	max_fragment_size = (skb->len - 1) / num_fragments + 1;
 
 	/* Don't even try to fragment, if we need more than 16 fragments */
-	if (skb->len > max_packet_size)
+	if (num_fragments > BATADV_FRAG_MAX_FRAGMENTS)
 		goto out;
 
 	bat_priv = orig_node->bat_priv;
@@ -498,7 +508,8 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 			goto out;
 		}
 
-		skb_fragment = batadv_frag_create(skb, &frag_header, mtu);
+		skb_fragment = batadv_frag_create(net_dev, skb, &frag_header,
+						  max_fragment_size);
 		if (!skb_fragment)
 			goto out;
 
@@ -517,11 +528,14 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 		frag_header.no++;
 	}
 
-	/* Make room for the fragment header. */
-	if (batadv_skb_head_push(skb, header_size) < 0 ||
-	    pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOMIC) < 0)
+	/* make sure that there is at least enough head for the fragmentation
+	 * and ethernet headers
+	 */
+	ret = skb_cow_head(skb, ETH_HLEN + header_size);
+	if (ret < 0)
 		goto out;
 
+	skb_push(skb, header_size);
 	memcpy(skb->data, &frag_header, header_size);
 
 	/* Send the last fragment */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f528761674df9..4f384abb4cedd 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -359,6 +359,9 @@ static void batadv_hardif_recalc_extra_skbroom(struct net_device *soft_iface)
 	needed_headroom = lower_headroom + (lower_header_len - ETH_HLEN);
 	needed_headroom += batadv_max_header_len();
 
+	/* fragmentation headers don't strip the unicast/... header */
+	needed_headroom += sizeof(struct batadv_frag_packet);
+
 	soft_iface->needed_headroom = needed_headroom;
 	soft_iface->needed_tailroom = lower_tailroom;
 }
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 2c017ab47557b..96b6ab9681cd9 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -177,29 +177,41 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_HLIST_HEAD(&bat_priv->softif_vlan_list);
 	INIT_HLIST_HEAD(&bat_priv->tp_list);
 
-	ret = batadv_v_mesh_init(bat_priv);
-	if (ret < 0)
-		goto err;
-
 	ret = batadv_originator_init(bat_priv);
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		goto err_orig;
+	}
 
 	ret = batadv_tt_init(bat_priv);
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		goto err_tt;
+	}
+
+	ret = batadv_v_mesh_init(bat_priv);
+	if (ret < 0) {
+		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		goto err_v;
+	}
 
 	ret = batadv_bla_init(bat_priv);
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		goto err_bla;
+	}
 
 	ret = batadv_dat_init(bat_priv);
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		goto err_dat;
+	}
 
 	ret = batadv_nc_mesh_init(bat_priv);
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
+		goto err_nc;
+	}
 
 	batadv_gw_init(bat_priv);
 	batadv_mcast_init(bat_priv);
@@ -209,8 +221,20 @@ int batadv_mesh_init(struct net_device *soft_iface)
 
 	return 0;
 
-err:
-	batadv_mesh_free(soft_iface);
+err_nc:
+	batadv_dat_free(bat_priv);
+err_dat:
+	batadv_bla_free(bat_priv);
+err_bla:
+	batadv_v_mesh_free(bat_priv);
+err_v:
+	batadv_tt_free(bat_priv);
+err_tt:
+	batadv_originator_free(bat_priv);
+err_orig:
+	batadv_purge_outstanding_packets(bat_priv, NULL);
+	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
+
 	return ret;
 }
 
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 5a2aac17805ba..283ac3fb94293 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -53,10 +53,12 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
 #include "packet.h"
+#include "send.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -1251,6 +1253,35 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt.commit_lock);
 }
 
+/**
+ * batadv_mcast_forw_send_orig() - send a multicast packet to an originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to send
+ * @vid: the vlan identifier
+ * @orig_node: the originator to send the packet to
+ *
+ * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
+ */
+int batadv_mcast_forw_send_orig(struct batadv_priv *bat_priv,
+				struct sk_buff *skb,
+				unsigned short vid,
+				struct batadv_orig_node *orig_node)
+{
+	/* Avoid sending multicast-in-unicast packets to other BLA
+	 * gateways - they already got the frame from the LAN side
+	 * we share with them.
+	 * TODO: Refactor to take BLA into account earlier, to avoid
+	 * reducing the mcast_fanout count.
+	 */
+	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig, vid)) {
+		dev_kfree_skb(skb);
+		return NET_XMIT_SUCCESS;
+	}
+
+	return batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0,
+				       orig_node, vid);
+}
+
 /**
  * batadv_mcast_purge_orig - reset originator global mcast state modifications
  * @orig: the originator which is going to get purged
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 1fb00ba84907a..751f547561643 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -45,6 +45,11 @@ enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       struct batadv_orig_node **mcast_single_orig);
 
+int batadv_mcast_forw_send_orig(struct batadv_priv *bat_priv,
+				struct sk_buff *skb,
+				unsigned short vid,
+				struct batadv_orig_node *orig_node);
+
 void batadv_mcast_init(struct batadv_priv *bat_priv);
 
 int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset);
@@ -71,6 +76,16 @@ static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+static inline int
+batadv_mcast_forw_send_orig(struct batadv_priv *bat_priv,
+			    struct sk_buff *skb,
+			    unsigned short vid,
+			    struct batadv_orig_node *orig_node)
+{
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
+}
+
 static inline void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
 }
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 09549885cd147..b0a85bd72afca 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -166,8 +166,10 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 				   &batadv_nc_coding_hash_lock_class_key);
 
 	bat_priv->nc.decoding_hash = batadv_hash_new(128);
-	if (!bat_priv->nc.decoding_hash)
+	if (!bat_priv->nc.decoding_hash) {
+		batadv_hash_destroy(bat_priv->nc.coding_hash);
 		goto err;
+	}
 
 	batadv_hash_set_lock_class(bat_priv->nc.decoding_hash,
 				   &batadv_nc_decoding_hash_lock_class_key);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index af0a8439cf08a..4805c98588dc1 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -356,9 +356,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 				goto dropped;
 			ret = batadv_send_skb_via_gw(bat_priv, skb, vid);
 		} else if (mcast_single_orig) {
-			ret = batadv_send_skb_unicast(bat_priv, skb,
-						      BATADV_UNICAST, 0,
-						      mcast_single_orig, vid);
+			ret = batadv_mcast_forw_send_orig(bat_priv, skb, vid,
+							  mcast_single_orig);
 		} else {
 			if (batadv_dat_snoop_outgoing_arp_request(bat_priv,
 								  skb))
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 607d8bac83760..6e9844e73bac3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4373,8 +4373,10 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
 		return ret;
 
 	ret = batadv_tt_global_init(bat_priv);
-	if (ret < 0)
+	if (ret < 0) {
+		batadv_tt_local_table_free(bat_priv);
 		return ret;
+	}
 
 	batadv_tvlv_handler_register(bat_priv, batadv_tt_tvlv_ogm_handler_v1,
 				     batadv_tt_tvlv_unicast_handler_v1,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f46f59129bf39..a47430d843dcf 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1319,6 +1319,9 @@ static void l2cap_sock_close_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return;
+
 	l2cap_sock_kill(sk);
 }
 
@@ -1327,6 +1330,9 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
 	struct sock *sk = chan->data;
 	struct sock *parent;
 
+	if (!sk)
+		return;
+
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
 	/* This callback can be called both for server (BT_LISTEN)
@@ -1510,8 +1516,10 @@ static void l2cap_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
-	if (l2cap_pi(sk)->chan)
+	if (l2cap_pi(sk)->chan) {
+		l2cap_pi(sk)->chan->data = NULL;
 		l2cap_chan_put(l2cap_pi(sk)->chan);
+	}
 
 	if (l2cap_pi(sk)->rx_busy_skb) {
 		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 77f88c7df6053..b3b4ffaa394f6 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -254,7 +254,8 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 	return err;
 }
 
-static int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
+static int sco_send_frame(struct sock *sk, void *buf, int len,
+			  unsigned int msg_flags)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -266,15 +267,11 @@ static int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 
 	BT_DBG("sk %p len %d", sk, len);
 
-	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = bt_skb_send_alloc(sk, len, msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		return err;
 
-	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
-		kfree_skb(skb);
-		return -EFAULT;
-	}
-
+	memcpy(skb_put(skb, len), buf, len);
 	hci_send_sco(conn->hcon, skb);
 
 	return len;
@@ -693,6 +690,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
 	struct sock *sk = sock->sk;
+	void *buf;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -704,14 +702,24 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (memcpy_from_msg(buf, msg, len)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = sco_send_frame(sk, msg, len);
+		err = sco_send_frame(sk, buf, len, msg->msg_flags);
 	else
 		err = -ENOTCONN;
 
 	release_sock(sk);
+	kfree(buf);
 	return err;
 }
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 4f831225d34f4..ca8757090ae35 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1298,7 +1298,7 @@ static size_t br_get_linkxstats_size(const struct net_device *dev, int attr)
 	}
 
 	return numvls * nla_total_size(sizeof(struct bridge_vlan_xstats)) +
-	       nla_total_size(sizeof(struct br_mcast_stats)) +
+	       nla_total_size_64bit(sizeof(struct br_mcast_stats)) +
 	       nla_total_size(0);
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 911752e8a3e64..012143f313a87 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3900,7 +3900,7 @@ static int rtnl_fill_statsinfo(struct sk_buff *skb, struct net_device *dev,
 static size_t if_nlmsg_stats_size(const struct net_device *dev,
 				  u32 filter_mask)
 {
-	size_t size = 0;
+	size_t size = NLMSG_ALIGN(sizeof(struct if_stats_msg));
 
 	if (stats_attr_valid(filter_mask, IFLA_STATS_LINK_64, 0))
 		size += nla_total_size_64bit(sizeof(struct rtnl_link_stats64));
diff --git a/net/core/stream.c b/net/core/stream.c
index 6e41b20bf9f86..05b63feac7e57 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -193,9 +193,6 @@ void sk_stream_kill_queues(struct sock *sk)
 	/* First the read buffer. */
 	__skb_queue_purge(&sk->sk_receive_queue);
 
-	/* Next, the error queue. */
-	__skb_queue_purge(&sk->sk_error_queue);
-
 	/* Next, the write queue. */
 	WARN_ON(!skb_queue_empty(&sk->sk_write_queue));
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b4318c1b5b960..f62e177267c34 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -368,7 +368,7 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0600,
 		.proc_handler	= proc_dolongvec_minmax_bpf_restricted,
 		.extra1		= &long_one,
-		.extra2		= &long_max,
+		.extra2		= &bpf_jit_limit_max,
 	},
 #endif
 	{
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 579fda1bc45df..ce54e66b47a03 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -290,6 +290,7 @@ ip6t_do_table(struct sk_buff *skb,
 	 * things we don't know, ie. tcp syn flag or ports).  If the
 	 * rule is also a fragment-specific rule, non-fragments won't
 	 * match it. */
+	acpar.fragoff = 0;
 	acpar.hotdrop = false;
 	acpar.net     = state->net;
 	acpar.in      = state->in;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f1d4558bc0edd..96b2333496b53 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3692,7 +3692,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		if (!bssid)
 			return false;
 		if (ether_addr_equal(sdata->vif.addr, hdr->addr2) ||
-		    ether_addr_equal(sdata->u.ibss.bssid, hdr->addr2))
+		    ether_addr_equal(sdata->u.ibss.bssid, hdr->addr2) ||
+		    !is_valid_ether_addr(hdr->addr2))
 			return false;
 		if (ieee80211_is_beacon(hdr->frame_control))
 			return true;
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index e8d56d9a4df2c..dacd2d34a790b 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -71,7 +71,7 @@ config NF_CONNTRACK_MARK
 config NF_CONNTRACK_SECMARK
 	bool  'Connection tracking security mark support'
 	depends on NETWORK_SECMARK
-	default m if NETFILTER_ADVANCED=n
+	default y if NETFILTER_ADVANCED=n
 	help
 	  This option enables security markings to be applied to
 	  connections.  Typically they are copied to connections from
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 4e08305a55c48..3ee198b3bfe28 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -3987,6 +3987,11 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	tbl[idx++].data = &ipvs->sysctl_conn_reuse_mode;
 	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
 	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
+#ifdef CONFIG_IP_VS_DEBUG
+	/* Global sysctls must be ro in non-init netns */
+	if (!net_eq(net, &init_net))
+		tbl[idx++].mode = 0444;
+#endif
 
 	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl);
 	if (ipvs->sysctl_hdr == NULL) {
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 2a811b5634d46..a35510565d4d1 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -539,7 +539,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 		goto nla_put_failure;
 
 	if (indev && entskb->dev &&
-	    entskb->mac_header != entskb->network_header) {
+	    skb_mac_header_was_set(entskb)) {
 		struct nfqnl_msg_packet_hw phw;
 		int len;
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 453b0efdc0d71..1b70de5898c42 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -574,7 +574,10 @@ static int netlink_insert(struct sock *sk, u32 portid)
 
 	/* We need to ensure that the socket is hashed and visible. */
 	smp_wmb();
-	nlk_sk(sk)->bound = portid;
+	/* Paired with lockless reads from netlink_bind(),
+	 * netlink_connect() and netlink_sendmsg().
+	 */
+	WRITE_ONCE(nlk_sk(sk)->bound, portid);
 
 err:
 	release_sock(sk);
@@ -993,7 +996,8 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 	else if (nlk->ngroups < 8*sizeof(groups))
 		groups &= (1UL << nlk->ngroups) - 1;
 
-	bound = nlk->bound;
+	/* Paired with WRITE_ONCE() in netlink_insert() */
+	bound = READ_ONCE(nlk->bound);
 	if (bound) {
 		/* Ensure nlk->portid is up-to-date. */
 		smp_rmb();
@@ -1073,8 +1077,9 @@ static int netlink_connect(struct socket *sock, struct sockaddr *addr,
 
 	/* No need for barriers here as we return to user-space without
 	 * using any of the bound attributes.
+	 * Paired with WRITE_ONCE() in netlink_insert().
 	 */
-	if (!nlk->bound)
+	if (!READ_ONCE(nlk->bound))
 		err = netlink_autobind(sock);
 
 	if (err == 0) {
@@ -1821,7 +1826,8 @@ static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		dst_group = nlk->dst_group;
 	}
 
-	if (!nlk->bound) {
+	/* Paired with WRITE_ONCE() in netlink_insert() */
+	if (!READ_ONCE(nlk->bound)) {
 		err = netlink_autobind(sock);
 		if (err)
 			goto out;
diff --git a/net/nfc/af_nfc.c b/net/nfc/af_nfc.c
index 54e40fa478226..1859b8e98ded2 100644
--- a/net/nfc/af_nfc.c
+++ b/net/nfc/af_nfc.c
@@ -72,6 +72,9 @@ int nfc_proto_register(const struct nfc_protocol *nfc_proto)
 		proto_tab[nfc_proto->id] = nfc_proto;
 	write_unlock(&proto_tab_lock);
 
+	if (rc)
+		proto_unregister(nfc_proto->proto);
+
 	return rc;
 }
 EXPORT_SYMBOL(nfc_proto_register);
diff --git a/net/nfc/core.c b/net/nfc/core.c
index c699d64a0753a..32a2dfc08f480 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -106,13 +106,13 @@ int nfc_dev_up(struct nfc_dev *dev)
 
 	device_lock(&dev->dev);
 
-	if (dev->rfkill && rfkill_blocked(dev->rfkill)) {
-		rc = -ERFKILL;
+	if (!device_is_registered(&dev->dev)) {
+		rc = -ENODEV;
 		goto error;
 	}
 
-	if (!device_is_registered(&dev->dev)) {
-		rc = -ENODEV;
+	if (dev->rfkill && rfkill_blocked(dev->rfkill)) {
+		rc = -ERFKILL;
 		goto error;
 	}
 
@@ -1133,11 +1133,7 @@ int nfc_register_device(struct nfc_dev *dev)
 	if (rc)
 		pr_err("Could not register llcp device\n");
 
-	rc = nfc_genl_device_added(dev);
-	if (rc)
-		pr_debug("The userspace won't be notified that the device %s was added\n",
-			 dev_name(&dev->dev));
-
+	device_lock(&dev->dev);
 	dev->rfkill = rfkill_alloc(dev_name(&dev->dev), &dev->dev,
 				   RFKILL_TYPE_NFC, &nfc_rfkill_ops, dev);
 	if (dev->rfkill) {
@@ -1146,6 +1142,12 @@ int nfc_register_device(struct nfc_dev *dev)
 			dev->rfkill = NULL;
 		}
 	}
+	device_unlock(&dev->dev);
+
+	rc = nfc_genl_device_added(dev);
+	if (rc)
+		pr_debug("The userspace won't be notified that the device %s was added\n",
+			 dev_name(&dev->dev));
 
 	return 0;
 }
@@ -1162,10 +1164,17 @@ void nfc_unregister_device(struct nfc_dev *dev)
 
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
+	rc = nfc_genl_device_removed(dev);
+	if (rc)
+		pr_debug("The userspace won't be notified that the device %s "
+			 "was removed\n", dev_name(&dev->dev));
+
+	device_lock(&dev->dev);
 	if (dev->rfkill) {
 		rfkill_unregister(dev->rfkill);
 		rfkill_destroy(dev->rfkill);
 	}
+	device_unlock(&dev->dev);
 
 	if (dev->ops->check_presence) {
 		device_lock(&dev->dev);
@@ -1175,11 +1184,6 @@ void nfc_unregister_device(struct nfc_dev *dev)
 		cancel_work_sync(&dev->check_pres_work);
 	}
 
-	rc = nfc_genl_device_removed(dev);
-	if (rc)
-		pr_debug("The userspace won't be notified that the device %s "
-			 "was removed\n", dev_name(&dev->dev));
-
 	nfc_llcp_unregister_device(dev);
 
 	mutex_lock(&nfc_devlist_mutex);
diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 0fd5518bf2522..8d083037f05bf 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -286,6 +286,7 @@ int digital_tg_configure_hw(struct nfc_digital_dev *ddev, int type, int param)
 static int digital_tg_listen_mdaa(struct nfc_digital_dev *ddev, u8 rf_tech)
 {
 	struct digital_tg_mdaa_params *params;
+	int rc;
 
 	params = kzalloc(sizeof(struct digital_tg_mdaa_params), GFP_KERNEL);
 	if (!params)
@@ -300,8 +301,12 @@ static int digital_tg_listen_mdaa(struct nfc_digital_dev *ddev, u8 rf_tech)
 	get_random_bytes(params->nfcid2 + 2, NFC_NFCID2_MAXSIZE - 2);
 	params->sc = DIGITAL_SENSF_FELICA_SC;
 
-	return digital_send_cmd(ddev, DIGITAL_CMD_TG_LISTEN_MDAA, NULL, params,
-				500, digital_tg_recv_atr_req, NULL);
+	rc = digital_send_cmd(ddev, DIGITAL_CMD_TG_LISTEN_MDAA, NULL, params,
+			      500, digital_tg_recv_atr_req, NULL);
+	if (rc)
+		kfree(params);
+
+	return rc;
 }
 
 static int digital_tg_listen_md(struct nfc_digital_dev *ddev, u8 rf_tech)
diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index d9080dec5d278..76622b3678fbb 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -473,8 +473,12 @@ static int digital_in_send_sdd_req(struct nfc_digital_dev *ddev,
 	*skb_put(skb, sizeof(u8)) = sel_cmd;
 	*skb_put(skb, sizeof(u8)) = DIGITAL_SDD_REQ_SEL_PAR;
 
-	return digital_in_send_cmd(ddev, skb, 30, digital_in_recv_sdd_res,
-				   target);
+	rc = digital_in_send_cmd(ddev, skb, 30, digital_in_recv_sdd_res,
+				 target);
+	if (rc)
+		kfree_skb(skb);
+
+	return rc;
 }
 
 static void digital_in_recv_sens_res(struct nfc_digital_dev *ddev, void *arg,
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index bff6ba84d3979..19518a231e571 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -157,12 +157,15 @@ inline int nci_request(struct nci_dev *ndev,
 {
 	int rc;
 
-	if (!test_bit(NCI_UP, &ndev->flags))
-		return -ENETDOWN;
-
 	/* Serialize all requests */
 	mutex_lock(&ndev->req_lock);
-	rc = __nci_request(ndev, req, opt, timeout);
+	/* check the state after obtaing the lock against any races
+	 * from nci_close_device when the device gets removed.
+	 */
+	if (test_bit(NCI_UP, &ndev->flags))
+		rc = __nci_request(ndev, req, opt, timeout);
+	else
+		rc = -ENETDOWN;
 	mutex_unlock(&ndev->req_lock);
 
 	return rc;
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index e3bbf1937d0e9..7681f89dc312b 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -289,6 +289,8 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 							 ndev->cur_conn_id);
 		if (conn_info) {
 			list_del(&conn_info->list);
+			if (conn_info == ndev->rf_conn_info)
+				ndev->rf_conn_info = NULL;
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
 	}
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index 1e37247656f80..8b7110cbcce4c 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -151,6 +151,9 @@ int fifo_set_limit(struct Qdisc *q, unsigned int limit)
 	if (strncmp(q->ops->id + 1, "fifo", 4) != 0)
 		return 0;
 
+	if (!q->ops->change)
+		return 0;
+
 	nla = kmalloc(nla_attr_size(sizeof(struct tc_fifo_qopt)), GFP_KERNEL);
 	if (nla) {
 		nla->nla_type = RTM_NEWQDISC;
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 9045f6bcb34c4..f71991520ad69 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4333,6 +4333,9 @@ sctp_disposition_t sctp_sf_violation(struct net *net,
 {
 	struct sctp_chunk *chunk = arg;
 
+	if (!sctp_vtag_verify(chunk, asoc))
+		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+
 	/* Make sure that the chunk has a valid length. */
 	if (!sctp_chunk_length_valid(chunk, sizeof(sctp_chunkhdr_t)))
 		return sctp_sf_violation_chunklen(net, ep, asoc, type, arg,
@@ -6018,6 +6021,7 @@ static struct sctp_packet *sctp_ootb_pkt_new(struct net *net,
 		 * yet.
 		 */
 		switch (chunk->chunk_hdr->type) {
+		case SCTP_CID_INIT:
 		case SCTP_CID_INIT_ACK:
 		{
 			sctp_initack_chunk_t *initack;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2fecdfe49bae3..95470d628d34b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1173,6 +1173,8 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 		 * non-blocking call.
 		 */
 		err = -EALREADY;
+		if (flags & O_NONBLOCK)
+			goto out;
 		break;
 	default:
 		if ((sk->sk_state == VSOCK_SS_LISTEN) ||
diff --git a/net/wireless/util.c b/net/wireless/util.c
index a16e805c4857f..71f9c14174b55 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1035,6 +1035,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 
 		switch (otype) {
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
 			cfg80211_stop_ap(rdev, dev, true);
 			break;
 		case NL80211_IFTYPE_ADHOC:
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 7f9060f435cde..da6de5e78e1dd 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -83,7 +83,7 @@ static int __init kretprobe_init(void)
 	ret = register_kretprobe(&my_kretprobe);
 	if (ret < 0) {
 		pr_err("register_kretprobe failed, returned %d\n", ret);
-		return -1;
+		return ret;
 	}
 	pr_info("Planted return probe at %s: %p\n",
 			my_kretprobe.kp.symbol_name, my_kretprobe.kp.addr);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 976b8dce64966..0138932ef34de 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -54,7 +54,7 @@ char *evm_config_xattrnames[] = {
 	NULL
 };
 
-static int evm_fixmode;
+static int evm_fixmode __ro_after_init;
 static int __init evm_set_fixmode(char *str)
 {
 	if (strncmp(str, "fix", 3) == 0)
diff --git a/security/security.c b/security/security.c
index 112df16be770d..9a13d72a64465 100644
--- a/security/security.c
+++ b/security/security.c
@@ -131,25 +131,25 @@ int __init security_module_enable(const char *module)
 
 /* Security operations */
 
-int security_binder_set_context_mgr(struct task_struct *mgr)
+int security_binder_set_context_mgr(const struct cred *mgr)
 {
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
-int security_binder_transaction(struct task_struct *from,
-				struct task_struct *to)
+int security_binder_transaction(const struct cred *from,
+				const struct cred *to)
 {
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-int security_binder_transfer_binder(struct task_struct *from,
-				    struct task_struct *to)
+int security_binder_transfer_binder(const struct cred *from,
+				    const struct cred *to)
 {
 	return call_int_hook(binder_transfer_binder, 0, from, to);
 }
 
-int security_binder_transfer_file(struct task_struct *from,
-				  struct task_struct *to, struct file *file)
+int security_binder_transfer_file(const struct cred *from,
+				  const struct cred *to, struct file *file)
 {
 	return call_int_hook(binder_transfer_file, 0, from, to, file);
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a2b63a6a33c7e..607c7fc4f24d3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2065,21 +2065,18 @@ static inline u32 open_file_to_av(struct file *file)
 
 /* Hook functions begin here. */
 
-static int selinux_binder_set_context_mgr(struct task_struct *mgr)
+static int selinux_binder_set_context_mgr(const struct cred *mgr)
 {
-	u32 mysid = current_sid();
-	u32 mgrsid = task_sid(mgr);
-
-	return avc_has_perm(mysid, mgrsid, SECCLASS_BINDER,
+	return avc_has_perm(current_sid(), cred_sid(mgr), SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
 }
 
-static int selinux_binder_transaction(struct task_struct *from,
-				      struct task_struct *to)
+static int selinux_binder_transaction(const struct cred *from,
+				      const struct cred *to)
 {
 	u32 mysid = current_sid();
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
+	u32 fromsid = cred_sid(from);
+	u32 tosid = cred_sid(to);
 	int rc;
 
 	if (mysid != fromsid) {
@@ -2093,21 +2090,19 @@ static int selinux_binder_transaction(struct task_struct *from,
 			    NULL);
 }
 
-static int selinux_binder_transfer_binder(struct task_struct *from,
-					  struct task_struct *to)
+static int selinux_binder_transfer_binder(const struct cred *from,
+					  const struct cred *to)
 {
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
-
-	return avc_has_perm(fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
+	return avc_has_perm(cred_sid(from), cred_sid(to),
+			    SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
 }
 
-static int selinux_binder_transfer_file(struct task_struct *from,
-					struct task_struct *to,
+static int selinux_binder_transfer_file(const struct cred *from,
+					const struct cred *to,
 					struct file *file)
 {
-	u32 sid = task_sid(to);
+	u32 sid = cred_sid(to);
 	struct file_security_struct *fsec = file->f_security;
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 966d30bf2e388..ed5b89fbbd96f 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -716,9 +716,7 @@ static void smk_cipso_doi(void)
 		printk(KERN_WARNING "%s:%d remove rc = %d\n",
 		       __func__, __LINE__, rc);
 
-	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL);
-	if (doip == NULL)
-		panic("smack:  Failed to initialize cipso DOI.\n");
+	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
 	doip->map.std = NULL;
 	doip->doi = smk_cipso_doi_value;
 	doip->type = CIPSO_V4_MAP_PASS;
@@ -737,7 +735,7 @@ static void smk_cipso_doi(void)
 	if (rc != 0) {
 		printk(KERN_WARNING "%s:%d map add rc = %d\n",
 		       __func__, __LINE__, rc);
-		kfree(doip);
+		netlbl_cfg_cipsov4_del(doip->doi, &nai);
 		return;
 	}
 }
@@ -854,6 +852,7 @@ static int smk_open_cipso(struct inode *inode, struct file *file)
 static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos, int format)
 {
+	struct netlbl_lsm_catmap *old_cat;
 	struct smack_known *skp;
 	struct netlbl_lsm_secattr ncats;
 	char mapcatset[SMK_CIPSOLEN];
@@ -943,9 +942,11 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 
 	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
 	if (rc >= 0) {
-		netlbl_catmap_free(skp->smk_netlabel.attr.mls.cat);
+		old_cat = skp->smk_netlabel.attr.mls.cat;
 		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
+		synchronize_rcu();
+		netlbl_catmap_free(old_cat);
 		rc = count;
 	}
 
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 2ff9c12d664a8..1845db338d0f6 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -145,11 +145,13 @@ static int snd_mixer_oss_devmask(struct snd_mixer_oss_file *fmixer)
 
 	if (mixer == NULL)
 		return -EIO;
+	mutex_lock(&mixer->reg_mutex);
 	for (chn = 0; chn < 31; chn++) {
 		pslot = &mixer->slots[chn];
 		if (pslot->put_volume || pslot->put_recsrc)
 			result |= 1 << chn;
 	}
+	mutex_unlock(&mixer->reg_mutex);
 	return result;
 }
 
@@ -161,11 +163,13 @@ static int snd_mixer_oss_stereodevs(struct snd_mixer_oss_file *fmixer)
 
 	if (mixer == NULL)
 		return -EIO;
+	mutex_lock(&mixer->reg_mutex);
 	for (chn = 0; chn < 31; chn++) {
 		pslot = &mixer->slots[chn];
 		if (pslot->put_volume && pslot->stereo)
 			result |= 1 << chn;
 	}
+	mutex_unlock(&mixer->reg_mutex);
 	return result;
 }
 
@@ -176,6 +180,7 @@ static int snd_mixer_oss_recmask(struct snd_mixer_oss_file *fmixer)
 
 	if (mixer == NULL)
 		return -EIO;
+	mutex_lock(&mixer->reg_mutex);
 	if (mixer->put_recsrc && mixer->get_recsrc) {	/* exclusive */
 		result = mixer->mask_recsrc;
 	} else {
@@ -187,6 +192,7 @@ static int snd_mixer_oss_recmask(struct snd_mixer_oss_file *fmixer)
 				result |= 1 << chn;
 		}
 	}
+	mutex_unlock(&mixer->reg_mutex);
 	return result;
 }
 
@@ -197,11 +203,12 @@ static int snd_mixer_oss_get_recsrc(struct snd_mixer_oss_file *fmixer)
 
 	if (mixer == NULL)
 		return -EIO;
+	mutex_lock(&mixer->reg_mutex);
 	if (mixer->put_recsrc && mixer->get_recsrc) {	/* exclusive */
-		int err;
 		unsigned int index;
-		if ((err = mixer->get_recsrc(fmixer, &index)) < 0)
-			return err;
+		result = mixer->get_recsrc(fmixer, &index);
+		if (result < 0)
+			goto unlock;
 		result = 1 << index;
 	} else {
 		struct snd_mixer_oss_slot *pslot;
@@ -216,7 +223,10 @@ static int snd_mixer_oss_get_recsrc(struct snd_mixer_oss_file *fmixer)
 			}
 		}
 	}
-	return mixer->oss_recsrc = result;
+	mixer->oss_recsrc = result;
+ unlock:
+	mutex_unlock(&mixer->reg_mutex);
+	return result;
 }
 
 static int snd_mixer_oss_set_recsrc(struct snd_mixer_oss_file *fmixer, int recsrc)
@@ -229,6 +239,7 @@ static int snd_mixer_oss_set_recsrc(struct snd_mixer_oss_file *fmixer, int recsr
 
 	if (mixer == NULL)
 		return -EIO;
+	mutex_lock(&mixer->reg_mutex);
 	if (mixer->get_recsrc && mixer->put_recsrc) {	/* exclusive input */
 		if (recsrc & ~mixer->oss_recsrc)
 			recsrc &= ~mixer->oss_recsrc;
@@ -254,6 +265,7 @@ static int snd_mixer_oss_set_recsrc(struct snd_mixer_oss_file *fmixer, int recsr
 			}
 		}
 	}
+	mutex_unlock(&mixer->reg_mutex);
 	return result;
 }
 
@@ -265,6 +277,7 @@ static int snd_mixer_oss_get_volume(struct snd_mixer_oss_file *fmixer, int slot)
 
 	if (mixer == NULL || slot > 30)
 		return -EIO;
+	mutex_lock(&mixer->reg_mutex);
 	pslot = &mixer->slots[slot];
 	left = pslot->volume[0];
 	right = pslot->volume[1];
@@ -272,15 +285,21 @@ static int snd_mixer_oss_get_volume(struct snd_mixer_oss_file *fmixer, int slot)
 		result = pslot->get_volume(fmixer, pslot, &left, &right);
 	if (!pslot->stereo)
 		right = left;
-	if (snd_BUG_ON(left < 0 || left > 100))
-		return -EIO;
-	if (snd_BUG_ON(right < 0 || right > 100))
-		return -EIO;
+	if (snd_BUG_ON(left < 0 || left > 100)) {
+		result = -EIO;
+		goto unlock;
+	}
+	if (snd_BUG_ON(right < 0 || right > 100)) {
+		result = -EIO;
+		goto unlock;
+	}
 	if (result >= 0) {
 		pslot->volume[0] = left;
 		pslot->volume[1] = right;
 	 	result = (left & 0xff) | ((right & 0xff) << 8);
 	}
+ unlock:
+	mutex_unlock(&mixer->reg_mutex);
 	return result;
 }
 
@@ -293,6 +312,7 @@ static int snd_mixer_oss_set_volume(struct snd_mixer_oss_file *fmixer,
 
 	if (mixer == NULL || slot > 30)
 		return -EIO;
+	mutex_lock(&mixer->reg_mutex);
 	pslot = &mixer->slots[slot];
 	if (left > 100)
 		left = 100;
@@ -303,10 +323,13 @@ static int snd_mixer_oss_set_volume(struct snd_mixer_oss_file *fmixer,
 	if (pslot->put_volume)
 		result = pslot->put_volume(fmixer, pslot, left, right);
 	if (result < 0)
-		return result;
+		goto unlock;
 	pslot->volume[0] = left;
 	pslot->volume[1] = right;
- 	return (left & 0xff) | ((right & 0xff) << 8);
+	result = (left & 0xff) | ((right & 0xff) << 8);
+ unlock:
+	mutex_unlock(&mixer->reg_mutex);
+	return result;
 }
 
 static int snd_mixer_oss_ioctl1(struct snd_mixer_oss_file *fmixer, unsigned int cmd, unsigned long arg)
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index e40a2cba5002a..5d16b20791195 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -162,6 +162,8 @@ static int snd_seq_device_dev_free(struct snd_device *device)
 	struct snd_seq_device *dev = device->device_data;
 
 	cancel_autoload_drivers();
+	if (dev->private_free)
+		dev->private_free(dev);
 	put_device(&dev->dev);
 	return 0;
 }
@@ -189,11 +191,7 @@ static int snd_seq_device_dev_disconnect(struct snd_device *device)
 
 static void snd_seq_dev_release(struct device *dev)
 {
-	struct snd_seq_device *sdev = to_seq_dev(dev);
-
-	if (sdev->private_free)
-		sdev->private_free(sdev);
-	kfree(sdev);
+	kfree(to_seq_dev(dev));
 }
 
 /*
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6475b85599364..596ba572d6c49 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -581,13 +581,13 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 	if (!timer)
 		return -EINVAL;
 	spin_lock_irqsave(&timer->lock, flags);
+	list_del_init(&timeri->ack_list);
+	list_del_init(&timeri->active_list);
 	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
 			       SNDRV_TIMER_IFLG_START))) {
 		result = -EBUSY;
 		goto unlock;
 	}
-	list_del_init(&timeri->ack_list);
-	list_del_init(&timeri->active_list);
 	if (timer->card && timer->card->shutdown)
 		goto unlock;
 	if (stop) {
@@ -622,23 +622,22 @@ static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool stop)
 {
 	unsigned long flags;
+	bool running;
 
 	spin_lock_irqsave(&slave_active_lock, flags);
-	if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
-		spin_unlock_irqrestore(&slave_active_lock, flags);
-		return -EBUSY;
-	}
+	running = timeri->flags & SNDRV_TIMER_IFLG_RUNNING;
 	timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
 	if (timeri->timer) {
 		spin_lock(&timeri->timer->lock);
 		list_del_init(&timeri->ack_list);
 		list_del_init(&timeri->active_list);
-		snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
-				  SNDRV_TIMER_EVENT_PAUSE);
+		if (running)
+			snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+					  SNDRV_TIMER_EVENT_PAUSE);
 		spin_unlock(&timeri->timer->lock);
 	}
 	spin_unlock_irqrestore(&slave_active_lock, flags);
-	return 0;
+	return running ? 0 : -EBUSY;
 }
 
 /*
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 00c6af2ae1c29..f0e112906c687 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -389,8 +389,9 @@ static int azx_reset(struct hdac_bus *bus, bool full_reset)
 	if (!full_reset)
 		goto skip_reset;
 
-	/* clear STATESTS */
-	snd_hdac_chip_writew(bus, STATESTS, STATESTS_INT_MASK);
+	/* clear STATESTS if not in reset */
+	if (snd_hdac_chip_readb(bus, GCTL) & AZX_GCTL_RESET)
+		snd_hdac_chip_writew(bus, STATESTS, STATESTS_INT_MASK);
 
 	/* reset controller */
 	snd_hdac_bus_enter_link_reset(bus);
diff --git a/sound/isa/gus/gus_dma.c b/sound/isa/gus/gus_dma.c
index 36c27c8323601..2e27cd3427c87 100644
--- a/sound/isa/gus/gus_dma.c
+++ b/sound/isa/gus/gus_dma.c
@@ -141,6 +141,8 @@ static void snd_gf1_dma_interrupt(struct snd_gus_card * gus)
 	}
 	block = snd_gf1_dma_next_block(gus);
 	spin_unlock(&gus->dma_lock);
+	if (!block)
+		return;
 	snd_gf1_dma_program(gus, block->addr, block->buf_addr, block->count, (unsigned short) block->cmd);
 	kfree(block);
 #if 0
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 11edb6f6bdafe..21b0368c2a3bc 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2406,10 +2406,16 @@ static struct snd_soc_dapm_widget *dapm_find_widget(
 	return NULL;
 }
 
-static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
-				const char *pin, int status)
+/*
+ * set the DAPM pin status:
+ * returns 1 when the value has been updated, 0 when unchanged, or a negative
+ * error code; called from kcontrol put callback
+ */
+static int __snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
+				  const char *pin, int status)
 {
 	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
+	int ret = 0;
 
 	dapm_assert_locked(dapm);
 
@@ -2422,13 +2428,26 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 		dapm_mark_dirty(w, "pin configuration");
 		dapm_widget_invalidate_input_paths(w);
 		dapm_widget_invalidate_output_paths(w);
+		ret = 1;
 	}
 
 	w->connected = status;
 	if (status == 0)
 		w->force = 0;
 
-	return 0;
+	return ret;
+}
+
+/*
+ * similar as __snd_soc_dapm_set_pin(), but returns 0 when successful;
+ * called from several API functions below
+ */
+static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
+				const char *pin, int status)
+{
+	int ret = __snd_soc_dapm_set_pin(dapm, pin, status);
+
+	return ret < 0 ? ret : 0;
 }
 
 /**
@@ -3323,14 +3342,15 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
+	int ret;
 
-	if (ucontrol->value.integer.value[0])
-		snd_soc_dapm_enable_pin(&card->dapm, pin);
-	else
-		snd_soc_dapm_disable_pin(&card->dapm, pin);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	ret = __snd_soc_dapm_set_pin(&card->dapm, pin,
+				     !!ucontrol->value.integer.value[0]);
+	mutex_unlock(&card->dapm_mutex);
 
 	snd_soc_dapm_sync(&card->dapm);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
@@ -3706,7 +3726,7 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 
 	w->params_select = ucontrol->value.enumerated.item[0];
 
-	return 0;
+	return 1;
 }
 
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 9312cd8a6fdd1..c5c6d360843aa 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -101,7 +101,7 @@ int snd_emux_register(struct snd_emux *emu, struct snd_card *card, int index, ch
 	emu->name = kstrdup(name, GFP_KERNEL);
 	emu->voices = kcalloc(emu->max_voices, sizeof(struct snd_emux_voice),
 			      GFP_KERNEL);
-	if (emu->voices == NULL)
+	if (emu->name == NULL || emu->voices == NULL)
 		return -ENOMEM;
 
 	/* create soundfont list */
diff --git a/sound/usb/6fire/comm.c b/sound/usb/6fire/comm.c
index 161215d78d952..f29c115b9d564 100644
--- a/sound/usb/6fire/comm.c
+++ b/sound/usb/6fire/comm.c
@@ -99,7 +99,7 @@ static int usb6fire_comm_send_buffer(u8 *buffer, struct usb_device *dev)
 	int actual_len;
 
 	ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, COMM_EP),
-			buffer, buffer[1] + 2, &actual_len, HZ);
+			buffer, buffer[1] + 2, &actual_len, 1000);
 	if (ret < 0)
 		return ret;
 	else if (actual_len != buffer[1] + 2)
diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
index 9520b4cd70385..7a89111041edc 100644
--- a/sound/usb/6fire/firmware.c
+++ b/sound/usb/6fire/firmware.c
@@ -166,7 +166,7 @@ static int usb6fire_fw_ezusb_write(struct usb_device *device,
 
 	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0), type,
 			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			value, 0, data, len, HZ);
+			value, 0, data, len, 1000);
 	if (ret < 0)
 		return ret;
 	else if (ret != len)
@@ -179,7 +179,7 @@ static int usb6fire_fw_ezusb_read(struct usb_device *device,
 {
 	int ret = usb_control_msg(device, usb_rcvctrlpipe(device, 0), type,
 			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE, value,
-			0, data, len, HZ);
+			0, data, len, 1000);
 	if (ret < 0)
 		return ret;
 	else if (ret != len)
@@ -194,7 +194,7 @@ static int usb6fire_fw_fpga_write(struct usb_device *device,
 	int ret;
 
 	ret = usb_bulk_msg(device, usb_sndbulkpipe(device, FPGA_EP), data, len,
-			&actual_len, HZ);
+			&actual_len, 1000);
 	if (ret < 0)
 		return ret;
 	else if (actual_len != len)
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 0107bbfeb17d1..8cca0befcf013 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -110,12 +110,12 @@ static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
 			retval = usb_interrupt_msg(line6->usbdev,
 						usb_sndintpipe(line6->usbdev, properties->ep_ctrl_w),
 						(char *)frag_buf, frag_size,
-						&partial, LINE6_TIMEOUT * HZ);
+						&partial, LINE6_TIMEOUT);
 		} else {
 			retval = usb_bulk_msg(line6->usbdev,
 						usb_sndbulkpipe(line6->usbdev, properties->ep_ctrl_w),
 						(char *)frag_buf, frag_size,
-						&partial, LINE6_TIMEOUT * HZ);
+						&partial, LINE6_TIMEOUT);
 		}
 
 		if (retval) {
@@ -351,7 +351,7 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 			      (datalen << 8) | 0x21, address,
-			      NULL, 0, LINE6_TIMEOUT * HZ);
+			      NULL, 0, LINE6_TIMEOUT);
 
 	if (ret < 0) {
 		dev_err(line6->ifcdev, "read request failed (error %d)\n", ret);
@@ -366,7 +366,7 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
 				      USB_DIR_IN,
 				      0x0012, 0x0000, len, 1,
-				      LINE6_TIMEOUT * HZ);
+				      LINE6_TIMEOUT);
 		if (ret < 0) {
 			dev_err(line6->ifcdev,
 				"receive length failed (error %d)\n", ret);
@@ -394,7 +394,7 @@ int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
 	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
 			      0x0013, 0x0000, data, datalen,
-			      LINE6_TIMEOUT * HZ);
+			      LINE6_TIMEOUT);
 
 	if (ret < 0)
 		dev_err(line6->ifcdev, "read failed (error %d)\n", ret);
@@ -426,7 +426,7 @@ int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 			      0x0022, address, data, datalen,
-			      LINE6_TIMEOUT * HZ);
+			      LINE6_TIMEOUT);
 
 	if (ret < 0) {
 		dev_err(line6->ifcdev,
@@ -442,7 +442,7 @@ int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 				      USB_TYPE_VENDOR | USB_RECIP_DEVICE |
 				      USB_DIR_IN,
 				      0x0012, 0x0000,
-				      status, 1, LINE6_TIMEOUT * HZ);
+				      status, 1, LINE6_TIMEOUT);
 
 		if (ret < 0) {
 			dev_err(line6->ifcdev,
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 7e3a3aada2220..395f4e2c570a3 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -31,7 +31,7 @@
 #define LINE6_FALLBACK_INTERVAL 10
 #define LINE6_FALLBACK_MAXPACKETSIZE 16
 
-#define LINE6_TIMEOUT 1
+#define LINE6_TIMEOUT 1000
 #define LINE6_BUFSIZE_LISTEN 64
 #define LINE6_MIDI_MESSAGE_MAXLEN 256
 
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 8c4375bf34ab7..7133c36f99b6c 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -232,7 +232,7 @@ static int podhd_dev_start(struct usb_line6_podhd *pod)
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0),
 					0x67, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 					0x11, 0,
-					NULL, 0, LINE6_TIMEOUT * HZ);
+					NULL, 0, LINE6_TIMEOUT);
 	if (ret < 0) {
 		dev_err(pod->line6.ifcdev, "read request failed (error %d)\n", ret);
 		goto exit;
@@ -242,7 +242,7 @@ static int podhd_dev_start(struct usb_line6_podhd *pod)
 	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0), 0x67,
 					USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
 					0x11, 0x0,
-					init_bytes, 3, LINE6_TIMEOUT * HZ);
+					init_bytes, 3, LINE6_TIMEOUT);
 	if (ret < 0) {
 		dev_err(pod->line6.ifcdev,
 			"receive length failed (error %d)\n", ret);
@@ -262,7 +262,7 @@ static int podhd_dev_start(struct usb_line6_podhd *pod)
 					USB_REQ_SET_FEATURE,
 					USB_TYPE_STANDARD | USB_RECIP_DEVICE | USB_DIR_OUT,
 					1, 0,
-					NULL, 0, LINE6_TIMEOUT * HZ);
+					NULL, 0, LINE6_TIMEOUT);
 exit:
 	kfree(init_bytes);
 	return ret;
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index d3871d99ade4e..d7336333a7fba 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -133,7 +133,7 @@ static int toneport_send_cmd(struct usb_device *usbdev, int cmd1, int cmd2)
 
 	ret = usb_control_msg(usbdev, usb_sndctrlpipe(usbdev, 0), 0x67,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			      cmd1, cmd2, NULL, 0, LINE6_TIMEOUT * HZ);
+			      cmd1, cmd2, NULL, 0, LINE6_TIMEOUT);
 
 	if (ret < 0) {
 		dev_err(&usbdev->dev, "send failed (error %d)\n", ret);
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index c19a5dd056317..8c00157c0fcb2 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -1032,7 +1032,7 @@ static int detect_usb_format(struct ua101 *ua)
 		fmt_playback->bSubframeSize * ua->playback.channels;
 
 	epd = &ua->intf[INTF_CAPTURE]->altsetting[1].endpoint[0].desc;
-	if (!usb_endpoint_is_isoc_in(epd)) {
+	if (!usb_endpoint_is_isoc_in(epd) || usb_endpoint_maxp(epd) == 0) {
 		dev_err(&ua->dev->dev, "invalid capture endpoint\n");
 		return -ENXIO;
 	}
@@ -1040,7 +1040,7 @@ static int detect_usb_format(struct ua101 *ua)
 	ua->capture.max_packet_bytes = usb_endpoint_maxp(epd);
 
 	epd = &ua->intf[INTF_PLAYBACK]->altsetting[1].endpoint[0].desc;
-	if (!usb_endpoint_is_isoc_out(epd)) {
+	if (!usb_endpoint_is_isoc_out(epd) || usb_endpoint_maxp(epd) == 0) {
 		dev_err(&ua->dev->dev, "invalid playback endpoint\n");
 		return -ENXIO;
 	}
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index d3d3e05fe5b8d..1904fc542025d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3446,5 +3446,37 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
+{
+	/*
+	 * Sennheiser GSP670
+	 * Change order of interfaces loaded
+	 */
+	USB_DEVICE(0x1395, 0x0300),
+	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			// Communication
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			// Recording
+			{
+				.ifnum = 4,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			// Main
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
