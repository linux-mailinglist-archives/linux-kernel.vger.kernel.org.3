Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1C05008DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbiDNIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiDNIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:54:53 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5183689B6;
        Thu, 14 Apr 2022 01:52:15 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.124]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M5fxm-1ncCRk3oIE-007AKs;
 Thu, 14 Apr 2022 10:52:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/14] ARM: dts: imx6ull-colibri: add/update some comments
Date:   Thu, 14 Apr 2022 10:51:05 +0200
Message-Id: <20220414085106.18621-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414085106.18621-1-marcel@ziswiler.com>
References: <20220414085106.18621-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XXaby9JajJQwtpgaJGaHWRcjjJGgCdue1eDCL45J36nEh+BDvWS
 NBOgIhjU6P/6a4KgcWo0IKaYPQtQ5EgHiGLIes7B20FjMpWOxZOzlkvRYc+b7dx02AdX7IK
 BQzUc96b2DH5xFj/z8Quzj4fXELwRdPHSHeluoO/Xlq9Gc8Cp5OfgPKTxcr0J2E1Kq8R81e
 g+coe1FuTzUKeQq8GLwIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s5eunHGg6mM=:4bX+nnBvWdlNdmGnHke86r
 NS17S/lvW6ckZBVo6/94q2vfpeIUN+kiAyltwnGm2A1RIHfSifD1SEqcVLYq/HzbXR3UHSm/X
 nV3RU8KqWto5V55PeQ4omAjLgP7wteSamNQFYPO4kNCNDo+qfJjaijWJD9FubXL7m/SDZ0zGm
 XEgYl8o3F7pAp98bbHvC4GOrpw1qi+asEE85KjUdzXgLHaE9qVLPNymbRSYTCkr9STDZ+S2Zz
 0UHTHe1fD/QsgjXBmUWcaMJrdaePKK1AxmYEQzk3LYJS5PDjzMToz3KTUdA12p4O3c4Mh8Bfq
 F0FMMumXsReRZnqgqCuQ2kGKtZto050kP54FFiN2F9FoaL7dLp5e7j0iaDPqrDCEoR0qgCUDt
 1PvurBWO1OcdguRKstKciDGn70XTn2YGXTE2ObQn8bDfGnkWuYW0uNZlYDcuvqJQbKhtAgOae
 YeFBBQlNTskxROsAM4g7aYM0p8vv4LUA9AqG9kWsJ6pPhFMt6pDAgeA6+xczSvwOSwGR4lHIs
 K53hkNbCL4fOVfkdF5WVlNc9ofALgd5qsDWSZLL+cUJkv8hTMiz5igASfajLMRW8ibmOTHGTp
 smiT19A1+yHyDmmKblSF5aMul3odRiIdHVbA/XYuJv2d3O7HV2Ne574LF5vK3mp0bYqBMv2vK
 x4hzqUVv8RCln+8P1FX+GyqBz3M43H69F1UIR0AomjtSN8w1sEI4X11dSk3izfAklLrg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add/update some comments.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../dts/imx6ull-colibri-emmc-nonwifi.dtsi     |  4 ++-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 36 ++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
index 1d75bc671f75..ea238525d5c0 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-emmc-nonwifi.dtsi
@@ -8,7 +8,7 @@
 / {
 	aliases {
 		mmc0 = &usdhc2; /* eMMC */
-		mmc1 = &usdhc1; /* MMC 4bit slot */
+		mmc1 = &usdhc1; /* MMC 4-bit slot */
 	};
 
 	memory@80000000 {
@@ -154,6 +154,7 @@ &gpio5 {
 			  "SODIMM_127";
 };
 
+/* NAND */
 &gpmi {
 	status = "disabled";
 };
@@ -170,6 +171,7 @@ &iomuxc_snvs {
 	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio3>;
 };
 
+/* eMMC */
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2emmc>;
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 04384139b512..f6fbc5c0e1ee 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -6,6 +6,7 @@
 #include "imx6ull.dtsi"
 
 / {
+	/* Ethernet aliases to ensure correct MAC addresses */
 	aliases {
 		ethernet0 = &fec2;
 		ethernet1 = &fec1;
@@ -104,6 +105,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
 };
 
+/* Ethernet */
 &fec2 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet2>;
@@ -125,6 +127,7 @@ ethphy1: ethernet-phy@2 {
 	};
 };
 
+/* NAND */
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
@@ -136,6 +139,7 @@ &gpmi {
 	status = "okay";
 };
 
+/* I2C3_SDA/SCL on SODIMM 194/196 (e.g. RTC on carrier board) */
 &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
@@ -157,6 +161,10 @@ atmel_mxt_ts: touchscreen@4a {
 	};
 };
 
+/*
+ * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
+ * touch screen controller
+ */
 &i2c2 {
 	/* Use low frequency to compensate for the high pull-up values. */
 	clock-frequency = <40000>;
@@ -196,21 +204,25 @@ lcdif_out: endpoint {
 	};
 };
 
+/* PWM <A> */
 &pwm4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 };
 
