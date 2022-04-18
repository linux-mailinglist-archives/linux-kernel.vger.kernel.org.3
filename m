Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB7D505FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiDRWtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiDRWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:49:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9DB2BB16;
        Mon, 18 Apr 2022 15:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9289B81125;
        Mon, 18 Apr 2022 22:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A911C385AB;
        Mon, 18 Apr 2022 22:46:49 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.34-rt40
Date:   Mon, 18 Apr 2022 22:45:36 -0000
Message-ID: <165032193629.1779843.4714223615384268434@puck.lan>
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

I'm pleased to announce the 5.15.34-rt40 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 2212a330188a3cf3f0cdcec06031f8ad4507f646

Or to build 5.15.34-rt40 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.34.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.34-rt40.patch.xz


Enjoy!
Clark

Changes from v5.15.32-rt39:
---

Aaron Conole (1):
      openvswitch: always update flow key after nat

Aashish Sharma (1):
      dm crypt: fix get_key_size compiler warning if !CONFIG_KEYS

Abel Vesa (2):
      clk: imx7d: Remove audio_mclk_root_clk
      ARM: dts: imx7: Use audio_mclk_post_div instead audio_mclk_root_clk

Abhishek Sahu (2):
      vfio/pci: fix memory leak during D3hot to D0 transition
      vfio/pci: wake-up devices around reset functions

Adam Wujek (1):
      clk: si5341: fix reported clk_rate when output divider is 2

Adrian Hunter (6):
      scsi: core: sd: Add silence_suspend flag to suppress some PM messages
      scsi: ufs: Fix runtime PM messages never-ending cycle
      perf/core: Fix address filter parser for multiple filters
      perf/x86/intel/pt: Fix address filter config for 32-bit kernel
      perf tools: Fix perf's libperf_print callback
      scsi: ufs: ufs-pci: Add support for Intel MTL

Aharon Landau (3):
      RDMA/mlx5: Fix the flow of a miss in the allocation of a cache ODP MR
      RDMA/mlx5: Don't remove cache MRs when a delay is needed
      RDMA/mlx5: Add a missing update of cache->last_add

Aidan MacDonald (1):
      pinctrl: ingenic: Fix regmap on X series SoCs

Akira Kawata (1):
      fs/binfmt_elf: Fix AT_PHDR for unusual ELF files

Akira Yokosawa (1):
      docs: sphinx/requirements: Limit jinja2<3.1

Alan Stern (1):
      USB: usb-storage: Fix use of bitfields for hardware data in ene_ub6250.c

Alex Deucher (5):
      drm/amdgpu: move PX checking into amdgpu_device_ip_early_init
      drm/amdgpu: only check for _PR3 on dGPUs
      drm/amdkfd: make CRAT table missing message informational only
      drm/amdgpu/smu10: fix SoC/fclk units in auto mode
      drm/amdgpu: don't use BACO for reset in S3

Alex Williamson (1):
      vfio/pci: Stub vfio_pci_vga_rw when !CONFIG_VFIO_PCI_VGA

Alexander Lobakin (9):
      i40e: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
      i40e: respect metadata on XSK Rx to skb
      igc: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
      ixgbe: pass bi->xdp to ixgbe_construct_skb_zc() directly
      ixgbe: don't reserve excessive XDP_PACKET_HEADROOM on XSK Rx to skb
      ixgbe: respect metadata on XSK Rx to skb
      ice: fix 'scheduling while atomic' on aux critical err interrupt
      ice: don't allow to run ice_send_event_to_aux() in atomic ctx
      MIPS: fix fortify panic when copying asm exception handlers

Alexander Usyskin (3):
      mei: me: disable driver on the ign firmware
      mei: me: add Alder Lake N device id.
      mei: avoid iterator usage outside of list_for_each_entry

Alexey Dobriyan (1):
      lib: uninline simple_strntoull() as well

Alexey Khoroshilov (1):
      NFS: remove unneeded check in decode_devicenotify_args()

Ali Pouladi (1):
      rtc: pl031: fix rtc features null pointer dereference

Alistair Delva (1):
      remoteproc: Fix count check in rproc_coredump_write()

Alistair Popple (1):
      mm/pages_alloc.c: don't create ZONE_MOVABLE beyond the end of a node

Amadeusz Sławiński (1):
      ASoC: topology: Allow TLV control to be either read or write

Amir Goldstein (1):
      nfsd: more robust allocation failure handling in nfsd_file_cache_init

Amit Kumar Mahapatra (1):
      mtd: rawnand: pl353: Set the nand chip node as the flash node

Amjad Ouled-Ameur (3):
      phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
      phy: amlogic: meson8b-usb2: Use dev_err_probe()
      phy: amlogic: meson8b-usb2: fix shared reset control use

Ammar Faizi (1):
      ASoC: SOF: Intel: Fix NULL ptr dereference when ENOMEM

Anand Jain (1):
      btrfs: harden identification of a stale device

Anatolii Gerasymenko (2):
      ice: Set txq_teid to ICE_INVAL_TEID on ring creation
      ice: Do not skip not enabled queues in ice_vc_dis_qs_msg

Anders Roxell (3):
      powerpc/lib/sstep: Fix 'sthcx' instruction
      powerpc/lib/sstep: Fix build errors with newer binutils
      powerpc: Fix build errors with newer binutils

Andre Przywara (3):
      ARM: configs: multi_v5_defconfig: re-enable CONFIG_V4L_PLATFORM_DRIVERS
      ARM: configs: multi_v5_defconfig: re-enable DRM_PANEL and FB_xxx
      irqchip/gic, gic-v3: Prevent GSI to SGI translations

Andrea Parri (Microsoft) (1):
      Drivers: hv: vmbus: Replace smp_store_mb() with virt_store_mb()

Andreas Gruenbacher (2):
      powerpc/kvm: Fix kvm_use_magic_page
      gfs2: gfs2_setattr_size error path fix

Andreas Rammhold (1):
      KEYS: trusted: Fix trusted key backends when building as module

Andrew Lunn (1):
      net: ethernet: mv643xx: Fix over zealous checking of_get_mac_address()

Andrew Price (1):
      gfs2: Make sure FITRIM minlen is rounded up to fs block size

Andrii Nakryiko (3):
      selftests/bpf: Normalize XDP section names in selftests
      libbpf: Fix compilation warning due to mismatched printf format
      libbpf: Fix memleak in libbpf_netlink_recv()

Andy Gospodarek (1):
      bnxt_en: reserve space inside receive page for skb_shared_info

Andy Shevchenko (4):
      spi: pxa2xx-pci: Balance reference count for PCI DMA device
      vsprintf: Fix potential unaligned access
      serial: 8250_mid: Balance reference count for PCI DMA device
      serial: 8250_lpss: Balance reference count for PCI DMA device

Ang Tien Sung (1):
      firmware: stratix10-svc: add missing callback parameter on RSU

Anirudh Rayabharam (1):
      vhost: handle error while adding split ranges to iotlb

Anisse Astier (1):
      drm: Add orientation quirk for GPD Win Max

Anssi Hannula (3):
      xhci: fix garbage USBSTS being logged in some cases
      xhci: fix uninitialized string returned by xhci_decode_ctrl_ctx()
      hv_balloon: rate-limit "Unhandled message" warning

Anthony I Gilea (1):
      ASoC: Intel: sof_sdw: fix quirks for 2022 HP Spectre x360 13"

Anton Ivanov (1):
      um: Fix uml_mconsole stop/go

Ard Biesheuvel (1):
      ARM: ftrace: avoid redundant loads or clobbering IP

Armin Wolf (1):
      hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING

Arnaldo Carvalho de Melo (4):
      perf build: Don't use -ffat-lto-objects in the python feature test when building with clang-13
      perf python: Fix probing for some clang command line options
      tools build: Filter out options and warnings not supported by clang
      tools build: Use $(shell ) instead of `` to get embedded libperl's ccopts

Arnd Bergmann (4):
      uaccess: fix nios2 and microblaze get_user_8()
      uaccess: fix type mismatch warnings from access_ok()
      lib/test_lockup: fix kernel pointer check for separate address spaces
      ARM: iop32x: offset IRQ numbers by 1

Arun Easi (2):
      scsi: qla2xxx: Fix device reconnect in loop topology
      scsi: qla2xxx: Fix missed DMA unmap for NVMe ls requests

Arınç ÜNAL (5):
      staging: mt7621-dts: fix LEDs and pinctrl on GB-PC1 devicetree
      staging: mt7621-dts: fix formatting
      staging: mt7621-dts: fix pinctrl properties for ethernet
      staging: mt7621-dts: fix GB-PC2 devicetree
      staging: mt7621-dts: fix pinctrl-0 items to be size-1 items on ethernet

Aswath Govindraju (1):
      mmc: sdhci_am654: Fix the driver data of AM64 SoC

Athira Rajeev (1):
      powerpc/perf: Don't use perf_hw_context for trace IMC PMU

Avraham Stern (1):
      cfg80211: don't add non transmitted BSS to 6GHz scanned channels

Axel Lin (2):
      regulator: rtq2134: Fix missing active_discharge_on setting
      regulator: atc260x: Fix missing active_discharge_on setting

Bagas Sanjaya (2):
      Documentation: add link to stable release candidate tree
      Documentation: update stable tree link

Baokun Li (5):
      jffs2: fix use-after-free in jffs2_clear_xattr_subsystem
      jffs2: fix memory leak in jffs2_do_mount_fs
      jffs2: fix memory leak in jffs2_scan_medium
      ubifs: rename_whiteout: correct old_dir size computing
      ubi: Fix race condition between ctrl_cdev_ioctl and ubi_cdev_ioctl

Bard Liao (1):
      ASoC: SOF: Intel: match sdw version on link_slaves_found

Bart Van Assche (1):
      scsi: fnic: Fix a tracing statement

Bartosz Golaszewski (1):
      Revert "gpio: Revert regression in sysfs-gpio (gpiolib.c)"

Ben Dooks (1):
      PCI: fu740: Force 2.5GT/s for initial device probe

Ben Greear (1):
      mt76: mt7921: fix crash when startup fails.

Benjamin Beichler (1):
      um: fix and optimize xor select template for CONFIG64 and timetravel mode

Benjamin Marty (1):
      drm/amdgpu/display: change pipe policy for DCN 2.1

Bharata B Rao (1):
      sched/debug: Remove mpol_get/put and task_lock/unlock from sched_show_numa

Biju Das (2):
      spi: Fix invalid sgs value
      spi: Fix erroneous sgs value with min_t()

Bikash Hazarika (1):
      scsi: qla2xxx: Fix wrong FDMI data for 64G adapter

Bjorn Helgaas (1):
      PCI: Avoid broken MSI on SB600 USB devices

Brandon Wyman (1):
      hwmon: (pmbus) Add Vin unit off handling

Brett Creeley (1):
      ionic: Don't send reset commands if FW isn't running

Cai Huoqing (1):
      drm/meson: Make use of the helper function devm_platform_ioremap_resourcexxx()

Casey Schaufler (2):
      LSM: general protection fault in legacy_parse_param
      Fix incorrect type in assignment of ipv6 port for audit

Chaitanya Kulkarni (1):
      loop: use sysfs_emit() in the sysfs xxx show()

Chanho Park (1):
      arm64: Add part number for Arm Cortex-A78AE

Chao Yu (6):
      f2fs: fix to unlock page correctly in error path of is_alive()
      f2fs: fix to do sanity check on .cp_pack_total_block_count
      f2fs: fix to enable ATGC correctly via gc_idle sysfs interface
      f2fs: fix to avoid potential deadlock
      f2fs: fix to do sanity check on curseg->alloc_type
      f2fs: compress: fix to print raw data size in error path of lz4 decompression

Charan Teja Kalla (3):
      mm: madvise: skip unmapped vma holes passed to process_madvise
      mm: madvise: return correct bytes advised with process_madvise
      Revert "mm: madvise: skip unmapped vma holes passed to process_madvise"

Charles Keepax (1):
      ASoC: madera: Add dependencies on MFD

Chen Jingwen (1):
      powerpc/kasan: Fix early region not updated correctly

Chen-Yu Tsai (8):
      media: v4l2-mem2mem: Apply DST_QUEUE_OFF_BASE on MMAP buffers across ioctls
      media: hantro: Fix overfill bottom register field name
      pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_* readback
      pinctrl: mediatek: paris: Fix "argument" argument type for mtk_pinconf_get()
      pinctrl: mediatek: paris: Fix pingroup pin config state readback
      pinctrl: mediatek: paris: Skip custom extra pin config dump for virtual GPIOs
      pinctrl: pinconf-generic: Print arguments for bias-pull-*
      net: stmmac: Fix unset max_speed difference between DT and non-DT platforms

ChenXiaoSong (2):
      Revert "NFSv4: Handle the special Linux file open access mode"
      NFSv4: fix open failure with O_ACCMODE flag

Chengming Zhou (2):
      blk-cgroup: set blkg iostat after percpu stat aggregation
      sched/cpuacct: Fix charge percpu cpuusage

Chris Leech (1):
      nvme-tcp: lockdep: annotate in-kernel sockets

Christian Brauner (1):
      landlock: Use square brackets around "landlock-ruleset"

Christian Göttsche (2):
      selinux: check return value of sel_make_avc_files
      selinux: use correct type for context length

Christian König (1):
      drm/syncobj: flatten dma_fence_chains on transfer

Christian Lamparter (1):
      ata: sata_dwc_460ex: Fix crash due to OOB write

Christian Löhle (1):
      mmc: block: Check for errors after write on SPI

Christoph Hellwig (2):
      nvme: cleanup __nvme_check_ids
      nvme: fix the check for duplicate unique identifiers

Christophe JAILLET (8):
      firmware: ti_sci: Fix compilation failure when CONFIG_TI_SCI_PROTOCOL is not defined
      i2c: bcm2835: Fix the error handling in 'bcm2835_i2c_probe()'
      power: supply: sbs-charger: Don't cancel work that is not initialized
      gpu: host1x: Fix a memory leak in 'host1x_remove()'
      fsi: Aspeed: Fix a potential double free
      misc: alcor_pci: Fix an error handling path
      block: Fix the maximum minor value is blk_alloc_ext_minor()
      scsi: zorro7xx: Fix a resource leak in zorro7xx_remove_one()

Christophe Leroy (6):
      vsprintf: Fix %pK with kptr_restrict == 0
      livepatch: Fix build failure on 32 bits processors
      powerpc: Add set_memory_{p/np}() and remove set_memory_attr()
      powerpc/set_memory: Avoid spinlock recursion in change_page_attr()
      powerpc/64: Fix build failure with allyesconfig in book3s_64_entry.S
      static_call: Don't make __static_call_return0 static

Chuck Lever (1):
      NFSD: Fix nfsd_breaker_owns_lease() return values

Chun-Jie Chen (1):
      soc: mediatek: pm-domains: Add wakeup capacity support in power domain

Clark Williams (2):
      Merge tag 'v5.15.34' into v5.15-rt
      Linux 5.15.34-rt40

Claudiu Beznea (3):
      net: dsa: microchip: add spi_device_id tables
      hwrng: atmel - disable trng on failure path
      clocksource/drivers/timer-microchip-pit64b: Use notrace

Codrin Ciubotariu (2):
      ASoC: dmaengine: do not use a NULL prepare_slave_config() callback
      clk: at91: sama7g5: fix parents of PDMCs' GCLK

Colin Ian King (2):
      carl9170: fix missing bit-wise or operator for tx_params
      iwlwifi: Fix -EIO error code that is never returned

Cooper Chiou (1):
      drm/edid: check basic audio support on CEA extension block

Corentin Labbe (9):
      crypto: sun8i-ss - really disable hash on A80
      crypto: rockchip - ECB does not need IV
      crypto: sun8i-ss - call finalize with bh disabled
      crypto: sun8i-ce - call finalize with bh disabled
      crypto: amlogic - call finalize with bh disabled
      crypto: gemini - call finalize with bh disabled
      media: staging: media: zoran: fix usage of vb2_dma_contig_set_max_seg_size
      media: staging: media: zoran: move videodev alloc
      media: staging: media: zoran: calculate the right buffer number for zoran_reap_stat_com

Corinna Vinschen (2):
      igc: avoid kernel warning when changing RX ring parameters
      igb: refactor XDP registration

Dafna Hirschfeld (1):
      media: stk1160: If start stream fails, return buffers with VB2_BUF_STATE_QUEUED

Dale Zhao (1):
      drm/amd/display: Add signal type check when verify stream backends same

Damien Le Moal (18):
      net: bnxt_ptp: fix compilation error
      scsi: libsas: Fix sas_ata_qc_issue() handling of NCQ NON DATA commands
      scsi: pm8001: Fix command initialization in pm80XX_send_read_log()
      scsi: pm8001: Fix command initialization in pm8001_chip_ssp_tm_req()
      scsi: pm8001: Fix payload initialization in pm80xx_set_thermal_config()
      scsi: pm8001: Fix le32 values handling in pm80xx_set_sas_protocol_timer_config()
      scsi: pm8001: Fix payload initialization in pm80xx_encrypt_update()
      scsi: pm8001: Fix le32 values handling in pm80xx_chip_ssp_io_req()
      scsi: pm8001: Fix le32 values handling in pm80xx_chip_sata_req()
      scsi: pm8001: Fix NCQ NON DATA command task initialization
      scsi: pm8001: Fix NCQ NON DATA command completion handling
      scsi: pm8001: Fix abort all task initialization
      scsi: pm8001: Fix pm80xx_pci_mem_copy() interface
      scsi: pm8001: Fix pm8001_mpi_task_abort_resp()
      scsi: pm8001: Fix task leak in pm8001_send_abort_all()
      scsi: pm8001: Fix tag leaks on error
      scsi: pm8001: Fix memory leak in pm8001_chip_fw_flash_update_req()
      scsi: mpt3sas: Fix use after free in _scsih_expander_node_remove()

Dan Carpenter (14):
      greybus: svc: fix an error handling bug in gb_svc_hello()
      NFSD: prevent underflow in nfssvc_decode_writeargs()
      NFSD: prevent integer overflow on 32 bit systems
      video: fbdev: atmel_lcdfb: fix an error code in atmel_lcdfb_probe()
      video: fbdev: fbcvt.c: fix printing in fb_cvt_print_name()
      media: usb: go7007: s2250-board: fix leak in probe()
      libbpf: Fix signedness bug in btf_dump_array_data()
      iwlwifi: mvm: Fix an error code in iwl_mvm_up()
      RDMA/irdma: Prevent some integer underflows
      USB: storage: ums-realtek: fix error code in rts51x_read_mem()
      clk: imx: off by one in imx_lpcg_parse_clks_from_dt()
      lib/test: use after free in register_test_dev_kmod()
      drm/amdgpu: fix off by one in amdgpu_gfx_kiq_acquire()
      rtc: mc146818-lib: fix signedness bug in mc146818_get_time()

Dan Williams (2):
      cxl/core: Fix cxl_probe_component_regs() error message
      nvdimm/region: Fix default alignment for small regions

Daniel González Cabanelas (1):
      media: cx88-mpeg: clear interrupt status register before streaming video

Daniel Henrique Barboza (1):
      powerpc/mm/numa: skip NUMA_NO_NODE onlining in parse_numa_properties()

Daniel Mack (1):
      drm/panel: ili9341: fix optional regulator handling

Daniel Palmer (1):
      ARM: mstar: Select HAVE_ARM_ARCH_TIMER

Daniel Thompson (3):
      soc: qcom: aoss: remove spurious IRQF_ONESHOT flags
      kdb: Fix the putarea helper function
      drm/msm/dsi: Remove spurious IRQF_ONESHOT flag

Daniel Wagner (1):
      scsi: qla2xxx: Refactor asynchronous command initialization

Dario Binacchi (1):
      mtd: rawnand: gpmi: fix controller timings setting

Darren Hart (1):
      ACPI/APEI: Limit printable size of BERT table data

