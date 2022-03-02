Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07D24CB17F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiCBVkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbiCBVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:40:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB5CA710;
        Wed,  2 Mar 2022 13:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9A0FB8223F;
        Wed,  2 Mar 2022 21:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C7C004E1;
        Wed,  2 Mar 2022 21:39:55 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.25-rt33
Date:   Wed, 02 Mar 2022 21:36:15 -0000
Message-ID: <164625697532.2377441.9278541632521957793@puck.lan>
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

I'm pleased to announce the 5.15.25-rt33 stable release.

This release contains a backport of the following commits from the 5.17.y-rt tree:

ac9c70a245d28	genirq: Provide generic_handle_irq_safe()
7e44f2d97e9c2	i2c: core: Use generic_handle_irq_safe() in i2c_handle_smbus_host_notify().
8ea8588239d64	i2c: cht-wc: Use generic_handle_irq_safe().
87ebe41b420c6	misc: hi6421-spmi-pmic: Use generic_handle_irq_safe().
a6efcd21ca31e	mfd: ezx-pcap: Use generic_handle_irq_safe().
dda02de93749e	net: usb: lan78xx: Use generic_handle_irq_safe().
37801f96e1f0e	staging: greybus: gpio: Use generic_handle_irq_safe().

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: e9e1ef73da553f7b8f8dc135229a97c7ad3b4ad4

Or to build 5.15.25-rt33 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.25.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.25-rt33.patch.xz


You can also build from 5.15.25-rt32 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.25-rt32-rt33.patch.xz

Enjoy!
Clark

Changes from v5.15.25-rt32:
---

Clark Williams (1):
      Linux 5.15.25-rt33

Sebastian Andrzej Siewior (7):
      genirq: Provide generic_handle_irq_safe().
      i2c: core: Use generic_handle_irq_safe() in i2c_handle_smbus_host_notify().
      i2c: cht-wc: Use generic_handle_irq_safe().
      misc: hi6421-spmi-pmic: Use generic_handle_irq_safe().
      mfd: ezx-pcap: Use generic_handle_irq_safe().
      net: usb: lan78xx: Use generic_handle_irq_safe().
      staging: greybus: gpio: Use generic_handle_irq_safe().
---
drivers/i2c/busses/i2c-cht-wc.c | 11 ++---------
 drivers/i2c/i2c-core-base.c     |  2 +-
 drivers/mfd/ezx-pcap.c          |  4 +---
 drivers/misc/hi6421v600-irq.c   |  6 +++---
 drivers/net/usb/lan78xx.c       |  7 ++-----
 drivers/staging/greybus/gpio.c  |  5 +----
 include/linux/irqdesc.h         |  1 +
 kernel/irq/irqdesc.c            | 23 +++++++++++++++++++++++
 localversion-rt                 |  2 +-
 9 files changed, 35 insertions(+), 26 deletions(-)
---
