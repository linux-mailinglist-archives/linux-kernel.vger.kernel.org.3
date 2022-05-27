Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39B5535B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349770AbiE0IgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349630AbiE0If6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:35:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40245F1364;
        Fri, 27 May 2022 01:35:57 -0700 (PDT)
Date:   Fri, 27 May 2022 08:35:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cedcf4dAND61Nrxi6DEHAepaUo8Lva6OT37IgFUsZ0Y=;
        b=N5qwWLpWFLWn1pclGgAE6s89wlguDvhsUSrvgfmRirvvGAQiSbKC2EpTJJjJizbRsXc6qC
        sOzwZRaWjVLgi/HLkQxQxmGJ6w8U39TlMF1zVOd8DdL1sdB5CTlqEjhTyhEv324VoPiFsi
        vzekox1uJX0ZOjgVqvgtnSR9EwF0ccJFtJKi3pZxp8Rc3na7q/0UXmC/i88KQ11gcwQCgf
        GEwB4b6caqf/G2c5YEy4OSBJB3IMeb0xfoS1KF5MSjFjXOw0/AogT94w9A9/vBrON3tez5
        R1fN/bQJEVIU82M5hukdxEh/pHX7l4iRVjgMm0tykZ4sjac5V0HPJqlCMRDjVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cedcf4dAND61Nrxi6DEHAepaUo8Lva6OT37IgFUsZ0Y=;
        b=pM1d5Q8KTaaOYUmrqAXYP1zO6GWRk/vx6lhjmF1r8iWnYNBwulwGN8juV/wDlDx0cOPZ69
        gKojPc6GKCnnGdAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/lpc32xx: Convert to SPDX identifier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220510171254.717233312@linutronix.de>
References: <20220510171254.717233312@linutronix.de>
MIME-Version: 1.0
Message-ID: <165364055427.4207.14903378008354479615.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     85c5aafd8e6a2476d27715b57dbcf26805eb3ab7
Gitweb:        https://git.kernel.org/tip/85c5aafd8e6a2476d27715b57dbcf26805eb3ab7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 May 2022 19:24:45 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:59 +02:00

clocksource/drivers/lpc32xx: Convert to SPDX identifier

The license information clearly states GPL version 2 only. The extra text
which excludes warranties is an excerpt of the corresponding GPLv2 clause
11.

So the SPDX identifier covers it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Link: https://lore.kernel.org/r/20220510171254.717233312@linutronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-lpc32xx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-lpc32xx.c b/drivers/clocksource/timer-lpc32xx.c
index d51a62a..68eae63 100644
--- a/drivers/clocksource/timer-lpc32xx.c
+++ b/drivers/clocksource/timer-lpc32xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Clocksource driver for NXP LPC32xx/18xx/43xx timer
  *
@@ -6,11 +7,6 @@
  * Based on:
  * time-efm32 Copyright (C) 2013 Pengutronix
  * mach-lpc32xx/timer.c Copyright (C) 2009 - 2010 NXP Semiconductors
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  */
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
