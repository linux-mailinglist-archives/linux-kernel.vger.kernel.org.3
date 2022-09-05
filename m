Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27F75AD958
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiIETAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiIETAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F984DB73;
        Mon,  5 Sep 2022 12:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 330E56124E;
        Mon,  5 Sep 2022 19:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FDC433C1;
        Mon,  5 Sep 2022 19:00:25 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.65-rt49
Date:   Mon, 05 Sep 2022 18:57:14 -0000
Message-ID: <166240423501.1262773.11517961384167065292@puck.lan>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_ABUSE_SURBL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.65-rt49 stable release.

My apologies for the long delay between releases, but I got stalled by
a conflict in the printk system and it's taken me this long to get my
head wrapped around it. Seems I missed the revert  of removing deferred
printk; once I got that in place things went much more smoothly for
the v5.15-rt kernel. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: f9bca13edef20b18c2eb6d77393d9987b8ef083b

Or to build 5.15.65-rt49 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.65.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.65-rt49.patch.xz


Enjoy!
Clark

Changes from v5.15.55-rt48:
---

Aaron Lu (1):
      x86/mm: Use proper mask when setting PUD mapping

Aaron Ma (1):
      Bluetooth: btusb: Add support of IMC Networks PID 0x3568

Adam Borowski (1):
      ACPI: thermal: drop an always true check

Adrian Hunter (4):
      perf tests: Fix Convert perf time to TSC test for hybrid
      perf tools: Fix dso_id inode generation comparison
      perf parse-events: Fix segfault when event parser gets an error
      perf tests: Fix Track with sched_switch test for hybrid case

Ahmad Fatoum (2):
      Bluetooth: hci_bcm: Add BCM4349B1 variant
      dt-bindings: bluetooth: broadcom: Add BCM4349B1 DT binding

Ahmed Zaki (1):
      mac80211: fix a memory leak where sta_info is not freed

Akihiko Odaki (1):
      HID: AMD_SFH: Add a DMI quirk entry for Chromebooks

Al Viro (8):
      fix short copy handling in copy_mc_pipe_to_iter()
      __follow_mount_rcu(): verify that mount_lock remains unchanged
      nios2: page fault et.al. are *not* restartable syscalls...
      nios2: don't leave NULLs in sys_call_table[]
      nios2: traced syscall does need to check the syscall number
      nios2: fix syscall restart checks
      nios2: restarts apply only to the first sigframe we build...
      nios2: add force_successful_syscall_return()

Alan Brady (1):
      i40e: Fix to stop tx_timeout recovery if GLOBR fails

Alejandro Lucero (1):
      sfc: disable softirqs for ptp TX

Alex Deucher (3):
      drm/amdgpu/display: add quirk handling for stutter mode
      drm/amdgpu: fix check in fbdev init
      drm/radeon: fix incorrrect SPDX-License-Identifiers

Alex Elder (1):
      net: ipa: don't assume SMEM is page-aligned

Alexander Aring (1):
      dlm: fix pending remove if msg allocation fails

Alexander Gordeev (10):
      s390/dump: fix old lowcore virtual vs physical address confusion
      s390/maccess: fix semantics of memcpy_real() and its callers
      s390/crash: fix incorrect number of bytes to copy to user space
      s390/zcore: fix race when reading from hardware system area
      s390/dump: fix os_info virtual vs physical address confusion
      s390/smp: cleanup target CPU callback starting
      s390/smp: cleanup control register update routines
      s390/maccess: rework absolute lowcore accessors
      s390/smp: enforce lowcore protection on CPU restart
      Revert "s390/smp: enforce lowcore protection on CPU restart"

Alexander Lobakin (3):
      ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
      x86/olpc: fix 'logical not is only applied to the left hand side'
      iommu/vt-d: avoid invalid memory access via node_online(NUMA_NO_NODE)

Alexander Shishkin (4):
      intel_th: msu: Fix vmalloced buffers
      intel_th: pci: Add Meteor Lake-P support
      intel_th: pci: Add Raptor Lake-S PCH support
      intel_th: pci: Add Raptor Lake-S CPU support

Alexander Stein (6):
      ARM: dts: imx6ul: add missing properties for sram
      ARM: dts: imx6ul: change operating-points to uint32-matrix
      ARM: dts: imx6ul: fix keypad compatible
      ARM: dts: imx6ul: fix csi node compatible
      ARM: dts: imx6ul: fix lcdif node compatible
      ARM: dts: imx6ul: fix qspi node compatible

Alexandre Chartre (2):
      x86/bugs: Report AMD retbleed vulnerability
      x86/bugs: Add AMD retbleed= boot parameter

Alexandru Elisei (1):
      arm64: cpufeature: Allow different PMU versions in ID_DFR0_EL1

Alexei Starovoitov (1):
      bpf: Fix subprog names in stack traces.

Alexey Kardashevskiy (3):
      KVM: Don't null dereference ops->destroy
      powerpc/iommu: Fix iommu_table_in_use for a small default DMA window case
      powerpc/ioda/iommu/debugfs: Generate unique debugfs entries

Alexey Khoroshilov (1):
      crypto: sun8i-ss - fix infinite loop in sun8i_ss_setup_ivs()

Alexey Kodanev (2):
      drm/radeon: fix potential buffer overflow in ni_set_mc_special_registers()
      wifi: iwlegacy: 4965: fix potential off-by-one overflow in il4965_rs_fill_link_cmd()

Alistair Popple (1):
      nouveau/svm: Fix to migrate all requested pages

Allen Ballway (1):
      ALSA: hda/cirrus - support for iMac 12,1 model

Alvin Lee (1):
      drm/amd/display: For stereo keep "FLIP_ANY_FRAME"

Amadeusz Sławiński (1):
      ALSA: info: Fix llseek return value when using callback

Amelie Delaunay (1):
      usb: dwc2: gadget: remove D+ pull-up while no vbus with usb-role-switch

Amit Cohen (1):
      mlxsw: spectrum: Clear PTP configuration after unregistering the netdevice

Amit Kumar Mahapatra (1):
      mtd: rawnand: arasan: Update NAND bus clock instead of system clock

Ammar Faizi (1):
      wifi: wil6210: debugfs: fix uninitialized variable use in `wil_write_file_wmi()`

Anand Jain (2):
      btrfs: replace: drop assert for suspended replace
      btrfs: add info when mount fails due to stale replace target

Andrea Mayer (3):
      seg6: fix skb checksum evaluation in SRH encapsulation/insertion
      seg6: fix skb checksum in SRv6 End.B6 and End.B6.Encaps behaviors
      seg6: bpf: fix skb checksum in bpf_push_seg6_encap()

Andrea Righi (1):
      x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y

Andrei Vagin (2):
      fs: sendfile handles O_NONBLOCK of out_fd
      selftests: kvm: set rax before vmcall

Andrew Cooper (1):
      x86/cpu/amd: Enumerate BTC_NO

Andrew Donnellan (1):
      gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin disabled for a file

Andrey Strachuk (1):
      usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()

Andy Shevchenko (6):
      pinctrl: armada-37xx: Use temporary variable for struct device
      pinctrl: armada-37xx: Make use of the devm_platform_ioremap_resource()
      pinctrl: armada-37xx: Convert to use dev_err_probe()
      serial: 8250_pci: Refactor the loop in pci_ite887x_init()
      serial: 8250_pci: Replace dev_*() by pci_*() macros
      pinctrl: intel: Check against matching data instead of ACPI companion

AngeloGioacchino Del Regno (2):
      media: platform: mtk-mdp: Fix mdp_ipi_comm structure alignment
      rpmsg: mtk_rpmsg: Fix circular locking dependency

Anquan Wu (1):
      libbpf: Fix the name of a reused map

Anshuman Khandual (1):
      drivers/perf: arm_spe: Fix consistency of SYS_PMSCR_EL1.CX

Ansuel Smith (1):
      clk: qcom: clk-krait: unlock spin after mux completion

Antonio Borneo (3):
      genirq: Don't return error on missing optional irq_request_resources()
      drm: adv7511: override i2c address of cec before accessing it
      scripts/gdb: fix 'lx-dmesg' on 32 bits arch

Antony Antony (1):
      xfrm: clone missing x->lastused in xfrm_do_migrate

Ard Biesheuvel (3):
      ARM: 9214/1: alignment: advance IT state after emulating Thumb instruction
      ARM: 9209/1: Spectre-BHB: avoid pr_info() every time a CPU comes out of idle
      ARM: remove some dead code

Armin Wolf (1):
      hwmon: (dell-smm) Add Dell XPS 13 7390 to fan control whitelist

Arnaldo Carvalho de Melo (3):
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      genelf: Use HAVE_LIBCRYPTO_SUPPORT, not the never defined HAVE_LIBCRYPTO

Artem Borisov (1):
      HID: alps: Declare U1_UNICORN_LEGACY support

Arun Easi (7):
      scsi: qla2xxx: Fix discovery issues in FC-AL topology
      scsi: qla2xxx: Fix crash due to stale SRB access around I/O timeouts
      scsi: qla2xxx: Fix excessive I/O error messages by default
      scsi: qla2xxx: Fix losing FCP-2 targets on long port disable with I/Os
      scsi: qla2xxx: Fix losing target when it reappears during delete
      scsi: qla2xxx: Fix losing FCP-2 targets during port perturbation tests
      scsi: qla2xxx: Fix response queue handler reading stale packets

Arun Ramadoss (1):
      net: dsa: microchip: ksz9477: fix fdb_dump last invalid entry

Arunpravin Paneer Selvam (1):
      drm/ttm: Fix dummy res NULL ptr deref bug

Arınç ÜNAL (2):
      pinctrl: ralink: rename MT7628(an) functions to MT76X8
      pinctrl: ralink: rename pinctrl-rt2880 to pinctrl-ralink

Athira Rajeev (1):
      powerpc/perf: Optimize clearing the pending PMI and remove WARN_ON for PMI check in power_pmu_disable

Aurabindo Pillai (1):
      drm/amd/display: Check correct bounds for stream encoder instances for DCN303

Axel Rasmussen (1):
      mm: userfaultfd: fix UFFDIO_CONTINUE on fallocated shmem pages

Aya Levin (1):
      net/mlx5e: Fix wrong application of the LRO state

Badari Pulavarty (1):
      mm/damon/dbgfs: avoid duplicate context directory creation

Baokun Li (4):
      ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h
      ext4: fix use-after-free in ext4_xattr_set_entry
      ext4: correct max_inline_xattr_value_size computing
      ext4: correct the misjudgment in ext4_iget_extra_inode

Bart Van Assche (4):
      blktrace: Trace remapped requests correctly
      RDMA/srpt: Duplicate port name members
      RDMA/srpt: Introduce a reference count in struct srpt_device
      RDMA/srpt: Fix a use-after-free

Basavaraj Natikar (3):
      HID: amd_sfh: Add NULL check for hid device
      HID: amd_sfh: Handle condition of "no sensors"
      pinctrl: amd: Don't save/restore interrupt status and wake status bits

Bean Huo (1):
      nvme: use command_id instead of req->tag in trace_nvme_complete_rq()

Bedant Patnaik (1):
      ALSA: hda/realtek: Add a quirk for HP OMEN 15 (8786) mute LED

Ben Dooks (3):
      riscv: add as-options for modules with assembly compontents
      dmaengine: dw-axi-dmac: do not print NULL LLI during error
      dmaengine: dw-axi-dmac: ignore interrupt if no descriptor

Ben Hutchings (2):
      x86/xen: Fix initialisation in hypercall_page after rethunk
      x86/speculation: Make all RETbleed mitigations 64-bit only

Benjamin Beichler (1):
      um: Remove straying parenthesis

Benjamin Gaignard (1):
      media: hevc: Embedded indexes in RPS

Benjamin Segall (1):
      epoll: autoremove wakers even more aggressively

Bernard Pidoux (1):
      rose: check NULL rose_loopback_neigh->loopback

Bharath SM (1):
      SMB3: fix lease break timeout when multiple deferred close handles for the same file.

Biao Huang (2):
      net: stmmac: fix pm runtime issue in stmmac_dvr_remove()
      net: stmmac: fix unbalanced ptp clock issue in suspend/resume flow

Biju Das (2):
      spi: spi-rspi: Fix PIO fallback on RZ platforms
      ASoC: sh: rz-ssi: Improve error handling in rz_ssi_probe() error path

Bikash Hazarika (2):
      scsi: qla2xxx: Fix incorrect display of max frame size
      scsi: qla2xxx: Zero undefined mailbox IN registers

Bjorn Andersson (2):
      scsi: ufs: core: Drop loglevel of WriteBoost message
      drm/bridge: lt9611uxc: Cancel only driver's work

Bo-Chen Chen (1):
      drm/mediatek: dpi: Remove output format of YUV

Bob Pearson (4):
      RDMA/rxe: Fix deadlock in rxe_do_local_ops()
      RDMA/rxe: Fix mw bind to allow any consumer key portion
      RDMA/rxe: Add memory barriers to kernel queues
      RDMA/rxe: Limit the number of calls to each tasklet

Boqun Feng (1):
      Drivers: hv: balloon: Support status report for larger page sizes

Brian Foster (7):
      xfs: fold perag loop iteration logic into helper function
      xfs: rename the next_agno perag iteration variable
      xfs: terminate perag iteration reliably on agcount
      xfs: fix perag reference leak on iteration race with growfs
      xfs: flush inodegc workqueue tasks before cancel
      xfs: fix soft lockup via spinning in filestream ag selection loop
      s390: fix double free of GS and RI CBs on fork() failure

Brian Norris (1):
      drm/rockchip: vop: Don't crash for invalid duplicate_state()

Bruce Chang (1):
      drm/i915/dg2: Add Wa_22011100796

Bryan O'Donoghue (5):
      clk: qcom: gcc-msm8939: Add missing SYSTEM_MM_NOC_BFDCD_CLK_SRC
      clk: qcom: gcc-msm8939: Fix bimc_ddr_clk_src rcgr base address
      clk: qcom: gcc-msm8939: Add missing system_mm_noc_bfdcd_clk_src
      clk: qcom: gcc-msm8939: Point MM peripherals to system_mm_noc clock
      clk: qcom: gcc-msm8939: Fix weird field spacing in ftbl_gcc_camss_cci_clk

Cameron Williams (1):
      tty: 8250: Add support for Brainboxes PX cards.

Carlos Llamas (1):
      binder: fix redefinition of seq_file attributes

Catalin Marinas (1):
      arm64: kasan: Revert "arm64: mte: reset the page tag in page->flags"

Celeste Liu (1):
      riscv: mmap with PROT_WRITE but no PROT_READ is invalid

Chanho Park (2):
      tty: serial: samsung_tty: set dma burst_size to 1
      phy: samsung: exynosautov9-ufs: correct TSRV register configurations

Chao Liu (1):
      f2fs: fix to remove F2FS_COMPR_FL and tag F2FS_NOCOMP_FL at the same time

Chao Yu (2):
      f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()
      f2fs: fix to do sanity check on segment type in build_sit_entries()

Charlene Liu (1):
      drm/amd/display: avoid doing vm_init multiple time

Charles Keepax (5):
      ASoC: wm5110: Fix DRE control
      ASoC: dapm: Initialise kcontrol data for mux/demux controls
      ASoC: cs47l15: Fix event generation for low power mux control
      ASoC: madera: Fix event generation for OUT1 demux
      ASoC: madera: Fix event generation for rate controls

Chen Lifu (1):
      riscv: lib: uaccess: fix CSR_STATUS SR_SUM bit

Chen Lin (1):
      dpaa2-eth: trace the allocated address instead of page struct

Chen Yu (1):
      sched/fair: Introduce SIS_UTIL to search idle CPU based on sum of util_avg

Chen Zhongjin (4):
      profiling: fix shift too large makes kernel panic
      kprobes: Forbid probing on trampoline and BPF code areas
      locking/csd_lock: Change csdlock_debug from early_param to __setup
      x86/unwind/orc: Unwind ftrace trampolines with correct ORC entry

ChenXiaoSong (1):
      ntfs: fix use-after-free in ntfs_ucsncmp()

Cheng Xu (1):
      RDMA/siw: Fix duplicated reported IW_CM_EVENT_CONNECT_REPLY event

Chenyi Qiang (1):
      x86/bus_lock: Don't assume the init value of DEBUGCTLMSR.BUS_LOCK_DETECT to be zero

Chia-Lin Kao (AceLan) (3):
      net: atlantic: remove deep parameter on suspend/resume functions
      net: atlantic: remove aq_nic_deinit() when resume
      net: atlantic: fix aq_vec index out of range error

Chris Wilson (3):
      drm/i915/gt: Serialize GRDOM access between multiple engine resets
      drm/i915/gt: Serialize TLB invalidates with GT resets
      drm/i915/gt: Skip TLB invalidations once wedged

Christian Brauner (1):
      ntfs: fix acl handling

Christian König (1):
      drm/ttm: fix locking in vmap/vunmap TTM GEM helpers

Christian Lamparter (1):
      ARM: dts: BCM5301X: Add DT for Meraki MR26

Christian Loehle (1):
      mmc: block: Add single read for 4k sector cards

Christian Marangi (1):
      PCI: qcom: Set up rev 2.1.0 PARF_PHY before enabling clocks

Christoffer Sandberg (1):
      ALSA: hda/realtek: Add quirk for Clevo NS50PU, NS70PU

Christoph Hellwig (7):
      btrfs: zoned: fix a leaked bioc in read_zone_info
      nvme: check for duplicate identifiers earlier
      memremap: remove support for external pgmap refcounts
      nvme: don't return an error from nvme_configure_metadata
      nvme: catch -ENODEV from nvme_revalidate_zones again
      block: remove the struct blk_queue_ctx forward declaration
      block: add a bdev_max_zone_append_sectors helper

Christophe JAILLET (17):
      mt76: mt7921: Fix the error handling path of mt7921_pci_probe()
      spi: spi-altera-dfl: Fix an error handling path
      drm/rockchip: Fix an error handling path rockchip_dp_probe()
      hinic: Use the bitmap API when applicable
      wifi: p54: Fix an error handling path in p54spi_probe()
      mtd: rawnand: meson: Fix a potential double free issue
      misc: rtsx: Fix an error handling path in rtsx_pci_probe()
      intel_th: Fix a resource leak in an error handling path
      memstick/ms_block: Fix some incorrect memory allocation
      memstick/ms_block: Fix a memory leak
      ASoC: qcom: q6dsp: Fix an off-by-one in q6adm_alloc_copp()
      mmc: pxamci: Fix another error handling path in pxamci_probe()
      mmc: pxamci: Fix an error handling path in pxamci_probe()
      mmc: meson-gx: Fix an error handling path in meson_mmc_probe()
      perf probe: Fix an error handling path in 'parse_perf_probe_command()'
      stmmac: intel: Add a missing clk_disable_unprepare() call in intel_eth_pci_remove()
      cxl: Fix a memory leak in an error handling path

Christophe Leroy (6):
      powerpc/ptdump: Fix display of RW pages on FSL_BOOK3E
      powerpc/32: Call mmu_mark_initmem_nx() regardless of data block mapping.
      powerpc/32: Do not allow selection of e5500 or e6500 CPUs on PPC32
      powerpc: Fix eh field when calling lwarx on PPC32
      powerpc/32: Set an IBAT covering up to _einittext during init
      powerpc/32: Don't always pass -mcpu=powerpc to the compiler

Christopher Obbard (1):
      um: random: Don't initialise hwrng struct with zero

Chuck Lever (2):
      NFSD: Clean up the show_nf_flags() macro
      SUNRPC: Fix xdr_encode_bool()

Clark Williams (3):
      Merge tag 'v5.15.65' into v5.15-rt
      Revert "printk: remove deferred printing"
      'Linux 5.15.65-rt49'

Claudio Imbrenda (1):
      KVM: s390: pv: leak the topmost page table when destroy fails

Claudiu Beznea (1):
      ASoC: mchp-spdifrx: disable end of block interrupt on failures

Coiby Xu (1):
      ima: force signature verification when CONFIG_KEXEC_SIG is configured

Conor Dooley (4):
      dt-bindings: riscv: fix SiFive l2-cache's cache-sets
      riscv: dts: sifive: Add fu740 topology information
      riscv: dts: canaan: Add k210 topology information
      riscv: traps: add missing prototype

Corentin Labbe (1):
      crypto: sun8i-ss - do not allocate memory when handling hash requests

Cristian Ciocaltea (1):
      spi: amd: Limit max transfer and message size

Csókás Bence (1):
      fec: Fix timer capture timing in `fec_ptp_enable_pps()`

Damien Le Moal (1):
      ata: libata-eh: Add missing command name

Dan Aloni (1):
      sunrpc: fix expiry of auth creds

Dan Carpenter (19):
      drm/i915/gvt: IS_ERR() vs NULL bug in intel_gvt_update_reg_whitelist()
      drm/i915/selftests: fix a couple IS_ERR() vs NULL tests
      net: stmmac: fix leaks in probe
      xfs: prevent a WARN_ONCE() in xfs_ioc_attr_list()
      drm/amdgpu: Off by one in dm_dmub_outbox1_low_irq()
      wifi: rtlwifi: fix error codes in rtl_debugfs_set_write_h2c()
      crypto: sun8i-ss - fix error codes in allocate_flows()
      wifi: wil6210: debugfs: fix info leak in wil_write_file_wmi()
      selftests/bpf: fix a test for snprintf() overflow
      libbpf: fix an snprintf() overflow check
      scsi: qla2xxx: Check correct variable in qla24xx_async_gffid()
      eeprom: idt_89hpesx: uninitialized data in idt_dbgfs_csr_write()
      platform/olpc: Fix uninitialized data in debugfs write
      null_blk: fix ida error handling in null_add_dev()
      kfifo: fix kfifo_to_user() return type
      NTB: ntb_tool: uninitialized heap data in tool_fn_write()
      xen/xenbus: fix return type in xenbus_file_read()
      fs/ntfs3: Don't clear upper bits accidentally in log_replay()
      fs/ntfs3: uninitialized variable in ntfs_set_acl_ex()

Dan Williams (1):
      ACPI: APEI: Fix _EINJ vs EFI_MEMORY_SP

Daniel Borkmann (1):
      bpf: Don't use tnum_range on array range checking for poke descriptors

Daniel Sneddon (1):
      x86/speculation: Add RSB VM Exit protections

Daniel Starke (11):
      tty: n_gsm: fix user open not possible at responder until initiator open
      tty: n_gsm: fix tty registration before control channel open
      tty: n_gsm: fix wrong queuing behavior in gsm_dlci_data_output()
      tty: n_gsm: fix missing timer to handle stalled links
      tty: n_gsm: fix non flow control frames during mux flow off
      tty: n_gsm: fix packet re-transmission without open control channel
      tty: n_gsm: fix race condition in gsmld_write()
      tty: n_gsm: fix resource allocation order in gsm_activate_mux()
      tty: n_gsm: fix wrong T1 retry count handling
      tty: n_gsm: fix DM command
      tty: n_gsm: fix missing corner cases in gsmld_poll()

Daniele Ceraolo Spurio (1):
      drm/i915/uc: correctly track uc_fw init failure

Daniele Palmas (2):
      bus: mhi: host: pci_generic: add Telit FN980 v1 hardware revision
      bus: mhi: host: pci_generic: add Telit FN990

Dario Binacchi (1):
      mtd: rawnand: gpmi: validate controller clock rate

Darrick J. Wong (9):
      xfs: only run COW extent recovery when there are no live extents
      xfs: don't include bnobt blocks when reserving free block pool
      xfs: fix maxlevels comparisons in the btree staging code
      xfs: reserve quota for dir expansion when linking/unlinking files
      xfs: reserve quota for target dir expansion when renaming files
      xfs: remove infinite loop when reserving free block pool
      xfs: always succeed at setting the reserve pool size
      xfs: fix overfilling of reserve pool
      xfs: reject crazy array sizes being fed to XFS_IOC_GETBMAP*

Dave Chinner (3):
      fs/remap: constrain dedupe of EOF blocks
      xfs: run callbacks before waking waiters in xlog_state_shutdown_callbacks
      xfs: drop async cache flushes from CIL commits.

Dave Stevenson (10):
      drm/vc4: plane: Fix margin calculations for the right/bottom edges
      drm/vc4: dsi: Release workaround buffer and DMA
      drm/vc4: dsi: Correct DSI divider calculations
      drm/vc4: dsi: Correct pixel order for DSI0
      drm/vc4: dsi: Register dsi0 as the correct vc4 encoder type
      drm/vc4: dsi: Fix dsi0 interrupt support
      drm/vc4: dsi: Add correct stop condition to vc4_dsi_encoder_disable iteration
      drm/vc4: hdmi: Reset HDMI MISC_CONTROL register
      drm/vc4: hdmi: Correct HDMI timing registers for interlaced modes
      drm/vc4: drv: Adopt the dma configuration from the HVS or V3D component

David Collins (1):
      spmi: trace: fix stack-out-of-bound access in SPMI tracing functions

David Hildenbrand (1):
      mm/hugetlb: fix hugetlb not supporting softdirty tracking

David Howells (4):
      watch_queue: Fix missing rcu annotation
      vfs: Check the truncate maximum size in inode_newsize_ok()
      rxrpc: Fix locking in rxrpc's sendmsg
      smb3: missing inode locks in punch hole

David Jeffery (1):
      scsi: mpt3sas: Stop fw fault watchdog work item during system shutdown

Dawid Lukwinski (1):
      i40e: Fix erroneous adapter reinitialization during recovery process

Demi Marie Obenour (1):
      xen/gntdev: Ignore failure to unmap INVALID_GRANT_HANDLE

Denis V. Lunev (1):
      neigh: fix possible DoS due to net iface start/stop loop

Deren Wu (2):
      mt76: mt7921: fix aggregation subframes setting to HE max
      mt76: mt7921: enlarge maximum VHT MPDU length to 11454

Dietmar Eggemann (1):
      sched/deadline: Merge dl_task_can_attach() and dl_cpu_busy()

Dimitri John Ledkov (1):
      riscv: set default pm_power_off to NULL

Dmitry Baryshkov (5):
      arm64: dts: qcom: sdm630: disable GPU by default
      arm64: dts: qcom: sdm630: fix the qusb2phy ref clock
      arm64: dts: qcom: sdm630: fix gpu's interconnect path
      arm64: dts: qcom: sdm636-sony-xperia-ganges-mermaid: correct sdc2 pinconf
      dt-bindings: clock: qcom,gcc-msm8996: add more GCC clock sources

Dmitry Klochkov (1):
      tools/kvm_stat: fix display of error when multiple processes are found

Dmitry Osipenko (5):
      ARM: 9213/1: Print message about disabled Spectre workarounds only once
      drm/panfrost: Put mapping instead of shmem obj on panfrost_mmu_map_fault_addr() error
      drm/panfrost: Fix shrinker list corruption by madvise IOCTL
      drm/gem: Properly annotate WW context on drm_gem_lock_reservations() error
      drm/shmem-helper: Add missing vunmap on error

Dom Cobley (2):
      drm/vc4: plane: Remove subpixel positioning check
      drm/vc4: hdmi: Avoid full hdmi audio fifo writes

Dominique Martinet (1):
      9p: fix a bunch of checkpatch warnings

Dongli Zhang (1):
      net: tun: split run_ebpf_filter() and pskb_trim() into different "if statement"

Dongliang Mu (1):
      media: pvrusb2: fix memory leak in pvr_probe

Doug Berger (1):
      serial: 8250_bcm7271: Save/restore RTS in suspend/resume

Douglas Anderson (2):
      tracing: Fix sleeping while atomic in kdb ftdump
      drm/dp: Export symbol / kerneldoc fixes for DP AUX bus

Duoming Zhou (6):
      sctp: fix sleep in atomic context bug in timer handlers
      mtd: sm_ftl: Fix deadlock caused by cancel_work_sync in sm_release
      mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv
      staging: rtl8192u: Fix sleep in atomic context bug in dm_fsync_timer_callback
      atm: idt77252: fix use-after-free bugs caused by tst_timer
      nfc: pn533: Fix use-after-free bugs caused by pn532_cmd_timeout

Dusica Milinkovic (1):
      drm/amdgpu: Increase tlb flush timeout for sriov

