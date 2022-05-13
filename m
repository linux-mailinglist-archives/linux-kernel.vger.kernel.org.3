Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044CD526919
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383269AbiEMSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382940AbiEMSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953E9209567;
        Fri, 13 May 2022 11:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C93CB83122;
        Fri, 13 May 2022 18:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A89C34100;
        Fri, 13 May 2022 18:16:44 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.39-rt42
Date:   Fri, 13 May 2022 18:15:20 -0000
Message-ID: <165246572090.247090.15069308471324681317@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.39-rt42 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 6a291da830cbca720bc228d39715943e42d73848

Or to build 5.15.39-rt42 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.39.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.39-rt42.patch.xz


Enjoy!
Clark

Changes from v5.15.36-rt41:
---

Adam Ford (2):
      ARM: dts: am3517-evm: Fix misc pinmuxing
      ARM: dts: logicpd-som-lv: Fix wrong pinmuxing on OMAP35

Adam Wujek (1):
      hwmon: (pmbus) disable PEC if not enabled

Alexey Kardashevskiy (2):
      powerpc/perf: Fix 32bit compile
      powerpc/64: Add UADDR64 relocation support

Andreas Gruenbacher (18):
      gup: Turn fault_in_pages_{readable,writeable} into fault_in_{readable,writeable}
      iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
      iov_iter: Introduce fault_in_iov_iter_writeable
      gfs2: Add wrapper for iomap_file_buffered_write
      gfs2: Clean up function may_grant
      gfs2: Move the inode glock locking to gfs2_file_buffered_write
      gfs2: Eliminate ip->i_gh
      gfs2: Fix mmap + page fault deadlocks for buffered I/O
      iomap: Fix iomap_dio_rw return value for user copies
      iomap: Support partial direct I/O on user copy failures
      iomap: Add done_before argument to iomap_dio_rw
      gup: Introduce FOLL_NOFAULT flag to disable page faults
      iov_iter: Introduce nofault flag to disable page faults
      gfs2: Fix mmap + page fault deadlocks for direct I/O
      gfs2: Prevent endless loops in gfs2_file_buffered_write
      gfs2: Minor retry logic cleanup
      gfs2: Make sure not to return short direct writes
      gfs2: No short reads or writes upon glock contention

Andreas Larsson (2):
      can: grcan: grcan_probe(): fix broken system id check for errata workaround needs
      can: grcan: only use the NAPI poll budget for RX

Andrei Lalaev (1):
      gpiolib: of: fix bounds check for 'gpio-reserved-ranges'

Armin Wolf (1):
      hwmon: (adt7470) Fix warning on module removal

Aya Levin (1):
      net/mlx5: Fix slab-out-of-bounds while reading resource dump menu

Baruch Siach (2):
      net: phy: marvell10g: fix return value on error
      gpio: mvebu: drop pwm base assignment

Bob Peterson (1):
      gfs2: Introduce flag for glock holder auto-demotion

Borislav Petkov (1):
      x86/cpu: Load microcode during restore_processor_state()

Brian Norris (1):
      mmc: core: Set HS clock speed before sending HS CMD13

Bruno Thomsen (1):
      USB: serial: cp210x: add PIDs for Kamstrup USB Meter Reader

Chao Song (1):
      ASoC: Intel: soc-acpi: correct device endpoints for max98373

Cheng Xu (1):
      RDMA/siw: Fix a condition race issue in MPA request processing

Chengfeng Ye (1):
      firewire: fix potential uaf in outbound_phy_packet_callback()

Christian Hewitt (2):
      arm64: dts: meson: remove CPU opps below 1GHz for G12B boards
      arm64: dts: meson: remove CPU opps below 1GHz for SM1 boards

Christophe JAILLET (1):
      bus: sunxi-rsb: Fix the return value of sunxi_rsb_device_create()

Christophe Leroy (1):
      eeprom: at25: Use DMA safe buffers

Chuanhong Guo (1):
      mtd: rawnand: fix ecc parameters for mt7622

Clark Williams (2):
      Merge tag 'v5.15.39' into v5.15-rt
      'Linux 5.15.39-rt42'

Claudiu Beznea (2):
      ARM: dts: at91: sama5d4_xplained: fix pinctrl phandle name
      ARM: dts: at91: fix pinctrl phandles

Codrin Ciubotariu (1):
      ASoC: dmaengine: Restore NULL prepare_slave_config() callback

Damien Le Moal (2):
      zonefs: Fix management of open zones
      zonefs: Clear inode information flags on inode creation

Dan Vacura (1):
      usb: gadget: uvc: Fix crash when encoding data for usb request

Daniel Hellstrom (1):
      can: grcan: use ofdev->dev when allocating DMA memory

Daniel Starke (15):
      tty: n_gsm: fix restart handling via CLD command
      tty: n_gsm: fix decoupled mux resource
      tty: n_gsm: fix mux cleanup after unregister tty device
      tty: n_gsm: fix wrong signal octet encoding in convergence layer type 2
      tty: n_gsm: fix malformed counter for out of frame data
      tty: n_gsm: fix insufficient txframe size
      tty: n_gsm: fix wrong DLCI release order
      tty: n_gsm: fix missing explicit ldisc flush
      tty: n_gsm: fix wrong command retry handling
      tty: n_gsm: fix wrong command frame length field encoding
      tty: n_gsm: fix wrong signal octets encoding in MSC
      tty: n_gsm: fix missing tty wakeup in convergence layer type 2
      tty: n_gsm: fix reset fifo race condition
      tty: n_gsm: fix incorrect UA handling
      tty: n_gsm: fix software flow control handling

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1057, 0x1058, 0x1075 compositions

Dany Madden (1):
      Revert "ibmvnic: Add ethtool private flag for driver-defined queue limits"

David Howells (1):
      rxrpc: Enable IPv6 checksums on transport socket