Dave Hansen (1):
      x86/mm/tlb: Revert retpoline avoidance approach

Dave Jiang (3):
      dmaengine: idxd: check GENCAP config support for gencfg register
      dmaengine: idxd: change bandwidth token to read buffers
      dmaengine: idxd: restore traffic class defaults after wq reset

Dave Kleikamp (1):
      KEYS: trusted: Avoid calling null function trusted_key_exit

Dave Stevenson (1):
      regulator: rpi-panel: Handle I2C errors/timing to the Atmel

David Ahern (1):
      ipv6: Fix stats accounting in ip6_pkt_drop

David Engraf (1):
      arm64: signal: nofpsimd: Do not allocate fp/simd context when not available

David Gow (1):
      firmware: google: Properly state IOMEM dependency

David Heidelberg (2):
      arm64: dts: qcom: sdm845: fix microphone bias properties and values
      ARM: dts: qcom: fix gic_irq_domain_translate warnings for msm8960

David Hildenbrand (1):
      drivers/base/memory: add memory block to memory group after registration succeeded

David Howells (3):
      watch_queue: Fix NULL dereference in error cleanup
      watch_queue: Actually free the watch
      rxrpc: Fix call timer start racing with call destruction

David Matlack (1):
      KVM: Prevent module exit until all VMs are freed

David Stevens (5):
      iommu/dma: Skip extra sync during unmap w/swiotlb
      iommu/dma: Fold _swiotlb helpers into callers
      iommu/dma: Check CONFIG_SWIOTLB more broadly
      swiotlb: Support aligned swiotlb buffers
      iommu/dma: Account for min_align_mask w/swiotlb

Denis Nikitin (1):
      perf session: Remap buf if there is no space for event

Deren Wu (1):
      mt76: fix monitor mode crash with sdio driver

Dirk Buchwalder (1):
      clk: qcom: ipq8074: Use floor ops for SDCC1 clock

Dirk Müller (1):
      lib/raid6/test: fix multiple definition linking error

Dmitry Baryshkov (5):
      arm64: dts: qcom: sm8250: fix PCIe bindings to follow schema
      drm/msm/dsi/phy: fix 7nm v4.0 settings for C-PHY mode
      drm/msm/dpu: add DSPP blocks teardown
      drm/msm/dpu: fix dp audio condition
      PM: core: keep irq flags in device_pm_check_callbacks()

Dmitry Torokhov (1):
      HID: i2c-hid: fix GET/SET_REPORT for unnumbered reports

Dmitry Vyukov (1):
      riscv: Increase stack size under KASAN

Dongli Zhang (1):
      xen: delay xen_hvm_init_time_ops() if kdump is boot on vcpu>=32

Dongliang Mu (3):
      media: em28xx: initialize refcount before kref_get
      ntfs: add sanity check on allocation size
      media: hdpvr: initialize dev->worker at hdpvr_register_videodev

Douglas Miller (1):
      RDMA/hfi1: Fix use-after-free bug for mm struct

Drew Fustini (1):
      clocksource/drivers/timer-ti-dm: Fix regression from errata i940 fix

Duoming Zhou (2):
      drivers: hamradio: 6pack: fix UAF bug caused by mod_timer()
      net/x25: Fix null-ptr-deref caused by x25_disconnect

Dust Li (2):
      net/smc: correct settings of RMB window update limit
      net/smc: send directly on setting TCP_NODELAY

Dāvis Mosāns (1):
      crypto: ccp - ccp_dmaengine_unregister release dma channels

Eddie James (1):
      USB: serial: pl2303: add IBM device IDs

Eli Cohen (2):
      vdpa/mlx5: Rename control VQ workqueue to vdpa wq
      vdpa/mlx5: Propagate link status from device to vdpa driver

Emily Deng (1):
      drm/amdgpu/vcn: Fix the register setting for vcn1

Eric Biggers (8):
      KEYS: fix length validation in keyctl_pkey_params_get_2()
      KEYS: asymmetric: enforce that sig algo matches key algo
      KEYS: asymmetric: properly validate hash_algo and encoding
      crypto: rsa-pkcs1pad - only allow with rsa
      crypto: rsa-pkcs1pad - correctly get hash from source scatterlist
      crypto: rsa-pkcs1pad - restore signature length check
      crypto: rsa-pkcs1pad - fix buffer overread in pkcs1pad_verify_complete()
      block: don't delete queue kobject before its children

Eric Dumazet (6):
      watch_queue: Free the page array when watch_queue is dismantled
      net: add skb_set_end_offset() helper
      net: preserve skb_end_offset() in skb_unclone_keeptruesize()
      ipv6: make mc_forwarding atomic
      net: initialize init_net earlier
      rxrpc: fix a race in rxrpc_exit_net()

Eric W. Biederman (4):
      coredump: Snapshot the vmas in do_coredump
      coredump: Remove the WARN_ON in dump_vma_snapshot
      coredump/elf: Pass coredump_params into fill_note_info
      coredump: Use the vma snapshot in fill_files_note

Ethan Lien (1):
      btrfs: fix qgroup reserve overflow the qgroup limit

Eugen Hristev (2):
      media: atmel: atmel-sama7g5-isc: fix ispck leftover
      media: atmel: atmel-isc-base: report frame sizes as full supported range

Eugene Syromiatnikov (1):
      io_uring: implement compat handling for IORING_REGISTER_IOWQ_AFF

Evgeny Boger (1):
      power: supply: axp20x_battery: properly report current when discharging

Evgeny Novikov (1):
      video: fbdev: w100fb: Reset global state

Eyal Birger (1):
      vrf: fix packet sniffing for traffic originating from ip tunnels

Fabiano Rosas (2):
      KVM: PPC: Fix vmx/vsx mixup in mmio emulation
      KVM: PPC: Book3S HV: Check return value of kvmppc_radix_init

Fabio Estevam (1):
      PCI: imx6: Allow to probe when dw_pcie_wait_for_link() fails

Fangrui Song (2):
      arm64: module: remove (NOLOAD) from linker script
      riscv module: remove (NOLOAD)

Felix Maurer (2):
      selftests: bpf: Fix bind on used port
      selftests/bpf: Make test_lwt_ip_encap more stable and faster

Feng Tang (1):
      lib/Kconfig.debug: add ARCH dependency for FUNCTION_ALIGN option

Fengnan Chang (1):
      f2fs: fix compressed file start atomic write may cause data corruption

Filipe Manana (1):
      btrfs: fix unexpected error path when reflinking an inline extent

Florian Fainelli (1):
      net: phy: broadcom: Fix brcm_fet_config_init()

Florian Westphal (2):
      net: prefer nf_ct_put instead of nf_conntrack_put
      netfilter: conntrack: revisit gc autotuning

Frank Wunderlich (1):
      arm64: dts: broadcom: Fix sata nodename

GONG, Ruiqi (1):
      selinux: access superblock_security_struct in LSM blob way

Gal Pressman (1):
      net/mlx5e: Remove overzealous validations in netlink EEPROM query

Geert Uytterhoeven (3):
      hwrng: cavium - HW_RANDOM_CAVIUM should depend on ARCH_THUNDER
      pinctrl: renesas: r8a77470: Reduce size for narrow VIN1 channel
      pinctrl: renesas: checker: Fix miscalculation of number of states

Geliang Tang (1):
      selftests: mptcp: add csum mib check for mptcp_connect

George Kennedy (1):
      video: fbdev: cirrusfb: check pixclock to avoid divide by zero

Gerhard Engleder (1):
      selftests/net: timestamping: Fix bind_phc check

Gilad Ben-Yossef (1):
      crypto: ccree - don't attempt 0 len DMA mappings

Greg Kroah-Hartman (2):
      Linux 5.15.33
      Linux 5.15.34

Guangbin Huang (1):
      net: hns3: fix software vlan talbe of vlan 0 inconsistent with hardware

Guilherme G. Piccoli (2):
      docs: sysctl/kernel: add missing bit to panic_print
      Drivers: hv: vmbus: Fix potential crash on module unload

Guillaume Nault (1):
      ipv4: Fix route lookups when handling ICMP redirects and PMTU updates

Guillaume Ranquet (1):
      clocksource/drivers/timer-of: Check return value of of_iomap in timer_of_base_init()

Guillaume Tucker (1):
      selftests, x86: fix how check_cc.sh is being invoked

Guo Ren (1):
      arm64: patch_text: Fixup last cpu should be master

Guo Xuenan (1):
      lz4: fix LZ4_decompress_safe_partial read out of bound

Gwendal Grignou (2):
      HID: intel-ish-hid: Use dma_alloc_coherent for firmware update
      platform: chrome: Split trace include file

H. Nikolaus Schaller (1):
      usb: dwc3: omap: fix "unbalanced disables for smps10_out1" on omap5evm

Haimin Zhang (2):
      af_key: add __GFP_ZERO flag for compose_sadb_supported in function pfkey_register
      jfs: prevent NULL deref in diFree

Hangbin Liu (3):
      selftests/bpf/test_xdp_redirect_multi: use temp netns for testing
      bareudp: use ipv6_mod_enabled to check if IPv6 enabled
      selftests/bpf/test_lirc_mode2.sh: Exit with proper code

Hangyu Hua (6):
      can: ems_usb: ems_usb_start_xmit(): fix double dev_kfree_skb() in error path
      can: usb_8dev: usb_8dev_start_xmit(): fix double dev_kfree_skb() in error path
      powerpc: 8xx: fix a return value error in mpc8xx_pic_init
      can: mcba_usb: mcba_usb_start_xmit(): fix double dev_kfree_skb in error path
      mips: ralink: fix a refcount leak in ill_acc_of_setup()
      powerpc/secvar: fix refcount leak in format_show()

Hans Verkuil (2):
      ivtv: fix incorrect device_caps for ivtvfb
      media: staging: media: zoran: fix various V4L2 compliance errors

Hans de Goede (7):
      drm/simpledrm: Add "panel orientation" property on non-upright mounted LCD panels
      power: supply: bq24190_charger: Fix bq24190_vbus_is_enabled() wrong false return
      iio: mma8452: Fix probe failing when an i2c_device_id is used
      media: atomisp_gmin_platform: Add DMI quirk to not turn AXP ELDO2 regulator off on some boards
      media: i2c: ov5648: Fix lockdep error
      power: supply: axp288-charger: Set Vhold to 4.4V
      usb: dwc3: pci: Set the swnode from inside dwc3_pci_quirks()

Harold Huang (1):
      tuntap: add sanity checks about msg_controllen in sendmsg

Hector Martin (5):
      brcmfmac: firmware: Allocate space for default boardrev in nvram
      brcmfmac: pcie: Release firmwares in the brcmf_pcie_setup error path
      brcmfmac: pcie: Declare missing firmware files in pcie.c
      brcmfmac: pcie: Replace brcmf_pcie_copy_mem_todev with memcpy_toio
      brcmfmac: pcie: Fix crashes due to early IRQs

Helge Deller (2):
      video: fbdev: sm712fb: Fix crash in smtcfb_read()
      parisc: Fix CPU affinity for Lasi, WAX and Dino chips

Hengqi Chen (1):
      bpf: Fix comment for helper bpf_current_task_under_cgroup()

Henry Lin (1):
      xhci: fix runtime PM imbalance in USB2 resume

Herbert Xu (3):
      crypto: authenc - Fix sleep in atomic context in decrypt_tail
      crypto: xts - Add softdep on ecb
      crypto: arm/aes-neonbs-cbc - Select generic cbc and aes

Hoang Le (1):
      tipc: fix the timer expires after interval 100ms

Horatiu Vultur (2):
      pinctrl: microchip sgpio: use reset driver
      dt-bindings: pinctrl: pinctrl-microchip-sgpio: Fix example

Hou Tao (2):
      bpf, arm64: Call build_prologue() first in first JIT pass
      bpf, arm64: Feed byte-offset into bpf line info

Hou Wenlong (2):
      KVM: x86/emulator: Defer not-present segment check in __load_segment_descriptor()
      KVM: x86/emulator: Emulate RDPID only if it is enabled in guest

Hou Zhiqiang (1):
      PCI: endpoint: Fix alignment fault error in copy tests

Hugh Dickins (1):
      mempolicy: mbind_range() set_policy() after vma_merge()

Håkon Bugge (1):
      IB/cma: Allow XRC INI QPs to set their local ACK timeout

Ian Rogers (1):
      perf vendor events: Update metrics for SkyLake Server

Ido Schimmel (2):
      selftests: test_vxlan_under_vrf: Fix broken test case
      ipv4: Invalidate neighbour for broadcast address upon address addition

Ilan Peer (2):
      mac80211: Remove a couple of obsolete TODO
      iwlwifi: mvm: Correctly set fragmented EBS

Ilpo Järvinen (1):
      serial: 8250: fix XOFF/XON sending when DMA is used

Ilya Maximets (2):
      net: openvswitch: don't send internal clone attribute to the userspace.
      net: openvswitch: fix leak of nested actions

Ivan Vecera (1):
      ice: Clear default forwarding VSI during VSI release

Jackie Liu (1):
      n64cart: convert bi_disk to bi_bdev->bd_disk fix build

Jaegeuk Kim (3):
      f2fs: fix missing free nid in f2fs_handle_failed_inode
      f2fs: don't get FREEZE lock in f2fs_evict_inode in frozen fs
      f2fs: use spin_lock to avoid hang

Jagan Teki (1):
      drm: bridge: adv7511: Fix ADV7535 HPD enablement

Jakob Koschel (2):
      media: saa7134: fix incorrect use to determine if list is empty
      powerpc/sysdev: fix incorrect use to determine if list is empty

Jakub Kicinski (4):
      tcp: ensure PMTU updates are processed during fastopen
      net: account alternate interface name memory
      net: limit altnames to 64k total
      Revert "selftests: net: Add tls config dependency for tls selftests"

Jakub Sitnicki (4):
      selftests/bpf: Fix error reporting from sock_fields programs
      bpf: Make dst_port field in struct bpf_sock 16-bit wide
      bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide
      selftests/bpf: Fix u8 narrow load checks for bpf_sk_lookup remote_port

James Clark (2):
      coresight: Fix TRCCONFIGR.QE sysfs interface
      perf: arm-spe: Fix perf report --mem-mode

James Smart (1):
      scsi: scsi_transport_fc: Fix FPIN Link Integrity statistics counters

Jamie Bainbridge (2):
      sctp: count singleton chunks in assoc user stats
      qede: confirm skb is allocated before using

Jammy Huang (1):
      media: aspeed: Correct value for h-total-pixels

Jani Nikula (1):
      drm/i915/opregion: check port number bounds for SWSCI display power state

Jann Horn (3):
      ptrace: Check PTRACE_O_SUSPEND_SECCOMP permission on PTRACE_SEIZE
      coredump: Also dump first pages of non-executable ELF libraries
      pstore: Don't use semaphores in always-atomic-context code

Janusz Krzysztofik (3):
      media: ov6650: Fix set format try processing path
      media: ov6650: Add try support to selection API operations
      media: ov6650: Fix crop rectangle affected by set format

Jason A. Donenfeld (2):
      wireguard: queueing: use CFI-safe ptr_ring cleanup function
      wireguard: socket: ignore v6 endpoints when ipv6 is disabled

Jason Wang (1):
      vdpa: mlx5: prevent cvq work from hogging CPU

Jean-Philippe Brucker (1):
      skbuff: fix coalescing for page_pool fragment recycling

Jens Axboe (6):
      io_uring: don't check unrelated req->open.how in accept request
      io_uring: terminate manual loop iterator loop correctly for non-vecs
      io_uring: don't check req->file in io_fsync_prep()
      io_uring: defer splice/tee file validity check until command issue
      io_uring: fix race between timeout flush and removal
      Revert "nbd: fix possible overflow on 'first_minor' in nbd_dev_add()"

Jeremy Linton (1):
      net: bcmgenet: Use stronger register read/writes to assure ordering

Jernej Skrabec (2):
      media: cedrus: H265: Fix neighbour info buffer size
      media: cedrus: h264: Fix neighbour info buffer size

Jia-Ju Bai (3):
      ASoC: rt5663: check the return value of devm_kzalloc() in rt5663_parse_dp()
      memory: emif: check the pointer temp in get_device_details()
      platform/x86: huawei-wmi: check the return value of device_create_file()

Jian Shen (4):
      net: hns3: fix bug when PF set the duplicate MAC address for VFs
      net: hns3: fix port base vlan add fail when concurrent with reset
      net: hns3: add vlan list lock to protect vlan list
      net: hns3: refine the process when PF set VF VLAN

Jianglei Nie (2):
      crypto: ccree - Fix use after free in cc_cipher_exit()
      scsi: libfc: Fix use after free in fc_exch_abts_resp()

Jianyong Wu (1):
      arm64/mm: avoid fixmap race condition when create pud mapping

Jiasheng Jiang (30):
      thermal: int340x: Check for NULL after calling kmemdup()
      spi: spi-zynqmp-gqspi: Handle error for dma_set_mask
      media: mtk-vcodec: potential dereference of null pointer
      ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
      media: meson: vdec: potential dereference of null pointer
      soc: qcom: rpmpd: Check for null return of devm_kcalloc
      ASoC: ti: davinci-i2s: Add check for clk_enable()
      ALSA: spi: Add check for clk_enable()
      ASoC: mxs-saif: Handle errors for clk_enable
      ASoC: atmel_ssc_dai: Handle errors for clk_enable
      ASoC: dwc-i2s: Handle errors for clk_enable
      ASoC: soc-compress: prevent the potentially use of null pointer
      memory: emif: Add check for setup_interrupts
      media: vidtv: Check for null return of vzalloc
      ASoC: wm8350: Handle error for wm8350_register_irq
      ASoC: fsi: Add check for clk_enable
      mmc: davinci_mmc: Handle error for clk_enable
      drm/v3d/v3d_drv: Check for error num after setting mask
      drm/panfrost: Check for error num after setting mask
      mtd: onenand: Check for error irq
      ray_cs: Check ioremap return value
      iommu/ipmmu-vmsa: Check for error num after setting mask
      power: supply: wm8350-power: Handle error for wm8350_register_irq
      power: supply: wm8350-power: Add missing free in free_charger_irq
      mfd: mc13xxx: Add check for mc13xxx_irq_request
      iio: adc: Add check for devm_request_threaded_irq
      habanalabs: Add check for pci_enable_device
      ASoC: soc-compress: Change the check for codec_dai
      rtc: wm8350: Handle error for wm8350_register_irq
      drm/imx: imx-ldb: Check for null pointer after calling kmemdup

Jiaxin Yu (1):
      ASoC: mediatek: mt6358: add missing EXPORT_SYMBOLs

Jie Hai (1):
      dmaengine: hisi_dma: fix MSI allocate fail when reload hisi_dma

Jim Mattson (2):
      KVM: x86/pmu: Use different raw event masks for AMD and Intel
      KVM: x86/svm: Clear reserved bits written to PerfEvtSeln MSRs

Jing Yao (3):
      video: fbdev: omapfb: panel-dsi-cm: Use sysfs_emit() instead of snprintf()
      video: fbdev: omapfb: panel-tpo-td043mtea1: Use sysfs_emit() instead of snprintf()
      video: fbdev: udlfb: replace snprintf in show functions with sysfs_emit

Jiri Slaby (2):
      mxser: fix xmit_buf leak in activate when LSR == 0xff
      serial: samsung_tty: do not unlock port->lock for uart_write_wakeup()

Jocelyn Falempe (1):
      mgag200 fix memmapsl configuration in GCTL6 register

Joe Carnuccio (3):
      scsi: qla2xxx: Fix T10 PI tag escape and IP guard options for 28XX adapters
      scsi: qla2xxx: Add devids and conditionals for 28xx
      scsi: qla2xxx: Check for firmware dump already collected

Joel Stanley (2):
      fsi: scom: Fix error handling
      fsi: scom: Remove retries in indirect scoms

Johan Almbladh (1):
      mt76: mt7915: fix injected MPDU transmission to not use HW A-MSDU