Egor Vorontsov (2):
      ALSA: usb-audio: Add quirk for Fiero SC-01
      ALSA: usb-audio: Add quirk for Fiero SC-01 (fw v1.0.0)

Eiichi Tsukata (1):
      docs/kernel-parameters: Update descriptions for "mitigations=" param with retbleed

Eli Cohen (1):
      vdpa/mlx5: Initialize CVQ vringh only once

Eric Auger (1):
      ACPI: VIOT: Fix ACS setup

Eric Biggers (1):
      crypto: lib - remove unneeded selection of XOR_BLOCKS

Eric Dumazet (8):
      ipv4/tcp: do not use per netns ctl sockets
      tcp: sk->sk_bound_dev_if once in inet_request_bound_dev_if()
      bpf: Make sure mac_header was set before using it
      net: fix sk_wmem_schedule() and sk_rmem_schedule() errors
      inet: add READ_ONCE(sk->sk_bound_dev_if) in INET_MATCH()
      ipv6: add READ_ONCE(sk->sk_bound_dev_if) in INET6_MATCH()
      net: rose: fix netdev reference changes
      tcp: fix over estimation in sk_forced_mem_schedule()

Eric Farman (1):
      vfio/ccw: Do not change FSM state in subchannel event

Eric Sandeen (1):
      xfs: revert "xfs: actually bump warning counts when we send warnings"

Eric Snowberg (1):
      lockdown: Fix kexec lockdown bypass with ima policy

Eric Whitney (1):
      ext4: fix extent status tree race in writeback error recovery path

Eugen Hristev (2):
      media: atmel: atmel-sama7g5-isc: fix warning in configs without OF
      mmc: sdhci-of-at91: fix set_uhs_signaling rewriting of MC1R

Evan Quan (1):
      drm/amd/pm: add missing ->fini_microcode interface for Sienna Cichlid

Ezequiel Garcia (2):
      media: hantro: postproc: Fix motion vector space size
      media: hantro: Simplify postprocessor

Fabiano Rosas (1):
      KVM: PPC: Book3S HV: Fix "rm_exit" entry in debugfs timings

Fabien Dessenne (1):
      pinctrl: stm32: fix optional IRQ support to gpios

Fabio Estevam (4):
      i2c: mxs: Silence a clang warning
      mmc: mxcmmc: Silence a clang warning
      dmaengine: imx-dma: Cast of_device_get_match_data() with (uintptr_t)
      ASoC: imx-audmux: Silence a clang warning

Fabrice Gasnier (1):
      phy: stm32: fix error return in stm32_usbphyc_phy_init

Fangzhi Zuo (1):
      drm/amd/display: Ignore First MST Sideband Message Return Error

Fawzi Khaber (1):
      iio: fix iio_format_avail_range() printing for none IIO_VAL_INT

Fedor Pchelkin (2):
      can: j1939: j1939_session_destroy(): fix memory leak of skbs
      can: j1939: j1939_sk_queue_activate_next_locked(): replace WARN_ON_ONCE with netdev_warn_once()

Felix Fietkau (2):
      wifi: mac80211: fix queue selection for mesh/OCB interfaces
      mt76: fix use-after-free by removing a non-RCU wcid pointer

Filipe Manana (9):
      btrfs: return -EAGAIN for NOWAIT dio reads/writes on compressed and inline extents
      btrfs: fix lost error handling when looking up extended ref on log replay
      btrfs: put initial index value of a directory in a constant
      btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
      btrfs: fix silent failure when deleting root reference
      btrfs: remove root argument from btrfs_unlink_inode()
      btrfs: remove no longer needed logic for replaying directory deletes
      btrfs: add and use helper for unlinking inode during log replay
      btrfs: fix warning during log replay when bumping inode link count

Florian Fainelli (6):
      ARM: 9216/1: Fix MAX_DMA_ADDRESS overflow
      MIPS: vdso: Utilize __pa() for gic_pfn
      MIPS: Fixed __debug_virt_addr_valid()
      tools/thermal: Fix possible path truncations
      net: phy: Warn about incorrect mdio_bus_phy_resume() state
      net: bcmgenet: Indicate MAC is in charge of PHY PM

Florian Westphal (6):
      netfilter: br_netfilter: do not skip all hooks with 0 priority
      netfilter: nf_queue: do not allow packet truncation below transport header offset
      netfilter: nf_tables: fix null deref due to zeroed list head
      plip: avoid rcu debug splat
      netfilter: ebtables: reject blobs that don't provide all entry points
      testing: selftests: nft_flowtable.sh: use random netns names

Francesco Dolcini (1):
      ASoC: sgtl5000: Fix noise on shutdown/remove

Francis Laniel (1):
      arm64: Do not forget syscall when starting a new thread.

Frank Li (2):
      usb: cdns3 fix use-after-free at workaround 2
      usb: cdns3: fix random warning message when driver load

Frederic Weisbecker (1):
      rcutorture: Fix ksoftirqd boosting timing and iteration

Frieder Schrempf (1):
      regulator: pca9450: Remove restrictions for regulator-name

Fudong Wang (1):
      drm/amd/display: clear optc underflow before turn off odm clock

GONG, Ruiqi (1):
      stack: Declare {randomize_,}kstack_offset to fix Sparse warnings

GUO Zihua (1):
      crypto: arm64/poly1305 - fix a read out-of-bound

Gabriel Fernandez (1):
      ARM: dts: stm32: use the correct clock source for CEC on stm32mp151

Gal Pressman (2):
      net/mlx5e: Fix capability check for updating vnic env counters
      net/mlx5e: Remove WARN_ON when trying to offload an unsupported TLS cipher/version

Gao Chao (1):
      drm/panel: Fix build error when CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m

Gao Xiang (1):
      erofs: avoid consecutive detection for Highmem memory

Gaosheng Cui (1):
      audit: fix potential double free on error path from fsnotify_add_inode_mark

Gavin Shan (1):
      KVM: selftests: Fix target thread to be migrated in rseq_test

Geert Uytterhoeven (5):
      sh: convert nommu io{re,un}map() to static inline functions
      arm64: dts: renesas: beacon: Fix regulator node names
      soc: renesas: r8a779a0-sysc: Fix A2DP1 and A2CV[2357] PDR values
      arm64: dts: renesas: Fix thermal-sensors on single-zone sensors
      netfilter: conntrack: NF_CONNTRACK_PROCFS should no longer default to y

Gerald Schaefer (1):
      s390/mm: do not trigger write fault when vma does not allow VM_WRITE

Giovanni Cabiddu (10):
      crypto: qat - set to zero DH parameters before free
      crypto: qat - use pre-allocated buffers in datapath
      crypto: qat - refactor submission logic
      crypto: qat - add backlog mechanism
      crypto: qat - fix memory leak in RSA
      crypto: qat - remove dma_free_coherent() for RSA
      crypto: qat - remove dma_free_coherent() for DH
      crypto: qat - add param check for RSA
      crypto: qat - add param check for DH
      crypto: qat - re-enable registration of algorithms

Goldwyn Rodrigues (1):
      btrfs: check if root is readonly while setting security xattr

Gowans, James (1):
      mm: split huge PUD on wp_huge_pud fallback

Greg Kroah-Hartman (15):
      Linux 5.15.56
      Linux 5.15.57
      Linux 5.15.58
      ARM: crypto: comment out gcc warning that breaks clang builds
      Linux 5.15.59
      Linux 5.15.60
      Revert "mwifiex: fix sleep in atomic context bugs caused by dev_coredumpv"
      Linux 5.15.61
      Linux 5.15.62
      Linux 5.15.63
      Revert "usbnet: smsc95xx: Fix deadlock on runtime resume"
      Revert "usbnet: smsc95xx: Forward PHY interrupts to PHY driver to avoid polling"
      Linux 5.15.64
      Revert "PCI/portdrv: Don't disable AER reporting in get_port_device_capability()"
      Linux 5.15.65

Grzegorz Siwik (1):
      ice: Ignore EEXIST when setting promisc mode

Guenter Roeck (1):
      lib/list_debug.c: Detect uninitialized lists

Guilherme G. Piccoli (1):
      ACPI: processor/idle: Annotate more functions to live in cpuidle section

Guillaume Ranquet (1):
      drm/mediatek: dpi: Only enable dpi after the bridge is enabled

Guo Mengqi (1):
      spi: synquacer: Add missing clk_disable_unprepare()

Guoqing Jiang (2):
      Revert "md-raid: destroy the bitmap after destroying the thread"
      md: call __md_stop_writes in md_stop

Gwendal Grignou (1):
      iio: cros: Register FIFO callback after sensor is registered

Haibo Chen (3):
      gpio: pca953x: only use single read/write for No AI mode
      gpio: pca953x: use the correct range when do regmap sync
      gpio: pca953x: use the correct register address when regcache sync during init

Hakan Jansson (1):
      Bluetooth: hci_bcm: Add DT compatible for CYW55572

Hangyu Hua (7):
      drm/i915: fix a possible refcount leak in intel_dp_add_mst_connector()
      net: tipc: fix possible refcount leak in tipc_sk_create()
      xfrm: xfrm_policy: fix a possible double xfrm_pols_put() in xfrm_bundle_lookup()
      drm: bridge: sii8620: fix possible off-by-one
      wifi: libertas: Fix possible refcount leak in if_usb_probe()
      dccp: put dccp_qpolicy_full() and dccp_qpolicy_push() in the same lock
      net: 9p: fix refcount leak in p9_read_work() error handling

Hans de Goede (4):
      ACPI: video: Fix acpi_video_handles_brightness_key_presses()
      ASoC: Intel: bytcr_wm5102: Fix GPIO related probe-ordering problem
      ACPI: EC: Remove duplicate ThinkPad X1 Carbon 6th entry from DMI quirks
      ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk

Haowen Bai (1):
      pinctrl: aspeed: Fix potential NULL dereference in aspeed_pinmux_set_mux()

Haoyue Xu (1):
      RDMA/hns: Fix incorrect clearing of interrupt status register

Harald Freudenberger (1):
      s390/archrandom: prevent CPACF trng invocations in interrupt context

Harman Kalra (1):
      octeontx2-af: suppress external profile loading warning

Harshit Mogalapalli (2):
      HID: cp2112: prevent a buffer overflow in cp2112_xfer()
      HID: mcp2221: prevent a buffer overflow in mcp_smbus_write()

Hawkins Jiawei (1):
      net: fix refcount bug in sk_psock_get (2)

Hayden Goodfellow (1):
      drm/amd/display: Fix wrong format specifier in amdgpu_dm.c

Hayes Wang (3):
      r8152: fix a WOL issue
      r8152: fix the units of some registers for RTL8156A
      r8152: fix the RX FIFO settings when suspending

Hector Martin (3):
      ASoC: tas2764: Correct playback volume range
      ASoC: tas2764: Fix amp gain register offset & default
      locking/atomic: Make test_and_*_bit() ordered on failure

Heiner Kallweit (1):
      net: stmmac: work around sporadic tx issue on link-up

Helge Deller (8):
      fbcon: Fix boundary checks for fbcon=vc:n1-n2 parameters
      fbcon: Fix accelerated fbdev scrolling while logo is still shown
      parisc: Fix device names in /proc/iomem
      parisc: Drop pa_swapper_pg_lock spinlock
      parisc: io_pgetevents_time64() needs compat syscall in 32-bit compat mode
      modules: Ensure natural alignment for .altinstructions and __bug_table sections
      parisc: Make CONFIG_64BIT available for ARCH=parisc64 only
      parisc: Fix exception handler for fldw and fstw instructions

Herbert Xu (1):
      af_key: Do not call xfrm_probe_algs in parallel

Hilda Wu (5):
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x04CA:0x4007
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x04C5:0x1675
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0CB8:0xC558
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3587
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3586

Hou Tao (5):
      bpf: Acquire map uref in .init_seq_private for array map iterator
      bpf: Acquire map uref in .init_seq_private for hash map iterator
      bpf: Acquire map uref in .init_seq_private for sock local storage map iterator
      bpf: Acquire map uref in .init_seq_private for sock{map,hash} iterator
      bpf: Check the validity of max_rdwr_access for sock local storage map iterator

Hristo Venev (1):
      be2net: Fix buffer overflow in be_get_module_eeprom

Hsin-Yi Wang (1):
      PM: domains: Ensure genpd_debugfs_dir exists before remove

Huacai Chen (3):
      MIPS: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
      tpm: eventlog: Fix section mismatch for DEBUG_SECTION_MISMATCH
      PCI/ACPI: Guard ARM64-specific mcfg_quirks

Huaxin Lu (1):
      ima: Fix a potential integer overflow in ima_appraise_measurement

Hyunchul Lee (2):
      ksmbd: prevent out of bound read for SMB2_TREE_CONNNECT
      ksmbd: prevent out of bound read for SMB2_WRITE

Ian Rogers (2):
      perf symbol: Fail to read phdr workaround
      perf stat: Clear evsel->reset_group for each stat run

Ido Schimmel (4):
      mlxsw: spectrum_router: Fix IPv4 nexthop gateway indication
      netdevsim: fib: Fix reference count leak on route deletion failure
      devlink: Fix use-after-free after a failed reload
      selftests: forwarding: Fix failing tests with old libnet

Ilpo Järvinen (4):
      serial: stm32: Clear prev values before setting RTS delays
      serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
      serial: 8250: Fix PM usage_count for console handover
      serial: 8250_dw: Store LSR into lsr_saved_flags in dw8250_tx_wait_empty()

Ilya Bakoulin (1):
      drm/amd/display: Fix pixel clock programming

Imre Deak (1):
      drm/dp/mst: Read the extended DPCD capabilities during system resume

Israel Rukshin (1):
      nvme: fix block device naming collision

Ivan Hasenkampf (1):
      ALSA: hda/realtek: Add quirk for HP Spectre x360 15-eb0xxx

Jack Wang (3):
      RDMA/rtrs-srv: Fix modinfo output for stringify
      RDMA/rtrs: Fix warning when use poll mode on client side.
      RDMA/rtrs: Replace duplicate check with is_pollqueue helper

Jacob Keller (1):
      ixgbe: stop resetting SYSTIME in ixgbe_ptp_start_cyclecounter

Jaewon Kim (1):
      page_alloc: fix invalid watermark check on a negative value

Jaewook Kim (1):
      f2fs: do not allow to decompress files have FI_COMPRESS_RELEASED

Jagath Jog J (2):
      iio: accel: bma400: Fix the scale min and max macro values
      iio: accel: bma400: Reordering of header files

Jakub Kicinski (4):
      netdevsim: Avoid allocation warnings triggered from user space
      net: genl: fix error path memory leak in policy dumping
      wifi: rtlwifi: remove always-true condition pointed out by GCC 12
      net: use eth_hw_addr_set() instead of ether_addr_copy()

Jakub Sitnicki (2):
      selftests/bpf: Extend verifier and bpf_sock tests for dst_port loads
      selftests/bpf: Check dst_port only on the client socket

Jamal Hadi Salim (1):
      net_sched: cls_route: disallow handle of 0

James Clark (1):
      perf python: Fix build when PYTHON_CONFIG is user supplied

James Morse (1):
      arm64: errata: Add Cortex-A510 to the repeat tlbi list

James Smart (10):
      scsi: lpfc: Fix EEH support for NVMe I/O
      scsi: lpfc: SLI path split: Refactor lpfc_iocbq
      scsi: lpfc: SLI path split: Refactor fast and slow paths to native SLI4
      scsi: lpfc: SLI path split: Refactor SCSI paths
      scsi: lpfc: Remove extra atomic_inc on cmd_pending in queuecommand after VMID
      scsi: lpfc: Fix locking for lpfc_sli_iocbq_lookup()
      scsi: lpfc: Fix element offset in __lpfc_sli_release_iocbq_s4()
      scsi: lpfc: Resolve some cleanup issues following SLI path refactoring
      scsi: lpfc: Prevent buffer overflow crashes in debugfs with malformed user input
      scsi: lpfc: Fix possible memory leak when failing to issue CMF WQE

Jan Beulich (1):
      x86: drop bogus "cc" clobber from __try_cmpxchg_user_asm()

Jan Kara (7):
      block: fix default IO priority handling again
      mbcache: don't reclaim used entries
      mbcache: add functions to delete entry if unused
      ext2: Add more validity checks for inode counts
      ext4: remove EA inode entry from mbcache on inode eviction
      ext4: unindent codeblock in ext4_xattr_block_set()
      ext4: fix race when reusing xattr blocks

Jann Horn (2):
      mm: Force TLB flush for PFNMAP mappings before unlink_file_vma()
      mm/rmap: Fix anon_vma->degree ambiguity leading to double-reuse

Jason A. Donenfeld (9):
      um: seed rng using host OS rng
      fs: check FMODE_LSEEK to control internal pipe splicing
      wireguard: ratelimiter: use hrtimer in selftest
      wireguard: allowedips: don't corrupt stack when detecting overflow
      crypto: blake2s - remove shash module
      timekeeping: contribute wall clock to rng on time change
      powerpc/powernv/kvm: Use darn for H_RANDOM on Power9
      crypto: lib/blake2s - reduce stack frame usage in self test
      um: add "noreboot" command line option for PANIC_TIMEOUT=-1 setups

Jason Wang (1):
      virtio-net: fix the race between refill work and close

Jason Yan (1):
      scsi: core: Fix warning in scsi_alloc_sgtables()

Javier Martinez Canillas (4):
      firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
      firmware: sysfb: Add sysfb_disable() helper function
      fbdev: Disable sysfb device registration when removing conflicting FBs
      drm/st7735r: Fix module autoloading for Okaya RH128128T

Jean Delvare (1):
      watchdog: sp5100_tco: Fix a memory leak of EFCH MMIO resource

Jean-Philippe Brucker (1):
      uacce: Handle parent device removal or parent driver module rmmod

Jeff Layton (6):
      lockd: set fl_owner when unlocking files
      lockd: fix nlm_close_files
      ceph: switch netfs read ops to use rreq->inode instead of rreq->mapping->host
      nfsd: eliminate the NFSD_FILE_BREAK_* flags
      lockd: detect and reject lock arguments that overflow
      ceph: don't leak snap_rwsem in handle_cap_grant

Jeffrey Hugo (4):
      PCI: hv: Fix multi-MSI to allow more than one MSI vector
      PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
      PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()
      PCI: hv: Fix interrupt mapping for multi-MSI

Jens Axboe (4):
      io_uring: use original request task for inflight tracking
      io_uring: fix issue with io_write() not always undoing sb_start_write()
      io_uring: remove poll entry from list when canceling all
      io_uring: bump poll refs to full 31-bits

Jens Wiklander (1):
      tee: add overflow check in register_shm_helper()

Jeongik Cha (1):
      wifi: mac80211_hwsim: fix race condition in pending packet

Jeremy Sowden (1):
      netfilter: bitwise: improve error goto labels

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP machines

Jernej Skrabec (2):
      media: cedrus: h265: Fix flag name
      media: cedrus: hevc: Add check for invalid timestamp

Jiachen Zhang (1):
      ovl: drop WARN_ON() dentry is NULL in ovl_encode_fh()

Jian Shen (2):
      test_bpf: fix incorrect netdev features
      net: ionic: fix error check for vlan flags in ionic_set_nic_features()

Jian Zhang (2):
      media: driver/nxp/imx-jpeg: fix a unexpected return value problem
      drm/exynos/exynos7_drm_decon: free resources when clk_set_parent() failed.

Jianglei Nie (5):
      ima: Fix potential memory leak in ima_init_crypto()
      net: sfp: fix memory leak in sfp_probe()
      net: macsec: fix potential resource leak in macsec_add_rxsa() and macsec_add_txsa()
      RDMA/qedr: Fix potential memory leak in __qedr_alloc_mr()
      RDMA/hfi1: fix potential memory leak in setup_base_ctxt()

Jianhua Lu (1):
      pinctrl: qcom: sm8250: Fix PDC map

Jiapeng Chong (1):
      io_uring: Remove unused function req_ref_put

Jiasheng Jiang (4):
      drm: bridge: adv7511: Add check for mipi_dsi_driver_register
      Bluetooth: hci_intel: Add check for platform_driver_register
      intel_th: msu-sink: Potential dereference of null pointer
      ASoC: codecs: da7210: add check for i2c_add_driver

Jing Leng (1):
      kbuild: Fix include path in scripts/Makefile.modpost

Jing-Ting Wu (1):
      cgroup: Fix race condition at rebind_subsystems()

Jinghao Jia (1):
      BPF: Fix potential bad pointer dereference in bpf_sys_bpf()

Jinke Han (1):
      block: don't allow the same type rq_qos add more than once

Jiri Slaby (6):
      x86/asm/32: Fix ANNOTATE_UNRET_SAFE use on 32-bit
      tty: drivers/tty/, stop using tty_schedule_flip()
      tty: the rest, stop using tty_schedule_flip()
      tty: drop tty_schedule_flip()
      tty: extract tty_flip_buffer_commit() from tty_flip_buffer_push()
      tty: use new tty_insert_flip_string_and_push_buffer() in pty_write()

Jisheng Zhang (1):
      riscv: lib: uaccess: fold fixups into body

Jitao Shi (2):
      drm/mediatek: Separate poweron/poweroff from enable/disable and define new funcs
      drm/mediatek: Keep dsi as LP00 before dcs cmds transfer

Joe Lawrence (1):
      selftests/livepatch: better synchronize test_klp_callbacks_busy

Johan Hovold (5):
      x86/pmem: Fix platform-device leak in error path
      arm64: dts: qcom: sm8250: add missing PCIe PHY clock-cells
      ath11k: fix netdev open race
      usb: dwc3: qcom: fix missing optional irq warnings
      USB: serial: fix tty-port initialized comments

Johannes Berg (4):
      iwlwifi: fw: uefi: add missing include guards
      um: virtio_uml: Fix broken device handling in time-travel
      wifi: mac80211_hwsim: add back erroneously removed cast
      wifi: mac80211_hwsim: use 32-bit skb cookie

John Allen (1):
      crypto: ccp - Use kzalloc for sev ioctl interfaces to prevent kernel memory leak

John Garry (1):
      scsi: hisi_sas: Limit max hw sectors for v3 HW

John Johansen (5):
      apparmor: fix quiet_denied for file rules
      apparmor: fix absroot causing audited secids to begin with =
      apparmor: Fix failed mount permission check error message
      apparmor: fix setting unconfined mode on a loaded profile
      apparmor: fix overlapping attachment computation

John Keeping (1):
      sched/core: Always flush pending blk_plug

John Ogness (1):
      scripts/gdb: lx-dmesg: read records individually

John Veness (1):
      ALSA: usb-audio: Add quirks for MacroSilicon MS2100/MS2106 devices

Jon Hunter (1):
      net: stmmac: dwc-qos: Disable split header for Tegra194

Jonas Dreßler (1):
      mwifiex: Ignore BTCOEX events from the 88W8897 firmware

Jonathan Toppins (1):
      bonding: 802.3ad: fix no transmission of LACPDUs

Jose Alonso (2):
      net: usb: ax88179_178a needs FLAG_SEND_ZLP
      Revert "net: usb: ax88179_178a needs FLAG_SEND_ZLP"

Jose Ignacio Tornos Martinez (1):
      wifi: iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue

Josef Bacik (6):
      mm: fix page leak with multiple threads mapping the same page
      btrfs: reset block group chunk force if we have to wait
      btrfs: reset RO counter on block group if we fail to relocate
      btrfs: move lockdep class helpers to locking.c
      btrfs: fix lockdep splat with reloc root extent buffers
      btrfs: tree-checker: check for overlapping extent items

Josh Kilmer (1):
      HID: asus: ROG NKey: Ignore portion of 0x5a report

Josh Poimboeuf (13):
      x86/bugs: Do IBPB fallback check only once
      x86/speculation: Fix RSB filling with CONFIG_RETPOLINE=n
      x86/speculation: Fix firmware entry SPEC_CTRL handling
      x86/speculation: Fix SPEC_CTRL write on SMT state change
      x86/speculation: Use cached host SPEC_CTRL value for guest entry/exit
      x86/speculation: Remove x86_spec_ctrl_mask
      objtool: Re-add UNWIND_HINT_{SAVE_RESTORE}
      KVM: VMX: Flatten __vmx_vcpu_run()
      KVM: VMX: Convert launched argument to flags
      KVM: VMX: Prevent guest RSB poisoning attacks with eIBRS
      KVM: VMX: Fix IBRS handling after vmexit
      x86/speculation: Fill RSB on vmexit for IBRS
      scripts/faddr2line: Fix vmlinux detection on arm64

Josip Pavic (1):
      drm/amd/display: Avoid MPC infinite loop

José Expósito (1):
      drm/amd/display: invalid parameter check in dmub_hpd_callback

Jozef Martiniak (1):
      gadgetfs: ep_io - wait until IRQ finishes

Jude Shih (1):
      drm/amd/display: Support for DMUB HPD interrupt handling

Juergen Gross (5):
      xen/netback: avoid entering xenvif_rx_next_skb() with an empty rx queue
      x86: Clear .brk area at early boot
      x86/pat: Fix x86_has_pat_wp()
      xen/privcmd: fix error exit of privcmd_ioctl_dm_op()
      s390/hypfs: avoid error message under KVM

Julien STEPHAN (1):
      drm/mediatek: Allow commands to be sent during video mode

Junxiao Bi (1):
      Revert "ocfs2: mount shared volume without ha stack"

Junxiao Chang (1):
      net: stmmac: fix dma queue left shift overflow issue

Juri Lelli (2):
      sched/deadline: Fix BUG_ON condition for deboosted tasks
      wait: Fix __wait_event_hrtimeout for RT/DL tasks

Kai Ye (1):
      crypto: hisilicon/sec - fix auth key size error

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Sanitization Mode event

Kan Liang (1):
      perf/x86/lbr: Enable the branch type for the Arch LBR by default

Karol Herbst (2):
      drm/nouveau: recognise GA103
      nouveau: explicitly wait on the fence in nouveau_bo_move_m2mf

Karthik Alapati (1):
      HID: hidraw: fix memory leak in hidraw_release()

Kees Cook (3):
      x86/alternative: Report missing return thunk details
      kasan: test: Silence GCC 12 warnings
      tracing/perf: Avoid -Warray-bounds warning for __rel_loc macro

Keith Busch (5):
      nvme-pci: phison e16 has bogus namespace ids
      block: fix infinite loop for invalid zone append
      nvme: disable namespace access for unsupported metadata
      block/bio: remove duplicate append pages code
      block: ensure iov_iter advances for added pages

Kent Overstreet (2):
      9p: Drop kref usage
      9p: Add client parameter to p9_req_put()

Khazhismel Kumykov (1):
      writeback: avoid use-after-free after removing device

Kim Phillips (4):
      x86/sev: Avoid using __x86_return_thunk
      x86/bugs: Enable STIBP for JMP2RET
      x86/bugs: Remove apostrophe typo
      x86/bugs: Enable STIBP for IBPB mitigated RETBleed

Kiselev, Oleg (1):
      ext4: avoid resizing to a partial cluster size

Kishon Vijay Abraham I (1):
      xhci: Set HCD flag to defer primary roothub registration

Kiwoong Kim (1):
      scsi: ufs: core: Enable link lost interrupt

Konrad Dybcio (1):
      soc: qcom: Make QCOM_RPMPD depend on PM

Konrad Rzeszutek Wilk (1):
      x86/kexec: Disable RET on kexec

Konstantin Komarov (4):
      fs/ntfs3: Fix double free on remount
      fs/ntfs3: Do not change mode if ntfs_set_ea failed
      fs/ntfs3: Fix missing i_op in ntfs_read_mft
      fs/ntfs3: Fix work with fragmented xattr

Kris Bahnsen (1):
      ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count

Krzysztof Kozlowski (13):
      ARM: dts: ast2500-evb: fix board compatible
      ARM: dts: ast2600-evb: fix board compatible
      ARM: dts: ast2600-evb-a1: fix board compatible
      ARM: dts: qcom: mdm9615: add missing PMIC GPIO reg
      ARM: dts: qcom: pm8841: add required thermal-sensor-cells
      ath10k: do not enforce interrupt trigger type
      ASoC: samsung: h1940_uda1380: include proepr GPIO consumer header
      dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3 compatibles
      dt-bindings: arm: qcom: fix Longcheer L8150 compatibles
      dt-bindings: arm: qcom: fix MSM8916 MTP compatibles
      dt-bindings: arm: qcom: fix MSM8994 boards compatibles
      spi: dt-bindings: cadence: add missing 'required'
      spi: dt-bindings: zynqmp-qspi: add missing 'required'

