Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA34D2D48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiCIKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiCIKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:43:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FB7C7BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:42:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D873DCE1DE0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019C9C340E8;
        Wed,  9 Mar 2022 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646822533;
        bh=i1WAlMbFpCB4zFf44FTclwrRDmJsihZ4p4yLAZbvN18=;
        h=Date:From:To:cc:Subject:From;
        b=ijyge3i9GHK+mFdpsdESFjuhIs3QM9gcgReZDclb4mxgERdKt5D5rtENvG6e2Il2a
         ezsyJQPe33ESZKJKy/MSS2Ul95d9MG+vzeLsakp3P4dvwQcDI8QZwV3DkhyTWIi5Be
         v++xQdSgcqDwCXq3S//9bO/KLWMKku1WY/7n1zDxbPmRFSB2REKKqTmMS0OrT1vV4j
         oMmGexeMmFbeE/lqAch6zVzXN5ryBkZ7QzQJMxIvP+yNQhBo1KhgUSlxKi7BqfivdA
         s6v5p4v1GfkPBi08mFiYYRCgX8FnQFtkcJ/7lPn5/N3H0bP0CKxrsfCtZ7+70HmBFb
         cHu4fRJmtTfTQ==
Date:   Wed, 9 Mar 2022 11:42:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2203091139210.24795@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive fixes for HID subsystem.

=====
- sysfs attributes leak fix for Google Vivaldi driver (Dmitry Torokhov)
- fix for potential out-of-bounds read in Thrustmaster driver (Pavel 
  Skripkin)
- error handling reference leak in Elo driver (Jiri Kosina)
- a few new device IDs
=====

Thanks.

----------------------------------------------------------------
Dmitry Torokhov (1):
      HID: vivaldi: fix sysfs attributes leak

Jia-Ju Bai (1):
      HID: nintendo: check the return value of alloc_workqueue()

Jiri Kosina (1):
      HID: elo: Revert USB reference counting

Lucas Zampieri (1):
      HID: logitech-dj: add new lightspeed receiver id

Michael Hübner (1):
      HID: Add support for open wheel and no attachment to T300

Pavel Skripkin (1):
      HID: hid-thrustmaster: fix OOB read in thrustmaster_interrupts

 drivers/hid/hid-elo.c          | 7 +------
 drivers/hid/hid-logitech-dj.c  | 1 +
 drivers/hid/hid-nintendo.c     | 4 ++++
 drivers/hid/hid-thrustmaster.c | 8 ++++++++
 drivers/hid/hid-vivaldi.c      | 2 +-
 5 files changed, 15 insertions(+), 7 deletions(-)

-- 
Jiri Kosina
SUSE Labs

