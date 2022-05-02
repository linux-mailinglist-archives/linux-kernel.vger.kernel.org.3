Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA75168F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378102AbiEBAH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEBAHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:07:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF533A72C;
        Sun,  1 May 2022 17:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E390EB8103F;
        Mon,  2 May 2022 00:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4B6C385A9;
        Mon,  2 May 2022 00:04:18 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.36-rt41
Date:   Mon, 02 May 2022 00:03:01 -0000
Message-ID: <165144978135.2585014.3783553287893853281@puck.lan>
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

I'm pleased to announce the 5.15.36-rt41 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 2167b95bd8855a18fcbc5a3d7df5308284845e81

Or to build 5.15.36-rt41 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.36.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.36-rt41.patch.xz


Enjoy!
Clark

Changes from v5.15.34-rt40:
---

Adrian Hunter (2):
      perf tools: Fix misleading add event PMU debug message
      perf tools: Fix segfault accessing sample_id xyarray

Ajish Koshy (2):
      scsi: pm80xx: Mask and unmask upper interrupt vectors 32-63
      scsi: pm80xx: Enable upper inbound, outbound queues

Alex Deucher (1):
      drm/amdgpu/gmc: use PCI BARs for APUs in passthrough

Alex Elder (4):
      dt-bindings: net: qcom,ipa: add optional qcom,qmp property
      net: ipa: request IPA register values be retained
      net: ipa: fix a build dependency
      arm64: dts: qcom: add IPA qcom,qmp property

Alexey Galakhov (1):
      scsi: mvsas: Add PCI ID of RocketRaid 2640

Alexey Kardashevskiy (1):
      KVM: PPC: Fix TCE handling for VFIO

Alistair Popple (1):
      mm/mmu_notifier.c: fix race in mmu_interval_notifier_remove()

Allen-KH Cheng (1):
      spi: spi-mtk-nor: initialize spi controller after resume

Andrea Parri (Microsoft) (1):
      Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg by default in isolated guests

Andy Chiu (1):
      net: axienet: setup mdio unconditionally

Andy Shevchenko (1):
      i2c: dev: check return value when calling dev_set_name()

Anilkumar Kolli (1):
      Revert "ath11k: mesh: add support for 256 bitmap in blockack frames in 11ax"

Anna-Maria Behnsen (1):
      timers: Fix warning condition in __run_timers()

Anshuman Khandual (1):
      arm64/mm: drop HAVE_ARCH_PFN_VALID

Antoine Tenart (1):
      netfilter: nf_tables: nft_parse_register can return a negative value

Athira Rajeev (3):
      testing/selftests/mqueue: Fix mq_perf_tests to free the allocated cpu set
      powerpc/perf: Fix power9 event alternatives
      powerpc/perf: Fix power10 event alternatives

Aurabindo Pillai (1):
      drm/amd: Add USBC connector ID

Axel Rasmussen (1):
      mm/secretmem: fix panic when growing a memfd_secret

Benedikt Spranger (1):
      net/sched: taprio: Check if socket flags are valid

Bob Peterson (1):
      gfs2: assign rgrp glock before compute_bitstructs

Boqun Feng (1):
      Drivers: hv: balloon: Disable balloon and hot-add accordingly

Borislav Petkov (4):
      perf/imx_ddr: Fix undefined behavior due to shift overflowing the constant
      ALSA: usb-audio: Fix undefined behavior due to shift overflowing the constant
      mt76: Fix undefined behavior due to shift overflowing the constant
      brcmfmac: sdio: Fix undefined behavior due to shift overflowing the constant

Chandrakanth patil (1):
      scsi: megaraid_sas: Target with invalid LUN ID is deleted during scan

Chao Gao (1):
      dma-direct: avoid redundant memory sync for swiotlb

Charlene Liu (1):
      drm/amd/display: fix audio format not updated after edid updated

Chiawen Huang (1):
      drm/amd/display: FEC check in timing validation

Christian Lamparter (1):
      ata: libata-core: Disable READ LOG DMA EXT for Samsung 840 EVOs

Christoph Böhmwalder (1):
      drbd: set QUEUE_FLAG_STABLE_WRITES

Christoph Hellwig (6):
      fs: remove __sync_filesystem
      block: remove __sync_blockdev
      block: simplify the block device syncing code
      nvme: add a quirk to disable namespace identifiers
      nvme-pci: disable namespace identifiers for the MAXIO MAP1002/1202
      nvme-pci: disable namespace identifiers for Qemu controllers

Christophe Leroy (1):
      mm, hugetlb: allow for "high" userspace addresses

Chuck Lever (2):
      SUNRPC: Fix the svc_deferred_event trace class
      SUNRPC: Fix NFSD's request deferral on RDMA transports

Clark Williams (2):
      Merge tag 'v5.15.36' into v5.15-rt
      Linux 5.15.36-rt41

Cristian Marussi (2):
      firmware: arm_scmi: Remove clear channel call on the TX channel
      firmware: arm_scmi: Fix sorting of retrieved clock rates

Darrick J. Wong (4):
      btrfs: fix fallocate to use file_modified to update permissions consistently
      vfs: make sync_filesystem return errors from ->sync_fs
      xfs: return errors in xfs_fs_sync_fs
      ext4: fix fallocate to use file_modified to update permissions consistently

Dave Jiang (4):
      dmaengine: idxd: fix device cleanup on disable
      dmaengine: idxd: add RO check for wq max_batch_size write
      dmaengine: idxd: add RO check for wq max_transfer_size write
      dmaengine: idxd: skip clearing device context when device is read-only

Dave Stevenson (2):
      drm/panel/raspberrypi-touchscreen: Avoid NULL deref if not initialised
      drm/panel/raspberrypi-touchscreen: Initialise the bridge in prepare