Kumar Kartikeya Dwivedi (1):
      bpf: Don't reinit map value in prealloc_lru_pop

Kunihiko Hayashi (2):
      ARM: dts: uniphier: Fix USB interrupts for PXs2 SoC
      arm64: dts: uniphier: Fix USB interrupts for PXs3 SoC

Kuninori Morimoto (1):
      ASoC: rsnd: care default case on rsnd_ssiu_busif_err_irq_ctrl()

Kuniyuki Iwashima (106):
      sysctl: Fix data races in proc_dointvec().
      sysctl: Fix data races in proc_douintvec().
      sysctl: Fix data races in proc_dointvec_minmax().
      sysctl: Fix data races in proc_douintvec_minmax().
      sysctl: Fix data races in proc_doulongvec_minmax().
      sysctl: Fix data races in proc_dointvec_jiffies().
      tcp: Fix a data-race around sysctl_tcp_max_orphans.
      inetpeer: Fix data-races around sysctl.
      net: Fix data-races around sysctl_mem.
      cipso: Fix data-races around sysctl.
      icmp: Fix data-races around sysctl.
      ipv4: Fix a data-race around sysctl_fib_sync_mem.
      sysctl: Fix data-races in proc_dou8vec_minmax().
      sysctl: Fix data-races in proc_dointvec_ms_jiffies().
      icmp: Fix data-races around sysctl_icmp_echo_enable_probe.
      icmp: Fix a data-race around sysctl_icmp_ignore_bogus_error_responses.
      icmp: Fix a data-race around sysctl_icmp_errors_use_inbound_ifaddr.
      icmp: Fix a data-race around sysctl_icmp_ratelimit.
      icmp: Fix a data-race around sysctl_icmp_ratemask.
      raw: Fix a data-race around sysctl_raw_l3mdev_accept.
      tcp: Fix a data-race around sysctl_tcp_ecn_fallback.
      ipv4: Fix data-races around sysctl_ip_dynaddr.
      nexthop: Fix data-races around nexthop_compat_mode.
      ip: Fix data-races around sysctl_ip_default_ttl.
      tcp: Fix data-races around sysctl_tcp_ecn.
      ip: Fix data-races around sysctl_ip_no_pmtu_disc.
      ip: Fix data-races around sysctl_ip_fwd_use_pmtu.
      ip: Fix data-races around sysctl_ip_fwd_update_priority.
      ip: Fix data-races around sysctl_ip_nonlocal_bind.
      ip: Fix a data-race around sysctl_ip_autobind_reuse.
      ip: Fix a data-race around sysctl_fwmark_reflect.
      tcp/dccp: Fix a data-race around sysctl_tcp_fwmark_accept.
      tcp: Fix data-races around sysctl_tcp_l3mdev_accept.
      tcp: Fix data-races around sysctl_tcp_mtu_probing.
      tcp: Fix data-races around sysctl_tcp_base_mss.
      tcp: Fix data-races around sysctl_tcp_min_snd_mss.
      tcp: Fix a data-race around sysctl_tcp_mtu_probe_floor.
      tcp: Fix a data-race around sysctl_tcp_probe_threshold.
      tcp: Fix a data-race around sysctl_tcp_probe_interval.
      igmp: Fix data-races around sysctl_igmp_llm_reports.
      igmp: Fix a data-race around sysctl_igmp_max_memberships.
      igmp: Fix data-races around sysctl_igmp_max_msf.
      tcp: Fix data-races around keepalive sysctl knobs.
      tcp: Fix data-races around sysctl_tcp_syn(ack)?_retries.
      tcp: Fix data-races around sysctl_tcp_syncookies.
      tcp: Fix data-races around sysctl_tcp_migrate_req.
      tcp: Fix data-races around sysctl_tcp_reordering.
      tcp: Fix data-races around some timeout sysctl knobs.
      tcp: Fix a data-race around sysctl_tcp_notsent_lowat.
      tcp: Fix a data-race around sysctl_tcp_tw_reuse.
      tcp: Fix data-races around sysctl_max_syn_backlog.
      tcp: Fix data-races around sysctl_tcp_fastopen.
      tcp: Fix data-races around sysctl_tcp_fastopen_blackhole_timeout.
      ipv4: Fix a data-race around sysctl_fib_multipath_use_neigh.
      ipv4: Fix data-races around sysctl_fib_multipath_hash_policy.
      ipv4: Fix data-races around sysctl_fib_multipath_hash_fields.
      ip: Fix data-races around sysctl_ip_prot_sock.
      udp: Fix a data-race around sysctl_udp_l3mdev_accept.
      tcp: Fix data-races around sysctl knobs related to SYN option.
      tcp: Fix a data-race around sysctl_tcp_early_retrans.
      tcp: Fix data-races around sysctl_tcp_recovery.
      tcp: Fix a data-race around sysctl_tcp_thin_linear_timeouts.
      tcp: Fix data-races around sysctl_tcp_slow_start_after_idle.
      tcp: Fix a data-race around sysctl_tcp_retrans_collapse.
      tcp: Fix a data-race around sysctl_tcp_stdurg.
      tcp: Fix a data-race around sysctl_tcp_rfc1337.
      tcp: Fix a data-race around sysctl_tcp_abort_on_overflow.
      tcp: Fix data-races around sysctl_tcp_max_reordering.
      tcp: Fix data-races around sysctl_tcp_dsack.
      tcp: Fix a data-race around sysctl_tcp_app_win.
      tcp: Fix a data-race around sysctl_tcp_adv_win_scale.
      tcp: Fix a data-race around sysctl_tcp_frto.
      tcp: Fix a data-race around sysctl_tcp_nometrics_save.
      tcp: Fix data-races around sysctl_tcp_no_ssthresh_metrics_save.
      tcp: Fix data-races around sysctl_tcp_moderate_rcvbuf.
      tcp: Fix a data-race around sysctl_tcp_limit_output_bytes.
      tcp: Fix a data-race around sysctl_tcp_challenge_ack_limit.
      net: ping6: Fix memleak in ipv6_renew_options().
      igmp: Fix data-races around sysctl_igmp_qrv.
      tcp: Fix a data-race around sysctl_tcp_min_tso_segs.
      tcp: Fix a data-race around sysctl_tcp_min_rtt_wlen.
      tcp: Fix a data-race around sysctl_tcp_autocorking.
      tcp: Fix a data-race around sysctl_tcp_invalid_ratelimit.
      tcp: Fix data-races around sk_pacing_rate.
      net: Fix data-races around sysctl_[rw]mem(_offset)?.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_delay_ns.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_slack_ns.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_nr.
      tcp: Fix data-races around sysctl_tcp_reflect_tos.
      ipv4: Fix data-races around sysctl_fib_notify_on_flag_change.
      net: Fix data-races around sysctl_[rw]mem_(max|default).
      net: Fix data-races around weight_p and dev_weight_[rt]x_bias.
      net: Fix data-races around netdev_max_backlog.
      net: Fix data-races around netdev_tstamp_prequeue.
      ratelimit: Fix data-races in ___ratelimit().
      net: Fix data-races around sysctl_optmem_max.
      net: Fix a data-race around sysctl_tstamp_allow_data.
      net: Fix a data-race around sysctl_net_busy_poll.
      net: Fix a data-race around sysctl_net_busy_read.
      net: Fix a data-race around netdev_budget.
      net: Fix data-races around sysctl_max_skb_frags.
      net: Fix a data-race around netdev_budget_usecs.
      net: Fix data-races around sysctl_fb_tunnels_only_for_init_net.
      net: Fix data-races around sysctl_devconf_inherit_init_net.
      net: Fix a data-race around sysctl_somaxconn.
      kprobes: don't call disarm_kprobe() for disabled kprobes

Lad Prabhakar (1):
      mmc: renesas_sdhi: Get the reset handle early in the probe

Lai Jiangshan (5):
      x86/traps: Use pt_regs directly in fixup_bad_iret()
      x86/entry: Switch the stack after error_entry() returns
      x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
      x86/entry: Don't call error_entry() for XENPV
      x86/entry: Move CLD to the start of the idtentry macro

Lars-Peter Clausen (1):
      i2c: cadence: Support PEC for SMBus block read

Laurent Dufour (1):
      watchdog: export lockup_detector_reconfigure

Laurentiu Palcu (1):
      drm/imx/dcss: get rid of HPD warning message

Lee Jones (1):
      HID: steam: Prevent NULL pointer dereference in steam_{recv,send}_report

Len Baker (1):
      drivers/iio: Remove all strcpy() uses

Lennert Buytenhek (1):
      igc: Reinstate IGC_REMOVED logic and implement it properly

Leo Li (1):
      drm/amdgpu: Check BO's requested pinning domains against its preferred_domains

Leo Ma (1):
      drm/amd/display: Fix HDMI VSIF V3 incorrect issue

Leo Yan (1):
      perf symbol: Correct address for bss symbols

Letu Ren (1):
      fbdev: fb_pm2fb: Avoid potential divide by zero error

Lev Kujawski (1):
      KVM: set_msr_mce: Permit guests to ignore single-bit ECC errors

Li Lingfeng (1):
      ext4: recover csum seed of tmp_inode after migrating to extents

Liam Howlett (2):
      binder_alloc: add missing mmap_lock calls when using the VMA
      android: binder: fix lockdep check on clearing vma

Liam R. Howlett (1):
      android: binder: stop saving a pointer to the VMA

Liang He (29):
      net: ftgmac100: Hold reference returned by of_get_child_by_name()
      cpufreq: pmac32-cpufreq: Fix refcount leak bug
      net: dsa: microchip: ksz_common: Fix refcount leak bug
      drm/imx/dcss: Add missing of_node_put() in fail path
      scsi: ufs: host: Hold reference returned by of_parse_phandle()
      net: sungem_phy: Add of_node_put() for reference returned by of_get_parent()
      ARM: OMAP2+: display: Fix refcount leak bug
      ARM: OMAP2+: pdata-quirks: Fix refcount leak bug
      ARM: shmobile: rcar-gen2: Increase refcount for new reference
      soc: amlogic: Fix refcount leak in meson-secure-pwrc.c
      regulator: of: Fix refcount leak bug in of_get_regulation_constraints()
      mediatek: mt76: mac80211: Fix missing of_node_put() in mt76_led_init()
      mediatek: mt76: eeprom: fix missing of_node_put() in mt76_find_power_limits_node()
      i2c: mux-gpmux: Add of_node_put() when breaking out of loop
      of: device: Fix missing of_node_put() in of_dma_set_restricted_buffer
      usb: aspeed-vhub: Fix refcount leak bug in ast_vhub_init_desc()
      gpio: gpiolib-of: Fix refcount bugs in of_mm_gpiochip_add_data()
      mmc: cavium-octeon: Add of_node_put() when breaking out of loop
      mmc: cavium-thunderx: Add of_node_put() when breaking out of loop
      ASoC: qcom: Fix missing of_node_put() in asoc_qcom_lpass_cpu_platform_probe()
      ASoC: mt6359: Fix refcount leak bug
      iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop
      ASoC: audio-graph-card: Add of_node_put() in fail path
      video: fbdev: amba-clcd: Fix refcount leak bugs
      drm/meson: Fix refcount bugs in meson_vpu_has_available_connectors()
      usb: host: ohci-ppc-of: Fix refcount leak bug
      usb: renesas: Fix refcount leak bug
      tty: serial: Fix refcount leak bug in ucc_uart.c
      mips: cavium-octeon: Fix missing of_node_put() in octeon2_usb_clocks_start

Liao Chang (1):
      csky/kprobe: reclaim insn_slot on kprobe unregistration

Like Xu (2):
      KVM: x86/pmu: Introduce the ctrl_mask value for fixed counter
      KVM: x86/pmu: Ignore pmu->global_ctrl check if vPMU doesn't support global_ctrl

Liming Sun (1):
      mmc: sdhci-of-dwcmshc: Re-enable support for the BlueField-3 SoC

Lin Ma (1):
      igb: Add lock to avoid data race

Linus Torvalds (4):
      signal handling: don't use BUG_ON() for debugging
      watchqueue: make sure to serialize 'wqueue->defunct' properly
      watch-queue: remove spurious double semicolon
      watch_queue: Fix missing locking in add_watch_to_object()

Linus Walleij (4):
      soc: ixp4xx/npe: Fix unused match warning
      ARM: dts: ux500: Fix Codina accelerometer mounting matrix
      ARM: dts: ux500: Fix Gavini accelerometer mounting matrix
      hwmon: (drivetemp) Add module alias

Linyu Yuan (2):
      usb: typec: add missing uevent when partner support PD
      usb: typec: ucsi: Acknowledge the GET_ERROR_STATUS command completion

Liu Jian (1):
      skmsg: Fix invalid last sg check in sk_msg_recvmsg()

Liu Shixin (1):
      bootmem: remove the vmemmap pages from kmemleak in put_page_bootmem

Logan Gunthorpe (1):
      md: Notify sysfs sync_completed in md_reap_sync_thread()

Lorenzo Bianconi (2):
      mt76: mt76x02u: fix possible memory leak in __mt76x02u_mcu_send_msg
      mt76: mt7615: do not update pm stats in case of error

Luca Weiss (1):
      ARM: dts: qcom-msm8974: fix irq type on blsp2_uart1

Lucien Buchmann (1):
      USB: serial: ftdi_sio: add Belimo device ids

Luiz Augusto von Dentz (10):
      Bluetooth: Add bt_skb_sendmsg helper
      Bluetooth: Add bt_skb_sendmmsg helper
      Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg
      Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg
      Bluetooth: Fix passing NULL to PTR_ERR
      Bluetooth: SCO: Fix sco_send_frame returning skb->len
      Bluetooth: Fix bt_skb_sendmmsg not allocating partial chunks
      Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put
      Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
      Bluetooth: L2CAP: Fix build errors in some archs

Lukas Bulwahn (1):
      asm-generic: remove a broken and needless ifdef conditional

Lukas Czerner (2):
      ext4: check if directory block is within i_size
      ext4: make sure ext4_append() always allocates new block

Lukas Wunner (6):
      usbnet: Fix linkwatch use-after-free on disconnect
      usbnet: smsc95xx: Don't clear read-only PHY interrupt
      usbnet: smsc95xx: Avoid link settings race on interrupt reception
      usbnet: smsc95xx: Forward PHY interrupts to PHY driver to avoid polling
      usbnet: smsc95xx: Fix deadlock on runtime resume
      net: phy: smsc: Disable Energy Detect Power-Down in interrupt mode

Luo Meng (1):
      dm thin: fix use-after-free crash in dm_sm_register_threshold_callback

Luís Henriques (1):
      ceph: use correct index when encoding client supported features

Lv Ruyi (1):
      firmware: tegra: Fix error check return value of debugfs_create_file()

Lyude Paul (3):
      drm/nouveau: Don't pm_runtime_put_sync(), only pm_runtime_put_autosuspend()
      drm/nouveau/acpi: Don't print error when we get -EINPROGRESS from pm_runtime
      drm/nouveau/kms: Fix failure path for creating DP connectors

Maciej Fijalkowski (5):
      ice: check (DD | EOF) bits on Rx descriptor rather than (EOP | RS)
      ice: do not setup vlan for loopback VSI
      selftests/xsk: Destroy BPF resources only when ctx refcount drops to 0
      ice: xsk: Force rings to be sized to power of 2
      ice: xsk: prohibit usage of non-balanced queue id

Maciej S. Szmigiero (1):
      KVM: SVM: Don't BUG if userspace injects an interrupt with GIF=0

Maciej W. Rozycki (3):
      serial: 8250: Export ICR access helpers for internal use
      serial: 8250: Fold EndRun device support into OxSemi Tornado code
      serial: 8250: Add proper clock handling for OxSemi PCIe devices

Maciej Żenczykowski (2):
      net: usb: make USB_RTL8153_ECM non user configurable
      net: ipvtap - add __init/__exit annotations to module init/exit funcs

Maher Sanalla (1):
      net/mlx5: Adjust log_max_qp to be 18 at most

Mahesh Rajashekhara (1):
      scsi: smartpqi: Fix DMA direction for RAID requests

Manikanta Pubbisetty (1):
      ath11k: Fix incorrect debug_mask mappings

Manivannan Sadhasivam (1):
      ARM: dts: qcom: sdx55: Fix the IRQ trigger type for UART

Manyi Li (1):
      ACPI: PM: save NVS memory for Lenovo G40-45

Maor Dickman (1):
      net/mlx5e: Fix wrong tc flag used when set hw-tc-offload off

Maor Gottlieb (1):
      RDMA/mlx5: Add missing check for return value in get namespace flow

Marc Kleine-Budde (4):
      spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers
      can: netlink: allow configuring of fixed bit rates without need for do_set_bittiming callback
      can: netlink: allow configuring of fixed data bit rates without need for do_set_data_bittiming callback
      can: ems_usb: fix clang's -Wunaligned-access warning

Marcel Ziswiler (1):
      ARM: dts: imx7d-colibri-emmc: add cpu1 supply

Marco Pagani (1):
      fpga: altera-pr-ip: fix unsigned comparison with less than zero

Marek Szyprowski (1):
      phy: samsung: phy-exynos-pcie: sanitize init/power_on callbacks

Marek Vasut (2):
      drm/bridge: tc358767: Move (e)DP bridge endpoint parsing into dedicated function
      drm/bridge: tc358767: Fix (e)DP bridge endpoint parsing in dedicated function

Marijn Suijten (2):
      arm64: dts: qcom: sm6125: Move sdc2 pinctrl from seine-pdx201 to sm6125
      arm64: dts: qcom: sm6125: Append -state suffix to pinctrl nodes

Mario Kleiner (1):
      drm/amd/display: Only use depth 36 bpp linebuffers on DCN display engines.

Mario Limonciello (1):
      HID: amd_sfh: Don't show client init failed as error when discovery fails

Mark Brown (3):
      ASoC: ops: Fix off by one in range control validation
      ASoC: wcd938x: Fix event generation for some controls
      mtd: dataflash: Add SPI ID table

Mark Rutland (2):
      arch: make TRACE_IRQFLAGS_NMI_SUPPORT generic
      arm64: select TRACE_IRQFLAGS_NMI_SUPPORT

Markus Mayer (1):
      thermal/tools/tmon: Include pthread and time headers in tmon.h

Martin Liška (1):
      eth: sun: cassini: remove dead code

Martin Povišer (6):
      ASoC: tas2764: Add post reset delays
      ASoC: tas2764: Fix and extend FSYNC polarity handling
      ASoC: tas2770: Set correct FSYNC polarity
      ASoC: tas2770: Allow mono streams
      ASoC: tas2770: Drop conflicting set_bias_level power setting
      ASoC: tas2770: Fix handling of mute/unmute

Masahiro Yamada (1):
      kbuild: fix the modules order between drivers and libs

Masami Hiramatsu (2):
      tracing: Add '__rel_loc' using trace event macros
      tracing: Avoid -Warray-bounds warning for __rel_loc macro

Masami Hiramatsu (Google) (1):
      x86/kprobes: Update kcb status flag after singlestepping

Mateusz Kwiatkowski (1):
      drm/vc4: hdmi: Fix timings for interlaced modes

Mathew McBride (1):
      rtc: rx8025: fix 12/24 hour mode detection on RX-8035

Mathias Nyman (3):
      xhci: dbc: refactor xhci_dbc_init()
      xhci: dbc: create and remove dbc structure in dbgtty driver.
      xhci: dbc: Rename xhci_dbc_init and xhci_dbc_exit

Matthias May (4):
      geneve: do not use RT_TOS for IPv6 flowlabel
      mlx5: do not use RT_TOS for IPv6 flowlabel
      ipv6: do not use RT_TOS for IPv6 flowlabel
      geneve: fix TOS inheriting for ipv4

Max Filippov (1):
      xtensa: iss/network: provide release() callback

Maxim Kochetkov (1):
      net: qrtr: start MHI channel after endpoit creation

Maxim Levitsky (1):
      KVM: x86: fix typo in __try_cmpxchg_user causing non-atomicness

Maxim Mikityanskiy (3):
      net/mlx5e: Ring the TX doorbell on DMA errors
      net/tls: Remove the context from the list in tls_device_down
      net/mlx5e: Fix the value of MLX5E_MAX_RQ_NUM_MTTS

Maxime Ripard (7):
      drm/bridge: Add a function to abstract away panels
      drm/vc4: dsi: Switch to devm_drm_of_get_bridge
      drm/vc4: hdmi: Fix HPD GPIO detection
      drm/bridge: Move devm_drm_of_get_bridge to bridge/panel.c
      drm/bridge: Add stubs for devm_drm_of_get_bridge when OF is disabled
      drm/vc4: hdmi: Rework power up
      drm/vc4: hdmi: Depends on CONFIG_PM

Maximilian Heyne (1):
      xen-blkback: Apply 'feature_persistent' parameter when connect

Maximilian Luz (1):
      HID: hid-input: add Surface Go battery quirk

Md Haris Iqbal (5):
      RDMA/rtrs: Introduce destroy_cq helper
      RDMA/rtrs: Do not allow sessname to contain special symbols / and .
      RDMA/rtrs-clt: Replace list_next_or_null_rr_rcu with an inline function
      RDMA/rxe: For invalidate compare according to set keys in mr
      block/rnbd-srv: Set keep_id to true after mutex_trylock

Mel Gorman (1):
      sched/core: Do not requeue task on CPU excluded from cpus_mask

Meng Tang (8):
      ALSA: hda - Add fixup for Dell Latitidue E5430
      ALSA: hda/conexant: Apply quirk for another HP ProDesk 600 G3 model
      ALSA: hda/realtek: Fix headset mic for Acer SF313-51
      ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc671
      ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc221
      ALSA: hda/realtek - Enable the headset-mic on a Xiaomi's laptop
      ALSA: hda/conexant: Add quirk for LENOVO 20149 Notebook model
      ALSA: hda/realtek: Add quirk for another Asus K42JZ model

Menglong Dong (8):
      net: skb: introduce kfree_skb_reason()
      net: skb: use kfree_skb_reason() in tcp_v4_rcv()
      net: skb: use kfree_skb_reason() in __udp4_lib_rcv()
      net: socket: rename SKB_DROP_REASON_SOCKET_FILTER
      net: skb_drop_reason: add document for drop reasons
      net: netfilter: use kfree_drop_reason() for NF_DROP
      net: ipv4: use kfree_skb_reason() in ip_rcv_core()
      net: ipv4: use kfree_skb_reason() in ip_rcv_finish_core()

Miaohe Lin (5):
      hugetlb: fix memoryleak in hugetlb_mcopy_atomic_pte
      lib/test_hmm: avoid accessing uninitialized pages
      mm/memremap: fix memunmap_pages() race with get_dev_pagemap()
      mm/mmap.c: fix missing call to vm_unacct_memory in mmap_region
      mm/hugetlb: avoid corrupting page->mapping in hugetlb_mcopy_atomic_pte

Miaoqian Lin (37):
      power/reset: arm-versatile: Fix refcount leak in versatile_reboot_probe
      meson-mx-socinfo: Fix refcount leak in meson_mx_socinfo_init
      ARM: bcm: Fix refcount leak in bcm_kona_smc_init
      ARM: OMAP2+: Fix refcount leak in omapdss_init_of
      ARM: OMAP2+: Fix refcount leak in omap3xxx_prm_late_init
      cpufreq: zynq: Fix refcount leak in zynq_get_revision
      soc: qcom: ocmem: Fix refcount leak in of_get_ocmem
      soc: qcom: aoss: Fix refcount leak in qmp_cooling_devices_register
      drm/meson: encoder_hdmi: Fix refcount leak in meson_encoder_hdmi_init
      drm/virtio: Fix NULL vs IS_ERR checking in virtio_gpu_object_shmem_init
      drm/mcde: Fix refcount leak in mcde_dsi_bind
      media: tw686x: Fix memory leak in tw686x_video_init
      mtd: maps: Fix refcount leak in of_flash_probe_versatile
      mtd: maps: Fix refcount leak in ap_flash_init
      PCI: microchip: Fix refcount leak in mc_pcie_init_irq_domains()
      PCI: tegra194: Fix PM error handling in tegra_pcie_config_ep()
      mtd: partitions: Fix refcount leak in parse_redboot_of
      mtd: parsers: ofpart: Fix refcount leak in bcm4908_partitions_fw_offset
      PCI: mediatek-gen3: Fix refcount leak in mtk_pcie_init_irq_domains()
      usb: host: Fix refcount leak in ehci_hcd_ppc_of_probe
      usb: ohci-nxp: Fix refcount leak in ohci_hcd_nxp_probe
      mmc: sdhci-of-esdhc: Fix refcount leak in esdhc_signal_voltage_switch
      ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe
      ASoC: samsung: Fix error handling in aries_audio_probe
      ASoC: mediatek: mt8173: Fix refcount leak in mt8173_rt5650_rt5676_dev_probe
      ASoC: mt6797-mt6351: Fix refcount leak in mt6797_mt6351_dev_probe
      ASoC: mediatek: mt8173-rt5650: Fix refcount leak in mt8173_rt5650_dev_probe
      remoteproc: k3-r5: Fix refcount leak in k3_r5_cluster_of_init
      remoteproc: imx_rproc: Fix refcount leak in imx_rproc_addr_init
      rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge
      mfd: max77620: Fix refcount leak in max77620_initialise_fps
      powerpc/spufs: Fix refcount leak in spufs_init_isolated_loader
      powerpc/xive: Fix refcount leak in xive_get_max_prio
      powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
      drm/meson: Fix refcount leak in meson_encoder_hdmi_init
      pinctrl: nomadik: Fix refcount leak in nmk_pinctrl_dt_subnode_to_map
      Input: exc3000 - fix return value check of wait_for_completion_timeout

Michael Chan (1):
      bnxt_en: Fix bnxt_reinit_after_abort() code path

Michael Ellerman (4):
      powerpc/powernv: Avoid crashing if rng is NULL
      powerpc/64s: Disable stack variable initialisation for prom_init
      powerpc/pci: Fix PHB numbering when using opal-phbid
      powerpc/pci: Fix get_phb_number() locking

Michael Grzeschik (4):
      usb: dwc3: gadget: refactor dwc3_repare_one_trb
      usb: dwc3: gadget: fix high speed multiplier setting
      usb: gadget: uvc: calculate the number of request depending on framesize
      usb: gadget: uvc: call uvc uvcg_warn on completed status instead of uvcg_info

Michael Hübner (1):
      HID: thrustmaster: Add sparco wheel and fix array length

Michael Walle (2):
      NFC: nxp-nci: don't print header length mismatch on i2c error
      soc: fsl: guts: machine variable might be unset

Michal Maloszewski (1):
      i40e: Fix interface init with MSI interrupts (no MSI-X)

Michal Simek (1):
      dt-bindings: gpio: zynq: Add missing compatible strings

Michal Suchanek (2):
      ARM: dts: sunxi: Fix SPI NOR campatible on Orange Pi Zero
      kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification

Mike Christie (3):
      scsi: iscsi: Allow iscsi_if_stop_conn() to be called from kernel
      scsi: iscsi: Add helper to remove a session from the kernel
      scsi: iscsi: Fix session removal on shutdown

Mike Manning (1):
      net: allow unbound socket for packets in VRF when tcp_l3mdev_accept set

Mike Rapoport (1):
      secretmem: fix unhandled fault in truncate

Mike Snitzer (1):
      dm: return early from dm_pr_call() if DM device is suspended

Mikko Perttunen (2):
      arm64: tegra: Update Tegra234 BPMP channel addresses
      arm64: tegra: Mark BPMP channels as no-memory-wc

Miklos Szeredi (3):
      fuse: limit nsec
      fuse: ioctl: translate ENOSYS
      ovl: warn if trusted xattr creation fails

