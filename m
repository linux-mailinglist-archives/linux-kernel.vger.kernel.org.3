Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA0489927
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiAJNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiAJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175BC03400D;
        Mon, 10 Jan 2022 04:59:57 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:59:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RK87sKfQK1GgoVdcb80emYlXNgCvVixZGlm/TafHJDc=;
        b=QhabCJKxfLI8Ay2uRaV4vijDnJxKSsmSfflUG87FSK26tJcQ45+arEAHDtFl5fY//z4pjo
        Kr7j3YKM5EhDgbcgz7eb4U+6Fqb/AzMki5X4Rzf+L8rWE1H1cnOpHATU3U8qfUb15gqx9/
        27KJYIjNsnvM2IhevLu2gyIFhsGa7oHRZh/fxdHhJEAfJcYHNknDe3OLh4dbYsIQyVgWxt
        NiG4wlhBceQ5FALFV523d3o5ckJM26JMl+i8zpG3CIxJmjjujp+oSLVHAKKJgUzOAln4U7
        vx0qMgsL7+LrqCWUClxY+oSf6fj2d3YfonpezNZMtu5/DqZcVW26yLzt/ZYCyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RK87sKfQK1GgoVdcb80emYlXNgCvVixZGlm/TafHJDc=;
        b=DPfspLNx/w+HU56utl5yg1h+7z23tx0bQGq/SDIxlALEwsipHe8SQevzeCq9HA/fOExKRn
        y865kHC5ajr9DiCw==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-sysctr: Mark two variable
 with __ro_after_init
Cc:     Kees Cook <keescook@chromium.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164181959496.16921.12784480702228745325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f5bd5fc9d478cdb94f89ccc74870dd81d1919b42
Gitweb:        https://git.kernel.org/tip/f5bd5fc9d478cdb94f89ccc74870dd81d1919b42
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Wed, 01 Dec 2021 20:50:29 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Dec 2021 14:13:04 +01:00

clocksource/drivers/imx-sysctr: Mark two variable with __ro_after_init

The variables 'sys_ctr_base' and 'cmpcr' are not be updated after
init, so mark them as __ro_after_init.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20211201125030.2307746-1-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-sysctr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 18b90fc..2b309af 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -20,8 +20,8 @@
 
 #define SYS_CTR_CLK_DIV		0x3
 
-static void __iomem *sys_ctr_base;
-static u32 cmpcr;
+static void __iomem *sys_ctr_base __ro_after_init;
+static u32 cmpcr __ro_after_init;
 
 static void sysctr_timer_enable(bool enable)
 {