David Ahern (1):
      l3mdev: l3mdev_master_upper_ifindex_by_index_rcu should be using netdev_master_upper_dev_get_rcu

David Howells (2):
      rxrpc: Restore removed timer deletion
      cifs: Check the IOCB_DIRECT flag, not O_DIRECT

Deepak Kumar Singh (1):
      soc: qcom: aoss: Expose send for generic usecase

Dinh Nguyen (1):
      net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-link

Dongjin Yang (1):
      dt-bindings: net: snps: remove duplicate name

Duoming Zhou (9):
      drivers: net: slip: fix NPD bug in sl_tx_timeout()
      ax25: add refcount in ax25_dev to avoid UAF bugs
      ax25: fix reference count leaks of ax25_dev
      ax25: fix UAF bugs of net_device caused by rebinding operation
      ax25: Fix refcount leaks caused by ax25_cb_del()
      ax25: fix UAF bug in ax25_send_control()
      ax25: fix NPD bug in ax25_disconnect
      ax25: Fix NULL pointer dereferences in ax25 timers
      ax25: Fix UAF bugs in ax25 timers

Dylan Hung (1):
      net: ftgmac100: access hardware register after clock ready

Dylan Yudaken (3):
      io_uring: move io_uring_rsrc_update2 validation
      io_uring: verify that resv2 is 0 in io_uring_rsrc_update2
      io_uring: verify pad field is 0 in io_get_ext_arg

Eric Dumazet (4):
      net/sched: cls_u32: fix netns refcount changes in u32_change()
      net/sched: cls_u32: fix possible leak in u32_init_knode()
      ipv6: make ip6_rt_gc_expire an atomic_t
      netlink: reset network and mac headers in netlink_dump()

Fabio M. De Francesco (1):
      ALSA: pcm: Test for "silence" field in struct "pcm_format_data"

Filipe Manana (1):
      btrfs: remove no longer used counter when reading data page

Florian Westphal (4):
      netfilter: nft_socket: make cgroup match work in input too
      netfilter: conntrack: convert to refcount_t api
      netfilter: conntrack: avoid useless indirection during conntrack destruction
      netfilter: nft_ct: fix use after free when attaching zone template

Greg Kroah-Hartman (2):
      Linux 5.15.35
      Linux 5.15.36

Guchun Chen (1):
      drm/amdgpu: conduct a proper cleanup of PDB bo

Guillaume Nault (1):
      veth: Ensure eth header is in skb's linear part

Guo Ren (1):
      xtensa: patch_text: Fixup last cpu should be master

Hangbin Liu (1):
      net/packet: fix packet_sock xmit return value checking

Harshit Mogalapalli (1):
      cifs: potential buffer overflow in handling symlinks

Heiner Kallweit (1):
      reset: renesas: Check return value of reset_control_deassert()

Herve Codina (1):
      dmaengine: dw-edma: Fix unaligned 64bit access

Hongbin Wang (1):
      vxlan: fix error return code in vxlan_fdb_append

Ido Schimmel (1):
      selftests: mlxsw: vxlan_flooding: Prevent flooding of unwanted packets

James Smart (1):
      scsi: lpfc: Fix queue failures when recovering from PCI parity error

Jason A. Donenfeld (1):
      gcc-plugins: latent_entropy: use /dev/urandom

Jason Gunthorpe (1):
      vfio/pci: Fix vf_token mechanism when device-specific VF drivers are used

Jeremy Linton (1):
      net: bcmgenet: Revert "Use stronger register read/writes to assure ordering"

Jia-Ju Bai (1):
      btrfs: fix root ref counts in error handling in btrfs_get_root_ref

Jiapeng Chong (1):
      platform/x86: samsung-laptop: Fix an unsigned comparison which can never be negative

Joey Gouly (1):
      arm64: alternatives: mark patch_alternative() as `noinstr`

Johan Hovold (1):
      memory: renesas-rpc-if: fix platform-device leak in error path

Johannes Berg (1):
      nl80211: correctly check NL80211_ATTR_REG_ALPHA2 size

Jonathan Bakker (1):
      regulator: wm8994: Add an off-on delay for WM8994 variant

Josef Bacik (1):
      btrfs: do not warn for free space inode in cow_file_range

José Roberto de Souza (1):
      drm/i915/display/psr: Unset enable_psr2_sel_fetch if other checks in intel_psr2_config_valid() fails

Juergen Gross (1):
      mm, page_alloc: fix build_zonerefs_node()

Kai Vehmanen (1):
      ALSA: hda/hdmi: fix warning about PCM count when used with SOF

Kai-Heng Feng (1):
      net: atlantic: Avoid out-of-bounds indexing

Karsten Graul (1):
      net/smc: Fix NULL pointer dereference in smc_pnet_find_ib()

Kees Cook (2):
      etherdevice: Adjust ether_addr* prototypes to silence -Wstringop-overead
      ARM: vexpress/spc: Avoid negative array index when !SMP

Kevin Groeneveld (1):
      dmaengine: imx-sdma: fix init of uart scripts

Kevin Hao (1):
      net: stmmac: Use readl_poll_timeout_atomic() in atomic state

Khazhismel Kumykov (2):
      dm mpath: only use ktime_get_ns() in historical selector
      block/compat_ioctl: fix range check in BLKGETSIZE

Kuogee Hsieh (1):
      drm/msm/dp: add fail safe mode outside of event_mutex context

Kurt Kanzenbach (1):
      net: dsa: hellcreek: Calculate checksums in tagger

Kyle Copperfield (1):
      media: rockchip/rga: do proper error checking in probe

Leo (Hanghong) Ma (1):
      drm/amd/display: Update VTEM Infopacket definition

