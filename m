Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA704849C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiADVX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:23:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36594 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiADVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:23:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B24B7B817F9;
        Tue,  4 Jan 2022 21:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DD5C36AEB;
        Tue,  4 Jan 2022 21:23:25 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.223-rt100
Date:   Tue, 04 Jan 2022 21:22:45 -0000
Message-ID: <164133136582.713651.8616556329027058758@puck.lan>
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

I'm pleased to announce the 4.19.223-rt100 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: e0ac069fc57666e0fecff8b7a2839950b594d9c8

Or to build 4.19.223-rt100 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.223.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.223-rt100.patch.xz


You can also build from 4.19.221-rt99 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.221-rt99-rt100.patch.xz

Enjoy!
Clark

Changes from v4.19.221-rt99:
---

Alyssa Ross (1):
      dmaengine: st_fdma: fix MODULE_ALIAS

Andrew Cooper (1):
      x86/pkey: Fix undefined behaviour with PKRU_WD_BIT

Ard Biesheuvel (2):
      x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol
      ARM: 9169/1: entry: fix Thumb2 bug in iWMMXt exception handling

Armin Wolf (1):
      hwmon: (dell-smm) Fix warning on /proc/i8k creation error

Benjamin Tissoires (1):
      HID: holtek: fix mouse probing

Chao Yu (1):
      f2fs: fix to do sanity check on last xattr entry in __f2fs_setxattr()

Chen Jun (1):
      tracing: Fix a kmemleak false positive in tracing_map

Clark Williams (2):
      Merge tag 'v4.19.223' into v4.19-rt
      Linux 4.19.223-rt100

Colin Ian King (1):
      ALSA: drivers: opl3: Fix incorrect use of vp->state

Cyril Novikov (1):
      ixgbe: set X550 MDIO speed before talking to PHY

Daniele Palmas (1):
      USB: serial: option: add Telit FN990 compositions

Dinh Nguyen (1):
      ARM: socfpga: dts: fix qspi node compatible

Dongliang Mu (1):
      spi: change clk_disable_unprepare to clk_unprepare

Eric Dumazet (2):
      sch_cake: do not call cake_destroy() from cake_init()
      sit: do not call ipip6_dev_free() from sit_init_net()

Erik Ekman (1):
      net/mlx4_en: Update reported link modes for 1/10G

Fabien Dessenne (1):
      pinctrl: stm32: consider the GPIO offset to expose all the GPIO lines

Fabio Estevam (1):
      ARM: dts: imx6ull-pinfunc: Fix CSI_DATA07__ESAI_TX0 pad name

Federico Motta (2):
      block, bfq: improve asymmetric scenarios detection
      block, bfq: fix asymmetric scenarios detection

Felix Fietkau (1):
      mac80211: send ADDBA requests using the tid/queue of the aggregation session

Fernando Fernandez Mancera (1):
      bonding: fix ad_actor_system option setting to default

Florian Fainelli (1):
      net: systemport: Add global locking for descriptor lifecycle

George Kennedy (2):
      libata: if T_LENGTH is zero, dma direction should be DMA_NONE
      scsi: scsi_debug: Sanity check block descriptor length in resp_mode_select()

Greg Jesionowski (1):
      net: usb: lan78xx: add Allied Telesis AT29M2-AF

Greg Kroah-Hartman (3):
      USB: gadget: bRequestType is a bitfield, not a enum
      Linux 4.19.222
      Linux 4.19.223

Guenter Roeck (2):
      hwmon: (lm90) Fix usage of CONFIG2 register in detect function
      hwmon: (lm90) Do not report 'busy' status bit as alarm

Haimin Zhang (1):
      netdevsim: Zero-initialize memory for new map's value in function nsim_bpf_map_alloc

Hangyu Hua (1):
      rds: memory leak in __rds_conn_create()

Harshit Mogalapalli (1):
      net: netlink: af_netlink: Prevent empty skb by adding a check on len.

Helge Deller (1):
      parisc/agp: Annotate parisc agp init functions with __init

Ignacy Gawędzki (1):
      netfilter: fix regression in looped (broad|multi)cast's MAC handling

J. Bruce Fields (1):
      nfsd: fix use-after-free due to delegation race

Jerome Marchand (1):
      recordmcount.pl: look for jgnop instruction as well as bcrl on s390

Jiasheng Jiang (4):
      qlcnic: potential dereference null pointer of rx_queue->page_ring
      fjes: Check for error irq
      drivers: net: smc911x: Check for error irq
      sfc: falcon: Check null pointer of rx_queue->page_ring

Jimmy Wang (1):
      USB: NO_LPM quirk Lenovo USB-C to Ethernet Adapher(RTL8153-04)

Joe Thornber (1):
      dm btree remove: fix use after free in rebalance_children()

Johan Hovold (1):
      USB: serial: cp210x: fix CP2105 GPIO registration

