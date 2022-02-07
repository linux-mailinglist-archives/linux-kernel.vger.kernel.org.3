Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD24AC361
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354816AbiBGP3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442422AbiBGPQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:16:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C52C0401C1;
        Mon,  7 Feb 2022 07:16:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC869CE111C;
        Mon,  7 Feb 2022 15:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AE0C004E1;
        Mon,  7 Feb 2022 15:16:47 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.21-rt30
Date:   Mon, 07 Feb 2022 15:15:48 -0000
Message-ID: <164424694842.617748.13169079401287172941@puck.lan>
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

I'm pleased to announce the 5.15.21-rt30 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: d6b72436d0aa760a7c15f12baa9dfaddc10e9014

Or to build 5.15.21-rt30 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.21.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.21-rt30.patch.xz


You can also build from 5.15.19-rt29 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.19-rt29-rt30.patch.xz

Enjoy!
Clark

Changes from v5.15.19-rt29:
---

Alex Elder (2):
      net: ipa: use a bitmap for endpoint replenish_enabled
      net: ipa: prevent concurrent replenish

Christoph Fritz (1):
      ovl: fix NULL pointer dereference in copy up warning

Clark Williams (2):
      Merge tag 'v5.15.21' into v5.15-rt
      Linux 5.15.21-rt30

Dan Carpenter (1):
      fanotify: Fix stale file descriptor in copy_event_to_user()

Dima Chumak (1):
      net/mlx5: Fix offloading with ESWITCH_IPV4_TTL_MODIFY_ENABLE

Eric Dumazet (4):
      net: sched: fix use-after-free in tc_new_tfilter()
      rtnetlink: make sure to refresh master_dev/m_ops in __rtnl_newlink()
      af_packet: fix data-race in packet_setsockopt / packet_setsockopt
      tcp: add missing tcp_skb_can_collapse() test in tcp_shift_skb_data()

Eric W. Biederman (1):
      cgroup-v1: Require capabilities to set release_agent

Gal Pressman (1):
      net/mlx5e: Fix module EEPROM query

Georgi Valkov (1):
      ipheth: fix EOVERFLOW in ipheth_rcvbulk_callback

Greg Kroah-Hartman (4):
      Linux 5.15.20
      Revert "drm/vc4: hdmi: Make sure the device is powered with CEC"
      Revert "drm/vc4: hdmi: Make sure the device is powered with CEC" again
      Linux 5.15.21

J. Bruce Fields (2):
      lockd: fix server crash on reboot of client holding lock
      lockd: fix failure to cleanup client locks

Jedrzej Jagielski (1):
      i40e: Fix reset bw limit when DCB enabled with 1 TC

John Hubbard (1):
      Revert "mm/gup: small refactoring: simplify try_grab_page()"

Karen Sornek (1):
      i40e: Fix reset path while removing the driver

Lukas Wunner (1):
      PCI: pciehp: Fix infinite loop in IRQ handler upon power fault

Maher Sanalla (1):
      net/mlx5: Use del_timer_sync in fw reset flow of halting poll

Maor Dickman (2):
      net/mlx5e: Fix handling of wrong devices during bond netevent
      net/mlx5: E-Switch, Fix uninitialized variable modact

Maxim Mikityanskiy (1):
      net/mlx5e: Don't treat small ceil values as unlimited in HTB offload

Maxime Ripard (1):
      drm/vc4: hdmi: Make sure the device is powered with CEC

Miklos Szeredi (1):
      ovl: don't fail copy up if no fileattr support on upper

Paolo Abeni (1):
      selftests: mptcp: fix ipv6 routing setup

Raed Salem (1):
      net/mlx5e: IPsec: Fix tunnel mode crypto offload for non TCP/UDP traffic

Raju Rangoju (1):
      net: amd-xgbe: ensure to reset the tx_timer_active flag

Roi Dayan (1):
      net/mlx5: Bridge, Fix devlink deadlock on net namespace deletion

Sasha Neftin (1):
      e1000e: Handshake with CSME starts from ADL platforms

Shyam Sundar S K (1):
      net: amd-xgbe: Fix skb data length underflow

Tianchen Ding (1):
      cpuset: Fix the bug that subpart_cpus updated wrongly in update_cpumask()

Vlad Buslov (2):
      net/mlx5: Bridge, take rtnl lock in init error handler
      net/mlx5: Bridge, ensure dev_name is null-terminated
---
Makefile                                           |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 10 +------
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           | 14 ++++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e.h             |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 31 +++++++++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/rep/bond.c  | 32 +++++++++-----------
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |  6 ++--
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       | 13 ++++++--
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |  4 +++
 .../mlx5/core/esw/diag/bridge_tracepoint.h         |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |  9 +++---
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  9 +++---
 drivers/net/ipa/ipa_endpoint.c                     | 21 ++++++++++---
 drivers/net/ipa/ipa_endpoint.h                     | 17 +++++++++--
 drivers/net/usb/ipheth.c                           |  6 ++--
 drivers/pci/hotplug/pciehp_hpc.c                   |  7 +++--
 fs/lockd/svcsubs.c                                 | 18 ++++++-----
 fs/notify/fanotify/fanotify_user.c                 |  6 ++--
 fs/overlayfs/copy_up.c                             | 16 ++++++++--
 kernel/cgroup/cgroup-v1.c                          | 14 +++++++++
 kernel/cgroup/cpuset.c                             |  3 +-
 localversion-rt                                    |  2 +-
 mm/gup.c                                           | 35 ++++++++++++++++++----
 net/core/rtnetlink.c                               |  6 ++--
 net/ipv4/tcp_input.c                               |  2 ++
 net/packet/af_packet.c                             |  8 +++--
 net/sched/cls_api.c                                | 11 ++++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  5 ++--
 31 files changed, 229 insertions(+), 92 deletions(-)
---
