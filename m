Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AE4E4233
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiCVOrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCVOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F56D6EC4B;
        Tue, 22 Mar 2022 07:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF71F616D4;
        Tue, 22 Mar 2022 14:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C562C340EC;
        Tue, 22 Mar 2022 14:46:03 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.29-rt37
Date:   Tue, 22 Mar 2022 14:45:12 -0000
Message-ID: <164796031252.447819.15314755309083801974@puck.lan>
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

I'm pleased to announce the 5.15.29-rt37 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 91d3be937da18f7e795be061a15aca1a7367fff9

Or to build 5.15.29-rt37 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.29.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.29-rt37.patch.xz


You can also build from 5.15.28-rt36 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.28-rt36-rt37.patch.xz

Enjoy!
Clark

Changes from v5.15.28-rt36:
---

Alex Deucher (1):
      PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken

Alexey Khoroshilov (1):
      mISDN: Fix memory leak in dsp_pipeline_build()

Andrei Vagin (1):
      KVM: x86/mmu: kvm_faultin_pfn has to return false if pfh is returned

Andy Shevchenko (2):
      gpiolib: acpi: Convert ACPI value of debounce to microseconds
      pinctrl: tigerlake: Revert "Add Alder Lake-M ACPI ID"

Aneesh Kumar K.V (1):
      selftest/vm: fix map_fixed_noreplace test failure

Anirudh Rayabharam (1):
      vhost: fix hung thread due to erroneous iotlb entries

Anton Romanov (1):
      kvm: x86: Disable KVM_HC_CLOCK_PAIRING if tsc is in always catchup mode

Bjorn Andersson (1):
      arm64: dts: qcom: sm8350: Correct UFS symbol clocks

Catalin Marinas (1):
      arm64: Ensure execute-only permissions are not allowed without EPAN

Christoph Hellwig (1):
      block: drop unused includes in <linux/genhd.h>

Christophe JAILLET (1):
      ice: Don't use GFP_KERNEL in atomic context

Clark Williams (2):
      Merge tag 'v5.15.29' into v5.15-rt
      Linux 5.15.29-rt37

Clément Léger (1):
      net: phy: DP83822: clear MISR2 register to disable interrupts

Dan Carpenter (1):
      staging: gdm724x: fix use after free in gdm_lte_rx()

Daniel Bristot de Oliveira (1):
      tracing/osnoise: Make osnoise_main to sleep for microseconds

Dave Ertman (1):
      ice: Fix error with handling of bonding MTU

David Howells (8):
      watch_queue: Fix filter limit check
      watch_queue, pipe: Free watchqueue state after clearing pipe ring
      watch_queue: Fix to release page in ->release()
      watch_queue: Fix to always request a pow-of-2 pipe ring size
      watch_queue: Fix the alloc bitmap size to reflect notes allocated
      watch_queue: Free the alloc bitmap when the watch_queue is torn down
      watch_queue: Fix lack of barrier/sync/lock between post and read
      watch_queue: Make comment about setting ->defunct more accurate

Dima Chumak (1):
      net/mlx5: Fix offloading with ESWITCH_IPV4_TTL_MODIFY_ENABLE

Dmitry Torokhov (1):
      HID: vivaldi: fix sysfs attributes leak

Duoming Zhou (1):
      ax25: Fix NULL pointer dereference in ax25_kill_by_device

Emil Renner Berthing (1):
      riscv: Fix auipc+jalr relocation range checks

Eric Dumazet (1):
      sctp: fix kernel-infoleak for SCTP sockets

Fabio Estevam (1):
      smsc95xx: Ignore -ENODEV errors when device is unplugged

Filipe Manana (1):
      btrfs: make send work with concurrent block group relocation

Greg Kroah-Hartman (1):
      Linux 5.15.29

Guchun Chen (1):
      drm/amdgpu: bypass tiling flag check in virtual display case (v2)

Guillaume Nault (2):
      selftests: pmtu.sh: Kill tcpdump processes launched by subshell.
      selftests: pmtu.sh: Kill nettest processes launched in subshell.

Halil Pasic (2):
      swiotlb: fix info leak with DMA_FROM_DEVICE
      swiotlb: rework "fix info leak with DMA_FROM_DEVICE"

Hans de Goede (1):
      staging: rtl8723bs: Fix access-point mode deadlock

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Raptor Lake-S

Heiner Kallweit (2):
      net: phy: meson-gxl: fix interrupt handling in forced mode
      net: phy: meson-gxl: improve link-up behavior

Jacob Keller (2):
      i40e: stop disabling VFs due to PF error responses
      ice: stop disabling VFs due to PF error responses