Johannes Berg (2):
      mac80211: track only QoS data frames for admission control
      mac80211: validate extended element ID is present

John David Anglin (1):
      parisc: Correct completer in lws start

José Expósito (2):
      IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()
      Input: atmel_mxt_ts - fix double free in mxt_read_info_block

Juergen Gross (5):
      xen/blkfront: harden blkfront against event channel storms
      xen/netfront: harden netfront against event channel storms
      xen/console: harden hvc_xen against event channel storms
      xen/netback: fix rx queue stall detection
      xen/netback: don't queue unlimited number of packages

Karen Sornek (1):
      igb: Fix removal of unicast MAC filters of VFs

Le Ma (1):
      drm/amdgpu: correct register access for RLC_JUMP_TABLE_RESTORE

Letu Ren (1):
      igbvf: fix double free in `igbvf_probe`

Lin Ma (3):
      ax25: NPD bug when detaching AX25 device
      hamradio: defer ax25 kfree after unregister_netdev
      hamradio: improve the incomplete fix to avoid NPD

Marian Postevca (1):
      usb: gadget: u_ether: fix race in setting MAC address in setup phase

Miklos Szeredi (2):
      fuse: annotate lock in fuse_reverse_inval_entry()
      ovl: fix warning in ovl_create_real()

Nathan Chancellor (4):
      soc/tegra: fuse: Fix bitwise vs. logical OR warning
      net: lan78xx: Avoid unnecessary self assignment
      mwifiex: Remove unnecessary braces from HostCmd_SET_SEQ_NO_BSS_INFO
      Input: touchscreen - avoid bitwise vs logical OR warning

Nicolas Pitre (1):
      ARM: 8805/2: remove unneeded naked function usage

Ondrej Jirman (1):
      i2c: rk3x: Handle a spurious start completion interrupt flag

Paolo Valente (3):
      block, bfq: fix decrement of num_active_groups
      block, bfq: fix queue removal from weights tree
      block, bfq: fix use after free in bfq_bfqq_expire

Paul Moore (1):
      audit: improve robustness of the audit queue handling

Pavel Skripkin (1):
      media: mxl111sf: change mutex_init() location

Philip Chen (1):
      drm/msm/dsi: set default num_data_lanes

Robert Marko (1):
      arm64: dts: allwinner: orangepi-zero-plus: fix PHY mode

Rémi Denis-Courmont (1):
      phonet/pep: refuse to enable an unbound pipe

Sasha Levin (1):
      stable: clamp SUBLEVEL in 4.19

Sean Christopherson (1):
      KVM: VMX: Fix stale docs for kvm-intel.emulate_invalid_guest_state

Stefan Agner (1):
      ARM: 8800/1: use choice for kernel unwinders

Stefan Roese (1):
      PCI/MSI: Mask MSI-X vectors only on success

Sudeep Holla (1):
      firmware: arm_scpi: Fix string overflow in SCPI genpd driver

Tadeusz Struk (1):
      nfc: fix segfault in nfc_genl_dump_devices_done

Thadeu Lima de Souza Cascardo (2):
      ipmi: bail out if init_srcu_struct fails
      ipmi: fix initialization when workqueue allocation fails

Thomas Gleixner (1):
      PCI/MSI: Clear PCI_MSIX_FLAGS_MASKALL on error

Tom Lendacky (1):
      x86/sme: Explicitly map new EFI memmap table as encrypted

Willem de Bruijn (3):
      net/packet: rx_owner_map depends on pg_vec
      net: accept UFOv6 packages in virtio_net_hdr_to_skb
      net: skip virtio_net_hdr_set_proto if protocol already set

Wu Bo (1):
      ipmi: Fix UAF when uninstall ipmi_si and ipmi_msghandler module

Xiaoke Wang (1):
      ALSA: jack: Check the return value of kstrdup()

Yu Liao (1):
      timekeeping: Really make sure wall_to_monotonic isn't positive