+/* PWM <B> */
 &pwm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm5>;
 };
 
+/* PWM <C> */
 &pwm6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm6>;
 };
 
+/* PWM <D> */
 &pwm7 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm7>;
@@ -224,6 +236,7 @@ &snvs_pwrkey {
 	status = "disabled";
 };
 
+/* Colibri UART_A */
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1>;
@@ -231,6 +244,7 @@ &uart1 {
 	fsl,dte-mode;
 };
 
+/* Colibri UART_B */
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -238,12 +252,14 @@ &uart2 {
 	fsl,dte-mode;
 };
 
+/* Colibri UART_C */
 &uart5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5>;
 	fsl,dte-mode;
 };
 
+/* Colibri USBC */
 &usbotg1 {
 	dr_mode = "otg";
 	srp-disable;
@@ -251,10 +267,12 @@ &usbotg1 {
 	adp-disable;
 };
 
+/* Colibri USBH */
 &usbotg2 {
 	dr_mode = "host";
 };
 
+/* Colibri MMC/SD */
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
@@ -265,7 +283,7 @@ &usdhc1 {
 	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
 	assigned-clock-rates = <0>, <198000000>;
 	bus-width = <4>;
-	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>; /* MMC_CD */
 	disable-wp;
 	keep-power-in-suspend;
 	no-1-8-v;
@@ -431,7 +449,7 @@ MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0xb0b0 /* SODIMM 63 */
 
 	/*
 	 * With an eMMC instead of a raw NAND device the following pins
-	 * are available at SODIMM pins
+	 * are available at SODIMM pins.
 	 */
 	pinctrl_gpmi_gpio: gpmi-gpio-grp {
 		fsl,pins = <
@@ -556,10 +574,10 @@ MX6UL_PAD_UART1_CTS_B__UART1_DTE_RTS	0x1b0b1	/* SODIMM 25 */
 
 	pinctrl_uart1_ctrl1: uart1-ctrl1-grp { /* Additional DTR, DCD */
 		fsl,pins = <
-			MX6UL_PAD_JTAG_TDI__GPIO1_IO13		0x70a0 /* SODIMM 31 */
-			MX6UL_PAD_LCD_DATA18__GPIO3_IO23	0x10b0 /* SODIMM 29 */
-			MX6UL_PAD_JTAG_TDO__GPIO1_IO12		0x90b1 /* SODIMM 23 */
-			MX6UL_PAD_LCD_DATA19__GPIO3_IO24        0x10b0 /* SODIMM 37 */
+			MX6UL_PAD_JTAG_TDI__GPIO1_IO13		0x70a0 /* SODIMM 31 / DCD */
+			MX6UL_PAD_LCD_DATA18__GPIO3_IO23	0x10b0 /* SODIMM 29 / DSR */
+			MX6UL_PAD_JTAG_TDO__GPIO1_IO12		0x90b1 /* SODIMM 23 / DTR */
+			MX6UL_PAD_LCD_DATA19__GPIO3_IO24        0x10b0 /* SODIMM 37 / RI */
 		>;
 	};
 
@@ -580,7 +598,7 @@ MX6UL_PAD_GPIO1_IO05__UART5_DTE_TX	0x1b0b1 /* SODIMM 21 */
 
 	pinctrl_usbh_reg: gpio-usbh-reg {
 		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x10b0 /* SODIMM 129 */
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x10b0 /* SODIMM 129 / USBH_PEN */
 		>;
 	};
 
@@ -658,7 +676,7 @@ pinctrl_snvs_gpio1: snvs-gpio1-grp {
 			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x110a0	/* SODIMM 93 */
 			MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x110a0	/* SODIMM 95 */
 			MX6ULL_PAD_BOOT_MODE0__GPIO5_IO10	0x1b0a0	/* SODIMM 105 */
-			MX6ULL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x0b0a0	/* SODIMM 131 */
+			MX6ULL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x0b0a0	/* SODIMM 131 / USBH_OC */
 			MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x110a0	/* SODIMM 138 */
 		>;
 	};
@@ -695,7 +713,7 @@ MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x130a0	/* SODIMM 45 */
 
 	pinctrl_snvs_usdhc1_cd: snvs-usdhc1-cd-grp {
 		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0a0 /* SODIMM 43 */
+			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0a0 /* SODIMM 43 / MMC_CD */
 		>;
 	};
 
-- 
2.35.1

