Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914A648471E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiADRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:41:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59646 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiADRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:41:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EF6CB817A7;
        Tue,  4 Jan 2022 17:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4851C36AED;
        Tue,  4 Jan 2022 17:41:07 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.12-rt25
Date:   Tue, 04 Jan 2022 17:40:19 -0000
Message-ID: <164131801914.517938.12860451937381531618@puck.lan>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.12-rt25 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 1907da15a6033b40c0c91e50db3e0736268d4a4c

Or to build 5.15.12-rt25 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.12.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.12-rt25.patch.xz


You can also build from 5.15.10-rt24 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.10-rt24-rt25.patch.xz

Enjoy!
Clark

Changes from v5.15.10-rt24:
---

Adrian Hunter (2):
      perf inject: Fix segfault due to close without open
      perf inject: Fix segfault due to perf_data__fd() without open

Alan Stern (1):
      USB: core: Make do_proc_control() and do_proc_bulk() killable

Alejandro Concepcion-Rodriguez (1):
      drm: simpledrm: fix wrong unit with pixel clock

Alex Bee (1):
      arm64: dts: rockchip: fix audio-supply for Rock Pi 4

Alexei Starovoitov (2):
      bpf: Fix extable fixup offset.
      bpf: Fix extable address check.

Alexey Gladkov (1):
      ucounts: Fix rlimit max values check

Alyssa Ross (1):
      dmaengine: st_fdma: fix MODULE_ALIAS

Amelie Delaunay (1):
      usb: dwc2: fix STM ID/VBUS detection startup delay in dwc2_driver_probe

Anand Jain (4):
      btrfs: convert latest_bdev type to btrfs_device and rename
      btrfs: use latest_dev in btrfs_show_devname
      btrfs: update latest_dev when we create a sprout device
      btrfs: remove stale comment about the btrfs_show_devname

Andrea Righi (1):
      Input: elantech - fix stack out of bound access in elantech_change_report_id()

Andrew Cooper (1):
      x86/pkey: Fix undefined behaviour with PKRU_WD_BIT

Andrew Jones (1):
      selftests: KVM: Fix non-x86 compiling

Andrey Eremeev (1):
      dsa: mv88e6xxx: fix debug print for SPEED_UNFORCED

Andrey Ryabinin (1):
      mm: mempolicy: fix THP allocations escaping mempolicy restrictions

Andy Shevchenko (1):
      platform/x86/intel: Remove X86_PLATFORM_DRIVERS_INTEL

AngeloGioacchino Del Regno (1):
      drm/mediatek: hdmi: Perform NULL pointer check for mtk_hdmi_conf

Ard Biesheuvel (1):
      ARM: 9169/1: entry: fix Thumb2 bug in iWMMXt exception handling

Arnd Bergmann (1):
      virtio: always enter drivers/virtio/

Artem Lapkin (1):
      arm64: dts: rockchip: remove mmc-hs400-enhanced-strobe from rk3399-khadas-edge

Baokun Li (1):
      kfence: fix memory leak when cat kfence objects

Baowen Zheng (1):
      flow_offload: return EOPNOTSUPP for the unsupported mpls action type

Benjamin Tissoires (1):
      HID: holtek: fix mouse probing

Bin Meng (2):
      riscv: dts: unleashed: Add gpio card detect to mmc-spi-slot
      riscv: dts: unmatched: Add gpio card detect to mmc-spi-slot

Borislav Petkov (1):
      Revert "x86/boot: Pull up cmdline preparation and early param parsing"

Bradley Scott (2):
      ALSA: hda/realtek: Amp init fixup for HP ZBook 15 G6
      ALSA: hda/realtek: Add new alc285-hp-amp-init model

Chao Yu (1):
      f2fs: fix to do sanity check on last xattr entry in __f2fs_setxattr()

Christian Brauner (1):
      ceph: fix up non-directory creation in SGID directories

Chuck Lever (1):
      NFSD: Fix READDIR buffer overflow

Chunfeng Yun (1):
      usb: xhci-mtk: fix list_del warning when enable list debug

Clark Williams (2):
      Merge tag 'v5.15.12' into v5.15-rt
      Linux 5.15.12-rt25

Colin Ian King (1):
      ALSA: drivers: opl3: Fix incorrect use of vp->state

Cyril Novikov (1):
      ixgbe: set X550 MDIO speed before talking to PHY

D. Wythe (1):
      net/smc: Prevent smc_release() from long blocking

Dan Carpenter (5):
      vduse: fix memory corruption in vduse_dev_ioctl()
      vduse: check that offset is within bounds in get_config()
      vdpa: check that offsets are within bounds
      tee: amdtee: fix an IS_ERR() vs NULL bug
      ksmbd: fix error code in ndr_read_int32()

Daniel Borkmann (7):
      bpf: Fix kernel address leakage in atomic fetch
      bpf, selftests: Add test case for atomic fetch on spilled pointer
      bpf: Fix signed bounds propagation after mov32
      bpf: Make 32->64 bounds propagation slightly more robust
      bpf, selftests: Add test case trying to taint map value pointer
      bpf: Fix kernel address leakage in atomic cmpxchg's r0 aux reg
      bpf, selftests: Update test case for atomic cmpxchg on r0 with pointer

Daniele Palmas (1):
      USB: serial: option: add Telit FN990 compositions