Jarkko Sakkinen (1):
      x86/sgx: Free backing memory after faulting the enclave page

Jason Wang (1):
      vhost: allow batching hint without size

Jedrzej Jagielski (1):
      ice: Fix curr_link_speed advertised speed

Jeremy Linton (1):
      net: bcmgenet: Don't claim WOL when its not available

Jernej Skrabec (1):
      drm/sun4i: mixer: Fix P010 and P210 format numbers

Jia-Ju Bai (2):
      isdn: hfcpci: check the return value of dma_set_mask() in setup_hw()
      net: qlogic: check the return value of dma_alloc_coherent() in qed_vf_hw_prepare()

Jiasheng Jiang (2):
      net: ethernet: ti: cpts: Handle error for clk_enable
      net: ethernet: lpc_eth: Handle error for clk_enable

Jiri Kosina (1):
      HID: elo: Revert USB reference counting

Jisheng Zhang (1):
      riscv: alternative only works on !XIP_KERNEL

Joel Stanley (1):
      ARM: dts: aspeed: Fix AST2600 quad spi group

Jon Lin (2):
      spi: rockchip: Fix error in getting num-cs property
      spi: rockchip: terminate dma transmission when slave abort

Konrad Dybcio (1):
      arm64: dts: qcom: sm8350: Describe GCC dependency clocks

Kumar Kartikeya Dwivedi (1):
      selftests/bpf: Add test for bpf_timer overwriting crash

Li Huafei (1):
      x86/traps: Mark do_int3() NOKPROBE_SYMBOL

Marek Marczykowski-Górecki (2):
      Revert "xen-netback: remove 'hotplug-status' once it has served its purpose"
      Revert "xen-netback: Check for hotplug-status existence before watching"

Mark Featherston (1):
      gpio: ts4900: Do not set DAT and OE together

Maxime Ripard (2):
      ARM: boot: dts: bcm2711: Fix HVS register range
      drm/vc4: hdmi: Unregister codec device on unbind

Miaoqian Lin (3):
      ethernet: Fix error handling in xemaclite_of_probe
      net: marvell: prestera: Add missing of_node_put() in prestera_switch_set_base_mac_addr
      gianfar: ethtool: Fix refcount leak in gfar_get_ts_info

Michael S. Tsirkin (2):
      virtio: unexport virtio_finalize_features
      virtio: acknowledge all features before access

Michal Maloszewski (1):
      iavf: Fix handling of vlan strip virtual channel messages

Mike Kravetz (1):
      selftests/memfd: clean up mapping in mfd_fail_write

Miklos Szeredi (2):
      fuse: fix fileattr op failure
      fuse: fix pipe buffer lifetime for direct_io

Mohammad Kabat (1):
      net/mlx5: Fix size field in bufferx_reg struct

Moshe Shemesh (1):
      net/mlx5: Fix a race on command flush flow

Nicolas Saenz Julienne (1):
      tracing/osnoise: Force quiescent states while tracing

Niels Dossche (1):
      ipv6: prevent a possible race condition with lifetimes

Niklas Cassel (1):
      riscv: dts: k210: fix broken IRQs on hart1

Pali Rohár (2):
      arm64: dts: armada-3720-turris-mox: Add missing ethernet0 alias
      arm64: dts: marvell: armada-37xx: Remap IO space to bus address 0x0

Paul Semel (1):
      arm64: kasan: fix include error in MTE functions

Pavel Skripkin (2):
      HID: hid-thrustmaster: fix OOB read in thrustmaster_interrupts
      NFC: port100: fix use-after-free in port100_send_complete

Randy Dunlap (1):
      ARM: Spectre-BHB: provide empty stub for non-config

Robert Hancock (1):
      net: macb: Fix lost RX packet wakeup race in NAPI receive

Roi Dayan (1):
      net/mlx5e: Lag, Only handle events from highest priority multipath entry

Rong Chen (1):
      mmc: meson: Fix usage of meson_mmc_post_req()

Ross Philipson (2):
      x86/boot: Fix memremap of setup_indirect structures
      x86/boot: Add setup_indirect support in early_memremap_is_setup_data()

Russell King (Oracle) (2):
      net: dsa: mt7530: fix incorrect test in mt753x_phylink_validate()
      ARM: fix Thumb2 regression with Spectre BHB

Shreeya Patel (1):
      gpio: Return EPROBE_DEFER if gc->to_irq is NULL

Si-Wei Liu (1):
      vdpa/mlx5: add validation for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command

Steffen Klassert (2):
      esp: Fix possible buffer overflow in ESP transformation
      esp: Fix BEET mode inter address family tunneling on GSO

Sven Schnelle (1):
      tracing: Ensure trace buffer is at least 4096 bytes large