Leo Ruan (1):
      gpu: ipu-v3: Fix dev_dbg frequency output

Leo Yan (2):
      perf script: Always allow field 'data_src' for auxtrace
      perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE event

Like Xu (1):
      KVM: x86/pmu: Update AMD PMC sample period to fix guest NMI-watchdog

Lin Ma (3):
      hamradio: defer 6pack kfree after unregister_netdev
      hamradio: remove needs_free_netdev to avoid UAF
      nfc: nci: add flush_workqueue to prevent uaf

Linus Torvalds (1):
      gpiolib: acpi: use correct format characters

Lv Ruyi (1):
      dpaa_eth: Fix missing of_node_put in dpaa_get_ts_info()

Manuel Ullmann (1):
      net: atlantic: invert deep par in pm functions, preventing null derefs

Marcelo Ricardo Leitner (1):
      net/sched: fix initialization order when updating chain 0 head

Marcin Kozlowski (1):
      net: usb: aqc111: Fix out-of-bounds accesses in RX fixup

Marco Elver (1):
      mm, kfence: support kmem_dump_obj() for KFENCE objects

Mario Limonciello (3):
      cpuidle: PSCI: Move the `has_lpi` check to the beginning of the function
      ACPI: processor idle: Check for architectural support for LPI
      gpio: Request interrupts after IRQ is initialized

Mark Brown (1):
      ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek

Martin Leung (1):
      drm/amd/display: Revert FEC check in validation

Martin Povišer (1):
      i2c: pasemi: Wait for write xfers to finish

Martin Willi (1):
      macvlan: Fix leaking skb in source mode with nodst option

Matt Roper (1):
      drm/i915: Sunset igpu legacy mmap support based on GRAPHICS_VER_FULL

Matthias Schiffer (2):
      spi: cadence-quadspi: fix protocol setup for non-1-1-X operations
      spi: cadence-quadspi: fix incorrect supports_op() return value

Max Filippov (1):
      xtensa: fix a7 clobbering in coprocessor context load/store

Melissa Wen (1):
      drm/amd/display: don't ignore alpha property on pre-multiplied mode

Miaoqian Lin (7):
      memory: atmel-ebi: Fix missing of_node_put in atmel_ebi_probe
      soc: qcom: aoss: Fix missing put_device call in qmp_get
      ASoC: rk817: Use devm_clk_get() in rk817_platform_probe
      ASoC: msm8916-wcd-digital: Check failure for devm_snd_soc_register_component
      dmaengine: imx-sdma: Fix error checking in sdma_event_remap
      Input: omap4-keypad - fix pm_runtime_get_sync() error checking
      drm/vc4: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage

Michael Kelley (2):
      PCI: hv: Propagate coherence from VMbus device to PCI device
      Drivers: hv: vmbus: Prevent load re-ordering when reading ring buffer

Michael Walle (1):
      net: dsa: felix: suppress -EPROBE_DEFER errors

Mike Christie (9):
      scsi: iscsi: Move iscsi_ep_disconnect()
      scsi: iscsi: Fix offload conn cleanup when iscsid restarts
      scsi: iscsi: Fix endpoint reuse regression
      scsi: iscsi: Fix conn cleanup and stop race during iscsid restart
      scsi: iscsi: Fix unbound endpoint error handling
      scsi: iscsi: Release endpoint ID when its freed
      scsi: iscsi: Merge suspend fields
      scsi: iscsi: Fix NOP handling during conn recovery
      scsi: qedi: Fix failed disconnect handling

Mike Rapoport (1):
      dma-mapping: remove bogus test for pfn_valid from dma_map_resource

Mikulas Patocka (2):
      dm integrity: fix memory corruption when tag_size is less than digest size
      stat: fix inconsistency between struct stat and struct compat_stat

Minchan Kim (1):
      mm: fix unexpected zeroed page mapping with zram swap

Ming Lei (1):
      block: fix offset/size check in bio_trim()

Mingwei Zhang (1):
      KVM: SVM: Flush when freeing encrypted pages even on SME_COHERENT CPUs

Muchun Song (1):
      arm64: mm: fix p?d_leaf()

Nadav Amit (1):
      smp: Fix offline cpu check in flush_smp_call_function_queue()

Naohiro Aota (2):
      btrfs: release correct delalloc amount in direct IO write path
      btrfs: mark resumed async balance as writing

Nathan Chancellor (2):
      btrfs: remove unused variable in btrfs_{start,write}_dirty_block_groups()
      ARM: davinci: da850-evm: Avoid NULL pointer dereference

NeilBrown (1):
      VFS: filename_create(): fix incorrect intent.

Nicholas Kazlauskas (2):
      drm/amd/display: Add pstate verification and recovery for DCN31
      drm/amd/display: Fix p-state allow debug index on dcn31

Nico Pache (1):
      oom_kill.c: futex: delay the OOM reaper to allow time for proper futex cleanup

Nicolas Dichtel (1):
      ipv6: fix panic when forwarding a pkt with no in6 dev

Oliver Hartkopp (1):
      can: isotp: stop timeout monitoring when no first frame was sent

Paolo Valerio (1):
      openvswitch: fix OOB access in reserve_sfa_size()

Patrick Wang (1):
      mm: kmemleak: take a full lowmem check in kmemleak_*_phys()

Paul Gortmaker (1):
      tick/nohz: Use WARN_ON_ONCE() to prevent console saturation

Pavel Begunkov (2):
      io_uring: zero tag on rsrc removal
      io_uring: use nospec annotation for more indexes

Pawan Gupta (2):
      x86/tsx: Use MSR_TSX_CTRL to clear CPUID bits
      x86/tsx: Disable TSX development mode at boot