David Stevens (1):
      iommu/vt-d: Calculate mask for non-aligned flushes

David Yat Sin (1):
      drm/amdkfd: Fix GWS queue count

Dinh Nguyen (3):
      spi: cadence-quadspi: fix write completion support
      ARM: dts: socfpga: change qspi to "intel,socfpga-qspi"
      net: ethernet: stmmac: fix write to sgmii_adapter_base

Dmitry Baryshkov (1):
      cpufreq: qcom-hw: fix the race between LMH worker and cpuhp

Duoming Zhou (6):
      arch: xtensa: platforms: Fix deadlock in rs_close()
      drivers: net: hippi: Fix deadlock in rr_close()
      can: grcan: grcan_close(): fix deadlock
      nfc: replace improper check device_is_registered() in netlink related functions
      nfc: nfcmrvl: main: reorder destructive operations in nfcmrvl_nci_unregister_dev to avoid bugs
      NFC: netlink: fix sleep in atomic bug when firmware download timeout

Eric Dumazet (4):
      tcp: fix potential xmit stalls caused by TCP_NOTSENT_LOWAT
      tcp: make sure treq->af_specific is initialized
      net: igmp: respect RCU rules in ip_mc_source() and ip_mc_msfilter()
      mld: respect RCU rules in ip6_mc_source() and ip6_mc_msfilter()

Eugen Hristev (1):
      ARM: dts: at91: sama7g5ek: enable pull-up on flexcom3 console lines

Evan Green (1):
      xhci: Enable runtime PM on second Alderlake controller

Eyal Birger (1):
      bpf, lwt: Fix crash when using bpf_skb_set_tunnel_key() from bpf_xmit lwt hook

Fabio Estevam (2):
      ARM: dts: imx6qdl-apalis: Fix sgtl5000 detection issue
      arm64: dts: imx8mn-ddr4-evk: Describe the 32.768 kHz PMIC clock

Fawzi Khaber (1):
      iio: imu: inv_icm42600: Fix I2C init possible nack

Filipe Manana (5):
      btrfs: fix deadlock due to page faults during direct IO reads and writes
      btrfs: fallback to blocking mode when doing async dio over multiple extents
      btrfs: fix leaked plug after failure syncing log on zoned filesystems
      btrfs: do not BUG_ON() on failure to update inode when setting xattr
      btrfs: always log symlinks in full mode

Florian Westphal (1):
      netfilter: nft_socket: only do sk lookups when indev is available

Francesco Ruggeri (1):
      tcp: md5: incorrect tcp_header_len for incoming connections

Frederic Weisbecker (2):
      rcu: Fix callbacks processing time limit retaining cond_resched()
      rcu: Apply callbacks processing time limit only on softirq

Geert Uytterhoeven (1):
      memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode

Greg Kroah-Hartman (3):
      Linux 5.15.37
      Linux 5.15.38
      Linux 5.15.39

Guillaume Giraudon (1):
      arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin labeling for CON1

Guo Ren (1):
      riscv: patch_text: Fixup last cpu should be master

H. Nikolaus Schaller (1):
      ARM: dts: Fix mmc order for omap3-gta04

Hangyu Hua (1):
      usb: misc: fix improper handling of refcount in uss720_probe()

Hao Luo (9):
      bpf: Introduce composable reg, ret and arg types.
      bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
      bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
      bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL
      bpf: Introduce MEM_RDONLY flag
      bpf: Convert PTR_TO_MEM_OR_NULL to composable types.
      bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
      bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.
      bpf/selftests: Test PTR_TO_RDONLY_MEM

Harry Wentland (1):
      drm/amd/display: Avoid reading audio pattern past AUDIO_CHANNELS_COUNT

Hector Martin (1):
      iommu/dart: Add missing module owner to ops structure

Heikki Krogerus (3):
      usb: typec: ucsi: Fix reuse of completion structure
      usb: typec: ucsi: Fix role swapping
      usb: dwc3: pci: add support for the Intel Meteor Lake-P

Heiner Kallweit (1):
      phy: amlogic: fix error path in phy_g12a_usb3_pcie_probe()

Helge Deller (2):
      parisc: Merge model and model name into one line in /proc/cpuinfo
      Revert "parisc: Mark sched_clock unstable only if clocks are not syncronized"

Henry Lin (1):
      xhci: stop polling roothubs after shutdown

Ido Schimmel (1):
      selftests: mirror_gre_bridge_1q: Avoid changing PVID while interface is operational

Imre Deak (1):
      drm/i915: Fix SEL_FETCH_PLANE_*(PIPE_B+) register addresses

Jakob Koschel (1):
      firewire: remove check of list iterator against head past the loop body

Jan Höppner (2):
      s390/dasd: Fix read for ESE with blksize < 4k
      s390/dasd: Fix read inconsistency for ESE DASD devices

Jann Horn (1):
      selftests/seccomp: Don't call read() on TTY from background pgrp

Javier Martinez Canillas (1):
      fbdev: Make fb_release() return -ENODEV if fbdev was unregistered

Jens Axboe (2):
      io_uring: check reserved fields for send/sendmsg
      io_uring: check reserved fields for recv/recvmsg

Jian Shen (3):
      net: hns3: clear inited state and stop client after failed to register netdev
      net: hns3: add validity check for message data length
      net: hns3: add return value for mailbox handling in PF

Jie Wang (1):
      net: hns3: modify the return code of hclge_get_ring_chain_from_mbx

Johan Hovold (2):
      serial: imx: fix overrun interrupts in DMA mode
      arm64: dts: imx8mm-venice: fix spi2 pin configuration

Jonathan Lemon (1):
      net: bcmgenet: hide status block before TX timestamping

Jouni Högander (1):
      drm/i915: Check EDID for HDR static metadata when choosing blc