Taniya Das (2):
      clk: qcom: gdsc: Add support to update GDSC transition delay
      clk: qcom: dispcc: Update the transition delay for MDSS GDSC

Thomas Zimmermann (1):
      drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP

Tom Rix (1):
      qed: return status of qed_iov_get_link

Tung Nguyen (2):
      tipc: fix kernel panic when enabling bearer
      tipc: fix incorrect order of state message data sanity check

Vikash Chandola (1):
      hwmon: (pmbus) Clear pmbus fault/warning bits after read

Ville Syrjälä (1):
      drm/i915: Workaround broken BIOS DBUF configuration on TGL/RKL

Vladimir Oltean (1):
      Revert "net: dsa: mv88e6xxx: flush switchdev FDB workqueue before removing VLAN"

Wanpeng Li (2):
      KVM: Fix lockdep false negative during host resume
      x86/kvm: Don't use pv tlb/ipi/sched_yield if on 1 vCPU

Xie Yongji (2):
      vduse: Fix returning wrong type in vduse_domain_alloc_iova()
      virtio-blk: Don't use MAX_DISCARD_SEGMENTS if max_discard_seg is zero

Zhang Min (1):
      vdpa: fix use-after-free on vp_vdpa_remove

suresh kumar (1):
      net-sysfs: add check for netdevice being present to speed_show
