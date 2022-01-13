Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0D48D10C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiAMDp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiAMDpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:45:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA68C061748;
        Wed, 12 Jan 2022 19:45:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D2E5B821BF;
        Thu, 13 Jan 2022 03:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AF1C36AEA;
        Thu, 13 Jan 2022 03:45:47 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.225-rt101
Date:   Thu, 13 Jan 2022 03:45:12 -0000
Message-ID: <164204551290.1795235.14392385656999546066@puck.lan>
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

I'm pleased to announce the 4.19.225-rt101 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 4cb25e562978b1cbf4e129d72816728a0bf405dd

Or to build 4.19.225-rt101 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.225.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.225-rt101.patch.xz


You can also build from 4.19.223-rt100 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.223-rt100-rt101.patch.xz

Enjoy!
Clark

Changes from v4.19.223-rt100:
---

Alexey Makhalov (1):
      scsi: vmw_pvscsi: Set residual data length conditionally

Chunfeng Yun (2):
      usb: mtu3: set interval of FS intr and isoc endpoint
      usb: mtu3: fix interval value for intr and isoc

Clark Williams (2):
      Merge tag 'v4.19.225' into v4.19-rt
      Linux 4.19.225-rt101

Coco Li (2):
      udp: using datalen to cap ipv6 udp max gso segments
      selftests: Calculate udpgso segment count without header adjustment

Dan Carpenter (1):
      scsi: lpfc: Terminate string in lpfc_debugfs_nvmeio_trc_write()

Darrick J. Wong (1):
      xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP just like fallocate

David Ahern (4):
      ipv6: Check attribute length for RTA_GATEWAY in multipath route
      ipv6: Check attribute length for RTA_GATEWAY when deleting multipath route
      ipv6: Continue processing multipath route even if gateway attribute is invalid
      ipv6: Do cleanup if attribute validation fails in multipath route

Di Zhu (1):
      i40e: fix use-after-free in i40e_sync_filters_subtask()

Dmitry V. Levin (1):
      uapi: fix linux/nfc.h userspace compilation errors

Eric Dumazet (1):
      sch_qfq: prevent shift-out-of-bounds in qfq_init_qdisc

Gal Pressman (1):
      net/mlx5e: Fix wrong features assignment in case of error

Greg Kroah-Hartman (2):
      Linux 4.19.224
      Linux 4.19.225

Hangyu Hua (1):
      phonet: refcount leak in pep_sock_accep

Hans de Goede (1):
      HID: asus: Add depends on USB_HID to HID_ASUS Kconfig option

Heiko Carstens (1):
      recordmcount.pl: fix typo in s390 mcount regex

Jedrzej Jagielski (1):
      i40e: Fix incorrect netdev's real number of RX/TX queues

Jens Wiklander (1):
      tee: handle lookup of shm with reference count 0

Krzysztof Kozlowski (1):
      nfc: uapi: use kernel size_t to fix user-space builds

Leo L. Schwab (1):
      Input: spaceball - fix parsing of movement data packets

Leon Romanovsky (1):
      RDMA/core: Don't infoleak GRH fields

Lixiaokeng (1):
      scsi: libiscsi: Fix UAF in iscsi_conn_get_param()/iscsi_conn_teardown()

Mathias Nyman (1):
      xhci: Fresco FL1100 controller should not have BROKEN_MSI quirk set.

Matthias-Christian Ott (1):
      net: usb: pegasus: Do not drop long Ethernet frames

Miaoqian Lin (1):
      fsl/fman: Fix missing put_device() call in fman_port_probe

Muchun Song (1):
      net: fix use-after-free in tw_timer_handler

Nathan Chancellor (1):
      power: reset: ltc2952: Fix use of floating point literals

Naveen N. Rao (2):
      tracing: Fix check for trace_percpu_buffer validity in get_trace_buf()
      tracing: Tag trace_percpu_buffer as a percpu pointer

Pavel Skripkin (3):
      i2c: validate user data in compat ioctl
      Input: appletouch - initialize work before device registration
      ieee802154: atusb: fix uninit value in atusb_set_extended_addr

Samuel Čavoj (1):
      Input: i8042 - enable deferred probe quirk for ASUS UM325UA