Mikulas Patocka (11):
      add barriers to buffer_uptodate and set_buffer_uptodate
      md-raid: destroy the bitmap after destroying the thread
      md-raid10: fix KASAN warning
      dm writecache: return void from functions
      dm writecache: count number of blocks read, not number of read bios
      dm writecache: count number of blocks written, not number of write bios
      dm writecache: count number of blocks discarded, not number of discard bios
      dm writecache: set a default MAX_WRITEBACK_JOBS
      dm raid: fix address sanitizer warning in raid_status
      dm raid: fix address sanitizer warning in raid_resume
      rds: add missing barrier to release_refill

Ming Lei (2):
      scsi: megaraid: Clear READ queue map's nr_queues
      blk-mq: don't create hctx debugfs dir until q->debugfs_dir is created

Ming Qian (12):
      media: imx-jpeg: Correct some definition according specification
      media: imx-jpeg: Leave a blank space before the configuration data
      media: imx-jpeg: use NV12M to represent non contiguous NV12
      media: imx-jpeg: Set V4L2_BUF_FLAG_LAST at eos
      media: imx-jpeg: Refactor function mxc_jpeg_parse
      media: imx-jpeg: Identify and handle precision correctly
      media: imx-jpeg: Handle source change in a function
      media: imx-jpeg: Support dynamic resolution change
      media: imx-jpeg: Align upwards buffer size
      media: imx-jpeg: Implement drain using v4l2-mem2mem helpers
      media: imx-jpeg: Disable slot interrupt when frame done
      media: v4l2-mem2mem: prevent pollerr when last_buffer_dequeued is set

Minghao Chi (CGEL ZTE) (1):
      drm/vc4: Use of_device_get_match_data()

Mingwei Zhang (1):
      KVM: x86/svm: add __GFP_ACCOUNT to __sev_dbg_{en,de}crypt_user()

Miquel Raynal (1):
      serial: 8250: dma: Allow driver operations before starting DMA transfers

Mirela Rabulea (1):
      media: imx-jpeg: Add pm-runtime support for imx-jpeg

Mohamed Khalfella (1):
      PCI/AER: Iterate over error counters instead of error strings

Mordechay Goodstein (1):
      ieee80211: add EHT 1K aggregation definitions

Moshe Shemesh (1):
      net/mlx5: Avoid false positive lockdep warning by adding lock_class_key

Muchun Song (1):
      mm: sysctl: fix missing numa_stat when !CONFIG_HUGETLB_PAGE

Mustafa Ismail (5):
      RDMA/irdma: Do not advertise 1GB page size for x722
      RDMA/irdma: Fix sleep from invalid context BUG
      RDMA/irdma: Fix a window for use-after-free
      RDMA/irdma: Fix VLAN connection with wildcard address
      RDMA/irdma: Fix setting of QP context err_rq_idx_valid field

Nadav Amit (1):
      x86/kprobes: Fix JNG/JNLE emulation

Namjae Jeon (6):
      ksmbd: use SOCK_NONBLOCK type for kernel_accept()
      ksmbd: fix memory leak in smb2_handle_negotiate
      ksmbd: fix use-after-free bug in smb2_tree_disconect
      ksmbd: fix heap-based overflow in set_ntacl_dacl()
      ksmbd: return STATUS_BAD_NETWORK_NAME error status if share is not configured
      ksmbd: don't remove dos attribute xattr on O_TRUNC open

Naohiro Aota (7):
      btrfs: zoned: prevent allocation from previous data relocation BG
      btrfs: zoned: fix critical section of relocation inode writeback
      btrfs: ensure pages are unlocked on cow_file_range() failure
      block: add bdev_max_segments() helper
      btrfs: zoned: revive max_zone_append_bytes
      btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size
      btrfs: convert count_max_extents() to use fs_info->max_extent_size

Narendra Hadke (1):
      serial: mvebu-uart: uart2 error bits clearing

Nathan Chancellor (4):
      x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current
      drm/simpledrm: Fix return type of simpledrm_simple_display_pipe_mode_valid()
      usb: cdns3: Don't use priv_dev uninitialized in cdns3_gadget_ep_enable()
      MIPS: tlbex: Explicitly compare _PAGE_NO_EXEC against 0

Nathan Lynch (1):
      powerpc/xive/spapr: correct bitmap allocation size

Naveen Mamindlapalli (1):
      octeontx2-pf: Fix NIX_AF_TL3_TL2X_LINKX_CFG register configuration

Neil Armstrong (2):
      drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR
      spi: meson-spicc: add local pow2 clock ops to preserve rate between messages

Nicholas Kazlauskas (4):
      drm/amd/display: Reset DMCUB before HW init
      drm/amd/display: Optimize bandwidth on following fast update
      drm/amd/display: Fix surface optimization regression on Carrizo
      drm/amd/display: Don't lock connection_mutex for DMUB HPD

Nick Bowler (1):
      nvme: define compat_ioctl again to unbreak 32-bit userspace.

Nick Desaulniers (4):
      x86/extable: Prefer local labels in .set directives
      Makefile: link with -z noexecstack --no-warn-rwx-segments
      x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments
      coresight: etm4x: avoid build failure with unrolled loops

Nick Hainke (1):
      arm64: dts: mt7622: fix BPI-R64 WPS button

Nico Boehr (1):
      KVM: s390: pv: don't present the ecall interrupt twice

Nicolas Dichtel (1):
      ip: fix dflt addr selection for connected nexthop

Nicolas Saenz Julienne (1):
      nohz/full, sched/rt: Fix missed tick-reenabling bug in dequeue_task_rt()

Niels Dossche (1):
      media: hdpvr: fix error value returns in hdpvr_read

Nikita Travkin (3):
      clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
      clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
      pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed

Nikolay Aleksandrov (1):
      xfrm: policy: fix metadata dst->dev xmit null pointer dereference

Nikolay Borisov (1):
      btrfs: properly flag filesystem with BTRFS_FEATURE_INCOMPAT_BIG_METADATA

Nilesh Javali (1):
      scsi: Revert "scsi: qla2xxx: Fix disk failure to rediscover"

Ning Qiang (1):
      macintosh/adb: fix oob read in do_adb_query() function

Nícolas F. R. A. Prado (3):
      arm64: dts: mt8192: Fix idle-states nodes naming scheme
      arm64: dts: mt8192: Fix idle-states entry-method
      dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be optional

Oded Gabbay (1):
      habanalabs/gaudi: mask constant value before cast

Ofir Bitton (1):
      habanalabs/gaudi: fix shift out of bounds

Oleg Nesterov (1):
      fix race between exit_itimers() and /proc/pid/timers

Oleksandr Tymoshenko (2):
      Revert "selftest/vm: verify remap destination address in mremap_test"
      Revert "selftest/vm: verify mmap addr in mremap_test"

Oleksij Rempel (2):
      net: dsa: sja1105: silent spi_device_id warnings
      net: dsa: vitesse-vsc73xx: silent spi_device_id warnings

Olga Kitaina (1):
      mtd: rawnand: arasan: Fix clock rate in NV-DDR

Olga Kornievskaia (1):
      NFSv4.2 fix problems with __nfs42_ssc_open

Oliver Upton (2):
      KVM: arm64: Treat PMCR_EL1.LC as RES1 on asymmetric systems
      KVM: arm64: Reject 32bit user PSTATE on asymmetric systems

Omar Sandoval (1):
      btrfs: fix space cache corruption and potential double allocations

Ondrej Mosnacek (1):
      kbuild: dummy-tools: avoid tmpdir leak in dummy gcc

Pablo Neira Ayuso (24):
      netfilter: nf_log: incorrect offset to network header
      netfilter: nf_tables: replace BUG_ON by element length check
      netfilter: nf_tables: use READ_ONCE and WRITE_ONCE for shared generation id access
      netfilter: nf_tables: disallow NFTA_SET_ELEM_KEY_END with NFT_SET_ELEM_INTERVAL_END flag
      netfilter: nf_tables: possible module reference underflow in error path
      netfilter: nf_tables: really skip inactive sets when allocating name
      netfilter: nf_tables: validate NFTA_SET_ELEM_OBJREF based on NFT_SET_OBJECT flag
      netfilter: nf_tables: NFTA_SET_ELEM_KEY_END requires concat and interval flags
      netfilter: nf_tables: disallow NFT_SET_ELEM_CATCHALL and NFT_SET_ELEM_INTERVAL_END
      netfilter: nf_tables: check NFT_SET_CONCAT flag if field_count is specified
      netfilter: nf_tables: disallow updates of implicit chain
      netfilter: nf_tables: make table handle allocation per-netns friendly
      netfilter: nft_payload: report ERANGE for too long offset and length
      netfilter: nft_payload: do not truncate csum_offset and csum_type
      netfilter: nf_tables: do not leave chain stats enabled on error
      netfilter: nft_osf: restrict osf to ipv4, ipv6 and inet families
      netfilter: nft_tunnel: restrict it to netdev family
      netfilter: nf_tables: consolidate rule verdict trace call
      netfilter: nft_cmp: optimize comparison for 16-bytes
      netfilter: nf_tables: upfront validation of data via nft_data_init()
      netfilter: nf_tables: disallow jump to implicit chain from set element
      netfilter: nf_tables: disallow binding to already bound chain
      netfilter: flowtable: add function to invoke garbage collection immediately
      netfilter: flowtable: fix stuck flows on cleanup due to pending work

Pali Rohár (6):
      serial: mvebu-uart: correctly report configured baudrate value
      PCI: Add defines for normal and subtractive PCI bridges
      powerpc/fsl-pci: Fix Class Code of PCIe Root Port
      crypto: inside-secure - Add missing MODULE_DEVICE_TABLE for of
      powerpc/pci: Prefer PCI domain assignment via DT 'linux,pci-domain' and alias
      PCI: aardvark: Fix reporting Slot capabilities on emulated bridge

Paolo Abeni (2):
      tcp: expose the tcp_mark_push() and tcp_skb_entail() helpers
      mptcp: stop relying on tcp_tx_skb_cache

Paolo Bonzini (5):
      KVM: emulate: do not adjust size of fastop and setcc subroutines
      KVM: x86: do not report a vCPU as preempted outside instruction boundaries
      KVM: x86: do not set st->preempted when going back to user space
      KVM: x86: do not report preemption if the steal time cache is stale
      KVM: x86: revalidate steal time cache if MSR value changes

Parav Pandit (1):
      vduse: Tie vduse mgmtdev and its device

Pascal Terjan (1):
      vboxguest: Do not use devm for irq

Patrice Chotard (1):
      mtd: spi-nor: fix spi_nor_spimem_setup_op() call in spi_nor_erase_{sector,chip}()

Paul Blakey (1):
      net/mlx5e: Fix enabling sriov while tc nic rules are offloaded

Paul E. McKenney (2):
      rcutorture: Warn on individual rcu_torture_init() error conditions
      rcutorture: Don't cpuhp_remove_state() if cpuhp_setup_state() failed

Pavan Chebbi (2):
      bnxt_en: Fix bnxt_refclk_read()
      PCI: Add ACS quirk for Broadcom BCM5750x NICs

Pavel Begunkov (11):
      io_uring: mem-account pbuf buckets
      io_uring: correct fill events helpers types
      io_uring: clean cqe filling functions
      io_uring: refactor poll update
      io_uring: move common poll bits
      io_uring: kill poll linking optimisation
      io_uring: inline io_poll_complete
      io_uring: poll rework
      io_uring: fail links when poll fails
      io_uring: fix wrong arm_poll error handling
      io_uring: fix UAF due to missing POLLFREE handling

Pavel Skripkin (2):
      ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
      fs/ntfs3: Fix NULL deref in ntfs_update_mftmirr

Pawan Gupta (6):
      x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
      x86/bugs: Add Cannon lake to RETBleed affected CPU list
      x86/speculation: Disable RRSBA behavior
      x86/bugs: Warn when "ibrs" mitigation is selected on Enhanced IBRS parts
      x86/speculation: Add LFENCE to RSB fill sequence
      x86/bugs: Add "unknown" reporting for MMIO Stale Data

Peilin Ye (2):
      vsock: Fix memory leak in vsock_connect()
      vsock: Set socket state back to SS_UNCONNECTED in vsock_connect_timeout()

Peng Fan (1):
      interconnect: imx: fix max_node_id

Peter Collingbourne (1):
      arm64: set UXN on swapper page tables

Peter Ujfalusi (3):
      ASoC: Intel: Skylake: Correct the ssp rate discovery in skl_get_ssp_clks()
      ASoC: Intel: Skylake: Correct the handling of fmt_config flexible array
      ASoC: SOF: Intel: hda-loader: Clarify the cl_dsp_init() flow

Peter Wang (1):
      scsi: ufs: core: Correct ufshcd_shutdown() flow

Peter Xu (1):
      mm/smaps: don't access young/dirty bit if pte unpresent

Peter Zijlstra (65):
      objtool: Classify symbols
      objtool: Explicitly avoid self modifying code in .altinstr_replacement
      objtool: Shrink struct instruction
      objtool,x86: Replace alternatives with .retpoline_sites
      objtool: Introduce CFI hash
      x86/retpoline: Remove unused replacement symbols
      x86/asm: Fix register order
      x86/asm: Fixup odd GEN-for-each-reg.h usage
      x86/retpoline: Move the retpoline thunk declarations to nospec-branch.h
      x86/retpoline: Create a retpoline thunk array
      x86/alternative: Implement .retpoline_sites support
      x86/alternative: Handle Jcc __x86_indirect_thunk_\reg
      x86/alternative: Try inline spectre_v2=retpoline,amd
      x86/alternative: Add debug prints to apply_retpolines()
      bpf,x86: Simplify computing label offsets
      bpf,x86: Respect X86_FEATURE_RETPOLINE*
      objtool: Default ignore INT3 for unreachable
      x86/entry: Remove skip_r11rcx
      x86/kvm/vmx: Make noinstr clean
      x86/cpufeatures: Move RETPOLINE flags to word 11
      x86/retpoline: Cleanup some #ifdefery
      x86/retpoline: Swizzle retpoline thunk
      x86/retpoline: Use -mfunction-return
      x86: Undo return-thunk damage
      x86,objtool: Create .return_sites
      x86,static_call: Use alternative RET encoding
      x86/ftrace: Use alternative RET encoding
      x86/bpf: Use alternative RET encoding
      x86/kvm: Fix SETcc emulation for return thunks
      x86/vsyscall_emu/64: Don't use RET in vsyscall emulation
      x86: Use return-thunk in asm code
      x86/entry: Avoid very early RET
      objtool: Treat .text.__x86.* as noinstr
      x86: Add magic AMD return-thunk
      x86/bugs: Keep a per-CPU IA32_SPEC_CTRL value
      x86/bugs: Optimize SPEC_CTRL MSR writes
      x86/bugs: Split spectre_v2_select_mitigation() and spectre_v2_user_select_mitigation()
      x86/bugs: Report Intel retbleed vulnerability
      intel_idle: Disable IBRS during long idle
      objtool: Update Retpoline validation
      x86/xen: Rename SYS* entry points
      x86/xen: Add UNTRAIN_RET
      x86/bugs: Add retbleed=ibpb
      objtool: Add entry UNRET validation
      x86/cpu/amd: Add Spectral Chicken
      x86/common: Stamp out the stepping madness
      x86/retbleed: Add fine grained Kconfig knobs
      x86/entry: Move PUSH_AND_CLEAR_REGS() back into error_entry
      um: Add missing apply_returns()
      x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds
      perf/core: Fix data race between perf_event_set_output() and perf_mmap_close()
      x86/uaccess: Implement macros for CMPXCHG on user addresses
      bitfield.h: Fix "type of reg too small for mask" test
      x86/entry_32: Remove .fixup usage
      x86/extable: Extend extable functionality
      x86/msr: Remove .fixup usage
      x86/futex: Remove .fixup usage
      x86/amd: Use IBPB for firmware calls
      x86/entry_32: Fix segment exceptions
      locking/lockdep: Fix lockdep_init_map_*() confusion
      x86/extable: Fix ex_handler_msr() print condition
      x86/ibt,ftrace: Make function-graph play nice
      x86/ftrace: Use alternative RET encoding
      x86/nospec: Unwreck the RSB stuffing
      x86/nospec: Fix i386 RSB stuffing

Phil Auld (1):
      drivers/base: fix userspace break from using bin_attributes for cpumap and cpulist

Phil Elwell (1):
      drm/vc4: hdmi: Disable audio if dmas property is present but empty

Philipp Zabel (1):
      ASoC: codec: tlv320aic32x4: fix mono playback via I2S

Pierre-Louis Bossart (8):
      ASoC: Realtek/Maxim SoundWire codecs: disable pm_runtime on remove
      ASoC: rt711-sdca-sdw: fix calibrate mutex initialization
      ASoC: Intel: sof_sdw: handle errors on card registration
      ASoC: rt711: fix calibrate mutex initialization
      ASoC: rt7*-sdw: harden jack_detect_handler
      ASoC: codecs: rt700/rt711/rt711-sdca: initialize workqueues in probe
      soundwire: bus_type: fix remove and shutdown support
      soundwire: revisit driver bind/unbind and callbacks

Ping Cheng (2):
      HID: wacom: Only report rotation for art pen
      HID: wacom: Don't register pad_input for touch switch

Piotr Skajewski (1):
      ixgbe: Add locking to prevent panic when setting sriov_numvfs to zero

Po-Wen Kao (1):
      scsi: ufs: ufs-mediatek: Fix the timing of configuring device regulators

Przemyslaw Patynowski (5):
      iavf: Fix handling of dummy receive descriptors
      iavf: Fix max_rate limiting
      iavf: Fix 'tc qdisc show' listing too many queues
      iavf: Fix adminq error handling
      iavf: Fix reset error handling

Puranjay Mohan (1):
      dt-bindings: iio: accel: Add DT binding doc for ADXL355

Qian Cai (1):
      crypto: arm64/gcm - Select AEAD for GHASH_ARM64_CE

Qiao Ma (2):
      net: hinic: fix bug that ethtool get wrong stats
      net: hinic: avoid kernel hung in hinic_get_stats64()

Qifu Zhang (1):
      Documentation: ACPI: EINJ: Fix obsolete example

Qu Wenruo (5):
      btrfs: rename btrfs_bio to btrfs_io_context
      btrfs: reject log replay if there is unsupported RO compat flag
      btrfs: only write the sectors in the vertical stripe which has data stripes
      btrfs: raid56: don't trust any cached sector in __raid56_parity_recover()
      btrfs: remove unnecessary parameter delalloc_start for writepage_delalloc()

Quanyang Wang (1):
      asm-generic: sections: refactor memory_intersects

Quentin Perret (1):
      KVM: arm64: Don't return from void function

Quinn Tran (19):
      scsi: qla2xxx: edif: Reduce Initiator-Initiator thrashing
      scsi: qla2xxx: edif: Fix potential stuck session in sa update
      scsi: qla2xxx: edif: Reduce connection thrash
      scsi: qla2xxx: edif: Fix inconsistent check of db_flags
      scsi: qla2xxx: edif: Synchronize NPIV deletion with authentication application
      scsi: qla2xxx: edif: Add retry for ELS passthrough
      scsi: qla2xxx: edif: Fix n2n discovery issue with secure target
      scsi: qla2xxx: edif: Fix n2n login retry for secure device
      scsi: qla2xxx: edif: Send LOGO for unexpected IKE message
      scsi: qla2xxx: edif: Reduce disruption due to multiple app start
      scsi: qla2xxx: edif: Fix no login after app start
      scsi: qla2xxx: edif: Tear down session if keys have been removed
      scsi: qla2xxx: edif: Fix session thrash
      scsi: qla2xxx: edif: Fix no logout on delete for N2N
      scsi: qla2xxx: Fix imbalance vha->vref_count
      scsi: qla2xxx: Turn off multi-queue for 8G adapters
      scsi: qla2xxx: Fix erroneous mailbox timeout after PCI error injection
      scsi: qla2xxx: Wind down adapter after PCIe error
      scsi: qla2xxx: edif: Fix dropped IKE message

R Mohamed Shah (1):
      ionic: VF initial random MAC address if no assigned mac

Rafael J. Wysocki (2):
      thermal: sysfs: Fix cooling_device_stats_setup() error code path
      ACPI: CPPC: Do not prevent CPPC from working in the future

Raghavendra Rao Ananta (1):
      selftests: KVM: Handle compiler optimizations in ucall

Ralph Campbell (1):
      mm/hmm: fault non-owner device private entries

Ralph Siemsen (1):
      clk: renesas: r9a06g032: Fix UART clkgrp bitsel

Randy Dunlap (3):
      usb: gadget: udc: amd5536 depends on HAS_DMA
      m68k: coldfire/device.c: protect FLEXCAN blocks
      kernel/sys_ni: add compat entry for fadvise64_64

Ranjani Sridharan (1):
      ASoC: SOF: Intel: hda: Define rom_status_reg in sof_intel_dsp_desc

Ren Zhijie (1):
      scsi: ufs: ufs-mediatek: Fix build error and type mismatch

Rex-BC Chen (1):
      clk: mediatek: reset: Fix written reset bit offset

Riwen Lu (1):
      ACPI: processor: Remove freq Qos request for all CPUs

Rob Clark (4):
      drm/msm/mdp5: Fix global state lock backoff
      drm/msm: Avoid dirtyfb stalls on video mode displays (v2)
      drm/msm/dpu: Fix for non-visible planes
      drm/msm: Fix dirtyfb refcounting

Robert Hancock (1):
      i2c: cadence: Change large transfer count reset logic to be unconditional

Robert Marko (7):
      arm64: dts: qcom: ipq8074: fix NAND node name
      clk: qcom: ipq8074: fix NSS core PLL-s
      clk: qcom: ipq8074: SW workaround for UBI32 PLL lock
      clk: qcom: ipq8074: fix NSS port frequency tables
      clk: qcom: ipq8074: set BRANCH_HALT_DELAY flag for UBI clocks
      PCI: qcom: Power on PHY before IPQ8074 DBI register accesses
      clk: qcom: ipq8074: dont disable gcc_sleep_clk_src

Roberto Sassu (1):
      tools build: Switch to new openssl API for test-libcrypto

Robin Murphy (1):
      swiotlb: fail map correctly with failed io_tlb_default_mem

Rohith Kollalsi (1):
      usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup

Ruozhu Li (1):
      nvme: fix regression when disconnect a recovering ctrl

Russell King (Oracle) (1):
      ARM: findbit: fix overflowing offset

Rustam Subkhankulov (3):
      wifi: p54: add missing parentheses in p54_flush()
      video: fbdev: sis: fix typos in SiS_GetModeID()
      net: dsa: sja1105: fix buffer overflow in sja1105_setup_devlink_regions()

Ryan Wanner (1):
      ARM: dts: at91: sama5d2: Fix typo in i2s1 node

Ryusuke Konishi (1):
      nilfs2: fix incorrect masking of permission flags for symlinks

Sabrina Dubroca (5):
      macsec: fix NULL deref in macsec_add_rxsa
      macsec: fix error message in macsec_add_rxsa and _txsa
      macsec: limit replay window size with XPN
      macsec: always read MACSEC_SA_ATTR_PN as a u64
      Revert "net: macsec: update SCI upon MAC address change."

Sagi Grimberg (2):
      nvme-tcp: always fail a request when sending it failed
      nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown

Sai Prakash Ranjan (2):
      irqchip/tegra: Fix overflow implicit truncation warnings
      drm/meson: Fix overflow implicit truncation warnings

Sakari Ailus (1):
      ACPI: property: Return type of acpi_add_nondev_subnodes() should be bool

Salvatore Bonaccorso (1):
      Documentation/ABI: Mention retbleed vulnerability info file for sysfs

Sam Protsenko (1):
      iommu/exynos: Handle failed IOMMU device registration properly

Samuel Holland (5):
      irqchip/mips-gic: Only register IPI domain when SMP is enabled
      genirq: GENERIC_IRQ_IPI depends on SMP
      arm64: dts: allwinner: a64: orangepi-win: Fix LED node name
      pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
      drm/sun4i: dsi: Prevent underflow when computing packet sizes

Sandor Bodo-Merle (1):
      net: bgmac: Fix a BUG triggered by wrong bytes_compl

Sascha Hauer (1):
      mtd: rawnand: gpmi: Set WAIT_FOR_READY timeout based on program/erase times

Sasha Neftin (2):
      e1000e: Enable GPT clock before sending message to CSME
      Revert "e1000e: Fix possible HW unit hang after an s0ix exit"

Saurabh Sengar (1):
      scsi: storvsc: Remove WQ_MEM_RECLAIM from storvsc_error_wq

Schspa Shi (1):
      vfio: Clear the caps->buf to NULL after free

Sean Christopherson (19):
      KVM: x86: Use __try_cmpxchg_user() to emulate atomic accesses
      KVM: nVMX: Snapshot pre-VM-Enter BNDCFGS for !nested_run_pending case
      KVM: nVMX: Snapshot pre-VM-Enter DEBUGCTL for !nested_run_pending case
      KVM: x86: Split kvm_is_valid_cr4() and export only the non-vendor bits
      KVM: nVMX: Let userspace set nVMX MSR to any _host_ supported value
      KVM: nVMX: Account for KVM reserved CR4 bits in consistency checks
      KVM: nVMX: Inject #UD if VMXON is attempted with incompatible CR0/CR4
      KVM: x86: Mark TSS busy during LTR emulation _after_ all fault checks
      KVM: x86: Set error code to segment selector on LLDT/LTR non-canonical #GP
      KVM: x86: Tag kvm_mmu_x86_module_init() with __init
      KVM: SVM: Unwind "speculative" RIP advancement if INTn injection "fails"
      KVM: SVM: Stuff next_rip on emulated INT3 injection if NRIPS is supported
      KVM: Don't set Accessed/Dirty bits for ZERO_PAGE
      KVM: nVMX: Set UMIP bit CR4_FIXED1 MSR when emulating UMIP
      KVM: x86: Signal #GP, not -EPERM, on bad WRMSR(MCi_CTL/STATUS)
      KVM: VMX: Mark all PERF_GLOBAL_(OVF)_CTRL bits reserved if there's no vPMU
      KVM: VMX: Add helper to check if the guest PMU has PERF_GLOBAL_CTRL
      KVM: nVMX: Attempt to load PERF_GLOBAL_CTRL on nVMX xfer iff it exists
      KVM: Unconditionally get a ref to /dev/kvm module when creating a VM

Sean Wang (4):
      Revert "mt76: mt7921: Fix the error handling path of mt7921_pci_probe()"
      Revert "mt76: mt7921e: fix possible probe failure after reboot"
      mt76: mt7921: use physical addr to unify register access
      mt76: mt7921e: fix possible probe failure after reboot

Sebastian Andrzej Siewior (1):
      batman-adv: Use netif_rx_any_context() any.

Sebastian Fricke (1):
      media: staging: media: hantro: Fix typos

Sebastian Reichel (1):
      mmc: sdhci-of-dwcmshc: rename rk3568 to rk35xx

Sebastian Würl (1):
      can: mcp251x: Fix race condition on receive interrupt

SeongJae Park (2):
      xen-blkback: fix persistent grants negotiation
      xen-blkfront: Apply 'feature_persistent' parameter when connect

Serge Semin (8):
      reset: Fix devm bulk optional exclusive control getter
      dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
      PCI: dwc: Stop link on host_init errors and de-initialization
      PCI: dwc: Add unroll iATU space support to dw_pcie_disable_atu()
      PCI: dwc: Disable outbound windows only for controllers using iATU
      PCI: dwc: Set INCREASE_REGION_SIZE flag based on limit address
      PCI: dwc: Deallocate EPC memory on dw_pcie_ep_init() errors
      PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists

Sergei Antonov (3):
      net: dsa: mv88e6060: prevent crash on an unused port
      net: moxa: pass pdev instead of ndev to DMA functions
      net: moxa: get rid of asymmetry in DMA mapping/unmapping

Sergey Senozhatsky (1):
      zram: do not lookup algorithm in backends table

Sergey Shtylyov (1):
      usb: host: xhci: use snprintf() in xhci_decode_trb()

Seth Forshee (1):
      fs: require CAP_SYS_ADMIN in target namespace for idmapped mounts

Shakeel Butt (1):
      Revert "memcg: cleanup racy sum avoidance code"

Shannon Nelson (3):
      ionic: widen queue_lock use around lif init and deinit
      ionic: clear broken state on generation change
      ionic: fix up issues with handling EAGAIN on FW cmds

