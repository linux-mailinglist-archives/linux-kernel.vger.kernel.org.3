Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77681497E69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiAXMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:00:37 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50995 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234568AbiAXMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:00:36 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EC18258031C;
        Mon, 24 Jan 2022 07:00:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Jan 2022 07:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=OV6gLk/OEfbUZtYAocx2+toTLnr6A1apdN5v+9
        F9RTY=; b=fLd2Y+V1a0vi9JcgwuaDt2CN8S3I07gWyFgb+e8X8bOGJz9esjhrU5
        N4dH5Avtno0kPNTrNM3r2gIDa+4E9VtbP27oEYTjJ897w4XU/TZA5y8pJ+gH/qzC
        r3aPkvNukErE2++GQ1LCs0ILULlf7B2HSS4oEPE76uoUT9MVBQE2XJ/j8gAptbFD
        mIS1xVC4tUp8OvdgvXPnt/7jqLZ/7BZ3UZ8/IMOa43qgJE/w/K5w81IM7LEz0zKP
        CpClrOGWaU89rSljURh53xfDHbPqJk7lWRCDLKvjrE6im8DBT2D5tYyFF+R4Iu2s
        yDR03+rNfWwuwaDerWsYvjop6CEsvT4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=OV6gLk/OEfbUZtYAocx2+toTLnr6A
        1apdN5v+9F9RTY=; b=R5+Qhcet9Ig/qaYUGm9RwNGuyU2SxlsZBrMPwdvFy+qqN
        TYjgONMtXtYdq4iirYS2/z7NpCzNCgmDNNEim8R3L3Z8YqcbPGyOHTmXfU7Vs2t4
        S17yR5hDY+a3NR51jQrum1y3ThFaoXTwUtim7185KSk/fo2mF3fw8xoowWm4QNrm
        Ggkn1hw9uavN8JFLfne3ov2oSmDftANOU0XyMqYbtKrd0iLgczq7ovefMXeEn1em
        QbURZEK8CnjEXkbVMG2MBrBhDs9Gv5GqOMXh0HuyReRG3For8wQFHjblT7KuKc/O
        JccGHR6r+fqoWuv3qAIXqhi7xvdDoC8we8DOaliwQ==
X-ME-Sender: <xms:45TuYTcXjbyCKyeGiFkzeVIPn2ljDtXRmVCCjiL53dCSFzYgikLjOw>
    <xme:45TuYZNomGvhDc2gj1jI6EKuUQgaFi73vpxK6Wao9uE4KoSH97D_QegdW9qbfVIEw
    FRW4xsv-I18vfN3MeU>
X-ME-Received: <xmr:45TuYcjwvJZFDgJ065_m-xC3Peeb9eTsSNfKzVX7VJ7YS1xt8OFROdQrcLpRhlMP1J3wMeRUQUvuoltoQxzO7Xse7zEeH_qw57rRgQ_p3Klt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgv
X-ME-Proxy: <xmx:45TuYU-hCZzld1ZY6aDbsctGrwMSXVTknhNHK7WyjIKlgSxyaKFjXQ>
    <xmx:45TuYftsHoqSv478OZbWy37arpvNM0stEpjNm527FSXg6myV0CzaMQ>
    <xmx:45TuYTGFKMdV67MqSoA5kKUfYdeOdEWdJiynvNJ_68Jr4QxU1F564Q>
    <xmx:45TuYTFGHtt4blJX2oT6J_nq7aM7bl-K33K-y_POj8gzrVixYF6vqg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:00:30 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-arm-kernel@lists.infradead.org, linux@roeck-us.net,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        s.hauer@pengutronix.de, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, kernel@pengutronix.de,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2] watchdog: imx2_wdg: Alow ping on suspend
Date:   Mon, 24 Jan 2022 22:00:27 +1000
Message-Id: <20220124120027.106754-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX watchdog cannot be disabled by softwrae once it has been
enabled. This means that it can't be stopped before suspend.

For systems that enter low power mode this is fine, as the watchdog will
be automatically stopped by hardwrae in low power mode. Not all i.MX
platforms support low power mode in the mainline kernel. For example the
i.MX7D does not enter low power mode and so will be rebooted 2 minutes
after entering freeze or mem sleep states.

This patch introduces a device tree property "fsl,ping-during-suspend"
that can be used to enable ping on suspend support for these systems.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
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
2.31.1