Kai-Heng Feng (1):
      drm/amdgpu: Ensure HDA function is suspended before ASIC reset

Kees Cook (2):
      USB: serial: whiteheat: fix heap overflow in WHITEHEAT_GET_DTR_RTS
      thermal: int340x: Fix attr.show callback prototype

Krzysztof Kozlowski (2):
      pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config
      phy: samsung: exynos5250-sata: fix missing device put in probe error paths

Kumar Kartikeya Dwivedi (2):
      bpf: Fix crash due to out of bounds access into reg2btf_ids.
      selftests/bpf: Add test for reg2btf_ids out of bounds access

Kuogee Hsieh (1):
      drm/msm/dp: remove fail safe mode related code

Kurt Kanzenbach (1):
      timekeeping: Mark NMI safe time accessors as notrace

Kyle Huey (1):
      KVM: x86/svm: Account for family 17h event renumberings in amd_pmc_perf_hw_id

Leon Romanovsky (1):
      ixgbe: ensure IPsec VF<->PF compatibility

Lino Sanfilippo (1):
      serial: amba-pl011: do not time out prematurely when draining tx fifo

Linus Torvalds (1):
      mm: gup: make fault_in_safe_writeable() use fixup_user_fault()

Liu Ying (1):
      arm64: dts: imx8qm: Correct SCU clock controller's compatible property

Lu Baolu (1):
      iommu/vt-d: Drop stop marker messages

Luca Ceresoli (1):
      pinctrl: rockchip: fix RK3308 pinmux bits

Lv Ruyi (1):
      pinctrl: pistachio: fix use of irq_of_parse_and_map()

Maciej Fijalkowski (1):
      xsk: Fix l2fwd for copy mode + busy poll combo

Maciej W. Rozycki (3):
      serial: 8250: Also set sticky MCR bits in console restoration
      serial: 8250: Correct the clock for EndRun PTP/1588 PCIe device
      MIPS: Fix CP0 counter erratum detection for R4k CPUs

Macpaul Lin (1):
      usb: mtu3: fix USB 3.0 dual-role-switch from device to host

Manish Chopra (1):
      bnx2x: fix napi API usage sequence

Manivannan Sadhasivam (2):
      bus: mhi: host: pci_generic: Add missing poweroff() PM callback
      bus: mhi: host: pci_generic: Flush recovery worker during freeze

Marc Kleine-Budde (2):
      selftests/net: so_txtime: fix parsing of start time stamp on 32 bit systems
      selftests/net: so_txtime: usage(): fix documentation of default clock

Marek Behún (5):
      PCI: aardvark: Make MSI irq_chip structures static driver structures
      PCI: aardvark: Make msi_domain_info structure a static driver structure
      PCI: aardvark: Use dev_fwnode() instead of of_node_to_fwnode(dev->of_node)
      PCI: aardvark: Drop __maybe_unused from advk_pcie_disable_phy()
      PCI: aardvark: Update comment about link going down after link-up

Marek Marczykowski-Górecki (1):
      drm/amdgpu: do not use passthrough mode in Xen dom0

Marek Vasut (3):
      arm64: dts: imx8mn: Fix SAI nodes
      pinctrl: stm32: Do not call stm32_gpio_get() for edge triggered IRQs in EOI
      pinctrl: stm32: Keep pinctrl block clock enabled when LEVEL IRQ requested

Mario Limonciello (2):
      drm/amdgpu: explicitly check for s0ix when evicting resources
      drm/amdgpu: don't set s3 and s0ix at the same time

Mark Brown (6):
      ARM: dts: at91: Map MCLK for wm8731 on at91sam9g20ek
      ASoC: da7219: Fix change notifications for tone generator frequency
      ASoC: wm8958: Fix change notifications for DSP controls
      ASoC: meson: Fix event generation for AUI ACODEC mux
      ASoC: meson: Fix event generation for G12A tohdmi mux
      ASoC: meson: Fix event generation for AUI CODEC mux

Mark Zhang (1):
      net/mlx5e: Fix the calling of update_buffer_lossy() API

Martin Blumenstingl (1):
      net: dsa: lantiq_gswip: Don't set GSWIP_MII_CFG_RMII_CLK

Martin Willi (1):
      netfilter: Update ip6_route_me_harder to consider L3 domain

Mathias Nyman (1):
      xhci: increase usb U3 -> U0 link resume timeout from 100ms to 500ms

Max Krummenacher (1):
      ARM: dts: imx6ull-colibri: fix vqmmc regulator

Maxim Mikityanskiy (1):
      tls: Skip tls_append_frag on zero copy size

Md Sadre Alam (1):
      mtd: rawnand: qcom: fix memory corruption that causes panic

Miaoqian Lin (8):
      phy: samsung: Fix missing of_node_put() in exynos_sata_phy_probe
      ARM: OMAP2+: Fix refcount leak in omap_gic_of_init
      phy: ti: omap-usb2: Fix error handling in omap_usb2_enable_clocks
      phy: mapphone-mdm6600: Fix PM error handling in phy_mdm6600_probe
      phy: ti: Add missing pm_runtime_disable() in serdes_am654_probe
      mtd: rawnand: Fix return value check of wait_for_completion_timeout
      net: dsa: Add missing of_node_put() in dsa_port_link_register_of
      drm/amd/display: Fix memory leak in dcn21_clock_source_create

Michael Chan (1):
      bnxt_en: Fix unnecessary dropping of RX packets

Michael Hennerich (1):
      iio: dac: ad5446: Fix read_raw not returning set value

Mikulas Patocka (3):
      hex2bin: make the function hex_to_bin constant-time
      hex2bin: fix access beyond string end
      x86: __memcpy_flushcache: fix wrong alignment if size > 2^32

Moshe Shemesh (2):
      net/mlx5: Avoid double clear or set of sync reset requested
      net/mlx5: Fix deadlock in sync reset flow

