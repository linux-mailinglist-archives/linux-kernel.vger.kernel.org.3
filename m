Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1E583C45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiG1KoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbiG1KoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A61E57263;
        Thu, 28 Jul 2022 03:44:04 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUS0xp6fB/bN90KSCuUvJRR+c+gHiKZyzDPGK6ohrRA=;
        b=DFtUR3yRIss1w74z27aQeV6JCHv0QKbDNdTHdpTs5QUI8Q0MkDXe8G1eK64s/R9aP7L3uB
        AIUEKBdWRCAJ0Er7PBj2DXLZcIH3UYwlBlwQdRPlk34bDEsgL6MVBbHaaoNnFTmSRUt7ct
        rcQXYvpO3OBrqbhtscCfi9kvQBdHEbc1GAoMuXKScFs0reOmbId8eU6DXo/zmzcKSNHAr/
        gpGLeEOdpBDPw9N49F3ot8qvyr0DaM3hBsTRGtDrePivJFaiHG1XZ7Yj27iZNbmgUIs3Qw
        DFM5eUT7HsANQ1cnQxAuWa+5LL+XT3jsjP5ikM21t041UchddRHAfiGBl3LL+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005042;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUS0xp6fB/bN90KSCuUvJRR+c+gHiKZyzDPGK6ohrRA=;
        b=DyhZgCiJphs6zEOvZUWKLQfMwNPeJoaHWPUJVdKdNKlc06q6CViLUzmSb8ptmF41EFxaZC
        8slJ5b/jZuaHKhDg==
From:   "tip-bot2 for XU pengfei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sun4i: Remove unnecessary
 (void*) conversions
Cc:     XU pengfei <xupengfei@nfschina.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220720020735.3771-1-xupengfei@nfschina.com>
References: <20220720020735.3771-1-xupengfei@nfschina.com>
MIME-Version: 1.0
Message-ID: <165900504167.15455.6354118034471744933.tip-bot2@tip-bot2>
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

Commit-ID:     7a93d490900edcdbd3833d8bb9a01b23d8bb461e
Gitweb:        https://git.kernel.org/tip/7a93d490900edcdbd3833d8bb9a01b23d8bb461e
Author:        XU pengfei <xupengfei@nfschina.com>
AuthorDate:    Wed, 20 Jul 2022 10:07:35 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:01:52 +02:00

clocksource/drivers/sun4i: Remove unnecessary (void*) conversions

Remove unnecessary void* type casting.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
Link: https://lore.kernel.org/r/20220720020735.3771-1-xupengfei@nfschina.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index bb6ea6c..94dc6e4 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -128,7 +128,7 @@ static void sun4i_timer_clear_interrupt(void __iomem *base)
 
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *evt = dev_id;
 	struct timer_of *to = to_timer_of(evt);
 
 	sun4i_timer_clear_interrupt(timer_of_base(to));