Johan Hovold (5):
      USB: serial: pl2303: fix GS type detection
      USB: serial: simple: add Nokia phone driver
      firmware: sysfb: fix platform-device leak in error path
      media: davinci: vpif: fix unbalanced runtime PM get
      media: davinci: vpif: fix unbalanced runtime PM enable

Johannes Berg (4):
      rfkill: make new event layout opt-in
      mac80211: limit bandwidth in HE capabilities
      iwlwifi: mvm: align locking in D3 test debugfs
      lib/logic_iomem: correct fallback config references

John David Anglin (2):
      parisc: Fix handling off probe non-access faults
      parisc: Fix patch code locking and flushing

John Garry (1):
      scsi: core: Fix sbitmap depth in scsi_realloc_sdev_budget_map()

Jon Hunter (1):
      spi: Fix Tegra QSPI example

Jonathan Cameron (2):
      cxl/regs: Fix size of CXL Capability Header Register
      staging:iio:adc:ad7280a: Fix handing of device address bit reversing.

Jonathan Marek (4):
      media: camss: csid-170: fix non-10bit formats
      media: camss: csid-170: don't enable unused irqs
      media: camss: csid-170: set the right HALT_CMD when disabled
      media: camss: vfe-170: fix "VFE halt timeout" error

Jonathan Neuschäfer (6):
      clk: actions: Terminate clk_div_table with sentinel element
      clk: loongson1: Terminate clk_div_table with sentinel element
      clk: hisilicon: Terminate clk_div_table with sentinel element
      clk: clps711x: Terminate clk_div_table with sentinel element
      pinctrl: nuvoton: npcm7xx: Rename DS() macro to DSTR()
      pinctrl: nuvoton: npcm7xx: Use %zu printk format for ARRAY_SIZE()

Jordy Zomer (1):
      dm ioctl: prevent potential spectre v1 gadget

Josef Bacik (1):
      btrfs: make search_csum_tree return 0 if we get -EFBIG

Joseph Qi (1):
      ocfs2: fix crash when mount with quota enabled

José Expósito (3):
      Revert "Input: clear BTN_RIGHT/MIDDLE on buttonpads"
      drm/selftests/test-drm_dp_mst_helper: Fix memory leak in sideband_msg_req_encode_decode
      drm/imx: Fix memory leak in imx_pd_connector_get_modes

José Roberto de Souza (1):
      drm/i915/display: Fix HPD short pulse handling for eDP

Juergen Gross (1):
      xen: fix is_xen_pmu()

Juhyung Park (1):
      f2fs: quota: fix loop condition at f2fs_quota_sync()

Kai Vehmanen (1):
      ASoC: SOF: Intel: enable DMI L1 for playback streams

Kai Ye (3):
      crypto: hisilicon/sec - fix the aead software fallback for engine
      crypto: hisilicon/qm - cleanup warning in qm_vf_read_qos
      crypto: hisilicon/sec - not need to enable sm4 extra mode at HW V3

Kai-Heng Feng (3):
      ALSA: hda/realtek: Fix audio regression on Mi Notebook Pro 2020
      mmc: rtsx: Use pm_runtime_{get,put}() to handle runtime PM
      mmc: rtsx: Let MMC core handle runtime PM

Kaiwen Hu (1):
      btrfs: prevent subvol with swapfile from being deleted

Kalle Valo (2):
      ath11k: pci: fix crash on suspend if board file is not found
      ath11k: mhi: use mhi_sync_power_up()

Kamal Dasu (1):
      spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op()

Kan Liang (2):
      perf/x86/intel: Update the FRONTEND MSR mask on Sapphire Rapids
      perf/x86/intel: Don't extend the pseudo-encoding to GP counters

Karol Herbst (1):
      drm/nouveau/pmu: Add missing callbacks for Tegra devices

Kees Cook (4):
      exec: Force single empty string when argv is empty
      gcc-plugins/stackleak: Exactly match strings instead of prefixes
      drm/dp: Fix off-by-one in register cache size
      ubsan: remove CONFIG_UBSAN_OBJECT_SIZE

Kefeng Wang (1):
      powerpc: Fix virt_addr_valid() for 64-bit Book3E & 32-bit

Kevin Groeneveld (1):
      scsi: sr: Fix typo in CDROM(CLOSETRAY|EJECT) handling

Kirill Tkhai (1):
      dm: fix use-after-free in dm_cleanup_zoned_dev()

Konrad Dybcio (1):
      clk: qcom: gcc-msm8994: Fix gpll4 width

Krzysztof Kozlowski (7):
      dt-bindings: usb: hcd: correct usb-device path
      pinctrl: samsung: drop pin banks references on error paths
      ARM: dts: exynos: fix UART3 pins configuration in Exynos5250
      ARM: dts: exynos: add missing HDMI supplies on SMDK5250
      ARM: dts: exynos: add missing HDMI supplies on SMDK5420
      clocksource/drivers/exynos_mct: Handle DTS with higher number of interrupts
      MIPS: ingenic: correct unit node address

Kuan-Ying Lee (1):
      mm/kmemleak: reset tag when compare object pointer

Kuldeep Singh (5):
      arm64: dts: ns2: Fix spi-cpol and spi-cpha property
      ARM: dts: spear1340: Update serial node properties
      ARM: dts: spear13xx: Update SPI dma properties
      arm64: dts: ls1043a: Update i2c dma properties
      arm64: dts: ls1046a: Update i2c node dma properties

Kumar Kartikeya Dwivedi (1):
      bpf: Fix UAF due to race between btf_try_get_module and load_module

Kunihiko Hayashi (1):
      clk: uniphier: Fix fixed-rate initialization

Kuniyuki Iwashima (2):
      af_unix: Fix some data-races around unix_sk(sk)->oob_skb.
      af_unix: Support POLLPRI for OOB.

Kuogee Hsieh (3):
      drm/msm/dp: populate connector of struct dp_panel
      drm/msm/dp: stop link training after link training 2 failed
      drm/msm/dp: always add fail-safe mode into connector mode list

Lad Prabhakar (3):
      ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv() recursively
      i2c: bcm2835: Use platform_get_irq() to get the interrupt
      ASoC: sh: rz-ssi: Make the data structures available before registering the handlers

Lars Ellenberg (1):
      drbd: fix potential silent data corruption

Laurent Pinchart (1):
      media: staging: media: imx: imx7-mipi-csis: Make subdev name unique

Lee Jones (1):
      drm/amdkfd: Create file descriptor after client is added to smi_clients list

Leilk Liu (1):
      spi: mediatek: support tick_delay without enhance_timing

Leon Romanovsky (1):
      Revert "RDMA/core: Fix ib_qp_usecnt_dec() called when error"

Li Chen (1):
      PCI: endpoint: Fix misused goto label

Li RongQing (1):
      KVM: x86: fix sending PV IPI

Liam Beguin (4):
      iio: afe: rescale: use s64 for temporary scale calculations
      iio: inkern: apply consumer scale on IIO_VAL_INT cases
      iio: inkern: apply consumer scale when no channel scale is available
      iio: inkern: make a best effort on offset calculation

Libin Yang (1):
      soundwire: intel: fix wrong register name in intel_shim_wake

Liguang Zhang (1):
      PCI: pciehp: Clear cmd_busy bit in polling mode

Like Xu (1):
      KVM: x86/pmu: Fix and isolate TSX-specific performance event logic

Lina Wang (1):
      xfrm: fix tunnel model fragmentation behavior

Lino Sanfilippo (1):
      tpm: fix reference counting for struct tpm_chip

Linus Torvalds (4):
      Revert "swiotlb: rework "fix info leak with DMA_FROM_DEVICE""
      fs: fd tables have to be multiples of BITS_PER_LONG
      fs: fix fd table size alignment properly
      Reinstate some of "swiotlb: rework "fix info leak with DMA_FROM_DEVICE""

Linus Walleij (2):
      Input: zinitix - do not report shadow fingers
      power: ab8500_chargalg: Use CLOCK_MONOTONIC

Liu Ying (2):
      phy: dphy: Correct lpx parameter and its derivatives(ta_{get,go,sure})
      drm/imx: dw_hdmi-imx: Fix bailout in error cases of probe

Lorenzo Bianconi (9):
      mt76: connac: fix sta_rec_wtbl tag len
      mt76: mt7915: use proper aid value in mt7915_mcu_wtbl_generic_tlv in sta mode
      mt76: mt7915: use proper aid value in mt7915_mcu_sta_basic_tlv
      mt76: mt7921: fix a leftover race in runtime-pm
      mt76: mt7615: fix a leftover race in runtime-pm
      mt76: mt7603: check sta_rates pointer in mt7603_sta_rate_tbl_update
      mt76: mt7615: check sta_rates pointer in mt7615_sta_rate_tbl_update
      mt76: mt7921: fix mt7921_queues_acq implementation
      mt76: dma: initialize skip_unmap in mt76_dma_rx_fill

Luca Coelho (1):
      iwlwifi: mvm: don't iterate unadded vifs when handling FW SMPS req

Luca Weiss (1):
      cpufreq: qcom-cpufreq-nvmem: fix reading of PVS Valid fuse

Lucas Denefle (1):
      w1: w1_therm: fixes w1_seq for ds28ea00 sensors

Lucas Tanure (1):
      i2c: meson: Fix wrong speed use from probe

Lucas Zampieri (1):
      HID: logitech-dj: add new lightspeed receiver id

Luis Chamberlain (1):
      nbd: add error handling support for add_disk()

Luiz Augusto von Dentz (2):
      Bluetooth: Fix not checking for valid hdev on bt_dev_{info,warn,err,dbg}
      Bluetooth: Fix use after free in hci_send_acl

Lv Ruyi (1):
      proc: bootconfig: Add null pointer check

Lv Yunlong (1):
      drbd: Fix five use after free bugs in get_initial_state

Lyude Paul (2):
      drm/nouveau/backlight: Fix LVDS backlight detection on some laptops
      drm/nouveau/backlight: Just set all backlight types as RAW

Maciej Fijalkowski (2):
      ice: synchronize_rcu() when terminating rings
      ice: xsk: fix VSI state check in ice_xsk_wakeup()

Maciej W. Rozycki (2):
      DEC: Limit PMAX memory probing to R3k systems
      MIPS: Sanitise Cavium switch cases in TLB handler synthesizers

Magnus Karlsson (1):
      xsk: Fix race at socket teardown

Mahesh Rajashekhara (1):
      scsi: smartpqi: Fix kdump issue when controller is locked up

Manish Chopra (2):
      qed: display VF trust config
      qed: validate and restrict untrusted VFs vlan promisc mode

Manish Rangankar (1):
      scsi: qla2xxx: Use correct feature type field during RFF_ID processing

Manivannan Sadhasivam (2):
      arm64: dts: qcom: sm8250: Fix MSI IRQ for PCIe1 and PCIe2
      PCI: pciehp: Add Qualcomm quirk for Command Completed erratum

Maor Gottlieb (1):
      RDMA/core: Set MR type in ib_reg_user_mr

Marc Kleine-Budde (1):
      can: m_can: m_can_tx_handler(): fix use after free of skb

Marc Zyngier (6):
      PCI: xgene: Revert "PCI: xgene: Fix IB window setup"
      pinctrl: npcm: Fix broken references to chip->parent_device
      irqchip/qcom-pdc: Fix broken locking
      PCI: xgene: Revert "PCI: xgene: Use inbound resources for setup"
      irqchip/gic-v3: Fix GICR_CTLR.RWP polling
      irqchip/gic-v4: Wait for GICR_VPENDBASER.Dirty to clear before descheduling

Marcel Ziswiler (1):
      arm64: defconfig: build imx-sdma as a module

Marcelo Ricardo Leitner (1):
      net/sched: act_ct: fix ref leak when switching zones

Marcelo Roberto Jimenez (1):
      gpio: Revert regression in sysfs-gpio (gpiolib.c)

Marco Elver (5):
      stack: Constrain and fix stack offset randomization with Clang builds
      kfence: count unexpectedly skipped allocations
      kfence: move saving stack trace of allocations into __kfence_alloc()
      kfence: limit currently covered allocations when pool nearly full
      stacktrace: move filter_irq_stacks() to kernel/stacktrace.c

Marek Szyprowski (1):
      clocksource/drivers/exynos_mct: Refactor resources allocation

Marek Vasut (1):
      ARM: dts: imx: Add missing LVDS decoder on M53Menlo

Marijn Suijten (2):
      firmware: qcom: scm: Remove reassignment to desc following initializer
      drm/msm/dsi: Use "ref" fw clock instead of global name for VCO parent

Mark Brown (2):
      mtd: mchp23k256: Add SPI ID table
      mtd: mchp48l640: Add SPI ID table

Mark Rutland (2):
      arm64: prevent instrumentation of bp hardening callbacks
      atomics: Fix atomic64_{read_acquire,set_release} fallbacks

Mark Tomlinson (1):
      PCI: Reduce warnings on possible RW1C corruption

Mark Zhang (1):
      IB/cm: Cancel mad on the DREQ event when the state is MRA_REP_RCVD

Martin Blumenstingl (2):
      drm/meson: osd_afbcd: Add an exit callback to struct meson_afbcd_ops
      drm/meson: Fix error handling when afbcd.ops->init fails

Martin Habets (1):
      sfc: Do not free an empty page_ring

Martin Kaiser (1):
      staging: r8188eu: fix endless loop in recv_func

Martin Kepplinger (2):
      media: imx: imx8mq-mipi-csi2: remove wrong irq config write operation
      media: imx: imx8mq-mipi_csi2: fix system resume

Martin Varghese (1):
      openvswitch: Fixed nd target mask field in the flow dump.

Masahiro Yamada (1):
      modpost: restore the warning message for missing symbol versions

Mastan Katragadda (1):
      drm/i915/gem: add missing boundary check in vm_access

Mateusz Jończyk (4):
      rtc: mc146818-lib: fix locking in mc146818_set_time
      rtc: mc146818-lib: change return values of mc146818_get_time()
      rtc: Check return value from mc146818_get_time()
      rtc: mc146818-lib: fix RTC presence check

Mathias Nyman (1):
      xhci: make xhci_handshake timeout for xhci_reset() adjustable

Mathieu Desnoyers (1):
      rseq: Remove broken uapi field layout on 32-bit little endian

Matt Johnston (1):
      mctp: Fix check for dev_hard_header() result

Matt Kramer (1):
      ALSA: hda/realtek: Add alc256-samsung-headphone fixup

Matthew Wilcox (Oracle) (2):
      XArray: Fix xas_create_range() when multi-order entry present
      XArray: Update the LRU list in xas_split()

Maulik Shah (2):
      arm64: dts: qcom: sm8150: Correct TCS configuration for apps rsc
      arm64: dts: qcom: sm8350: Correct TCS configuration for apps rsc

Mauricio Faria de Oliveira (1):
      mm: fix race between MADV_FREE reclaim and blkdev direct IO read

Mauro Carvalho Chehab (1):
      media: atomisp: fix bad usage at error handling logic

Max Filippov (5):
      xtensa: define update_mmu_tlb function
      xtensa: fix stop_machine_cpuslocked call in patch_text
      xtensa: fix xtensa_wsr always writing 0
      xtensa: fix DTC warning unit_address_format
      highmem: fix checks in __kmap_local_sched_{in,out}

Maxim Kiselev (2):
      powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
      powerpc: dts: t104xrdb: fix phy type for FMAN 4/5

Maxim Mikityanskiy (2):
      net/mlx5e: Disable TX queues before registering the netdev
      bpf: Support dual-stack sockets in bpf_tcp_check_syncookie

Maxime Ripard (6):
      drm/edid: Don't clear formats if using deep color
      drm/edid: Split deep color modes between RGB and YUV444
      clk: Fix clk_hw_get_clk() when dev is NULL
      clk: Initialize orphan req_rate
      drm/connector: Fix typo in documentation
      clk: Enforce that disjoints limits are invalid

Maíra Canal (1):
      drm/amd/display: Remove vupdate_int_entry definition

Mel Gorman (1):
      sched/fair: Improve consistency of allowed NUMA balance calculations

Meng Tang (1):
      ASoC: amd: Fix reference to PCM buffer address

Miaohe Lin (3):
      mm/mlock: fix two bugs in user_shm_lock()
      kernel/resource: fix kfree() of bootmem memory again
      mm/mempolicy: fix mpol_new leak in shared_policy_replace

Miaoqian Lin (37):
      coresight: syscfg: Fix memleak on registration failure in cscfg_create_device
      spi: tegra114: Add missing IRQ check in tegra_spi_probe
      spi: tegra210-quad: Fix missin IRQ check in tegra_qspi_probe
      hwrng: nomadik - Change clk_disable to clk_disable_unprepare
      media: coda: Fix missing put_device() call in coda_get_vdoa_data
      soc: qcom: ocmem: Fix missing put_device() call in of_get_ocmem
      soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe
      ASoC: atmel: Add missing of_node_put() in at91sam9g20ek_audio_probe
      video: fbdev: omapfb: Add missing of_node_put() in dvic_probe_of
      ASoC: atmel: Fix error handling in snd_proto_probe
      ASoC: rockchip: i2s: Fix missing clk_disable_unprepare() in rockchip_i2s_probe
      ASoC: SOF: Add missing of_node_put() in imx8m_probe
      ASoC: mediatek: mt8192-mt6359: Fix error handling in mt8192_mt6359_dev_probe
      ASoC: rk817: Fix missing clk_disable_unprepare() in rk817_platform_probe
      ASoC: mxs: Fix error handling in mxs_sgtl5000_probe
      ASoC: msm8916-wcd-digital: Fix missing clk_disable_unprepare() in msm8916_wcd_digital_probe
      ASoC: atmel: Fix error handling in sam9x5_wm8731_driver_probe
      ASoC: msm8916-wcd-analog: Fix error handling in pm8916_wcd_analog_spmi_probe
      ASoC: codecs: wcd934x: Add missing of_node_put() in wcd934x_codec_parse_data
      drm/bridge: Fix free wrong object in sii8620_init_rcp_input_dev
      drm/bridge: Add missing pm_runtime_disable() in __dw_mipi_dsi_probe
      drm/bridge: nwl-dsi: Fix PM disable depth imbalance in nwl_dsi_probe
      power: reset: gemini-poweroff: Fix IRQ check in gemini_poweroff_probe
      power: supply: ab8500: Fix memory leak in ab8500_fg_sysfs_init
      drm/tegra: Fix reference leak in tegra_dsi_ganged_probe
      ath10k: Fix error handling in ath10k_setup_msa_resources
      mips: cdmm: Fix refcount leak in mips_cdmm_phys_base
      mfd: asic3: Add missing iounmap() on error asic3_mfd_probe
      remoteproc: qcom: Fix missing of_node_put in adsp_alloc_memory_region
      remoteproc: qcom_wcnss: Add missing of_node_put() in wcnss_alloc_memory_region
      remoteproc: qcom_q6v5_mss: Fix some leaks in q6v5_alloc_memory_region
      clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver
      pinctrl: mediatek: Fix missing of_node_put() in mtk_pctrl_init
      pinctrl: nomadik: Add missing of_node_put() in nmk_pinctrl_probe
      pinctrl/rockchip: Add missing of_node_put() in rockchip_pinctrl_probe
      watchdog: rti-wdt: Add missing pm_runtime_disable() in probe function
      dpaa2-ptp: Fix refcount leak in dpaa2_ptp_probe

Michael Chan (1):
      bnxt_en: Eliminate unintended link toggle during FW reset

Michael Ellerman (4):
      powerpc/Makefile: Don't pass -mcpu=powerpc64 when building 32-bit
      powerpc/64s: Don't use DSISR for SLB faults
      powerpc/pseries: Fix use after free in remove_phb_dynamic()
      powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FSL_BOOK3E

Michael Hübner (1):
      HID: Add support for open wheel and no attachment to T300

Michael S. Tsirkin (1):
      virtio_console: break out of buf poll on remove