Dave Jiang (3):
      dmaengine: idxd: add halt interrupt support
      dmaengine: idxd: fix calling wq quiesce inside spinlock
      dmaengine: idxd: fix missed completion on abort path

David Ahern (3):
      selftests: Add duplicate config only for MD5 VRF tests
      selftests: Fix raw socket bind tests with VRF
      selftests: Fix IPv6 address bind tests

David Howells (1):
      afs: Fix mmap

Davide Caratti (1):
      net/sched: sch_ets: don't remove idle classes from the round-robin list

Derek Fang (1):
      ASoC: rt5682: fix the wrong jack type detected

Dinh Nguyen (1):
      ARM: socfpga: dts: fix qspi node compatible

Dmitry Osipenko (2):
      ASoC: tegra: Add DAPM switches for headphones and mic jack
      ASoC: tegra: Restore headphones jack name on Nyan Big

Dongliang Mu (1):
      spi: change clk_disable_unprepare to clk_unprepare

Eric Dumazet (7):
      sch_cake: do not call cake_destroy() from cake_init()
      inet_diag: fix kernel-infoleak for UDP sockets
      sit: do not call ipip6_dev_free() from sit_init_net()
      netfilter: nf_tables: fix use-after-free in nft_set_catchall_destroy()
      tcp: move inet->rx_dst_ifindex to sk->sk_rx_dst_ifindex
      ipv6: move inet6_sk(sk)->rx_dst_cookie to sk->sk_rx_dst_cookie
      inet: fully convert sk->sk_rx_dst to RCU rules

Fabien Dessenne (1):
      pinctrl: stm32: consider the GPIO offset to expose all the GPIO lines

Fabio Estevam (1):
      ARM: dts: imx6ull-pinfunc: Fix CSI_DATA07__ESAI_TX0 pad name

Felix Fietkau (3):
      mac80211: fix rate control for retransmitted frames
      mac80211: fix regression in SSN handling of addba tx
      mac80211: send ADDBA requests using the tid/queue of the aggregation session

Fernando Fernandez Mancera (1):
      bonding: fix ad_actor_system option setting to default

Filip Pokryvka (1):
      netdevsim: don't overwrite read only ethtool parms

Filipe Manana (1):
      btrfs: fix double free of anon_dev after failure to create subvolume

Florian Fainelli (1):
      net: systemport: Add global locking for descriptor lifecycle

Florian Klink (1):
      arm64: dts: rockchip: fix poweroff on helios64

Florian Westphal (2):
      mptcp: remove tcp ulp setsockopt support
      mptcp: clear 'kern' flag from fallback sockets

Gal Pressman (1):
      net: Fix double 0x prefix print in SKB dump

George Kennedy (5):
      libata: if T_LENGTH is zero, dma direction should be DMA_NONE
      scsi: scsi_debug: Don't call kcalloc() if size arg is zero
      scsi: scsi_debug: Fix type in min_t to avoid stack OOB
      scsi: scsi_debug: Sanity check block descriptor length in resp_mode_select()
      tun: avoid double free in tun_free_netdev

Greg Jesionowski (1):
      net: usb: lan78xx: add Allied Telesis AT29M2-AF

Greg Kroah-Hartman (4):
      USB: gadget: bRequestType is a bitfield, not a enum
      Revert "usb: early: convert to readl_poll_timeout_atomic()"
      Linux 5.15.11
      Linux 5.15.12

Guenter Roeck (7):
      hwmon: (lm90) Fix usage of CONFIG2 register in detect function
      hwmon: (lm90) Prevent integer overflow/underflow in hysteresis calculations
      hwmon: (lm90) Introduce flag indicating extended temperature support
      hwmon: (lm90) Add basic support for TI TMP461
      hwmon: (lm90) Drop critical attribute support for MAX6654
      hwmom: (lm90) Fix citical alarm status for MAX6680/MAX6681
      hwmon: (lm90) Do not report 'busy' status bit as alarm

Guodong Liu (1):
      pinctrl: mediatek: fix global-out-of-bounds issue

Gustavo A. R. Silva (1):
      net: bridge: Use array_size() helper in copy_to_user()

Haimin Zhang (1):
      netdevsim: Zero-initialize memory for new map's value in function nsim_bpf_map_alloc

Hangbin Liu (1):
      selftest/net/forwarding: declare NETIFS p9 p10

Hangyu Hua (1):
      rds: memory leak in __rds_conn_create()

Hans de Goede (1):
      Input: goodix - add id->model mapping for the "9111" model

Harshit Mogalapalli (1):
      drm/i915/display: Fix an unsigned subtraction which can never be negative.

Hawking Zhang (1):
      drm/amdgpu: don't override default ECO_BITs setting

Hayes Wang (2):
      r8152: fix the force speed doesn't work for RTL8156
      r8152: sync ocp base

Heiner Kallweit (1):
      igb: fix deadlock caused by taking RTNL in RPM resume path

Hu Weiwen (1):
      ceph: fix duplicate increment of opened_inodes metric

Ignacy Gawędzki (1):
      netfilter: fix regression in looped (broad|multi)cast's MAC handling

Ilan Peer (1):
      cfg80211: Acquire wiphy mutex on regulatory work

Ismael Luceno (1):
      uapi: Fix undefined __always_inline on non-glibc systems

Jaegeuk Kim (1):
      scsi: ufs: core: Retry START_STOP on UNIT_ATTENTION

Jani Nikula (1):
      drm/i915/hdmi: convert intel_hdmi_to_dev to intel_hdmi_to_i915