---
Makefile                                           |   2 +-
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi           |   2 +-
 arch/arm/boot/dts/bcm2711.dtsi                     |   1 +
 arch/arm/include/asm/spectre.h                     |   6 +
 arch/arm/kernel/entry-armv.S                       |   4 +-
 arch/arm64/Kconfig                                 |   3 -
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |   8 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  48 ++-
 arch/arm64/include/asm/mte-kasan.h                 |   1 +
 arch/arm64/include/asm/pgtable-prot.h              |   4 +-
 arch/arm64/include/asm/pgtable.h                   |  12 -
 arch/arm64/mm/mmap.c                               |  17 +
 arch/riscv/Kconfig.erratas                         |   1 +
 arch/riscv/Kconfig.socs                            |   4 +-
 arch/riscv/boot/dts/canaan/k210.dtsi               |   3 +-
 arch/riscv/kernel/module.c                         |  21 +-
 arch/um/drivers/ubd_kern.c                         |   1 +
 arch/x86/kernel/cpu/sgx/encl.c                     |  57 +++-
 arch/x86/kernel/e820.c                             |  41 ++-
 arch/x86/kernel/kdebugfs.c                         |  37 ++-
 arch/x86/kernel/ksysfs.c                           |  77 ++++-
 arch/x86/kernel/kvm.c                              |   9 +-
 arch/x86/kernel/setup.c                            |  34 +-
 arch/x86/kernel/traps.c                            |   1 +
 arch/x86/kvm/mmu/mmu.c                             |   1 +
 arch/x86/kvm/x86.c                                 |   7 +
 arch/x86/mm/ioremap.c                              |  57 +++-
 block/genhd.c                                      |   1 +
 block/holder.c                                     |   1 +
 block/partitions/core.c                            |   1 +
 drivers/block/amiflop.c                            |   1 +
 drivers/block/ataflop.c                            |   1 +
 drivers/block/floppy.c                             |   1 +
 drivers/block/swim.c                               |   1 +
 drivers/block/virtio_blk.c                         |  10 +-
 drivers/block/xen-blkfront.c                       |   1 +
 drivers/clk/qcom/dispcc-sc7180.c                   |   5 +-
 drivers/clk/qcom/dispcc-sc7280.c                   |   5 +-
 drivers/clk/qcom/dispcc-sm8250.c                   |   5 +-
 drivers/clk/qcom/gdsc.c                            |  26 +-
 drivers/clk/qcom/gdsc.h                            |   8 +-
 drivers/gpio/gpio-ts4900.c                         |  24 +-
 drivers/gpio/gpiolib-acpi.c                        |   6 +-
 drivers/gpio/gpiolib.c                             |  20 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |   2 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   5 +-
 drivers/gpu/drm/i915/display/intel_display.h       |   2 +
 drivers/gpu/drm/i915/intel_pm.c                    |  68 ++++
 drivers/gpu/drm/i915/intel_pm.h                    |   1 +
 drivers/gpu/drm/panel/Kconfig                      |   1 +
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |   8 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   8 +
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |   1 +
 drivers/hid/hid-elo.c                              |   7 +-
 drivers/hid/hid-thrustmaster.c                     |   6 +
 drivers/hid/hid-vivaldi.c                          |   2 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |   5 +
 drivers/isdn/hardware/mISDN/hfcpci.c               |   6 +-
 drivers/isdn/mISDN/dsp_pipeline.c                  |   6 +-
 drivers/md/md.c                                    |   1 +
 drivers/mmc/host/meson-gx-mmc.c                    |  15 +-
 drivers/net/dsa/mt7530.c                           |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   7 -
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |   7 +
 drivers/net/ethernet/cadence/macb_main.c           |  25 +-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |   1 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  57 +---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   5 -
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  40 +++
 drivers/net/ethernet/intel/ice/ice.h               |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  31 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c   |  18 --
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h   |   3 -
 .../net/ethernet/marvell/prestera/prestera_main.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag_mp.c   |  11 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |   3 -
 drivers/net/ethernet/nxp/lpc_eth.c                 |   5 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |  18 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |   7 +
 drivers/net/ethernet/ti/cpts.c                     |   4 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |   4 +-
 drivers/net/phy/dp83822.c                          |   2 +-
 drivers/net/phy/meson-gxl.c                        |  31 +-
 drivers/net/usb/smsc95xx.c                         |  28 +-
 drivers/net/xen-netback/xenbus.c                   |  14 +-
 drivers/nfc/port100.c                              |   2 +
 drivers/pci/quirks.c                               |  14 +-
 drivers/pinctrl/intel/pinctrl-tigerlake.c          |   1 -
 drivers/s390/block/dasd_genhd.c                    |   1 +
 drivers/scsi/sd.c                                  |   1 +
 drivers/scsi/sg.c                                  |   1 +
 drivers/scsi/sr.c                                  |   1 +
 drivers/scsi/st.c                                  |   1 +
 drivers/spi/spi-rockchip.c                         |  13 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   5 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   7 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |  10 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |  22 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |  16 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |   2 +
 drivers/usb/dwc3/dwc3-pci.c                        |   4 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |  16 +
 drivers/vdpa/vdpa_user/iova_domain.c               |   2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c                  |   2 +-
 drivers/vhost/iotlb.c                              |  11 +
 drivers/vhost/vhost.c                              |   7 +
 drivers/virtio/virtio.c                            |  40 +--
 fs/btrfs/block-group.c                             |   9 +-
 fs/btrfs/ctree.c                                   |  98 ++++--
 fs/btrfs/ctree.h                                   |  14 +-
 fs/btrfs/disk-io.c                                 |   4 +-
 fs/btrfs/relocation.c                              |  13 -
 fs/btrfs/send.c                                    | 357 ++++++++++++++++++---
 fs/btrfs/transaction.c                             |   4 +
 fs/fuse/dev.c                                      |  12 +-
 fs/fuse/file.c                                     |   1 +
 fs/fuse/fuse_i.h                                   |   1 +
 fs/fuse/ioctl.c                                    |   9 +-
 fs/pipe.c                                          |  11 +-
 include/linux/genhd.h                              |  14 +-
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 include/linux/part_stat.h                          |   1 +
 include/linux/virtio.h                             |   1 -
 include/linux/virtio_config.h                      |   3 +-
 include/linux/watch_queue.h                        |   3 +-
 include/net/dsa.h                                  |   1 -
 include/net/esp.h                                  |   2 +
 kernel/dma/swiotlb.c                               |  22 +-
 kernel/trace/trace.c                               |  10 +-
 kernel/trace/trace_osnoise.c                       |  73 +++--
 kernel/watch_queue.c                               |  15 +-
 localversion-rt                                    |   2 +-
 net/ax25/af_ax25.c                                 |   7 +
 net/core/net-sysfs.c                               |   2 +-
 net/dsa/dsa.c                                      |   1 -
 net/dsa/dsa_priv.h                                 |   1 +
 net/ipv4/esp4.c                                    |   5 +
 net/ipv4/esp4_offload.c                            |   3 +
 net/ipv6/addrconf.c                                |   2 +
 net/ipv6/esp6.c                                    |   5 +
 net/ipv6/esp6_offload.c                            |   3 +
 net/sctp/diag.c                                    |   9 +-
 net/tipc/bearer.c                                  |  12 +-
 net/tipc/link.c                                    |   9 +-
 .../testing/selftests/bpf/prog_tests/timer_crash.c |  32 ++
 tools/testing/selftests/bpf/progs/timer_crash.c    |  54 ++++
 tools/testing/selftests/memfd/memfd_test.c         |   1 +
 tools/testing/selftests/net/pmtu.sh                |  21 +-
 tools/testing/selftests/vm/map_fixed_noreplace.c   |  49 ++-
 virt/kvm/kvm_main.c                                |   4 +-
 154 files changed, 1596 insertions(+), 557 deletions(-)
---