Michael Schmitz (1):
      video: fbdev: atari: Atari 2 bpp (STe) palette bugfix

Michael Straube (1):
      staging: r8188eu: release_firmware is not called if allocation fails

Michael T. Kloos (1):
      riscv: Fixed misaligned memory access. Fixed pointer comparison.

Michael Walle (3):
      pinctrl: microchip-sgpio: lock RMW access
      net: sfp: add 2500base-X quirk for Lantech SFP module
      net: phy: mscc-miim: reject clause 45 register accesses

Michael Wu (1):
      mmc: core: Fixup support for writeback-cache for eMMC and SD

Mike Marciniszyn (1):
      IB/hfi1: Allow larger MTU without AIP

Mike Snitzer (4):
      dm stats: fix too short end duration_ns when using precise_timestamps
      dm: interlock pending dm_io and dm_wait_for_bios_completion
      dm: fix double accounting of flush with data
      dm: requeue IO if mapping table not yet available

Mikulas Patocka (1):
      dm integrity: set journal entry unused when shrinking device

Minchan Kim (1):
      mm: fs: fix lru_cache_disabled race in bh_lru

Ming Qian (1):
      media: imx-jpeg: fix a bug of accessing array out of bounds

Minghao Chi (1):
      spi: tegra20: Use of_device_get_match_data()

Minghao Chi (CGEL ZTE) (2):
      net:mcf8390: Use platform_get_irq() to get the interrupt
      Bluetooth: use memset avoid memory leaks

Mingzhe Zou (1):
      bcache: fixup multiple threads crash

Miquel Raynal (4):
      spi: mxic: Fix the transmit path
      dt-bindings: mtd: nand-controller: Fix the reg property description
      dt-bindings: mtd: nand-controller: Fix a comment in the examples
      dt-bindings: spi: mxic: The interrupt property is not mandatory

Mirela Rabulea (2):
      media: ov5640: Fix set format, v4l2_mbus_pixelcode not updated
      media: imx-jpeg: Prevent decoding NV12M jpegs into single-planar buffers

Miri Korenblit (1):
      iwlwifi: mvm: move only to an enabled channel

Miroslav Lichvar (1):
      ptp: unregister virtual clocks when unregistering physical clock.

Mohan Kumar (1):
      ALSA: hda: Avoid unsol event during RPM suspending

Muchun Song (1):
      mm: kfence: fix missing objcg housekeeping for SLAB

Muhammad Usama Anjum (3):
      selftests/x86: Add validity check and allow field splitting
      selftests/sgx: Treat CC as one argument
      selftests/lkdtm: Add UBSAN config

Mustafa Ismail (3):
      RDMA/irdma: Fix netdev notifications for vlan's
      RDMA/irdma: Fix Passthrough mode in VM
      RDMA/irdma: Remove incorrect masking of PD

Namhyung Kim (2):
      bpf: Adjust BPF stack helper functions to accommodate skip > 0
      perf/core: Inherit event_caps

Naohiro Aota (1):
      btrfs: zoned: mark relocation as writing

Naresh Kamboju (1):
      selftests: net: Add tls config dependency for tls selftests

Nathan Chancellor (1):
      x86/Kconfig: Do not allow CONFIG_X86_X32_ABI=y with llvm-objcopy

Neal Liu (1):
      usb: ehci: add pci device support for Aspeed platforms

Neil Armstrong (3):
      media: mexon-ge2d: fixup frames size in registers
      drm/meson: split out encoder from meson_dw_hdmi
      drm/bridge: dw-hdmi: use safe format when first in bridge chain

NeilBrown (6):
      SUNRPC: avoid race between mod_timer() and del_timer_sync()
      SUNRPC/call_alloc: async tasks mustn't block waiting for memory
      SUNRPC/xprt: async tasks mustn't block waiting for memory
      SUNRPC: remove scheduling boost for "SWAPPER" tasks.
      NFS: swap IO handling is slightly different for O_DIRECT IO
      NFS: swap-out must always use STABLE writes.

Nicholas Kazlauskas (1):
      drm/amd/display: Use PSR version selected during set_psr_caps

Nicholas Piggin (1):
      powerpc/64s/hash: Make hash faults work in NMI context

Nicolas Dufresne (1):
      media: v4l2-core: Initialize h264 scaling matrix

Niels Dossche (3):
      btrfs: extend locking to all space_info members accesses
      Bluetooth: call hci_le_conn_failed with hdev lock in hci_le_conn_failed
      IB/rdmavt: add lock to call to rvt_error_qp to prevent a race condition

Nikita Shubin (1):
      riscv: Fix fill_callchain return value

Niklas Cassel (1):
      riscv: dts: canaan: Fix SPI3 bus width

Niklas Söderlund (1):
      samples/bpf, xdpsock: Fix race when running for fix duration of time

Nikolay Aleksandrov (1):
      net: ipv4: fix route with nexthop object delete warning

Nilesh Javali (1):
      scsi: qla2xxx: Fix warning for missing error code

Nishanth Menon (5):
      arm64: dts: ti: k3-am65: Fix gic-v3 compatible regs
      arm64: dts: ti: k3-j721e: Fix gic-v3 compatible regs
      arm64: dts: ti: k3-j7200: Fix gic-v3 compatible regs
      arm64: dts: ti: k3-am64: Fix gic-v3 compatible regs
      drm/bridge: cdns-dsi: Make sure to to create proper aliases for dt

Ohad Sharabi (1):
      habanalabs: fix possible memory leak in MMU DR fini

Ojaswin Mujoo (1):
      ext4: make mb_optimize_scan performance mount option work with extents

Olga Kornievskaia (2):
      SUNRPC don't resend a task on an offlined transport
      NFSv4.1: don't retry BIND_CONN_TO_SESSION on session error

Oliver Hartkopp (6):
      vxcan: enable local echo for sent CAN frames
      can: isotp: sanitize CAN ID checks in isotp_bind()
      can: isotp: return -EADDRNOTAVAIL when reading from unbound socket
      can: isotp: support MSG_TRUNC flag when reading from socket
      can: isotp: restore accidentally removed MSG_PEEK feature
      can: isotp: set default value for N_As to 50 micro seconds

Ondrej Zary (1):
      media: bttv: fix WARNING regression on tunerless devices

Pablo Neira Ayuso (2):
      netfilter: flowtable: Fix QinQ and pppoe support for inet table
      netfilter: nf_conntrack_tcp: preserve liberal flag in tcp options

Pali Rohár (4):
      PCI: aardvark: Fix reading MSI interrupt number
      PCI: aardvark: Fix reading PCI_EXP_RTSTA_PME bit on emulated bridge
      PCI: aardvark: Fix support for MSI interrupts
      Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator warning"

Pankaj Raghav (1):
      nvme: fix the read-only state for zoned namespaces with unsupposed features

Paolo Bonzini (4):
      KVM: x86: Reinitialize context if host userspace toggles EFER.LME
      KVM: x86/mmu: do compare-and-exchange of gPTE via the user address
      mmmremap.c: avoid pointless invalidate_range_start/end on mremap(old_size=0)
      KVM: avoid NULL pointer dereference in kvm_dirty_ring_push

Paolo Valente (1):
      Revert "Revert "block, bfq: honor already-setup queue merges""

Patrick Rudolph (1):
      hwmon: (pmbus) Add mutex to regulator ops

Paul Davey (1):
      bus: mhi: Fix MHI DMA structure endianness

Paul E. McKenney (2):
      rcu: Mark writes to the rcu_segcblist structure's ->flags field
      torture: Make torture.sh help message match reality

Paul Kocialkowski (1):
      ARM: dts: sun8i: v3s: Move the csi1 block to follow address order

Paul Menzel (1):
      lib/raid6/test/Makefile: Use $(pound) instead of \# for Make 4.3

Paulo Alcantara (2):
      cifs: prevent bad output lengths in smb2_ioctl_query_info()
      cifs: fix NULL ptr dereference in smb2_ioctl_query_info()

Pavan Chebbi (1):
      bnxt_en: Synchronize tx when xdp redirects happen on same ring

Pavel Begunkov (3):
      io_uring: fix memory leak of uid in files registration
      io_uring: nospec index for tags on files update
      io_uring: don't touch scm_fp_list after queueing skb

Pavel Kubelun (1):
      ARM: dts: qcom: ipq4019: fix sleep clock

Pavel Skripkin (8):
      udmabuf: validate ubuf->pagecount
      Bluetooth: hci_serdev: call init_rwsem() before p->open()
      ath9k_htc: fix uninit value bugs
      net: asix: add proper error handling of usb read errors
      Bluetooth: hci_uart: add missing NULL check in h5_enqueue
      jfs: fix divide error in dbNextAG
      media: Revert "media: em28xx: add missing em28xx_close_extension"
      can: mcba_usb: properly check endpoint type

Pawan Gupta (2):
      x86/pm: Save the MSR validity status at context setup
      x86/speculation: Restore speculation related MSRs during S3 resume

Pawel Laszczak (1):
      usb: cdnsp: fix cdnsp_decode_trb function to properly handle ret value

Peiwei Hu (1):
      media: ir_toy: free before error exiting

Pekka Pessi (1):
      mailbox: tegra-hsp: Flush whole channel

Peng Li (1):
      net: hns3: clean residual vf config after disable sriov

Peng Liu (1):
      kunit: make kunit_test_timeout compatible with comment

Peter Gonda (2):
      crypto: ccp - Ensure psp_ret is always init'd in __sev_platform_init_locked()
      KVM: SVM: Fix kvm_cache_regs.h inclusions for is_guest_mode()

Peter Rosin (1):
      i2c: mux: demux-pinctrl: do not deactivate a master that is not active

Peter Xu (1):
      mm: don't skip swap entry even if zap_details specified

Peter Zijlstra (2):
      x86: Annotate call_on_stack()
      x86,static_call: Fix __static_call_return0 for i386

Petr Machata (1):
      af_netlink: Fix shift out of bounds in group mask calculation

Petr Vorel (1):
      crypto: vmx - add missing dependencies

Phil Auld (1):
      arch/arm64: Fix topology initialization for core scheduling

Phil Sutter (1):
      netfilter: conntrack: Add and use nf_ct_set_auto_assign_helper_warned()

Philip Yang (1):
      drm/amdkfd: Don't take process mutex for svm ioctls

Phillip Potter (1):
      staging: r8188eu: convert DBG_88E_LEVEL call in hal/rtl8188e_hal_init.c

Pierre Gondois (1):
      cpufreq: CPPC: Fix performance/frequency conversion

Pin-Yen Lin (1):
      drm/bridge: anx7625: Fix overflow issue on reading EDID

Po Liu (1):
      net:enetc: allocate CBD ring data memory using DMA coherent methods

Prashant Malani (1):
      platform/chrome: cros_ec_typec: Check for EC device

Qais Yousef (2):
      sched/core: Export pelt_thermal_tp
      sched/uclamp: Fix iowait boost escaping uclamp restriction

Qi Liu (1):
      scsi: hisi_sas: Free irq vectors in order for v3 HW

Qinghua Jin (1):
      minix: fix bug when opening a file with O_DIRECT

Qu Wenruo (1):
      btrfs: verify the tranisd of the to-be-written dirty extent buffer

Quentin Schulz (1):
      clk: rockchip: re-add rational best approximation algorithm to the fractional divider

Quinn Tran (11):
      scsi: qla2xxx: Fix stuck session in gpdb
      scsi: qla2xxx: Fix warning message due to adisc being flushed
      scsi: qla2xxx: Fix scheduling while atomic
      scsi: qla2xxx: Fix premature hw access after PCI error
      scsi: qla2xxx: edif: Fix clang warning
      scsi: qla2xxx: Fix disk failure to rediscover
      scsi: qla2xxx: Fix incorrect reporting of task management failure
      scsi: qla2xxx: Fix hang due to session stuck
      scsi: qla2xxx: Fix N2N inconsistent PLOGI
      scsi: qla2xxx: Fix stuck session of PRLI reject
      scsi: qla2xxx: Reduce false trigger to login

Rafael J. Wysocki (3):
      Revert "ACPI: Pass the same capabilities to the _OSC regardless of the query flag"
      ACPICA: Avoid walking the ACPI Namespace if it is not there
      ACPI: CPPC: Avoid out of bounds access when parsing _CPC data

Rafał Miłecki (2):
      arm64: dts: broadcom: bcm4908: use proper TWD binding
      phy: phy-brcm-usb: fixup BCM4908 support

Rajneesh Bhardwaj (1):
      drm/amdgpu: Fix recursive locking warning

Randy Dunlap (25):
      hv: utils: add PTP_1588_CLOCK to Kconfig to fix build
      EVM: fix the evm= __setup handler return value
      PM: hibernate: fix __setup handler error handling
      PM: suspend: fix return value of __setup handler
      ACPI: APEI: fix return value of __setup handlers
      clocksource: acpi_pm: fix return value of __setup handler
      printk: fix return value of printk.devkmsg __setup handler
      m68k: coldfire/device.c: only build for MCF_EDMA when h/w macros are defined
      TOMOYO: fix __setup handlers return values
      mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
      MIPS: RB532: fix return value of __setup handler
      dma-debug: fix return value of __setup handlers
      tty: hvc: fix return value of __setup handler
      kgdboc: fix return value of __setup handler
      kgdbts: fix return value of __setup handler
      driver core: dd: fix return value of __setup handler
      net: sparx5: depends on PTP_1588_CLOCK_OPTIONAL
      net: sparx5: uses, depends on BRIDGE or !BRIDGE
      mm/mmap: return 1 from stack_guard_gap __setup() handler
      ARM: 9187/1: JIVE: fix return value of __setup handler
      mm/memcontrol: return 1 from cgroup.memory __setup() handler
      mm/usercopy: return 1 from hardened_usercopy __setup() handler
      scsi: aha152x: Fix aha152x_setup() __setup handler return value
      init/main.c: return 1 from handled __setup() functions
      virtio_console: eliminate anonymous module_init & module_exit

Ray Jui (1):
      bnxt_en: Prevent XDP redirect from running when stopping TX queue

Reto Buerki (1):
      x86/msi: Fix msi message data shadow struct

Richard Guy Briggs (1):
      audit: log AUDIT_TIME_* records only from rules

Richard Haines (1):
      selinux: allow FIOCLEX and FIONCLEX with policy capability

Richard Leitner (1):
      ARM: tegra: tamonten: Fix I2C3 pad setting

Richard Schleich (2):
      ARM: dts: bcm2837: Add the missing L1/L2 cache information
      ARM: dts: bcm2711: Add the missing L1/L2 cache information

Rik van Riel (2):
      mm: invalidate hwpoison page cache page in fault path
      mm,hwpoison: unmap poisoned page before invalidation

Ritesh Harjani (3):
      ext4: fix ext4_fc_stats trace point
      ext4: correct cluster len and clusters changed accounting in ext4_mb_mark_bb
      ext4: fix ext4_mb_mark_bb() with flex_bg with fast_commit

Rob Clark (1):
      drm/msm/a6xx: Fix missing ARRAY_SIZE() check

Rob Herring (1):
      arm64: dts: rockchip: Fix SDIO regulator supply properties on rk3399-firefly

Robert Hancock (6):
      ASoC: xilinx: xlnx_formatter_pcm: Handle sysclk setting
      ASoC: simple-card-utils: Set sysclk on all components
      net: phy: at803x: move page selection fix to config_init
      i2c: xiic: Make bus names unique
      net: axienet: fix RX ring refill allocation failure handling
      pps: clients: gpio: Propagate return value from pps_gpio_probe

Robert Marko (1):
      clk: qcom: ipq8074: fix PCI-E clock oops

Robin Gong (2):
      mailbox: imx: fix crash in resume on i.mx8ulp
      mailbox: imx: fix wakeup failure from freeze mode

Robin Murphy (1):
      iommu/iova: Improve 32-bit free space estimate

Rohith Surabattula (1):
      Adjust cifssb maximum read size

Roman Li (1):
      drm/amd/display: Add affected crtcs to atomic state for dsc mst unplug

Ronnie Sahlberg (2):
      cifs: fix handlecache and multiuser
      cifs: we do not need a spinlock around the tree access during umount

Rotem Saado (1):
      iwlwifi: yoyo: remove DBGI_SRAM address reset writing

Sakari Ailus (3):
      ACPI: properties: Consistently return -ENOENT if there are no more references
      media: v4l: Avoid unaligned access warnings when printing 4cc modifiers
      media: ov5648: Don't pack controls struct

Sam Protsenko (1):
      pinctrl: samsung: Remove EINT handler for Exynos850 ALIVE and CMGP gpios

Sascha Hauer (1):
      clk: rockchip: drop CLK_SET_RATE_PARENT from dclk_vop* on rk3568

Saurav Kashyap (3):
      scsi: qla2xxx: Implement ref count for SRB
      scsi: qla2xxx: Suppress a kernel complaint in qla_create_qpair()
      scsi: qla2xxx: Add qla2x00_async_done() for async routines

Scott Mayhew (1):
      selinux: Fix selinux_sb_mnt_opts_compat()

Sean Christopherson (3):
      KVM: x86/mmu: Move "invalid" check out of kvm_tdp_mmu_get_root()
      KVM: x86/mmu: Zap _all_ roots when unmapping gfn range in TDP MMU
      KVM: x86/mmu: Check for present SPTE when clearing dirty bit in TDP MMU

Sean Nyekjaer (1):
      mtd: rawnand: protect access to rawnand devices while in suspend

Sean Young (1):
      media: gpio-ir-tx: fix transmit with long spaces on Orange Pi PC

Sebastian Andrzej Siewior (2):
      tcp: Don't acquire inet_listen_hashbucket::lock with disabled BH.
      sched: Teach the forced-newidle balancer about CPU affinity limitation.

Shannon Nelson (2):
      ionic: fix type complaint in ionic_dev_cmd_clean()
      ionic: start watchdog after all is setup

Shawn Guo (1):
      PM: domains: Fix sleep-in-atomic bug caused by genpd_debug_remove()

Shengjiu Wang (2):
      ASoC: fsl_spdif: Disable TX clock when stop
      ASoC: soc-core: skip zero num_dai component in searching dai name

Shijith Thotton (1):
      crypto: octeontx2 - remove CONFIG_DM_CRYPT check

Shin'ichiro Kawasaki (1):
      block: limit request dispatch loop duration

Shirish S (1):
      amd/display: set backlight only if required

Shreeya Patel (1):
      gpio: Restrict usage of GPIO chip irq members before initialization

Si-Wei Liu (1):
      vdpa/mlx5: should verify CTRL_VQ feature exists for MQ

Sondhauß, Jan (1):
      drivers: ethernet: cpsw: fix panic when interrupt coaleceing is set via ethtool

Souptick Joarder (HPE) (1):
      irqchip/nvic: Release nvic_base upon failure

Sourabh Jain (1):
      powerpc: Set crashkernel offset to mid of RMA region

Sreekanth Reddy (3):
      scsi: mpt3sas: Fix incorrect 4GB boundary check
      scsi: mpi3mr: Fix reporting of actual data transfer size
      scsi: mpi3mr: Fix memory leaks

Srinivas Kandagatla (7):
      ASoC: codecs: rx-macro: fix accessing compander for aux
      ASoC: codecs: rx-macro: fix accessing array out of bounds for enum type
      ASoC: codecs: va-macro: fix accessing array out of bounds for enum type
      ASoC: codecs: wc938x: fix accessing array out of bounds for enum type
      ASoC: codecs: wcd938x: fix kcontrol max values
      ASoC: codecs: wcd934x: fix kcontrol max values
      ASoC: codecs: wcd934x: fix return value of wcd934x_rx_hph_mode_put

Srinivas Pandruvada (1):
      thermal: int340x: Increase bitmap size

Stanimir Varbanov (2):
      media: venus: hfi_cmds: List HDR10 property as unsupported for v1 and v3
      media: venus: venc: Fix h264 8x8 transform control