Moshe Tal (1):
      net/mlx5e: Fix trust state reset in reload

Muchun Song (1):
      mm: kfence: fix objcgs vector allocation

Mustafa Ismail (1):
      RDMA/irdma: Fix possible crash due to NULL netdev in notifier

Namhyung Kim (3):
      perf symbol: Pass is_kallsyms to symbols__fixup_end()
      perf symbol: Update symbols__fixup_end()
      perf symbol: Remove arch__symbols__fixup_end()

Namjae Jeon (2):
      ksmbd: increment reference count of parent fp
      ksmbd: set fixed sector size to FS_SECTOR_SIZE_INFORMATION

Nathan Rossi (1):
      net: dsa: mv88e6xxx: Fix port_hidden_wait to account for port_base_addr

Nick Kossifidis (1):
      RISC-V: relocate DTB if it's outside memory region

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()

Niels Dossche (2):
      firewire: core: extend card->lock in fw_core_handle_bus_reset
      net: mdio: Fix ENOMEM return value in BCM6368 mux bus controller

Nikolay Aleksandrov (2):
      virtio_net: fix wrong buf address calculation when using xdp
      wireguard: device: check for metadata_dst with skb_valid_dst()

Nirmoy Das (1):
      drm/amdgpu: unify BO evicting method in amdgpu_ttm

Nobuhiro Iwamatsu (1):
      gpio: visconti: Fix fwnode of GPIO IRQ

Oleksandr Ocheretnyi (1):
      mtd: fix 'part' field data corruption in mtd_info

Olga Kornievskaia (1):
      SUNRPC release the transport of a relocated task with an assigned transport

Oliver Hartkopp (1):
      can: isotp: remove re-binding of bound socket

Oliver Neukum (2):
      USB: quirks: add a Realtek card reader
      USB: quirks: add STRING quirk for VCOM device

Pablo Neira Ayuso (1):
      netfilter: nft_set_rbtree: overlap detection with element re-addition after deletion

Pali Rohár (25):
      PCI: pci-bridge-emul: Add description for class_revision field
      PCI: pci-bridge-emul: Add definitions for missing capabilities registers
      PCI: aardvark: Add support for DEVCAP2, DEVCTL2, LNKCAP2 and LNKCTL2 registers on emulated bridge
      PCI: aardvark: Clear all MSIs at setup
      PCI: aardvark: Comment actions in driver remove method
      PCI: aardvark: Disable bus mastering when unbinding driver
      PCI: aardvark: Mask all interrupts when unbinding driver
      PCI: aardvark: Fix memory leak in driver unbind
      PCI: aardvark: Assert PERST# when unbinding driver
      PCI: aardvark: Disable link training when unbinding driver
      PCI: aardvark: Disable common PHY when unbinding driver
      PCI: aardvark: Replace custom PCIE_CORE_INT_* macros with PCI_INTERRUPT_*
      PCI: aardvark: Rewrite IRQ code to chained IRQ handler
      PCI: aardvark: Check return value of generic_handle_domain_irq() when processing INTx IRQ
      PCI: aardvark: Refactor unmasking summary MSI interrupt
      PCI: aardvark: Add support for masking MSI interrupts
      PCI: aardvark: Fix setting MSI address
      PCI: aardvark: Enable MSI-X support
      PCI: aardvark: Add support for ERR interrupt on emulated bridge
      PCI: aardvark: Optimize writing PCI_EXP_RTCTL_PMEIE and PCI_EXP_RTSTA_PME on emulated bridge
      PCI: aardvark: Add support for PME interrupts
      PCI: aardvark: Fix support for PME requester on emulated bridge
      PCI: aardvark: Use separate INTA interrupt for emulated root bridge
      PCI: aardvark: Remove irq_mask_ack() callback for INTx interrupts
      PCI: aardvark: Don't mask irq when mapping

Paolo Bonzini (3):
      kvm: selftests: do not use bitfields larger than 32-bits for PTEs
      KVM: x86: Do not change ICR on write to APIC_SELF_IPI
      KVM: x86/mmu: avoid NULL-pointer dereference on page freeing bugs

Paul Blakey (1):
      net/mlx5e: CT: Fix queued up restore put() executing after relevant ft release

Pavel Skripkin (1):
      video: fbdev: udlfb: properly check endpoint type

Pawel Laszczak (1):
      usb: cdns3: Fix issue for clear halt endpoint

Peilin Ye (3):
      ip_gre: Make o_seqno start from 0 in native mode
      ip6_gre: Make o_seqno start from 0 in native mode
      ip_gre, ip6_gre: Fix race condition on o_seqno in collect_md mode

Pengcheng Yang (3):
      ipvs: correctly print the memory size of ip_vs_conn_tab
      tcp: ensure to use the most recently sent skb when filling the rate sample
      tcp: fix F-RTO may not work correctly when receiving DSACK

Peter Zijlstra (2):
      objtool: Fix code relocs vs weak symbols
      objtool: Fix type of reloc::addend

Pierre-Louis Bossart (1):
      ASoC: soc-ops: fix error handling

Puyou Lu (1):
      gpio: pca953x: fix irq_stat not updated when irq is disabled (irq_mask not set)

Qiao Ma (1):
      hinic: fix bug of wq out of bound access

Qu Wenruo (1):
      btrfs: force v2 space cache usage for subpage mount

Ricky WU (1):
      mmc: rtsx: add 74 Clocks in power on flow

Ronnie Sahlberg (1):
      cifs: destage any unwritten data to the server before calling copychunk_write

Samuel Holland (2):
      drm/sun4i: Remove obsolete references to PHYS_OFFSET
      mmc: sunxi-mmc: Fix DMA descriptors allocated above 32 bits

