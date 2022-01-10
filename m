Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB0489929
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiAJNCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiAJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9A8C061748;
        Mon, 10 Jan 2022 05:00:00 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:59:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSvdeKv/XGJOW00Dafq3XoTx6afY1iCEVAyie0tCPNo=;
        b=HAPddS2ZHzpEc9gbX+O4mJ7Cy3FUP7CamXUwEP0csbvJvM7qtyFfySMB0LtOq8FIBWS0Vd
        PeY3rCzmKImWFsG37mrN6HPwcs8VMI5oM49KWeZR3QrLJ/wpeOMCvZCP4lFhNB9nsfwF54
        zytKjNayY+qLPsJSMpxuHUGZXhjtUGH5zeg4l+2X/Ol1C56gXnnaVpNd1M98opK3Vpc1Qc
        s3cGgrEzBhskVBCSnin4c4BAopa7FHkjKyaQdP4d5dxPBPjd71FASbnsZulbc96ygxIewq
        BvrKwcPNFwhi3HjXxlJYRHTTkU+ekzAz0Chc6bdmoCyOX7Somqa4XtxiYYxa8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSvdeKv/XGJOW00Dafq3XoTx6afY1iCEVAyie0tCPNo=;
        b=R75bVFx3gtlOnYRHkRxtQ5WRRvNBZXL9NzuwMKSmagXe0FvBSU/YnLKxRN/lBkEnDy1JdI
        0JZDQd0DQqaSSmAQ==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Fix silly typo
 resulting in checkpatch warning
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211103164804.30182-1-will@kernel.org>
References: <20211103164804.30182-1-will@kernel.org>
MIME-Version: 1.0
Message-ID: <164181959837.16921.11386944410746087524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     410fbda49cc9b2165e80b87880f164d9644b460d
Gitweb:        https://git.kernel.org/tip/410fbda49cc9b2165e80b87880f164d9644b460d
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Wed, 03 Nov 2021 16:48:04 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Dec 2021 12:29:52 +01:00

clocksource/drivers/exynos_mct: Fix silly typo resulting in checkpatch warning

Commit ae460fd9164b ("clocksource/drivers/exynos_mct: Prioritise Arm
arch timer on arm64") changed the rating of the MCT clockevents device
to be lower than the Arm architected timer and, in the process, replaced
a semicolon with a comma thanks to a silly copy-paste error.

Put the semicolon back so that the code looks more idiomatic and resolve
the SUSPECT_COMMA_SEMICOLON warning from checkpatch at the same time.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20211103164804.30182-1-will@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 857cf12..6db3d55 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -467,7 +467,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
-	evt->rating = MCT_CLKEVENTS_RATING,
+	evt->rating = MCT_CLKEVENTS_RATING;
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