Stefan Wahren (2):
      staging: vchiq_arm: Avoid NULL ptr deref in vchiq_dump_platform_instances
      staging: vchiq_core: handle NULL result of find_service_by_handle

Stefano Garzarella (4):
      tools/virtio: fix virtio_test execution
      vsock/virtio: initialize vdev->priv before using VQs
      vsock/virtio: read the negotiated features before using VQs
      vsock/virtio: enable VQs early on probe

Steven Rostedt (Google) (3):
      tracing: Have trace event string test handle zero length strings
      tracing: Have TRACE_DEFINE_ENUM affect trace event types as well
      tracing: Have type enum modifications copy the strings

Sukadev Bhattiprolu (1):
      ibmvnic: fix race between xmit and reset

Sungup Moon (1):
      nvme: allow duplicate NSIDs for private namespaces

Sunil Goutham (1):
      hwrng: cavium - Check health status while reading random data

Suravee Suthikulpanit (1):
      KVM: SVM: Allow AVIC support on system w/ physical APIC ID > 255

Sven Eckelmann (1):
      macvtap: advertise link netns via netlink

Sven Peter (1):
      usb: typec: tipd: Forward plug orientation to typec subsystem

Taehee Yoo (2):
      net: sfc: add missing xdp queue reinitialization
      net: sfc: fix using uninitialized xdp tx_queue

Takashi Iwai (2):
      ALSA: pcm: Fix potential AB/BA lock with buffer_mutex and mmap_lock
      iwlwifi: mvm: Don't call iwl_mvm_sta_from_mac80211() with NULL sta

Takashi Sakamoto (1):
      ALSA: firewire-lib: fix uninitialized flag for AV/C deferred transaction

Taniya Das (2):
      clk: qcom: clk-rcg2: Update logic to calculate D value for RCG
      clk: qcom: clk-rcg2: Update the frac table for pixel clock

Tedd Ho-Jeong An (1):
      Bluetooth: btintel: Fix WBS setting for Intel legacy ROM products

Tejun Heo (4):
      block: don't merge across cgroup boundaries if blkcg is enabled
      selftests: cgroup: Make cg_create() use 0755 for permission instead of 0644
      selftests: cgroup: Test open-time credential usage for migration checks
      selftests: cgroup: Test open-time cgroup namespace usage for migration checks

Theodore Ts'o (1):
      ext4: don't BUG if someone dirty pages without asking ext4 first

Thomas Bracht Laumann Jespersen (1):
      scripts/dtc: Call pkg-config POSIXly correct

Thomas Richter (1):
      perf stat: Fix forked applications enablement of counters

Thomas Zimmermann (3):
      fbdev: Hot-unplug firmware fb devices on forced removal
      drm/fb-helper: Mark screen buffers in system memory with FBINFO_VIRTFB
      fbdev: Fix unregistering of framebuffers without device

Tim Gardner (1):
      video: fbdev: nvidiafb: Use strscpy() to prevent buffer overflow

Tobias Waldekranz (1):
      net: dsa: mv88e6xxx: Enable port policy support on 6097

Toke Høiland-Jørgensen (1):
      libbpf: Use dynamically allocated buffer when receiving netlink messages

Tom Rix (7):
      samples/landlock: Fix path_list memory leak
      media: video/hdmi: handle short reads of hdmi info frame.
      drm/amd/pm: return -ENOTSUPP if there is no get_dpm_ultimate_freq function
      qlcnic: dcb: default to returning -EOPNOTSUPP
      octeontx2-af: initialize action variable
      can: mcp251xfd: mcp251xfd_register_get_dev_id(): fix return of error value
      rtc: check if __rtc_read_time was successful

Tomas Paukrt (1):
      crypto: mxs-dcp - Fix scatterlist processing

Tong Zhang (1):
      dax: make sure inodes are flushed before destroy cache

Tony Lindgren (2):
      clk: ti: Preserve node in ti_dt_clocks_register()
      iommu/omap: Fix regression in probe for NULL pointer dereference

Tony Lu (1):
      net/smc: Send directly when TCP_CORK is cleared

Trond Myklebust (14):
      NFS: NFSv2/v3 clients should never be setting NFS_CAP_XATTR
      NFS: Use of mapping_set_error() results in spurious errors
      NFS: Return valid errors from nfs2/3_decode_dirent()
      NFS: Don't loop forever in nfs_do_recoalesce()
      NFSv4/pNFS: Fix another issue with a list iterator pointing to the head
      NFSv4: Protect the state recovery thread against direct reclaim
      SUNRPC: Fix socket waits for write buffer space
      NFS: nfsiod should not block forever in mempool_alloc()
      NFS: Avoid writeback threads getting stuck in mempool_alloc()
      SUNRPC: Handle ENOMEM in call_transmit_status()
      SUNRPC: Handle low memory situations in call_status()
      SUNRPC: svc_tcp_sendmsg() should handle errors from xdr_alloc_bvec()
      SUNRPC: Prevent immediate close+reconnect
      SUNRPC: Don't call connect() more than once on a TCP socket

Tsuchiya Yuto (1):
      media: atomisp: fix dummy_ptr check to avoid duplicate active_bo

Tudor Ambarus (2):
      ARM: dts: at91: sama7g5: Remove unused properties in i2c nodes
      ARM: dts: at91: sama5d2: Fix PMERRLOC resource size

Tzung-Bi Shih (1):
      ASoC: mediatek: use of_device_get_match_data()

Ulf Hansson (2):
      mmc: host: Return an error when ->enable_sdio_irq() ops is missing
      mmc: rtsx: Fix build errors/warnings for unused variable

Uwe Kleine-König (3):
      pwm: lpc18xx-sct: Initialize driver data and hardware before pwmchip_add()
      serial: 8250: Fix race condition in RTS-after-send handling
      ARM: mmp: Fix failure to remove sram device

Valentin Schneider (2):
      sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
      sched/tracing: Report TASK_RTLOCK_WAIT tasks as TASK_UNINTERRUPTIBLE

Venkateswara Naralasetty (1):
      ath11k: fix kernel panic during unload/load ath11k modules

Vijay Balakrishna (1):
      arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones

Vijendar Mukunda (1):
      ASoC: amd: vg: fix for pm resume callback sequence

Ville Syrjälä (3):
      drm/i915: Treat SAGV block time 0 as SAGV disabled
      drm/i915: Fix PSF GV point mask when SAGV is not possible
      drm/i915: Reject unsupported TMDS rates on ICL+

Vincent Mailhol (2):
      can: etas_es58x: es58x_fd_rx_event_msg(): initialize rx_event_msg before calling es58x_check_msg_len()
      x86/bug: Prevent shadowing in __WARN_FLAGS

Vinod Koul (2):
      spi: core: add dma_map_dev for __spi_unmap_msg()
      dmaengine: Revert "dmaengine: shdma: Fix runtime PM imbalance on error"

Viresh Kumar (1):
      opp: Expose of-node's name in debugfs

Vitaly Kuznetsov (7):
      KVM: x86: hyper-v: Drop redundant 'ex' parameter from kvm_hv_send_ipi()
      KVM: x86: hyper-v: Drop redundant 'ex' parameter from kvm_hv_flush_tlb()
      KVM: x86: hyper-v: Fix the maximum number of sparse banks for XMM fast TLB flush hypercalls
      KVM: x86: hyper-v: HVCALL_SEND_IPI_EX is an XMM fast hypercall
      KVM: x86: Check lapic_in_kernel() before attempting to set a SynIC irq
      KVM: x86: Avoid theoretical NULL pointer dereference in kvm_irq_delivery_to_apic_fast()
      KVM: x86: Forbid VMM to set SYNIC/STIMER MSRs when SynIC wasn't activated

Vladimir Oltean (2):
      net: dsa: fix panic on shutdown if multi-chip tree failed to probe
      net: enetc: report software timestamping via SO_TIMESTAMPING

Waiman Long (3):
      locking/lockdep: Avoid potential access of invalid memory in lock_class
      locking/lockdep: Iterate lock_classes directly when reading lockdep files
      mm/sparsemem: fix 'mem_section' will never be NULL gcc 12 warning

Wang Hai (2):
      video: fbdev: smscufx: Fix null-ptr-deref in ufx_usb_probe()
      wireguard: socket: free skb in send6 when ipv6 is disabled

Wang Wensheng (1):
      ASoC: imx-es8328: Fix error return code in imx_es8328_probe()

Wang Yufen (5):
      bpf, sockmap: Fix memleak in sk_psock_queue_msg
      bpf, sockmap: Fix memleak in tcp_bpf_sendmsg while sk msg is full
      bpf, sockmap: Fix more uncharged while msg has more_data
      bpf, sockmap: Fix double uncharge the mem of sk_msg
      netlabel: fix out-of-bounds memory accesses

Wayne Chang (2):
      usb: gadget: tegra-xudc: Do not program SPARAM
      usb: gadget: tegra-xudc: Fix control endpoint's definitions

Wei Fu (1):
      bpftool: Only set obj->skeleton on complete success

Wen Gong (1):
      ath10k: fix memory overwrite of the WoWLAN wakeup packet pattern

Will Deacon (1):
      arm64: mm: Drop 'const' from conditional arm64_dma_phys_limit definition

Wolfram Sang (1):
      mmc: renesas_sdhi: don't overwrite TAP settings when HS400 tuning is complete

Xiang Chen (2):
      scsi: hisi_sas: Change permission of parameter prot_mask
      scsi: hisi_sas: Limit users changing debugfs BIST count value

Xiao Yang (1):
      RDMA/rxe: Check the last packet by RXE_END_MASK

Xiaoke Wang (1):
      staging: wfx: fix an error handling in wfx_init_common()

Xiaolong Huang (2):
      virt: acrn: fix a memory leak in acrn_dev_ioctl()
      rxrpc: fix some null-ptr-deref bugs in server_key.c

Xiaomeng Tong (4):
      ALSA: cs4236: fix an incorrect NULL check on list iterator
      net: dsa: bcm_sf2_cfp: fix an incorrect NULL check on list iterator
      scsi: ufs: ufshpb: Fix a NULL check on list iterator
      perf: qcom_l2_pmu: fix an incorrect NULL check on list iterator

Xie Yongji (1):
      virtio-blk: Use blk_validate_block_size() to validate block size

Xin Xiong (3):
      mtd: rawnand: atmel: fix refcount issue in atmel_nand_controller_init
      drm/amd/amdgpu/amdgpu_cs: fix refcount leak of a dma_fence obj
      NFSv4.2: fix reference count leaks in _nfs42_proc_copy_notify()

Xiubo Li (2):
      ceph: fix inode reference leakage in ceph_get_snapdir()
      ceph: fix memory leak in ceph_readdir when note_last_dentry returns error

Xu Kuohai (1):
      libbpf: Skip forward declaration when counting duplicated type names

Yafang Shao (1):
      libbpf: Fix possible NULL pointer dereference when destroying skeleton

Yahu Gao (1):
      block/bfq_wf2q: correct weight to ioprio

Yajun Deng (1):
      RDMA/core: Fix ib_qp_usecnt_dec() called when error

Yake Yang (1):
      Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt

Yaliang Wang (1):
      MIPS: pgalloc: fix memory leak caused by pgd_free()

Yang Guang (4):
      video: fbdev: omapfb: acx565akm: replace snprintf with sysfs_emit
      ptp: replace snprintf with sysfs_emit
      scsi: mvsas: Replace snprintf() with sysfs_emit()
      scsi: bfa: Replace snprintf() with sysfs_emit()

Yang Li (1):
      mt76: mt7615: Fix assigning negative values to unsigned variable

Yann Gautier (1):
      mmc: mmci: stm32: correctly check all elements of sg list

Ye Bin (3):
      ext4: fix fs corruption when tring to remove a non-empty directory with IO error
      nbd: Fix incorrect error handle when first_minor is illegal in nbd_dev_add
      nbd: Fix hungtask when nbd_config_put

Yi Wang (1):
      KVM: SVM: fix panic on out-of-bounds guest IRQ

Yinjun Zhang (1):
      bpftool: Fix the error when lookup in no-btf maps

Yiqing Yao (1):
      drm/amd/pm: enable pm sysfs write for one VF mode

Yong Wu (4):
      media: iommu/mediatek-v1: Free the existed fwspec if the master dev already has
      media: iommu/mediatek: Return ENODEV if the device is NULL
      media: iommu/mediatek: Add device_link between the consumer and the larb devices
      dt-bindings: memory: mtk-smi: No need mediatek,larb-id for mt8167

Yonghong Song (1):
      libbpf: Fix build issue with llvm-readelf

Yonghua Huang (1):
      virt: acrn: obtain pa from VMA with PFNMAP flag

Yonglin Tan (1):
      bus: mhi: pci_generic: Add mru_default for Quectel EM1xx series

Yongzhi Liu (4):
      RDMA/mlx5: Fix memory leak in error flow for subscribe event routine
      drm/amd/display: Fix memory leak
      drm/bridge: Add missing pm_runtime_put_sync
      drm/v3d: fix missing unlock

Yosry Ahmed (1):
      selftests: vm: fix clang build error multiple output files

Yu Kuai (1):
      block, bfq: don't move oom_bfqq

YueHaibing (1):
      video: fbdev: controlfb: Fix COMPILE_TEST build

Yufeng Mo (2):
      net: hns3: format the output of the MAC address
      net: hns3: fix the concurrency between functions reading debugfs

Z. Liu (1):
      video: fbdev: matroxfb: set maxvram of vbG200eW to the same as vbG200 to avoid black screen

Zekun Shen (1):
      ath5k: fix OOB in ath5k_eeprom_read_pcal_info_5111

Zev Weiss (2):
      ARM: dts: Fix OpenBMC flash layout label addresses
      serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port type

Zhang Wensheng (2):
      bfq: fix use-after-free in bfq_dispatch_request
      nbd: fix possible overflow on 'first_minor' in nbd_dev_add()

Zhang Yi (1):
      ext2: correct max file size computing

Zheng Bin (1):
      ASoC: SOF: Intel: Fix build error without SND_SOC_SOF_PCI_DEV

Zheng Yongjun (1):
      net: sparx5: switchdev: fix possible NULL pointer dereference

Zhenzhong Duan (1):
      KVM: x86: Fix emulation in writing cr8

Zheyu Ma (2):
      ethernet: sun: Free the coherent when failing in probing
      video: fbdev: sm712fb: Fix crash in smtcfb_write()

Zhihao Cheng (10):
      ubifs: rename_whiteout: Fix double free for whiteout_ui->data
      ubifs: Fix deadlock in concurrent rename whiteout and inode writeback
      ubifs: Add missing iput if do_tmpfile() failed in rename whiteout
      ubifs: Rename whiteout atomically
      ubifs: Fix 'ui->dirty' race between do_tmpfile() and writeback work
      ubifs: Rectify space amount budget for mkdir/tmpfile operations
      ubifs: setflags: Make dirtied_ino_d 8 bytes aligned
      ubifs: Fix read out-of-bounds in ubifs_wbuf_write_nolock()
      ubifs: Fix to add refcount once page is set private
      ubi: fastmap: Return error code if memory allocation fails in add_aeb()

Zhou Guanghui (1):
      iommu/arm-smmu-v3: fix event handling soft lockup

Zhou Qingyang (3):
      media: ti-vpe: cal: Fix a NULL pointer dereference in cal_ctx_v4l2_init_formats()
      drm/nouveau/acr: Fix undefined behavior in nvkm_acr_hsfw_load_bl()
      drm/amd/display: Fix a NULL pointer dereference in amdgpu_dm_connector_add_common_modes()

Ziyang Xuan (1):
      net/tls: fix slab-out-of-bounds bug in decrypt_internal

dann frazier (1):
      Revert "net/mlx5: Accept devlink user input after driver initialization complete"

kernel test robot (1):
      regulator: qcom_smd: fix for_each_child.cocci warnings

lic121 (1):
      libbpf: Unmap rings when umem deleted
