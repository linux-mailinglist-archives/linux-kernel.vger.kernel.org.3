Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51CF583C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiG1KoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiG1KoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44773558CD;
        Thu, 28 Jul 2022 03:44:01 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxv01eGaa649xSqbgRpJW9/CzfvQglZ4zFbdASaQxCM=;
        b=a872Xi/nAEFiU0H0RU30dbCrNgAq4O6Bu5QumjI39tQRqmkFsV634aItsUb/aEUvVWKk9W
        ZB6T42zDxc90/ZCe00ldvupQtm/d180ncaD+eiemnfSqWVsz2QJBl73zz8uBs1RTD3Daw6
        yh1RgGlWqLrQIsd4/Fyj+VrS8Kms+R8F4x77yQeyq9tW2iPwSExqb0fJ8bzJ12ikKO1cv5
        kjluVdM4cYd08LoHroQdSBrUId5oKYjg896c0Xf/WeYfOaLnDYlyF9QBYKULTBhp/6LRD3
        beWO1DVh20/4/zImoQDXvWWymfEYlEe4izMtKL50V/ns9319qGhxj2nNcAIthw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxv01eGaa649xSqbgRpJW9/CzfvQglZ4zFbdASaQxCM=;
        b=x1ePKgT+9VGpQBCdligMGC+9LmZr3yBbLTOt/4dOnGlbtxh1qBTLaQMl1dDmbJxceTHMqG
        pVZQ3xSOhH4kccDA==
From:   "tip-bot2 for Li zeming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sun5i: Remove unnecessary
 (void*) conversions
Cc:     Li zeming <zeming@nfschina.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220727083751.5540-1-zeming@nfschina.com>
References: <20220727083751.5540-1-zeming@nfschina.com>
MIME-Version: 1.0
Message-ID: <165900503875.15455.2041878956886148502.tip-bot2@tip-bot2>
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

Commit-ID:     148399c90e25bb5d1aa6f3e1dde25fec6f4005f2
Gitweb:        https://git.kernel.org/tip/148399c90e25bb5d1aa6f3e1dde25fec6f4005f2
Author:        Li zeming <zeming@nfschina.com>
AuthorDate:    Wed, 27 Jul 2022 16:37:51 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:01:52 +02:00

clocksource/drivers/sun5i: Remove unnecessary (void*) conversions

Remove unnecessary void* type castings.

Signed-off-by: Li zeming <zeming@nfschina.com>
Link: https://lore.kernel.org/r/20220727083751.5540-1-zeming@nfschina.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 85900f7..7d5fa90 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -142,7 +142,7 @@ static int sun5i_clkevt_next_event(unsigned long evt,
 
 static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 {
-	struct sun5i_timer_clkevt *ce = (struct sun5i_timer_clkevt *)dev_id;
+	struct sun5i_timer_clkevt *ce = dev_id;
 
 	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
 	ce->clkevt.event_handler(&ce->clkevt);