Sandipan Das (1):
      kvm: x86/cpuid: Only provide CPUID leaf 0xA if host has architectural PMU

Sean Anderson (1):
      usb: phy: generic: Get the vbus supply

Sergey Shtylyov (1):
      smsc911x: allow using IRQ0

Shaik Sajida Bhanu (1):
      mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC

Shiraz Saleem (1):
      RDMA/irdma: Reduce iWARP QP destroy time

Shravya Kumbham (1):
      net: emaclite: Add error handling for of_address_to_resource()

Sidhartha Kumar (4):
      selftest/vm: verify mmap addr in mremap_test
      selftest/vm: verify remap destination address in mremap_test
      selftest/vm: verify mmap addr in mremap_test
      selftest/vm: verify remap destination address in mremap_test

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/MV32-WB

Somnath Kotur (1):
      bnxt_en: Fix possible bnxt_open() failure caused by wrong RFS flag

Stefan Haberland (2):
      s390/dasd: fix data corruption for ESE devices
      s390/dasd: prevent double format of tracks for ESE devices

Stephen Boyd (1):
      interconnect: qcom: sdx55: Drop IP0 interconnects

Sven Peter (1):
      usb: dwc3: Try usb-role-switch first in dwc3_drd_init

Takashi Sakamoto (1):
      ALSA: fireworks: fix wrong return count shorter than expected by 4 bytes

Tan Tee Min (1):
      net: stmmac: disable Split Header (SPH) for Intel platforms

Tasos Sahanidis (1):
      usb: core: Don't hold the device lock while sleeping in do_proc_control()

Tatyana Nikolova (1):
      RDMA/irdma: Flush iWARP QP if modified to ERR from RTR state

Tejun Heo (1):
      iocost: don't reset the inuse weight of under-weighted debtors

Thinh Nguyen (3):
      usb: dwc3: core: Fix tx/rx threshold settings
      usb: dwc3: core: Only handle soft-reset in DCTL
      usb: dwc3: gadget: Return proper request status

Thomas Gleixner (2):
      x86/pci/xen: Disable PCI/MSI[-X] masking for XEN_HVM guests
      x86/fpu: Prevent FPU state corruption

Thomas Huth (1):
      KVM: selftests: Silence compiler warning in the kvm_page_table_test

Thomas Pfaff (1):
      genirq: Synchronize interrupt thread startup

Tim Harvey (1):
      ARM: dts: imx8mm-venice-gw{71xx,72xx,73xx}: fix OTG controller OC mode

Timothy Hayes (1):
      perf arm-spe: Fix addresses of synthesized SPE events

Tong Zhang (1):
      iio:imu:bmi160: disable regulator in error path

Tony Lindgren (2):
      bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific
      ARM: dts: dra7: Fix suspend warning for vpe powerdomain

Trond Myklebust (2):
      Revert "SUNRPC: attempt AF_LOCAL connect on setup"
      NFSv4: Don't invalidate inode attributes on delegation return

Vijayavardhan Vennapusa (1):
      usb: gadget: configfs: clear deactivation flag in configfs_composite_unbind()

Ville Syrjälä (2):
      Revert "ACPI: processor: idle: fix lockup regression on 32-bit ThinkPad T40"
      ACPI: processor: idle: Avoid falling back to C3 type C-states

Vlad Buslov (4):
      net/mlx5e: Don't match double-vlan packets if cvlan is not set
      net/mlx5e: Lag, Fix use-after-free in fib event handler
      net/mlx5e: Lag, Fix fib_info pointer assignment
      net/mlx5e: Lag, Don't skip fib events on current dst

Vladimir Oltean (1):
      selftests: ocelot: tc_flower_chains: specify conform-exceed action for policer

Vladimir Zapolskiy (2):
      cpufreq: qcom-cpufreq-hw: Fix throttle frequency value on EPSS platforms
      cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts

Volodymyr Mytnyk (1):
      netfilter: conntrack: fix udp offload timeout sysctl

Wang Qing (1):
      arch_topology: Do not set llc_sibling if llc_id is invalid

Wanpeng Li (2):
      x86/kvm: Preserve BSP MSR_KVM_POLL_CONTROL across suspend/resume
      KVM: LAPIC: Enable timer posted-interrupt only when mwait/hlt is advertised

Weitao Wang (1):
      USB: Fix xhci event ring dequeue pointer ERDP update issue

Willy Tarreau (1):
      floppy: disable FDRAWCMD by default

Xiaobing Luo (1):
      cpufreq: fix memory leak in sun50i_cpufreq_nvmem_probe

Xin Long (1):
      sctp: check asoc strreset_chunk in sctp_generate_reconf_event

Xiubo Li (1):
      ceph: fix possible NULL pointer dereference for req->r_session

Yang Yingliang (7):
      clk: sunxi: sun9i-mmc: check return value after calling platform_get_resource()
      net: fec: add missing of_node_put() in fec_enet_init_stop_mode()
      iommu/dart: check return value after calling platform_get_resource()
      net: ethernet: mediatek: add missing of_node_put() in mtk_sgmii_init()
      net: dsa: mt7530: add missing of_node_put() in mt7530_setup()
      net: stmmac: dwmac-sun8i: add missing of_node_put() in sun8i_dwmac_register_mdio_mux()
      net: cpsw: add missing of_node_put() in cpsw_probe_dt()

Ye Bin (1):
      ext4: fix bug_on in start_this_handle during umount filesystem

YueHaibing (1):
      pinctrl: mediatek: moore: Fix build error

Zheyu Ma (2):
      iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on()
      ASoC: wm8731: Disable the regulator when probing fails

Zihao Wang (1):
      ALSA: hda/realtek: Add quirk for Yoga Duet 7 13ITL6 speakers

Zizhuang Deng (1):
      iio: dac: ad5592r: Fix the missing return value.