Peilin Ye (2):
      ip6_gre: Avoid updating tunnel->tun_hlen in __gre6_xmit()
      ip6_gre: Fix skb_under_panic in __gre6_xmit()

Peter Ujfalusi (1):
      ASoC: topology: Correct error handling in soc_tplg_dapm_widget_create()

Peter Wang (1):
      scsi: ufs: core: scsi_get_lba() error fix

Petr Malat (1):
      sctp: Initialize daddr on peeled off socket

QintaoShen (1):
      drm/amdkfd: Check for potential null return of kmalloc_array()

Qu Wenruo (1):
      btrfs: remove unused parameter nr_pages in add_ra_bio_pages()

Rameshkumar Sundaram (1):
      cfg80211: hold bss_lock while updating nontrans_list

Randy Dunlap (1):
      net: micrel: fix KS8851_MLL Kconfig

Rei Yamamoto (1):
      genirq/affinity: Consider that CPUs on nodes can be unbalanced

Richard Gong (1):
      ACPI: processor idle: Allow playing dead in C3 state

Rob Clark (2):
      drm/msm: Add missing put_task_struct() in debugfs path
      drm/msm: Fix range size vs end confusion

Rob Herring (2):
      arm64: dts: imx: Fix imx8*-var-som touchscreen property sizes
      arm_pmu: Validate single/group leader events

Roman Li (2):
      drm/amd/display: Enable power gating before init_pipes
      drm/amd/display: Fix allocate_mst_payload assert on resume

Ronnie Sahlberg (1):
      cifs: verify that tcon is valid before dereference in cifs_kill_sb

Sabrina Dubroca (1):
      esp: limit skb_page_frag_refill use to a single page

Sameer Pujar (1):
      reset: tegra-bpmp: Restore Handle errors in BPMP response

Sasha Neftin (3):
      igc: Fix infinite loop in release_swfw_sync
      igc: Fix BUG: scheduling while atomic
      e1000e: Fix possible overflow in LTR decoding

Sean Christopherson (3):
      KVM: x86/mmu: Resolve nx_huge_pages when kvm.ko is loaded
      KVM: x86: Pend KVM_REQ_APICV_UPDATE during vCPU creation to fix a race
      KVM: nVMX: Defer APICv updates while L2 is active until L1 is active

Sergey Matyukevich (1):
      ARC: entry: fix syscall_trace_exit argument

Shakeel Butt (1):
      memcg: sync flush only if periodic flush is delayed

Shubhrajyoti Datta (1):
      EDAC/synopsys: Read the error count from the correct register

Shyam Prasad N (1):
      cifs: release cached dentries only if mount is complete

Sreekanth Reddy (1):
      scsi: mpt3sas: Fail reset operation if config request timed out

Srinivas Kandagatla (1):
      ASoC: codecs: wcd934x: do not switch off SIDO Buck when codec is in use

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: ITMT support for overclocked system

Stephen Boyd (1):
      drm/msm/dsi: Use connector directly in msm_dsi_manager_connector_init()

Stephen Hemminger (1):
      net: restore alpha order to Ethernet devices in config

Steve Capper (1):
      tlb: hugetlb: Add more sizes to tlb_remove_huge_tlb_entry

Steven Price (1):
      cpu/hotplug: Remove the 'cpu' member of cpuhp_cpu_state

Tadeusz Struk (1):
      ext4: limit length to bitmap_maxbytes - blocksize in punch_hole

Takashi Iwai (45):
      ALSA: core: Add snd_card_free_on_error() helper
      ALSA: sis7019: Fix the missing error handling
      ALSA: ali5451: Fix the missing snd_card_free() call at probe error
      ALSA: als300: Fix the missing snd_card_free() call at probe error
      ALSA: als4000: Fix the missing snd_card_free() call at probe error
      ALSA: atiixp: Fix the missing snd_card_free() call at probe error
      ALSA: au88x0: Fix the missing snd_card_free() call at probe error
      ALSA: aw2: Fix the missing snd_card_free() call at probe error
      ALSA: azt3328: Fix the missing snd_card_free() call at probe error
      ALSA: bt87x: Fix the missing snd_card_free() call at probe error
      ALSA: ca0106: Fix the missing snd_card_free() call at probe error
      ALSA: cmipci: Fix the missing snd_card_free() call at probe error
      ALSA: cs4281: Fix the missing snd_card_free() call at probe error
      ALSA: cs5535audio: Fix the missing snd_card_free() call at probe error
      ALSA: echoaudio: Fix the missing snd_card_free() call at probe error
      ALSA: emu10k1x: Fix the missing snd_card_free() call at probe error
      ALSA: ens137x: Fix the missing snd_card_free() call at probe error
      ALSA: es1938: Fix the missing snd_card_free() call at probe error
      ALSA: es1968: Fix the missing snd_card_free() call at probe error
      ALSA: fm801: Fix the missing snd_card_free() call at probe error
      ALSA: galaxy: Fix the missing snd_card_free() call at probe error
      ALSA: hdsp: Fix the missing snd_card_free() call at probe error
      ALSA: hdspm: Fix the missing snd_card_free() call at probe error
      ALSA: ice1724: Fix the missing snd_card_free() call at probe error
      ALSA: intel8x0: Fix the missing snd_card_free() call at probe error
      ALSA: intel_hdmi: Fix the missing snd_card_free() call at probe error
      ALSA: korg1212: Fix the missing snd_card_free() call at probe error
      ALSA: lola: Fix the missing snd_card_free() call at probe error
      ALSA: lx6464es: Fix the missing snd_card_free() call at probe error
      ALSA: maestro3: Fix the missing snd_card_free() call at probe error
      ALSA: oxygen: Fix the missing snd_card_free() call at probe error
      ALSA: riptide: Fix the missing snd_card_free() call at probe error
      ALSA: rme32: Fix the missing snd_card_free() call at probe error
      ALSA: rme9652: Fix the missing snd_card_free() call at probe error
      ALSA: rme96: Fix the missing snd_card_free() call at probe error
      ALSA: sc6000: Fix the missing snd_card_free() call at probe error
      ALSA: sonicvibes: Fix the missing snd_card_free() call at probe error
      ALSA: via82xx: Fix the missing snd_card_free() call at probe error
      ALSA: usb-audio: Cap upper limits of buffer/period bytes for implicit fb
      ALSA: nm256: Don't call card private_free at probe error path
      ALSA: ad1889: Fix the missing snd_card_free() call at probe error
      ALSA: mtpav: Don't call card private_free at probe error path
      ALSA: usb-audio: Increase max buffer size
      ALSA: usb-audio: Limit max buffer and period sizes per time
      ALSA: usb-audio: Clear MIDI port active flag after draining

