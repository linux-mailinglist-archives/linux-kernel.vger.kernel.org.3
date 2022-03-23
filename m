Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D54E51B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbiCWL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiCWL7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:59:36 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7B1129;
        Wed, 23 Mar 2022 04:58:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CB875C017F;
        Wed, 23 Mar 2022 07:58:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 23 Mar 2022 07:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=njhFasRxl7Ia1rqX1GO6RIfc0g8n5/4PEtJNvN
        BVDok=; b=Y5thfAR321DMYFnFm7bhCzkSBUoOnnavryCjsHPUXb+M/fK1gc86hX
        1mZB/Yrsa4ov6SpS1GYP8O4mNJPmMEfBsbgFBfd+7SyRWvm0RaVAgn3q5KvJnIMv
        F8s9dDqFT3+qNmWgp8DUtdGcoe8oZIDtedMig8UOYxqOZm94ip6QjBHUwcec44cL
        ar/zdmmvpRGpZ8vBgU+TR6CrFHrzHyE0kvvFyJfqHn6mkWVKdSqyuWBZJCtVAE89
        hopavM3je5MY87re4Tfuu5mbNgih9u9M5VYcBmS8MwXQ5EPBNySrb1fX5hptYELM
        zYol+N/fD3T30z+S1thQ9piHi+JcQrKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=njhFasRxl7Ia1rqX1GO6RIfc0g8n5
        /4PEtJNvNBVDok=; b=mdnYcUdhuEX6a0ttheB9gooKSO65Xb2r33bLAJvwQdVqO
        NDL29/OuMpscze0GVQEZE+kyWpxc2aH2Hc1gDZFc7F5QUtyj3G6CiRdqskW4kgrz
        YCXEBufpyleb5mAugj3Mo2ZLX36RPfg8vwZJJP2PWzyswclL+3gn/Bx0qKDwZvHq
        zfqCv8/qx1XsOAJO6lNxAtOAQyDoTq4ojcLZIJNrAxALaewQBU36QSJ3Gm6PBOp4
        2puydx4N/G8WUWeG76hDfe37UwBRIS1xeDMse/Qq6FSolJGQDSg5OX6Ladawlz4I
        Za3AEd+AKdTdx7x3E8AMFDqZQCcjQS5FQNd+qXKRg==
X-ME-Sender: <xms:SAs7YoDWBIs5HmpNlN85X8MuyZG75S-APzlUdhhyWFne_HeSTKJYpQ>
    <xme:SAs7YqhwvI9Kf4f_f9XOBfGwIZN8q9_xz1YR65QyTbk3IX_7magkA_mEC8ie2SZJH
    cgj1ghny2aZmPfJkr4>
X-ME-Received: <xmr:SAs7Yrk_swLN_dEvSH4U8BiRIaGGxpnggpCiEBj3FkRk3g7kgzuiwXZEB58JvoMPPuLCOHSgJv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:SAs7YuzDAaONmUfUwjqb0dU8m-Ti0fa-AK8HsWUg_QobOyrrbrdK5A>
    <xmx:SAs7YtQ3mn_7Nq8sdCNcAfoVYfBA9grgem_tnQ9hc9Om16WX2uYaWA>
    <xmx:SAs7YpbZKLNR5Lpr9KddZTHoozh081dANQgUa5xJMMf_EXg4sJaAeg>
    <xmx:SQs7YtZ9oOUGFxWipqa4oWF7jd0sNPaWBnYRdEhZDxf2ysyMRaGdZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 07:57:55 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     shawnguo@kernel.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, festevam@gmail.com, robh+dt@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4] watchdog: imx2_wdg: Allow ping on suspend
Date:   Wed, 23 Mar 2022 21:57:52 +1000
Message-Id: <20220323115752.360409-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX watchdog cannot be disabled by software once it has been
enabled. This means that it can't be stopped before suspend.

For systems that enter low power mode this is fine, as the watchdog will
be automatically stopped by hardware in low power mode. Not all i.MX
platforms support low power mode in the mainline kernel. For example the
i.MX7D does not enter low power mode and so will be rebooted 2 minutes
after entering sleep states.

This patch introduces a device tree property "fsl,ping-during-suspend"
that can be used to enable ping on suspend support for these systems.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/imx2_wdt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 51bfb796898b..d0c5d47ddede 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -66,6 +66,7 @@ struct imx2_wdt_device {
 	struct watchdog_device wdog;
 	bool ext_reset;
 	bool clk_is_on;
+	bool no_ping;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -312,12 +313,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 
 	wdev->ext_reset = of_property_read_bool(dev->of_node,
 						"fsl,ext-reset-output");
+	/*
+	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
+	 * during suspend.
+	 */
+	wdev->no_ping = !of_device_is_compatible(dev->of_node, "fsl,imx7d-wdt");
 	platform_set_drvdata(pdev, wdog);
 	watchdog_set_drvdata(wdog, wdev);
 	watchdog_set_nowayout(wdog, nowayout);
 	watchdog_set_restart_priority(wdog, 128);
 	watchdog_init_timeout(wdog, timeout, dev);
-	watchdog_stop_ping_on_suspend(wdog);
+	if (wdev->no_ping)
+		watchdog_stop_ping_on_suspend(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
@@ -366,9 +373,11 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
 		imx2_wdt_ping(wdog);
 	}
 
-	clk_disable_unprepare(wdev->clk);
+	if (wdev->no_ping) {
+		clk_disable_unprepare(wdev->clk);
 
-	wdev->clk_is_on = false;
+		wdev->clk_is_on = false;
+	}
 
 	return 0;
 }
@@ -380,11 +389,14 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 	int ret;
 
-	ret = clk_prepare_enable(wdev->clk);
-	if (ret)
-		return ret;
+	if (wdev->no_ping) {
+		ret = clk_prepare_enable(wdev->clk);
 
-	wdev->clk_is_on = true;
+		if (ret)
+			return ret;
+
+		wdev->clk_is_on = true;
+	}
 
 	if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
 		/*
@@ -407,6 +419,7 @@ static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
 
 static const struct of_device_id imx2_wdt_dt_ids[] = {
 	{ .compatible = "fsl,imx21-wdt", },
+	{ .compatible = "fsl,imx7d-wdt", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
-- 
2.35.1