---
Documentation/admin-guide/kernel-parameters.txt    |   8 +-
 Documentation/networking/bonding.txt               |  11 +-
 Makefile                                           |   4 +-
 arch/Kconfig                                       |   3 +
 arch/arm/Kconfig.debug                             |  44 ++--
 arch/arm/boot/dts/imx6ull-pinfunc.h                |   2 +-
 arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts   |   2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |   4 +-
 arch/arm/kernel/entry-armv.S                       |   8 +-
 arch/arm/mm/copypage-fa.c                          |  35 ++-
 arch/arm/mm/copypage-feroceon.c                    |  98 ++++---
 arch/arm/mm/copypage-v4mc.c                        |  19 +-
 arch/arm/mm/copypage-v4wb.c                        |  41 ++-
 arch/arm/mm/copypage-v4wt.c                        |  37 ++-
 arch/arm/mm/copypage-xsc3.c                        |  71 +++--
 arch/arm/mm/copypage-xscale.c                      |  71 +++--
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts |   2 +-
 arch/parisc/kernel/syscall.S                       |   2 +-
 arch/x86/Kconfig                                   |   6 +-
 arch/x86/include/asm/pgtable.h                     |   4 +-
 arch/x86/mm/ioremap.c                              |   4 +-
 arch/x86/platform/efi/quirks.c                     |   3 +-
 block/bfq-iosched.c                                | 287 +++++++++++++--------
 block/bfq-iosched.h                                |  76 ++++--
 block/bfq-wf2q.c                                   |  56 ++--
 drivers/ata/libata-scsi.c                          |  15 +-
 drivers/block/xen-blkfront.c                       |  15 +-
 drivers/char/agp/parisc-agp.c                      |   6 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  21 +-
 drivers/dma/st_fdma.c                              |   2 +-
 drivers/firmware/scpi_pm_domain.c                  |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   2 +
 drivers/hid/hid-holtek-mouse.c                     |  15 ++
 drivers/hwmon/dell-smm-hwmon.c                     |   7 +-
 drivers/hwmon/lm90.c                               |   8 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   4 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c          |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   2 +-
 drivers/input/touchscreen/of_touchscreen.c         |  18 +-
 drivers/md/persistent-data/dm-btree-remove.c       |   2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.c            |  16 +-
 drivers/net/bonding/bond_options.c                 |   2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   5 +
 drivers/net/ethernet/broadcom/bcmsysport.h         |   1 +
 drivers/net/ethernet/intel/igb/igb_main.c          |  28 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   3 +
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   6 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h  |   2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |  12 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |   4 +-
 drivers/net/ethernet/sfc/falcon/rx.c               |   5 +-
 drivers/net/ethernet/smsc/smc911x.c                |   5 +
 drivers/net/fjes/fjes_main.c                       |   5 +
 drivers/net/hamradio/mkiss.c                       |   5 +-
 drivers/net/netdevsim/bpf.c                        |   1 +
 drivers/net/usb/lan78xx.c                          |  12 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |   4 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |   8 +-
 drivers/net/xen-netback/common.h                   |   1 +
 drivers/net/xen-netback/rx.c                       |  77 ++++--
 drivers/net/xen-netfront.c                         | 125 ++++++---
 drivers/pci/msi.c                                  |  15 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   8 +-
 drivers/scsi/scsi_debug.c                          |   4 +-
 drivers/soc/tegra/fuse/fuse-tegra.c                |   2 +-
 drivers/soc/tegra/fuse/fuse.h                      |   2 +-
 drivers/spi/spi-armada-3700.c                      |   2 +-
 drivers/tty/hvc/hvc_xen.c                          |  30 ++-
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/gadget/composite.c                     |   6 +-
 drivers/usb/gadget/function/u_ether.c              |  15 +-
 drivers/usb/gadget/legacy/dbgp.c                   |   6 +-
 drivers/usb/gadget/legacy/inode.c                  |   6 +-
 drivers/usb/serial/cp210x.c                        |   6 +-
 drivers/usb/serial/option.c                        |   8 +
 fs/f2fs/xattr.c                                    |   9 +-
 fs/fuse/dir.c                                      |   2 +-
 fs/nfsd/nfs4state.c                                |   9 +-
 fs/overlayfs/dir.c                                 |   3 +-
 fs/overlayfs/overlayfs.h                           |   1 +
 fs/overlayfs/super.c                               |  12 +-
 include/linux/virtio_net.h                         |  25 +-
 kernel/audit.c                                     |  21 +-
 kernel/time/timekeeping.c                          |   3 +-
 kernel/trace/tracing_map.c                         |   3 +
 lib/Kconfig.debug                                  |   6 +-
 localversion-rt                                    |   2 +-
 net/ax25/af_ax25.c                                 |   4 +-
 net/ipv6/sit.c                                     |   1 -
 net/mac80211/agg-tx.c                              |   2 +-
 net/mac80211/mlme.c                                |  13 +-
 net/mac80211/util.c                                |   2 +
 net/netfilter/nfnetlink_log.c                      |   3 +-
 net/netfilter/nfnetlink_queue.c                    |   3 +-
 net/netlink/af_netlink.c                           |   5 +
 net/nfc/netlink.c                                  |   6 +-
 net/packet/af_packet.c                             |   5 +-
 net/phonet/pep.c                                   |   2 +
 net/rds/connection.c                               |   1 +
 net/sched/sch_cake.c                               |   6 +-
 scripts/recordmcount.pl                            |   2 +-
 sound/core/jack.c                                  |   4 +
 sound/drivers/opl3/opl3_midi.c                     |   2 +-
 110 files changed, 1022 insertions(+), 617 deletions(-)
---
