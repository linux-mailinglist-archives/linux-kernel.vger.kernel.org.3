Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C704CDDDA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiCDULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiCDUIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:08:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877318F605;
        Fri,  4 Mar 2022 12:03:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87555B82B7E;
        Fri,  4 Mar 2022 19:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C5DC340E9;
        Fri,  4 Mar 2022 19:38:40 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.232-rt104
Date:   Fri, 04 Mar 2022 19:35:43 -0000
Message-ID: <164642254363.3441070.3803906129050387693@puck.lan>
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
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.232-rt104 stable release.

In addition to the merge of the upstream 4.19.232 tree, this release contains a fix
for a typo released earlier, which shows up when compiling this tree with
CONFIG_PREEMPT_RT_FULL turned off. An incorrect paren placement caused the compiler
to choke on a macro invocation of READ_ONCE in include/linux/netdevice.h, specifically
in the netdev_queue_has_owner() function call.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: aafc335300cd297ce325cc4986a248e672155ac1

Or to build 4.19.232-rt104 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.232.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.232-rt104.patch.xz


You can also build from 4.19.230-rt103 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.230-rt103-rt104.patch.xz

Enjoy!
Clark

Changes from v4.19.230-rt103:
---

Anders Roxell (1):
      powerpc/lib/sstep: fix 'ptesync' build error

Bart Van Assche (1):
      RDMA/ib_srp: Fix a deadlock

Brenda Streiff (1):
      kconfig: let 'shell' return enough output for deep path names

Bryan O'Donoghue (1):
      mtd: rawnand: qcom: Fix clock sequencing in qcom_nandc_probe()

ChenXiaoSong (1):
      configfs: fix a race in configfs_{,un}register_subsystem()

Christian Hewitt (1):
      arm64: dts: meson-gx: add ATF BL32 reserved-memory region

Christian Löhle (1):
      mmc: block: fix read single on recovery logic

Christophe JAILLET (1):
      iio: adc: men_z188_adc: Fix a resource leak in an error handling path

Clark Williams (3):
      netdevice:  Fix PREEMPT_RT thinko in READ_ONCE usage
      Merge tag 'v4.19.232' into v4.19-rt
      Linux 4.19.232-rt104

Daehwan Jung (1):
      usb: gadget: rndis: add spinlock for rndis response list

Dan Carpenter (1):
      tipc: Fix end of loop tests for list_for_each_entry()

Daniele Palmas (1):
      USB: serial: option: add Telit LE910R1 compositions

Darrick J. Wong (2):
      vfs: make freeze_super abort when sync_filesystem returns error
      quota: make dquot_quota_sync return errors from ->sync_fs

Dmytro Bagrii (1):
      Revert "USB: serial: ch341: add new Product ID for CH341A"

Duoming Zhou (1):
      ax25: improve the incomplete fix to avoid UAF and NPD bugs

Dāvis Mosāns (1):
      btrfs: send: in case of IO error log it

Eliav Farber (1):
      EDAC: Fix calculation of returned address and next offset in edac_align_ptr()

Eric Dumazet (4):
      drop_monitor: fix data-race in dropmon_net_event / trace_napi_poll_hit
      bonding: fix data-races around agg_select_timer
      net: sched: limit TC_ACT_REPEAT loops
      net: __pskb_pull_tail() & pskb_carve_frag_list() drop_monitor friends

Eric W. Biederman (1):
      taskstats: Cleanup the use of task->exit_code

Florian Westphal (1):
      netfilter: conntrack: don't refresh sctp entries in closed state

Gal Pressman (1):
      net/mlx5e: Fix wrong return value on ioctl EEPROM query failure

Greg Kroah-Hartman (2):
      Linux 4.19.231
      Linux 4.19.232

Guillaume Nault (1):
      xfrm: Don't accidentally set RTO_ONLINK in decode_session4()

Guo Ren (1):
      irqchip/sifive-plic: Add missing thead,c900-plic match string

Hans de Goede (1):
      usb: dwc3: pci: Fix Bay Trail phy GPIO mappings

Helge Deller (2):
      parisc/unaligned: Fix fldd and fstd unaligned handlers on 32-bit kernel
      parisc/unaligned: Fix ldw() and stw() unalignment handlers

Hongyu Xie (1):
      xhci: Prevent futile URB re-submissions due to incorrect return value.

Igor Pylypiv (1):
      Revert "module, async: async_synchronize_full() on module init iff async is used"

JaeSang Yoo (1):
      tracing: Fix tp_printk option related with tp_printk_stop_on_boot

Jann Horn (1):
      net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup

Jiasheng Jiang (1):
      dmaengine: sh: rcar-dmac: Check for error num after setting mask

Jim Mattson (1):
      KVM: x86/pmu: Use AMD64_RAW_EVENT_MASK for PERF_TYPE_RAW

Johannes Berg (3):
      iwlwifi: fix use-after-free
      iwlwifi: pcie: fix locking when "HW not ready"
      iwlwifi: pcie: gen2: fix locking when "HW not ready"

John David Anglin (2):
      parisc: Fix data TLB miss in sba_unmap_sg
      parisc: Fix sglist access in ccio-dma.c

