Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11967488686
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 22:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiAHV5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 16:57:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiAHV5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 16:57:32 -0500
Date:   Sat, 08 Jan 2022 21:57:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641679050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=967Qju2NwbyM0qVAZp6YVDsi5d6NviMZ1NadlgJJnmE=;
        b=YLjrttD1zZdaPKjMTqhnhZbfu4Q0ZrJY2HcPE1yqfqnPTva/KBNAZSUrpQObdsFKXjFklw
        3AngByy3/xyLIfnX5QuMBHvDUft2DEvvPetjgKYJg7KdFhk9DSTDz3WdpUreS190LtZh3H
        P7mmrmyG1JbAQkIV9lKakJQJsWNDzgZf7z2ZKrE8Jpvamaigd8P2V0MjjD/r9FwCpFIMGC
        YsMpktpKnsG/PHOHC3sXFqnc0O4orKK0Vhp3TnWHEZPz6WMrqjfKft8OMrSNu5OpxH/UqJ
        Uit0V5CdN+dS2Wp3U3J9PZlZqIF1SEAig+FPWMy0RdWE7B83fC6TMnZ7pjYUCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641679050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=967Qju2NwbyM0qVAZp6YVDsi5d6NviMZ1NadlgJJnmE=;
        b=TbLGib7L3rbLwwRV7JEYCW21Cr47I7f1NBE86x7flhdhujpTC41fTp8/EwDb+ATK7dx7tb
        86nQ+HfNIcZhftDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/kbuild: Enable CONFIG_KALLSYMS_ALL=y in the defconfigs
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YdTn7gssoMVDMgMw@gmail.com>
References: <YdTn7gssoMVDMgMw@gmail.com>
MIME-Version: 1.0
Message-ID: <164167904946.16921.8215342846945528313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     b6aa86cff44cf099299d3a5e66348cb709cd7964
Gitweb:        https://git.kernel.org/tip/b6aa86cff44cf099299d3a5e66348cb709cd7964
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 05 Jan 2022 01:35:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Jan 2022 22:55:29 +01:00

x86/kbuild: Enable CONFIG_KALLSYMS_ALL=y in the defconfigs

Most distro kernels have this option enabled, to improve debug output.

Lockdep also selects it.

Enable this in the defconfig kernel as well, to make it more
representative of what people are using on x86.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YdTn7gssoMVDMgMw@gmail.com
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 5d97a2d..71124cf 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -261,3 +261,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_KALLSYMS_ALL=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 30ab3e5..92b1169 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -257,3 +257,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_KALLSYMS_ALL=y