Jaroslav Kysela (1):
      ALSA: rawmidi - fix the uninitalized user_pversion

Javier Martinez Canillas (1):
      Revert "drm/fb-helper: improve DRM fbdev emulation device names"

Jeff LaBundy (1):
      Input: iqs626a - prohibit inlining of channel parsing functions

Jeffle Xu (1):
      netfs: fix parameter of cleanup()

Jens Axboe (4):
      io-wq: remove spurious bit clear on task_work addition
      io-wq: check for wq exit after adding new worker task_work
      io-wq: drop wqe lock before creating new worker
      io_uring: zero iocb->ki_pos for stream file types

Jens Wiklander (1):
      tee: handle lookup of shm with reference count 0

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ProBook

Jernej Skrabec (1):
      bus: sunxi-rsb: Fix shutdown

Jerome Marchand (1):
      recordmcount.pl: look for jgnop instruction as well as bcrl on s390

Ji-Ze Hong (Peter Hong) (1):
      serial: 8250_fintek: Fix garbled text for console

Jiacheng Shi (1):
      RDMA/hns: Replace kfree() with kvfree()

Jianglei Nie (1):
      btrfs: fix memory leak in __add_inode_ref()

Jiasheng Jiang (9):
      drm/ast: potential dereference of null pointer
      sfc_ef100: potential dereference of null pointer
      HID: potential dereference of null pointer
      qlcnic: potential dereference null pointer of rx_queue->page_ring
      fjes: Check for error irq
      drivers: net: smc911x: Check for error irq
      net: ks8851: Check for error irq
      sfc: Check null pointer of rx_queue->page_ring
      sfc: falcon: Check null pointer of rx_queue->page_ring

Jie Meng (1):
      bpf, x64: Factor out emission of REX byte in more cases

Jie Wang (1):
      net: hns3: fix use-after-free bug in hclgevf_send_mbx_msg

Jie2x Zhou (1):
      selftests: net: Correct ping6 expected rc from 2 to 1

Jimmy Wang (1):
      USB: NO_LPM quirk Lenovo USB-C to Ethernet Adapher(RTL8153-04)

Joe Thornber (1):
      dm btree remove: fix use after free in rebalance_children()

Johan Hovold (2):
      USB: serial: cp210x: fix CP2105 GPIO registration
      platform/x86: intel_pmc_core: fix memleak on registration failure

Johannes Berg (7):
      mac80211: mark TX-during-stop for TX in in_reconfig
      mac80211: validate extended element ID is present
      mac80211: track only QoS data frames for admission control
      iwlwifi: mvm: don't crash on invalid rate w/o STA
      mac80211: agg-tx: don't schedule_and_wake_txq() under sta->lock
      mac80211: fix lookup when adding AddBA extension element
      mac80211: fix locking in ieee80211_start_ap error path

John David Anglin (2):
      parisc: Correct completer in lws start
      parisc: Fix mask used to select futex spinlock

John Keeping (3):
      arm64: dts: rockchip: fix rk3308-roc-cc vcc-sd supply
      arm64: dts: rockchip: fix rk3399-leez-p710 vcc3v3-lan supply
      net: stmmac: dwmac-rk: fix oob read in rk_gmac_setup

Johnny Chuang (1):
      Input: elants_i2c - do not check Remark ID on eKTH3900/eKTH5312

Jon Hunter (1):
      reset: tegra-bpmp: Revert Handle errors in BPMP response

Josef Bacik (1):
      btrfs: check WRITE_ERR when trying to read an extent buffer

Josh Poimboeuf (1):
      compiler.h: Fix annotation macro misplacement with Clang

José Expósito (2):
      IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()
      Input: atmel_mxt_ts - fix double free in mxt_read_info_block

Juergen Gross (6):
      x86/kvm: remove unused ack_notifier callbacks
      xen/blkfront: harden blkfront against event channel storms
      xen/netfront: harden netfront against event channel storms
      xen/console: harden hvc_xen against event channel storms
      xen/netback: fix rx queue stall detection
      xen/netback: don't queue unlimited number of packages

Kai Vehmanen (2):
      ASoC: SOF: Intel: pci-tgl: add new ADL-P variant
      ASoC: SOF: Intel: pci-tgl: add ADL-N support

Karen Sornek (1):
      igb: Fix removal of unicast MAC filters of VFs

Karol Kolacinski (2):
      ice: Use div64_u64 instead of div_u64 in adjfine
      ice: Don't put stale timestamps in the skb

Lai Jiangshan (1):
      KVM: X86: Fix tlb flush for tdp in kvm_invalidate_pcid()

Lakshmi Ramasubramanian (1):
      arm64: kexec: Fix missing error code 'ret' warning in load_other_segments()

Lang Yu (1):
      drm/amd/pm: fix a potential gpu_metrics_table memory leak

Le Ma (1):
      drm/amdgpu: correct register access for RLC_JUMP_TABLE_RESTORE

Letu Ren (1):
      igbvf: fix double free in `igbvf_probe`

Lin Ma (3):
      ax25: NPD bug when detaching AX25 device
      hamradio: defer ax25 kfree after unregister_netdev
      hamradio: improve the incomplete fix to avoid NPD

Liu Shixin (1):
      mm/hwpoison: clear MF_COUNT_INCREASED before retrying get_any_page()

Maciej Fijalkowski (1):
      ice: xsk: return xsk buffers back to pool when cleaning the ring

