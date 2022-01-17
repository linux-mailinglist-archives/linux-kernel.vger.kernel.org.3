Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308E24903F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbiAQIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:36:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiAQIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:36:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8461212C5;
        Mon, 17 Jan 2022 08:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642408593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FtJCCBAxuUDcCgRSleoZ8EPFKlcAqokZy9jGQB7KBnc=;
        b=m1LNh5jWynGL8i+ScVMHxF8LXqHUeE+gErwV7yJM+mEcuC8mesgILgsnEKyHtmRICAWafV
        AKa7UbVi8msWvbEJYAmXtr3CzSA1TaBfkBfGpz8cSMC8//Tuqon7VMs2Qz6n+FWUyHTIMy
        QO69UN6ea7Sy13yzXsUWgi7Q6T9DUN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642408593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FtJCCBAxuUDcCgRSleoZ8EPFKlcAqokZy9jGQB7KBnc=;
        b=ATpt3KtIjb49oghhvDP5Q4vF10huv79m3VbAyUzGpvrqO44PYylbqz5QcLBRV/4Ea16jru
        ibKc9JIQEHANJIBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D679A134DA;
        Mon, 17 Jan 2022 08:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qy9UNJEq5WFUHgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 17 Jan 2022 08:36:33 +0000
Date:   Mon, 17 Jan 2022 09:36:33 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.4.299-rt230
Message-ID: <164232885429.16727.14256146043064078052@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.299-rt230 stable release.

This is just an update to the latest stable release. No RT specific
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 6c3d1a0e6e3f5eec61f856fa284426dc880f7bd5

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

Enjoy!
Daniel

Changes from v4.4.296-rt229:
---

Alexey Makhalov (1):
      scsi: vmw_pvscsi: Set residual data length conditionally

Ard Biesheuvel (1):
      ARM: 9169/1: entry: fix Thumb2 bug in iWMMXt exception handling

Benjamin Tissoires (1):
      HID: holtek: fix mouse probing

Colin Ian King (1):
      ALSA: drivers: opl3: Fix incorrect use of vp->state

Daniel Borkmann (1):
      bpf, test: fix ld_abs + vlan push/pop stress test

Daniel Wagner (2):
      Merge tag 'v4.4.299' into v4.4-rt
      Linux 4.4.299-rt230

Darrick J. Wong (1):
      xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP just like fallocate

Dmitry V. Levin (1):
      uapi: fix linux/nfc.h userspace compilation errors

Eric Dumazet (1):
      sch_qfq: prevent shift-out-of-bounds in qfq_init_qdisc

Fernando Fernandez Mancera (1):
      bonding: fix ad_actor_system option setting to default

Greg Jesionowski (1):
      net: usb: lan78xx: add Allied Telesis AT29M2-AF

Greg Kroah-Hartman (3):
      Linux 4.4.297
      Linux 4.4.298
      Linux 4.4.299

Guenter Roeck (1):
      hwmon: (lm90) Fix usage of CONFIG2 register in detect function

Hangyu Hua (1):
      phonet: refcount leak in pep_sock_accep

Heiko Carstens (1):
      recordmcount.pl: fix typo in s390 mcount regex

Jedrzej Jagielski (1):
      i40e: Fix incorrect netdev's real number of RX/TX queues

Jiasheng Jiang (2):
      qlcnic: potential dereference null pointer of rx_queue->page_ring
      drivers: net: smc911x: Check for error irq

Jimmy Assarsson (1):
      can: kvaser_usb: get CAN clock frequency from device

José Expósito (1):
      IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()

Juergen Gross (1):
      xen/blkfront: fix bug in backported patch

Krzysztof Kozlowski (1):
      nfc: uapi: use kernel size_t to fix user-space builds

Leo L. Schwab (1):
      Input: spaceball - fix parsing of movement data packets

Lin Ma (3):
      ax25: NPD bug when detaching AX25 device
      hamradio: defer ax25 kfree after unregister_netdev
      hamradio: improve the incomplete fix to avoid NPD

Lixiaokeng (1):
      scsi: libiscsi: Fix UAF in iscsi_conn_get_param()/iscsi_conn_teardown()

