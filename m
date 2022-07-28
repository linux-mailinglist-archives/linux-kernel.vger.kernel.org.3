Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D56583C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiG1Ko2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbiG1KoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A1558CD;
        Thu, 28 Jul 2022 03:44:08 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ks7NDmugWmYKwK3yKYkehZq8Cz1u3P0371A+Gsgu3EI=;
        b=C9JpNJkf8NT9G8SQbzk6uvRA9Zuz+VmoMz2ODt/zlnHWYngpwi658mqImw6Ti/moVpxbFJ
        eM3K0c40VXd/gJBcUqna8BCeSaV/QwNgeXdVU+kGJfjSw/XXaDfjKC0AD7fTiLvSAPDhc0
        z+FuoJJpzVVSxfWFXkSxvIrM24vm/W6yhsIay0vHwhMdKVlDMDJrR0/5FPaGnqumH+VC38
        6Zh7N+n49EEO7FpnDeqdZnZD1TmrUiM6tuxFgSvXx8JF3m2CBqm8QCLo8GIm0C/dwhrWHX
        bQTP6CWsGUZwxaYTssSIgtFMOogCQULrvO028/0z/mcptetXeYzvypDX2kp1uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ks7NDmugWmYKwK3yKYkehZq8Cz1u3P0371A+Gsgu3EI=;
        b=brS34VPn6Azf8Qvianm53hxAofb3zpDbYHsNMC741+cden65NkIV0HULnL5J6PPCZ4x03X
        6ry8CQ7/xKEmDwAA==
From:   "tip-bot2 for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Add compatible
 for am6 SoCs
Cc:     Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220408101715.43697-4-tony@atomide.com>
References: <20220408101715.43697-4-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <165900504553.15455.9650668104529152866.tip-bot2@tip-bot2>
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

Commit-ID:     4e3203610a889c72e96ddfc9e601b9349ef19c00
Gitweb:        https://git.kernel.org/tip/4e3203610a889c72e96ddfc9e601b9349ef19c00
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 08 Apr 2022 13:17:15 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:00:48 +02:00

clocksource/drivers/timer-ti-dm: Add compatible for am6 SoCs

Add compatible for ti,am654-timer to support the timers. For example, am654
has four timers in the MCU domain and 12 timers in the MAIN domain.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20220408101715.43697-4-tony@atomide.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ti-dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 530b71f..80d7e5a 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1036,6 +1036,10 @@ static const struct dmtimer_platform_data omap3plus_pdata = {
 	.timer_ops = &dmtimer_ops,
 };
 
+static const struct dmtimer_platform_data am6_pdata = {
+	.timer_ops = &dmtimer_ops,
+};
+
 static const struct of_device_id omap_timer_match[] = {
 	{
 		.compatible = "ti,omap2420-timer",
@@ -1064,6 +1068,10 @@ static const struct of_device_id omap_timer_match[] = {
 		.compatible = "ti,dm816-timer",
 		.data = &omap3plus_pdata,
 	},
+	{
+		.compatible = "ti,am654-timer",
+		.data = &am6_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_timer_match);
