Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68A470CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbhLJV4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:56:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48098 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbhLJV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:56:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FE04B8295C;
        Fri, 10 Dec 2021 21:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ECEC00446;
        Fri, 10 Dec 2021 21:52:54 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.7-rt23
Date:   Fri, 10 Dec 2021 21:51:03 -0000
Message-ID: <163917306338.354826.2101838423353476993@puck.lan>
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

I'm pleased to announce the 5.15.7-rt23 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 098a6d8590a95d4fc44c3a06e3e40023e2cdd4ca

Or to build 5.15.7-rt23 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.7.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.7-rt23.patch.xz


You can also build from 5.15.5-rt22 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.5-rt22-rt23.patch.xz

Enjoy!
Clark

Changes from v5.15.5-rt22:
---

Aaro Koskinen (1):
      i2c: cbus-gpio: set atomic transfer callback

Aaron Ma (1):
      net: usb: r8152: Add MAC passthrough support for more Lenovo Docks

Adamos Ttofari (1):
      cpufreq: intel_pstate: Add Ice Lake server to out-of-band IDs

Adrian Hunter (2):
      mmc: sdhci: Fix ADMA for PAGE_SIZE >= 64KiB
      scsi: ufs: ufs-pci: Add support for Intel ADL

Al Cooper (1):
      serial: 8250_bcm7271: UART errors after resuming from S2

Alain Volmat (3):
      i2c: stm32f7: flush TX FIFO upon transfer errors
      i2c: stm32f7: recover the bus on access timeout
      i2c: stm32f7: stop dma transfer in case of NACK

Albert Wang (1):
      usb: dwc3: gadget: Fix null pointer exception

Alex Bee (1):
      iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568

Alex Deucher (3):
      drm/amdgpu/pm: fix powerplay OD interface
      drm/amdgpu/gfx10: add wraparound gpu counter check for APUs as well
      drm/amdgpu/gfx9: switch to golden tsc registers for renoir+

Alex Elder (3):
      net: ipa: directly disable ipa-setup-ready interrupt
      net: ipa: separate disabling setup from modem stop
      net: ipa: kill ipa_cmd_pipeline_clear()

Alex Williamson (1):
      iommu/vt-d: Fix unmap_pages support

Alexander Aring (1):
      net: ieee802154: handle iftypes as u32

Alexey Kardashevskiy (2):
      powerpc/pseries/ddw: Revert "Extend upper limit for huge DMA window for persistent memory"
      powerpc/pseries/ddw: Do not try direct mapping with persistent memory and one window

Amit Cohen (1):
      mlxsw: spectrum: Protect driver from buggy firmware

Andreas Gruenbacher (2):
      iomap: Fix inline extent handling in iomap_readpage
      gfs2: Fix length of holes reported at end-of-file

Andrew Halaney (1):
      preempt/dynamic: Fix setup_preempt_mode() return value

Arnd Bergmann (2):
      media: v4l2-core: fix VIDIOC_DQEVENT handling on non-x86
      siphash: use _unaligned version by default

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Wait in SNK_DEBOUNCED until disconnect

Baokun Li (2):
      sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
      sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Ben Ben-Ishay (1):
      net/mlx5e: Rename lro_timeout to packet_merge_timeout

Ben Gardon (1):
      KVM: x86/mmu: Fix TLB flush range when handling disconnected pt

Ben Skeggs (1):
      drm/nouveau: recognise GA106

Benjamin Coddington (1):
      NFSv42: Fix pagecache invalidation after COPY/CLONE

Benjamin Poirier (1):
      net: mpls: Fix notifications when deleting a device

Bernard Zhao (1):
      drm/amd/amdgpu: fix potential memleak

Bob Peterson (1):
      gfs2: release iopen glock early in evict

Brett Creeley (1):
      iavf: Fix VLAN feature flags after VFR

Catalin Marinas (1):
      KVM: arm64: Avoid setting the upper 32 bits of TCR_EL2 and CPTR_EL2 to 1

Chao Yu (1):
      f2fs: quota: fix potential deadlock

Christophe JAILLET (3):
      ksmbd: Fix an error handling path in 'smb2_sess_setup()'
      net: marvell: mvpp2: Fix the computation of shared CPUs
      iwlwifi: Fix memory leaks in error handling path

Christophe Leroy (1):
      powerpc/32: Fix hardlockup on vmap stack overflow

Clark Williams (3):
      Merge tag 'v5.15.6' into v5.15-rt
      Merge tag 'v5.15.7' into v5.15-rt
      Linux 5.15.7-rt23

Claudia Pellegrino (1):
      HID: magicmouse: prevent division by 0 on scroll

Cristian Marussi (3):
      firmware: arm_scmi: Fix null de-reference on error path
      firmware: arm_scmi: Fix type error assignment in voltage protocol
      firmware: arm_scmi: Fix type error in sensor protocol

Damien Le Moal (1):
      scsi: sd: Fix sd_do_mode_sense() buffer length handling

Dan Carpenter (7):
      usb: chipidea: ci_hdrc_imx: fix potential error pointer dereference in probe
      staging: rtl8192e: Fix use after free in _rtl92e_pci_disconnect()
      staging: r8188eu: fix a memory leak in rtw_wx_read32()
      drm/nouveau/acr: fix a couple NULL vs IS_ERR() checks
      scsi: qla2xxx: edif: Fix off by one bug in qla_edif_app_getfcinfo()
      drm/vc4: fix error code in vc4_create_object()
      KVM: VMX: Set failure code in prepare_vmcs02()

Daniele Palmas (1):
      USB: serial: option: add Telit LE910S1 0x9200 composition

David Hildenbrand (1):
      proc/vmcore: fix clearing user buffer by properly using clear_user()

David Matlack (1):
      KVM: x86/mmu: Rename slot_handle_leaf to slot_handle_level_4k

Davide Caratti (1):
      net/sched: sch_ets: don't peek at classes beyond 'nbands'

Diana Wang (1):
      nfp: checking parameter process for rx-usecs/tx-usecs is invalid

Dmitry Bogdanov (2):
      atlantic: Increase delay for fw transactions
      atlantic: Fix statistics logic for production hardware

Dmitry Osipenko (1):
      usb: xhci: tegra: Check padctrl interrupt presence in device tree

Dmytro Linkin (2):
      net/mlx5: E-switch, Respect BW share of the new group
      net/mlx5: E-Switch, Check group pointer before reading bw_share value

Dongliang Mu (1):
      dpaa2-eth: destroy workqueue at the end of remove function

