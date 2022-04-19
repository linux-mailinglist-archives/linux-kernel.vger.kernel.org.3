Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE631506379
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348401AbiDSEvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348351AbiDSEva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D61C2FE4C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:48 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002uW-FN; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047Qo-KO; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 07/17] ARM: dts: imx6qdl-vicut1.dtsi: Update GPIO line names
Date:   Tue, 19 Apr 2022 06:48:14 +0200
Message-Id: <20220419044824.981747-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419044824.981747-1-o.rempel@pengutronix.de>
References: <20220419044824.981747-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

Add some missing names and remove names to pins that have never been used
and/or are not present on any hardware.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index a5f962f1028b..a93e7f8302aa 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -257,12 +257,10 @@ &gpio1 {
 	gpio-line-names =
 		"CAN1_TERM", "SD1_CD", "ITU656_RESET", "CAM1_MIRROR",
 			"CAM2_MIRROR", "", "", "SMBALERT",
-		"DEBUG_0", "DEBUG_1", "SDIO_SCK", "SDIO_CMD", "SDIO_D3",
-			"SDIO_D2", "SDIO_D1", "SDIO_D0",
+		"DEBUG_0", "DEBUG_1", "", "", "", "", "", "",
 		"SD1_DATA0", "SD1_DATA1", "SD1_CMD", "SD1_DATA2", "SD1_CLK",
-			"SD1_DATA3", "", "",
-		"", "ETH_RESET", "WIFI_PD", "WIFI_BT_RST", "ETH_INT", "",
-			"WL_IRQ", "ETH_MDC";
+			"SD1_DATA3", "ETH_MDIO", "",
+		"", "ETH_RESET", "", "", "ETH_INT", "", "", "ETH_MDC";
 };
 
 &gpio2 {
@@ -270,8 +268,8 @@ &gpio2 {
 		"YACO_WHEEL", "YACO_RADAR", "YACO_PTO", "", "", "", "", "",
 		"", "LED_PWM", "", "", "",
 			"", "", "",
-		"", "", "", "", "", "", "", "ON_SWITCH",
-		"POWER_LED", "", "ECSPI2_SS0", "", "", "", "", "";
+		"", "", "", "", "", "ISB_IN2", "ISB_nIN1", "ON_SWITCH",
+		"POWER_LED", "", "", "", "", "", "", "";
 };
 
 &gpio3 {
@@ -280,7 +278,8 @@ &gpio3 {
 		"", "", "", "", "", "", "", "",
 		"ECSPI1_SCLK", "ECSPI1_MISO", "ECSPI1_MOSI", "ECSPI1_SS1",
 			"CPU_ON1_FB", "USB_OTG_OC", "USB_OTG_PWR", "YACO_IRQ",
-		"", "", "", "", "", "", "", "";
+		"TSS_TXD", "TSS_RXD", "", "", "", "", "YACO_BOOT0",
+			"YACO_RESET";
 };
 
 &gpio4 {
@@ -288,8 +287,8 @@ &gpio4 {
 		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
 		"UART5_TXD", "UART5_RXD", "CAN1_TX", "CAN1_RX", "CAN1_SR",
 			"CAN2_SR", "CAN2_TX", "CAN2_RX",
-		"LED_DI0_DEBUG_0", "LED_DI0_DEBUG_1", "", "", "", "ON1_CTRL",
-			"ON2_CTRL", "HITCH_IN_OUT",
+		"", "", "DIP1_FB", "", "VCAM_EN", "ON1_CTRL", "ON2_CTRL",
+			"HITCH_IN_OUT",
 		"LIGHT_ON", "", "", "CONTACT_IN", "BL_EN", "BL_PWM", "",
 			"ISB_LED";
 };
-- 
2.30.2

