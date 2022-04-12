Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3274FD78A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390891AbiDLJZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355524AbiDLIKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:10:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71262B852
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:40:20 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1neB8A-0007gD-Ln; Tue, 12 Apr 2022 09:40:06 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1neB89-00AQZB-9n; Tue, 12 Apr 2022 09:40:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v1 04/17] arm: dts: imx6qdl-vicut1/victgo: Remove UART2
Date:   Tue, 12 Apr 2022 09:39:51 +0200
Message-Id: <20220412074004.2485264-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412074004.2485264-1-o.rempel@pengutronix.de>
References: <20220412074004.2485264-1-o.rempel@pengutronix.de>
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

Only first prototype had UART2 and there are no plans to add it in the
future.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-victgo.dts   | 13 -------------
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 15 ---------------
 2 files changed, 28 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 7dd7fb165432..9cf4df3eaeb0 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -616,12 +616,6 @@ &uart1 {
 	status = "okay";
 };
 
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
@@ -905,13 +899,6 @@ MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA		0x1b0b1
 		>;
 	};
 
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D26__UART2_TX_DATA		0x1b0b1
-			MX6QDL_PAD_EIM_D27__UART2_RX_DATA		0x1b0b1
-		>;
-	};
-
 	/* YaCO Touchscreen UART */
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index b126ef4d5255..ea474aa93485 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -463,12 +463,6 @@ &uart1 {
 	status = "okay";
 };
 
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
@@ -728,15 +722,6 @@ MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA		0x1b0b1
 		>;
 	};
 
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D26__UART2_RX_DATA		0x1b0b1
-			MX6QDL_PAD_EIM_D27__UART2_TX_DATA		0x1b0b1
-			MX6QDL_PAD_EIM_D28__UART2_DTE_CTS_B		0x1b0b1
-			MX6QDL_PAD_EIM_D29__UART2_DTE_RTS_B		0x1b0b1
-		>;
-	};
-
 	/* YaCO Touchscreen UART */
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-- 
2.30.2