Shengjiu Wang (6):
      rpmsg: char: Add mutex protection for rpmsg_eptdev_open()
      ASoC: imx-card: Fix DSD/PDM mclk frequency
      ASoC: fsl_asrc: force cast the asrc_format type
      ASoC: fsl-asoc-card: force cast the asrc_format type
      ASoC: fsl_easrc: use snd_pcm_format_t type for sample_format
      ASoC: imx-card: use snd_pcm_format_t type for asrc_format

Sherry Sun (1):
      tty: serial: fsl_lpuart: correct the count of break characters

Shigeru Yoshida (1):
      fbdev: fbcon: Properly revert changes when vc_resize() failed

Shuai Xue (1):
      ACPI: APEI: explicit init of HEST and GHES in apci_init()

Shuming Fan (1):
      ASoC: rt711-sdca: fix kernel NULL pointer dereference when IO error

Shunsuke Mie (1):
      PCI: endpoint: Don't stop controller when unbinding endpoint function

Shuqi Zhang (1):
      ext4: use kmemdup() to replace kmalloc + memcpy

Sibi Sankar (1):
      remoteproc: sysmon: Wait for SSCTL service to come up

Siddh Raman Pant (2):
      x86/numa: Use cpumask_available instead of hardcoded NULL check
      loop: Check for overflow while configuring loop

Siddharth Gupta (1):
      remoteproc: qcom: pas: Check if coredump is enabled

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw: Fix devlink port register sequence

Sireesh Kodali (2):
      arm64: dts: qcom: msm8916: Fix typo in pronto remoteproc node
      remoteproc: qcom: wcnss: Fix handling of IRQs

Srinivas Kandagatla (3):
      soundwire: qcom: Check device status before reading devid
      ASoC: codecs: msm8916-wcd-digital: move gains from SX_TLV to S8_TLV
      ASoC: codecs: wcd9335: move gains from SX_TLV to S8_TLV

Srinivas Neeli (2):
      Revert "can: xilinx_can: Limit CANFD brp to 2"
      gpio: gpio-xilinx: Fix integer overflow

Stafford Horne (2):
      irqchip: or1k-pic: Undefine mask_ack for level triggered hardware
      openrisc: io: Define iounmap argument as volatile

Stanimir Varbanov (1):
      venus: pm_helpers: Fix warning in OPP during probe

Stanislaw Kardach (1):
      octeontx2-af: Apply tx nibble fixup always

Steev Klimaszewski (1):
      HID: add Lenovo Yoga C630 battery quirk

Stefan Roese (1):
      PCI/portdrv: Don't disable AER reporting in get_port_device_capability()

Steffen Maier (1):
      scsi: zfcp: Fix missing auto port scan and thus missing target ports

Stephan Gerhold (3):
      virtio_mmio: Add missing PM calls to freeze/restore
      virtio_mmio: Restore guest page size on resume
      regulator: qcom_smd: Fix pm8916_pldo range

Stephane Eranian (2):
      perf/x86/intel/uncore: Fix broken read_counter() for SNB IMC PMU
      perf/x86/intel/ds: Fix precise store latency handling

Stephen Boyd (2):
      arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on trogdor
      platform/chrome: cros_ec: Always expose last resume result

Steve French (1):
      smb3: check xattr value length earlier

Steven Rostedt (Google) (12):
      net: sock: tracing: Fix sock_exceed_buf_limit not to dereference stale pointer
      tracing: Have event format check not flag %p* on __get_dynamic_array()
      ftrace/x86: Add back ftrace_expected assignment
      tracing: Use a struct alignof to determine trace event field alignment
      tracing/perf: Fix double put of trace event when init fails
      tracing/eprobes: Do not allow eprobes to use $stack, or % for regs
      tracing/eprobes: Do not hardcode $comm as a string
      tracing/eprobes: Have event probes be consistent with kprobes and uprobes
      tracing/probes: Have kprobes and uprobes use $COMM too
      tracing: Have filter accept "common_cpu" to be consistent
      tracing/eprobes: Fix reading of string fields
      selftests/kprobe: Do not test for GRP/ without event failures

Steven Rostedt (VMware) (1):
      tracing: Place trace_pid_list logic into abstract functions

Stéphane Graber (1):
      tools/vm/slabinfo: Handle files in debugfs

Subbaraya Sundeep (3):
      octeontx2-pf: Fix UDP/TCP src and dst port tc filters
      octeontx2-af: Fix mcam entry resource leak
      octeontx2-af: Fix key checking for source mac

Sudeep Holla (1):
      firmware: arm_scpi: Ensure scpi_info is not assigned if the probe fails

Sumit Garg (1):
      arm64: dts: qcom: qcs404: Fix incorrect USB2 PHYs assignment

Sungjong Seo (2):
      exfat: use updated exfat_chain directly during renaming
      f2fs: allow compression for mmap files in compress_mode=user

Sunil Goutham (1):
      octeontx2-pf: cn10k: Fix egress ratelimit configuration

Suren Baghdasaryan (1):
      mm/pagealloc: sysctl: change watermark_scale_factor max limit to 30%

Suzuki K Poulose (1):
      coresight: Clear the connection field properly

Sylwester Dziedziuch (1):
      i40e: Fix incorrect address type for IPv6 flow rules

Tadeusz Struk (1):
      bpf: Fix KASAN use-after-free Read in compute_effective_progs

Taehee Yoo (1):
      net: mld: fix reference count leak in mld_{query | report}_work()

Takashi Iwai (8):
      ALSA: usb-audio: Add quirk for Behringer UMC202HD
      ALSA: usb-audio: More comprehensive mixer map for ASUS ROG Zenith II
      ASoC: SOF: debug: Fix potential buffer overflow by snprintf()
      ASoC: SOF: Intel: hda: Fix potential buffer overflow by snprintf()
      ALSA: core: Add async signal helpers
      ALSA: timer: Use deferred fasync helper
      ALSA: control: Use deferred fasync helper
      ALSA: usb-audio: Add quirk for LH Labs Geek Out HD Audio 1V5

Tali Perry (2):
      i2c: npcm: Remove own slave addresses 2:10
      i2c: npcm: Correct slave role behavior

Tamás Szűcs (1):
      arm64: tegra: Fix SDMMC1 CD on P2888

Tang Bin (3):
      usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()
      usb: xhci: tegra: Fix error check
      opp: Fix error check in dev_pm_opp_attach_genpd()

Tao Jin (1):
      HID: multitouch: new device class fix Lenovo X12 trackpad sticky

Tariq Toukan (4):
      net/mlx5e: kTLS, Fix build time constant test in TX
      net/mlx5e: kTLS, Fix build time constant test in RX
      net/tls: Check for errors in tls_device_init
      net/tls: Fix race in TLS device down flow

Tejun Heo (1):
      cgroup: Use separate src/dst nodes when preloading css_sets for migration

Tetsuo Handa (3):
      tty: vt: initialize unicode screen buffer
      PM: hibernate: defer device probing when resuming from hibernation
      lib/smp_processor_id: fix imbalanced instrumentation_end() call

Thadeu Lima de Souza Cascardo (13):
      x86/realmode: build with -D__DISABLE_EXPORTS
      objtool: skip non-text sections when adding return-thunk sites
      x86/entry: Add kernel IBRS implementation
      x86/bugs: Do not enable IBPB-on-entry when IBPB is not supported
      efi/x86: use naked RET on mixed mode call wrapper
      x86/kvm: fix FASTOP_SIZE when return thunks are enabled
      x86/bugs: Do not enable IBPB at firmware entry when IBPB is not available
      netfilter: nf_tables: do not allow SET_ID to refer to another table
      netfilter: nf_tables: do not allow CHAIN_ID to refer to another table
      netfilter: nf_tables: do not allow RULE_ID to refer to another chain
      posix-cpu-timers: Cleanup CPU timers before freeing them during exec
      net_sched: cls_route: remove from list when handle is 0
      Revert "x86/ftrace: Use alternative RET encoding"

Theodore Ts'o (1):
      ext4: update s_overhead_clusters in the superblock during an on-line resize

Thierry Reding (1):
      arm64: tegra: Fixup SYSRAM references

Thinh Nguyen (2):
      usb: dwc3: gadget: Fix event pending check
      usb: dwc3: core: Deprecate GCTL.CORESOFTRESET

Thomas Gleixner (7):
      x86/static_call: Serialize __static_call_fixup() properly
      x86/extable: Tidy up redundant handler functions
      x86/extable: Get rid of redundant macros
      x86/mce: Deduplicate exception handling
      x86/extable: Rework the exception table mechanics
      x86/extable: Provide EX_TYPE_DEFAULT_MCE_SAFE and EX_TYPE_FAULT_MCE_SAFE
      netfilter: xtables: Bring SPDX identifier back

Thomas Hellström (1):
      drm/i915: Require the vm mutex for i915_vma_bind()

Thomas Zimmermann (5):
      drm/aperture: Run fbdev removal before internal helpers
      drm/hyperv-drm: Include framebuffer and EDID headers
      drm/shmem-helper: Unexport drm_gem_shmem_create_with_handle()
      drm/shmem-helper: Export dedicated wrappers for GEM object functions
      drm/shmem-helper: Pass GEM shmem object in public interfaces

Tianchen Ding (2):
      sched: Fix the check of nr_running at queue wakelist
      sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle

Tianjia Zhang (1):
      KEYS: asymmetric: enforce SM2 signature use pkey algo

Tianyu Li (1):
      mm/mempolicy: fix get_nodes out of bound access

Tim Crawford (1):
      ALSA: hda/realtek: Add quirk for Clevo NV45PZ

Timo Alho (1):
      firmware: tegra: bpmp: Do only aligned access to IPC memory area

Timur Tabi (1):
      drm/nouveau: fix another off-by-one in nvbios_addr

Tom Lendacky (1):
      crypto: ccp - During shutdown, check SEV data pointer before using

Tom Rix (3):
      ASoC: samsung: change gpiod_speaker_power and rx1950_audio from global to static variables
      drm/vc4: change vc4_dma_range_matches from a global to static
      apparmor: fix aa_label_asxprint return check

Tony Battersby (1):
      scsi: sg: Allow waiting for commands to complete on removed device

Tony Lindgren (1):
      clk: ti: Stop using legacy clkctrl names for omap4 and 5

Tony Luck (1):
      ACPI: APEI: Better fix to avoid spamming the console with old error logs

Toshi Kani (1):
      EDAC/ghes: Set the DIMM label unconditionally

Trond Myklebust (9):
      Revert "pNFS: nfs3_set_ds_client should set NFS_CS_NOPING"
      pNFS/flexfiles: Report RDMA connection errors to the server
      NFSv4.1: Don't decrease the value of seq_nr_highest_sent
      NFSv4.1: Handle NFS4ERR_DELAY replies to OP_SEQUENCE correctly
      NFSv4: Fix races in the legacy idmapper upcall
      NFSv4/pnfs: Fix a use-after-free bug in open
      SUNRPC: Reinitialise the backchannel request buffers before reuse
      NFS: Don't allocate nfs_fattr on the stack in __nfs42_ssc_open()
      SUNRPC: RPC level errors should set task->tk_rpc_status

Tyler Hicks (1):
      net/9p: Initialize the iounit field during fid creation

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_proto: don't show MKBP version if unsupported

Uwe Kleine-König (12):
      hwmon: (sht15) Fix wrong assumptions in device remove callback
      pwm: sifive: Simplify offset calculation for PWMCMP registers
      pwm: sifive: Ensure the clk is enabled exactly once per running PWM
      pwm: sifive: Shut down hardware only after pwmchip_remove() completed
      pwm: lpc18xx-sct: Reduce number of devm memory allocations
      pwm: lpc18xx-sct: Simplify driver by not using pwm_[gs]et_chip_data()
      pwm: lpc18xx: Fix period handling
      mtd: st_spi_fsm: Add a clk_disable_unprepare() in .probe()'s error path
      serial: 8250_fsl: Don't report FE, PE and OE twice
      mfd: t7l66xb: Drop platform disable callback
      i2c: imx: Make sure to unregister adapter on remove()
      dmaengine: sprd: Cleanup in .remove() after pm_runtime_get_sync() failed

Vadim Pasternak (1):
      i2c: mlxcpld: Fix register setting for 400KHz frequency

Vaibhav Jain (1):
      of: check previous kernel's ima-kexec-buffer against memory bounds

Vaishali Thakkar (3):
      RDMA/rtrs: Rename rtrs_sess to rtrs_path
      RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path
      RDMA/rtrs-clt: Rename rtrs_clt_sess to rtrs_clt_path

Viacheslav Mitrofanov (1):
      dmaengine: sf-pdma: Add multithread support for a DMA channel

Vidya Sagar (2):
      PCI: tegra194: Fix Root Port interrupt handling
      PCI: tegra194: Fix link up retry sequence

Vikas Gupta (1):
      bnxt_en: fix NQ resource accounting during vf creation on 57500 chips

Vincent Mailhol (10):
      can: pch_can: do not report txerr and rxerr during bus-off
      can: rcar_can: do not report txerr and rxerr during bus-off
      can: sja1000: do not report txerr and rxerr during bus-off
      can: hi311x: do not report txerr and rxerr during bus-off
      can: sun4i_can: do not report txerr and rxerr during bus-off
      can: kvaser_usb_hydra: do not report txerr and rxerr during bus-off
      can: kvaser_usb_leaf: do not report txerr and rxerr during bus-off
      can: usb_8dev: do not report txerr and rxerr during bus-off
      can: error: specify the values of data[5..7] of CAN error frames
      can: pch_can: pch_can_error(): initialize errc before using it

Vincent Whitchurch (1):
      um: virtio_uml: Allow probing from devicetree

Vitaly Kuznetsov (3):
      KVM: x86: Fully initialize 'struct kvm_lapic_irq' in kvm_pv_kick_cpu_op()
      KVM: selftests: Make hyperv_clock selftest more stable
      KVM: nVMX: Always enable TSC scaling for L2 when it was enabled for L1

Vivek Kasireddy (1):
      udmabuf: Set the DMA mask for the udmabuf device (v2)

Vlad Buslov (1):
      net/mlx5e: Properly disable vlan strip on non-UL reps

Vladimir Oltean (4):
      pinctrl: armada-37xx: use raw spinlocks for regmap to avoid invalid wait context
      net: pcs: xpcs: propagate xpcs_read error to xpcs_get_state_c37_sgmii
      net: dsa: felix: fix ethtool 256-511 and 512-1023 TX packet counters
      net: dsa: don't warn in dsa_port_set_state_now() when driver doesn't support it

Vladimir Zapolskiy (4):
      clk: qcom: camcc-sm8250: Fix halt on boot by reducing driver's init level
      clk: qcom: camcc-sdm845: Fix topology around titan_top power domain
      clk: qcom: camcc-sm8250: Fix topology around titan_top power domain
      clk: qcom: clk-alpha-pll: fix clk_trion_pll_configure description

Waiman Long (2):
      locking/rwsem: Allow slowpath writer to ignore handoff bit if not set by first waiter
      sched, cpuset: Fix dl_cpu_busy() panic due to empty cs->cpus_allowed

Wang Cheng (1):
      mm/mempolicy: fix uninit-value in mpol_rebind_policy()

Wayne Lin (2):
      drm/amd/display: Add option to defer works of hpd_rx_irq
      drm/amd/display: Fork thread to offload work of hpd_rx_irq

Wei Wang (1):
      Revert "tcp: change pingpong threshold to 3"

Weitao Wang (1):
      USB: HCD: Fix URB giveback issue in tasklet function

Wenbin Mei (1):
      mmc: mtk-sd: Clear interrupts when cqe off/disable

Wentao_Liang (1):
      drivers:md:fix a potential use-after-free bug

Werner Sembach (6):
      ACPI: video: Force backlight native for some TongFang devices
      ACPI: video: Shortening quirk list by identifying Clevo by board_name only
      Input: i8042 - move __initconst to fix code styling warning
      Input: i8042 - merge quirk tables
      Input: i8042 - add TUXEDO devices to i8042 quirk tables
      Input: i8042 - add additional TUXEDO devices to i8042 quirk tables

William Dean (5):
      pinctrl: ralink: Check for null return of devm_kcalloc
      parisc: Check the return value of ioremap() in lba_driver_probe()
      irqchip/mips-gic: Check the return value of ioremap() in gic_of_init()
      wifi: rtw88: check the return value of alloc_workqueue()
      watchdog: armada_37xx_wdt: check the return value of devm_ioremap() in armada_37xx_wdt_probe()

William Zhang (2):
      arm64: dts: broadcom: bcm4908: Fix timer node for BCM4906 SoC
      arm64: dts: broadcom: bcm4908: Fix cpu node for smp boot

Wolfram Sang (3):
      selftests: timers: valid-adjtimex: build fix for newer toolchains
      selftests: timers: clocksource-switch: fix passing errors from child
      mmc: tmio: avoid glitches when resetting

Wong Vee Khee (1):
      net: stmmac: remove redunctant disable xPCS EEE call

Wonhyuk Yang (1):
      tracing: Fix return value of trace_pid_write()

Wyes Karny (1):
      x86: Handle idle=nomwait cmdline properly for x86_idle

Xiang Chen (1):
      scsi: hisi_sas: Use managed PCI functions

Xianting Tian (5):
      RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
      RISC-V: Fixup get incorrect user mode PC for kernel mode regs
      RISC-V: Fixup schedule out issue in machine_crash_shutdown()
      RISC-V: Add modules to virtual kernel memory layout dump
      RISC-V: Add fast call path of crash_kexec()

Xiao Yang (1):
      RDMA/rxe: Remove the is_user members of struct rxe_sq/rxe_rq/rxe_srq

Xiaolei Wang (1):
      net: phy: Don't WARN for PHY_READY state in mdio_bus_phy_resume()

Xiaomeng Tong (2):
      media: [PATCH] pci: atomisp_cmd: fix three missing checks on list iterator
      virtio-gpu: fix a missing check to avoid NULL dereference

Xiaoming Ni (1):
      sysctl: move some boundary constants from sysctl.c to sysctl_vals

Xie Shaowen (1):
      Input: gscps2 - check return value of ioremap() in gscps2_probe()

Xie Yongji (1):
      fuse: Remove the control interface for virtio-fs

Xin Long (2):
      Documentation: fix sctp_wmem in ip-sysctl.rst
      sctp: leave the err path free in sctp_stream_init to sctp_stream_free

Xin Xiong (4):
      apparmor: fix reference count leak in aa_pivotroot()
      net/sunrpc: fix potential memory leaks in rpc_sysfs_xprt_state_change()
      net: fix potential refcount leak in ndisc_router_discovery()
      xfrm: fix refcount leak in __xfrm_policy_check()

Xinlei Lee (2):
      drm/mediatek: Modify dsi funcs to atomic operations
      drm/mediatek: Add pull-down MIPI operation in mtk_dsi_poweroff function

Xiu Jianfeng (4):
      Revert "evm: Fix memleak in init_desc"
      selinux: fix memleak in security_read_state_kernel()
      selinux: Add boundary check in put_entry()
      apparmor: Fix memleak in aa_simple_write_to_buffer()

Xu Qiang (2):
      irqdomain: Report irq number for NOMAP domains
      of/fdt: declared return type does not match actual return type

Xu Wang (1):
      i2c: Fix a potential use after free

Xuan Zhuo (1):
      virtio_net: fix memory leak inside XPD_TX with mergeable

Yan Lei (1):
      fs/ntfs3: Fix using uninitialized value n when calling indx_read

Yang Jihong (1):
      ftrace: Fix NULL pointer dereference in is_ftrace_trampoline when ftrace is dead

Yang Xu (1):
      fs: Add missing umask strip in vfs_tmpfile

Yang Yingliang (5):
      bus: hisi_lpc: fix missing platform_device_put() in hisi_lpc_acpi_probe()
      spi: Fix simplification of devm_spi_register_controller
      spi: tegra20-slink: fix UAF in tegra_slink_remove()
      xtensa: iss: fix handling error cases in iss_net_configure()
      net: neigh: don't call kfree_skb() under spin_lock_irqsave()

Yangxi Xiang (1):
      vt: fix memory overlapping when deleting chars in the buffer

Ye Bin (2):
      ext4: fix warning in ext4_iomap_begin as race between bmap and write
      ext4: avoid remove directory when directory is corrupted

Yefim Barashkin (1):
      drm/amd/pm: Prevent divide by zero

Yi Yang (1):
      serial: 8250: fix return error code in serial8250_request_std_resource()

YiFei Zhu (1):
      selftests/seccomp: Fix compile warning when CC=clang

Yifeng Zhao (1):
      mmc: sdhci-of-dwcmshc: add reset call back for rockchip Socs

Yipeng Zou (1):
      riscv:uprobe fix SR_SPIE set/clear handling

Yonglong Li (2):
      tcp: make retransmitted SKB fit into the send window
      mptcp: Fix crash due to tcp_tsorted_anchor was initialized before release skb

Yu Kuai (1):
      blk-mq: fix io hung due to missing commit_rqs

Yu Xiao (1):
      nfp: ethtool: fix the display error of `ethtool -m DEVNAME`

Yuanzheng Song (1):
      tools/vm/slabinfo: use alphabetic order when two values are equal

Yuezhang Mo (1):
      exfat: fix referencing wrong parent directory information after renaming

Yunfei Wang (1):
      iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit

Yunhao Tian (1):
      drm/mipi-dbi: align max_chunk to 2 in spi_transfer

Zenghui Yu (1):
      arm64: Fix match_list for erratum 1286807 on Arm Cortex-A76

Zhang Wensheng (1):
      driver core: fix potential deadlock in __driver_attach

Zhang Xianwei (1):
      NFSv4.1: RECLAIM_COMPLETE must handle EACCES

Zhang Xiaoxu (1):
      cifs: Fix memory leak on the deferred close

Zhang Yi (1):
      jbd2: fix outstanding credits assert in jbd2_journal_commit_transaction()

Zhen Lei (1):
      ARM: 9210/1: Mark the FDT_FIXED sections as shareable

Zheng Yejian (1):
      tracing/histograms: Fix memory leak problem

Zhengchao Shao (5):
      crypto: hisilicon/sec - don't sleep when in softirq
      crypto: hisilicon - Kunpeng916 crypto driver don't sleep when in softirq
      crypto: hisilicon/hpre - don't use GFP_KERNEL to alloc mem during softirq
      bpf: Don't redirect packets with invalid pkt_len
      net/af_packet: check len when min_header_len equals to 0

Zhenguo Zhao (1):
      tty: n_gsm: Delete gsmtty open SABM frame when config requester

Zheyu Ma (8):
      ALSA: bcd2000: Fix a UAF bug on the error path of probing
      iio: light: isl29028: Fix the warning in isl29028_remove()
      media: tw686x: Register the irq at the end of probe
      video: fbdev: arkfb: Fix a divide-by-zero bug in ark_set_pixclock()
      video: fbdev: vt8623fb: Check the size of screen before memset_io()
      video: fbdev: arkfb: Check the size of screen before memset_io()
      video: fbdev: s3fb: Check the size of screen before memset_io()
      video: fbdev: i740fb: Check the argument of i740_calc_vclk()

Zhihao Cheng (2):
      jbd2: fix assertion 'jh->b_frozen_data == NULL' failure when journal aborted
      proc: fix a dentry lock race between release_task and lookup

Zhouyi Zhou (1):
      powerpc/64: Init jump labels before parse_early_param()

Zhu Yanjun (1):
      RDMA/rxe: Fix error unwind in rxe_create_qp()

Zixuan Fu (2):
      btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()
      btrfs: fix possible memory leak in btrfs_get_dev_args_from_path()

Ziyang Xuan (1):
      ipv6/addrconf: fix a null-ptr-deref bug for ip6_ptr

haibinzhang (张海斌) (1):
      arm64: fix oops in concurrently setting insn_emulation sysctls

huhai (1):
      ACPI: LPSS: Fix missing check in register_device_clock()

xinhui pan (1):
      drm/amdgpu: Remove one duplicated ef removal

Íñigo Huguet (2):
      sfc: fix use after free when disabling sriov
      sfc: fix kernel panic when creating VF