Magnus Karlsson (3):
      xsk: Do not sleep in poll() when need_wakeup set
      Revert "xsk: Do not sleep in poll() when need_wakeup set"
      ice: Use xdp_buf instead of rx_buf for xsk zero-copy

Marc Orr (1):
      KVM: x86: Always set kvm_run->if_flag

Marcos Del Sol Vives (1):
      ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Marek Behún (1):
      net: dsa: mv88e6xxx: Unforce speed & duplex in mac_link_down()

Marian Postevca (1):
      usb: gadget: u_ether: fix race in setting MAC address in setup phase

Mario Limonciello (3):
      pinctrl: amd: Fix wakeups when IRQ is shared with SCI
      drm/amd/pm: fix reading SMU FW version from amdgpu_firmware_info on YC
      platform/x86: amd-pmc: only use callbacks for suspend

Martin Blumenstingl (3):
      ASoC: meson: aiu: fifo: Add missing dma_coerce_mask_and_coherent()
      ASoC: meson: aiu: Move AIU_I2S_MISC hold setting to aiu-fifo-i2s
      mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands

Martin Haaß (1):
      ARM: dts: imx6qdl-wandboard: Fix Ethernet support

Martin KaFai Lau (1):
      bpf, selftests: Fix racing issue in btf_skc_cls_ingress test

Martin Kepplinger (1):
      arm64: dts: imx8mq: remove interconnect property from lcdif

Martin Povišer (1):
      ASoC: tas2770: Fix setting of high sample rates

Mathew McBride (1):
      arm64: dts: ten64: remove redundant interrupt declaration for gpio-keys

Matthias Schiffer (3):
      Revert "can: m_can: remove support for custom bit timing"
      can: m_can: make custom bittiming fields const
      can: m_can: pci: use custom bit timings for Elkhart Lake

Matthieu Baerts (1):
      mptcp: add missing documented NL params

Maxim Galaganov (1):
      mptcp: fix deadlock in __mptcp_push_pending()

Mian Yousaf Kaukab (1):
      ipmi: ssif: initialize ssif_info->client early

Mike Rapoport (1):
      x86/boot: Move EFI range reservation after cmdline parsing

Mike Tipton (1):
      clk: Don't parent clks until the parent is fully registered

Miklos Szeredi (2):
      fuse: annotate lock in fuse_reverse_inval_entry()
      ovl: fix warning in ovl_create_real()

Namjae Jeon (1):
      ksmbd: fix uninitialized symbol 'pntsd_size'

Naohiro Aota (1):
      zonefs: add MODULE_ALIAS_FS

Naoya Horiguchi (1):
      mm, hwpoison: fix condition in free hugetlb page path

Nathan Chancellor (1):
      soc/tegra: fuse: Fix bitwise vs. logical OR warning

Nehal Bakulchandra Shah (1):
      usb: xhci: Extend support for runtime power management for AMD's Yellow carp.

Nicholas Kazlauskas (1):
      drm/amd/display: Set exit_optimized_pwr_state for DCN31

Nick Desaulniers (1):
      arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd

Nobuhiro Iwamatsu (1):
      net: stmmac: dwmac-visconti: Fix value of ETHER_CLK_SEL_FREQ_SEL_2P5M

Noralf Trønnes (1):
      gpio: dln2: Fix interrupts when replugging the device

Ong Boon Leong (1):
      net: stmmac: fix tc flower deletion for VLAN priority Rx steering

Paolo Abeni (2):
      mptcp: never allow the PM to close a listener subflow
      veth: ensure skb entering GRO are not cloned.

Paolo Bonzini (2):
      KVM: VMX: clear vmx_x86_ops.sync_pir_to_irr if APICv is disabled
      KVM: downgrade two BUG_ONs to WARN_ON_ONCE

Parav Pandit (1):
      vdpa: Consider device id larger than 31

Paul E. McKenney (1):
      rcu: Mark accesses to rcu_state.n_force_qs

Paul Moore (1):
      audit: improve robustness of the audit queue handling

Pavel Skripkin (3):
      media: mxl111sf: change mutex_init() location
      asix: fix uninit-value in asix_mdio_read()
      asix: fix wrong return value in asix_check_host_enable()

Pawel Laszczak (4):
      usb: cdnsp: Fix incorrect status for control request
      usb: cdnsp: Fix incorrect calling of cdnsp_died function
      usb: cdnsp: Fix issue in cdnsp_log_ep trace event
      usb: cdnsp: Fix lack of spin_lock_irqsave/spin_lock_restore

Phil Elwell (1):
      pinctrl: bcm2835: Change init order for gpio hogs

Philipp Rudo (2):
      s390/kexec_file: fix error handling when applying relocations
      kernel/crash_core: suppress unknown crashkernel parameter warning

Po-Hsu Lin (1):
      selftests: icmp_redirect: pass xfail=0 to log_test()

Prathamesh Shete (1):
      mmc: sdhci-tegra: Fix switch to HS400ES mode

Rafael J. Wysocki (1):
      PM: sleep: Fix error handling in dpm_prepare()

Remi Pommarel (1):
      net: bridge: fix ioctl old_deviceless bridge argument

Robert Marko (1):
      arm64: dts: allwinner: orangepi-zero-plus: fix PHY mode

Robert Schlabbach (1):
      ixgbe: Document how to enable NBASE-T support

Russell Currey (1):
      powerpc/module_64: Fix livepatching for RO modules