Douglas Anderson (2):
      drm/msm/a6xx: Allocate enough space for GMU registers
      drm/msm: Fix mmap to include VM_IO and VM_DONTDUMP

Dust Li (1):
      net/smc: fix wrong list_del in smc_lgr_cleanup_early

Dylan Hung (1):
      mdio: aspeed: Fix "Link is Down" issue

Eiichi Tsukata (2):
      rxrpc: Fix rxrpc_peer leak in rxrpc_look_up_bundle()
      rxrpc: Fix rxrpc_local leak in rxrpc_lookup_peer()

Eric Dumazet (5):
      mptcp: fix delack timer
      ipv6: fix typos in __ip6_finish_output()
      tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows
      net: annotate data-races on txq->xmit_lock_owner
      ipv4: convert fib_num_tclassid_users to atomic_t

Fabio Aiuto (1):
      usb: dwc3: leave default DMA for PCI devices

Fabio M. De Francesco (1):
      staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context

Felix Fietkau (1):
      mac80211: fix throughput LED trigger

Feng Tang (2):
      x86/tsc: Add a timer to make sure TSC_adjust is always checked
      x86/tsc: Disable clocksource watchdog for TSC on qualified platorms

Filipe Manana (1):
      btrfs: silence lockdep when reading chunk tree during mount

Florent Fourcot (2):
      netfilter: ctnetlink: fix filtering with CTA_TUPLE_REPLY
      netfilter: ctnetlink: do not erase error code with EINVAL

Florian Fainelli (4):
      ARM: dts: BCM5301X: Fix I2C controller interrupt
      ARM: dts: BCM5301X: Add interrupt properties to GPIO node
      ARM: dts: bcm2711: Fix PCIe interrupts
      net: dsa: b53: Add SPI ID table

Frank Li (1):
      usb: cdns3: gadget: fix new urb never complete if ep cancel previous requests

German Gomez (1):
      perf inject: Fix ARM SPE handling

Greg Kroah-Hartman (2):
      Linux 5.15.6
      Linux 5.15.7

Guangbin Huang (1):
      net: hns3: fix VF RSS failed problem after PF enable multi-TCs

Guangming (1):
      dma-buf: system_heap: Use 'for_each_sgtable_sg' in pages free flow

Guo DaXing (1):
      net/smc: Fix loop in smc_listen

Gustavo A. R. Silva (1):
      wireguard: ratelimiter: use kvcalloc() instead of kvzalloc()

Hans Verkuil (1):
      media: cec: copy sequence field for the reply

Hans de Goede (1):
      HID: input: Fix parsing of HID_CP_CONSUMER_CONTROL fields

Heiner Kallweit (1):
      lan743x: fix deadlock in lan743x_phy_link_status_change()

Helge Deller (4):
      Revert "parisc: Fix backtrace to always include init funtion names"
      parisc: Fix KBUILD_IMAGE for self-extracting kernel
      parisc: Fix "make install" on newer debian releases
      parisc: Mark cr16 CPU clocksource unstable on all SMP machines

Holger Assmann (1):
      net: stmmac: retain PTP clock time during SIOCSHWTSTAMP ioctls

Hou Wenlong (2):
      KVM: x86/mmu: Skip tlb flush if it has been done in zap_gfn_range()
      KVM: x86/mmu: Pass parameter flush as false in kvm_tdp_mmu_zap_collapsible_sptes()

Huang Jianan (1):
      erofs: fix deadlock when shrink erofs slab

Huang Pei (2):
      MIPS: loongson64: fix FTLB configuration
      MIPS: use 3-level pgtable for 64KB page size on MIPS_VA_BITS_48

Ian Rogers (2):
      perf hist: Fix memory leak of a perf_hpp_fmt
      perf report: Fix memory leaks around perf_tip()

Ilia Sergachev (1):
      serial: liteuart: Fix NULL pointer dereference in ->remove()

Ioanna Alifieraki (1):
      ipmi: Move remove_work to dedicated workqueue

Jakub Kicinski (3):
      tls: splice_read: fix record type check
      tls: splice_read: fix accessing pre-processed records
      tls: fix replacing proto_ops

James Smart (1):
      scsi: lpfc: Fix non-recovery of remote ports following an unsolicited LOGO

Jason A. Donenfeld (6):
      wireguard: selftests: increase default dmesg log size
      wireguard: allowedips: add missing __rcu annotation to satisfy sparse
      wireguard: selftests: actually test for routing loops
      wireguard: device: reset peer src endpoint when netns exits
      wireguard: receive: use ring buffer for incoming handshakes
      wireguard: receive: drop handshakes if queue lock is contended

Jason Gerecke (1):
      HID: wacom: Use "Confidence" flag to prevent reporting invalid contacts

Jay Dolan (2):
      serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
      serial: 8250_pci: rewrite pericom_do_set_divisor()

Jedrzej Jagielski (1):
      iavf: Fix refreshing iavf adapter stats on ethtool request

Jeff Layton (1):
      ceph: properly handle statfs on multifs setups

Jens Axboe (1):
      io-wq: don't retry task_work creation failure on fatal conditions

Jesse Brandeburg (1):
      igb: fix netpoll exit with traffic

Jie Wang (1):
      net: hns3: fix incorrect components info of ethtool --reset command

Jimmy Wang (1):
      platform/x86: thinkpad_acpi: Add support for dual fan control

Jiri Olsa (1):
      tracing/uprobe: Fix uprobe_perf_open probes iteration

Joel Stanley (1):
      drm/aspeed: Fix vga_pw sysfs output

Joerg Roedel (2):
      iommu/amd: Clarify AMD IOMMUv2 initialization messages
      x86/64/mm: Map all kernel memory into trampoline_pgd

Johan Hovold (4):
      USB: serial: pl2303: fix GC type detection
      serial: core: fix transmit-buffer reset and memleak
      serial: liteuart: fix use-after-free and memleak on unbind
      serial: liteuart: fix minor-number leak on probe errors

Jordy Zomer (1):
      ipv6: check return value of ipv6_skip_exthdr

José Roberto de Souza (1):
      Revert "drm/i915: Implement Wa_1508744258"

Juergen Gross (2):
      x86/pvh: add prototype for xen_pvh_init()
      xen/pvh: add missing prototype to header

Julian Braha (2):
      drm/sun4i: fix unmet dependency on RESET_CONTROLLER for PHY_SUN6I_MIPI_DPHY
      pinctrl: qcom: fix unmet dependencies on GPIOLIB for GPIOLIB_IRQCHIP

Julian Wiedmann (1):
      ethtool: ioctl: fix potential NULL deref in ethtool_set_coalesce()

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: fix hotplug when only codec is suspended