Zqiang (1):
      kasan: prevent cpu_quarantine corruption when CPU offline and cache shrink occur at same time

liuyacan (1):
      net/smc: sync err code when tcp connection was refused

suresh kumar (1):
      bonding: do not discard lowest hash bit for non layer3+4 hashing

zhangqilong (1):
      usb: xhci: tegra:Fix PM usage reference leak of tegra_xusb_unpowergate_partitions
---
Makefile                                           |   2 +-
 arch/arm/boot/dts/am3517-evm.dts                   |  45 +-
 arch/arm/boot/dts/am3517-som.dtsi                  |   9 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |   8 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |   6 +-
 arch/arm/boot/dts/at91-sama7g5ek.dts               |   2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   6 +
 arch/arm/boot/dts/dra7-l4.dtsi                     |   4 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  10 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi             |   2 +-
 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts   |  15 +
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |  15 +
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  15 -
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +
 arch/arm/boot/dts/socfpga.dtsi                     |   2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   2 +-
 arch/arm/mach-exynos/Kconfig                       |   1 -
 arch/arm/mach-omap2/omap4-common.c                 |   2 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi  |  40 --
 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi  |  40 --
 .../boot/dts/amlogic/meson-sm1-bananapi-m5.dts     |   1 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |  20 -
 .../boot/dts/freescale/imx8mm-venice-gw71xx.dtsi   |   4 +-
 .../boot/dts/freescale/imx8mm-venice-gw72xx.dtsi   |   4 +-
 .../boot/dts/freescale/imx8mm-venice-gw73xx.dtsi   |   4 +-
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts  |   4 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |  10 +-
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |   2 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |   2 +-
 arch/mips/include/asm/timex.h                      |   8 +-
 arch/mips/kernel/time.c                            |  11 +-
 arch/parisc/kernel/processor.c                     |   3 +-
 arch/parisc/kernel/setup.c                         |   2 +
 arch/parisc/kernel/time.c                          |   6 +-
 arch/powerpc/kernel/kvm.c                          |   3 +-
 arch/powerpc/kernel/reloc_64.S                     |  67 ++-
 arch/powerpc/kernel/signal_32.c                    |   4 +-
 arch/powerpc/kernel/signal_64.c                    |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |   2 -
 arch/powerpc/perf/Makefile                         |   4 +-
 arch/powerpc/tools/relocs_check.sh                 |   7 +-
 arch/riscv/kernel/patch.c                          |   2 +-
 arch/riscv/mm/init.c                               |  21 +-
 arch/x86/include/asm/microcode.h                   |   2 +
 arch/x86/kernel/cpu/microcode/core.c               |   6 +-
 arch/x86/kernel/fpu/core.c                         |  67 ++-
 arch/x86/kernel/fpu/signal.c                       |   7 +-
 arch/x86/kernel/kvm.c                              |  13 +
 arch/x86/kvm/cpuid.c                               |   5 +
 arch/x86/kvm/lapic.c                               |  10 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +
 arch/x86/kvm/svm/pmu.c                             |  28 +-
 arch/x86/lib/usercopy_64.c                         |   2 +-
 arch/x86/pci/xen.c                                 |   6 +-
 arch/x86/power/cpu.c                               |  10 +-
 arch/xtensa/platforms/iss/console.c                |   8 -
 block/blk-iocost.c                                 |  12 +-
 drivers/acpi/processor_idle.c                      |   8 +-
 drivers/base/arch_topology.c                       |   2 +-
 drivers/block/Kconfig                              |  16 +
 drivers/block/floppy.c                             |  43 +-
 drivers/bus/mhi/pci_generic.c                      |   2 +
 drivers/bus/sunxi-rsb.c                            |   2 +
 drivers/bus/ti-sysc.c                              |  16 +-
 drivers/clk/sunxi/clk-sun9i-mmc.c                  |   2 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  27 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   4 +-
 drivers/firewire/core-card.c                       |   3 +
 drivers/firewire/core-cdev.c                       |   4 +-
 drivers/firewire/core-topology.c                   |   9 +-
 drivers/firewire/core-transaction.c                |  30 +-
 drivers/firewire/sbp2.c                            |  13 +-
 drivers/gpio/gpio-mvebu.c                          |   7 -
 drivers/gpio/gpio-pca953x.c                        |   4 +-
 drivers/gpio/gpio-visconti.c                       |   7 +-
 drivers/gpio/gpiolib-of.c                          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  23 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  30 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  83 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   1 +
 drivers/gpu/drm/armada/armada_gem.c                |   7 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |  34 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   6 -
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  11 -
 drivers/gpu/drm/msm/dp/dp_panel.h                  |   1 -
 drivers/gpu/drm/sun4i/sun4i_frontend.c             |   3 -
 drivers/hwmon/adt7470.c                            |   4 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |   3 +
 drivers/iio/dac/ad5446.c                           |   2 +-
 drivers/iio/dac/ad5592r-base.c                     |   2 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |  20 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |  15 +-
 drivers/iio/magnetometer/ak8975.c                  |   1 +
 drivers/infiniband/hw/irdma/cm.c                   |  26 +-
 drivers/infiniband/hw/irdma/utils.c                |  21 +-
 drivers/infiniband/hw/irdma/verbs.c                |   4 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |   7 +-
 drivers/interconnect/qcom/sdx55.c                  |  21 -
 drivers/iommu/apple-dart.c                         |  10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   9 +-
 drivers/iommu/intel/iommu.c                        |  27 +-
 drivers/iommu/intel/svm.c                          |   4 +
 drivers/memory/renesas-rpc-if.c                    |  60 ++-
 drivers/misc/eeprom/at25.c                         |  19 +-
 drivers/mmc/core/mmc.c                             |  23 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  29 +-
 drivers/mmc/host/sdhci-msm.c                       |  42 ++
 drivers/mmc/host/sunxi-mmc.c                       |   5 +-
 drivers/mtd/nand/raw/mtk_ecc.c                     |  12 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |  24 +-
 drivers/mtd/nand/raw/sh_flctl.c                    |  14 +-
 drivers/net/bonding/bond_main.c                    |  13 +-
 drivers/net/can/grcan.c                            |  46 +-
 drivers/net/dsa/lantiq_gswip.c                     |   3 -
 drivers/net/dsa/mt7530.c                           |   1 +
 drivers/net/dsa/mv88e6xxx/port_hidden.c            |   5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  13 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   7 +
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   9 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  31 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c    |   7 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 | 129 ++----
 drivers/net/ethernet/ibm/ibmvnic.h                 |   6 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |   3 +-
 drivers/net/ethernet/mediatek/mtk_sgmii.c          |   1 +
 .../ethernet/mellanox/mlx5/core/diag/rsc_dump.c    |  31 +-
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |  10 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  11 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  60 +--
 drivers/net/ethernet/mellanox/mlx5/core/lag_mp.c   |  38 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag_mp.h   |   7 +-
 drivers/net/ethernet/smsc/smsc911x.c               |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   2 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |   5 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |  15 +-
 drivers/net/hippi/rrunner.c                        |   2 +
 drivers/net/mdio/mdio-mux-bcm6368.c                |   2 +-
 drivers/net/phy/marvell10g.c                       |   2 +-
 drivers/net/virtio_net.c                           |  20 +-
 drivers/net/wireguard/device.c                     |   3 +-
 drivers/nfc/nfcmrvl/main.c                         |   2 +-
 drivers/pci/controller/pci-aardvark.c              | 428 +++++++++++++-----
 drivers/pci/pci-bridge-emul.c                      |  49 ++-
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c     |  20 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |   3 +-
 drivers/phy/samsung/phy-exynos5250-sata.c          |  21 +-
 drivers/phy/ti/phy-am654-serdes.c                  |   2 +-
 drivers/phy/ti/phy-omap-usb2.c                     |   2 +-
 drivers/pinctrl/mediatek/Kconfig                   |   1 +
 drivers/pinctrl/pinctrl-pistachio.c                |   6 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  45 +-
 drivers/pinctrl/samsung/Kconfig                    |  11 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  23 +-
 drivers/s390/block/dasd.c                          |  18 +-
 drivers/s390/block/dasd_eckd.c                     |  28 +-
 drivers/s390/block/dasd_int.h                      |  14 +
 drivers/spi/spi-cadence-quadspi.c                  |  24 +-
 .../intel/int340x_thermal/int3400_thermal.c        |   4 +-
 drivers/tty/n_gsm.c                                | 209 ++++-----
 drivers/tty/serial/8250/8250_pci.c                 |   8 +-
 drivers/tty/serial/8250/8250_port.c                |   2 +-
 drivers/tty/serial/amba-pl011.c                    |   9 +-
 drivers/tty/serial/imx.c                           |   2 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   7 +-
 drivers/usb/core/devio.c                           |  14 +-
 drivers/usb/core/quirks.c                          |   6 +
 drivers/usb/dwc3/core.c                            |  11 +-
 drivers/usb/dwc3/drd.c                             |  11 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   8 +
 drivers/usb/dwc3/gadget.c                          |  31 +-
 drivers/usb/gadget/configfs.c                      |   2 +
 drivers/usb/gadget/function/uvc_queue.c            |   2 +
 drivers/usb/host/xhci-hub.c                        |   2 +-
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/usb/host/xhci-ring.c                       |   1 +
 drivers/usb/host/xhci-tegra.c                      |   4 +-
 drivers/usb/host/xhci.c                            |  11 +
 drivers/usb/misc/uss720.c                          |   3 +-
 drivers/usb/mtu3/mtu3_dr.c                         |   6 +-
 drivers/usb/phy/phy-generic.c                      |   7 +
 drivers/usb/serial/cp210x.c                        |   2 +
 drivers/usb/serial/option.c                        |  12 +
 drivers/usb/serial/whiteheat.c                     |   5 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  24 +-
 drivers/video/fbdev/core/fbmem.c                   |   5 +-
 drivers/video/fbdev/udlfb.c                        |  14 +-
 fs/btrfs/disk-io.c                                 |  11 +
 fs/btrfs/file.c                                    | 142 +++++-
 fs/btrfs/inode.c                                   |  28 ++
 fs/btrfs/ioctl.c                                   |   5 +-
 fs/btrfs/tree-log.c                                |  15 +-
 fs/btrfs/xattr.c                                   |   6 +-
 fs/ceph/caps.c                                     |   4 +
 fs/cifs/smb2ops.c                                  |   8 +
 fs/erofs/data.c                                    |   2 +-
 fs/ext4/file.c                                     |   5 +-
 fs/ext4/super.c                                    |  19 +-
 fs/f2fs/file.c                                     |   2 +-
 fs/fuse/file.c                                     |   2 +-
 fs/gfs2/bmap.c                                     |  60 +--
 fs/gfs2/file.c                                     | 249 ++++++++++-
 fs/gfs2/glock.c                                    | 330 ++++++++++----
 fs/gfs2/glock.h                                    |  20 +
 fs/gfs2/incore.h                                   |   4 +-
 fs/io_uring.c                                      |   4 +
 fs/iomap/buffered-io.c                             |   2 +-
 fs/iomap/direct-io.c                               |  29 +-
 fs/ksmbd/smb2pdu.c                                 |  13 +-
 fs/ksmbd/vfs_cache.c                               |   1 +
 fs/nfs/nfs4proc.c                                  |  12 +-
 fs/ntfs/file.c                                     |   2 +-
 fs/ntfs3/file.c                                    |   2 +-
 fs/xfs/xfs_file.c                                  |   6 +-
 fs/zonefs/super.c                                  |  50 ++-
 include/linux/bpf.h                                | 101 ++++-
 include/linux/bpf_verifier.h                       |  18 +
 include/linux/iomap.h                              |  11 +-
 include/linux/kernel.h                             |   2 +-
 include/linux/mm.h                                 |   3 +-
 include/linux/mtd/mtd.h                            |   6 +-
 include/linux/pagemap.h                            |  58 +--
 include/linux/stmmac.h                             |   1 +
 include/linux/uio.h                                |   4 +-
 include/memory/renesas-rpc-if.h                    |   1 +
 include/net/ip6_tunnel.h                           |   2 +-
 include/net/ip_tunnels.h                           |   2 +-
 include/net/tcp.h                                  |   8 +
 kernel/bpf/btf.c                                   |  16 +-
 kernel/bpf/cgroup.c                                |   2 +-
 kernel/bpf/helpers.c                               |  12 +-
 kernel/bpf/map_iter.c                              |   4 +-
 kernel/bpf/ringbuf.c                               |   2 +-
 kernel/bpf/syscall.c                               |   2 +-
 kernel/bpf/verifier.c                              | 488 ++++++++++-----------
 kernel/irq/internals.h                             |   2 +
 kernel/irq/irqdesc.c                               |   2 +
 kernel/irq/manage.c                                |  39 +-
 kernel/rcu/tree.c                                  |  31 +-
 kernel/time/timekeeping.c                          |   4 +-
 kernel/trace/bpf_trace.c                           |  22 +-
 lib/hexdump.c                                      |  41 +-
 lib/iov_iter.c                                     |  98 ++++-
 localversion-rt                                    |   2 +-
 mm/filemap.c                                       |   4 +-
 mm/gup.c                                           | 120 ++++-
 mm/kasan/quarantine.c                              |   7 +
 mm/kfence/core.c                                   |  11 +-
 mm/kfence/kfence.h                                 |   3 +
 net/can/isotp.c                                    |  22 +-
 net/core/bpf_sk_storage.c                          |   2 +-
 net/core/filter.c                                  |  64 +--
 net/core/lwt_bpf.c                                 |   7 +-
 net/core/sock_map.c                                |   2 +-
 net/dsa/port.c                                     |   2 +
 net/ipv4/igmp.c                                    |   9 +-
 net/ipv4/ip_gre.c                                  |  12 +-
 net/ipv4/syncookies.c                              |   8 +-
 net/ipv4/tcp_input.c                               |  15 +-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv4/tcp_output.c                              |   1 +
 net/ipv4/tcp_rate.c                                |  11 +-
 net/ipv6/ip6_gre.c                                 |  16 +-
 net/ipv6/mcast.c                                   |   8 +-
 net/ipv6/netfilter.c                               |  10 +-
 net/ipv6/syncookies.c                              |   3 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |   2 +-
 net/netfilter/nf_conntrack_standalone.c            |   2 +-
 net/netfilter/nft_set_rbtree.c                     |   6 +-
 net/netfilter/nft_socket.c                         |  52 ++-
 net/nfc/core.c                                     |  29 +-
 net/nfc/netlink.c                                  |   4 +-
 net/rxrpc/local_object.c                           |   3 +
 net/sctp/sm_sideeffect.c                           |   4 +
 net/smc/af_smc.c                                   |   2 +
 net/sunrpc/clnt.c                                  |  11 +-
 net/sunrpc/xprtsock.c                              |   3 -
 net/tls/tls_device.c                               |  12 +-
 net/xdp/xsk.c                                      |   2 +-
 sound/firewire/fireworks/fireworks_hwdep.c         |   1 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/da7219.c                          |  14 +-
 sound/soc/codecs/wm8731.c                          |  19 +-
 sound/soc/codecs/wm8958-dsp2.c                     |   8 +-
 sound/soc/intel/common/soc-acpi-intel-tgl-match.c  |   4 +-
 sound/soc/meson/aiu-acodec-ctrl.c                  |   2 +-
 sound/soc/meson/aiu-codec-ctrl.c                   |   2 +-
 sound/soc/meson/g12a-tohdmitx.c                    |   2 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   6 +-
 sound/soc/soc-ops.c                                |   2 +-
 tools/objtool/check.c                              |   8 +-
 tools/objtool/elf.c                                | 189 +++++++-
 tools/objtool/include/objtool/elf.h                |   4 +-
 tools/perf/arch/arm64/util/Build                   |   1 -
 tools/perf/arch/arm64/util/machine.c               |  28 --
 tools/perf/arch/powerpc/util/Build                 |   1 -
 tools/perf/arch/powerpc/util/machine.c             |  25 --
 tools/perf/arch/s390/util/machine.c                |  16 -
 tools/perf/util/arm-spe.c                          |   3 +-
 tools/perf/util/symbol-elf.c                       |   2 +-
 tools/perf/util/symbol.c                           |  37 +-
 tools/perf/util/symbol.h                           |   3 +-
 tools/testing/selftests/bpf/prog_tests/ksyms_btf.c |  14 +
 .../bpf/progs/test_ksyms_btf_write_check.c         |  29 ++
 tools/testing/selftests/bpf/verifier/calls.c       |  19 +
 .../drivers/net/ocelot/tc_flower_chains.sh         |   2 +-
 .../selftests/kvm/include/x86_64/processor.h       |  15 +
 tools/testing/selftests/kvm/kvm_page_table_test.c  |   2 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 192 ++++----
 .../net/forwarding/mirror_gre_bridge_1q.sh         |   3 +
 tools/testing/selftests/net/so_txtime.c            |   4 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  10 +-
 tools/testing/selftests/vm/mremap_test.c           | 136 +++++-
 328 files changed, 4220 insertions(+), 2189 deletions(-)
---
