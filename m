Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3C5AAA9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiIBIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiIBItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:49:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F2540BE6;
        Fri,  2 Sep 2022 01:49:34 -0700 (PDT)
Date:   Fri, 02 Sep 2022 08:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662108572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LhC5SzV6FmtAzJxo9QgqF/iC69FniHK0pnksthsFM90=;
        b=hb2t/0o9211K7UhBmFCuvLG7ybD7aq99+w1DG7RXvruwKlawDzj/SF/SnOviHqPMq7HOqD
        CGmGWBmfTE1pcC0VRb4H3L/CMFxuDsvR4UOC/zuejyOq7JmIZcvOKv/pEBtTfOYCyy0BI4
        wQE7fhTdlK4FVUmpDrQ4EnIOhAzvmSKlNfiAgo6CuBgV+lLkLnZlXP+zw77doaRRcDeUgv
        14D0CPDlcC1JR869dd64NrULEahuk0M0CTttw/jqmotbMzNCmGIoW3WvhtFfFjWIkdaRMi
        35I5MWxc+6MiriV47htgijATsPHuN2+trs9FPMgbCC4zhr/FIZzrV6QlMibnkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662108572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LhC5SzV6FmtAzJxo9QgqF/iC69FniHK0pnksthsFM90=;
        b=jjoO2p+EsKBZIhuzlwHRq37p+J4U1/qpwiPOsJC/a65TAp6oWWCpQa25o14gqkBDG0tlgv
        mWILOLr2Z+WJD2BA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/defconfig: Enable CONFIG_DEBUG_WX=y
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166210857127.401.12347515000313120930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c0d2e63d4c618185cdd92faae10bdde33a00c25d
Gitweb:        https://git.kernel.org/tip/c0d2e63d4c618185cdd92faae10bdde33a00c25d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 02 Sep 2022 10:41:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Sep 2022 10:41:42 +02:00

x86/defconfig: Enable CONFIG_DEBUG_WX=y

7 years after it got introduced it's time to make this the default,
at least in the x86 defconfigs.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index a292489..3cf3491 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -273,6 +273,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_WX=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 2a7333b..2775923 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -269,6 +269,7 @@ CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_WX=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