Tao Jin (1):
      ALSA: hda/realtek: add quirk for Lenovo Thinkpad X12 speakers

Theodore Ts'o (2):
      ext4: fix overhead calculation to account for the reserved gdt blocks
      ext4: force overhead calculation if the s_overhead_cluster makes no sense

Tianci Yin (1):
      drm/amdgpu/vcn: improve vcn dpg stop procedure

Tim Crawford (2):
      ALSA: hda/realtek: Add quirk for Clevo PD50PNT
      ALSA: hda/realtek: Add quirk for Clevo NP70PNP

Toke Høiland-Jørgensen (2):
      ath9k: Properly clear TX status area before reporting to mac80211
      ath9k: Fix usage of driver-private space in tx_info

Tom Rix (1):
      scsi: sr: Do not leak information in ioctl

Tomas Melin (1):
      net: macb: Restart tx only if queue pointer is lagging

Tomasz Moń (1):
      drm/amdgpu: Enable gfxoff quirk on MacBook Pro

Tony Lu (1):
      net/smc: Fix sock leak when release after smc_shutdown()

Tudor Ambarus (1):
      spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller

Tushar Patel (1):
      drm/amdkfd: Fix Incorrect VMIDs passed to HWS

Tyrel Datwyler (1):
      scsi: ibmvscsis: Increase INITIAL_SRP_LIMIT to 1024

Vadim Pasternak (1):
      mlxsw: i2c: Fix initialization error flow

Vinicius Costa Gomes (1):
      igc: Fix suspending when PTM is active

Vlad Buslov (1):
      net/sched: flower: fix parsing of ethertype following VLAN header

Vladimir Oltean (2):
      net: mdio: don't defer probe forever if PHY IRQ provider is missing
      net: mscc: ocelot: fix broken IP multicast flooding

Woody Suwalski (1):
      ACPI: processor: idle: fix lockup regression on 32-bit ThinkPad T40

Xiaoguang Wang (1):
      scsi: target: tcmu: Fix possible page UAF

Xiaoke Wang (2):
      drm/msm/disp: check the return value of kzalloc()
      drm/msm/mdp5: check the return of kzalloc()

Xiaomeng Tong (3):
      myri10ge: fix an incorrect free for skb in myri10ge_sw_tso
      dma: at_xdmac: fix a missing check on list iterator
      ASoC: soc-dapm: fix two incorrect uses of list iterator

Xiongwei Song (1):
      mm: page_alloc: fix building error on -Werror=array-compare

Xu Yu (1):
      mm/memory-failure.c: skip huge_zero_page in memory_failure()

Ye Bin (3):
      ext4: fix symlink file size not match to file content
      ext4: fix use-after-free in ext4_search_dir
      jbd2: fix a potential race while discarding reserved buffers after an abort

Zheyu Ma (1):
      ata: pata_marvell: Check the 'bmdma_addr' beforing reading

Zhipeng Xie (1):
      perf/core: Fix perf_mmap fail when CONFIG_PERF_USE_VMALLOC enabled

kuyo chang (1):
      sched/pelt: Fix attach_entity_load_avg() corner case

wangjianjian (C) (1):
      ext4, doc: fix incorrect h_reserved size

zhangqilong (1):
      dmaengine: mediatek:Fix PM usage reference leak of mtk_uart_apdma_alloc_chan_resources
