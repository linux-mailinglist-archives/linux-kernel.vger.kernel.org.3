Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86865474F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhLOAcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhLOAcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:32:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DC8C061574;
        Tue, 14 Dec 2021 16:32:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 4CB2E1F4535F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639528337; bh=qgazptVaJjWqeQL+TdU9+7ZQpBTWcfp3FJPzSQaHDAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFATu1K2p5k3MgNey77OiaEXkYx10On4/whMUNoaBXRtDV/M8kgL/x5h9Bbbpb/Qt
         vYYoeDGJZnxCN0FgLdkKHnfE3X47iQZpm91bTUWuH+5ARvA/ErCzeSm4MvwGDbDwbk
         7M/m3wCXduFv4CvZAJc9w/cYgu9w3Z9fUtQ1aQEfvijS2vK845HTA2R7unHj5G9R9I
         IPyWKttY/2VYd8wRwOXELm2WgmSOW5jcOXCIj3bp2+FTLTMGoSMLTSrWWbh9Q3TwGI
         +sEWLrnrcQIFh7oXxY28iGNYzevNpUDRh+s7g+Yu0g9QIs2OzS9mvT8e4y7QPCa+Wy
         k4qQi2gVs7faQ==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     aisheng.dong@nxp.com, ariel.dalessandro@collabora.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com, robh@kernel.org
Subject: [PATCH v5 5/5] arm: dts: imx6ulz-bsh-smm-m2: Add BSH SMM-M2 IMX6ULZ SystemMaster
Date:   Tue, 14 Dec 2021 21:30:50 -0300
Message-Id: <20211215003050.174125-6-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
References: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add DTS of BSH SMM-M2 SystemMaster.

This version comes with:
- 128 MiB DDR3 RAM
- 256 MiB Nand
- wifi
- bluetooth

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/Makefile               |   3 +-
 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 146 +++++++++++++++++++++++
 2 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..68d6d0e6337a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -693,7 +693,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-phytec-segin-ff-rdk-nand.dtb \
 	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
 	imx6ull-phytec-segin-lc-rdk-nand.dtb \
-	imx6ulz-14x14-evk.dtb
+	imx6ulz-14x14-evk.dtb \
+	imx6ulz-bsh-smm-m2.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-aster.dtb \
diff --git a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
new file mode 100644
index 000000000000..59bcfc9a6b10
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2021 BSH Hausgeraete GmbH
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "imx6ulz.dtsi"
+
+/ {
+	model = "BSH SMM M2";
+	compatible = "bsh,imx6ulz-bsh-smm-m2", "fsl,imx6ull", "fsl,imx6ulz";
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	usdhc2_pwrseq: usdhc2-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		max-speed = <3000000>;
+		shutdown-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "peripheral";
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usdhc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wlan>;
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	cap-sdio-irq;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+	};
+};
+
+&wdog1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpmi_nand: gpmi-nand {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b099
+			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
+			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b099
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0x79		/* BT_REG_ON */
+			MX6UL_PAD_SD1_CLK__GPIO2_IO17		0x100b1		/* BT_DEV_WAKE out */
+			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x1b0b0		/* BT_HOST_WAKE in */
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17059
+			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10059
+			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17059
+			MX6UL_PAD_SD1_DATA3__GPIO2_IO21		0x79		/* WL_REG_ON */
+			MX6UL_PAD_UART2_CTS_B__GPIO1_IO22	0x100b1		/* WL_DEV_WAKE - WiFi_GPIO_4 - WiFi FW UART */
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x1b0b1		/* WL_HOST_WAKE - WIFI_GPIO_0 - OOB IRQ */
+			MX6UL_PAD_ENET1_RX_EN__OSC32K_32K_OUT	0x4001b031	/* OSC 32Khz wifi clk in */
+		>;
+	};
+};
-- 
2.30.2

