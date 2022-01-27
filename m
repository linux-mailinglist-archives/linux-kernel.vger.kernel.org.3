Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9949DFBB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiA0Krt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:47:49 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41489 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234845AbiA0Krr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:47:47 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id ED60C580325;
        Thu, 27 Jan 2022 05:47:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 27 Jan 2022 05:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=/Q1y1pNtiXVQD7Pj8td3yR3lF4dB6MlMG9FvF4
        asB9A=; b=ZJUc1vFbckXRuLXAH+4BAKpDs6sBuFQboo1i2ZLMdV1kvPse0uSRGs
        r7pwkRL7/lT2S4v7nCZir+ttB3ofPrAsz0kvqz9AenmGoa55AdhMcE8u6zWj0a87
        WUQCHiadFyCR/CgLXoIM271ywrC38UZbd+dkfAfRlHgBVq7cfZ6hx1Kdm7QPTw2b
        2VPAygt3KScZsKLXeZCfsCl8WV3rM3tL6yadqA7e9q2pUFYf1BkqnyLw0zfwXQ3r
        qs5lsq+cYJDPuZFTzuv5CxJ+LvOIT+N/LoipCgVhMky22/z03zKHbifkShA3zSUg
        mSynnTDRUjm1t50vNQv+lLyCV7db1ezg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=/Q1y1pNtiXVQD7Pj8td3yR3lF4dB6
        MlMG9FvF4asB9A=; b=CnVBCJZEpRh2fGtMjofaZNYrW+PgmJ7cdbp+I6JA/vC7n
        qBImVv6CM4Vj752QAPc27ODkN+3sNdT5kT6nN/S127zanANQ/NyB/5PveZQK69pF
        jjz/H3GwNLjbm4LPm2IeA/cK4vWEulOwmLLFwqWXAO7zV/cq5x7WgUUj+6DU3Qfm
        kHGt48kZE8GvYH3pc0VMuz4ley4PN/WSys893LFpjILz8Wz0A6FNGuChp/Kb5bc/
        GXM8EEYb0JNDQJ2P1oZm1fIh06TwnBUsT6QCNzpXzTrMhLYlsk1ifux6Fk5LTLyH
        zcztcNnNM7awMAVe9ZQ5tF25f5GsHSkidmI4/gnCA==
X-ME-Sender: <xms:UnjyYTPUIOiMReyaCPqjt_WL-uK4-zK14ghl40r3OulCkq3HiuxtEA>
    <xme:UnjyYd9HmnVQT--ght1uo0k8LDbwTml9U23w-9Uq_xEg488nSkG_TKhNe_vo8ef54
    QFTp37EWYD3tiosrZE>
X-ME-Received: <xmr:UnjyYSRMN0qWhuIf5l-EN7yIdCSM7AXmuIzR3YmC4EBC-AQuy99c76HpfUE7PxzliTuX3mrWhWBxeZpJ6PgTNSgW6hywNHSIiuR7s3S8GHY5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeefgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvggtihhpvdculdegtddmnecujf
    gurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishhtrghirhcu
    hfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecugg
    ftrfgrthhtvghrnhepjeeliefhvdetgfdttefhtdegffdtiefffeejiefffeevueeljeeh
    jeevhfffueeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:UnjyYXsvB_byPkEXLE48tJ6Nem1nQB5jiz986gtVtPwvFBAXXUHNYg>
    <xmx:UnjyYbd9X-FOx6V3sH072vFEGWCk_mUbwjc7Mi0xnYw4bAKouzw-Dg>
    <xmx:UnjyYT2NNdhmsGFE9zdsfnvlXuwiUsNhjXvpZemIR_b4BmZtdAOEqw>
    <xmx:UnjyYT1p7W50OigL1qMAf_xQIDKc-91dAlRZy6GPVbDtkmCl5j_BvQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jan 2022 05:47:42 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        s.hauer@pengutronix.de
Cc:     robh+dt@kernel.org, linux-imx@nxp.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3] watchdog: imx2_wdg: Alow ping on suspend
Date:   Thu, 27 Jan 2022 20:47:39 +1000
Message-Id: <20220127104739.312592-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
v3:
 - Fixup typos in commit message
v2:
 - Remove custom property

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

