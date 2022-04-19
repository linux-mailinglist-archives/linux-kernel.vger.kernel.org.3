Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3187450637C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiDSEvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348343AbiDSEv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E72F3A9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:47 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002uQ-Fw; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047Pw-EZ; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 01/17] ARM: dts: imx6qdl-vicut1.dtsi: remove TiWi module
Date:   Tue, 19 Apr 2022 06:48:08 +0200
Message-Id: <20220419044824.981747-2-o.rempel@pengutronix.de>
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

Only the first prototypes had a TiWi module. There is no publicly available
hardware where this module is fitted and there are no plan to produce
any.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi | 51 ---------------------------
 1 file changed, 51 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
index ec39008c0950..fe2685642bf1 100644
--- a/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-vicut1.dtsi
@@ -144,18 +144,6 @@ reg_otg_vbus: regulator-otg-vbus {
 		enable-active-high;
 	};
 
-	reg_wifi: regulator-wifi {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_wifi_npd>;
-		regulator-name = "wifi";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <70000>;
-	};
-
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "prti6q-sgtl5000";
@@ -530,26 +518,6 @@ &usdhc1 {
 	status = "okay";
 };
 
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2>;
-	vmmc-supply = <&reg_wifi>;
-	non-removable;
-	cap-power-off-card;
-	keep-power-in-suspend;
-	no-1-8-v;
-	no-mmc;
-	no-sd;
-	status = "okay";
-
-	wifi {
-		compatible = "ti,wl1271";
-		interrupts-extended = <&gpio1 30 IRQ_TYPE_LEVEL_HIGH>;
-		ref-clock-frequency = "38400000";
-		tcxo-clock-frequency = "19200000";
-	};
-};
-
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -808,19 +776,6 @@ MX6QDL_PAD_GPIO_1__GPIO1_IO01			0x1b0b0
 		>;
 	};
 
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD2_CMD__SD2_CMD			0x170b9
-			MX6QDL_PAD_SD2_CLK__SD2_CLK			0x100b9
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x170b9
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x170b9
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x170b9
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x170b9
-			/* WL12xx IRQ */
-			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30		0x10880
-		>;
-	};
-
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17099
@@ -836,10 +791,4 @@ MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17099
 			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
 		>;
 	};
-
-	pinctrl_wifi_npd: wifinpdgrp {
-		fsl,pins = <
-			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26		0x1b8b0
-		>;
-	};
 };
-- 
2.30.2

