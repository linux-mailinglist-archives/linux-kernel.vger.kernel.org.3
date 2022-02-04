Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9600C4A9715
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357941AbiBDJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:45:34 -0500
Received: from mail.nearlyone.de ([46.163.114.145]:52476 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357714AbiBDJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:45:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C4835D29E;
        Fri,  4 Feb 2022 10:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1643967920; h=from:subject:date:message-id:to:cc:mime-version:content-type;
        bh=uW+iRR5gqEJU+1M6EnA8mdOewWVOAxPVV8N6J4EW8hY=;
        b=JV64dYc6Hyr/HoKpususCmfBbiJ45ShPx9mx6JJqprck7tZ526xlavIbpxb7UnFTkni6+D
        nAnP1pTZuttmAvhQfzbH6OIyha5AU2Vkk7bM4kxuoZU8zj37RLG5ocYq+g9PC4itI+Y1aE
        OaEMM0a2xHy2gl+OAWEdKcy+ZLwybNA0rceTbjFm5KLDhYGKrk/I0NkS+u9ionFsZt6WRn
        1LMnZGuWMxfRZJkb64jShGZNoh9QWSxeDOTTbMI70as6Zg9AiHXqD9kjQB3B1edexKeIrR
        2J3MNd5rPg8ef80QxjTIJoSlwLdt77H9sfEgz01uGGtIb5A6tBtYbhAn0eMOSA==
Date:   Fri, 4 Feb 2022 10:45:17 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.4.302-rt232 (END OF LIFE)
Message-ID: <164396730424.21109.15121913505546223213@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.302-rt232 stable release.

This is an update to the v4.4 stable update[1]. No RT specific changes.

The v4.4-rt branch is END OF LIFE. There wont be any v4.4-rt updates
from the stable-rt community anymore as the stable v4.4 branch reached
END OF LIFE as well. As Greg indicated the CIP project is considering to
support v4.4 a bit longer.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 334a53b5f6c3f92cfe37ba1083fe3dd06eac1df4

Or to build 4.4.302-rt232 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.302.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.302-rt232.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

Enjoy!
Daniel

[1] https://lore.kernel.org/stable/1643877137240249@kroah.com/


Changes from v4.4.301-rt231:
---

Alan Stern (2):
      usb-storage: Add unusual-devs entry for VL817 USB-SATA bridge
      USB: core: Fix hang in usb_kill_urb by adding memory barriers

Brian Gix (1):
      Bluetooth: refactor malicious adv data check

Cameron Williams (1):
      tty: Add support for Brainboxes UC cards.

Congyu Liu (1):
      net: fix information leakage in /proc/net/ptype

Daniel Wagner (2):
      Merge tag 'v4.4.302' into v4.4-rt
      Linux 4.4.302-rt232

Eric Dumazet (3):
      ipv4: avoid using shared IP generator for connected sockets
      ipv4: raw: lock the socket in raw_bind()
      ipv4: tcp: send zero IPID in SYNACK messages

Greg Kroah-Hartman (2):
      PM: wakeup: simplify the output logic of pm_show_wakelocks()
      Linux 4.4.302

Guenter Roeck (1):
      hwmon: (lm90) Reduce maximum conversion rate for G781

Guillaume Bertholon (5):
      Bluetooth: MGMT: Fix misplaced BT_HS check
      Revert "drm/radeon/ci: disable mclk switching for high refresh rates (v2)"
      Revert "tc358743: fix register i2c_rd/wr function fix"
      KVM: x86: Fix misplaced backport of "work around leak of uninitialized stack contents"
      Input: i8042 - Fix misplaced backport of "add ASUS Zenbook Flip to noselftest list"

Ido Schimmel (1):
      ipv6_tunnel: Rate limit warning messages

Jan Kara (2):
      udf: Restore i_lenAlloc when inode expansion fails
      udf: Fix NULL ptr deref when converting from inline format

Jianguo Wu (1):
      net-procfs: show net devices bound packet types

John Meneghini (1):
      scsi: bnx2fc: Flush destroy_work queue before calling bnx2fc_interface_put()

Steffen Maier (1):
      scsi: zfcp: Fix failed recovery on gone remote port with non-NPIV FCP devices

Valentin Caron (1):
      serial: stm32: fix software flow control transfer

Vasily Gorbik (1):
      s390/hypfs: include z/VM guests with access control group set

Xianting Tian (1):
      drm/msm: Fix wrong size calculation

Ziyang Xuan (1):
      can: bcm: fix UAF of bcm op

daniel.starke@siemens.com (1):
      tty: n_gsm: fix SW flow control encoding/handling
