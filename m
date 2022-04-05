Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406A14F51CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847274AbiDFCRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiDEUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:21:50 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2200D6D3BD;
        Tue,  5 Apr 2022 13:02:33 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nbpNh-00CFJb-3P; Tue, 05 Apr 2022 20:02:25 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8m{m,n}-venice-*: add missing uart-has-rtscts property to UARTs
Date:   Tue,  5 Apr 2022 13:02:23 -0700
Message-Id: <20220405200223.18384-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing 'uart-has-rtscts' property to UART's that have hardware
flow control capability.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts  | 3 +++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts  | 3 +++
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts  | 1 +
 4 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
index 426483ec1f88..7a5d45e80982 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
@@ -221,6 +221,7 @@
 	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_bten>;
 	cts-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
 	rts-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 
 	bluetooth {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index ee78c189c556..a23801deb4cd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -716,6 +716,7 @@
 	dtr-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 	dsr-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
 	dcd-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 };
 
@@ -731,6 +732,7 @@
 	pinctrl-0 = <&pinctrl_uart3>;
 	cts-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
 	rts-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 };
 
@@ -739,6 +741,7 @@
 	pinctrl-0 = <&pinctrl_uart4>;
 	cts-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
 	rts-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 49e15a671b67..6aa0eb463647 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -644,6 +644,7 @@
 	pinctrl-0 = <&pinctrl_uart1>;
 	rts-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
 	cts-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 };
 
@@ -660,6 +661,7 @@
 	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_uart3_gpio>;
 	rts-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 	cts-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 
 	bluetooth {
@@ -677,6 +679,7 @@
 	dtr-gpios = <&gpio4 3 GPIO_ACTIVE_LOW>;
 	dsr-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
 	dcd-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 3c0e63d2e82d..2c1f591335ad 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -625,6 +625,7 @@
 	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_uart3_gpio>;
 	rts-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 	cts-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
 	status = "okay";
 
 	bluetooth {
-- 
2.17.1