Takashi Iwai (1):
      Input: i8042 - add deferred probe support

Thomas Toye (1):
      rndis_host: support Hytera digital radios

Todd Kjos (1):
      binder: fix async_free_space accounting for empty parcels

Tom Rix (2):
      selinux: initialize proto variable in selinux_ip_postroute_compat()
      mac80211: initialize variable have_higher_than_11mbit

Vincent Pelletier (1):
      usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear.

Wang Qing (1):
      platform/x86: apple-gmux: use resource_size() with res

Wei Yongjun (1):
      NFC: st21nfca: Fix memory leak in device probe and remove

William Zhao (1):
      ip6_vti: initialize __ip6_tnl_parm struct in vti6_siocdevprivate

Xin Long (1):
      sctp: use call_rcu to free endpoint

wolfgang huang (1):
      mISDN: change function names to avoid conflicts

wujianguo (1):
      selftests/net: udpgso_bench_tx: fix dst ip argument

yangxingwu (1):
      net: udp: fix alignment problem in udp4_seq_show()
---
Documentation/admin-guide/kernel-parameters.txt   |   2 +
 Makefile                                          |   2 +-
 drivers/android/binder_alloc.c                    |   2 +-
 drivers/hid/Kconfig                               |   1 +
 drivers/i2c/i2c-dev.c                             |   3 +
 drivers/infiniband/core/uverbs_marshall.c         |   2 +-
 drivers/input/joystick/spaceball.c                |  11 +-
 drivers/input/mouse/appletouch.c                  |   4 +-
 drivers/input/serio/i8042-x86ia64io.h             |  21 +++
 drivers/input/serio/i8042.c                       |  54 ++++---
 drivers/isdn/mISDN/core.c                         |   6 +-
 drivers/isdn/mISDN/core.h                         |   4 +-
 drivers/isdn/mISDN/layer1.c                       |   4 +-
 drivers/net/ethernet/freescale/fman/fman_port.c   |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  56 ++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  11 +-
 drivers/net/ieee802154/atusb.c                    |  10 +-
 drivers/net/usb/pegasus.c                         |   4 +-
 drivers/net/usb/rndis_host.c                      |   5 +
 drivers/nfc/st21nfca/i2c.c                        |  29 ++--
 drivers/platform/x86/apple-gmux.c                 |   2 +-
 drivers/power/reset/ltc2952-poweroff.c            |   4 +-
 drivers/scsi/libiscsi.c                           |   6 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                  |   4 +-
 drivers/scsi/vmw_pvscsi.c                         |   7 +-
 drivers/tee/tee_shm.c                             | 177 ++++++++--------------
 drivers/usb/gadget/function/f_fs.c                |   9 +-
 drivers/usb/host/xhci-pci.c                       |   5 +-
 drivers/usb/mtu3/mtu3_gadget.c                    |  11 +-
 fs/xfs/xfs_ioctl.c                                |   3 +-
 include/linux/tee_drv.h                           |   4 +-
 include/net/sctp/sctp.h                           |   6 +-
 include/net/sctp/structs.h                        |   3 +-
 include/uapi/linux/nfc.h                          |   6 +-
 kernel/trace/trace.c                              |   6 +-
 localversion-rt                                   |   2 +-
 net/ipv4/af_inet.c                                |  10 +-
 net/ipv4/udp.c                                    |   2 +-
 net/ipv6/ip6_vti.c                                |   2 +
 net/ipv6/route.c                                  |  28 +++-
 net/ipv6/udp.c                                    |   2 +-
 net/mac80211/mlme.c                               |   2 +-
 net/phonet/pep.c                                  |   1 +
 net/sched/sch_qfq.c                               |   6 +-
 net/sctp/diag.c                                   |  12 +-
 net/sctp/endpointola.c                            |  23 ++-
 net/sctp/socket.c                                 |  23 ++-
 scripts/recordmcount.pl                           |   2 +-
 security/selinux/hooks.c                          |   2 +-
 tools/testing/selftests/net/udpgso.c              |  12 +-
 tools/testing/selftests/net/udpgso_bench_tx.c     |   8 +-
 51 files changed, 382 insertions(+), 251 deletions(-)
---
