Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B4350637E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbiDSEwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348357AbiDSEva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916222F39C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:49 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmx-0002uT-KM; Tue, 19 Apr 2022 06:48:31 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047QN-HS; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 04/17] ARM: dts: imx6qdl-vicut1/victgo: Remove UART2
Date:   Tue, 19 Apr 2022 06:48:11 +0200
Message-Id: <20220419044824.981747-5-o.rempel@pengutronix.de>
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