Karsten Graul (1):
      net/smc: Fix NULL pointer dereferencing in smc_vlan_by_tcpsk()

Khalid Manaa (1):
      net/mlx5e: Rename TIR lro functions to TIR packet merge functions

Krzysztof Kozlowski (2):
      riscv: dts: microchip: fix board compatible
      riscv: dts: microchip: drop duplicated MMC/SDHC node

Kumar Thangavel (1):
      net/ncsi : Add payload to be 32-bit aligned to fix dropped packets

Lai Jiangshan (5):
      KVM: X86: Use vcpu->arch.walk_mmu for kvm_mmu_invlpg()
      KVM: X86: Fix when shadow_root_level=5 && guest root_level<4
      x86/entry: Add a fence for kernel entry SWAPGS in paranoid_entry()
      x86/entry: Use the correct fence macro after swapgs in kernel CR3
      x86/xen: Add xenpv_restore_regs_and_return_to_usermode()

Larry Finger (1):
      staging: r8188eu: Fix breakage introduced when 5G code was removed

Li Zhijian (2):
      wireguard: selftests: rename DEBUG_PI_LIST to DEBUG_PLIST
      selftests: net: Correct case name

Lijo Lazar (1):
      drm/amd/pm: Remove artificial freq level on Navi1x

Like Xu (1):
      KVM: x86/pmu: Fix reserved bits for AMD PerfEvtSeln register

Linus Torvalds (1):
      fget: check that the fd still exists after getting a ref to it

Longpeng (1):
      vdpa_sim: avoid putting an uninitialized iova_domain

Lorenzo Bianconi (1):
      mt76: mt7915: fix NULL pointer dereference in mt7915_get_phy_mode

Lukas Wunner (1):
      serial: 8250: Fix RTS modem control while in rs485 mode

Lyude Paul (1):
      drm/i915/dp: Perform 30ms delay after source OUI write

Maciej Fijalkowski (1):
      ice: fix vsi->txq_map sizing

