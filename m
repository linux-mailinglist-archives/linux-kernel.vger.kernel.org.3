Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5954E7BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiCYWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiCYWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3219897B;
        Fri, 25 Mar 2022 15:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C2461425;
        Fri, 25 Mar 2022 22:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4216AC340F0;
        Fri, 25 Mar 2022 22:19:58 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.31-rt38
Date:   Fri, 25 Mar 2022 22:19:01 -0000
Message-ID: <164824674160.618312.17652860693196499470@puck.lan>
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
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.31-rt38 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 4a5bf82a954ec1e8dbfcaa20f6e60263bfdda64b

Or to build 5.15.31-rt38 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.31.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.31-rt38.patch.xz


Enjoy!
Clark

Changes from v5.15.29-rt37:
---

Alan Stern (2):
      usb: gadget: Fix use-after-free bug by not setting udc->dev.driver
      usb: usbtmc: Fix bug in pipe direction for control transfers

Alexander Lobakin (1):
      MIPS: smp: fill in sibling and core maps earlier

Arnd Bergmann (1):
      arm64: fix clang warning about TRAMP_VALIAS

Brian Masney (1):
      crypto: qcom-rng - ensure buffer for generate is completely filled

Chengming Zhou (1):
      kselftest/vm: fix tests build with old libc

Christoph Niedermaier (1):
      drm/imx: parallel-display: Remove bus flags check in imx_pd_bridge_atomic_check()

Christophe JAILLET (1):
      bnx2: Fix an error message

Clark Williams (3):
      Merge tag 'v5.15.30' into v5.15-rt
      Merge tag 'v5.15.31' into v5.15-rt
      Linux 5.15.31-rt38

Corentin Labbe (1):
      ARM: dts: rockchip: fix a typo on rk3288 crypto-controller

Dan Carpenter (1):
      usb: gadget: rndis: prevent integer overflow in rndis_set_response()

Dinh Nguyen (1):
      arm64: dts: agilex: use the compatible "intel,socfpga-agilex-hsotg"

Doug Berger (1):
      net: bcmgenet: skip invalid partial checksums

Eric Dumazet (2):
      tcp: make tcp_read_sock() more robust
      net/packet: fix slab-out-of-bounds access in packet_recvmsg()

Filipe Manana (1):
      btrfs: skip reserved bytes warning on unmount after log cleanup failure

Golan Ben Ami (1):
      iwlwifi: don't advertise TWT support

Greg Kroah-Hartman (2):
      Linux 5.15.30
      Linux 5.15.31

Guo Ziliang (1):
      mm: swap: get rid of livelock in swapin readahead

Ivan Vecera (2):
      ice: Fix race condition during interface enslave
      iavf: Fix hang during reboot/shutdown

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: fix rk3399-puma eMMC HS400 signal integrity

Jia-Ju Bai (1):
      atm: firestream: check the return value of ioremap() in fs_init()

Jiasheng Jiang (2):
      atm: eni: Add check for dma_map_single
      hv_netvsc: Add check for kvmalloc_array

Jiyong Park (1):
      vsock: each transport cycles only on its own sockets

Jocelyn Falempe (1):
      drm/mgag200: Fix PLL setup for g200wb and g200ew

Johannes Berg (1):
      mac80211: refuse aggregations sessions before authorized

Joseph Qi (1):
      ocfs2: fix crash when initialize filecheck kobj fails

Juerg Haefliger (1):
      net: phy: mscc: Add MODULE_FIRMWARE macros

Julian Braha (1):
      ARM: 9178/1: fix unmet dependency on BITREVERSE for HAVE_ARCH_BITREVERSE

Kai Lueke (1):
      Revert "xfrm: state and policy should fail if XFRMA_IF_ID 0"

Krzysztof Kozlowski (1):
      arm64: dts: rockchip: align pl330 node name with dtschema

Kurt Cancemi (1):
      net: phy: marvell: Fix invalid comparison in the resume and suspend functions

Lad Prabhakar (1):
      can: rcar_canfd: rcar_canfd_channel_probe(): register the CAN device when fully ready

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix leaking sent_cmd skb

Manasi Navare (1):
      drm/vrr: Set VRR capable prop only if it is attached to connector

Manish Chopra (1):
      bnx2x: fix built-in kernel driver load failure

Marek Vasut (1):
      drm/panel: simple: Fix Innolux G070Y2-L01 BPP settings

Matt Lupfer (1):
      scsi: mpt3sas: Page fault in reply q processing

Miaoqian Lin (1):
      net: dsa: Add missing of_node_put() in dsa_port_parse_of

Michael Petlan (1):
      perf symbols: Fix symbol size calculation condition

Ming Lei (1):
      block: release rq qos structures for queue without disk

Nicolas Dichtel (1):
      net: handle ARPHRD_PIMREG in dev_is_mac_header_xmit()

Niels Dossche (2):
      sfc: extend the locking on mcdi->seqno
      alx: acquire mutex for alx_reinit in alx_change_mtu

Pavel Skripkin (1):
      Input: aiptek - properly check endpoint type

Peter Zijlstra (1):
      x86/module: Fix the paravirt vs alternative order

Przemyslaw Patynowski (1):
      iavf: Fix double free in iavf_reset_task

