Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0B4EBE05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiC3Jru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbiC3Jrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:47:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00E267591;
        Wed, 30 Mar 2022 02:46:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7569C5C0194;
        Wed, 30 Mar 2022 05:45:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 30 Mar 2022 05:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=IqPvKyQ6qMpku5I40/8FtZcCMepOPwE59gZVZv
        4G8ug=; b=GNGeUDzw4n80hqW5Nu15s66q2bN2dPPSpD9CZ3PeCNqqwlE1Yv9NT5
        lvoOf52XOAbrJ5cWuP7tuyqTnjAowimqbrkT/0BRIL8DT1PdqPPeGX47MjU3wq6s
        MTSrSpajJAoHt+d4d1KZoVlgP3bt7J33r9orVj+nbeczxek4O/gjb8yWC/45qeG+
        fm59txCY+cW35cnFMf/D8kMAg9PqsRUYHia7P2q3LkP6Hl7EUeKLxYe4F2AUFi8q
        msn/GBLhcdRgq86A4FjaEUqn+VsdLtPMskrjfmZjgb5epRiT7tOXSwYVe48UYKnI
        xbCDwlSVjXEJAzrc+H9s2Oj//81rWGkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=IqPvKyQ6qMpku5I40/8FtZcCMepOP
        wE59gZVZv4G8ug=; b=AU48Hzmt8oM+KC2lRCEm0YCkQgtjbHkhJglj1RqP4Kf7N
        9CX+Y/3Irngo/zcmYHwzM2CHPJL6BCxU6mGLp5y4qarIsLALTtsHPIQYUDsqRveP
        OUfqYbi2Vbwa1KgJlNcwRleT+orprUBe5py0ePcZGo3id88ZueVwz9jFwZr9+eY6
        yd+ggDvJ0PtZ1R6ATNXK4mYVWOr3ULpsCV85b1ptYB6h8+HQYIa1aOb3KQTbKP7E
        SRcKnyMH1su9s9OsnRv60+0y+ltiBbHgj747lt4YYvrpL2HBmDFDQDXeL7KBTq4l
        9E1kzCV6zy/ZKRjewZE4rL41N+UnWeOdEd/vU1IDg==
X-ME-Sender: <xms:1yZEYirIu29v7RSEI4Tg-FTAvd3zOedq5uGCaP1cYRiYKZyvMoFHKQ>
    <xme:1yZEYgoSeIPOzGTBKrSx4CAslEsspZ_VNMvzol49Q9jnGt66ooYyF_T6BJH9DuXPm
    uulbwZyoOusJpa9tBU>
X-ME-Received: <xmr:1yZEYnMC7R7SWTq6EzIwlKv4Kt47pDnxAzmQlN2kYK5G7i5icIFVbaTHuWgUMe-KH30Cs2wo2Ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeejleeihfdvtefgtd
    ethfdtgefftdeiffefjeeiffefveeuleejheejvefhffeukeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:1yZEYh7JBFzXClwgGjBxMypdpqPPu2WavL84Wfc3AdvJNGpdsc0QgQ>
    <xmx:1yZEYh5apiKmUz1S0stFCGl-Y6YU251eVrpbRVWxoczXvitG1UFGIg>
    <xmx:1yZEYhjvWc7sbLSNkqXkA9xjVnXxKXPWj24dxXmrUzXxQCdpKmoevQ>
    <xmx:1yZEYtj3Ka7gVTmQENDpx5pxOuQYI1dYlrrdMjZp-R2YmFm4ag6N1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 05:45:54 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de,
        linux@roeck-us.net
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5] watchdog: imx2_wdg: Allow ping on suspend
Date:   Wed, 30 Mar 2022 19:45:52 +1000
Message-Id: <20220330094552.31039-1-alistair@alistair23.me>
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

This patch introduces the "fsl,imx7d-wdt" compatible string
which enables ping on suspend support. This allows the i.MX7D systems to
suspend without triggering the watchdog.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
v5:
 - Fixup commit message description
v4:
 - Fix spelling on allow/alow in title

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