---
Documentation/ABI/testing/sysfs-devices-system-cpu |    1 +
 Documentation/ABI/testing/sysfs-driver-xen-blkback |    2 +-
 .../ABI/testing/sysfs-driver-xen-blkfront          |    2 +-
 .../admin-guide/device-mapper/writecache.rst       |   16 +-
 .../hw-vuln/processor_mmio_stale_data.rst          |   14 +
 Documentation/admin-guide/hw-vuln/spectre.rst      |    8 +
 Documentation/admin-guide/kernel-parameters.txt    |   40 +
 Documentation/admin-guide/pm/cpuidle.rst           |   15 +-
 Documentation/admin-guide/sysctl/net.rst           |    2 +-
 Documentation/admin-guide/sysctl/vm.rst            |    2 +-
 Documentation/arm64/silicon-errata.rst             |    2 +
 Documentation/atomic_bitops.txt                    |    2 +-
 Documentation/devicetree/bindings/arm/qcom.yaml    |   18 +-
 .../bindings/clock/qcom,gcc-msm8996.yaml           |   16 +
 .../devicetree/bindings/gpio/gpio-zynq.yaml        |    6 +-
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |   88 ++
 .../bindings/net/broadcom-bluetooth.yaml           |    1 +
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |   11 -
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml |    6 +-
 .../devicetree/bindings/spi/spi-cadence.yaml       |    7 +
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |    7 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |    1 +
 .../driver-api/firmware/other_interfaces.rst       |    6 +
 Documentation/firmware-guide/acpi/apei/einj.rst    |    2 +-
 Documentation/networking/ip-sysctl.rst             |   13 +-
 .../tty/device_drivers/oxsemi-tornado.rst          |  129 ++
 .../userspace-api/media/v4l/ext-ctrls-codec.rst    |    6 +-
 Makefile                                           |   20 +-
 arch/Kconfig                                       |    3 +
 arch/alpha/kernel/srmcons.c                        |    2 +-
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |    2 +-
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts        |    1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts           |    2 +-
 arch/arm/boot/dts/bcm53015-meraki-mr26.dts         |  166 +++
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi              |    2 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   33 +-
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi          |    4 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi                |    1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |    2 +-
 arch/arm/boot/dts/qcom-pm8841.dtsi                 |    1 +
 arch/arm/boot/dts/qcom-sdx55.dtsi                  |    2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |    2 +-
 arch/arm/boot/dts/ste-ux500-samsung-codina.dts     |    4 +-
 arch/arm/boot/dts/ste-ux500-samsung-gavini.dts     |    4 +-
 arch/arm/boot/dts/stm32mp151.dtsi                  |    2 +-
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |    2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |    8 +-
 arch/arm/crypto/Kconfig                            |    2 +-
 arch/arm/crypto/Makefile                           |    4 +-
 arch/arm/crypto/blake2s-shash.c                    |   75 --
 arch/arm/include/asm/dma.h                         |    2 +-
 arch/arm/include/asm/entry-macro-multi.S           |   24 -
 arch/arm/include/asm/mach/map.h                    |    1 +
 arch/arm/include/asm/ptrace.h                      |   26 +
 arch/arm/include/asm/smp.h                         |    5 -
 arch/arm/kernel/smp.c                              |    7 +-
 arch/arm/lib/findbit.S                             |   16 +-
 arch/arm/lib/xor-neon.c                            |    3 +-
 arch/arm/mach-bcm/bcm_kona_smc.c                   |    1 +
 arch/arm/mach-omap2/display.c                      |    3 +
 arch/arm/mach-omap2/pdata-quirks.c                 |    2 +
 arch/arm/mach-omap2/prm3xxx.c                      |    1 +
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |    5 +-
 arch/arm/mach-zynq/common.c                        |    1 +
 arch/arm/mm/alignment.c                            |    3 +
 arch/arm/mm/mmu.c                                  |   15 +-
 arch/arm/mm/proc-v7-bugs.c                         |    9 +-
 arch/arm/probes/decode.h                           |   26 +-
 arch/arm64/Kconfig                                 |   18 +
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |    2 +-
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi  |    8 +
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi  |    2 +
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |    2 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |   26 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |    3 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |    3 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   17 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |    2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |    4 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |    4 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |    1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |    7 +-
 .../dts/qcom/sdm636-sony-xperia-ganges-mermaid.dts |    2 +-
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |   36 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi               |   30 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |    6 +
 .../boot/dts/renesas/beacon-renesom-baseboard.dtsi |    6 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |    2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |    8 +-
 arch/arm64/crypto/Kconfig                          |    1 +
 arch/arm64/crypto/poly1305-glue.c                  |    2 +-
 arch/arm64/include/asm/kernel-pgtable.h            |    4 +-
 arch/arm64/include/asm/kvm_host.h                  |    4 +
 arch/arm64/include/asm/processor.h                 |    3 +-
 arch/arm64/kernel/armv8_deprecated.c               |    9 +-
 arch/arm64/kernel/cpu_errata.c                     |   10 +-
 arch/arm64/kernel/cpufeature.c                     |    2 +-
 arch/arm64/kernel/head.S                           |    2 +-
 arch/arm64/kernel/hibernate.c                      |    5 -
 arch/arm64/kernel/mte.c                            |    9 -
 arch/arm64/kvm/arm.c                               |    3 +-
 arch/arm64/kvm/guest.c                             |    2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |    2 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |    2 +-
 arch/arm64/kvm/sys_regs.c                          |    4 +-
 arch/arm64/mm/copypage.c                           |    9 -
 arch/arm64/mm/mteswap.c                            |    9 -
 arch/csky/kernel/probes/kprobes.c                  |    4 +
 arch/ia64/include/asm/processor.h                  |    2 +-
 arch/m68k/coldfire/device.c                        |    6 +-
 arch/mips/cavium-octeon/octeon-platform.c          |    3 +-
 arch/mips/kernel/proc.c                            |    2 +-
 arch/mips/kernel/vdso.c                            |    2 +-
 arch/mips/mm/physaddr.c                            |   14 +-
 arch/mips/mm/tlbex.c                               |    4 +-
 arch/nios2/include/asm/entry.h                     |    3 +-
 arch/nios2/include/asm/ptrace.h                    |    2 +
 arch/nios2/kernel/entry.S                          |   22 +-
 arch/nios2/kernel/signal.c                         |    3 +-
 arch/nios2/kernel/syscall_table.c                  |    1 +
 arch/openrisc/include/asm/io.h                     |    2 +-
 arch/openrisc/mm/ioremap.c                         |    2 +-
 arch/parisc/Kconfig                                |   21 +-
 arch/parisc/kernel/cache.c                         |    3 -
 arch/parisc/kernel/drivers.c                       |    9 +-
 arch/parisc/kernel/syscalls/syscall.tbl            |    2 +-
 arch/parisc/kernel/unaligned.c                     |    2 +-
 arch/powerpc/Makefile                              |   26 +-
 arch/powerpc/include/asm/archrandom.h              |    5 -
 arch/powerpc/include/asm/simple_spinlock.h         |   15 +-
 arch/powerpc/kernel/Makefile                       |    1 +
 arch/powerpc/kernel/head_book3s_32.S               |    4 +-
 arch/powerpc/kernel/iommu.c                        |    5 +
 arch/powerpc/kernel/pci-common.c                   |   45 +-
 arch/powerpc/kernel/prom.c                         |    7 +
 arch/powerpc/kexec/crash.c                         |    3 +
 arch/powerpc/kvm/book3s_hv_builtin.c               |    7 +-
 arch/powerpc/kvm/book3s_hv_p9_entry.c              |   13 +-
 arch/powerpc/mm/book3s32/mmu.c                     |   10 +-
 arch/powerpc/mm/nohash/8xx.c                       |    4 +-
 arch/powerpc/mm/pgtable_32.c                       |    6 +-
 arch/powerpc/mm/ptdump/shared.c                    |    6 +-
 arch/powerpc/perf/core-book3s.c                    |   35 +-
 arch/powerpc/platforms/Kconfig.cputype             |   25 +-
 arch/powerpc/platforms/cell/axon_msi.c             |    1 +
 arch/powerpc/platforms/cell/spufs/inode.c          |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c          |    2 +
 arch/powerpc/platforms/powernv/rng.c               |   34 +-
 arch/powerpc/sysdev/fsl_pci.c                      |    8 +
 arch/powerpc/sysdev/fsl_pci.h                      |    1 +
 arch/powerpc/sysdev/xive/spapr.c                   |    6 +-
 arch/riscv/Makefile                                |    1 +
 arch/riscv/boot/dts/canaan/k210.dtsi               |   12 +
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |   24 +
 arch/riscv/include/asm/thread_info.h               |    2 +
 arch/riscv/kernel/crash_save_regs.S                |    2 +-
 arch/riscv/kernel/machine_kexec.c                  |   28 +-
 arch/riscv/kernel/probes/uprobes.c                 |    6 -
 arch/riscv/kernel/reset.c                          |   12 +-
 arch/riscv/kernel/sys_riscv.c                      |    5 +-
 arch/riscv/kernel/traps.c                          |    7 +-
 arch/riscv/lib/uaccess.S                           |   24 +-
 arch/riscv/mm/init.c                               |    4 +
 arch/s390/hypfs/hypfs_diag.c                       |    2 +-
 arch/s390/hypfs/inode.c                            |    2 +-
 arch/s390/include/asm/archrandom.h                 |    9 +-
 arch/s390/include/asm/ctl_reg.h                    |   16 +-
 arch/s390/include/asm/gmap.h                       |    2 +
 arch/s390/include/asm/os_info.h                    |    2 +-
 arch/s390/include/asm/processor.h                  |   19 +-
 arch/s390/include/asm/uaccess.h                    |    2 +-
 arch/s390/kernel/asm-offsets.c                     |    2 +
 arch/s390/kernel/crash_dump.c                      |   58 +-
 arch/s390/kernel/ipl.c                             |    4 +-
 arch/s390/kernel/machine_kexec.c                   |    2 +-
 arch/s390/kernel/machine_kexec_file.c              |   18 +-
 arch/s390/kernel/os_info.c                         |   12 +-
 arch/s390/kernel/process.c                         |   22 +-
 arch/s390/kernel/setup.c                           |   19 +-
 arch/s390/kernel/smp.c                             |   57 +-
 arch/s390/kvm/intercept.c                          |   15 +
 arch/s390/kvm/pv.c                                 |    9 +-
 arch/s390/kvm/sigp.c                               |    4 +-
 arch/s390/mm/fault.c                               |    4 +-
 arch/s390/mm/gmap.c                                |   86 ++
 arch/s390/mm/maccess.c                             |    4 +-
 arch/sh/include/asm/io.h                           |    8 +-
 arch/um/drivers/random.c                           |    2 +-
 arch/um/drivers/virtio_uml.c                       |   81 +-
 arch/um/include/asm/archrandom.h                   |   30 +
 arch/um/include/asm/xor.h                          |    2 +-
 arch/um/include/shared/os.h                        |    7 +
 arch/um/kernel/um_arch.c                           |   16 +
 arch/um/os-Linux/skas/process.c                    |   17 +-
 arch/um/os-Linux/util.c                            |    6 +
 arch/x86/Kconfig                                   |  104 +-
 arch/x86/Kconfig.debug                             |    3 -
 arch/x86/Makefile                                  |    2 +-
 arch/x86/boot/Makefile                             |    2 +-
 arch/x86/boot/compressed/Makefile                  |    4 +
 arch/x86/crypto/Makefile                           |    4 +-
 arch/x86/crypto/blake2s-glue.c                     |    3 +-
 arch/x86/crypto/blake2s-shash.c                    |   77 --
 arch/x86/entry/Makefile                            |    3 +-
 arch/x86/entry/calling.h                           |   72 +-
 arch/x86/entry/entry.S                             |   22 +
 arch/x86/entry/entry_32.S                          |   37 +-
 arch/x86/entry/entry_64.S                          |   96 +-
 arch/x86/entry/entry_64_compat.S                   |   21 +-
 arch/x86/entry/thunk_32.S                          |    2 -
 arch/x86/entry/thunk_64.S                          |    4 -
 arch/x86/entry/vdso/Makefile                       |    3 +-
 arch/x86/entry/vsyscall/vsyscall_emu_64.S          |    9 +-
 arch/x86/events/intel/ds.c                         |   10 +-
 arch/x86/events/intel/lbr.c                        |    8 +
 arch/x86/events/intel/uncore_snb.c                 |   18 +-
 arch/x86/include/asm/GEN-for-each-reg.h            |   14 +-
 arch/x86/include/asm/alternative.h                 |    2 +
 arch/x86/include/asm/asm-prototypes.h              |   18 -
 arch/x86/include/asm/asm.h                         |   85 +-
 arch/x86/include/asm/cpufeatures.h                 |   16 +-
 arch/x86/include/asm/disabled-features.h           |   21 +-
 arch/x86/include/asm/extable.h                     |   44 +-
 arch/x86/include/asm/extable_fixup_types.h         |   58 +
 arch/x86/include/asm/fpu/internal.h                |    4 +-
 arch/x86/include/asm/futex.h                       |   28 +-
 arch/x86/include/asm/insn-eval.h                   |    2 +
 arch/x86/include/asm/kvm_host.h                    |    6 +-
 arch/x86/include/asm/linkage.h                     |    8 +
 arch/x86/include/asm/mshyperv.h                    |    7 -
 arch/x86/include/asm/msr-index.h                   |   17 +
 arch/x86/include/asm/msr.h                         |   30 +-
 arch/x86/include/asm/nospec-branch.h               |  213 ++--
 arch/x86/include/asm/segment.h                     |    2 +-
 arch/x86/include/asm/static_call.h                 |   17 +
 arch/x86/include/asm/traps.h                       |    2 +-
 arch/x86/include/asm/uaccess.h                     |  142 +++
 arch/x86/include/asm/unwind_hints.h                |   14 +-
 arch/x86/kernel/alternative.c                      |  262 +++-
 arch/x86/kernel/cpu/amd.c                          |   46 +-
 arch/x86/kernel/cpu/bugs.c                         |  546 +++++++--
 arch/x86/kernel/cpu/common.c                       |  111 +-
 arch/x86/kernel/cpu/cpu.h                          |    2 +
 arch/x86/kernel/cpu/hygon.c                        |    6 +
 arch/x86/kernel/cpu/intel.c                        |   27 +-
 arch/x86/kernel/cpu/mce/core.c                     |   40 +-
 arch/x86/kernel/cpu/mce/internal.h                 |   10 -
 arch/x86/kernel/cpu/mce/severity.c                 |   23 +-
 arch/x86/kernel/cpu/scattered.c                    |    1 +
 arch/x86/kernel/dumpstack_32.c                     |    2 +-
 arch/x86/kernel/dumpstack_64.c                     |    3 +-
 arch/x86/kernel/ftrace.c                           |   13 +-
 arch/x86/kernel/ftrace_64.S                        |   19 +-
 arch/x86/kernel/head64.c                           |    2 +
 arch/x86/kernel/head_32.S                          |    1 +
 arch/x86/kernel/head_64.S                          |    5 +
 arch/x86/kernel/i8259.c                            |    3 +-
 arch/x86/kernel/kprobes/core.c                     |   20 +-
 arch/x86/kernel/module.c                           |   15 +-
 arch/x86/kernel/pmem.c                             |    7 +-
 arch/x86/kernel/process.c                          |   11 +-
 arch/x86/kernel/relocate_kernel_32.S               |   25 +-
 arch/x86/kernel/relocate_kernel_64.S               |   23 +-
 arch/x86/kernel/static_call.c                      |   49 +-
 arch/x86/kernel/traps.c                            |   19 +-
 arch/x86/kernel/unwind_frame.c                     |   16 +-
 arch/x86/kernel/unwind_orc.c                       |   17 +-
 arch/x86/kernel/vmlinux.lds.S                      |   23 +-
 arch/x86/kvm/emulate.c                             |   56 +-
 arch/x86/kvm/mmu/mmu.c                             |    2 +-
 arch/x86/kvm/svm/nested.c                          |    3 +-
 arch/x86/kvm/svm/sev.c                             |    4 +-
 arch/x86/kvm/svm/svm.c                             |   31 +-
 arch/x86/kvm/svm/vmenter.S                         |   18 +
 arch/x86/kvm/vmx/nested.c                          |  109 +-
 arch/x86/kvm/vmx/nested.h                          |    3 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |   13 +-
 arch/x86/kvm/vmx/run_flags.h                       |    8 +
 arch/x86/kvm/vmx/vmenter.S                         |  166 +--
 arch/x86/kvm/vmx/vmx.c                             |   81 +-
 arch/x86/kvm/vmx/vmx.h                             |   18 +-
 arch/x86/kvm/x86.c                                 |  136 ++-
 arch/x86/kvm/x86.h                                 |    2 +-
 arch/x86/kvm/xen.h                                 |    6 +-
 arch/x86/lib/insn-eval.c                           |   71 +-
 arch/x86/lib/memmove_64.S                          |    7 +-
 arch/x86/lib/retpoline.S                           |  133 ++-
 arch/x86/mm/extable.c                              |  197 +--
 arch/x86/mm/init.c                                 |   14 +-
 arch/x86/mm/init_64.c                              |    2 +-
 arch/x86/mm/mem_encrypt_boot.S                     |   10 +-
 arch/x86/mm/numa.c                                 |    4 +-
 arch/x86/net/bpf_jit_comp.c                        |  190 ++-
 arch/x86/net/bpf_jit_comp32.c                      |   22 +-
 arch/x86/platform/efi/efi_thunk_64.S               |    5 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c              |    2 +-
 arch/x86/um/Makefile                               |    3 +-
 arch/x86/xen/setup.c                               |    6 +-
 arch/x86/xen/xen-asm.S                             |   30 +-
 arch/x86/xen/xen-head.S                            |    5 +-
 arch/x86/xen/xen-ops.h                             |    6 +-
 arch/xtensa/platforms/iss/network.c                |   42 +-
 block/bio.c                                        |   99 +-
 block/blk-ioc.c                                    |    1 +
 block/blk-iocost.c                                 |   20 +-
 block/blk-iolatency.c                              |   18 +-
 block/blk-mq-debugfs.c                             |    3 +
 block/blk-mq.c                                     |    5 +-
 block/blk-rq-qos.h                                 |   11 +-
 block/blk-wbt.c                                    |   12 +-
 block/ioprio.c                                     |    4 +-
 crypto/Kconfig                                     |   20 +-
 crypto/Makefile                                    |    1 -
 crypto/asymmetric_keys/public_key.c                |    7 +-
 crypto/blake2s_generic.c                           |   75 --
 crypto/tcrypt.c                                    |   12 -
 crypto/testmgr.c                                   |   24 -
 crypto/testmgr.h                                   |  217 ----
 drivers/accessibility/speakup/spk_ttyio.c          |    4 +-
 drivers/acpi/acpi_lpss.c                           |    3 +
 drivers/acpi/acpi_video.c                          |   11 +-
 drivers/acpi/apei/bert.c                           |   31 +-
 drivers/acpi/apei/einj.c                           |    2 +
 drivers/acpi/apei/ghes.c                           |   19 +-
 drivers/acpi/bus.c                                 |    3 +
 drivers/acpi/cppc_acpi.c                           |   54 +-
 drivers/acpi/ec.c                                  |   82 +-
 drivers/acpi/pci_mcfg.c                            |    3 +
 drivers/acpi/pci_root.c                            |    3 -
 drivers/acpi/processor_idle.c                      |    6 +-
 drivers/acpi/processor_thermal.c                   |    2 +-
 drivers/acpi/property.c                            |    8 +-
 drivers/acpi/sleep.c                               |    8 +
 drivers/acpi/thermal.c                             |    2 -
 drivers/acpi/video_detect.c                        |   55 +-
 drivers/acpi/viot.c                                |   26 +-
 drivers/android/binder.c                           |  114 +-
 drivers/android/binder_alloc.c                     |   66 +-
 drivers/android/binder_alloc.h                     |    2 +-
 drivers/android/binder_alloc_selftest.c            |    2 +-
 drivers/android/binder_internal.h                  |   46 +-
 drivers/android/binderfs.c                         |   47 +-
 drivers/ata/libata-eh.c                            |    1 +
 drivers/atm/idt77252.c                             |    1 +
 drivers/base/cpu.c                                 |    8 +
 drivers/base/dd.c                                  |    5 +-
 drivers/base/node.c                                |    4 +-
 drivers/base/power/domain.c                        |    3 +
 drivers/base/topology.c                            |   28 +-
 drivers/block/loop.c                               |    5 +
 drivers/block/null_blk/main.c                      |   14 +-
 drivers/block/rnbd/rnbd-srv.c                      |   15 +-
 drivers/block/xen-blkback/xenbus.c                 |   20 +-
 drivers/block/xen-blkfront.c                       |    4 +-
 drivers/block/zram/zcomp.c                         |   11 +-
 drivers/bluetooth/btbcm.c                          |    2 +
 drivers/bluetooth/btusb.c                          |   15 +
 drivers/bluetooth/hci_bcm.c                        |    2 +
 drivers/bluetooth/hci_intel.c                      |    6 +-
 drivers/bus/hisi_lpc.c                             |   10 +-
 drivers/bus/mhi/pci_generic.c                      |   79 ++
 drivers/char/random.c                              |    2 +-
 drivers/clk/mediatek/reset.c                       |    4 +-
 drivers/clk/qcom/camcc-sdm845.c                    |    4 +
 drivers/clk/qcom/camcc-sm8250.c                    |   16 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |    2 +-
 drivers/clk/qcom/clk-krait.c                       |    7 +-
 drivers/clk/qcom/clk-rcg2.c                        |   16 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |   61 +-
 drivers/clk/qcom/gcc-msm8939.c                     |   33 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    8 +-
 drivers/clk/ti/clk-44xx.c                          |  210 ++--
 drivers/clk/ti/clk-54xx.c                          |  160 +--
 drivers/clk/ti/clkctrl.c                           |    4 -
 drivers/cpufreq/pmac32-cpufreq.c                   |    4 +
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |    1 +
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |   22 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |   15 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h       |    4 +
 drivers/crypto/ccp/sev-dev.c                       |   12 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |    2 +-
 drivers/crypto/hisilicon/sec/sec_algs.c            |   14 +-
 drivers/crypto/hisilicon/sec/sec_drv.h             |    2 +-
 drivers/crypto/hisilicon/sec2/sec.h                |    2 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c         |   26 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.h         |    1 +
 drivers/crypto/inside-secure/safexcel.c            |    2 +
 drivers/crypto/qat/qat_4xxx/adf_drv.c              |    7 -
 drivers/crypto/qat/qat_common/Makefile             |    1 +
 drivers/crypto/qat/qat_common/adf_transport.c      |   11 +
 drivers/crypto/qat/qat_common/adf_transport.h      |    1 +
 .../crypto/qat/qat_common/adf_transport_internal.h |    1 +
 drivers/crypto/qat/qat_common/qat_algs.c           |  138 ++-
 drivers/crypto/qat/qat_common/qat_algs_send.c      |   86 ++
 drivers/crypto/qat/qat_common/qat_algs_send.h      |   11 +
 drivers/crypto/qat/qat_common/qat_asym_algs.c      |  304 +++--
 drivers/crypto/qat/qat_common/qat_crypto.c         |   10 +-
 drivers/crypto/qat/qat_common/qat_crypto.h         |   39 +
 drivers/dma-buf/udmabuf.c                          |   18 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |   11 +
 drivers/dma/dw-edma/dw-edma-core.c                 |    2 +-
 drivers/dma/imx-dma.c                              |    2 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |   44 +-
 drivers/dma/sprd-dma.c                             |    5 +-
 drivers/edac/ghes_edac.c                           |   11 +-
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/arm_scpi.c                        |   61 +-
 drivers/firmware/arm_sdei.c                        |   13 +-
 drivers/firmware/sysfb.c                           |   58 +-
 drivers/firmware/sysfb_simplefb.c                  |   16 +-
 drivers/firmware/tegra/bpmp-debugfs.c              |   10 +-
 drivers/firmware/tegra/bpmp.c                      |    6 +-
 drivers/fpga/altera-pr-ip-core.c                   |    2 +-
 drivers/gpio/gpio-pca953x.c                        |   22 +-
 drivers/gpio/gpio-xilinx.c                         |    2 +-
 drivers/gpio/gpiolib-of.c                          |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |    3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  446 ++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   97 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   17 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   24 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   89 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   11 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    9 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    2 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |    6 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    5 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |    6 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c    |    8 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c  |    2 +-
 .../drm/amd/display/dc/dcn303/dcn303_resource.c    |    2 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   15 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    2 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   24 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |    2 +-
 drivers/gpu/drm/bridge/panel.c                     |   37 +
 drivers/gpu/drm/bridge/sil-sii8620.c               |    4 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   30 +-
 drivers/gpu/drm/drm_aperture.c                     |   26 +-
 drivers/gpu/drm/drm_bridge.c                       |    7 +-
 drivers/gpu/drm/drm_dp_aux_bus.c                   |    4 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    7 +-
 drivers/gpu/drm/drm_gem.c                          |    4 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |  132 +--
 drivers/gpu/drm/drm_gem_ttm_helper.c               |    9 +-
 drivers/gpu/drm/drm_mipi_dbi.c                     |    7 +
 drivers/gpu/drm/drm_of.c                           |    3 +
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |   17 +-
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |    2 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |    1 +
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   50 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   18 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   44 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |    8 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c          |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |    4 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h           |   17 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |    6 +-
 drivers/gpu/drm/i915/i915_vma.c                    |    1 +
 drivers/gpu/drm/imx/dcss/dcss-dev.c                |    3 +
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |    2 -
 drivers/gpu/drm/lima/lima_gem.c                    |   18 +-
 drivers/gpu/drm/lima/lima_sched.c                  |    4 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    1 +
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   33 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  126 +-
 drivers/gpu/drm/meson/Kconfig                      |    2 +
 drivers/gpu/drm/meson/meson_drv.c                  |    5 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |    1 +
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   96 +-
 drivers/gpu/drm/meson/meson_viu.c                  |   22 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   26 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |    3 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   19 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |    8 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h           |    5 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c          |    3 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   21 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   15 -
 drivers/gpu/drm/msm/msm_drv.h                      |    6 +-
 drivers/gpu/drm/msm/msm_fb.c                       |   43 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    9 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |    8 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |    4 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |    6 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   22 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c    |    2 +-
 drivers/gpu/drm/panel/Kconfig                      |    2 +
 drivers/gpu/drm/panfrost/panfrost_drv.c            |    6 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |   20 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c   |    2 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |    7 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |    6 +-
 drivers/gpu/drm/radeon/.gitignore                  |    2 +-
 drivers/gpu/drm/radeon/Kconfig                     |    2 +-
 drivers/gpu/drm/radeon/Makefile                    |    2 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |    6 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   10 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    3 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   10 +-
 drivers/gpu/drm/tiny/simpledrm.c                   |    2 +-
 drivers/gpu/drm/tiny/st7735r.c                     |    1 +
 drivers/gpu/drm/ttm/ttm_bo.c                       |    2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                       |   22 +-
 drivers/gpu/drm/vc4/Kconfig                        |    1 +
 drivers/gpu/drm/vc4/vc4_crtc.c                     |   10 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   19 +
 drivers/gpu/drm/vc4/vc4_dsi.c                      |  187 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   57 +-
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h                |    3 +
 drivers/gpu/drm/vc4/vc4_plane.c                    |   30 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    6 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |   31 +-
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           |    2 +
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c              |   12 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             |   21 +-
 drivers/hid/hid-alps.c                             |    2 +
 drivers/hid/hid-asus.c                             |    7 +
 drivers/hid/hid-cp2112.c                           |    5 +
 drivers/hid/hid-ids.h                              |    2 +
 drivers/hid/hid-input.c                            |    4 +
 drivers/hid/hid-mcp2221.c                          |    3 +
 drivers/hid/hid-multitouch.c                       |   13 +-
 drivers/hid/hid-steam.c                            |   10 +
 drivers/hid/hid-thrustmaster.c                     |    3 +-
 drivers/hid/hidraw.c                               |    3 +
 drivers/hid/wacom_sys.c                            |    2 +-
 drivers/hid/wacom_wac.c                            |   72 +-
 drivers/hv/hv_balloon.c                            |   13 +-
 drivers/hwmon/dell-smm-hwmon.c                     |    8 +
 drivers/hwmon/drivetemp.c                          |    1 +
 drivers/hwmon/sht15.c                              |   17 +-
 drivers/hwtracing/coresight/coresight-core.c       |    1 +
 drivers/hwtracing/coresight/coresight-etm4x.h      |    3 +-
 drivers/hwtracing/intel_th/msu-sink.c              |    3 +
 drivers/hwtracing/intel_th/msu.c                   |   14 +-
 drivers/hwtracing/intel_th/pci.c                   |   25 +-
 drivers/i2c/busses/i2c-cadence.c                   |   40 +-
 drivers/i2c/busses/i2c-imx.c                       |   20 +-
 drivers/i2c/busses/i2c-mlxcpld.c                   |    2 +-
 drivers/i2c/busses/i2c-mxs.c                       |    2 +-
 drivers/i2c/busses/i2c-npcm7xx.c                   |   50 +-
 drivers/i2c/i2c-core-base.c                        |    3 +-
 drivers/i2c/muxes/i2c-mux-gpmux.c                  |    1 +
 drivers/idle/intel_idle.c                          |   43 +-
 drivers/iio/accel/bma400.h                         |   23 +-
 drivers/iio/accel/bma400_core.c                    |    4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |    4 +-
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |    4 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    6 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   58 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |   36 +-
 drivers/iio/industrialio-core.c                    |   18 +-
 drivers/iio/light/cros_ec_light_prox.c             |    6 +-
 drivers/iio/light/isl29028.c                       |    2 +-
 drivers/iio/pressure/cros_ec_baro.c                |    6 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |    4 +-
 drivers/infiniband/hw/irdma/cm.c                   |   61 +-
 drivers/infiniband/hw/irdma/hw.c                   |   15 +-
 drivers/infiniband/hw/irdma/i40iw_hw.c             |    1 +
 drivers/infiniband/hw/irdma/icrdma_hw.c            |    1 +
 drivers/infiniband/hw/irdma/irdma.h                |    1 +
 drivers/infiniband/hw/irdma/verbs.c                |    6 +-
 drivers/infiniband/hw/mlx5/fs.c                    |    6 +-
 drivers/infiniband/hw/qedr/verbs.c                 |    8 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |   12 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   25 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |    2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |   12 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                 |    7 -
 drivers/infiniband/sw/rxe/rxe_param.h              |    6 +
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   26 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |   30 +-
 drivers/infiniband/sw/rxe/rxe_queue.h              |  292 ++---
 drivers/infiniband/sw/rxe/rxe_req.c                |   45 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   40 +-
 drivers/infiniband/sw/rxe/rxe_srq.c                |    3 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |   16 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   56 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    3 -
 drivers/infiniband/sw/siw/siw_cm.c                 |    7 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c           |    4 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c       |    8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |  123 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             | 1062 +++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |   22 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   39 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |  121 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  659 ++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   12 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |  127 +-
 drivers/infiniband/ulp/rtrs/rtrs.h                 |    7 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  148 ++-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   18 +-
 drivers/input/serio/gscps2.c                       |    4 +
 drivers/input/serio/i8042-x86ia64io.h              | 1251 ++++++++++++--------
 drivers/input/touchscreen/exc3000.c                |    7 +-
 drivers/interconnect/imx/imx.c                     |    8 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |    7 +-
 drivers/iommu/exynos-iommu.c                       |    6 +-
 drivers/iommu/intel/dmar.c                         |    2 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |   75 +-
 drivers/irqchip/Kconfig                            |    5 +-
 drivers/irqchip/irq-mips-gic.c                     |   84 +-
 drivers/irqchip/irq-or1k-pic.c                     |    1 -
 drivers/irqchip/irq-tegra.c                        |   10 +-
 drivers/macintosh/adb.c                            |    2 +-
 drivers/md/dm-raid.c                               |    4 +-
 drivers/md/dm-thin-metadata.c                      |    7 +-
 drivers/md/dm-thin.c                               |    4 +-
 drivers/md/dm-writecache.c                         |   43 +-
 drivers/md/dm.c                                    |    5 +
 drivers/md/md.c                                    |    2 +
 drivers/md/raid10.c                                |    5 +-
 drivers/md/raid5.c                                 |    2 +-
 drivers/media/pci/tw686x/tw686x-core.c             |   18 +-
 drivers/media/pci/tw686x/tw686x-video.c            |    4 +-
 drivers/media/platform/atmel/atmel-sama7g5-isc.c   |    2 +
 drivers/media/platform/imx-jpeg/mxc-jpeg-hw.c      |    5 +
 drivers/media/platform/imx-jpeg/mxc-jpeg-hw.h      |    9 +-
 drivers/media/platform/imx-jpeg/mxc-jpeg.c         |  523 +++++---
 drivers/media/platform/imx-jpeg/mxc-jpeg.h         |    7 +-
 drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h       |    2 +
 drivers/media/platform/qcom/venus/pm_helpers.c     |   10 +-
 drivers/media/usb/hdpvr/hdpvr-video.c              |    2 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |    1 +
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    2 +-
 drivers/memstick/core/ms_block.c                   |   11 +-
 drivers/mfd/max77620.c                             |    2 +
 drivers/mfd/t7l66xb.c                              |    6 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |    6 +-
 drivers/misc/cxl/irq.c                             |    1 +
 drivers/misc/eeprom/idt_89hpesx.c                  |    8 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |   24 +-
 drivers/misc/uacce/uacce.c                         |  133 ++-
 drivers/mmc/core/block.c                           |   28 +-
 drivers/mmc/host/cavium-octeon.c                   |    1 +
 drivers/mmc/host/cavium-thunderx.c                 |    4 +-
 drivers/mmc/host/meson-gx-mmc.c                    |    6 +-
 drivers/mmc/host/mtk-sd.c                          |    6 +
 drivers/mmc/host/mxcmmc.c                          |    2 +-
 drivers/mmc/host/pxamci.c                          |    4 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   37 +-
 drivers/mmc/host/sdhci-of-at91.c                   |    9 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |   88 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |    1 +
 drivers/mmc/host/tmio_mmc.c                        |    2 +-
 drivers/mmc/host/tmio_mmc.h                        |    6 +-
 drivers/mmc/host/tmio_mmc_core.c                   |   28 +-
 drivers/mtd/devices/mtd_dataflash.c                |    8 +
 drivers/mtd/devices/st_spi_fsm.c                   |    8 +-
 drivers/mtd/maps/physmap-versatile.c               |    2 +
 drivers/mtd/nand/raw/arasan-nand-controller.c      |   16 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |   28 +-
 drivers/mtd/nand/raw/meson_nand.c                  |    1 -
 drivers/mtd/parsers/ofpart_bcm4908.c               |    3 +
 drivers/mtd/parsers/redboot.c                      |    1 +
 drivers/mtd/sm_ftl.c                               |    2 +-
 drivers/mtd/spi-nor/core.c                         |    6 +-
 drivers/net/bonding/bond_3ad.c                     |   38 +-
 drivers/net/can/dev/netlink.c                      |    6 +-
 drivers/net/can/pch_can.c                          |    8 +-
 drivers/net/can/rcar/rcar_can.c                    |    8 +-
 drivers/net/can/sja1000/sja1000.c                  |    7 +-
 drivers/net/can/spi/hi311x.c                       |    5 +-
 drivers/net/can/spi/mcp251x.c                      |   18 +-
 drivers/net/can/sun4i_can.c                        |    9 +-
 drivers/net/can/usb/ems_usb.c                      |    2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |   12 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |    6 +-
 drivers/net/can/usb/usb_8dev.c                     |    7 +-
 drivers/net/can/xilinx_can.c                       |    4 +-
 drivers/net/dsa/microchip/ksz9477.c                |    3 +
 drivers/net/dsa/microchip/ksz_common.c             |    5 +-
 drivers/net/dsa/mv88e6060.c                        |    3 +
 drivers/net/dsa/ocelot/felix_vsc9959.c             |    3 +-
 drivers/net/dsa/sja1105/sja1105_devlink.c          |    2 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |   16 +
 drivers/net/dsa/vitesse-vsc73xx-spi.c              |   10 +
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   21 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   23 +-
 drivers/net/ethernet/broadcom/bgmac.c              |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |    2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |    3 +
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |    8 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   10 +-
 drivers/net/ethernet/emulex/benet/be_cmds.h        |    2 +-
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |   31 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   15 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |    4 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |    6 +-
 drivers/net/ethernet/huawei/hinic/hinic_dev.h      |    3 -
 drivers/net/ethernet/huawei/hinic/hinic_main.c     |   68 +-
 drivers/net/ethernet/huawei/hinic/hinic_rx.c       |    2 -
 drivers/net/ethernet/huawei/hinic/hinic_tx.c       |    2 -
 drivers/net/ethernet/intel/e1000e/hw.h             |    1 -
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |    4 -
 drivers/net/ethernet/intel/e1000e/ich8lan.h        |    1 -
 drivers/net/ethernet/intel/e1000e/netdev.c         |   30 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   21 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |    6 +
 drivers/net/ethernet/intel/iavf/iavf_adminq.c      |   15 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   55 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |    5 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |    3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |    8 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |    2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   14 +
 drivers/net/ethernet/intel/igb/igb.h               |    2 +
 drivers/net/ethernet/intel/igb/igb_main.c          |   12 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |    3 +
 drivers/net/ethernet/intel/igc/igc_regs.h          |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |   59 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |    6 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    6 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   15 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   19 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  106 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |    4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |    3 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   39 +-
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    6 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |    9 +-
 drivers/net/ethernet/moxa/moxart_ether.c           |   29 +-
 drivers/net/ethernet/netronome/nfp/flower/action.c |    2 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |    2 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  111 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    4 +-
 drivers/net/ethernet/sfc/ef10.c                    |    3 +
 drivers/net/ethernet/sfc/ef10_sriov.c              |   10 +-
 drivers/net/ethernet/sfc/ptp.c                     |   22 +
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    3 +
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |    8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    8 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   31 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    8 +-
 drivers/net/ethernet/sun/cassini.c                 |    4 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   17 +-
 drivers/net/geneve.c                               |   15 +-
 drivers/net/ipa/ipa_mem.c                          |    2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    2 +-
 drivers/net/ipvlan/ipvtap.c                        |    4 +-
 drivers/net/macsec.c                               |   46 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/netdevsim/bpf.c                        |    8 +-
 drivers/net/netdevsim/fib.c                        |   27 +-
 drivers/net/pcs/pcs-xpcs.c                         |    2 +-
 drivers/net/phy/phy_device.c                       |    6 +
 drivers/net/phy/sfp.c                              |    2 +-
 drivers/net/phy/smsc.c                             |    6 +-
 drivers/net/plip/plip.c                            |    2 +-
 drivers/net/sungem_phy.c                           |    1 +
 drivers/net/tun.c                                  |    5 +-
 drivers/net/usb/Kconfig                            |    3 +-
 drivers/net/usb/r8152.c                            |   43 +-
 drivers/net/usb/smsc95xx.c                         |   20 +-
 drivers/net/usb/usbnet.c                           |    8 +-
 drivers/net/virtio_net.c                           |   42 +-
 drivers/net/wireguard/allowedips.c                 |    9 +-
 drivers/net/wireguard/selftest/allowedips.c        |    6 +-
 drivers/net/wireguard/selftest/ratelimiter.c       |   25 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    5 +-
 drivers/net/wireless/ath/ath11k/core.c             |   16 +-
 drivers/net/wireless/ath/ath11k/debug.h            |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath9k/htc.h               |   10 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |    3 +-
 drivers/net/wireless/ath/wil6210/debugfs.c         |   18 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c      |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    1 +
 drivers/net/wireless/intersil/p54/main.c           |    2 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |    3 +-
 drivers/net/wireless/mac80211_hwsim.c              |   14 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |    1 +
 drivers/net/wireless/marvell/mwifiex/main.h        |    2 +
 drivers/net/wireless/marvell/mwifiex/pcie.c        |    3 +
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |    3 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |    5 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    9 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_mcu.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h   |   22 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    9 +-
 drivers/net/wireless/realtek/rtlwifi/debug.c       |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |    5 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    4 +
 drivers/net/xen-netback/rx.c                       |    1 +
 drivers/nfc/nxp-nci/i2c.c                          |    8 +-
 drivers/nfc/pn533/uart.c                           |    1 +
 drivers/ntb/test/ntb_tool.c                        |    8 +-
 drivers/nvme/host/core.c                           |   65 +-
 drivers/nvme/host/multipath.c                      |    1 +
 drivers/nvme/host/nvme.h                           |    1 +
 drivers/nvme/host/pci.c                            |    3 +-
 drivers/nvme/host/rdma.c                           |   12 +-
 drivers/nvme/host/tcp.c                            |   13 +-
 drivers/nvme/host/trace.h                          |    2 +-
 drivers/nvme/target/tcp.c                          |    3 +-
 drivers/nvme/target/zns.c                          |    3 +-
 drivers/of/device.c                                |    5 +-
 drivers/of/fdt.c                                   |    2 +-
 drivers/of/kexec.c                                 |   17 +
 drivers/opp/core.c                                 |    4 +-
 drivers/parisc/lba_pci.c                           |    6 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   18 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   30 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   46 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |   58 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   49 +-
 drivers/pci/controller/pci-aardvark.c              |   33 +-
 drivers/pci/controller/pci-hyperv.c                |  106 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |    6 +-
 drivers/pci/controller/pcie-microchip-host.c       |    2 +
 drivers/pci/endpoint/functions/pci-epf-test.c      |    1 -
 drivers/pci/p2pdma.c                               |    2 +-
 drivers/pci/pcie/aer.c                             |    7 +-
 drivers/pci/quirks.c                               |    3 +
 drivers/perf/arm_spe_pmu.c                         |   22 +-
 drivers/phy/samsung/phy-exynos-pcie.c              |   25 +-
 drivers/phy/samsung/phy-exynosautov9-ufs.c         |   18 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |    4 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            |    4 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   14 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   97 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |    4 +-
 drivers/pinctrl/pinctrl-amd.c                      |   11 +-
 drivers/pinctrl/qcom/pinctrl-msm8916.c             |    4 +-
 drivers/pinctrl/qcom/pinctrl-sm8250.c              |    2 +-
 drivers/pinctrl/ralink/Kconfig                     |   16 +-
 drivers/pinctrl/ralink/Makefile                    |    2 +-
 drivers/pinctrl/ralink/pinctrl-mt7620.c            |  252 ++--
 drivers/pinctrl/ralink/pinctrl-mt7621.c            |   30 +-
 .../ralink/{pinctrl-rt2880.c => pinctrl-ralink.c}  |   92 +-
 .../pinctrl/ralink/{pinmux.h => pinctrl-ralink.h}  |   16 +-
 drivers/pinctrl/ralink/pinctrl-rt288x.c            |   20 +-
 drivers/pinctrl/ralink/pinctrl-rt305x.c            |   44 +-
 drivers/pinctrl/ralink/pinctrl-rt3883.c            |   28 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   18 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c        |    1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |    7 +-
 drivers/platform/chrome/cros_ec.c                  |    8 +-
 drivers/platform/chrome/cros_ec_proto.c            |    8 +-
 drivers/platform/olpc/olpc-ec.c                    |    2 +-
 drivers/platform/x86/hp-wmi.c                      |    3 +
 drivers/power/reset/arm-versatile-reboot.c         |    1 +
 drivers/pwm/pwm-lpc18xx-sct.c                      |   88 +-
 drivers/pwm/pwm-sifive.c                           |   61 +-
 drivers/regulator/of_regulator.c                   |    6 +-
 drivers/regulator/qcom_smd-regulator.c             |    4 +-
 drivers/remoteproc/imx_rproc.c                     |    7 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |    3 +
 drivers/remoteproc/qcom_sysmon.c                   |   10 +
 drivers/remoteproc/qcom_wcnss.c                    |   10 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c           |    2 +
 drivers/rpmsg/mtk_rpmsg.c                          |    2 +
 drivers/rpmsg/qcom_smd.c                           |    1 +
 drivers/rpmsg/rpmsg_char.c                         |    7 +-
 drivers/rtc/rtc-rx8025.c                           |   22 +-
 drivers/s390/char/keyboard.h                       |    4 +-
 drivers/s390/char/zcore.c                          |   14 +-
 drivers/s390/cio/vfio_ccw_drv.c                    |   14 +-
 drivers/s390/scsi/zfcp_fc.c                        |   29 +-
 drivers/s390/scsi/zfcp_fc.h                        |    6 +-
 drivers/s390/scsi/zfcp_fsf.c                       |    4 +-
 drivers/scsi/be2iscsi/be_main.c                    |    2 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |    2 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |    2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   27 +-
 drivers/scsi/iscsi_tcp.c                           |    4 +-
 drivers/scsi/libiscsi.c                            |    9 +-
 drivers/scsi/lpfc/lpfc.h                           |   41 +
 drivers/scsi/lpfc/lpfc_bsg.c                       |   50 +-
 drivers/scsi/lpfc/lpfc_crtn.h                      |    3 +-
 drivers/scsi/lpfc/lpfc_ct.c                        |    8 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                   |   20 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  139 ++-
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |    1 +
 drivers/scsi/lpfc/lpfc_hw4.h                       |    7 +
 drivers/scsi/lpfc/lpfc_init.c                      |   44 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |    4 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |   87 +-
 drivers/scsi/lpfc/lpfc_nvme.h                      |    6 +-
 drivers/scsi/lpfc/lpfc_nvmet.c                     |   83 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |  501 ++++----
 drivers/scsi/lpfc/lpfc_sli.c                       |  911 +++++++-------
 drivers/scsi/lpfc/lpfc_sli.h                       |   26 +-
 drivers/scsi/lpfc/lpfc_sli4.h                      |    2 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |    3 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |    1 +
 drivers/scsi/qedi/qedi_main.c                      |    9 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   31 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |   10 +-
 drivers/scsi/qla2xxx/qla_def.h                     |   16 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |  154 ++-
 drivers/scsi/qla2xxx/qla_edif.h                    |   13 +-
 drivers/scsi/qla2xxx/qla_edif_bsg.h                |    2 +
 drivers/scsi/qla2xxx/qla_fw.h                      |    2 +-
 drivers/scsi/qla2xxx/qla_gbl.h                     |    8 +-
 drivers/scsi/qla2xxx/qla_gs.c                      |  129 +-
 drivers/scsi/qla2xxx/qla_init.c                    |  124 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |    8 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |  101 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   19 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |    6 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |    5 -
 drivers/scsi/qla2xxx/qla_os.c                      |  103 +-
 drivers/scsi/qla2xxx/qla_target.c                  |    2 +-
 drivers/scsi/scsi_ioctl.c                          |    2 +-
 drivers/scsi/scsi_transport_iscsi.c                |   66 +-
 drivers/scsi/sg.c                                  |   53 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |    4 +-
 drivers/scsi/storvsc_drv.c                         |    2 +-
 drivers/scsi/ufs/ufs-mediatek.c                    |   60 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c                   |   15 +-
 drivers/scsi/ufs/ufshcd.c                          |    8 +-
 drivers/scsi/ufs/ufshci.h                          |    6 +-
 drivers/soc/amlogic/meson-mx-socinfo.c             |    1 +
 drivers/soc/amlogic/meson-secure-pwrc.c            |    4 +-
 drivers/soc/fsl/guts.c                             |    2 +-
 drivers/soc/ixp4xx/ixp4xx-npe.c                    |    2 +-
 drivers/soc/qcom/Kconfig                           |    1 +
 drivers/soc/qcom/ocmem.c                           |    3 +
 drivers/soc/qcom/qcom_aoss.c                       |    4 +-
 drivers/soc/renesas/r8a779a0-sysc.c                |   10 +-
 drivers/soundwire/bus.c                            |   75 +-
 drivers/soundwire/bus_type.c                       |   38 +-
 drivers/soundwire/qcom.c                           |    4 +
 drivers/soundwire/slave.c                          |    3 +-
 drivers/soundwire/stream.c                         |   53 +-
 drivers/spi/spi-altera-dfl.c                       |   14 +-
 drivers/spi/spi-amd.c                              |    8 +
 drivers/spi/spi-bcm2835.c                          |   12 +-
 drivers/spi/spi-meson-spicc.c                      |  129 +-
 drivers/spi/spi-rspi.c                             |    4 +
 drivers/spi/spi-synquacer.c                        |    1 +
 drivers/spi/spi-tegra20-slink.c                    |    3 +-
 drivers/spi/spi.c                                  |   19 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |   57 +-
 drivers/staging/media/hantro/hantro.h              |    2 +
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c  |   27 +-
 drivers/staging/media/hantro/hantro_hevc.c         |    2 +-
 drivers/staging/media/hantro/hantro_postproc.c     |   15 +-
 drivers/staging/media/hantro/imx8m_vpu_hw.c        |    1 +
 drivers/staging/media/hantro/rockchip_vpu_hw.c     |    1 +
 drivers/staging/media/hantro/sama5d4_vdec_hw.c     |    1 +
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |    7 +-
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h   |    3 +-
 drivers/staging/rtl8192u/r8192U.h                  |    2 +-
 drivers/staging/rtl8192u/r8192U_dm.c               |   38 +-
 drivers/staging/rtl8192u/r8192U_dm.h               |    2 +-
 drivers/tee/tee_shm.c                              |    3 +
 drivers/thermal/thermal_sysfs.c                    |   10 +-
 drivers/tty/goldfish.c                             |    2 +-
 drivers/tty/moxa.c                                 |    4 +-
 drivers/tty/n_gsm.c                                |  360 ++++--
 drivers/tty/pty.c                                  |   14 +-
 drivers/tty/serial/8250/8250.h                     |   40 +
 drivers/tty/serial/8250/8250_bcm7271.c             |   24 +-
 drivers/tty/serial/8250/8250_core.c                |    4 +
 drivers/tty/serial/8250/8250_dma.c                 |    4 +
 drivers/tty/serial/8250/8250_dw.c                  |    3 +
 drivers/tty/serial/8250/8250_fsl.c                 |    2 +-
 drivers/tty/serial/8250/8250_pci.c                 |  582 ++++++---
 drivers/tty/serial/8250/8250_port.c                |   25 +-
 drivers/tty/serial/amba-pl011.c                    |   23 +-
 drivers/tty/serial/fsl_lpuart.c                    |   12 +-
 drivers/tty/serial/lpc32xx_hs.c                    |    2 +-
 drivers/tty/serial/mvebu-uart.c                    |   36 +-
 drivers/tty/serial/samsung_tty.c                   |    5 +-
 drivers/tty/serial/serial_core.c                   |    5 -
 drivers/tty/serial/stm32-usart.c                   |    2 +
 drivers/tty/serial/ucc_uart.c                      |    2 +
 drivers/tty/tty.h                                  |    3 +
 drivers/tty/tty_buffer.c                           |   66 +-
 drivers/tty/vt/keyboard.c                          |    6 +-
 drivers/tty/vt/vt.c                                |    6 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |   15 +-
 drivers/usb/core/hcd.c                             |   26 +-
 drivers/usb/dwc2/gadget.c                          |    3 +-
 drivers/usb/dwc3/core.c                            |    9 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |    4 +-
 drivers/usb/dwc3/gadget.c                          |   96 +-
 drivers/usb/gadget/function/uvc_queue.c            |   17 +-
 drivers/usb/gadget/function/uvc_video.c            |    2 +-
 drivers/usb/gadget/legacy/inode.c                  |    1 +
 drivers/usb/gadget/udc/Kconfig                     |    2 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |    4 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |    8 +-
 drivers/usb/host/ehci-ppc-of.c                     |    1 +
 drivers/usb/host/ohci-nxp.c                        |    1 +
 drivers/usb/host/ohci-ppc-of.c                     |    1 +
 drivers/usb/host/xhci-dbgcap.c                     |  135 +--
 drivers/usb/host/xhci-dbgcap.h                     |   13 +-
 drivers/usb/host/xhci-dbgtty.c                     |   22 +-
 drivers/usb/host/xhci-tegra.c                      |    8 +-
 drivers/usb/host/xhci.c                            |    6 +-
 drivers/usb/host/xhci.h                            |    2 +-
 drivers/usb/renesas_usbhs/rza.c                    |    4 +
 drivers/usb/serial/ftdi_sio.c                      |    3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    6 +
 drivers/usb/serial/sierra.c                        |    3 +-
 drivers/usb/serial/usb-serial.c                    |    2 +-
 drivers/usb/serial/usb_wwan.c                      |    3 +-
 drivers/usb/typec/class.c                          |    1 +
 drivers/usb/typec/ucsi/ucsi.c                      |    4 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   31 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   60 +-
 drivers/vfio/vfio.c                                |    1 +
 drivers/video/fbdev/amba-clcd.c                    |   24 +-
 drivers/video/fbdev/arkfb.c                        |    9 +-
 drivers/video/fbdev/core/fbcon.c                   |   39 +-
 drivers/video/fbdev/core/fbmem.c                   |   12 +
 drivers/video/fbdev/i740fb.c                       |    9 +-
 drivers/video/fbdev/pm2fb.c                        |    5 +
 drivers/video/fbdev/s3fb.c                         |    2 +
 drivers/video/fbdev/sis/init.c                     |    4 +-
 drivers/video/fbdev/vt8623fb.c                     |    2 +
 drivers/virt/vboxguest/vboxguest_linux.c           |    9 +-
 drivers/virtio/virtio_mmio.c                       |   26 +
 drivers/watchdog/armada_37xx_wdt.c                 |    2 +
 drivers/watchdog/sp5100_tco.c                      |    1 +
 drivers/xen/gntdev.c                               |    6 +-
 drivers/xen/privcmd.c                              |   21 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c           |    4 +-
 fs/9p/acl.c                                        |    1 +
 fs/9p/acl.h                                        |   17 +-
 fs/9p/cache.c                                      |    4 +-
 fs/9p/v9fs.c                                       |    4 +
 fs/9p/v9fs_vfs.h                                   |   11 +-
 fs/9p/vfs_addr.c                                   |    6 +-
 fs/9p/vfs_dentry.c                                 |    2 +
 fs/9p/vfs_file.c                                   |    1 +
 fs/9p/vfs_inode.c                                  |   14 +-
 fs/9p/vfs_inode_dotl.c                             |    9 +-
 fs/9p/vfs_super.c                                  |    7 +-
 fs/9p/xattr.h                                      |   19 +-
 fs/attr.c                                          |    2 +
 fs/btrfs/block-group.c                             |   52 +-
 fs/btrfs/block-group.h                             |    5 +-
 fs/btrfs/btrfs_inode.h                             |   12 +-
 fs/btrfs/check-integrity.c                         |    2 +-
 fs/btrfs/ctree.c                                   |    3 +
 fs/btrfs/ctree.h                                   |   33 +-
 fs/btrfs/delalloc-space.c                          |    6 +-
 fs/btrfs/dev-replace.c                             |    5 +-
 fs/btrfs/disk-io.c                                 |  119 +-
 fs/btrfs/disk-io.h                                 |   10 -
 fs/btrfs/extent-tree.c                             |   87 +-
 fs/btrfs/extent_io.c                               |   50 +-
 fs/btrfs/extent_map.c                              |    4 +-
 fs/btrfs/inode.c                                   |  153 ++-
 fs/btrfs/locking.c                                 |   91 ++
 fs/btrfs/locking.h                                 |   14 +
 fs/btrfs/raid56.c                                  |  201 ++--
 fs/btrfs/raid56.h                                  |    8 +-
 fs/btrfs/reada.c                                   |   26 +-
 fs/btrfs/relocation.c                              |    9 +-
 fs/btrfs/root-tree.c                               |    5 +-
 fs/btrfs/scrub.c                                   |  115 +-
 fs/btrfs/tree-checker.c                            |   25 +-
 fs/btrfs/tree-log.c                                |  244 ++--
 fs/btrfs/tree-log.h                                |    2 +-
 fs/btrfs/volumes.c                                 |  272 ++---
 fs/btrfs/volumes.h                                 |   38 +-
 fs/btrfs/xattr.c                                   |    3 +
 fs/btrfs/zoned.c                                   |   72 +-
 fs/btrfs/zoned.h                                   |    6 +
 fs/ceph/addr.c                                     |    6 +-
 fs/ceph/caps.c                                     |   27 +-
 fs/ceph/mds_client.c                               |    7 +-
 fs/ceph/mds_client.h                               |    6 -
 fs/cifs/file.c                                     |   20 +-
 fs/cifs/misc.c                                     |    6 +
 fs/cifs/smb2ops.c                                  |   17 +-
 fs/dlm/lock.c                                      |    3 +-
 fs/erofs/decompressor.c                            |   16 +-
 fs/eventpoll.c                                     |   22 +
 fs/exec.c                                          |    5 +-
 fs/exfat/namei.c                                   |   31 +-
 fs/ext2/super.c                                    |   12 +-
 fs/ext4/inline.c                                   |    3 +
 fs/ext4/inode.c                                    |   24 +-
 fs/ext4/migrate.c                                  |    4 +-
 fs/ext4/namei.c                                    |   30 +-
 fs/ext4/resize.c                                   |   11 +
 fs/ext4/xattr.c                                    |  169 +--
 fs/ext4/xattr.h                                    |   14 +
 fs/f2fs/file.c                                     |   17 +-
 fs/f2fs/node.c                                     |    6 +-
 fs/f2fs/segment.c                                  |   13 +
 fs/fs-writeback.c                                  |   12 +-
 fs/fuse/control.c                                  |    4 +-
 fs/fuse/inode.c                                    |    6 +
 fs/fuse/ioctl.c                                    |   15 +-
 fs/io_uring.c                                      |  758 ++++++------
 fs/jbd2/commit.c                                   |    2 +-
 fs/jbd2/transaction.c                              |   14 +-
 fs/ksmbd/mgmt/tree_connect.c                       |    2 +-
 fs/ksmbd/smb2misc.c                                |   12 +-
 fs/ksmbd/smb2pdu.c                                 |   71 +-
 fs/ksmbd/smbacl.c                                  |  130 +-
 fs/ksmbd/smbacl.h                                  |    2 +-
 fs/ksmbd/transport_tcp.c                           |    2 +-
 fs/ksmbd/vfs.c                                     |    5 +
 fs/lockd/svc4proc.c                                |    8 +
 fs/lockd/svcsubs.c                                 |   14 +-
 fs/lockd/xdr4.c                                    |   19 +-
 fs/mbcache.c                                       |   76 +-
 fs/namei.c                                         |    4 +
 fs/namespace.c                                     |    7 +
 fs/nfs/flexfilelayout/flexfilelayout.c             |    4 +
 fs/nfs/nfs3client.c                                |    1 -
 fs/nfs/nfs4file.c                                  |   16 +-
 fs/nfs/nfs4idmap.c                                 |   46 +-
 fs/nfs/nfs4proc.c                                  |   20 +-
 fs/nfsd/filecache.c                                |   22 +-
 fs/nfsd/filecache.h                                |    4 +-
 fs/nfsd/trace.h                                    |    8 -
 fs/nilfs2/nilfs.h                                  |    3 +
 fs/ntfs/attrib.c                                   |    8 +-
 fs/ntfs3/fslog.c                                   |    2 +-
 fs/ntfs3/fsntfs.c                                  |    7 +-
 fs/ntfs3/index.c                                   |    2 +-
 fs/ntfs3/inode.c                                   |    1 +
 fs/ntfs3/super.c                                   |    8 +-
 fs/ntfs3/xattr.c                                   |   45 +-
 fs/ocfs2/ocfs2.h                                   |    4 +-
 fs/ocfs2/slot_map.c                                |   46 +-
 fs/ocfs2/super.c                                   |   21 -
 fs/overlayfs/export.c                              |    2 +-
 fs/overlayfs/super.c                               |    7 +-
 fs/proc/base.c                                     |   46 +-
 fs/proc/proc_sysctl.c                              |    2 +-
 fs/proc/task_mmu.c                                 |    7 +-
 fs/read_write.c                                    |    3 +
 fs/remap_range.c                                   |    3 +-
 fs/splice.c                                        |   10 +-
 fs/xfs/libxfs/xfs_ag.h                             |   36 +-
 fs/xfs/libxfs/xfs_btree_staging.c                  |    4 +-
 fs/xfs/xfs_bio_io.c                                |   35 -
 fs/xfs/xfs_filestream.c                            |    7 +-
 fs/xfs/xfs_fsops.c                                 |   52 +-
 fs/xfs/xfs_icache.c                                |   22 +-
 fs/xfs/xfs_inode.c                                 |   79 +-
 fs/xfs/xfs_ioctl.c                                 |    4 +-
 fs/xfs/xfs_ioctl.h                                 |    5 +-
 fs/xfs/xfs_linux.h                                 |    2 -
 fs/xfs/xfs_log.c                                   |   58 +-
 fs/xfs/xfs_log_cil.c                               |   42 +-
 fs/xfs/xfs_log_priv.h                              |    3 +-
 fs/xfs/xfs_log_recover.c                           |   24 +-
 fs/xfs/xfs_mount.c                                 |   12 +-
 fs/xfs/xfs_mount.h                                 |   15 +
 fs/xfs/xfs_reflink.c                               |    5 +-
 fs/xfs/xfs_super.c                                 |    9 -
 fs/xfs/xfs_trans.c                                 |   86 ++
 fs/xfs/xfs_trans.h                                 |    3 +
 fs/xfs/xfs_trans_dquot.c                           |    1 -
 fs/zonefs/super.c                                  |    3 +-
 include/acpi/apei.h                                |    4 +-
 include/acpi/cppc_acpi.h                           |    2 +-
 include/asm-generic/bitops/atomic.h                |    6 -
 include/asm-generic/io.h                           |    2 -
 include/asm-generic/sections.h                     |    7 +-
 include/crypto/internal/blake2s.h                  |  108 --
 include/drm/drm_bridge.h                           |   13 +
 include/drm/drm_gem_shmem_helper.h                 |  168 ++-
 include/dt-bindings/clock/qcom,gcc-msm8939.h       |    1 +
 include/linux/acpi_viot.h                          |    2 +
 include/linux/arm_sdei.h                           |    2 +
 include/linux/bitfield.h                           |   19 +-
 include/linux/blkdev.h                             |   13 +-
 include/linux/bpfptr.h                             |    8 +-
 include/linux/buffer_head.h                        |   25 +-
 include/linux/cgroup-defs.h                        |    3 +-
 include/linux/cpu.h                                |    2 +
 include/linux/cpumask.h                            |   18 +
 include/linux/ieee80211.h                          |    6 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |    7 +-
 include/linux/io-pgtable.h                         |   15 +-
 include/linux/ioprio.h                             |    2 +-
 include/linux/kexec.h                              |    6 +
 include/linux/kfifo.h                              |    2 +-
 include/linux/kvm_host.h                           |    2 +-
 include/linux/lockd/xdr.h                          |    2 +
 include/linux/lockdep.h                            |   30 +-
 include/linux/mbcache.h                            |   10 +-
 include/linux/memcontrol.h                         |   15 +-
 include/linux/memremap.h                           |   18 +-
 include/linux/mfd/t7l66xb.h                        |    1 -
 include/linux/mlx5/driver.h                        |    1 +
 include/linux/netdevice.h                          |   20 +-
 include/linux/netfilter_bridge/ebtables.h          |    4 -
 include/linux/nmi.h                                |    2 +
 include/linux/objtool.h                            |    9 +-
 include/linux/once_lite.h                          |   20 +-
 include/linux/pci_ids.h                            |    2 +
 include/linux/pipe_fs_i.h                          |    9 +
 include/linux/printk.h                             |   34 +
 include/linux/reset.h                              |    2 +-
 include/linux/rmap.h                               |    7 +-
 include/linux/sched.h                              |    2 +-
 include/linux/sched/task.h                         |    2 +-
 include/linux/sched/topology.h                     |    1 +
 include/linux/serial_core.h                        |    5 +
 include/linux/skbuff.h                             |   55 +-
 include/linux/skmsg.h                              |    3 +-
 include/linux/soundwire/sdw.h                      |    6 +-
 include/linux/sunrpc/xdr.h                         |    4 +-
 include/linux/suspend.h                            |   10 +-
 include/linux/sysctl.h                             |   13 +-
 include/linux/sysfb.h                              |   22 +-
 include/linux/torture.h                            |    8 +
 include/linux/tpm_eventlog.h                       |    2 +-
 include/linux/tty_flip.h                           |    1 -
 include/linux/uacce.h                              |    6 +-
 include/linux/usb/hcd.h                            |    1 +
 include/linux/wait.h                               |    9 +-
 include/net/9p/9p.h                                |   10 +-
 include/net/9p/client.h                            |   30 +-
 include/net/9p/transport.h                         |   18 +-
 include/net/addrconf.h                             |    3 +
 include/net/bluetooth/bluetooth.h                  |   65 +
 include/net/bluetooth/l2cap.h                      |    1 +
 include/net/busy_poll.h                            |    2 +-
 include/net/inet6_hashtables.h                     |   27 +-
 include/net/inet_connection_sock.h                 |   10 +-
 include/net/inet_hashtables.h                      |   44 +-
 include/net/inet_sock.h                            |   23 +-
 include/net/ip.h                                   |    6 +-
 include/net/netfilter/nf_flow_table.h              |    3 +
 include/net/netfilter/nf_tables.h                  |   24 +-
 include/net/netfilter/nf_tables_core.h             |    9 +
 include/net/netns/ipv4.h                           |    1 -
 include/net/raw.h                                  |    2 +-
 include/net/route.h                                |    2 +-
 include/net/sock.h                                 |   93 +-
 include/net/tcp.h                                  |   22 +-
 include/net/tls.h                                  |    4 +-
 include/net/udp.h                                  |    2 +-
 include/scsi/libiscsi.h                            |    2 +-
 include/scsi/scsi_transport_iscsi.h                |    1 +
 include/sound/control.h                            |    2 +-
 include/sound/core.h                               |    8 +
 include/trace/bpf_probe.h                          |   16 +
 include/trace/events/skb.h                         |   48 +-
 include/trace/events/sock.h                        |    6 +-
 include/trace/events/spmi.h                        |   12 +-
 include/trace/perf.h                               |   17 +
 include/trace/trace_events.h                       |  131 +-
 include/uapi/linux/btrfs_tree.h                    |    4 +-
 include/uapi/linux/can/error.h                     |    5 +-
 include/uapi/linux/netfilter/xt_IDLETIMER.h        |   17 +-
 init/main.c                                        |    1 +
 kernel/audit_fsnotify.c                            |    1 +
 kernel/bpf/arraymap.c                              |    6 +
 kernel/bpf/cgroup.c                                |   70 +-
 kernel/bpf/core.c                                  |    8 +-
 kernel/bpf/hashtab.c                               |    8 +-
 kernel/bpf/verifier.c                              |   14 +-
 kernel/cgroup/cgroup.c                             |   38 +-
 kernel/cgroup/cpuset.c                             |    2 +-
 kernel/dma/swiotlb.c                               |    2 +-
 kernel/events/core.c                               |   45 +-
 kernel/exit.c                                      |    2 +-
 kernel/irq/Kconfig                                 |    1 +
 kernel/irq/chip.c                                  |    3 +-
 kernel/irq/irqdomain.c                             |    2 +
 kernel/kexec_file.c                                |   11 +-
 kernel/kprobes.c                                   |   12 +-
 kernel/locking/lockdep.c                           |    7 +-
 kernel/locking/rwsem.c                             |   30 +-
 kernel/power/main.c                                |   10 +-
 kernel/power/user.c                                |   13 +-
 kernel/printk/Makefile                             |    1 +
 kernel/printk/internal.h                           |   36 +
 kernel/printk/printk.c                             |   70 +-
 kernel/printk/printk_safe.c                        |   52 +
 kernel/profile.c                                   |    7 +
 kernel/rcu/rcutorture.c                            |   62 +-
 kernel/sched/core.c                                |   60 +-
 kernel/sched/deadline.c                            |   59 +-
 kernel/sched/fair.c                                |   92 +-
 kernel/sched/features.h                            |    3 +-
 kernel/sched/psi.c                                 |   15 +-
 kernel/sched/rt.c                                  |   17 +-
 kernel/sched/sched.h                               |    4 +-
 kernel/signal.c                                    |    8 +-
 kernel/smp.c                                       |    4 +-
 kernel/sys_ni.c                                    |    1 +
 kernel/sysctl.c                                    |  101 +-
 kernel/time/clockevents.c                          |    9 +-
 kernel/time/hrtimer.c                              |    1 +
 kernel/time/ntp.c                                  |   14 +-
 kernel/time/posix-timers.c                         |   19 +-
 kernel/time/timekeeping.c                          |   37 +-
 kernel/time/timekeeping_debug.c                    |    2 +-
 kernel/trace/Makefile                              |    1 +
 kernel/trace/blktrace.c                            |    2 +-
 kernel/trace/ftrace.c                              |   16 +-
 kernel/trace/pid_list.c                            |  160 +++
 kernel/trace/pid_list.h                            |   13 +
 kernel/trace/trace.c                               |   95 +-
 kernel/trace/trace.h                               |   17 +-
 kernel/trace/trace_eprobe.c                        |   88 +-
 kernel/trace/trace_event_perf.c                    |    7 +-
 kernel/trace/trace_events.c                        |   14 +-
 kernel/trace/trace_events_hist.c                   |    2 +
 kernel/trace/trace_probe.c                         |   29 +-
 kernel/watch_queue.c                               |  103 +-
 kernel/watchdog.c                                  |   21 +-
 kernel/workqueue.c                                 |    4 +
 lib/crypto/Kconfig                                 |    1 -
 lib/crypto/blake2s-selftest.c                      |   41 +
 lib/crypto/blake2s.c                               |   37 +-
 lib/iov_iter.c                                     |   15 +-
 lib/list_debug.c                                   |   12 +-
 lib/livepatch/test_klp_callbacks_busy.c            |    8 +
 lib/ratelimit.c                                    |   16 +-
 lib/smp_processor_id.c                             |    2 +-
 lib/test_bpf.c                                     |    4 +-
 lib/test_hmm.c                                     |   10 +-
 lib/test_kasan.c                                   |   10 +
 localversion-rt                                    |    2 +-
 mm/backing-dev.c                                   |   10 +-
 mm/bootmem_info.c                                  |    2 +
 mm/damon/dbgfs.c                                   |    3 +
 mm/hmm.c                                           |   19 +-
 mm/hugetlb.c                                       |    3 +-
 mm/memory.c                                        |   34 +-
 mm/mempolicy.c                                     |    4 +-
 mm/memremap.c                                      |   59 +-
 mm/mmap.c                                          |   21 +-
 mm/page-writeback.c                                |    6 +-
 mm/page_alloc.c                                    |   12 +-
 mm/rmap.c                                          |   29 +-
 mm/secretmem.c                                     |   33 +-
 mm/userfaultfd.c                                   |    5 +-
 net/8021q/vlan_dev.c                               |    6 +-
 net/9p/client.c                                    |  462 ++++----
 net/9p/error.c                                     |    2 +-
 net/9p/mod.c                                       |    9 +-
 net/9p/protocol.c                                  |   36 +-
 net/9p/protocol.h                                  |    2 +-
 net/9p/trans_common.h                              |    2 +-
 net/9p/trans_fd.c                                  |   13 +-
 net/9p/trans_rdma.c                                |    2 +-
 net/9p/trans_virtio.c                              |    4 +-
 net/9p/trans_xen.c                                 |    2 +-
 net/batman-adv/bridge_loop_avoidance.c             |    2 +-
 net/bluetooth/l2cap_core.c                         |   64 +-
 net/bluetooth/rfcomm/core.c                        |   50 +-
 net/bluetooth/rfcomm/sock.c                        |   46 +-
 net/bluetooth/sco.c                                |   30 +-
 net/bpf/test_run.c                                 |    3 +
 net/bridge/br_netfilter_hooks.c                    |   21 +-
 net/bridge/netfilter/ebtable_broute.c              |    8 -
 net/bridge/netfilter/ebtable_filter.c              |    8 -
 net/bridge/netfilter/ebtable_nat.c                 |    8 -
 net/bridge/netfilter/ebtables.c                    |    8 +-
 net/can/j1939/socket.c                             |    5 +-
 net/can/j1939/transport.c                          |    8 +-
 net/core/bpf_sk_storage.c                          |   17 +-
 net/core/dev.c                                     |   22 +-
 net/core/devlink.c                                 |    4 +-
 net/core/drop_monitor.c                            |   10 +-
 net/core/filter.c                                  |   18 +-
 net/core/gro_cells.c                               |    2 +-
 net/core/neighbour.c                               |   27 +-
 net/core/secure_seq.c                              |    4 +-
 net/core/skbuff.c                                  |   14 +-
 net/core/skmsg.c                                   |    8 +-
 net/core/sock.c                                    |   18 +-
 net/core/sock_map.c                                |   20 +-
 net/core/sock_reuseport.c                          |    4 +-
 net/core/sysctl_net_core.c                         |   15 +-
 net/dccp/proto.c                                   |   10 +-
 net/decnet/af_decnet.c                             |    4 +-
 net/dsa/port.c                                     |    7 +-
 net/dsa/slave.c                                    |    4 +-
 net/hsr/hsr_device.c                               |    2 +-
 net/hsr/hsr_main.c                                 |    2 +-
 net/ipv4/af_inet.c                                 |    8 +-
 net/ipv4/cipso_ipv4.c                              |   12 +-
 net/ipv4/devinet.c                                 |   16 +-
 net/ipv4/fib_semantics.c                           |    6 +-
 net/ipv4/fib_trie.c                                |    9 +-
 net/ipv4/icmp.c                                    |   18 +-
 net/ipv4/igmp.c                                    |   49 +-
 net/ipv4/inet_connection_sock.c                    |    5 +-
 net/ipv4/inet_hashtables.c                         |   17 +-
 net/ipv4/inetpeer.c                                |   12 +-
 net/ipv4/ip_forward.c                              |    2 +-
 net/ipv4/ip_input.c                                |   26 +-
 net/ipv4/ip_output.c                               |    2 +-
 net/ipv4/ip_sockglue.c                             |   14 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |    4 +-
 net/ipv4/nexthop.c                                 |    5 +-
 net/ipv4/proc.c                                    |    2 +-
 net/ipv4/route.c                                   |   10 +-
 net/ipv4/syncookies.c                              |   11 +-
 net/ipv4/sysctl_net_ipv4.c                         |   14 +-
 net/ipv4/tcp.c                                     |   36 +-
 net/ipv4/tcp_fastopen.c                            |    9 +-
 net/ipv4/tcp_input.c                               |   94 +-
 net/ipv4/tcp_ipv4.c                                |   81 +-
 net/ipv4/tcp_metrics.c                             |   13 +-
 net/ipv4/tcp_minisocks.c                           |    4 +-
 net/ipv4/tcp_output.c                              |   86 +-
 net/ipv4/tcp_recovery.c                            |    6 +-
 net/ipv4/tcp_timer.c                               |   30 +-
 net/ipv4/udp.c                                     |   13 +-
 net/ipv6/addrconf.c                                |    5 +-
 net/ipv6/af_inet6.c                                |    2 +-
 net/ipv6/icmp.c                                    |    2 +-
 net/ipv6/inet6_hashtables.c                        |    6 +-
 net/ipv6/ip6_output.c                              |    3 +-
 net/ipv6/ipv6_sockglue.c                           |    4 +-
 net/ipv6/mcast.c                                   |   14 +-
 net/ipv6/ndisc.c                                   |    3 +
 net/ipv6/ping.c                                    |    6 +
 net/ipv6/route.c                                   |    2 +-
 net/ipv6/seg6_iptunnel.c                           |    5 +-
 net/ipv6/seg6_local.c                              |    2 -
 net/ipv6/syncookies.c                              |    3 +-
 net/ipv6/tcp_ipv6.c                                |    4 +-
 net/ipv6/udp.c                                     |    2 +-
 net/key/af_key.c                                   |    3 +
 net/mac80211/agg-rx.c                              |    2 +-
 net/mac80211/sta_info.c                            |    6 +-
 net/mac80211/wme.c                                 |    4 +-
 net/mptcp/protocol.c                               |  146 ++-
 net/netfilter/Kconfig                              |    1 -
 net/netfilter/core.c                               |    3 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |    4 +-
 net/netfilter/nf_flow_table_core.c                 |   15 +-
 net/netfilter/nf_flow_table_offload.c              |    8 +
 net/netfilter/nf_log_syslog.c                      |    8 +-
 net/netfilter/nf_synproxy_core.c                   |    2 +-
 net/netfilter/nf_tables_api.c                      |  256 ++--
 net/netfilter/nf_tables_core.c                     |   55 +-
 net/netfilter/nfnetlink_queue.c                    |    7 +-
 net/netfilter/nft_bitwise.c                        |   67 +-
 net/netfilter/nft_cmp.c                            |  140 ++-
 net/netfilter/nft_immediate.c                      |   22 +-
 net/netfilter/nft_osf.c                            |   18 +-
 net/netfilter/nft_payload.c                        |   29 +-
 net/netfilter/nft_range.c                          |   27 +-
 net/netfilter/nft_tunnel.c                         |    1 +
 net/netlink/genetlink.c                            |    6 +-
 net/netlink/policy.c                               |   14 +-
 net/packet/af_packet.c                             |    4 +-
 net/qrtr/mhi.c                                     |   12 +-
 net/rds/ib_recv.c                                  |    1 +
 net/rose/af_rose.c                                 |   11 +-
 net/rose/rose_loopback.c                           |    3 +-
 net/rose/rose_route.c                              |    2 +
 net/rxrpc/call_object.c                            |    4 +-
 net/rxrpc/sendmsg.c                                |   92 +-
 net/sched/cls_route.c                              |   12 +-
 net/sched/sch_generic.c                            |    2 +-
 net/sctp/associola.c                               |    5 +-
 net/sctp/protocol.c                                |    2 +-
 net/sctp/stream.c                                  |   19 +-
 net/sctp/stream_sched.c                            |    2 +-
 net/smc/smc_llc.c                                  |    2 +-
 net/socket.c                                       |    2 +-
 net/sunrpc/auth.c                                  |    2 +-
 net/sunrpc/backchannel_rqst.c                      |   14 +
 net/sunrpc/clnt.c                                  |    2 +-
 net/sunrpc/sysfs.c                                 |    6 +-
 net/tipc/socket.c                                  |    3 +-
 net/tls/tls_device.c                               |   19 +-
 net/tls/tls_main.c                                 |    7 +-
 net/vmw_vsock/af_vsock.c                           |   10 +-
 net/xfrm/espintcp.c                                |    2 +-
 net/xfrm/xfrm_input.c                              |    2 +-
 net/xfrm/xfrm_policy.c                             |    8 +-
 net/xfrm/xfrm_state.c                              |    3 +-
 scripts/Makefile.build                             |    1 +
 scripts/Makefile.gcc-plugins                       |    2 +-
 scripts/Makefile.modpost                           |    3 +-
 .../dummy-plugin-dir/include/plugin-version.h      |    0
 scripts/dummy-tools/gcc                            |    8 +-
 scripts/faddr2line                                 |    4 +-
 scripts/gdb/linux/dmesg.py                         |   42 +-
 scripts/gdb/linux/utils.py                         |   14 +-
 scripts/link-vmlinux.sh                            |    3 +
 scripts/module.lds.S                               |    2 +
 scripts/sorttable.c                                |    4 +-
 security/Kconfig                                   |   11 -
 security/apparmor/apparmorfs.c                     |    2 +-
 security/apparmor/audit.c                          |    2 +-
 security/apparmor/domain.c                         |    2 +-
 security/apparmor/include/lib.h                    |    5 +
 security/apparmor/include/policy.h                 |    2 +-
 security/apparmor/label.c                          |   13 +-
 security/apparmor/mount.c                          |    8 +-
 security/apparmor/policy_unpack.c                  |   12 +-
 security/integrity/evm/evm_crypto.c                |    7 +-
 security/integrity/ima/ima_appraise.c              |    3 +-
 security/integrity/ima/ima_crypto.c                |    1 +
 security/integrity/ima/ima_efi.c                   |    2 +
 security/integrity/ima/ima_policy.c                |    4 +
 security/selinux/ss/policydb.h                     |    2 +
 security/selinux/ss/services.c                     |    9 +-
 sound/core/control.c                               |    7 +-
 sound/core/info.c                                  |    6 +-
 sound/core/misc.c                                  |   94 ++
 sound/core/timer.c                                 |   11 +-
 sound/pci/hda/patch_cirrus.c                       |    1 +
 sound/pci/hda/patch_conexant.c                     |   12 +-
 sound/pci/hda/patch_realtek.c                      |   36 +
 sound/soc/atmel/mchp-spdifrx.c                     |    9 +-
 sound/soc/codecs/cros_ec_codec.c                   |    1 +
 sound/soc/codecs/cs47l15.c                         |    5 +-
 sound/soc/codecs/da7210.c                          |    2 +
 sound/soc/codecs/madera.c                          |   14 +-
 sound/soc/codecs/max98373-sdw.c                    |   12 +-
 sound/soc/codecs/msm8916-wcd-digital.c             |   46 +-
 sound/soc/codecs/mt6359-accdet.c                   |    1 +
 sound/soc/codecs/mt6359.c                          |    1 +
 sound/soc/codecs/rt1308-sdw.c                      |   11 +
 sound/soc/codecs/rt1316-sdw.c                      |   11 +
 sound/soc/codecs/rt5682-sdw.c                      |    5 +-
 sound/soc/codecs/rt700-sdw.c                       |    6 +-
 sound/soc/codecs/rt700.c                           |   14 +-
 sound/soc/codecs/rt711-sdca-sdw.c                  |    9 +-
 sound/soc/codecs/rt711-sdca.c                      |   18 +-
 sound/soc/codecs/rt711-sdw.c                       |    9 +-
 sound/soc/codecs/rt711.c                           |   16 +-
 sound/soc/codecs/rt715-sdca-sdw.c                  |   12 +
 sound/soc/codecs/rt715-sdw.c                       |   12 +
 sound/soc/codecs/sgtl5000.c                        |    9 +
 sound/soc/codecs/sgtl5000.h                        |    1 +
 sound/soc/codecs/tas2764.c                         |   46 +-
 sound/soc/codecs/tas2764.h                         |    6 +-
 sound/soc/codecs/tas2770.c                         |   98 +-
 sound/soc/codecs/tas2770.h                         |    5 +
 sound/soc/codecs/tlv320aic32x4.c                   |    9 +
 sound/soc/codecs/wcd9335.c                         |   81 +-
 sound/soc/codecs/wcd938x.c                         |   12 +
 sound/soc/codecs/wm5110.c                          |    8 +-
 sound/soc/fsl/fsl-asoc-card.c                      |    5 +-
 sound/soc/fsl/fsl_asrc.c                           |    6 +-
 sound/soc/fsl/fsl_easrc.c                          |    9 +-
 sound/soc/fsl/fsl_easrc.h                          |    2 +-
 sound/soc/fsl/imx-audmux.c                         |    2 +-
 sound/soc/fsl/imx-card.c                           |   22 +-
 sound/soc/generic/audio-graph-card.c               |    4 +-
 sound/soc/intel/boards/bytcr_wm5102.c              |   13 +-
 sound/soc/intel/boards/sof_sdw.c                   |   51 +-
 sound/soc/intel/skylake/skl-nhlt.c                 |   40 +-
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          |    6 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   10 +-
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |    9 +-
 sound/soc/qcom/lpass-cpu.c                         |    1 +
 sound/soc/qcom/qdsp6/q6adm.c                       |    2 +-
 sound/soc/samsung/aries_wm8994.c                   |    6 +-
 sound/soc/samsung/h1940_uda1380.c                  |    2 +-
 sound/soc/samsung/rx1950_uda1380.c                 |    4 +-
 sound/soc/sh/rcar/ssiu.c                           |    2 +
 sound/soc/sh/rz-ssi.c                              |   26 +-
 sound/soc/soc-dapm.c                               |    5 +
 sound/soc/soc-ops.c                                |    4 +-
 sound/soc/sof/debug.c                              |    6 +-
 sound/soc/sof/intel/apl.c                          |    1 +
 sound/soc/sof/intel/cnl.c                          |    2 +
 sound/soc/sof/intel/hda-loader.c                   |   22 +-
 sound/soc/sof/intel/hda.c                          |   10 +-
 sound/soc/sof/intel/icl.c                          |    1 +
 sound/soc/sof/intel/shim.h                         |    1 +
 sound/soc/sof/intel/tgl.c                          |    4 +
 sound/usb/bcd2000/bcd2000.c                        |    3 +-
 sound/usb/card.c                                   |    8 +
 sound/usb/mixer_maps.c                             |   34 +-
 sound/usb/quirks-table.h                           |  248 ++++
 sound/usb/quirks.c                                 |   13 +
 tools/arch/x86/include/asm/cpufeatures.h           |   13 +-
 tools/arch/x86/include/asm/disabled-features.h     |   21 +-
 tools/arch/x86/include/asm/msr-index.h             |   17 +
 tools/build/feature/test-libcrypto.c               |   15 +-
 tools/include/linux/objtool.h                      |    9 +-
 tools/include/uapi/linux/bpf.h                     |    3 +-
 tools/kvm/kvm_stat/kvm_stat                        |    3 +-
 tools/lib/bpf/gen_loader.c                         |    2 +-
 tools/lib/bpf/libbpf.c                             |    9 +-
 tools/lib/bpf/xsk.c                                |    9 +-
 tools/objtool/arch/x86/decode.c                    |  145 +--
 tools/objtool/builtin-check.c                      |    4 +-
 tools/objtool/check.c                              |  701 +++++++++--
 tools/objtool/elf.c                                |   84 --
 tools/objtool/include/objtool/arch.h               |    3 +-
 tools/objtool/include/objtool/builtin.h            |    2 +-
 tools/objtool/include/objtool/cfi.h                |    2 +
 tools/objtool/include/objtool/check.h              |   10 +-
 tools/objtool/include/objtool/elf.h                |    9 +-
 tools/objtool/include/objtool/objtool.h            |    1 +
 tools/objtool/objtool.c                            |    1 +
 tools/objtool/orc_gen.c                            |   15 +-
 tools/objtool/special.c                            |    8 -
 tools/perf/Makefile.config                         |    2 +-
 tools/perf/builtin-stat.c                          |    1 +
 tools/perf/tests/perf-time-to-tsc.c                |   18 +-
 tools/perf/tests/switch-tracking.c                 |   18 +-
 tools/perf/util/dsos.c                             |   15 +-
 tools/perf/util/genelf.c                           |    6 +-
 tools/perf/util/parse-events.c                     |   14 +-
 tools/perf/util/probe-event.c                      |    6 +-
 tools/perf/util/symbol-elf.c                       |   60 +-
 tools/testing/nvdimm/test/iomap.c                  |   43 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |    2 +-
 .../testing/selftests/bpf/prog_tests/sock_fields.c |   58 +-
 .../testing/selftests/bpf/progs/test_sock_fields.c |   45 +
 tools/testing/selftests/bpf/verifier/sock.c        |   81 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    1 -
 tools/testing/selftests/kvm/lib/aarch64/ucall.c    |    9 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c |    2 +-
 tools/testing/selftests/kvm/rseq_test.c            |    8 +-
 tools/testing/selftests/kvm/x86_64/hyperv_clock.c  |   10 +-
 .../net/forwarding/custom_multipath_hash.sh        |   24 +-
 .../net/forwarding/gre_custom_multipath_hash.sh    |   24 +-
 .../net/forwarding/ip6gre_custom_multipath_hash.sh |   24 +-
 tools/testing/selftests/netfilter/nft_flowtable.sh |  246 ++--
 tools/testing/selftests/seccomp/seccomp_bpf.c      |    2 +-
 .../testing/selftests/timers/clocksource-switch.c  |    6 +-
 tools/testing/selftests/timers/valid-adjtimex.c    |    2 +-
 tools/testing/selftests/vm/mremap_test.c           |   53 -
 tools/thermal/tmon/sysfs.c                         |   24 +-
 tools/thermal/tmon/tmon.h                          |    3 +
 tools/vm/slabinfo.c                                |   58 +-
 virt/kvm/kvm_main.c                                |   35 +-
 1676 files changed, 25222 insertions(+), 14814 deletions(-)
---