Kamal Dasu (1):
      mtd: rawnand: brcmnand: Refactored code to introduce helper functions

Karol Herbst (1):
      Revert "drm/nouveau/pmu/gm200-: avoid touching PMU outside of DEVINIT/PREOS/ACR"

Kees Cook (1):
      libsubcmd: Fix use-after-free for realloc(..., 0)

Kimberly Brown (1):
      Drivers: hv: vmbus: Expose monitor data only when monitor pages are used

Laibin Qiu (1):
      block/wbt: fix negative inflight counter when remove scsi device

Linus Torvalds (1):
      fget: clarify and improve __fget_files() implementation

Mans Rullgard (1):
      net: dsa: lan9303: fix reset on probe

Marc St-Amand (1):
      net: macb: Align the dma and coherent dma masks

Marc Zyngier (1):
      gpio: tegra186: Fix chip_data type confusion

Mark Brown (2):
      ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw()
      ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_range()

Max Kellermann (1):
      lib/iov_iter: initialize "flags" in new pipe_buffer

Maxime Ripard (1):
      drm/edid: Always set RGB444

Miaohe Lin (1):
      memblock: use kfree() to release kmalloced memblock regions

Miaoqian Lin (1):
      Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj

Miquel Raynal (2):
      net: ieee802154: at86rf230: Stop leaking skb's
      net: ieee802154: ca8210: Fix lifs/sifs periods

Nathan Chancellor (1):
      Makefile.extrawarn: Move -Wunaligned-access to W=1

Nicholas Bishop (1):
      drm/radeon: Fix backlight control on iMac 12,1

Oliver Neukum (2):
      sr9700: sanity check for packet length
      USB: zaurus: support another broken Zaurus

Paul Blakey (1):
      openvswitch: Fix setting ipv6 fields causing hw csum failure

Puma Hsu (1):
      xhci: re-initialize the HC during resume if HCE was set

Rafał Miłecki (1):
      i2c: brcmstb: fix support for DSL and CM variants

Randy Dunlap (1):
      serial: parisc: GSC: fix build when IOSAPIC is not set

Sagi Grimberg (2):
      nvme: fix a possible use-after-free in controller reset during load
      nvme-rdma: fix possible use-after-free in transport error_recovery work

Sebastian Andrzej Siewior (1):
      usb: dwc3: gadget: Let the interrupt handler disable bottom halves.

Sergey Shtylyov (1):
      ata: pata_hpt37x: disable primary channel on HPT371

Seth Forshee (1):
      vsock: remove vsock from connected table when connect is interrupted by a signal

Slark Xiao (2):
      net: usb: qmi_wwan: Add support for Dell DW5829e
      USB: serial: option: add support for DW5829e

Stefano Garzarella (1):
      vhost/vsock: don't check owner in vhost_vsock_stop() while releasing

Steven Rostedt (Google) (2):
      tracing: Have traceon and traceoff trigger honor the instance
      tracefs: Set the group ownership in apply_options() not parse_options()

Szymon Heidrich (1):
      USB: gadget: validate endpoint index for xilinx udc

Takashi Iwai (2):
      ALSA: hda: Fix regression on forced probe mask option
      ALSA: hda: Fix missing codec probe on Shenker Dock 15

Tao Liu (1):
      gso: do not skip outer ip header in case of ipip and net_failover

Trond Myklebust (2):
      NFS: LOOKUP_DIRECTORY is also ok with symlinks
      NFS: Do not report writeback errors in nfs_getattr()

Wan Jiabing (1):
      ARM: OMAP2+: hwmod: Add of_node_put() before break

Xin Long (2):
      ping: fix the dif and sdif check in ping_lookup
      ping: remove pr_err from ping_lookup

Yang Xu (3):
      selftests/zram: Skip max_comp_streams interface on newer kernel
      selftests/zram01.sh: Fix compression ratio calculation
      selftests/zram: Adapt the situation that /dev/zram0 is being used

Zhang Qiao (1):
      cgroup/cpuset: Fix a race between cpuset_attach() and cpu hotplug

Zhang Yi (1):
      ext4: check for out-of-order index extents in ext4_valid_extent_entries()

Zoltán Böszörményi (1):
      ata: libata-core: Disable TRIM on M88V29

daniel.starke@siemens.com (2):
      tty: n_gsm: fix proper link termination after failed open
      tty: n_gsm: fix encoding of control signal octet bit DV

david regan (1):
      mtd: rawnand: brcmnand: Fixed incorrect sub-page ECC status