Mathias Nyman (1):
      xhci: Fresco FL1100 controller should not have BROKEN_MSI quirk set.

Muchun Song (1):
      net: fix use-after-free in tw_timer_handler

Nathan Chancellor (1):
      power: reset: ltc2952: Fix use of floating point literals

Pavel Skripkin (2):
      Input: appletouch - initialize work before device registration
      ieee802154: atusb: fix uninit value in atusb_set_extended_addr

Rémi Denis-Courmont (1):
      phonet/pep: refuse to enable an unbound pipe

Takashi Iwai (1):
      Bluetooth: btusb: Apply QCA Rome patches for some ATH3012 models

Thomas Toye (1):
      rndis_host: support Hytera digital radios

Tom Rix (2):
      selinux: initialize proto variable in selinux_ip_postroute_compat()
      mac80211: initialize variable have_higher_than_11mbit

Vincent Pelletier (1):
      usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear.

Wang Qing (1):
      platform/x86: apple-gmux: use resource_size() with res

William Zhao (1):
      ip6_vti: initialize __ip6_tnl_parm struct in vti6_siocdevprivate

Xiaoke Wang (1):
      ALSA: jack: Check the return value of kstrdup()

wolfgang huang (1):
      mISDN: change function names to avoid conflicts

yangxingwu (1):
      net: udp: fix alignment problem in udp4_seq_show()
---
Documentation/networking/bonding.txt               | 11 +++---
 Makefile                                           |  2 +-
 arch/arm/kernel/entry-armv.S                       |  8 ++---
 drivers/block/xen-blkfront.c                       |  4 ---
 drivers/bluetooth/btusb.c                          | 32 +++++++++++++----
 drivers/hid/hid-holtek-mouse.c                     | 15 ++++++++
 drivers/hwmon/lm90.c                               |  5 ++-
 drivers/infiniband/hw/qib/qib_user_sdma.c          |  2 +-
 drivers/input/joystick/spaceball.c                 | 11 ++++--
 drivers/input/mouse/appletouch.c                   |  4 +--
 drivers/isdn/mISDN/core.c                          |  6 ++--
 drivers/isdn/mISDN/core.h                          |  4 +--
 drivers/isdn/mISDN/layer1.c                        |  4 +--
 drivers/net/bonding/bond_options.c                 |  2 +-
 drivers/net/can/usb/kvaser_usb.c                   | 41 +++++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 32 +++++++++++++----
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov.h  |  2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   | 12 +++++--
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |  4 ++-
 drivers/net/ethernet/smsc/smc911x.c                |  5 +++
 drivers/net/hamradio/mkiss.c                       |  5 +--
 drivers/net/ieee802154/atusb.c                     | 10 +++---
 drivers/net/usb/lan78xx.c                          |  6 ++++
 drivers/net/usb/rndis_host.c                       |  5 +++
 drivers/platform/x86/apple-gmux.c                  |  2 +-
 drivers/power/reset/ltc2952-poweroff.c             |  4 +--
 drivers/scsi/libiscsi.c                            |  6 ++--
 drivers/scsi/vmw_pvscsi.c                          |  7 ++--
 drivers/usb/gadget/function/f_fs.c                 |  9 +++--
 drivers/usb/host/xhci-pci.c                        |  5 ++-
 fs/xfs/xfs_ioctl.c                                 |  3 +-
 include/uapi/linux/nfc.h                           |  6 ++--
 lib/test_bpf.c                                     |  2 +-
 localversion-rt                                    |  2 +-
 net/ax25/af_ax25.c                                 |  4 ++-
 net/ipv4/af_inet.c                                 | 10 +++---
 net/ipv4/udp.c                                     |  2 +-
 net/ipv6/ip6_vti.c                                 |  2 ++
 net/mac80211/mlme.c                                |  2 +-
 net/phonet/pep.c                                   |  3 ++
 net/sched/sch_qfq.c                                |  6 ++--
 scripts/recordmcount.pl                            |  2 +-
 security/selinux/hooks.c                           |  2 +-
 sound/core/jack.c                                  |  4 +++
 sound/drivers/opl3/opl3_midi.c                     |  2 +-
 45 files changed, 223 insertions(+), 94 deletions(-)