---
Documentation/ABI/testing/sysfs-fs-f2fs            |   1 +
 Documentation/admin-guide/kernel-parameters.txt    |   3 +-
 Documentation/admin-guide/sysctl/kernel.rst        |   1 +
 .../memory-controllers/mediatek,smi-larb.yaml      |   1 -
 .../devicetree/bindings/mtd/nand-controller.yaml   |   4 +-
 .../bindings/pinctrl/microchip,sparx5-sgpio.yaml   |   2 +-
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   2 +-
 Documentation/devicetree/bindings/spi/spi-mxic.txt |   4 +-
 Documentation/devicetree/bindings/usb/usb-hcd.yaml |   2 +-
 Documentation/process/stable-kernel-rules.rst      |  11 +-
 Documentation/sound/hd-audio/models.rst            |   4 +
 Documentation/sphinx/requirements.txt              |   2 +
 Makefile                                           |   2 +-
 arch/Kconfig                                       |   1 +
 arch/alpha/kernel/rtc.c                            |   7 +-
 arch/arc/kernel/process.c                          |   2 +-
 arch/arm/boot/dts/bcm2711.dtsi                     |  50 ++
 arch/arm/boot/dts/bcm2837.dtsi                     |  49 ++
 arch/arm/boot/dts/dra7-l4.dtsi                     |   5 +-
 arch/arm/boot/dts/dra7.dtsi                        |   8 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   3 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   3 +
 arch/arm/boot/dts/imx53-m53menlo.dts               |  29 +-
 arch/arm/boot/dts/imx7-colibri.dtsi                |   4 +-
 arch/arm/boot/dts/imx7-mba7.dtsi                   |   2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   2 +-
 arch/arm/boot/dts/imx7d-pico-hobbit.dts            |   4 +-
 arch/arm/boot/dts/imx7d-pico-pi.dts                |   4 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   4 +-
 arch/arm/boot/dts/imx7s-warp.dts                   |   4 +-
 arch/arm/boot/dts/openbmc-flash-layout-64.dtsi     |   2 +-
 arch/arm/boot/dts/openbmc-flash-layout.dtsi        |   2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   3 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi                |   8 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                     |   6 -
 arch/arm/boot/dts/spear1340.dtsi                   |   6 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   6 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |  22 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   6 +-
 arch/arm/configs/multi_v5_defconfig                |   2 +
 arch/arm/crypto/Kconfig                            |   2 +
 arch/arm/kernel/entry-ftrace.S                     |  51 +-
 arch/arm/kernel/swp_emulate.c                      |   2 +-
 arch/arm/kernel/traps.c                            |   2 +-
 arch/arm/mach-iop32x/include/mach/entry-macro.S    |   2 +-
 arch/arm/mach-iop32x/include/mach/irqs.h           |   2 +-
 arch/arm/mach-iop32x/irq.c                         |   6 +-
 arch/arm/mach-iop32x/irqs.h                        |  60 +--
 arch/arm/mach-mmp/sram.c                           |  22 +-
 arch/arm/mach-mstar/Kconfig                        |   1 +
 arch/arm/mach-s3c/mach-jive.c                      |   6 +-
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi  |   8 +-
 .../arm64/boot/dts/broadcom/northstar2/ns2-svk.dts |   8 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   6 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   6 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  16 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |   4 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |   5 +-
 arch/arm64/boot/dts/ti/k3-am64.dtsi                |   1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   5 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |   1 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   5 +-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi               |   1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   5 +-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi               |   1 +
 arch/arm64/configs/defconfig                       |   2 +-
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/include/asm/module.lds.h                |   6 +-
 arch/arm64/include/asm/spectre.h                   |   3 +-
 arch/arm64/kernel/patching.c                       |   4 +-
 arch/arm64/kernel/proton-pack.c                    |  10 +-
 arch/arm64/kernel/signal.c                         |  10 +-
 arch/arm64/kernel/smp.c                            |   2 +-
 arch/arm64/mm/init.c                               |  36 +-
 arch/arm64/mm/mmu.c                                |  41 +-
 arch/arm64/net/bpf_jit_comp.c                      |  18 +-
 arch/csky/kernel/perf_callchain.c                  |   2 +-
 arch/csky/kernel/signal.c                          |   2 +-
 arch/m68k/coldfire/device.c                        |   6 +-
 arch/microblaze/include/asm/uaccess.h              |  18 +-
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   2 +-
 arch/mips/dec/int-handler.S                        |   6 +-
 arch/mips/dec/prom/Makefile                        |   2 +-
 arch/mips/dec/setup.c                              |   3 +-
 arch/mips/include/asm/dec/prom.h                   |  15 +-
 arch/mips/include/asm/pgalloc.h                    |   6 +
 arch/mips/include/asm/setup.h                      |   2 +-
 arch/mips/kernel/traps.c                           |  22 +-
 arch/mips/mm/tlbex.c                               |  23 +-
 arch/mips/ralink/ill_acc.c                         |   1 +
 arch/mips/rb532/devices.c                          |   6 +-
 arch/nios2/include/asm/uaccess.h                   |  26 +-
 arch/nios2/kernel/signal.c                         |  20 +-
 arch/parisc/include/asm/traps.h                    |   1 +
 arch/parisc/kernel/patch.c                         |  25 +-
 arch/parisc/kernel/traps.c                         |   2 +
 arch/parisc/mm/fault.c                             |  89 ++++
 arch/powerpc/Makefile                              |   2 +-
 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts       |  30 ++
 arch/powerpc/boot/dts/fsl/t1040rdb.dts             |   8 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |   4 +-
 arch/powerpc/include/asm/interrupt.h               |   2 +-
 arch/powerpc/include/asm/io.h                      |  40 +-
 arch/powerpc/include/asm/page.h                    |   6 +-
 arch/powerpc/include/asm/set_memory.h              |  12 +-
 arch/powerpc/include/asm/uaccess.h                 |   3 +
 arch/powerpc/kernel/kvm.c                          |   2 +-
 arch/powerpc/kernel/rtas.c                         |   6 +
 arch/powerpc/kernel/secvar-sysfs.c                 |   9 +-
 arch/powerpc/kexec/core.c                          |  15 +-
 arch/powerpc/kvm/book3s_64_entry.S                 |  10 +-
 arch/powerpc/kvm/book3s_hv.c                       |   5 +-
 arch/powerpc/kvm/powerpc.c                         |   4 +-
 arch/powerpc/lib/sstep.c                           |  12 +-
 arch/powerpc/mm/book3s64/hash_utils.c              |  54 +-
 arch/powerpc/mm/fault.c                            |  14 +-
 arch/powerpc/mm/kasan/kasan_init_32.c              |   3 +-
 arch/powerpc/mm/numa.c                             |   4 +-
 arch/powerpc/mm/pageattr.c                         |  71 +--
 arch/powerpc/mm/pgtable_32.c                       |  24 +-
 arch/powerpc/perf/callchain.h                      |   9 +-
 arch/powerpc/perf/callchain_64.c                   |  27 -
 arch/powerpc/perf/imc-pmu.c                        |   6 +-
 arch/powerpc/platforms/8xx/pic.c                   |   1 +
 arch/powerpc/platforms/Kconfig.cputype             |   3 +-
 arch/powerpc/platforms/powernv/rng.c               |   6 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c         |   4 +
 arch/powerpc/sysdev/fsl_gtm.c                      |   4 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts     |   2 +
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts    |   2 +
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts      |   2 +
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts    |   2 +
 arch/riscv/include/asm/module.lds.h                |   6 +-
 arch/riscv/include/asm/thread_info.h               |  10 +-
 arch/riscv/kernel/perf_callchain.c                 |   6 +-
 arch/riscv/lib/memmove.S                           | 368 +++++++++++---
 arch/sparc/kernel/signal_32.c                      |   2 +-
 arch/um/drivers/mconsole_kern.c                    |   3 +-
 arch/um/include/asm/xor.h                          |   4 +-
 arch/x86/Kconfig                                   |   5 +
 arch/x86/events/intel/core.c                       |   8 +-
 arch/x86/events/intel/pt.c                         |   2 +-
 arch/x86/include/asm/bug.h                         |   4 +-
 arch/x86/include/asm/irq_stack.h                   |   3 +-
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/include/asm/msi.h                         |  19 +-
 arch/x86/include/asm/perf_event.h                  |   5 +
 arch/x86/kernel/hpet.c                             |   8 +-
 arch/x86/kernel/kvm.c                              |   2 +-
 arch/x86/kernel/static_call.c                      |   5 +-
 arch/x86/kvm/emulate.c                             |  18 +-
 arch/x86/kvm/hyperv.c                              |  96 ++--
 arch/x86/kvm/kvm_emulate.h                         |   1 +
 arch/x86/kvm/lapic.c                               |   9 +-
 arch/x86/kvm/mmu.h                                 |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h                     |  77 ++-
 arch/x86/kvm/mmu/tdp_mmu.c                         |  52 +-
 arch/x86/kvm/mmu/tdp_mmu.h                         |   3 -
 arch/x86/kvm/pmu.c                                 |  18 +-
 arch/x86/kvm/svm/avic.c                            |  17 +-
 arch/x86/kvm/svm/pmu.c                             |   9 +-
 arch/x86/kvm/svm/svm.h                             |   4 +-
 arch/x86/kvm/svm/svm_onhyperv.c                    |   1 -
 arch/x86/kvm/vmx/pmu_intel.c                       |  14 +-
 arch/x86/kvm/x86.c                                 |   9 +-
 arch/x86/mm/tlb.c                                  |  37 +-
 arch/x86/power/cpu.c                               |  21 +-
 arch/x86/xen/pmu.c                                 |  10 +-
 arch/x86/xen/pmu.h                                 |   3 +-
 arch/x86/xen/smp_hvm.c                             |   6 +
 arch/x86/xen/smp_pv.c                              |   2 +-
 arch/x86/xen/time.c                                |  24 +-
 arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi        |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi         |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi          |   4 +-
 arch/xtensa/include/asm/pgtable.h                  |   4 +
 arch/xtensa/include/asm/processor.h                |   4 +-
 arch/xtensa/kernel/jump_label.c                    |   2 +-
 arch/xtensa/mm/tlb.c                               |   6 +
 block/bfq-cgroup.c                                 |   6 +
 block/bfq-iosched.c                                |  31 +-
 block/bfq-wf2q.c                                   |   2 +-
 block/blk-cgroup.c                                 |  10 +-
 block/blk-merge.c                                  |  11 +
 block/blk-mq-sched.c                               |   9 +-
 block/blk-sysfs.c                                  |   8 +-
 block/genhd.c                                      |   2 +-
 crypto/asymmetric_keys/pkcs7_verify.c              |   6 -
 crypto/asymmetric_keys/public_key.c                | 126 +++--
 crypto/asymmetric_keys/x509_public_key.c           |   6 -
 crypto/authenc.c                                   |   2 +-
 crypto/rsa-pkcs1pad.c                              |  11 +-
 crypto/xts.c                                       |   1 +
 drivers/acpi/acpica/nswalk.c                       |   3 +
 drivers/acpi/apei/bert.c                           |  10 +-
 drivers/acpi/apei/erst.c                           |   2 +-
 drivers/acpi/apei/hest.c                           |   2 +-
 drivers/acpi/bus.c                                 |  27 +-
 drivers/acpi/cppc_acpi.c                           |   5 +
 drivers/acpi/property.c                            |   2 +-
 drivers/ata/sata_dwc_460ex.c                       |   6 +-
 drivers/base/dd.c                                  |   2 +-
 drivers/base/memory.c                              |   8 +-
 drivers/base/power/domain.c                        |   2 +-
 drivers/base/power/main.c                          |   6 +-
 drivers/base/power/trace.c                         |   6 +-
 drivers/block/drbd/drbd_int.h                      |   8 +-
 drivers/block/drbd/drbd_nl.c                       |  41 +-
 drivers/block/drbd/drbd_req.c                      |   3 +-
 drivers/block/drbd/drbd_state.c                    |  18 +-
 drivers/block/drbd/drbd_state_change.h             |   8 +-
 drivers/block/loop.c                               |  10 +-
 drivers/block/n64cart.c                            |   2 +-
 drivers/block/nbd.c                                |  40 +-
 drivers/block/virtio_blk.c                         |  12 +-
 drivers/bluetooth/btintel.c                        |  11 +-
 drivers/bluetooth/btintel.h                        |   1 +
 drivers/bluetooth/btmtksdio.c                      |   4 +-
 drivers/bluetooth/btusb.c                          |   6 +
 drivers/bluetooth/hci_h5.c                         |   8 +-
 drivers/bluetooth/hci_serdev.c                     |   3 +-
 drivers/bus/mhi/core/debugfs.c                     |  26 +-
 drivers/bus/mhi/core/init.c                        |  36 +-
 drivers/bus/mhi/core/internal.h                    | 119 ++---
 drivers/bus/mhi/core/main.c                        |  22 +-
 drivers/bus/mhi/core/pm.c                          |   4 +-
 drivers/bus/mhi/pci_generic.c                      |   1 +
 drivers/bus/mips_cdmm.c                            |   1 +
 drivers/char/hw_random/Kconfig                     |   2 +-
 drivers/char/hw_random/atmel-rng.c                 |   1 +
 drivers/char/hw_random/cavium-rng-vf.c             | 194 +++++++-
 drivers/char/hw_random/cavium-rng.c                |  11 +-
 drivers/char/hw_random/nomadik-rng.c               |   4 +-
 drivers/char/tpm/tpm-chip.c                        |  46 +-
 drivers/char/tpm/tpm.h                             |   2 +
 drivers/char/tpm/tpm2-space.c                      |  65 +++
 drivers/char/virtio_console.c                      |  15 +-
 drivers/clk/actions/owl-s700.c                     |   1 +
 drivers/clk/actions/owl-s900.c                     |   2 +-
 drivers/clk/at91/sama7g5.c                         |   8 +-
 drivers/clk/clk-clps711x.c                         |   2 +
 drivers/clk/clk-si5341.c                           |  16 +-
 drivers/clk/clk.c                                  |  40 +-
 drivers/clk/hisilicon/clk-hi3559a.c                |   4 +-
 drivers/clk/imx/clk-imx7d.c                        |   1 -
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |   2 +-
 drivers/clk/loongson1/clk-loongson1c.c             |   1 +
 drivers/clk/qcom/clk-rcg2.c                        |  14 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |  21 +-
 drivers/clk/qcom/gcc-msm8994.c                     |   1 +
 drivers/clk/rockchip/clk-rk3568.c                  |   6 +-
 drivers/clk/rockchip/clk.c                         |   3 +
 drivers/clk/tegra/clk-tegra124-emc.c               |   1 +
 drivers/clk/ti/clk.c                               |  13 +-
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c     |   1 +
 drivers/clocksource/acpi_pm.c                      |   6 +-
 drivers/clocksource/exynos_mct.c                   |  60 ++-
 drivers/clocksource/timer-microchip-pit64b.c       |   2 +-
 drivers/clocksource/timer-of.c                     |   6 +-
 drivers/clocksource/timer-ti-dm-systimer.c         |   4 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  43 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    |   3 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  |   3 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |   3 +
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |   2 +
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |   3 +
 drivers/crypto/amlogic/amlogic-gxl-cipher.c        |   2 +
 drivers/crypto/ccp/ccp-dmaengine.c                 |  16 +
 drivers/crypto/ccp/sev-dev.c                       |   2 +-
 drivers/crypto/ccree/cc_buffer_mgr.c               |   7 +
 drivers/crypto/ccree/cc_cipher.c                   |   2 +-
 drivers/crypto/gemini/sl3516-ce-cipher.c           |   2 +
 drivers/crypto/hisilicon/qm.c                      |   2 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |  16 +-
 drivers/crypto/hisilicon/sec2/sec_main.c           |   8 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |  17 +-
 drivers/crypto/mxs-dcp.c                           |   2 +-
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c   |   1 -
 drivers/crypto/vmx/Kconfig                         |   4 +
 drivers/cxl/core/regs.c                            |   6 +-
 drivers/dax/super.c                                |   1 +
 drivers/dma-buf/udmabuf.c                          |   4 +
 drivers/dma/hisi_dma.c                             |   2 +-
 drivers/dma/idxd/device.c                          |  34 +-
 drivers/dma/idxd/idxd.h                            |  12 +-
 drivers/dma/idxd/init.c                            |   6 +-
 drivers/dma/idxd/registers.h                       |  14 +-
 drivers/dma/idxd/sysfs.c                           |  42 +-
 drivers/dma/sh/shdma-base.c                        |   4 +-
 drivers/firmware/efi/efi-pstore.c                  |   2 +-
 drivers/firmware/google/Kconfig                    |   2 +-
 drivers/firmware/qcom_scm.c                        |   6 -
 drivers/firmware/stratix10-svc.c                   |   2 +-
 drivers/firmware/sysfb_simplefb.c                  |  23 +-
 drivers/fsi/fsi-master-aspeed.c                    |  17 +-
 drivers/fsi/fsi-scom.c                             |  45 +-
 drivers/gpio/gpiolib.c                             |  19 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  11 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   4 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |  24 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  17 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  80 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   3 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   2 +-
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   |  14 -
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  11 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |   8 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h           |   1 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  29 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   3 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                  |   1 +
 drivers/gpu/drm/bridge/nwl-dsi.c                   |  19 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |   2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   5 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   1 +
 drivers/gpu/drm/drm_edid.c                         |  18 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   9 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   6 +
 drivers/gpu/drm/drm_syncobj.c                      |  61 ++-
 drivers/gpu/drm/i915/display/intel_bw.c            |   3 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  13 +-
 drivers/gpu/drm/i915/display/intel_opregion.c      |  15 +
 drivers/gpu/drm/i915/display/intel_pps.c           |   6 +-
 drivers/gpu/drm/i915/display/intel_pps.h           |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   2 +-
 drivers/gpu/drm/i915/intel_pm.c                    |  10 +-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |   8 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |   2 +
 drivers/gpu/drm/imx/parallel-display.c             |   4 +-
 drivers/gpu/drm/meson/Makefile                     |   1 +
 drivers/gpu/drm/meson/meson_drv.c                  |  31 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              | 345 +------------
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         | 370 ++++++++++++++
 drivers/gpu/drm/meson/meson_encoder_hdmi.h         |  12 +
 drivers/gpu/drm/meson/meson_osd_afbcd.c            |  41 +-
 drivers/gpu/drm/meson/meson_osd_afbcd.h            |   1 +
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   5 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   8 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |   3 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   5 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   5 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         |   4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c         |   4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c    |   4 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  26 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c     |   9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gm20b.c    |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp102.c    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c    |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c       |   4 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |   5 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |   2 +-
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c |   4 +-
 drivers/gpu/drm/tegra/dsi.c                        |   4 +-
 drivers/gpu/drm/tiny/simpledrm.c                   |   3 +
 drivers/gpu/drm/v3d/v3d_drv.c                      |   8 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |   6 +-
 drivers/gpu/host1x/dev.c                           |   1 +
 drivers/greybus/svc.c                              |   8 +-
 drivers/hid/hid-logitech-dj.c                      |   1 +
 drivers/hid/hid-thrustmaster.c                     |   2 +
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  32 +-
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c        |  29 +-
 drivers/hv/Kconfig                                 |   1 +
 drivers/hv/channel_mgmt.c                          |   6 +-
 drivers/hv/hv_balloon.c                            |   2 +-
 drivers/hv/vmbus_drv.c                             |   9 +-
 drivers/hwmon/pmbus/pmbus.h                        |   1 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  18 +-
 drivers/hwmon/sch56xx-common.c                     |   2 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   8 +-
 drivers/hwtracing/coresight/coresight-syscfg.c     |   2 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |  26 +-
 drivers/i2c/busses/i2c-meson.c                     |  12 +-
 drivers/i2c/busses/i2c-xiic.c                      |   3 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   5 +-
 drivers/iio/accel/mma8452.c                        |  29 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   2 +
 drivers/iio/afe/iio-rescale.c                      |   8 +-
 drivers/iio/inkern.c                               |  40 +-
 drivers/infiniband/core/cm.c                       |   3 +-
 drivers/infiniband/core/cma.c                      |   2 +-
 drivers/infiniband/core/verbs.c                    |   1 +
 drivers/infiniband/hw/hfi1/mmu_rb.c                |   6 +
 drivers/infiniband/hw/hfi1/verbs.c                 |   3 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |  10 +-
 drivers/infiniband/hw/irdma/hw.c                   |   2 +-
 drivers/infiniband/hw/irdma/i40iw_if.c             |   1 +
 drivers/infiniband/hw/irdma/main.c                 |   1 +
 drivers/infiniband/hw/irdma/main.h                 |   1 +
 drivers/infiniband/hw/irdma/utils.c                |  48 +-
 drivers/infiniband/hw/irdma/verbs.c                |   4 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   4 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   7 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   6 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  10 +-
 drivers/input/input.c                              |   6 -
 drivers/input/touchscreen/zinitix.c                |  44 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   1 +
 drivers/iommu/dma-iommu.c                          | 155 +++---
 drivers/iommu/iova.c                               |   5 +-
 drivers/iommu/ipmmu-vmsa.c                         |   4 +-
 drivers/iommu/mtk_iommu.c                          |  32 +-
 drivers/iommu/mtk_iommu_v1.c                       |  40 +-
 drivers/iommu/omap-iommu.c                         |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  28 +-
 drivers/irqchip/irq-gic-v3.c                       |  14 +-
 drivers/irqchip/irq-gic.c                          |   6 +
 drivers/irqchip/irq-nvic.c                         |   2 +
 drivers/irqchip/qcom-pdc.c                         |   5 +-
 drivers/mailbox/imx-mailbox.c                      |  11 +-
 drivers/mailbox/tegra-hsp.c                        |   5 +
 drivers/md/bcache/btree.c                          |   6 +-
 drivers/md/bcache/writeback.c                      |   6 +-
 drivers/md/dm-core.h                               |   2 +
 drivers/md/dm-crypt.c                              |   2 +-
 drivers/md/dm-integrity.c                          |   6 +-
 drivers/md/dm-ioctl.c                              |   2 +
 drivers/md/dm-rq.c                                 |   7 +-
 drivers/md/dm-stats.c                              |  34 +-
 drivers/md/dm-stats.h                              |  11 +-
 drivers/md/dm.c                                    |  97 ++--
 drivers/media/i2c/adv7511-v4l2.c                   |   2 +-
 drivers/media/i2c/adv7604.c                        |   2 +-
 drivers/media/i2c/adv7842.c                        |   2 +-
 drivers/media/i2c/ov5640.c                         |  14 +-
 drivers/media/i2c/ov5648.c                         |  12 +-
 drivers/media/i2c/ov6650.c                         | 115 +++--
 drivers/media/pci/bt8xx/bttv-driver.c              |   4 +-
 drivers/media/pci/cx88/cx88-mpeg.c                 |   3 +
 drivers/media/pci/ivtv/ivtv-driver.h               |   1 -
 drivers/media/pci/ivtv/ivtv-ioctl.c                |  10 +-
 drivers/media/pci/ivtv/ivtv-streams.c              |  11 +-
 drivers/media/pci/saa7134/saa7134-alsa.c           |   4 +-
 drivers/media/platform/aspeed-video.c              |   9 +-
 drivers/media/platform/atmel/atmel-isc-base.c      |  22 +-
 drivers/media/platform/atmel/atmel-sama7g5-isc.c   |   6 -
 drivers/media/platform/coda/coda-common.c          |   1 +
 drivers/media/platform/davinci/vpif.c              |  12 +-
 drivers/media/platform/imx-jpeg/mxc-jpeg.c         |   7 +-
 drivers/media/platform/meson/ge2d/ge2d.c           |  24 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c  |   2 +
 drivers/media/platform/qcom/camss/camss-csid-170.c |  19 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |  12 +-
 drivers/media/platform/qcom/venus/hfi_cmds.c       |   2 +
 drivers/media/platform/qcom/venus/venc.c           |   4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |   6 +-
 drivers/media/platform/ti-vpe/cal-video.c          |   3 +
 drivers/media/rc/gpio-ir-tx.c                      |  28 +-
 drivers/media/rc/ir_toy.c                          |   2 +-
 drivers/media/test-drivers/vidtv/vidtv_s302m.c     |  17 +-
 drivers/media/usb/em28xx/em28xx-cards.c            |  13 +-
 drivers/media/usb/go7007/s2250-board.c             |  10 +-
 drivers/media/usb/hdpvr/hdpvr-video.c              |   4 +-
 drivers/media/usb/stk1160/stk1160-core.c           |   2 +-
 drivers/media/usb/stk1160/stk1160-v4l.c            |  10 +-
 drivers/media/usb/stk1160/stk1160.h                |   2 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  10 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |  12 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |  53 +-
 drivers/memory/emif.c                              |   8 +-
 drivers/mfd/asic3.c                                |  10 +-
 drivers/mfd/mc13xxx-core.c                         |   4 +-
 drivers/misc/cardreader/alcor_pci.c                |   9 +-
 drivers/misc/habanalabs/common/debugfs.c           |   2 +
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |   2 +-
 drivers/misc/kgdbts.c                              |   4 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/hw-me.c                           |  23 +-
 drivers/misc/mei/interrupt.c                       |  35 +-
 drivers/misc/mei/pci-me.c                          |   1 +
 drivers/mmc/core/block.c                           |  46 +-
 drivers/mmc/core/host.c                            |  15 +-
 drivers/mmc/host/davinci_mmc.c                     |   6 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                |   6 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   4 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  20 +-
 drivers/mmc/host/sdhci-xenon.c                     |  10 -
 drivers/mmc/host/sdhci_am654.c                     |  24 +-
 drivers/mtd/devices/mchp23k256.c                   |  14 +
 drivers/mtd/devices/mchp48l640.c                   |  10 +
 drivers/mtd/nand/onenand/generic.c                 |   7 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c       |  14 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |   3 +
 drivers/mtd/nand/raw/nand_base.c                   |  44 +-
 drivers/mtd/nand/raw/pl35x-nand-controller.c       |   2 +-
 drivers/mtd/ubi/build.c                            |   9 +-
 drivers/mtd/ubi/fastmap.c                          |  28 +-
 drivers/mtd/ubi/vmt.c                              |   8 +-
 drivers/net/bareudp.c                              |  19 +-
 drivers/net/can/m_can/m_can.c                      |   5 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   2 +-
 drivers/net/can/usb/ems_usb.c                      |   1 -
 drivers/net/can/usb/etas_es58x/es58x_fd.c          |   3 +-
 drivers/net/can/usb/mcba_usb.c                     |  27 +-
 drivers/net/can/usb/usb_8dev.c                     |  30 +-
 drivers/net/can/vxcan.c                            |   2 +-
 drivers/net/dsa/bcm_sf2_cfp.c                      |   6 +-
 drivers/net/dsa/microchip/ksz8795_spi.c            |  11 +
 drivers/net/dsa/microchip/ksz9477_spi.c            |  12 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   1 +
 drivers/net/ethernet/8390/mcf8390.c                |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   7 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |  14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h      |   2 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c   |   4 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   5 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   | 128 ++---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  18 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  15 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h |   1 -
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  47 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 234 +++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   4 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  12 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  63 ++-
 drivers/net/ethernet/ibm/ibmvnic.h                 |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  16 +-
 drivers/net/ethernet/intel/ice/ice.h               |   4 +-
 drivers/net/ethernet/intel/ice/ice_idc.c           |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  29 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   6 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   4 -
 drivers/net/ethernet/intel/igb/igb_main.c          |  19 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |  27 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  23 -
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   2 -
 drivers/net/ethernet/microchip/sparx5/Kconfig      |   2 +
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   2 +
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |   4 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |  20 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |  24 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |  29 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.h        |   1 +
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   3 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.h    |  10 +-
 drivers/net/ethernet/sfc/efx_channels.c            | 148 +++---
 drivers/net/ethernet/sfc/rx_common.c               |   3 +
 drivers/net/ethernet/sfc/tx.c                      |   3 +
 drivers/net/ethernet/sfc/tx_common.c               |   2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +-
 drivers/net/ethernet/sun/sunhme.c                  |   6 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c             |   6 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  72 +--
 drivers/net/hamradio/6pack.c                       |   4 +-
 drivers/net/macvtap.c                              |   6 +
 drivers/net/mdio/mdio-mscc-miim.c                  |   6 +
 drivers/net/phy/at803x.c                           |  40 +-
 drivers/net/phy/broadcom.c                         |  21 +
 drivers/net/phy/sfp-bus.c                          |   6 +
 drivers/net/tap.c                                  |   3 +-
 drivers/net/tun.c                                  |   3 +-
 drivers/net/usb/asix.h                             |   4 +-
 drivers/net/usb/asix_common.c                      |  19 +-
 drivers/net/usb/asix_devices.c                     |  21 +-
 drivers/net/vrf.c                                  |  15 +-
 drivers/net/wireguard/queueing.c                   |   3 +-
 drivers/net/wireguard/socket.c                     |   5 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |   2 +-
 drivers/net/wireless/ath/ath10k/wow.c              |   7 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   2 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   2 +-
 drivers/net/wireless/ath/ath11k/pci.c              |  10 +
 drivers/net/wireless/ath/ath5k/eeprom.c            |   3 +
 drivers/net/wireless/ath/ath9k/htc_hst.c           |   5 +
 drivers/net/wireless/ath/carl9170/main.c           |   2 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |   2 +
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  73 +--
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   1 -
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |  31 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   5 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   1 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   3 +
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   3 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   9 +-
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   8 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h   |  11 +-
 drivers/net/wireless/ray_cs.c                      |   6 +
 drivers/nvdimm/region_devs.c                       |   3 +
 drivers/nvme/host/core.c                           |  48 +-
 drivers/nvme/host/multipath.c                      |   7 +-
 drivers/nvme/host/nvme.h                           |  19 +
 drivers/nvme/host/tcp.c                            |  40 ++
 drivers/opp/debugfs.c                              |   5 +
 drivers/opp/opp.h                                  |   1 +
 drivers/parisc/dino.c                              |  41 +-
 drivers/parisc/gsc.c                               |  31 ++
 drivers/parisc/gsc.h                               |   1 +
 drivers/parisc/lasi.c                              |   7 +-
 drivers/parisc/wax.c                               |   7 +-
 drivers/pci/access.c                               |   9 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  10 +-
 drivers/pci/controller/dwc/pcie-fu740.c            |  51 +-
 drivers/pci/controller/pci-aardvark.c              |  29 +-
 drivers/pci/controller/pci-xgene.c                 |  35 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |  14 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |   4 +
 drivers/pci/quirks.c                               |  12 +
 drivers/perf/qcom_l2_pmu.c                         |   6 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |   5 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c             |   9 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c           |  36 ++
 drivers/phy/broadcom/phy-brcm-usb-init.h           |   1 +
 drivers/phy/broadcom/phy-brcm-usb.c                |  11 +-
 drivers/phy/phy-core-mipi-dphy.c                   |   4 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   2 +
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  30 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |   4 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          | 185 ++++---
 drivers/pinctrl/pinconf-generic.c                  |   6 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |  46 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |  22 +
 drivers/pinctrl/pinctrl-rockchip.c                 |   2 +
 drivers/pinctrl/renesas/core.c                     |   5 +-
 drivers/pinctrl/renesas/pfc-r8a77470.c             |   4 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |   2 -
 drivers/pinctrl/samsung/pinctrl-samsung.c          |  30 +-
 drivers/platform/chrome/Makefile                   |   3 +-
 drivers/platform/chrome/cros_ec_sensorhub_ring.c   |   3 +-
 drivers/platform/chrome/cros_ec_sensorhub_trace.h  | 123 +++++
 drivers/platform/chrome/cros_ec_trace.h            |  95 ----
 drivers/platform/chrome/cros_ec_typec.c            |   6 +
 drivers/platform/x86/huawei-wmi.c                  |  13 +-
 drivers/power/reset/gemini-poweroff.c              |   4 +-
 drivers/power/supply/ab8500_chargalg.c             |   4 +-
 drivers/power/supply/ab8500_fg.c                   |   4 +-
 drivers/power/supply/axp20x_battery.c              |  13 +-
 drivers/power/supply/axp288_charger.c              |  14 +-
 drivers/power/supply/bq24190_charger.c             |   7 +-
 drivers/power/supply/sbs-charger.c                 |  18 +-
 drivers/power/supply/wm8350_power.c                |  97 +++-
 drivers/pps/clients/pps-gpio.c                     |   2 +-
 drivers/ptp/ptp_clock.c                            |  11 +-
 drivers/ptp/ptp_sysfs.c                            |   4 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |  20 +-
 drivers/regulator/atc260x-regulator.c              |   1 +
 drivers/regulator/qcom_smd-regulator.c             |   4 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     |  56 ++-
 drivers/regulator/rtq2134-regulator.c              |   1 +
 drivers/remoteproc/qcom_q6v5_adsp.c                |   1 +
 drivers/remoteproc/qcom_q6v5_mss.c                 |  11 +-
 drivers/remoteproc/qcom_wcnss.c                    |   1 +
 drivers/remoteproc/remoteproc_debugfs.c            |   2 +-
 drivers/rtc/interface.c                            |   7 +-
 drivers/rtc/rtc-cmos.c                             |  19 +-
 drivers/rtc/rtc-mc146818-lib.c                     |  48 +-
 drivers/rtc/rtc-pl031.c                            |   6 +-
 drivers/rtc/rtc-wm8350.c                           |  11 +-
 drivers/scsi/aha152x.c                             |   6 +-
 drivers/scsi/bfa/bfad_attr.c                       |  26 +-
 drivers/scsi/fnic/fnic_scsi.c                      |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  70 ++-
 drivers/scsi/libfc/fc_exch.c                       |   1 +
 drivers/scsi/libsas/sas_ata.c                      |   2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |   2 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c                    |   2 +
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  25 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   5 +-
 drivers/scsi/mvsas/mv_init.c                       |   4 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |  50 +-
 drivers/scsi/pm8001/pm8001_sas.c                   |   2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   | 226 +++++----
 drivers/scsi/qla2xxx/qla_attr.c                    |   7 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |   6 +-
 drivers/scsi/qla2xxx/qla_def.h                     |  21 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |  25 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |   4 +-
 drivers/scsi/qla2xxx/qla_gs.c                      | 160 +++---
 drivers/scsi/qla2xxx/qla_init.c                    | 233 +++++----
 drivers/scsi/qla2xxx/qla_inline.h                  |   2 +
 drivers/scsi/qla2xxx/qla_iocb.c                    |  93 +++-
 drivers/scsi/qla2xxx/qla_isr.c                     |   1 +
 drivers/scsi/qla2xxx/qla_mbx.c                     |  29 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |   9 +-
 drivers/scsi/qla2xxx/qla_mr.c                      |  11 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |  22 +
 drivers/scsi/qla2xxx/qla_os.c                      |  32 +-
 drivers/scsi/qla2xxx/qla_sup.c                     |   4 +-
 drivers/scsi/qla2xxx/qla_target.c                  |  14 +-
 drivers/scsi/qla2xxx/qla_tmpl.c                    |   9 +-
 drivers/scsi/scsi_error.c                          |   9 +-
 drivers/scsi/scsi_scan.c                           |   5 +
 drivers/scsi/scsi_transport_fc.c                   |  39 +-
 drivers/scsi/sd.c                                  |   6 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |  39 +-
 drivers/scsi/sr.c                                  |   2 +-
 drivers/scsi/ufs/ufshcd-pci.c                      |  17 +
 drivers/scsi/ufs/ufshcd.c                          |  21 +-
 drivers/scsi/ufs/ufshpb.c                          |  11 +-
 drivers/scsi/zorro7xx.c                            |   2 +
 drivers/soc/mediatek/mtk-pm-domains.c              |   3 +
 drivers/soc/qcom/ocmem.c                           |   1 +
 drivers/soc/qcom/qcom_aoss.c                       |   2 +-
 drivers/soc/qcom/rpmpd.c                           |   3 +
 drivers/soc/ti/wkup_m3_ipc.c                       |   4 +-
 drivers/soundwire/dmi-quirks.c                     |   2 +-
 drivers/soundwire/intel.c                          |   4 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi-mt65xx.c                           |  15 +-
 drivers/spi/spi-mxic.c                             |  28 +-
 drivers/spi/spi-pxa2xx-pci.c                       |  17 +-
 drivers/spi/spi-tegra114.c                         |   4 +
 drivers/spi/spi-tegra20-slink.c                    |   8 +-
 drivers/spi/spi-tegra210-quad.c                    |   2 +
 drivers/spi/spi-zynqmp-gqspi.c                     |   5 +-
 drivers/spi/spi.c                                  |   8 +-
 drivers/staging/iio/adc/ad7280a.c                  |   4 +-
 drivers/staging/media/atomisp/pci/atomisp_acc.c    |  28 +-
 .../media/atomisp/pci/atomisp_gmin_platform.c      |  18 +
 drivers/staging/media/atomisp/pci/hmm/hmm.c        |   7 +-
 drivers/staging/media/hantro/hantro_h1_jpeg_enc.c  |   2 +-
 drivers/staging/media/hantro/hantro_h1_regs.h      |   2 +-
 drivers/staging/media/imx/imx7-mipi-csis.c         |   6 +-
 drivers/staging/media/imx/imx8mq-mipi-csi2.c       |  74 ++-
 drivers/staging/media/meson/vdec/esparser.c        |   7 +-
 drivers/staging/media/meson/vdec/vdec_helpers.c    |   8 +-
 drivers/staging/media/meson/vdec/vdec_helpers.h    |   4 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |   2 +-
 drivers/staging/media/zoran/zoran.h                |   2 +-
 drivers/staging/media/zoran/zoran_card.c           |  86 ++--
 drivers/staging/media/zoran/zoran_device.c         |   7 +-
 drivers/staging/media/zoran/zoran_driver.c         |  18 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |  40 +-
 drivers/staging/mt7621-dts/gbpc2.dts               | 116 ++++-
 drivers/staging/mt7621-dts/mt7621.dtsi             |  26 +-
 drivers/staging/r8188eu/core/rtw_recv.c            |   3 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |   4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   3 +
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |   6 +
 drivers/staging/wfx/main.c                         |   7 +-
 .../intel/int340x_thermal/int3400_thermal.c        |   7 +-
 drivers/tty/hvc/hvc_iucv.c                         |   4 +-
 drivers/tty/mxser.c                                |  15 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   2 +-
 drivers/tty/serial/8250/8250_dma.c                 |  11 +-
 drivers/tty/serial/8250/8250_lpss.c                |  28 +-
 drivers/tty/serial/8250/8250_mid.c                 |  19 +-
 drivers/tty/serial/8250/8250_port.c                |  24 +-
 drivers/tty/serial/kgdboc.c                        |   6 +-
 drivers/tty/serial/samsung_tty.c                   |   5 +-
 drivers/tty/serial/serial_core.c                   |  14 +
 drivers/usb/cdns3/cdnsp-debug.h                    | 305 ++++++------
 drivers/usb/dwc3/dwc3-omap.c                       |   2 +-
 drivers/usb/dwc3/dwc3-pci.c                        |  11 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |  20 +-
 drivers/usb/host/ehci-pci.c                        |   9 +
 drivers/usb/host/xhci-hub.c                        |   5 +-
 drivers/usb/host/xhci-mem.c                        |   2 +-
 drivers/usb/host/xhci.c                            |  20 +-
 drivers/usb/host/xhci.h                            |  14 +-
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/pl2303.c                        |   2 +
 drivers/usb/serial/pl2303.h                        |   3 +
 drivers/usb/serial/usb-serial-simple.c             |   7 +
 drivers/usb/storage/ene_ub6250.c                   | 155 +++---
 drivers/usb/storage/realtek_cr.c                   |   2 +-
 drivers/usb/typec/tipd/core.c                      |   5 +
 drivers/usb/typec/tipd/tps6598x.h                  |   1 +
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                 |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  | 139 +++++-
 drivers/vfio/pci/vfio_pci_core.c                   |  61 +++
 drivers/vfio/pci/vfio_pci_rdwr.c                   |   2 +
 drivers/vhost/iotlb.c                              |   6 +-
 drivers/vhost/net.c                                |   1 +
 drivers/video/fbdev/atafb.c                        |  12 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |  11 +-
 drivers/video/fbdev/cirrusfb.c                     |  16 +-
 drivers/video/fbdev/controlfb.c                    |   2 +
 drivers/video/fbdev/core/fbcvt.c                   |  53 +-
 drivers/video/fbdev/core/fbmem.c                   |  36 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |   2 +-
 drivers/video/fbdev/nvidia/nv_i2c.c                |   2 +-
 .../fbdev/omap2/omapfb/displays/connector-dvi.c    |   1 +
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |   8 +-
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   |   2 +-
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |   4 +-
 drivers/video/fbdev/sm712fb.c                      |  46 +-
 drivers/video/fbdev/smscufx.c                      |   3 +-
 drivers/video/fbdev/udlfb.c                        |   8 +-
 drivers/video/fbdev/w100fb.c                       |  15 +-
 drivers/virt/acrn/hsm.c                            |  20 +-
 drivers/virt/acrn/mm.c                             |  24 +
 drivers/w1/slaves/w1_therm.c                       |   8 +-
 drivers/watchdog/rti_wdt.c                         |   1 +
 drivers/xen/swiotlb-xen.c                          |   2 +-
 fs/binfmt_elf.c                                    |  90 ++--
 fs/binfmt_elf_fdpic.c                              |  18 +-
 fs/btrfs/block-group.c                             |   8 +-
 fs/btrfs/disk-io.c                                 |  26 +-
 fs/btrfs/extent_io.h                               |   2 +-
 fs/btrfs/file-item.c                               |   2 +-
 fs/btrfs/inode.c                                   |  22 +
 fs/btrfs/reflink.c                                 |   7 +-
 fs/btrfs/space-info.c                              |   3 +-
 fs/btrfs/volumes.c                                 |  48 +-
 fs/buffer.c                                        |   8 +-
 fs/ceph/dir.c                                      |  11 +-
 fs/ceph/inode.c                                    |  10 +-
 fs/cifs/cifsfs.c                                   |  14 +-
 fs/cifs/file.c                                     |  10 +
 fs/cifs/smb2ops.c                                  | 130 ++---
 fs/coredump.c                                      |  86 +++-
 fs/exec.c                                          |  26 +-
 fs/ext2/super.c                                    |   6 +-
 fs/ext4/inline.c                                   |   9 +-
 fs/ext4/inode.c                                    |  25 +
 fs/ext4/mballoc.c                                  | 128 +++--
 fs/ext4/namei.c                                    |  10 +-
 fs/f2fs/checkpoint.c                               |   8 +-
 fs/f2fs/compress.c                                 |   5 +-
 fs/f2fs/data.c                                     |   8 +-
 fs/f2fs/debug.c                                    |  18 +-
 fs/f2fs/f2fs.h                                     |   1 +
 fs/f2fs/file.c                                     |   5 +-
 fs/f2fs/gc.c                                       |   4 +-
 fs/f2fs/inode.c                                    |   7 +-
 fs/f2fs/node.c                                     |   6 +-
 fs/f2fs/segment.c                                  |   7 +
 fs/f2fs/super.c                                    |  10 +-
 fs/f2fs/sysfs.c                                    |   2 +-
 fs/file.c                                          |  31 +-
 fs/gfs2/bmap.c                                     |   2 +-
 fs/gfs2/file.c                                     |   2 +-
 fs/gfs2/inode.c                                    |   2 +-
 fs/gfs2/rgrp.c                                     |  10 +-
 fs/gfs2/rgrp.h                                     |   2 +-
 fs/gfs2/super.c                                    |   2 +-
 fs/io_uring.c                                      |  89 ++--
 fs/jffs2/build.c                                   |   4 +-
 fs/jffs2/fs.c                                      |   2 +-
 fs/jffs2/scan.c                                    |   6 +-
 fs/jfs/inode.c                                     |   3 +-
 fs/jfs/jfs_dmap.c                                  |   7 +
 fs/minix/inode.c                                   |   3 +-
 fs/nfs/callback_proc.c                             |  27 +-
 fs/nfs/callback_xdr.c                              |   4 -
 fs/nfs/dir.c                                       |  10 -
 fs/nfs/direct.c                                    |  48 +-
 fs/nfs/file.c                                      |   4 +-
 fs/nfs/inode.c                                     |   1 -
 fs/nfs/internal.h                                  |  17 +
 fs/nfs/nfs2xdr.c                                   |   2 +-
 fs/nfs/nfs3xdr.c                                   |  22 +-
 fs/nfs/nfs42proc.c                                 |   9 +-
 fs/nfs/nfs4file.c                                  |   6 +-
 fs/nfs/nfs4proc.c                                  |   1 +
 fs/nfs/nfs4state.c                                 |  12 +
 fs/nfs/pagelist.c                                  |  11 +-
 fs/nfs/pnfs.c                                      |  11 +
 fs/nfs/pnfs.h                                      |   2 +
 fs/nfs/pnfs_nfs.c                                  |   8 +-
 fs/nfs/proc.c                                      |   1 +
 fs/nfs/write.c                                     |  39 +-
 fs/nfsd/filecache.c                                |   6 +-
 fs/nfsd/nfs4state.c                                |  12 +-
 fs/nfsd/nfsproc.c                                  |   2 +-
 fs/nfsd/xdr.h                                      |   2 +-
 fs/ntfs/inode.c                                    |   4 +
 fs/ocfs2/quota_global.c                            |  23 +-
 fs/ocfs2/quota_local.c                             |   2 -
 fs/proc/bootconfig.c                               |   2 +
 fs/pstore/platform.c                               |  38 +-
 fs/ubifs/dir.c                                     | 238 +++++----
 fs/ubifs/file.c                                    |  14 +-
 fs/ubifs/io.c                                      |  34 +-
 fs/ubifs/ioctl.c                                   |   2 +-
 fs/ubifs/journal.c                                 |  52 +-
 include/drm/drm_connector.h                        |  12 +-
 include/drm/drm_dp_helper.h                        |   2 +-
 include/linux/atomic/atomic-arch-fallback.h        |  38 +-
 include/linux/binfmts.h                            |   3 +
 include/linux/blk-cgroup.h                         |  17 +
 include/linux/coredump.h                           |   5 +-
 include/linux/fb.h                                 |   1 +
 include/linux/gpio/driver.h                        |   9 +
 include/linux/ipv6.h                               |   2 +-
 include/linux/mc146818rtc.h                        |   3 +-
 include/linux/mmzone.h                             |  11 +-
 include/linux/mtd/rawnand.h                        |   2 +
 include/linux/nfs_fs.h                             |  10 +-
 include/linux/nvme.h                               |   1 +
 include/linux/pci.h                                |   1 +
 include/linux/pstore.h                             |   6 +-
 include/linux/randomize_kstack.h                   |  16 +-
 include/linux/sched.h                              |   8 +
 include/linux/serial_core.h                        |   2 +
 include/linux/skbuff.h                             |  28 +-
 include/linux/skmsg.h                              |  13 +-
 include/linux/soc/ti/ti_sci_protocol.h             |   2 +-
 include/linux/stackdepot.h                         |   2 -
 include/linux/stacktrace.h                         |   1 +
 include/linux/static_call.h                        |   5 +-
 include/linux/sunrpc/xdr.h                         |   2 +
 include/linux/sunrpc/xprtsock.h                    |   1 +
 include/linux/swiotlb.h                            |   3 +-
 include/linux/vfio_pci_core.h                      |   9 +
 include/net/arp.h                                  |   1 +
 include/net/bluetooth/bluetooth.h                  |  14 +-
 include/net/net_namespace.h                        |   6 +
 include/net/netfilter/nf_conntrack_helper.h        |   1 +
 include/net/netfilter/nf_flow_table.h              |  18 +
 include/scsi/scsi_device.h                         |   1 +
 include/sound/pcm.h                                |   1 +
 include/trace/events/ext4.h                        |  78 +--
 include/trace/events/rxrpc.h                       |   8 +-
 include/uapi/linux/bpf.h                           |  18 +-
 include/uapi/linux/can/isotp.h                     |  28 +-
 include/uapi/linux/rfkill.h                        |  14 +-
 include/uapi/linux/rseq.h                          |  20 +-
 include/uapi/linux/serial_core.h                   |   3 +
 init/main.c                                        |   8 +-
 kernel/Makefile                                    |   3 +-
 kernel/audit.h                                     |   4 +
 kernel/auditsc.c                                   |  87 +++-
 kernel/bpf/btf.c                                   |  26 +-
 kernel/bpf/stackmap.c                              |  56 +--
 kernel/debug/kdb/kdb_support.c                     |   2 +-
 kernel/dma/debug.c                                 |   4 +-
 kernel/dma/swiotlb.c                               |  24 +-
 kernel/events/core.c                               |   6 +
 kernel/livepatch/core.c                            |   4 +-
 kernel/locking/lockdep.c                           |  38 +-
 kernel/locking/lockdep_internals.h                 |   6 +-
 kernel/locking/lockdep_proc.c                      |  51 +-
 kernel/power/hibernate.c                           |   2 +-
 kernel/power/suspend_test.c                        |   8 +-
 kernel/printk/printk.c                             |   6 +-
 kernel/ptrace.c                                    |  47 +-
 kernel/rcu/rcu_segcblist.h                         |   4 +-
 kernel/resource.c                                  |  41 +-
 kernel/rseq.c                                      |   8 +-
 kernel/sched/core.c                                |   3 +-
 kernel/sched/cpuacct.c                             |   3 +-
 kernel/sched/cpufreq_schedutil.c                   |   1 +
 kernel/sched/deadline.c                            |  12 +-
 kernel/sched/debug.c                               |  10 -
 kernel/sched/fair.c                                |  18 +-
 kernel/sched/rt.c                                  |  32 +-
 kernel/stacktrace.c                                |  30 ++
 kernel/static_call.c                               | 542 +-------------------
 kernel/static_call_inline.c                        | 543 +++++++++++++++++++++
 kernel/trace/trace.c                               |   9 +-
 kernel/trace/trace_events.c                        |  88 ++++
 kernel/watch_queue.c                               |   4 +-
 lib/Kconfig.debug                                  |   3 +-
 lib/Kconfig.ubsan                                  |  13 -
 lib/kunit/try-catch.c                              |   2 +-
 lib/logic_iomem.c                                  |   8 +-
 lib/lz4/lz4_decompress.c                           |   8 +-
 lib/raid6/test/Makefile                            |   4 +-
 lib/raid6/test/test.c                              |   1 -
 lib/stackdepot.c                                   |  24 -
 lib/test_kmod.c                                    |   1 +
 lib/test_lockup.c                                  |  11 +-
 lib/test_ubsan.c                                   |  22 -
 lib/test_xarray.c                                  |  22 +
 lib/vsprintf.c                                     |  51 +-
 lib/xarray.c                                       |   4 +
 localversion-rt                                    |   2 +-
 mm/highmem.c                                       |   4 +-
 mm/kfence/core.c                                   | 156 +++++-
 mm/kfence/kfence.h                                 |   2 +
 mm/kmemleak.c                                      |   9 +-
 mm/madvise.c                                       |   3 +-
 mm/memcontrol.c                                    |   2 +-
 mm/memory.c                                        |  42 +-
 mm/mempolicy.c                                     |   9 +-
 mm/mlock.c                                         |   7 +-
 mm/mmap.c                                          |   2 +-
 mm/mremap.c                                        |   3 +
 mm/page_alloc.c                                    |   9 +-
 mm/rmap.c                                          |  25 +-
 mm/slab.c                                          |   1 +
 mm/usercopy.c                                      |   5 +-
 net/batman-adv/multicast.c                         |   2 +-
 net/bluetooth/hci_conn.c                           |   2 +
 net/bluetooth/hci_event.c                          |   3 +-
 net/bluetooth/l2cap_core.c                         |   1 +
 net/bpf/test_run.c                                 |   4 +-
 net/can/isotp.c                                    |  81 +--
 net/core/dev.c                                     |   3 +-
 net/core/filter.c                                  |  30 +-
 net/core/net_namespace.c                           |  17 +-
 net/core/rtnetlink.c                               |  13 +-
 net/core/skbuff.c                                  |  66 ++-
 net/core/skmsg.c                                   |  17 +-
 net/dsa/dsa2.c                                     |   5 +
 net/ipv4/arp.c                                     |   9 +-
 net/ipv4/fib_frontend.c                            |   5 +-
 net/ipv4/fib_semantics.c                           |   7 +-
 net/ipv4/inet_hashtables.c                         |  48 +-
 net/ipv4/route.c                                   |  18 +-
 net/ipv4/tcp_bpf.c                                 |  14 +-
 net/ipv4/tcp_output.c                              |   5 +-
 net/ipv6/addrconf.c                                |   4 +-
 net/ipv6/ip6_input.c                               |   2 +-
 net/ipv6/ip6mr.c                                   |   8 +-
 net/ipv6/route.c                                   |   2 +-
 net/ipv6/xfrm6_output.c                            |  16 +
 net/key/af_key.c                                   |   2 +-
 net/mac80211/ieee80211_i.h                         |   2 +-
 net/mac80211/main.c                                |  13 +-
 net/mac80211/mesh.c                                |   2 +-
 net/mac80211/mlme.c                                |  15 +-
 net/mac80211/util.c                                |  27 +-
 net/mctp/route.c                                   |   2 +-
 net/netfilter/nf_conntrack_core.c                  |  89 +++-
 net/netfilter/nf_conntrack_helper.c                |   6 +
 net/netfilter/nf_conntrack_proto_tcp.c             |  17 +-
 net/netfilter/nf_flow_table_inet.c                 |  17 +
 net/netfilter/nf_flow_table_ip.c                   |  18 -
 net/netfilter/nft_ct.c                             |   3 +
 net/netlabel/netlabel_kapi.c                       |   2 +
 net/netlink/af_netlink.c                           |   2 +
 net/openvswitch/actions.c                          |   2 +-
 net/openvswitch/conntrack.c                        | 132 ++---
 net/openvswitch/flow_netlink.c                     | 103 +++-
 net/rfkill/core.c                                  |  48 +-
 net/rxrpc/ar-internal.h                            |  15 +-
 net/rxrpc/call_event.c                             |   2 +-
 net/rxrpc/call_object.c                            |  40 +-
 net/rxrpc/net_ns.c                                 |   2 +-
 net/rxrpc/server_key.c                             |   7 +-
 net/sched/act_ct.c                                 |  19 +-
 net/sctp/outqueue.c                                |   6 +-
 net/smc/af_smc.c                                   |   8 +-
 net/smc/smc_core.c                                 |   2 +-
 net/smc/smc_tx.c                                   |  25 +-
 net/smc/smc_tx.h                                   |   1 +
 net/sunrpc/clnt.c                                  |  11 +-
 net/sunrpc/sched.c                                 |  11 +-
 net/sunrpc/svcsock.c                               |   4 +-
 net/sunrpc/xprt.c                                  |  26 +-
 net/sunrpc/xprtrdma/transport.c                    |   6 +-
 net/sunrpc/xprtsock.c                              |  73 ++-
 net/tipc/socket.c                                  |   3 +-
 net/tls/tls_sw.c                                   |   2 +-
 net/unix/af_unix.c                                 |  16 +-
 net/vmw_vsock/virtio_transport.c                   |  11 +-
 net/wireless/scan.c                                |   9 +-
 net/x25/af_x25.c                                   |  11 +-
 net/xdp/xsk.c                                      |  69 ++-
 net/xfrm/xfrm_interface.c                          |   5 +-
 samples/bpf/xdpsock_user.c                         |   5 +-
 samples/landlock/sandboxer.c                       |   1 +
 scripts/Makefile.ubsan                             |   1 -
 scripts/atomic/fallbacks/read_acquire              |  11 +-
 scripts/atomic/fallbacks/set_release               |   7 +-
 scripts/dtc/Makefile                               |   2 +-
 scripts/gcc-plugins/stackleak_plugin.c             |  25 +-
 scripts/mod/modpost.c                              |   2 +-
 security/integrity/evm/evm_main.c                  |   2 +-
 security/keys/keyctl_pkey.c                        |  14 +-
 security/keys/trusted-keys/trusted_core.c          |   6 +-
 security/landlock/syscalls.c                       |   2 +-
 security/security.c                                |  17 +-
 security/selinux/hooks.c                           |  90 ++--
 security/selinux/include/policycap.h               |   1 +
 security/selinux/include/policycap_names.h         |   3 +-
 security/selinux/include/security.h                |   7 +
 security/selinux/selinuxfs.c                       |   2 +
 security/selinux/xfrm.c                            |   2 +-
 security/smack/smack_lsm.c                         |   2 +-
 security/tomoyo/load_policy.c                      |   4 +-
 sound/core/pcm.c                                   |   1 +
 sound/core/pcm_lib.c                               |   9 +-
 sound/core/pcm_native.c                            |  39 +-
 sound/firewire/fcp.c                               |   4 +-
 sound/isa/cs423x/cs4236.c                          |   8 +-
 sound/pci/hda/patch_hdmi.c                         |   8 +-
 sound/pci/hda/patch_realtek.c                      |  15 +-
 sound/soc/amd/vangogh/acp5x-pcm-dma.c              |  68 +--
 sound/soc/atmel/atmel_ssc_dai.c                    |   5 +-
 sound/soc/atmel/mikroe-proto.c                     |  20 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   1 +
 sound/soc/atmel/sam9x5_wm8731.c                    |  13 +-
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/lpass-rx-macro.c                  |  14 +-
 sound/soc/codecs/lpass-tx-macro.c                  |   2 +
 sound/soc/codecs/lpass-va-macro.c                  |   4 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |   2 +
 sound/soc/codecs/msm8916-wcd-analog.c              |  22 +-
 sound/soc/codecs/msm8916-wcd-digital.c             |   5 +-
 sound/soc/codecs/mt6358.c                          |   4 +
 sound/soc/codecs/rk817_codec.c                     |   6 +-
 sound/soc/codecs/rt5663.c                          |   2 +
 sound/soc/codecs/wcd934x.c                         |  12 +-
 sound/soc/codecs/wcd938x.c                         |  10 +-
 sound/soc/codecs/wm8350.c                          |  28 +-
 sound/soc/dwc/dwc-i2s.c                            |  17 +-
 sound/soc/fsl/fsl_spdif.c                          |   2 +
 sound/soc/fsl/imx-es8328.c                         |   1 +
 sound/soc/generic/simple-card-utils.c              |  15 +
 sound/soc/intel/boards/sof_sdw.c                   |   2 +-
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c |   7 +-
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c        |   7 +-
 .../mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c  |  23 +-
 sound/soc/mxs/mxs-saif.c                           |   5 +-
 sound/soc/mxs/mxs-sgtl5000.c                       |   3 +
 sound/soc/rockchip/rockchip_i2s.c                  |  15 +-
 sound/soc/sh/fsi.c                                 |  19 +-
 sound/soc/sh/rz-ssi.c                              |  73 +--
 sound/soc/soc-compress.c                           |   5 +
 sound/soc/soc-core.c                               |   2 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   6 +-
 sound/soc/soc-topology.c                           |   3 +-
 sound/soc/sof/imx/imx8m.c                          |   1 +
 sound/soc/sof/intel/Kconfig                        |   1 +
 sound/soc/sof/intel/hda-loader.c                   |  11 +-
 sound/soc/sof/intel/hda-pcm.c                      |   1 +
 sound/soc/sof/intel/hda.c                          |  15 +-
 sound/soc/ti/davinci-i2s.c                         |   5 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |  25 +
 sound/spi/at73c213.c                               |  27 +-
 tools/bpf/bpftool/gen.c                            |   2 +-
 tools/bpf/bpftool/map.c                            |   6 +-
 tools/build/feature/Makefile                       |   9 +-
 tools/include/uapi/linux/bpf.h                     |   4 +-
 tools/lib/bpf/Makefile                             |   4 +-
 tools/lib/bpf/btf_dump.c                           |  11 +-
 tools/lib/bpf/libbpf.c                             |   3 +
 tools/lib/bpf/netlink.c                            |  63 ++-
 tools/lib/bpf/xsk.c                                |  11 +
 tools/perf/Makefile.config                         |   6 +
 tools/perf/arch/arm64/util/arm-spe.c               |   6 +
 tools/perf/builtin-stat.c                          |   2 +-
 tools/perf/perf.c                                  |   2 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json | 111 +++--
 .../arch/x86/skylakex/floating-point.json          |  24 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |  18 +-
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |  96 ++--
 .../pmu-events/arch/x86/skylakex/pipeline.json     |  11 +
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  | 461 +++++++++++++++--
 .../pmu-events/arch/x86/skylakex/uncore-other.json |  23 +
 tools/perf/util/session.c                          |  15 +-
 tools/perf/util/setup.py                           |   8 +-
 tools/testing/selftests/bpf/prog_tests/bind_perm.c |  20 +-
 .../testing/selftests/bpf/progs/test_map_in_map.c  |   2 +-
 tools/testing/selftests/bpf/progs/test_sk_lookup.c |   3 +-
 .../testing/selftests/bpf/progs/test_sock_fields.c |   2 +-
 .../bpf/progs/test_tcp_check_syncookie_kern.c      |   2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c       |   2 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c          |   2 +-
 .../bpf/progs/test_xdp_adjust_tail_shrink.c        |   4 +-
 .../selftests/bpf/progs/test_xdp_devmap_helpers.c  |   2 +-
 tools/testing/selftests/bpf/progs/test_xdp_link.c  |   2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c  |   2 +-
 .../selftests/bpf/progs/test_xdp_noinline.c        |   4 +-
 .../bpf/progs/test_xdp_with_cpumap_helpers.c       |   4 +-
 .../bpf/progs/test_xdp_with_devmap_helpers.c       |   4 +-
 tools/testing/selftests/bpf/progs/xdp_dummy.c      |   2 +-
 .../selftests/bpf/progs/xdp_redirect_multi_kern.c  |   4 +-
 tools/testing/selftests/bpf/progs/xdping_kern.c    |   4 +-
 tools/testing/selftests/bpf/test_lirc_mode2.sh     |   5 +-
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh   |  10 +-
 .../selftests/bpf/test_tcp_check_syncookie.sh      |   2 +-
 tools/testing/selftests/bpf/test_xdp_redirect.sh   |   4 +-
 .../selftests/bpf/test_xdp_redirect_multi.sh       |  62 +--
 tools/testing/selftests/bpf/test_xdp_veth.sh       |   4 +-
 tools/testing/selftests/bpf/xdping.c               |   5 +-
 tools/testing/selftests/cgroup/cgroup_util.c       |   2 +-
 tools/testing/selftests/cgroup/test_core.c         | 165 +++++++
 tools/testing/selftests/lkdtm/config               |   1 +
 .../testing/selftests/net/af_unix/test_unix_oob.c  |   6 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  19 +
 .../testing/selftests/net/test_vxlan_under_vrf.sh  |   8 +-
 tools/testing/selftests/net/timestamping.c         |   4 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  |   4 +-
 tools/testing/selftests/sgx/Makefile               |   2 +-
 tools/testing/selftests/vm/Makefile                |  12 +-
 tools/testing/selftests/x86/Makefile               |   6 +-
 tools/testing/selftests/x86/check_cc.sh            |   2 +-
 tools/virtio/virtio_test.c                         |   1 +
 virt/kvm/kvm_main.c                                |  15 +-
 1227 files changed, 13639 insertions(+), 7043 deletions(-)
---
