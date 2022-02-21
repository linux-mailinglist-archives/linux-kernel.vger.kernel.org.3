Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A94BE79F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354807AbiBUKdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:33:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354967AbiBUKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:33:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B54369F1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:53:31 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nM5Nb-0007AW-9u; Mon, 21 Feb 2022 10:53:15 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nM5NZ-00FUea-LD; Mon, 21 Feb 2022 10:53:13 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 4/8] ARM: dts: imx6qdl-vicut1: update gpio-line-names for some GPIOs
Date:   Mon, 21 Feb 2022 10:53:08 +0100
Message-Id: <20220221095312.3692669-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221095312.3692669-1-o.rempel@pengutronix.de>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
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

countedX lines have different board names (YACO_x). And REV_ and BOARD_ pins
have multiple functions. So, use names exposed to the OS.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index 2f6b263eea66..ec39008c0950 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -277,9 +277,9 @@ &gpio1 {
 
 &gpio2 {
 	gpio-line-names =
-		"count0", "count1", "count2", "", "", "", "", "",
-		"REV_ID0", "REV_ID1", "REV_ID2", "REV_ID3", "REV_ID4",
-			"BOARD_ID0", "BOARD_ID1", "BOARD_ID2",
+		"YACO_WHEEL", "YACO_RADAR", "YACO_PTO", "", "", "", "", "",
+		"", "LED_PWM", "", "", "",
+			"", "", "",
 		"", "", "", "", "", "", "", "ON_SWITCH",
 		"POWER_LED", "", "ECSPI2_SS0", "", "", "", "", "";
 };
@@ -298,8 +298,10 @@ &gpio4 {
 		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
 		"UART5_TXD", "UART5_RXD", "CAN1_TX", "CAN1_RX", "CAN1_SR",
 			"CAN2_SR", "CAN2_TX", "CAN2_RX",
-		"LED_DI0_DEBUG_0", "LED_DI0_DEBUG_1", "", "", "", "", "", "",
-		"", "", "", "", "BL_EN", "BL_PWM", "", "";
+		"LED_DI0_DEBUG_0", "LED_DI0_DEBUG_1", "", "", "", "ON1_CTRL",
+			"ON2_CTRL", "HITCH_IN_OUT",
+		"LIGHT_ON", "", "", "CONTACT_IN", "BL_EN", "BL_PWM", "",
+			"ISB_LED";
 };
 
 &gpio5 {
-- 
2.30.2