Quentin Schulz (1):
      arm64: dts: rockchip: fix rk3399-puma-haikou USB OTG mode

Randy Dunlap (1):
      efi: fix return value of __setup handlers

Sabrina Dubroca (1):
      esp6: fix check on ipv6_skip_exthdr's return value

Sascha Hauer (2):
      arm64: dts: rockchip: reorder rk3399 hdmi clocks
      ARM: dts: rockchip: reorder rk322x hmdi clocks

Sreeramya Soratkal (1):
      nl80211: Update bss channel on channel switch for P2P_CLIENT

Thomas Zimmermann (1):
      drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS

Vladimir Oltean (1):
      net: mscc: ocelot: fix backwards compatibility with single-chain tc-flower offload

Yan Yan (2):
      xfrm: Check if_id in xfrm_migrate
      xfrm: Fix xfrm migrate issues when address family changes
---
Makefile                                           |  2 +-
 arch/arm/boot/dts/rk322x.dtsi                      |  4 ++--
 arch/arm/boot/dts/rk3288.dtsi                      |  2 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |  4 ++--
 arch/arm64/boot/dts/rockchip/px30.dtsi             |  2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  2 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 20 ++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  6 ++---
 arch/arm64/include/asm/vectors.h                   |  4 ++--
 arch/mips/kernel/smp.c                             |  6 ++---
 arch/x86/kernel/module.c                           | 13 ++++++----
 block/blk-core.c                                   |  4 ++++
 drivers/atm/eni.c                                  |  2 ++
 drivers/atm/firestream.c                           |  2 ++
 drivers/crypto/qcom-rng.c                          | 17 +++++++------
 drivers/firmware/efi/apple-properties.c            |  2 +-
 drivers/firmware/efi/efi.c                         |  2 +-
 drivers/gpu/drm/bridge/Kconfig                     |  2 +-
 drivers/gpu/drm/drm_connector.c                    |  3 +++
 drivers/gpu/drm/imx/parallel-display.c             |  8 -------
 drivers/gpu/drm/mgag200/mgag200_pll.c              |  6 ++---
 drivers/gpu/drm/panel/Kconfig                      |  1 +
 drivers/gpu/drm/panel/panel-simple.c               |  2 +-
 drivers/input/tablet/aiptek.c                      | 10 ++++----
 drivers/net/can/rcar/rcar_canfd.c                  |  6 ++---
 drivers/net/ethernet/atheros/alx/main.c            |  5 +++-
 drivers/net/ethernet/broadcom/bnx2.c               |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  2 --
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    | 28 +++++++++++++---------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 15 ++----------
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  6 +++--
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 15 +++++++++++-
 drivers/net/ethernet/intel/ice/ice.h               | 11 ++++++++-
 drivers/net/ethernet/intel/ice/ice_main.c          | 12 +++++++++-
 drivers/net/ethernet/mscc/ocelot_flower.c          | 16 ++++++++++++-
 drivers/net/ethernet/sfc/mcdi.c                    |  2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  3 +++
 drivers/net/phy/marvell.c                          |  8 +++----
 drivers/net/phy/mscc/mscc_main.c                   |  3 +++
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  1 -
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  5 ++--
 drivers/usb/class/usbtmc.c                         | 13 +++++++---
 drivers/usb/gadget/function/rndis.c                |  1 +
 drivers/usb/gadget/udc/core.c                      |  3 ---
 drivers/vhost/vsock.c                              |  3 ++-
 fs/btrfs/block-group.c                             | 26 ++++++++++++++++++--
 fs/btrfs/ctree.h                                   |  7 ++++++
 fs/btrfs/tree-log.c                                | 23 ++++++++++++++++++
 fs/ocfs2/super.c                                   | 22 ++++++++---------
 include/linux/if_arp.h                             |  1 +
 include/net/af_vsock.h                             |  3 ++-
 include/net/xfrm.h                                 |  5 ++--
 lib/Kconfig                                        |  1 -
 localversion-rt                                    |  2 +-
 mm/swap_state.c                                    |  2 +-
 net/bluetooth/hci_core.c                           |  1 +
 net/dsa/dsa2.c                                     |  1 +
 net/ipv4/tcp.c                                     | 10 ++++----
 net/ipv6/esp6.c                                    |  3 +--
 net/key/af_key.c                                   |  2 +-
 net/mac80211/agg-tx.c                              | 10 +++++++-
 net/packet/af_packet.c                             | 11 ++++++++-
 net/vmw_vsock/af_vsock.c                           |  9 +++++--
 net/vmw_vsock/virtio_transport.c                   |  7 ++++--
 net/vmw_vsock/vmci_transport.c                     |  5 +++-
 net/wireless/nl80211.c                             |  3 ++-
 net/xfrm/xfrm_policy.c                             | 14 ++++++-----
 net/xfrm/xfrm_state.c                              | 15 ++++++++----
 net/xfrm/xfrm_user.c                               | 27 +++++++--------------
 tools/perf/util/symbol.c                           |  2 +-
 tools/testing/selftests/vm/userfaultfd.c           |  1 +
 73 files changed, 336 insertions(+), 167 deletions(-)
---