---
Documentation/ABI/stable/sysfs-bus-vmbus           |  12 +-
 Makefile                                           |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   4 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   6 +
 arch/parisc/kernel/unaligned.c                     |  14 +--
 arch/powerpc/lib/sstep.c                           |   2 +
 arch/x86/kvm/pmu.c                                 |   2 +-
 block/bfq-iosched.c                                |   2 +
 block/elevator.c                                   |   2 -
 drivers/ata/libata-core.c                          |   1 +
 drivers/ata/pata_hpt37x.c                          |  14 +++
 drivers/dma/sh/rcar-dmac.c                         |   4 +-
 drivers/edac/edac_mc.c                             |   2 +-
 drivers/gpio/gpio-tegra186.c                       |  14 ++-
 drivers/gpu/drm/drm_edid.c                         |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c     |  37 +++---
 drivers/gpu/drm/radeon/atombios_encoders.c         |   3 +-
 drivers/hv/channel_mgmt.c                          |   1 +
 drivers/hv/hyperv_vmbus.h                          |   2 +
 drivers/hv/vmbus_drv.c                             |  82 ++++++++++++-
 drivers/i2c/busses/i2c-brcmstb.c                   |   2 +-
 drivers/iio/adc/men_z188_adc.c                     |   9 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   6 +-
 drivers/irqchip/irq-sifive-plic.c                  |   1 +
 drivers/mmc/core/block.c                           |  28 ++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           | 102 ++++++++++------
 drivers/mtd/nand/raw/qcom_nandc.c                  |  14 +--
 drivers/net/bonding/bond_3ad.c                     |  30 ++++-
 drivers/net/dsa/lan9303-core.c                     |   2 +-
 drivers/net/ethernet/cadence/macb_main.c           |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   2 +-
 drivers/net/ieee802154/at86rf230.c                 |  13 +-
 drivers/net/ieee802154/ca8210.c                    |   4 +-
 drivers/net/usb/ax88179_178a.c                     |  68 ++++++-----
 drivers/net/usb/cdc_ether.c                        |  12 ++
 drivers/net/usb/qmi_wwan.c                         |   2 +
 drivers/net/usb/sr9700.c                           |   2 +-
 drivers/net/usb/zaurus.c                           |  12 ++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   2 +
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   3 +-
 drivers/nvme/host/core.c                           |   9 +-
 drivers/nvme/host/rdma.c                           |   1 +
 drivers/parisc/ccio-dma.c                          |   3 +-
 drivers/parisc/sba_iommu.c                         |   3 +-
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/serial/8250/8250_gsc.c                 |   2 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   4 +-
 drivers/usb/dwc3/gadget.c                          |   2 +
 drivers/usb/gadget/function/rndis.c                |   8 ++
 drivers/usb/gadget/function/rndis.h                |   1 +
 drivers/usb/gadget/udc/udc-xilinx.c                |   6 +
 drivers/usb/host/xhci.c                            |  28 +++--
 drivers/usb/serial/ch341.c                         |   1 -
 drivers/usb/serial/option.c                        |  12 ++
 drivers/vhost/vsock.c                              |  21 ++--
 fs/btrfs/send.c                                    |   4 +
 fs/configfs/dir.c                                  |  14 +++
 fs/ext4/extents.c                                  |  21 ++--
 fs/file.c                                          |  73 ++++++++---
 fs/nfs/dir.c                                       |   4 +-
 fs/nfs/inode.c                                     |   9 +-
 fs/quota/dquot.c                                   |  11 +-
 fs/super.c                                         |  19 +--
 fs/tracefs/inode.c                                 |   5 +-
 include/linux/netdevice.h                          |   2 +-
 include/linux/sched.h                              |   1 -
 include/net/bond_3ad.h                             |   2 +-
 include/net/checksum.h                             |   5 +
 kernel/async.c                                     |   3 -
 kernel/cgroup/cpuset.c                             |   2 +
 kernel/module.c                                    |  25 +---
 kernel/trace/trace.c                               |   4 +
 kernel/trace/trace_events_trigger.c                |  52 +++++++-
 kernel/tsacct.c                                    |   7 +-
 lib/iov_iter.c                                     |   2 +
 localversion-rt                                    |   2 +-
 mm/memblock.c                                      |  10 +-
 net/ax25/af_ax25.c                                 |   9 +-
 net/core/drop_monitor.c                            |  11 +-
 net/core/skbuff.c                                  |   4 +-
 net/ipv4/af_inet.c                                 |   5 +-
 net/ipv4/ping.c                                    |  10 +-
 net/ipv4/xfrm4_policy.c                            |   3 +-
 net/ipv6/ip6_offload.c                             |   2 +
 net/netfilter/nf_conntrack_proto_sctp.c            |   9 ++
 net/openvswitch/actions.c                          |  46 +++++--
 net/sched/act_api.c                                |  13 +-
 net/tipc/name_table.c                              |   2 +-
 net/tipc/socket.c                                  |   2 +-
 net/vmw_vsock/af_vsock.c                           |   1 +
 scripts/Makefile.extrawarn                         |   1 +
 scripts/kconfig/preprocess.c                       |   2 +-
 sound/pci/hda/hda_intel.c                          |   5 +-
 sound/soc/soc-ops.c                                |  29 +++--
 tools/lib/subcmd/subcmd-util.h                     |  11 +-
 tools/testing/selftests/zram/zram.sh               |  15 +--
 tools/testing/selftests/zram/zram01.sh             |  33 ++---
 tools/testing/selftests/zram/zram02.sh             |   1 -
 tools/testing/selftests/zram/zram_lib.sh           | 134 ++++++++++++++-------
 100 files changed, 863 insertions(+), 394 deletions(-)
---