Maciej W. Rozycki (1):
      vgacon: Propagate console boot parameters before calling `vc_resize'

Manaf Meethalavalappu Pallikunhi (1):
      thermal: core: Reset previous low and high trip during thermal zone init

Marco Elver (1):
      perf: Ignore sigtrap for tracepoints destined for other tasks

Marek Behún (8):
      PCI: aardvark: Deduplicate code in advk_pcie_rd_conf()
      net: marvell: mvpp2: increase MTU limit when XDP enabled
      net: dsa: mv88e6xxx: Fix application of erratum 4.8 for 88E6393X
      net: dsa: mv88e6xxx: Drop unnecessary check in mv88e6393x_serdes_erratum_4_6()
      net: dsa: mv88e6xxx: Save power by disabling SerDes trasmitter and receiver
      net: dsa: mv88e6xxx: Add fix for erratum 5.2 of 88E6393X family
      net: dsa: mv88e6xxx: Fix inband AN for 2500base-x on 88E6393X family
      net: dsa: mv88e6xxx: Link in pcs_get_state() if AN is bypassed

Mario Limonciello (3):
      ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile
      ata: libahci: Adjust behavior when StorageD3Enable _DSD is set
      ACPI: Add stubs for wakeup handler functions

Mark Bloch (1):
      net/mlx5: E-Switch, fix single FDB creation on BlueField

Mark Rutland (3):
      arm64: uaccess: avoid blocking within critical sections
      sched/scs: Reset task stack state in bringup_cpu()
      arm64: ftrace: add missing BTIs

Marta Plantykow (1):
      ice: avoid bpf_prog refcount underflow

Martyn Welch (1):
      net: usb: Correct PHY handling of smsc95xx

Masami Hiramatsu (1):
      kprobes: Limit max data_size of the kretprobe instances

Mathias Nyman (3):
      usb: hub: Fix usb enumeration issue due to address0 race
      usb: hub: Fix locking issues with address0_mutex
      xhci: Fix commad ring abort, write all 64 bits to CRCR register.

Matt Johnston (1):
      mctp: Don't let RTM_DELROUTE delete local routes

Maurizio Lombardi (1):
      nvmet: use IOCB_NOWAIT only if the filesystem supports it

Mauro Carvalho Chehab (1):
      docs: accounting: update delay-accounting.rst reference

Maxime Ripard (6):
      drm/vc4: kms: Wait for the commit before increasing our clock rate
      drm/vc4: kms: Fix return code check
      drm/vc4: kms: Add missing drm_crtc_commit_put
      drm/vc4: kms: Clear the HVS FIFO commit pointer once done
      drm/vc4: kms: Don't duplicate pending commit
      drm/vc4: kms: Fix previous HVS commit wait

Michael Kelley (1):
      firmware: smccc: Fix check for ARCH_SOC_ID not implemented

Michael Sterritt (1):
      x86/sev: Fix SEV-ES INS/OUTS instructions for word, dword, and qword

Michael Straube (1):
      staging: r8188eu: use GFP_ATOMIC under spinlock

Mike Christie (2):
      scsi: core: sysfs: Fix setting device state to SDEV_RUNNING
      scsi: iscsi: Unblock session then wake up error handler

Miklos Szeredi (1):
      fuse: release pipe buf after last use

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix ISOC flow for elapsed frames

Ming Lei (2):
      blk-mq: cancel blk-mq dispatch work in both blk_cleanup_queue and disk_release()
      block: avoid to quiesce queue in elevator_init_mq

Mingjie Zhang (1):
      USB: serial: option: add Fibocom FM101-GL variants

Mohammed Gamal (1):
      drm/hyperv: Fix device removal on Gen1 VMs

Mordechay Goodstein (1):
      iwlwifi: mvm: retry init flow if failed

Moshe Shemesh (1):
      net/mlx5: Move MODIFY_RQT command to ignore list in internal error state

Namhyung Kim (3):
      perf sort: Fix the 'weight' sort key behavior
      perf sort: Fix the 'ins_lat' sort key behavior
      perf sort: Fix the 'p_stage_cyc' sort key behavior

Namjae Jeon (3):
      ksmbd: downgrade addition info error msg to debug in smb2_get_info_sec()
      ksmbd: contain default data stream even if xattr is empty
      ksmbd: fix memleak in get_file_stream_info()

Nathan Chancellor (1):
      usb: dwc2: hcd_queue: Fix use of floating point literal

Nicholas Kazlauskas (3):
      drm/amd/display: Fix DPIA outbox timeout after GPU reset
      drm/amd/display: Set plane update flags for all planes in reset
      drm/amd/display: Allow DSC on supported MST branch devices

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Prevent POWER7/8 TLB flush flushing SLB

Nicolas Frattaroli (1):
      ASoC: rk817: Add module alias for rk817-codec

Nikita Danilov (2):
      atlatnic: enable Nbase-t speeds with base-t
      atlantic: Add missing DIDs and fix 115c.

Nikita Yushchenko (1):
      tracing: Don't use out-of-sync va_list in event printing

Niklas Schnelle (1):
      s390/pci: move pseudo-MMIO to prevent MIO overlap

Nikolay Aleksandrov (3):
      net: nexthop: fix null pointer dereference when IPv6 is not enabled
      net: ipv6: add fib6_nh_release_dsts stub
      net: nexthop: release IPv6 per-cpu dsts when replacing a nexthop group

Nitesh B Venkatesh (1):
      iavf: Prevent changing static ITR values if adaptive moderation is on

Noralf Trønnes (1):
      staging/fbtft: Fix backlight

Ole Ernst (1):
      USB: NO_LPM quirk Lenovo Powered USB-C Travel Hub

Olivier Moysan (1):
      ASoC: stm32: i2s: fix 32 bits channel length without mclk

Ondrej Jirman (1):
      usb: typec: fusb302: Fix masking of comparator and bc_lvl interrupts

Pali Rohár (3):
      PCI: aardvark: Implement re-issuing config requests on CRS response
      PCI: aardvark: Simplify initialization of rootcap on virtual bridge
      PCI: aardvark: Fix link training

Paolo Abeni (2):
      mptcp: use delegate action to schedule 3rd ack retrans
      tcp: fix page frag corruption on page fault

Paolo Bonzini (7):
      KVM: fix avic_set_running for preemptable kernels
      KVM: x86: ignore APICv if LAPIC is not enabled
      KVM: VMX: prepare sync_pir_to_irr for running with APICv disabled
      KVM: x86: Use a stable condition around all VT-d PI paths
      KVM: MMU: shadow nested paging does not have PKU
      KVM: x86: check PIR even for vCPUs with disabled APICv
      KVM: SEV: initialize regions_list of a mirror VM

Patrik John (1):
      serial: tegra: Change lower tolerance baud rate limit for tegra20 and tegra30

Pavel Begunkov (3):
      io_uring: correct link-list traversal locking
      io_uring: fail cancellation for EXITING tasks
      io_uring: fix link traversal locking

Peng Fan (1):
      firmware: arm_scmi: pm: Propagate return value to caller

Philip Yang (1):
      drm/amdgpu: IH process reset count when restart

Pierre Gondois (1):
      serial: pl011: Add ACPI SBSA UART match id

Pierre-Louis Bossart (2):
      ALSA: intel-dsp-config: add quirk for JSL devices based on ES8336 codec
      ALSA: intel-dsp-config: add quirk for CML devices based on ES8336 codec

Pingfan Liu (1):
      arm64: mm: Fix VM_BUG_ON(mm != &init_mm) for trans_pgd

Qais Yousef (1):
      sched/uclamp: Fix rq->uclamp_max not set on first enqueue

Raed Salem (2):
      net/mlx5e: IPsec: Fix Software parser inner l3 type setting in case of encapsulation
      net/mlx5e: Fix missing IPsec statistics on uplink representor

Rafael J. Wysocki (2):
      ACPI: CPPC: Add NULL pointer check to cppc_get_perf()
      cpufreq: intel_pstate: Fix active mode offline/online EPP handling

Randy Dunlap (1):
      natsemi: xtensa: fix section mismatch warnings

Rob Clark (4):
      drm/msm: Do hw_init() before capturing GPU state
      drm/msm/devfreq: Fix OPP refcnt leak
      drm/msm: Fix wait_fence submitqueue leak
      drm/msm: Restore error return on invalid fence

Roman Li (1):
      drm/amd/display: Fix OLED brightness control on eDP

Russell King (Oracle) (2):
      net: phylink: Force link down and retrigger resolve on interface change
      net: phylink: Force retrigger in case of latched link-fail indicator

Sakari Ailus (1):
      ACPI: Get acpi_device's parent from the parent field

Sameer Pujar (9):
      ASoC: tegra: Fix wrong value type in ADMAIF
      ASoC: tegra: Fix wrong value type in I2S
      ASoC: tegra: Fix wrong value type in DMIC
      ASoC: tegra: Fix wrong value type in DSPK
      ASoC: tegra: Fix kcontrol put callback in ADMAIF
      ASoC: tegra: Fix kcontrol put callback in I2S
      ASoC: tegra: Fix kcontrol put callback in DMIC
      ASoC: tegra: Fix kcontrol put callback in DSPK
      ASoC: tegra: Fix kcontrol put callback in AHUB

Sameer Saurabh (3):
      atlantic: Fix to display FW bundle version instead of FW mac version.
      Remove Half duplex mode speed capabilities.
      atlantic: Remove warn trace message.

Sean Christopherson (8):
      x86/hyperv: Move required MSRs check to initial platform probing
      KVM: Disallow user memslot with size that exceeds "unsigned long"
      KVM: Ensure local memslot copies operate on up-to-date arch-specific data
      KVM: nVMX: Emulate guest TLB flush on nested VM-Enter with new vpid12
      KVM: nVMX: Flush current VPID (L1 vs. L2) for KVM_REQ_TLB_FLUSH_GUEST
      KVM: nVMX: Abide to KVM_REQ_TLB_FLUSH_GUEST request on nested vmentry/vmexit
      KVM: SEV: Return appropriate error codes if SEV-ES scratch setup fails
      KVM: x86/mmu: Remove spurious TLB flushes in TDP MMU zap collapsible path

Shin'ichiro Kawasaki (1):
      scsi: scsi_debug: Zero clear zones at reset write pointer

Shyam Prasad N (2):
      cifs: nosharesock should not share socket with future sessions
      cifs: nosharesock should be set on new server

Slark Xiao (1):
      platform/x86: thinkpad_acpi: Fix WWAN device disabled issue after S3 deep

Sreekanth Reddy (3):
      scsi: mpt3sas: Fix kernel panic during drive powercycle test
      scsi: mpt3sas: Fix system going into read-only mode
      scsi: mpt3sas: Fix incorrect system timestamp

Srinivas Kandagatla (5):
      ASoC: qdsp6: q6routing: Conditionally reset FrontEnd Mixer
      ASoC: qdsp6: q6asm: fix q6asm_dai_prepare error handling
      ASoC: codecs: wcd938x: fix volatile register range
      ASoC: codecs: wcd934x: return error code correctly from hw_params
      ASoC: codecs: lpass-rx-macro: fix HPHR setting CLSH mask

Stanislaw Gruszka (1):
      rt2x00: do not mark device gone on EPROTO errors during start

Stefan Binding (1):
      ALSA: hda/cs8409: Set PMSG_ON earlier inside cs8409 driver

Stefano Garzarella (1):
      vhost/vsock: fix incorrect used length reported to the guest

Stefano Stabellini (2):
      xen: don't continue xenstore initialization in case of errors
      xen: detect uninitialized xenbus in xenbus_init

Stephen Suryaputra (1):
      vrf: Reset IPCB/IP6CB when processing outbound pkts in vrf dev xmit

Steven Rostedt (VMware) (3):
      tracing: Fix pid filtering when triggers are attached
      tracing: Check pid filtering when creating events
      tracing/histograms: String compares should not care about signed values

Sven Eckelmann (1):
      tty: serial: msm_serial: Deactivate RX DMA for polling support

Sven Schuchmann (1):
      net: usb: lan78xx: lan78xx_phy_init(): use PHY_POLL instead of "0" if no IRQ is available

Takashi Iwai (17):
      ALSA: ctxfi: Fix out-of-range access
      ALSA: hda/realtek: Fix LED on HP ProBook 435 G7
      staging: greybus: Add missing rwsem around snd_ctl_remove() calls
      ASoC: topology: Add missing rwsem around snd_ctl_remove() calls
      ARM: socfpga: Fix crash with CONFIG_FORTIRY_SOURCE
      ALSA: usb-audio: Restrict rates for the shared clocks
      ALSA: usb-audio: Rename early_playback_start flag with lowlatency_playback
      ALSA: usb-audio: Disable low-latency playback for free-wheel mode
      ALSA: usb-audio: Disable low-latency mode for implicit feedback sync
      ALSA: usb-audio: Check available frames for the next packet size
      ALSA: usb-audio: Add spinlock to stop_urbs()
      ALSA: usb-audio: Improved lowlatency playback support
      ALSA: usb-audio: Avoid killing in-flight URBs during draining
      ALSA: usb-audio: Fix packet size calculation regression
      ALSA: usb-audio: Less restriction for low-latency playback mode
      ALSA: usb-audio: Switch back to non-latency mode at a later point
      ALSA: usb-audio: Don't start stream for capture at prepare

Tariq Toukan (1):
      net/mlx5e: Sync TIR params updates against concurrent create/modify

Teng Qi (2):
      ethernet: hisilicon: hns: hns_dsaf_misc: fix a possible array overflow in hns_dsaf_ge_srst_by_port()
      net: ethernet: dec: tulip: de4x5: fix possible array overflows in type3_infoblock()

Thinh Nguyen (3):
      usb: dwc3: core: Revise GHWPARAMS9 offset
      usb: dwc3: gadget: Ignore NoStream after End Transfer
      usb: dwc3: gadget: Check for L1/L2/U3 for Start Transfer

Thomas Weißschuh (2):
      HID: input: set usage type to key on keycode remap
      platform/x86: dell-wmi-descriptor: disable by default

Thomas Zeitlhofer (1):
      PM: hibernate: use correct mode for swsusp_close()

Tianjia Zhang (1):
      net/tls: Fix authentication failure in CCM mode

Tim Harvey (1):
      mmc: sdhci-esdhc-imx: disable CMDQ support

Todd Kjos (1):
      binder: fix test regression due to sender_euid change

Tony Lu (3):
      net/smc: Ensure the active closing peer first closes clcsock
      net/smc: Don't call clcsock shutdown twice when smc shutdown
      net/smc: Keep smc_close_final rc during active close

Trond Myklebust (1):
      NFSv42: Don't fail clone() unless the OP_CLONE operation failed

Varun Prakash (1):
      nvmet-tcp: fix incomplete data digest send

Vasily Gorbik (1):
      s390/setup: avoid using memblock_enforce_memory_limit

Vincent Guittot (1):
      firmware: arm_scmi: Fix base agent discover response

Vincent Whitchurch (3):
      af_unix: fix regression in read after shutdown
      i2c: virtio: disable timeout handling
      net: stmmac: Avoid DMA_CHAN_CONTROL write if no Split Header support

Vladimir Oltean (2):
      net: mscc: ocelot: don't downgrade timestamping RX filters in SIOCSHWTSTAMP
      net: mscc: ocelot: correctly report the timestamping RX filters in ethtool

Volodymyr Mytnyk (2):
      net: marvell: prestera: fix brige port operation
      net: marvell: prestera: fix double free issue on err path

Waiman Long (1):
      locking/rwsem: Make handoff bit handling more consistent

Wang Yugui (1):
      btrfs: check-integrity: fix a warning on write caching disabled disk

Wei Yongjun (1):
      ipmi: msghandler: Make symbol 'remove_work_wq' static

Weichao Guo (1):
      f2fs: set SBI_NEED_FSCK flag when inconsistent node block found

Wen Gu (2):
      net/smc: Transfer remaining wait queue entries during fallback
      net/smc: Avoid warning of possible recursive locking

Werner Sembach (1):
      ALSA: hda/realtek: Add quirk for ASRock NUC Box 1100

Will Mortensen (1):
      netfilter: flowtable: fix IPv6 tunnel addr match

William Kucharski (1):
      net/rds: correct socket tunable error in rds_tcp_tune()

Xing Song (1):
      mac80211: do not access the IV when it was stripped

Xiongfeng Wang (1):
      cpufreq: Fix get_cpu_device() failure in add_cpu_dev_symlink()

Yannick Vignon (1):
      net: stmmac: Disable Tx queues when reconfiguring the interface

Ye Bin (1):
      io_uring: fix soft lockup when call __io_remove_buffers

Zekun Shen (1):
      atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_wait

Zhou Qingyang (4):
      net: qlogic: qlcnic: Fix a NULL pointer dereference in qlcnic_83xx_add_rings()
      net/mlx4_en: Fix an use-after-free bug in mlx4_en_try_alloc_resources()
      octeontx2-af: Fix a memleak bug in rvu_mbox_init()
      usb: cdnsp: Fix a NULL pointer dereference in cdnsp_endpoint_init()

Ziyang Xuan (1):
      net: vlan: fix underflow for the real_dev refcnt

liuguoqiang (1):
      net: return correct error code

msizanoen1 (1):
      ipv6: fix memory leak in fib6_rule_suppress

shaoyunl (1):
      drm/amd/amdkfd: Fix kernel panic when reset failed and been triggered again

yangxingwu (1):
      netfilter: ipvs: Fix reuse connection if RS weight is 0

zhangyue (1):
      net: tulip: de4x5: fix the problem that the array 'lp->phy[8]' may be out of bound

Łukasz Bartosik (1):
      iwlwifi: fix warnings produced by kernel debug options
---
Documentation/admin-guide/sysctl/kernel.rst        |   2 +-
 Documentation/networking/ipvs-sysctl.rst           |   3 +-
 Makefile                                           |   2 +-
 arch/arm/boot/dts/bcm2711.dtsi                     |   8 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   4 +-
 arch/arm/mach-socfpga/core.h                       |   2 +-
 arch/arm/mach-socfpga/platsmp.c                    |   8 +-
 arch/arm64/include/asm/kvm_arm.h                   |   4 +-
 arch/arm64/include/asm/pgalloc.h                   |   2 +-
 arch/arm64/include/asm/uaccess.h                   |  48 +++-
 arch/arm64/kernel/entry-ftrace.S                   |   6 +
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/kernel/cpu-probe.c                       |   4 +-
 arch/parisc/Makefile                               |   5 +
 arch/parisc/install.sh                             |   1 +
 arch/parisc/kernel/time.c                          |  30 +--
 arch/parisc/kernel/vmlinux.lds.S                   |   3 +-
 arch/powerpc/kernel/head_32.h                      |   6 +-
 arch/powerpc/kvm/book3s_hv_builtin.c               |   5 +-
 arch/powerpc/platforms/pseries/iommu.c             |  15 +-
 .../dts/microchip/microchip-mpfs-icicle-kit.dts    |  13 +-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi  |  33 +--
 arch/s390/include/asm/pci_io.h                     |   7 +-
 arch/s390/kernel/setup.c                           |   3 -
 arch/x86/entry/entry_64.S                          |  35 ++-
 arch/x86/hyperv/hv_init.c                          |   9 +-
 arch/x86/include/asm/xen/hypervisor.h              |   5 +
 arch/x86/kernel/cpu/mshyperv.c                     |  20 +-
 arch/x86/kernel/sev.c                              |  57 ++--
 arch/x86/kernel/tsc.c                              |  28 +-
 arch/x86/kernel/tsc_sync.c                         |  41 +++
 arch/x86/kvm/lapic.c                               |   2 +-
 arch/x86/kvm/mmu/mmu.c                             |  37 +--
 arch/x86/kvm/mmu/tdp_mmu.c                         |  36 +--
 arch/x86/kvm/mmu/tdp_mmu.h                         |   5 +-
 arch/x86/kvm/svm/avic.c                            |  16 +-
 arch/x86/kvm/svm/pmu.c                             |   2 +-
 arch/x86/kvm/svm/sev.c                             |  31 ++-
 arch/x86/kvm/svm/svm.c                             |   1 -
 arch/x86/kvm/vmx/nested.c                          |  49 ++--
 arch/x86/kvm/vmx/posted_intr.c                     |  20 +-
 arch/x86/kvm/vmx/vmx.c                             |  62 +++--
 arch/x86/kvm/x86.c                                 |  46 +++-
 arch/x86/kvm/x86.h                                 |   7 +-
 arch/x86/realmode/init.c                           |  12 +-
 arch/x86/xen/xen-asm.S                             |  20 ++
 block/blk-core.c                                   |   4 +-
 block/blk-mq.c                                     |  13 +
 block/blk-mq.h                                     |   2 +
 block/blk-sysfs.c                                  |  10 -
 block/elevator.c                                   |  10 +-
 block/genhd.c                                      |   2 +
 drivers/acpi/cppc_acpi.c                           |   9 +-
 drivers/acpi/property.c                            |  11 +-
 drivers/android/binder.c                           |   2 +-
 drivers/ata/ahci.c                                 |   1 +
 drivers/ata/libahci.c                              |  15 ++
 drivers/ata/sata_fsl.c                             |  20 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  13 +-
 drivers/cpufreq/cpufreq.c                          |   9 +-
 drivers/cpufreq/intel_pstate.c                     |   7 +
 drivers/dma-buf/heaps/system_heap.c                |   2 +-
 drivers/firmware/arm_scmi/base.c                   |  15 +-
 drivers/firmware/arm_scmi/scmi_pm_domain.c         |   4 +-
 drivers/firmware/arm_scmi/sensors.c                |   2 +-
 drivers/firmware/arm_scmi/virtio.c                 |  10 +-
 drivers/firmware/arm_scmi/voltage.c                |   2 +-
 drivers/firmware/smccc/soc_id.c                    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  15 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  46 +++-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   5 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  20 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  20 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  24 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |   6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  28 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  10 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  58 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  13 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |   2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |  19 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   3 +
 drivers/gpu/drm/i915/display/intel_dp.c            |  11 +
 drivers/gpu/drm/i915/display/intel_dp.h            |   2 +
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |   5 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   7 -
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |   4 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |   1 +
 drivers/gpu/drm/msm/msm_drv.c                      |  49 ++--
 drivers/gpu/drm/msm/msm_gem.c                      |   3 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   1 +
 drivers/gpu/drm/msm/msm_gpu.h                      |   3 +
 drivers/gpu/drm/msm/msm_gpu_devfreq.c              |   5 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  22 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c    |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c    |   6 +-
 drivers/gpu/drm/sun4i/Kconfig                      |   1 +
 drivers/gpu/drm/vc4/vc4_bo.c                       |   2 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |  40 ++-
 drivers/hid/hid-input.c                            |   6 +-
 drivers/hid/hid-magicmouse.c                       |   7 +-
 drivers/hid/wacom_wac.c                            |   8 +-
 drivers/hid/wacom_wac.h                            |   1 +
 drivers/i2c/busses/i2c-cbus-gpio.c                 |   5 +-
 drivers/i2c/busses/i2c-stm32f7.c                   |  31 ++-
 drivers/i2c/busses/i2c-virtio.c                    |  14 +-
 drivers/iommu/amd/iommu_v2.c                       |   6 +-
 drivers/iommu/intel/iommu.c                        |   6 +-
 drivers/iommu/rockchip-iommu.c                     |   4 +-
 drivers/media/cec/core/cec-adap.c                  |   1 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |  41 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   2 -
 drivers/mmc/host/sdhci.c                           |  21 +-
 drivers/mmc/host/sdhci.h                           |   4 +-
 drivers/net/dsa/b53/b53_spi.c                      |  14 +
 drivers/net/dsa/mv88e6xxx/serdes.c                 | 252 +++++++++++++++---
 drivers/net/dsa/mv88e6xxx/serdes.h                 |   4 +
 drivers/net/ethernet/aquantia/atlantic/aq_common.h |  27 +-
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |   2 +
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |  10 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   7 +-
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c    |   3 -
 .../aquantia/atlantic/hw_atl/hw_atl_utils.c        |  25 +-
 .../aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c   |   3 -
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   |  22 +-
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h   |   2 +
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils.h      |  38 ++-
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c   | 110 ++++++--
 drivers/net/ethernet/dec/tulip/de4x5.c             |  34 ++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   2 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   4 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   4 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   3 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  33 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  51 ++--
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  47 +++-
 drivers/net/ethernet/intel/ice/ice_lib.c           |   9 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  18 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  16 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   2 +-
 .../ethernet/marvell/prestera/prestera_switchdev.c |   8 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  14 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  21 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |   6 -
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |  23 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |   7 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |  66 ++++-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c   |  16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.h   |   6 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |  24 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  46 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   7 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   2 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  12 +-
 drivers/net/ethernet/mscc/ocelot.c                 |  11 +-
 drivers/net/ethernet/natsemi/xtsonic.c             |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net.h       |   3 -
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |   2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  10 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 138 ++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   2 +-
 drivers/net/ipa/ipa_cmd.c                          |  16 --
 drivers/net/ipa/ipa_cmd.h                          |   6 -
 drivers/net/ipa/ipa_endpoint.c                     |   2 -
 drivers/net/ipa/ipa_main.c                         |   6 +
 drivers/net/ipa/ipa_modem.c                        |   6 +-
 drivers/net/ipa/ipa_smp2p.c                        |  21 +-
 drivers/net/ipa/ipa_smp2p.h                        |   7 +-
 drivers/net/mdio/mdio-aspeed.c                     |   7 +
 drivers/net/phy/phylink.c                          |  26 +-
 drivers/net/usb/lan78xx.c                          |   2 +-
 drivers/net/usb/r8152.c                            |   9 +-
 drivers/net/usb/smsc95xx.c                         |  55 ++--
 drivers/net/vrf.c                                  |   2 +
 drivers/net/wireguard/allowedips.c                 |   2 +-
 drivers/net/wireguard/device.c                     |  39 +--
 drivers/net/wireguard/device.h                     |   9 +-
 drivers/net/wireguard/queueing.c                   |   6 +-
 drivers/net/wireguard/queueing.h                   |   2 +-
 drivers/net/wireguard/ratelimiter.c                |   4 +-
 drivers/net/wireguard/receive.c                    |  39 +--
 drivers/net/wireguard/socket.c                     |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   6 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   5 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   4 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   3 +
 drivers/nvme/target/io-cmd-file.c                  |   4 +-
 drivers/nvme/target/tcp.c                          |   7 +-
 drivers/pci/controller/pci-aardvark.c              | 242 +++++++----------
 drivers/pinctrl/qcom/Kconfig                       |   2 +
 drivers/platform/x86/dell/Kconfig                  |   2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  13 +-
 drivers/scsi/lpfc/lpfc_els.c                       |   9 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h                |   4 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |  59 +++-
 drivers/scsi/qla2xxx/qla_edif.c                    |   2 +-
 drivers/scsi/scsi_debug.c                          |   5 +
 drivers/scsi/scsi_sysfs.c                          |   2 +-
 drivers/scsi/scsi_transport_iscsi.c                |   6 +-
 drivers/scsi/sd.c                                  |   7 +
 drivers/scsi/ufs/ufshcd-pci.c                      |  18 ++
 drivers/staging/fbtft/fb_ssd1351.c                 |   4 -
 drivers/staging/fbtft/fbtft-core.c                 |   9 +-
 drivers/staging/greybus/audio_helper.c             |   8 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       |   8 +-
 drivers/staging/r8188eu/os_dep/mlme_linux.c        |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   3 +-
 drivers/thermal/thermal_core.c                     |   2 +
 drivers/tty/serial/8250/8250_bcm7271.c             |  13 +
 drivers/tty/serial/8250/8250_pci.c                 |  39 ++-
 drivers/tty/serial/8250/8250_port.c                |   7 -
 drivers/tty/serial/amba-pl011.c                    |   1 +
 drivers/tty/serial/liteuart.c                      |  20 +-
 drivers/tty/serial/msm_serial.c                    |   3 +
 drivers/tty/serial/serial-tegra.c                  |   4 +-
 drivers/tty/serial/serial_core.c                   |  18 +-
 drivers/usb/cdns3/cdns3-gadget.c                   |  20 +-
 drivers/usb/cdns3/cdnsp-mem.c                      |   3 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  18 +-
 drivers/usb/core/hub.c                             |  24 +-
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/dwc2/gadget.c                          |  17 +-
 drivers/usb/dwc2/hcd_queue.c                       |   2 +-
 drivers/usb/dwc3/core.c                            |   8 +-
 drivers/usb/dwc3/core.h                            |   2 +-
 drivers/usb/dwc3/gadget.c                          |  39 ++-
 drivers/usb/host/xhci-ring.c                       |  21 +-
 drivers/usb/host/xhci-tegra.c                      |  41 ++-
 drivers/usb/serial/option.c                        |   5 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/typec/tcpm/fusb302.c                   |   6 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   4 -
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   7 +-
 drivers/vhost/vsock.c                              |   2 +-
 drivers/video/console/vgacon.c                     |  14 +-
 drivers/xen/xenbus/xenbus_probe.c                  |  27 +-
 fs/btrfs/disk-io.c                                 |  14 +-
 fs/btrfs/volumes.c                                 |  18 +-
 fs/ceph/super.c                                    |  11 +-
 fs/cifs/cifs_debug.c                               |   2 +
 fs/cifs/cifsglob.h                                 |   1 +
 fs/cifs/connect.c                                  |   7 +
 fs/erofs/utils.c                                   |   8 +-
 fs/f2fs/checkpoint.c                               |   3 +-
 fs/f2fs/node.c                                     |   1 +
 fs/file.c                                          |   4 +
 fs/fuse/dev.c                                      |  10 +-
 fs/gfs2/bmap.c                                     |   2 +-
 fs/gfs2/super.c                                    |  14 +-
 fs/io-wq.c                                         |   7 +
 fs/io_uring.c                                      |  70 +++--
 fs/iomap/buffered-io.c                             |  11 +-
 fs/ksmbd/smb2pdu.c                                 |  30 ++-
 fs/nfs/nfs42proc.c                                 |   4 +-
 fs/nfs/nfs42xdr.c                                  |   3 +-
 fs/proc/vmcore.c                                   |  16 +-
 include/linux/acpi.h                               |   9 +
 include/linux/kprobes.h                            |   2 +
 include/linux/mlx5/mlx5_ifc.h                      |   8 +-
 include/linux/netdevice.h                          |  19 +-
 include/linux/siphash.h                            |  14 +-
 include/net/dst_cache.h                            |  11 +
 include/net/fib_rules.h                            |   4 +-
 include/net/ip6_fib.h                              |   1 +
 include/net/ip_fib.h                               |   2 +-
 include/net/ipv6_stubs.h                           |   1 +
 include/net/netns/ipv4.h                           |   2 +-
 include/net/nl802154.h                             |   7 +-
 include/net/sock.h                                 |  13 +-
 kernel/cpu.c                                       |   7 +
 kernel/events/core.c                               |   3 +
 kernel/kprobes.c                                   |   3 +
 kernel/locking/rwsem.c                             | 171 ++++++------
 kernel/power/hibernate.c                           |   6 +-
 kernel/sched/core.c                                |  10 +-
 kernel/trace/trace.c                               |  12 +
 kernel/trace/trace.h                               |  24 +-
 kernel/trace/trace_events.c                        |  10 +
 kernel/trace/trace_events_hist.c                   |   2 +-
 kernel/trace/trace_uprobe.c                        |   1 +
 lib/siphash.c                                      |  12 +-
 localversion-rt                                    |   2 +-
 net/8021q/vlan.c                                   |   3 -
 net/8021q/vlan_dev.c                               |   3 +
 net/core/dev.c                                     |   5 +-
 net/core/dst_cache.c                               |  19 ++
 net/core/fib_rules.c                               |   2 +-
 net/ethtool/ioctl.c                                |   2 +-
 net/ipv4/devinet.c                                 |   2 +-
 net/ipv4/fib_frontend.c                            |   2 +-
 net/ipv4/fib_rules.c                               |   5 +-
 net/ipv4/fib_semantics.c                           |   4 +-
 net/ipv4/nexthop.c                                 |  35 ++-
 net/ipv4/tcp_cubic.c                               |   5 +-
 net/ipv6/af_inet6.c                                |   1 +
 net/ipv6/esp6.c                                    |   6 +
 net/ipv6/fib6_rules.c                              |   4 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/route.c                                   |  19 ++
 net/mac80211/led.h                                 |   8 +-
 net/mac80211/rx.c                                  |  10 +-
 net/mac80211/tx.c                                  |  34 ++-
 net/mctp/route.c                                   |   9 +-
 net/mpls/af_mpls.c                                 |  68 +++--
 net/mptcp/options.c                                |  32 +--
 net/mptcp/protocol.c                               |  51 +++-
 net/mptcp/protocol.h                               |  17 +-
 net/ncsi/ncsi-cmd.c                                |  24 +-
 net/netfilter/ipvs/ip_vs_core.c                    |   8 +-
 net/netfilter/nf_conntrack_netlink.c               |   6 +-
 net/netfilter/nf_flow_table_offload.c              |   4 +-
 net/rds/tcp.c                                      |   2 +-
 net/rxrpc/conn_client.c                            |  14 +-
 net/rxrpc/peer_object.c                            |  14 +-
 net/sched/sch_ets.c                                |   8 +-
 net/smc/af_smc.c                                   |  26 +-
 net/smc/smc_close.c                                |  10 +
 net/smc/smc_core.c                                 |  42 +--
 net/tls/tls_main.c                                 |  47 +++-
 net/tls/tls_sw.c                                   |  44 +--
 net/unix/af_unix.c                                 |   3 -
 sound/hda/intel-dsp-config.c                       |  19 ++
 sound/pci/ctxfi/ctamixer.c                         |  14 +-
 sound/pci/ctxfi/ctdaio.c                           |  16 +-
 sound/pci/ctxfi/ctresource.c                       |   7 +-
 sound/pci/ctxfi/ctresource.h                       |   4 +-
 sound/pci/ctxfi/ctsrc.c                            |   7 +-
 sound/pci/hda/hda_local.h                          |   9 +
 sound/pci/hda/patch_cs8409.c                       |   5 +
 sound/pci/hda/patch_realtek.c                      |  28 ++
 sound/soc/codecs/lpass-rx-macro.c                  |   2 +-
 sound/soc/codecs/rk817_codec.c                     |   1 +
 sound/soc/codecs/wcd934x.c                         |   3 +-
 sound/soc/codecs/wcd938x.c                         |   3 +
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  19 +-
 sound/soc/qcom/qdsp6/q6routing.c                   |   6 +-
 sound/soc/soc-topology.c                           |   3 +
 sound/soc/sof/intel/hda-bus.c                      |  17 ++
 sound/soc/sof/intel/hda-dsp.c                      |   3 +-
 sound/soc/sof/intel/hda.c                          |  16 ++
 sound/soc/stm/stm32_i2s.c                          |   2 +-
 sound/soc/tegra/tegra186_dspk.c                    | 181 ++++++++++---
 sound/soc/tegra/tegra210_admaif.c                  | 140 +++++++---
 sound/soc/tegra/tegra210_ahub.c                    |  11 +-
 sound/soc/tegra/tegra210_dmic.c                    | 184 ++++++++++---
 sound/soc/tegra/tegra210_i2s.c                     | 296 ++++++++++++++++-----
 sound/usb/card.h                                   |  10 +-
 sound/usb/endpoint.c                               | 223 +++++++++++-----
 sound/usb/endpoint.h                               |  13 +-
 sound/usb/pcm.c                                    | 165 +++++++++---
 tools/perf/builtin-report.c                        |  15 +-
 tools/perf/ui/hist.c                               |  28 +-
 tools/perf/util/arm-spe.c                          |  15 ++
 tools/perf/util/hist.c                             |  23 +-
 tools/perf/util/hist.h                             |   1 -
 tools/perf/util/sort.c                             |  52 ++--
 tools/perf/util/sort.h                             |   6 +-
 tools/perf/util/util.c                             |  14 +-
 tools/perf/util/util.h                             |   2 +-
 tools/testing/selftests/net/fcnal-test.sh          |   4 +-
 tools/testing/selftests/wireguard/netns.sh         |  30 ++-
 .../testing/selftests/wireguard/qemu/debug.config  |   2 +-
 .../testing/selftests/wireguard/qemu/kernel.config |   1 +
 virt/kvm/kvm_main.c                                |  50 ++--
 385 files changed, 4545 insertions(+), 2184 deletions(-)
---
