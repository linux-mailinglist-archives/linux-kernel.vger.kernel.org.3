Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005974D7EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiCNJax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbiCNJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B724C443D8;
        Mon, 14 Mar 2022 02:28:33 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8xHN8aCpCJbBJdzn4gr64qUx2dODxv0lbSbUX8/eps=;
        b=RyYd5mNNxXltipHcfKhfQa3Y3Phyvg7OrBHDtMcWXcx0WhEx7SNShb8A8euWGKIYsAwMAb
        lczNoyQTM0DsWPCyxjt+GZ5axidCjPTf6/g0FA8U7RmRWV6clx54j2Ix/ecYt/B3Tgz49R
        BTCn0nyushafL8xLZTcISNs+yuh63bEDtlEeP4m7Yzrmo2gZV96YxUqDnvV47Y5KKA8Wfy
        3sbEazsew+OAVucMdYIm6Sm9bBMnzyIVXwZ8kI+JhSvybVwZtHnewSugl+3MpQH6RS/7mQ
        +E8CI1j8chVOefmNnUWdLb7JMt4uyf2T5CHzmDlVcdykP0mqimuduxjanqaHDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8xHN8aCpCJbBJdzn4gr64qUx2dODxv0lbSbUX8/eps=;
        b=MnOgbtAl3vVFNcwrY8spo2VNph+9jyII0iQQHigpDxmawNiA6TgiVOgj4l35Shfzf26/Kk
        uJEslN82zIninjDg==
From:   "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx-tpm: Update name of clkevt
Cc:     Peng Fan <peng.fan@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211214120737.1611955-6-peng.fan@oss.nxp.com>
References: <20211214120737.1611955-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <164725011154.16921.14825368276621958347.tip-bot2@tip-bot2>
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

Commit-ID:     e547ffe9e6f497e36bde9d86dbcfbc781946752b
Gitweb:        https://git.kernel.org/tip/e547ffe9e6f497e36bde9d86dbcfbc781946752b
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Tue, 14 Dec 2021 20:07:37 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Jan 2022 10:01:05 +01:00

clocksource/drivers/imx-tpm: Update name of clkevt

The tpm driver is not only for i.MX7ULP now, i.MX8ULP also use it. It
maybe also used by other i.MX variants, so update name to reflect it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20211214120737.1611955-6-peng.fan@oss.nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 578fe16..df80641 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -127,7 +127,7 @@ static irqreturn_t tpm_timer_interrupt(int irq, void *dev_id)
 static struct timer_of to_tpm = {
 	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
 	.clkevt = {
-		.name			= "i.MX7ULP TPM Timer",
+		.name			= "i.MX TPM Timer",
 		.rating			= 200,
 		.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown	= tpm_set_state_shutdown,