Rémi Denis-Courmont (1):
      phonet/pep: refuse to enable an unbound pipe

Sasha Neftin (1):
      igc: Fix typo in i225 LTR functions

Scott Mayhew (1):
      selinux: fix sleeping function called from invalid context

Sean Christopherson (5):
      KVM: x86/mmu: Don't advance iterator after restart due to yielding
      KVM: nVMX: Synthesize TRIPLE_FAULT for L2 if emulation is required
      KVM: VMX: Always clear vmx->fail on emulation_required
      KVM: VMX: Wake vCPU when delivering posted IRQ even if vCPU == this vCPU
      KVM: VMX: Fix stale docs for kvm-intel.emulate_invalid_guest_state

SeongJae Park (2):
      selftests/damon: test debugfs file reads/writes with huge count
      mm/damon/dbgfs: protect targets destructions with kdamond_lock

Shin'ichiro Kawasaki (1):
      btrfs: fix missing blkdev_put() call in btrfs_scan_one_device()

Stefan Roese (1):
      PCI/MSI: Mask MSI-X vectors only on success

Stephan Gerhold (1):
      soc: imx: Register SoC device only on i.MX boards

Sudeep Holla (1):
      firmware: arm_scpi: Fix string overflow in SCPI genpd driver

Sumit Garg (1):
      tee: optee: Fix incorrect page free bug

Sven Schnelle (1):
      s390/entry: fix duplicate tracking of irq nesting level

Tejun Heo (1):
      iocost: Fix divide-by-zero on donation from low hweight cgroup

Tetsuo Handa (1):
      tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous

Thadeu Lima de Souza Cascardo (2):
      ipmi: bail out if init_srcu_struct fails
      ipmi: fix initialization when workqueue allocation fails

Thiago Rafael Becker (1):
      cifs: sanitize multiple delimiters in prepath

Thomas Gleixner (1):
      PCI/MSI: Clear PCI_MSIX_FLAGS_MASKALL on error

Tony Lindgren (1):
      bus: ti-sysc: Fix variable set but not used warning for reinit_modules

Ulf Hansson (1):
      mmc: core: Disable card detect during shutdown

Ville Syrjälä (2):
      drm/i915/hdmi: Turn DP++ TMDS output buffers back on in encoder->shutdown()
      ALSA: hda/hdmi: Disable silent stream on GLK

Vincent Whitchurch (1):
      gpio: virtio: remove timeout

Vitaly Kuznetsov (2):
      KVM: selftests: Make sure kvm_create_max_vcpus test won't hit RLIMIT_NOFILE
      KVM: x86: Drop guest CPUID check for host initiated writes to MSR_IA32_PERF_CAPABILITIES

Vladimir Murzin (1):
      ARM: 9160/1: NOMMU: Reload __secondary_data after PROCINFO_INITFUNC

Wei Wang (1):
      virtio/vsock: fix the transport to work with VMADDR_CID_ANY

Werner Sembach (1):
      ALSA: hda/realtek: Fix quirk for Clevo NJ51CU

Will Deacon (1):
      virtio_ring: Fix querying of maximum DMA mapping size for virtio device

Willem de Bruijn (4):
      selftests/net: toeplitz: fix udp option
      net/packet: rx_owner_map depends on pg_vec
      net: accept UFOv6 packages in virtio_net_hdr_to_skb
      net: skip virtio_net_hdr_set_proto if protocol already set

Wu Bo (1):
      ipmi: Fix UAF when uninstall ipmi_si and ipmi_msghandler module

Xiaoke Wang (1):
      ALSA: jack: Check the return value of kstrdup()

Xiaoliang Yang (1):
      net: stmmac: ptp: fix potentially overflowing expression

Xiaoming Ni (1):
      powerpc/85xx: Fix oops when CONFIG_FSL_PMC=n

Xiubo Li (1):
      ceph: initialize pathlen variable in reconnect_caps_cb

Xu Yang (1):
      usb: typec: tcpm: fix tcpm unregister port but leave a pending timer

Yangyang Li (1):
      RDMA/hns: Fix RNR retransmission issue for HIP08

Yann Gautier (1):
      mmc: mmci: stm32: clear DLYB_CR after sending tuning command

Yevhen Orlov (2):
      net: marvell: prestera: fix incorrect return of port_find
      net: marvell: prestera: fix incorrect structure access

Yu Liao (1):
      timekeeping: Really make sure wall_to_monotonic isn't positive

Yufeng Mo (1):
      net: hns3: fix race condition in debugfs

Zhang Yi (3):
      ext4: prevent partial update of the extent blocks
      ext4: check for out-of-order index extents in ext4_valid_extent_entries()
      ext4: check for inconsistent extents between index and leaf block

Zhang Ying-22455 (1):
      arm64: dts: lx2160a: fix scl-gpios property name

Zqiang (1):
      locking/rtmutex: Fix incorrect condition in rtmutex_spin_on_owner()
