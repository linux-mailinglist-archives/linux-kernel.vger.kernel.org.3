Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9028C4888E9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiAILlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:41:37 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57627 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235315AbiAILlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:41:36 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BC5B058017B;
        Sun,  9 Jan 2022 06:41:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 09 Jan 2022 06:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=LDXYYE+MqxWyK
        1qhbbPA/YRmiGTmz4Uzxb4a/XgCPCI=; b=C4ba/oa49ptB3yL66l0g8c3ysSxMY
        spHltFdr11Cl2/Bm/j+/uNZg+4FLLXny4Yt8+XI+e68ckXEg/gZuJQ+mS2RTKY+k
        2kEM7Og5MJbIQqec8olvDvHTHpiB1QIpYa5+PN7DC8xR+3ajM216IR19PfMDkfBY
        kJJKyq3Csd6YS9iK52a7V4VL0td0cDCrpmFclNvvQKs5heIkfamUiE6EEMNo4imC
        8rSF01h9ommT7natpvBXOiyVlilbAz0DZmn5gqfR2VhGUDpTYJzRwwUVmm4ocm2z
        ZR8B5dciGUHq6faCaSaPz36RuGBXSXhlT/Y2oZHc8ud80hxMIJ1vya8Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LDXYYE+MqxWyK1qhbbPA/YRmiGTmz4Uzxb4a/XgCPCI=; b=eXl1V4MZ
        iUWZRXBisFm54HkZiWNL+3SI9KzVv0Nnf+8zCBUdplNgpgBMEkvvDexSJowkPoTw
        YF5dwSLBFHMwLaNpgdBOsHgFquf2AL/n6V+/AXJilGNL8o1mIhrJzZ0epvICKRXR
        GWptVpKG95r29SmUYw3147ysaedF6XzhdAv8df4/Be2gLU31Rh5CAvJjVkZB28qh
        guI2jH+p1nCMX5IP1jzJRcxTi9BvKBe3hzBij+Lc/kyy5DA4iS6lwxqgvrhlCyBR
        g/wynQ0a9LYs4YHBkTigM04Ac4faUyiL1pWSblUwh1kqfSf9YfFA3Z9CZarJKMOX
        rIfVMo+soIA86A==
X-ME-Sender: <xms:78naYaxRCMLe8qQ7i7K9pnRvvYRcIwBl0d3L3iE1EUk-43twNlBrtA>
    <xme:78naYWRqcdFnYQV6dzzAuJvYIcWr0QIyA_9ZycAMIQqnxLg9hmf2ot_xxAPDNZGn-
    QlovSWsBR9XHaS574w>
X-ME-Received: <xmr:78naYcV8cNaZiD1KdsTiGN05rXG2BDhSzInDeVBzC1vypE6nlPN0nCx9qifCQJA40t1MSRf80abp95NfD-w_mL0KAu-5duPujN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:78naYQiKfX6YxraJs72P_wqDLS7fMV-TWnMi6n_Vts0ixipG6Xw3Qw>
    <xmx:78naYcC5GhEFUoHzmJm8iC_pUK6nSOl1fXcBae4kGzOcnxuwYQ63Wg>
    <xmx:78naYRIzKol681GtkHTCBLu7SgG-mrysWo7KxqFrdBzY6LukEUuKFQ>
    <xmx:78naYVIu20o6Q8vr9YlniFKCoZu5_dIzOTVq47pcRT8hqjREYo3NzA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jan 2022 06:41:29 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        shawnguo@kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/2] watchdog: imx2_wdg: Alow ping on suspend
Date:   Sun,  9 Jan 2022 21:41:19 +1000
Message-Id: <20220109114120.386013-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109114120.386013-1-alistair@alistair23.me>
References: <20220109114120.386013-1-alistair@alistair23.me>
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
 .../bindings/watchdog/fsl-imx-wdt.yaml        |  7 ++++++
 drivers/watchdog/imx2_wdt.c                   | 22 +++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
index fb7695515be1..b8660a3c456c 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
@@ -55,6 +55,13 @@ properties:
       If present, the watchdog device is configured to assert its
       external reset (WDOG_B) instead of issuing a software reset.
 
+  fsl,ping-during-suspend:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      If present, the kernel will ping the watchdog during suspend.
+      This should be used on platforms that don't enter low power mode
+      during suspend.
+
 required:
   - compatible
   - interrupts
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 51bfb796898b..9a5fdb3173a8 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -66,6 +66,7 @@ struct imx2_wdt_device {
 	struct watchdog_device wdog;
 	bool ext_reset;
 	bool clk_is_on;
+	bool no_ping;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -312,12 +313,14 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 
 	wdev->ext_reset = of_property_read_bool(dev->of_node,
 						"fsl,ext-reset-output");
+	wdev->no_ping = !of_property_read_bool(dev->of_node, "fsl,ping-during-suspend");
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
@@ -366,9 +369,11 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
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
@@ -380,11 +385,14 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
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
-- 
2.31.1

