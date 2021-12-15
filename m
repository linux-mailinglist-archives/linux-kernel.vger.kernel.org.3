Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384CA474F00
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhLOAS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:18:26 -0500
Received: from finn.gateworks.com ([108.161.129.64]:35628 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235245AbhLOASZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:18:25 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mxHzr-0090fo-4m; Wed, 15 Dec 2021 00:18:15 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8m{m,n}_venice*: add gpio-line-names
Date:   Tue, 14 Dec 2021 16:18:12 -0800
Message-Id: <20211215001812.9006-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-line-names for the various GPIO's used on Gateworks Venice
boards. Note that these GPIO's are typically 'configured' in Boot
Firmware via gpio-hog therefore we only configure line names to keep the
boot firmware configuration from changing on kernel init.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mm-venice-gw71xx.dtsi   | 14 +++++++
 .../dts/freescale/imx8mm-venice-gw72xx.dtsi   | 16 ++++++++
 .../dts/freescale/imx8mm-venice-gw73xx.dtsi   | 16 ++++++++
 .../dts/freescale/imx8mm-venice-gw7901.dts    | 23 +++++++++++
 .../dts/freescale/imx8mm-venice-gw7902.dts    | 39 ++++++++++++++++++-
 .../dts/freescale/imx8mn-venice-gw7902.dts    | 39 ++++++++++++++++++-
 6 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
index 506335efc391..73addc0b8e57 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -68,6 +68,20 @@
 	status = "okay";
 };
 
+&gpio1 {
+	gpio-line-names = "", "", "", "", "", "", "pci_usb_sel", "dio0",
+		"", "dio1", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = "", "", "", "dio2", "dio3", "", "", "pci_wdis#",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index 72a3a3aa8fcd..1e7badb2a82e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -88,6 +88,22 @@
 	status = "okay";
 };
 
+&gpio1 {
+	gpio-line-names = "rs485_term", "mipi_gpio4", "", "",
+		"", "", "pci_usb_sel", "dio0",
+		"", "dio1", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = "rs485_en", "mipi_gpio3", "rs485_hd", "mipi_gpio2",
+		"mipi_gpio1", "", "", "pci_wdis#",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
index 7b00b6b5bb38..426483ec1f88 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi
@@ -108,6 +108,22 @@
 	status = "okay";
 };
 
+&gpio1 {
+	gpio-line-names = "rs485_term", "mipi_gpio4", "", "",
+		"", "", "pci_usb_sel", "dio0",
+		"", "dio1", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = "rs485_en", "mipi_gpio3", "rs485_hd", "mipi_gpio2",
+		"mipi_gpio1", "", "", "pci_wdis#",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 4bf2b97b3ef5..8710586a1d8f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -293,6 +293,29 @@
 	};
 };
 
+&gpio1 {
+	gpio-line-names = "uart1_rs422#", "", "", "uart1_rs485#",
+		"", "uart1_rs232#", "dig1_in", "dig1_out",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = "", "", "", "",
+		"", "", "uart3_rs232#", "uart3_rs422#",
+		"uart3_rs485#", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "uart4_rs485#", "", "sim1det#", "sim2det#", "";
+};
+
+&gpio5 {
+	gpio-line-names = "", "", "", "dig2_out", "dig2_in", "sim2sel", "", "",
+		"", "", "uart4_rs232#", "", "", "uart4_rs422#", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &gpu_2d {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 1b2aaf299b24..edf0c7aaaef0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -260,6 +260,43 @@
 	};
 };
 
+&gpio1 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "m2_reset", "", "m2_wdis#",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+		"uart2_en#", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names = "", "m2_gdis#", "", "", "", "", "", "m2_off#",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+		"", "", "", "amp_gpio3", "amp_gpio2", "", "amp_gpio1", "",
+		"", "", "", "", "amp_gpio4", "app_gpio1", "", "uart1_rs485",
+		"", "uart1_term", "uart1_half", "app_gpio2",
+		"mipi_gpio1", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names = "", "", "", "mipi_gpio4",
+		"mipi_gpio3", "mipi_gpio2", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -691,7 +728,7 @@
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x40000159 /* M2_GDIS# */
-			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000041 /* M2_RST# */
+			MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000041 /* M2_RESET */
 			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7	0x40000119 /* M2_OFF# */
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x40000159 /* M2_WDIS# */
 			MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14	0x40000041 /* AMP GPIO1 */
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 2d58005d20e4..3c0e63d2e82d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -255,6 +255,43 @@
 	};
 };
 
+&gpio1 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "m2_reset", "", "m2_wdis#",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+		"uart2_en#", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names = "", "m2_gdis#", "", "", "", "", "", "m2_off#",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "app_gpio1", "", "uart1_rs485",
+		"", "uart1_term", "uart1_half", "app_gpio2",
+		"mipi_gpio1", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names = "", "", "", "mipi_gpio4",
+		"mipi_gpio3", "mipi_gpio2", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &gpu {
 	status = "disabled";
 };
@@ -645,7 +682,7 @@
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x40000159 /* M2_GDIS# */
-			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000041 /* M2_RST# */
+			MX8MN_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x40000041 /* M2_RESET */
 			MX8MN_IOMUXC_NAND_DATA01_GPIO3_IO7	0x40000119 /* M2_OFF# */
 			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x40000159 /* M2_WDIS# */
 			MX8MN_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x40000041 /* APP GPIO1 */
-- 
2.17.1

