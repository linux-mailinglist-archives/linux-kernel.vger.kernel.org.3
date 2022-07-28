Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E8583C42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiG1KoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiG1KoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E06558B52;
        Thu, 28 Jul 2022 03:44:06 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEbhqaxSChgM9OdbvV/k/n22+zGiBNFAmseZxqwdJHg=;
        b=r5nc7x35yN4QWmnVd+9COzAQjr5RcWUOPDr+Otth5ev4dyHdy4909wXwOdUs9GxdyBDzst
        AQjmAmCqcdQP9In/uPxu4C254q5YKqVpLw75ELzVBjVD3UA6IaRfWYwWve35LGlDjjDCoy
        nGhmJetGtBiWgUhdSAU+A/rMDQ3/YBPksO4uw2r8Xm0R4GbJKWPFpfURB35iaykb3h7s3X
        Rjh8JAjFQQcoIz78ngRxaRoxyT0PbmYwTxIrUOilt7JP2MFLWtMc+egIsNoYg1I+INnwA7
        eyxLMNt6fS1YEgYp7Vdu8RxlRgoPDBR2XLSYNAS7hVq5mSmLUGvCIYLC5iNF/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEbhqaxSChgM9OdbvV/k/n22+zGiBNFAmseZxqwdJHg=;
        b=A8j57QCGcq42Fb8oxOw30uWiOdED/hfGKwbHMj7w2O1gWvsdI6VXJXBa7JaWOGPXfD0I0d
        4R/q3jWZz1R3vRBA==
From:   "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/tegra186: Put Kconfig option
 'tristate' to 'bool'
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220718213657.1303538-1-daniel.lezcano@linaro.org>
References: <20220718213657.1303538-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165900504361.15455.7202765072349365466.tip-bot2@tip-bot2>
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

Commit-ID:     110a25357584a2d2d9f50accb1e89455c54290b6
Gitweb:        https://git.kernel.org/tip/110a25357584a2d2d9f50accb1e89455c54290b6
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 18 Jul 2022 23:36:57 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:00:49 +02:00

clocksource/drivers/tegra186: Put Kconfig option 'tristate' to 'bool'

The clocksources are built-in, they are not modules. We don't know if
the core time framework is ready for clockevents / clocksources as
modules.

Revert back this option to 'bool'.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220718213657.1303538-1-daniel.lezcano@linaro.org
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5d09cf5..440d4f4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -158,7 +158,7 @@ config TEGRA_TIMER
 	  Enables support for the Tegra driver.
 
 config TEGRA186_TIMER
-	tristate "NVIDIA Tegra186 timer driver"
+	bool "NVIDIA Tegra186 timer driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on WATCHDOG && WATCHDOG_CORE
 	help