---
Documentation/admin-guide/kernel-parameters.txt    |   8 +-
 Documentation/hwmon/lm90.rst                       |  10 ++
 Documentation/networking/bonding.rst               |  11 +-
 .../device_drivers/ethernet/intel/ixgbe.rst        |  16 ++
 Documentation/sound/hd-audio/models.rst            |   2 +
 Makefile                                           |   2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   1 +
 arch/arm/boot/dts/imx6ull-pinfunc.h                |   2 +-
 arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts   |   2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |   4 +-
 arch/arm/kernel/entry-armv.S                       |   8 +-
 arch/arm/kernel/head-nommu.S                       |   1 +
 arch/arm64/Kconfig                                 |   3 +-
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts |   2 -
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   2 -
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |   2 +-
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |   1 -
 .../boot/dts/rockchip/rk3399-kobol-helios64.dts    |   1 +
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |   2 +-
 arch/arm64/kernel/machine_kexec_file.c             |   1 +
 arch/arm64/kernel/vdso32/Makefile                  |  17 +-
 arch/parisc/include/asm/futex.h                    |   4 +-
 arch/parisc/kernel/syscall.S                       |   2 +-
 arch/powerpc/kernel/module_64.c                    |  42 ++++-
 arch/powerpc/platforms/85xx/smp.c                  |   4 +-
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |   1 +
 .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts |   2 +
 arch/s390/kernel/irq.c                             |   9 +-
 arch/s390/kernel/machine_kexec_file.c              |   7 +-
 arch/x86/include/asm/kvm-x86-ops.h                 |   1 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/include/asm/pkru.h                        |   4 +-
 arch/x86/kernel/setup.c                            |  72 ++++-----
 arch/x86/kvm/ioapic.h                              |   1 -
 arch/x86/kvm/irq.h                                 |   1 -
 arch/x86/kvm/mmu/tdp_iter.c                        |   6 +
 arch/x86/kvm/mmu/tdp_iter.h                        |   6 +
 arch/x86/kvm/mmu/tdp_mmu.c                         |  29 ++--
 arch/x86/kvm/svm/svm.c                             |  21 +--
 arch/x86/kvm/vmx/vmx.c                             |  49 ++++--
 arch/x86/kvm/x86.c                                 |  23 +--
 arch/x86/net/bpf_jit_comp.c                        | 101 ++++++++----
 block/blk-iocost.c                                 |   9 +-
 drivers/Makefile                                   |   3 +-
 drivers/ata/libata-scsi.c                          |  15 +-
 drivers/base/power/main.c                          |   2 +-
 drivers/block/xen-blkfront.c                       |  15 +-
 drivers/bus/sunxi-rsb.c                            |   8 +-
 drivers/bus/ti-sysc.c                              |   3 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  21 ++-
 drivers/char/ipmi/ipmi_ssif.c                      |   7 +-
 drivers/clk/clk.c                                  |  15 +-
 drivers/dma/idxd/irq.c                             |   7 +-
 drivers/dma/idxd/registers.h                       |   1 +
 drivers/dma/idxd/submit.c                          |  18 ++-
 drivers/dma/st_fdma.c                              |   2 +-
 drivers/firmware/scpi_pm_domain.c                  |  10 +-
 drivers/gpio/gpio-dln2.c                           |  19 ++-
 drivers/gpio/gpio-virtio.c                         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |   1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |   1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |   1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c            |   1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |   1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |   2 -
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c  |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |   3 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   3 +
 drivers/gpu/drm/ast/ast_mode.c                     |   5 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   8 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.c            |   1 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |   1 +
 drivers/gpu/drm/i915/display/intel_dmc.c           |   2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  32 ++--
 drivers/gpu/drm/i915/display/intel_hdmi.h          |   1 +
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  12 +-
 drivers/gpu/drm/tiny/simpledrm.c                   |   2 +-
 drivers/hid/hid-holtek-mouse.c                     |  15 ++
 drivers/hid/hid-vivaldi.c                          |   3 +
 drivers/hwmon/Kconfig                              |   2 +-
 drivers/hwmon/lm90.c                               | 175 +++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  64 +++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   8 +
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   2 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c          |   2 +-
 drivers/input/misc/iqs626a.c                       |  21 +--
 drivers/input/mouse/elantech.c                     |   8 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   2 +-
 drivers/input/touchscreen/elants_i2c.c             |  46 +++++-
 drivers/input/touchscreen/goodix.c                 |   1 +
 drivers/md/persistent-data/dm-btree-remove.c       |   2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.c            |  16 +-
 drivers/mmc/core/core.c                            |   7 +-
 drivers/mmc/core/core.h                            |   1 +
 drivers/mmc/core/host.c                            |   9 ++
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |  16 ++
 drivers/mmc/host/mmci_stm32_sdmmc.c                |   2 +
 drivers/mmc/host/sdhci-tegra.c                     |  43 +++--
 drivers/net/bonding/bond_options.c                 |   2 +-
 drivers/net/can/m_can/m_can.c                      |  24 ++-
 drivers/net/can/m_can/m_can.h                      |   3 +
 drivers/net/can/m_can/m_can_pci.c                  |  48 +++++-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   4 +
 drivers/net/dsa/mv88e6xxx/port.c                   |   4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   5 +-
 drivers/net/ethernet/broadcom/bcmsysport.h         |   1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  20 ++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  13 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   6 +
 drivers/net/ethernet/intel/ice/ice_txrx.h          |  16 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  64 ++++----
 drivers/net/ethernet/intel/igb/igb_main.c          |  47 +++---
 drivers/net/ethernet/intel/igbvf/netdev.c          |   1 +
 drivers/net/ethernet/intel/igc/igc_i225.c          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   3 +
 .../net/ethernet/marvell/prestera/prestera_main.c  |  35 +++--
 drivers/net/ethernet/micrel/ks8851_par.c           |   2 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h  |   2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  12 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |   4 +-
 drivers/net/ethernet/sfc/ef100_nic.c               |   3 +
 drivers/net/ethernet/sfc/falcon/rx.c               |   5 +-
 drivers/net/ethernet/sfc/rx_common.c               |   5 +-
 drivers/net/ethernet/smsc/smc911x.c                |   5 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  17 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  86 ++++++++--
 drivers/net/fjes/fjes_main.c                       |   5 +
 drivers/net/hamradio/mkiss.c                       |   5 +-
 drivers/net/netdevsim/bpf.c                        |   1 +
 drivers/net/netdevsim/ethtool.c                    |   5 +-
 drivers/net/tun.c                                  | 115 +++++++-------
 drivers/net/usb/asix_common.c                      |   8 +-
 drivers/net/usb/lan78xx.c                          |   6 +
 drivers/net/usb/r8152.c                            |  43 ++++-
 drivers/net/veth.c                                 |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   5 +-
 drivers/net/xen-netback/common.h                   |   1 +
 drivers/net/xen-netback/rx.c                       |  77 +++++----
 drivers/net/xen-netfront.c                         | 125 +++++++++++----
 drivers/pci/msi.c                                  |  15 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |  29 ++--
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   |   8 +-
 drivers/pinctrl/pinctrl-amd.c                      |  29 +++-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   8 +-
 drivers/platform/x86/Makefile                      |   2 +-
 drivers/platform/x86/amd-pmc.c                     |   3 +-
 drivers/platform/x86/intel/Kconfig                 |  15 --
 drivers/platform/x86/intel/pmc/pltdrv.c            |   2 +-
 drivers/reset/tegra/reset-bpmp.c                   |   9 +-
 drivers/scsi/scsi_debug.c                          |  42 +++--
 drivers/scsi/ufs/ufshcd.c                          |  12 +-
 drivers/soc/imx/soc-imx.c                          |   4 +
 drivers/soc/tegra/fuse/fuse-tegra.c                |   2 +-
 drivers/soc/tegra/fuse/fuse.h                      |   2 +-
 drivers/spi/spi-armada-3700.c                      |   2 +-
 drivers/tee/amdtee/core.c                          |   5 +-
 drivers/tee/optee/shm_pool.c                       |   6 +-
 drivers/tee/tee_shm.c                              | 171 ++++++++------------
 drivers/tty/hvc/hvc_xen.c                          |  30 +++-
 drivers/tty/n_hdlc.c                               |  23 ++-
 drivers/tty/serial/8250/8250_fintek.c              |  20 ---
 drivers/usb/cdns3/cdnsp-gadget.c                   |  12 ++
 drivers/usb/cdns3/cdnsp-ring.c                     |  11 +-
 drivers/usb/cdns3/cdnsp-trace.h                    |   4 +-
 drivers/usb/core/devio.c                           | 144 +++++++++++++----
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/dwc2/platform.c                        |   3 +
 drivers/usb/early/xhci-dbc.c                       |  15 +-
 drivers/usb/gadget/composite.c                     |   6 +-
 drivers/usb/gadget/function/u_ether.c              |  16 +-
 drivers/usb/gadget/legacy/dbgp.c                   |   6 +-
 drivers/usb/gadget/legacy/inode.c                  |   6 +-
 drivers/usb/host/xhci-mtk-sch.c                    |   2 +-
 drivers/usb/host/xhci-pci.c                        |   6 +-
 drivers/usb/serial/cp210x.c                        |   6 +-
 drivers/usb/serial/option.c                        |   8 +
 drivers/usb/typec/tcpm/tcpm.c                      |  18 ++-
 drivers/vdpa/vdpa.c                                |   3 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   6 +-
 drivers/vhost/vdpa.c                               |   2 +-
 drivers/virtio/virtio_ring.c                       |   2 +-
 drivers/xen/events/events_base.c                   |   6 +
 fs/afs/file.c                                      |   5 +-
 fs/afs/super.c                                     |   1 +
 fs/btrfs/disk-io.c                                 |  14 +-
 fs/btrfs/extent_io.c                               |  10 +-
 fs/btrfs/inode.c                                   |   2 +-
 fs/btrfs/super.c                                   |  26 +--
 fs/btrfs/tree-log.c                                |   1 +
 fs/btrfs/volumes.c                                 |  25 ++-
 fs/btrfs/volumes.h                                 |   6 +-
 fs/ceph/caps.c                                     |  16 +-
 fs/ceph/file.c                                     |  18 ++-
 fs/ceph/mds_client.c                               |   3 +-
 fs/cifs/fs_context.c                               |  38 ++++-
 fs/ext4/extents.c                                  |  95 +++++++----
 fs/f2fs/xattr.c                                    |  11 +-
 fs/fuse/dir.c                                      |   2 +-
 fs/io-wq.c                                         |  31 +++-
 fs/io_uring.c                                      |  10 +-
 fs/ksmbd/ndr.c                                     |   2 +-
 fs/ksmbd/smb2ops.c                                 |   3 -
 fs/ksmbd/smb2pdu.c                                 |  29 +++-
 fs/netfs/read_helper.c                             |   6 +-
 fs/nfsd/nfs3proc.c                                 |  11 +-
 fs/nfsd/nfsproc.c                                  |   8 +-
 fs/overlayfs/dir.c                                 |   3 +-
 fs/overlayfs/overlayfs.h                           |   1 +
 fs/overlayfs/super.c                               |  12 +-
 fs/zonefs/super.c                                  |   1 +
 include/linux/compiler.h                           |   4 +-
 include/linux/instrumentation.h                    |   4 +-
 include/linux/ipv6.h                               |   1 -
 include/linux/tee_drv.h                            |   4 +-
 include/linux/virtio_net.h                         |  25 ++-
 include/net/inet_sock.h                            |   3 +-
 include/net/sock.h                                 |   7 +-
 include/uapi/linux/byteorder/big_endian.h          |   1 +
 include/uapi/linux/byteorder/little_endian.h       |   1 +
 include/uapi/linux/mptcp.h                         |  18 ++-
 include/xen/events.h                               |   1 +
 kernel/audit.c                                     |  21 ++-
 kernel/bpf/verifier.c                              |  49 ++++--
 kernel/crash_core.c                                |  11 ++
 kernel/locking/rtmutex.c                           |   2 +-
 kernel/rcu/tree.c                                  |  10 +-
 kernel/time/timekeeping.c                          |   3 +-
 kernel/ucount.c                                    |  15 +-
 localversion-rt                                    |   2 +-
 mm/damon/dbgfs.c                                   |   2 +
 mm/kfence/core.c                                   |   1 +
 mm/memory-failure.c                                |  14 +-
 mm/mempolicy.c                                     |   3 +-
 net/ax25/af_ax25.c                                 |   4 +-
 net/bridge/br_ioctl.c                              |   8 +-
 net/core/skbuff.c                                  |   2 +-
 net/ipv4/af_inet.c                                 |   2 +-
 net/ipv4/inet_diag.c                               |   4 +-
 net/ipv4/tcp.c                                     |   3 +-
 net/ipv4/tcp_input.c                               |   2 +-
 net/ipv4/tcp_ipv4.c                                |  17 +-
 net/ipv4/udp.c                                     |   6 +-
 net/ipv6/sit.c                                     |   1 -
 net/ipv6/tcp_ipv6.c                                |  23 +--
 net/ipv6/udp.c                                     |   8 +-
 net/mac80211/agg-rx.c                              |   5 +-
 net/mac80211/agg-tx.c                              |  16 +-
 net/mac80211/cfg.c                                 |   3 +
 net/mac80211/driver-ops.h                          |   5 +-
 net/mac80211/mlme.c                                |  13 +-
 net/mac80211/sta_info.h                            |   1 +
 net/mac80211/tx.c                                  |   6 +-
 net/mac80211/util.c                                |   7 +-
 net/mptcp/pm_netlink.c                             |   3 +
 net/mptcp/protocol.c                               |   6 +-
 net/mptcp/sockopt.c                                |   1 -
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nfnetlink_log.c                      |   3 +-
 net/netfilter/nfnetlink_queue.c                    |   3 +-
 net/packet/af_packet.c                             |   5 +-
 net/phonet/pep.c                                   |   2 +
 net/rds/connection.c                               |   1 +
 net/sched/cls_api.c                                |   1 +
 net/sched/sch_cake.c                               |   6 +-
 net/sched/sch_ets.c                                |   4 +-
 net/smc/af_smc.c                                   |   4 +-
 net/vmw_vsock/virtio_transport_common.c            |   3 +-
 net/wireless/reg.c                                 |   7 +-
 scripts/recordmcount.pl                            |   2 +-
 security/selinux/hooks.c                           |  33 ++--
 sound/core/jack.c                                  |   4 +
 sound/core/rawmidi.c                               |   1 +
 sound/drivers/opl3/opl3_midi.c                     |   2 +-
 sound/pci/hda/patch_hdmi.c                         |  21 ++-
 sound/pci/hda/patch_realtek.c                      |  29 +++-
 sound/soc/codecs/rt5682.c                          |   4 +
 sound/soc/codecs/tas2770.c                         |   4 +-
 sound/soc/meson/aiu-encoder-i2s.c                  |  33 ----
 sound/soc/meson/aiu-fifo-i2s.c                     |  19 +++
 sound/soc/meson/aiu-fifo.c                         |   6 +
 sound/soc/sof/intel/pci-tgl.c                      |   4 +
 sound/soc/tegra/tegra_asoc_machine.c               |  11 +-
 sound/soc/tegra/tegra_asoc_machine.h               |   1 +
 tools/perf/builtin-inject.c                        |  13 +-
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c |  16 +-
 .../selftests/bpf/verifier/atomic_cmpxchg.c        |  86 ++++++++++
 .../selftests/bpf/verifier/value_ptr_arith.c       |  23 +++
 tools/testing/selftests/damon/.gitignore           |   2 +
 tools/testing/selftests/damon/Makefile             |   2 +
 tools/testing/selftests/damon/debugfs_attrs.sh     |  18 +++
 .../selftests/damon/huge_count_read_write.c        |  39 +++++
 tools/testing/selftests/kvm/include/kvm_util.h     |  10 +-
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c |  30 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c         |   5 +
 tools/testing/selftests/net/fcnal-test.sh          |  45 ++++--
 .../net/forwarding/forwarding.config.sample        |   2 +
 tools/testing/selftests/net/icmp_redirect.sh       |   2 +-
 tools/testing/selftests/net/toeplitz.c             |   2 +-
 virt/kvm/kvm_main.c                                |   6 +-
 316 files changed, 2756 insertions(+), 1276 deletions(-)
---
