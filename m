Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADED583C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiG1Kpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiG1Kox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C22664DC;
        Thu, 28 Jul 2022 03:44:22 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28vTh1xrKraBbKk4KDvuJQ4oTbXOPi/qO6kFvmSS7fo=;
        b=Rw1crhnpbXtMKEvHxWVMcH6nj6NLCLiMncuXP7VSa9+RLMPcjK1SL4RwkDt81FA9/lUJpn
        qF8K/nPN7SyVyCKtRgbAhoK+E6WUbBtZlZ2Mix8ZrK2/DULMPU3yxPnlht2Ubb7+EpR3o7
        4LmU4erogWi1m83XqH2fDLCRV+TCRgSmDnaidyoXVpGjvboIu/xHO3IvqQUVqDFH/EP/5D
        4rPumBwTIorkKjl//alXIzlmQ+yywN/B8tI3QplaJ7NG5647q+pVwcU4ccK8xv/iiePrqW
        unBcUkfgoEBCaPmGTQeOPAgqMZ42sgP1iZEznnKtD0BVErbC0j9DM9P9bV/mRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28vTh1xrKraBbKk4KDvuJQ4oTbXOPi/qO6kFvmSS7fo=;
        b=A9XZc8Z6ANoSzQ9mHLTPO6ECPr+W6bKyTIOMTwBOr/wEEKjdXZ59eqolRMHqJlzqjvWjwX
        hw7f3D6CnkgR8ZBg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Fix Kconfig
 "its" grammar
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220715015852.12523-1-rdunlap@infradead.org>
References: <20220715015852.12523-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <165900505923.15455.14416342051577650910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6f6f3e313f39f91ed5ffd59bfaf29748ced9d24c
Gitweb:        https://git.kernel.org/tip/6f6f3e313f39f91ed5ffd59bfaf29748ced9d24c
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Thu, 14 Jul 2022 18:58:52 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:33:29 +02:00

clocksource/drivers/arm_global_timer: Fix Kconfig "its" grammar

Use the possessive "its" instead of the contraction "it's"
where appropriate.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20220715015852.12523-1-rdunlap@infradead.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8182ff2..0367a1c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -367,7 +367,7 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	depends on ARM_GLOBAL_TIMER
 	help
 	  When the ARM global timer initializes, its current rate is declared
-	  to the kernel and maintained forever. Should it's parent clock
+	  to the kernel and maintained forever. Should its parent clock
 	  change, the driver tries to fix the timer's internal prescaler.
 	  On some machs (i.e. Zynq) the initial prescaler value thus poses
 	  bounds about how much the parent clock is allowed to decrease or