---
.../devicetree/bindings/net/qcom,ipa.yaml          |   6 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |   6 +-
 Documentation/filesystems/ext4/attributes.rst      |   2 +-
 Makefile                                           |   2 +-
 arch/arc/kernel/entry.S                            |   1 +
 arch/arm/mach-davinci/board-da850-evm.c            |   4 +-
 arch/arm/mach-vexpress/spc.c                       |   2 +-
 arch/arm64/Kconfig                                 |   1 -
 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi  |   8 +-
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   8 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   2 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   2 +
 arch/arm64/include/asm/page.h                      |   1 -
 arch/arm64/include/asm/pgtable.h                   |   4 +-
 arch/arm64/kernel/alternative.c                    |   6 +-
 arch/arm64/kernel/cpuidle.c                        |   6 +-
 arch/arm64/mm/init.c                               |  37 ----
 arch/powerpc/kvm/book3s_64_vio.c                   |  45 ++--
 arch/powerpc/kvm/book3s_64_vio_hv.c                |  44 ++--
 arch/powerpc/perf/power10-pmu.c                    |   2 +-
 arch/powerpc/perf/power9-pmu.c                     |   8 +-
 arch/x86/include/asm/compat.h                      |   6 +-
 arch/x86/include/asm/kvm_host.h                    |   5 +-
 arch/x86/include/asm/msr-index.h                   |   4 +-
 arch/x86/kernel/cpu/common.c                       |   2 +
 arch/x86/kernel/cpu/cpu.h                          |   5 +-
 arch/x86/kernel/cpu/intel.c                        |   7 -
 arch/x86/kernel/cpu/tsx.c                          | 104 ++++++++-
 arch/x86/kvm/mmu/mmu.c                             |  20 +-
 arch/x86/kvm/pmu.h                                 |   9 +
 arch/x86/kvm/svm/pmu.c                             |   1 +
 arch/x86/kvm/svm/sev.c                             |   9 +-
 arch/x86/kvm/vmx/nested.c                          |   5 +
 arch/x86/kvm/vmx/pmu_intel.c                       |   8 +-
 arch/x86/kvm/vmx/vmx.c                             |   5 +
 arch/x86/kvm/vmx/vmx.h                             |   1 +
 arch/x86/kvm/x86.c                                 |  35 ++-
 arch/xtensa/kernel/coprocessor.S                   |   4 +-
 arch/xtensa/kernel/jump_label.c                    |   2 +-
 block/bdev.c                                       |  28 ++-
 block/bio.c                                        |   2 +-
 block/ioctl.c                                      |   2 +-
 drivers/acpi/processor_idle.c                      |  23 +-
 drivers/ata/libata-core.c                          |   3 +
 drivers/ata/pata_marvell.c                         |   2 +
 drivers/base/dd.c                                  |   1 +
 drivers/block/drbd/drbd_main.c                     |   1 +
 drivers/cpufreq/intel_pstate.c                     |  10 +
 drivers/dma/at_xdmac.c                             |  12 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c              |   7 +-
 drivers/dma/idxd/device.c                          |   6 +-
 drivers/dma/idxd/sysfs.c                           |   6 +
 drivers/dma/imx-sdma.c                             |  32 +--
 drivers/dma/mediatek/mtk-uart-apdma.c              |   9 +-
 drivers/edac/synopsys_edac.c                       |  16 +-
 drivers/firmware/arm_scmi/clock.c                  |   3 +-
 drivers/firmware/arm_scmi/driver.c                 |   3 +-
 drivers/gpio/gpiolib-acpi.c                        |   4 +-
 drivers/gpio/gpiolib.c                             |   4 +-
 drivers/gpu/drm/amd/amdgpu/ObjectID.h              |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |   3 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  29 ++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  14 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   5 +-
 .../gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c  |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c    |  63 ++++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |   5 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   2 +
 .../amd/display/modules/info_packet/info_packet.c  |   5 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  38 ++--
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   3 +
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |   2 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   6 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  20 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |   1 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |   2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   1 +
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |  13 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   2 +-
 drivers/gpu/ipu-v3/ipu-di.c                        |   5 +-
 drivers/hv/hv_balloon.c                            |  36 +++-
 drivers/hv/ring_buffer.c                           |  11 +-
 drivers/hv/vmbus_drv.c                             |  18 +-
 drivers/i2c/busses/i2c-pasemi.c                    |   6 +
 drivers/i2c/i2c-dev.c                              |  15 +-
 drivers/input/keyboard/omap4-keypad.c              |   2 +-
 drivers/md/dm-integrity.c                          |   7 +-
 drivers/md/dm-ps-historical-service-time.c         |  10 +-
 drivers/media/platform/rockchip/rga/rga.c          |   2 +-
 drivers/memory/atmel-ebi.c                         |  23 +-
 drivers/memory/renesas-rpc-if.c                    |  10 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c             |   2 +-
 drivers/net/ethernet/Kconfig                       |  26 +--
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   8 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   8 +-
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c    |  24 +--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   4 +-
 drivers/net/ethernet/cadence/macb_main.c           |   8 +
 drivers/net/ethernet/faraday/ftgmac100.c           |  10 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   8 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   4 +-
 drivers/net/ethernet/intel/igc/igc_i225.c          |  11 +-
 drivers/net/ethernet/intel/igc/igc_phy.c           |   4 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |  15 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |   1 +
 drivers/net/ethernet/micrel/Kconfig                |   1 +
 drivers/net/ethernet/mscc/ocelot.c                 |   2 +
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |   6 +-
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.c |   8 -
 drivers/net/ethernet/stmicro/stmmac/altr_tse_pcs.h |   4 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  13 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   4 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  13 +-
 drivers/net/hamradio/6pack.c                       |   5 +-
 drivers/net/ipa/Kconfig                            |   1 +
 drivers/net/ipa/ipa_power.c                        |  52 +++++
 drivers/net/ipa/ipa_power.h                        |   7 +
 drivers/net/ipa/ipa_uc.c                           |   5 +
 drivers/net/macvlan.c                              |   8 +-
 drivers/net/mdio/fwnode_mdio.c                     |   5 +
 drivers/net/slip/slip.c                            |   2 +-
 drivers/net/usb/aqc111.c                           |   9 +-
 drivers/net/veth.c                                 |   2 +-
 drivers/net/vxlan.c                                |   4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  21 +-
 drivers/net/wireless/ath/ath9k/main.c              |   2 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |  33 +--
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |   2 +-
 drivers/nvme/host/core.c                           |  24 ++-
 drivers/nvme/host/nvme.h                           |   5 +
 drivers/nvme/host/pci.c                            |   9 +-
 drivers/pci/controller/pci-hyperv.c                |   9 +
 drivers/perf/arm_pmu.c                             |  10 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |   2 +-
 drivers/platform/x86/samsung-laptop.c              |   2 -
 drivers/regulator/wm8994-regulator.c               |  42 +++-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c            |   4 +-
 drivers/reset/tegra/reset-bpmp.c                   |   9 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |   2 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |   2 +-
 drivers/scsi/cxgbi/libcxgbi.c                      |   6 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           |   2 +-
 drivers/scsi/libiscsi.c                            |  27 ++-
 drivers/scsi/libiscsi_tcp.c                        |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   2 +
 drivers/scsi/megaraid/megaraid_sas.h               |   3 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |   7 +
 drivers/scsi/mpt3sas/mpt3sas_config.c              |   9 +-
 drivers/scsi/mvsas/mv_init.c                       |   1 +
 drivers/scsi/pm8001/pm80xx_hwi.c                   |  33 ++-
 drivers/scsi/qedi/qedi_iscsi.c                     |  69 +++---
 drivers/scsi/scsi_transport_iscsi.c                | 239 ++++++++++++---------
 drivers/scsi/sr_ioctl.c                            |  15 +-
 drivers/scsi/ufs/ufshcd.c                          |   5 +-
 drivers/soc/qcom/qcom_aoss.c                       |  58 ++++-
 drivers/spi/atmel-quadspi.c                        |   3 +
 drivers/spi/spi-cadence-quadspi.c                  |  65 +++---
 drivers/spi/spi-mtk-nor.c                          |  12 +-
 drivers/target/target_core_user.c                  |   3 +-
 drivers/vfio/pci/vfio_pci_core.c                   | 124 ++++++-----
 fs/btrfs/block-group.c                             |   4 -
 fs/btrfs/compression.c                             |   2 -
 fs/btrfs/disk-io.c                                 |   5 +-
 fs/btrfs/extent_io.c                               |   5 +-
 fs/btrfs/file.c                                    |  13 +-
 fs/btrfs/inode.c                                   |   7 +-
 fs/btrfs/volumes.c                                 |   2 +
 fs/cifs/cifsfs.c                                   |  30 +--
 fs/cifs/link.c                                     |   3 +
 fs/ext4/ext4.h                                     |   6 +-
 fs/ext4/extents.c                                  |  32 ++-
 fs/ext4/inode.c                                    |  18 +-
 fs/ext4/namei.c                                    |   4 +-
 fs/ext4/page-io.c                                  |   4 +-
 fs/ext4/super.c                                    |  19 +-
 fs/gfs2/rgrp.c                                     |   9 +-
 fs/hugetlbfs/inode.c                               |   9 +-
 fs/internal.h                                      |  11 -
 fs/io_uring.c                                      |  24 ++-
 fs/jbd2/commit.c                                   |   4 +-
 fs/namei.c                                         |  22 +-
 fs/stat.c                                          |  19 +-
 fs/sync.c                                          |  72 +++----
 fs/xfs/xfs_super.c                                 |   6 +-
 include/asm-generic/tlb.h                          |  10 +-
 include/linux/blkdev.h                             |   9 +
 include/linux/etherdevice.h                        |   5 +-
 include/linux/kfence.h                             |  24 +++
 include/linux/memcontrol.h                         |   5 +
 include/linux/netfilter/nf_conntrack_common.h      |  10 +-
 include/linux/sched.h                              |   1 +
 include/linux/sched/mm.h                           |   8 +
 include/linux/soc/qcom/qcom_aoss.h                 |  38 ++++
 include/linux/sunrpc/svc.h                         |   1 +
 include/linux/vfio_pci_core.h                      |   2 +
 include/net/ax25.h                                 |  12 ++
 include/net/esp.h                                  |   2 -
 include/net/flow_dissector.h                       |   2 +
 include/net/netfilter/nf_conntrack.h               |   8 +-
 include/net/netns/ipv6.h                           |   4 +-
 include/scsi/libiscsi.h                            |   9 +-
 include/scsi/scsi_transport_iscsi.h                |   4 +-
 include/sound/core.h                               |   1 +
 include/trace/events/sunrpc.h                      |   7 +-
 kernel/cpu.c                                       |  36 ++--
 kernel/dma/direct.h                                |   3 +-
 kernel/dma/mapping.c                               |   4 -
 kernel/events/core.c                               |   2 +-
 kernel/events/internal.h                           |   5 +
 kernel/events/ring_buffer.c                        |   5 -
 kernel/irq/affinity.c                              |   5 +-
 kernel/sched/fair.c                                |  10 +-
 kernel/smp.c                                       |   2 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/time/timer.c                                |  11 +-
 localversion-rt                                    |   2 +-
 mm/kfence/core.c                                   |  21 --
 mm/kfence/kfence.h                                 |  21 ++
 mm/kfence/report.c                                 |  47 ++++
 mm/kmemleak.c                                      |   8 +-
 mm/memcontrol.c                                    |  12 +-
 mm/memory-failure.c                                |  13 ++
 mm/mmap.c                                          |   8 -
 mm/mmu_notifier.c                                  |  14 +-
 mm/oom_kill.c                                      |  54 +++--
 mm/page_alloc.c                                    |   4 +-
 mm/page_io.c                                       |  54 -----
 mm/secretmem.c                                     |  17 ++
 mm/slab.c                                          |   2 +-
 mm/slab.h                                          |   2 +-
 mm/slab_common.c                                   |   9 +
 mm/slob.c                                          |   2 +-
 mm/slub.c                                          |   2 +-
 mm/workingset.c                                    |   2 +-
 net/ax25/af_ax25.c                                 |  38 +++-
 net/ax25/ax25_dev.c                                |  28 ++-
 net/ax25/ax25_route.c                              |  13 +-
 net/ax25/ax25_subr.c                               |  20 +-
 net/can/isotp.c                                    |  10 +-
 net/core/flow_dissector.c                          |   1 +
 net/dsa/tag_hellcreek.c                            |   8 +
 net/ipv4/esp4.c                                    |   5 +-
 net/ipv6/esp6.c                                    |   5 +-
 net/ipv6/ip6_gre.c                                 |  14 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/route.c                                   |  11 +-
 net/l3mdev/l3mdev.c                                |   2 +-
 net/netfilter/nf_conntrack_core.c                  |  38 ++--
 net/netfilter/nf_conntrack_expect.c                |   4 +-
 net/netfilter/nf_conntrack_netlink.c               |   6 +-
 net/netfilter/nf_conntrack_standalone.c            |   4 +-
 net/netfilter/nf_flow_table_core.c                 |   2 +-
 net/netfilter/nf_synproxy_core.c                   |   1 -
 net/netfilter/nf_tables_api.c                      |   2 +-
 net/netfilter/nft_ct.c                             |   9 +-
 net/netfilter/nft_socket.c                         |   7 +-
 net/netfilter/xt_CT.c                              |   3 +-
 net/netlink/af_netlink.c                           |   7 +
 net/nfc/nci/core.c                                 |   4 +
 net/openvswitch/conntrack.c                        |   1 -
 net/openvswitch/flow_netlink.c                     |   2 +-
 net/packet/af_packet.c                             |  13 +-
 net/rxrpc/net_ns.c                                 |   2 +
 net/sched/act_ct.c                                 |   1 -
 net/sched/cls_api.c                                |   2 +-
 net/sched/cls_flower.c                             |  18 +-
 net/sched/cls_u32.c                                |  24 ++-
 net/sched/sch_taprio.c                             |   3 +-
 net/sctp/socket.c                                  |   2 +-
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc_pnet.c                                 |   5 +-
 net/sunrpc/svc_xprt.c                              |   3 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |   2 +-
 net/wireless/nl80211.c                             |   3 +-
 net/wireless/scan.c                                |   2 +
 scripts/gcc-plugins/latent_entropy_plugin.c        |  44 ++--
 sound/core/init.c                                  |  28 +++
 sound/core/pcm_misc.c                              |   2 +-
 sound/drivers/mtpav.c                              |   4 +-
 sound/isa/galaxy/galaxy.c                          |   7 +-
 sound/isa/sc6000.c                                 |   7 +-
 sound/pci/ad1889.c                                 |  10 +-
 sound/pci/ali5451/ali5451.c                        |  10 +-
 sound/pci/als300.c                                 |   8 +-
 sound/pci/als4000.c                                |  10 +-
 sound/pci/atiixp.c                                 |  10 +-
 sound/pci/atiixp_modem.c                           |  10 +-
 sound/pci/au88x0/au88x0.c                          |   8 +-
 sound/pci/aw2/aw2-alsa.c                           |   8 +-
 sound/pci/azt3328.c                                |   8 +-
 sound/pci/bt87x.c                                  |  10 +-
 sound/pci/ca0106/ca0106_main.c                     |  10 +-
 sound/pci/cmipci.c                                 |   8 +-
 sound/pci/cs4281.c                                 |  10 +-
 sound/pci/cs5535audio/cs5535audio.c                |  10 +-
 sound/pci/echoaudio/echoaudio.c                    |   9 +-
 sound/pci/emu10k1/emu10k1x.c                       |  10 +-
 sound/pci/ens1370.c                                |  10 +-
 sound/pci/es1938.c                                 |  10 +-
 sound/pci/es1968.c                                 |  10 +-
 sound/pci/fm801.c                                  |  10 +-
 sound/pci/hda/patch_hdmi.c                         |   6 +-
 sound/pci/hda/patch_realtek.c                      |   3 +
 sound/pci/ice1712/ice1724.c                        |  10 +-
 sound/pci/intel8x0.c                               |  10 +-
 sound/pci/intel8x0m.c                              |  10 +-
 sound/pci/korg1212/korg1212.c                      |   8 +-
 sound/pci/lola/lola.c                              |  10 +-
 sound/pci/lx6464es/lx6464es.c                      |   8 +-
 sound/pci/maestro3.c                               |   8 +-
 sound/pci/nm256/nm256.c                            |   2 +-
 sound/pci/oxygen/oxygen_lib.c                      |  12 +-
 sound/pci/riptide/riptide.c                        |   8 +-
 sound/pci/rme32.c                                  |   8 +-
 sound/pci/rme96.c                                  |  10 +-
 sound/pci/rme9652/hdsp.c                           |   8 +-
 sound/pci/rme9652/hdspm.c                          |   8 +-
 sound/pci/rme9652/rme9652.c                        |   8 +-
 sound/pci/sis7019.c                                |  14 +-
 sound/pci/sonicvibes.c                             |  10 +-
 sound/pci/via82xx.c                                |  10 +-
 sound/pci/via82xx_modem.c                          |  10 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |  61 ------
 sound/soc/codecs/msm8916-wcd-digital.c             |   9 +-
 sound/soc/codecs/rk817_codec.c                     |   2 +-
 sound/soc/codecs/wcd934x.c                         |  26 +--
 sound/soc/soc-dapm.c                               |   6 +-
 sound/soc/soc-topology.c                           |   4 +-
 sound/usb/midi.c                                   |   1 +
 sound/usb/pcm.c                                    |  16 +-
 sound/usb/usbaudio.h                               |   2 +-
 sound/x86/intel_hdmi_audio.c                       |   7 +-
 tools/arch/x86/include/asm/msr-index.h             |   4 +-
 tools/lib/perf/evlist.c                            |   3 +-
 tools/perf/builtin-report.c                        |  14 ++
 tools/perf/builtin-script.c                        |   2 +-
 tools/perf/util/parse-events.c                     |   5 +-
 .../selftests/drivers/net/mlxsw/vxlan_flooding.sh  |  17 ++
 tools/testing/selftests/mqueue/mq_perf_tests.c     |  25 ++-
 357 files changed, 2680 insertions(+), 1352 deletions(-)
---
