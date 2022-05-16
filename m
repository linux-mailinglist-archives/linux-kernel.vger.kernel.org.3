Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDDA5285F5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiEPNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244071AbiEPNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:50:09 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D4B3B298;
        Mon, 16 May 2022 06:49:14 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M7ZR3-1neGmD2tfT-00xGNg;
 Mon, 16 May 2022 15:48:59 +0200
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
Subject: [PATCH v2 17/24] ARM: dts: imx7-colibri: add clarifying comments
Date:   Mon, 16 May 2022 15:47:27 +0200
Message-Id: <20220516134734.493065-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:neDi+m+pTaHKB2Q8oXHn1HXiJ2Sh1YhU4lBwqzZfvhta0xeodEb
 95h9Yn7W0GcTF26H8zfeYD+273pnS5QUajhlHMNmyVbuTbTUQyd0M1tHp2fzdDEFThBaMPN
 C2V8FqJuBWO3u4XNzz9jle+ZIrGp4kHCwztvtkCWcq+n6DIYKKhz5kRWtUi0uPXWOER9NZ/
 gAN+V4WCxeTeuGOTe7IlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NQTn592N0wA=:LdOamR4YUaMo6/1hrlFhAR
 MaJN3dGDxNBsGlg0SmcOckzn8/R1Nz3RXtFThDwk+ImyD0xcwLHUpoZzqOmizzzKfLMrfJr2a
 R28wY8kzxAVkxC3UX37Ei5BYTB3dbD73PpHQ8Y4Dz4o9LPE+xc4NAi8tzNdG4j7W9uhSkH8hd
 Swdk8qw5yeuXHDSVQtP8u6z/7nCERLhtEhf2lqeTe8cGoVa4AuAVsOWKmUakFuXxzy4/EZeBz
 WqF3/0LDjsOh3tm9EhvZhyyM0zbTnCWfCz0sD0YYjj6fGj2uc+D7Muu6wTvOq8gEL68cpvQgS
 wVrd0y5f34vmVOVPV6QPYwPiKGI57oiEsCmuegjfg1dz7HW4gzv5A/SV3khqJcXPbse1PGszG
 vdnjvQ06D1/a3xqDT5tcMgyr6xH0iUdmRXaLYMewkrOnAdRj6PR4pRStT2WVbKW+3Qvn1X1y6
 WRuoLz2B2Pugks9wADq691/atO+QF+ndZX2tFa81xuIeR4J8i3gam87u3KGBx42OemFGDQkN5
 0cS6b6Adw4yyp5ebegowsnyFN45W4JVaFxsyG/uK69+eIAQb5pAFFJL3InIYrt8Pck9hNVkTp
 eqikEXH9rqb95E+f+r0+Rg973M/j/6QIn/xqNWR9Qd3fBH0ncTKfC5ukymtLXWPFOjoSBSMoB
 F17MISBk3LiQpKyBkWETvl8mFHr0S2TywNcVp3QmcRzu3VTixVX71jw9n2BBt8kziqlX0czk1
 ad/qETEpqcihz0PH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

- Add clarifying comments.
- Remove spurious new line.
- Add required new line.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri-aster.dtsi     |  11 ++
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi   |  15 ++
 arch/arm/boot/dts/imx7-colibri.dtsi           | 140 ++++++++++--------
 arch/arm/boot/dts/imx7d-colibri-aster.dts     |   2 +-
 .../arm/boot/dts/imx7d-colibri-emmc-aster.dts |   1 +
 .../boot/dts/imx7d-colibri-emmc-eval-v3.dts   |   1 +
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi     |   2 +
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts   |   5 +
 arch/arm/boot/dts/imx7d-colibri.dtsi          |   2 +
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts   |   4 +
 arch/arm/boot/dts/imx7s-colibri.dtsi          |   1 +
 11 files changed, 121 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index 117965705814..fa488a6de0d4 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2017-2022 Toradex
  */
 
+/* Colibri AD0 to AD3 */
 &adc1 {
 	status = "okay";
 };
@@ -17,26 +18,32 @@ &gpio4 22 GPIO_ACTIVE_LOW /* SODIMM 85 / already muxed pinctrl_gpio2 as SPI_CE1_
 	status = "okay";
 };
 
+/* Colibri Fast Ethernet */
 &fec1 {
 	status = "okay";
 };
 
+/* Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 */
 &i2c4 {
 	status = "okay";
 };
 
+/* Colibri PWM<A> */
 &pwm1 {
 	status = "okay";
 };
 
+/* Colibri PWM<B> */
 &pwm2 {
 	status = "okay";
 };
 
+/* Colibri PWM<C> */
 &pwm3 {
 	status = "okay";
 };
 
+/* Colibri PWM<D> */
 &pwm4 {
 	status = "okay";
 };
@@ -46,18 +53,22 @@ &rtc {
 	status = "okay";
 };
 
+/* Colibri UART_A */
 &uart1 {
 	status = "okay";
 };
 
+/* Colibri UART_B */
 &uart2 {
 	status = "okay";
 };
 
+/* Colibri UART_C */
 &uart3 {
 	status = "okay";
 };
 
+/* Colibri USBC */
 &usbotg1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 6ae38c1f38d4..441331b09fb4 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -12,6 +12,7 @@ clk16m: clk16m {
 	};
 };
 
+/* Colibri AD0 to AD3 */
 &adc1 {
 	status = "okay";
 };
@@ -28,6 +29,7 @@ &atmel_mxt_ts {
 	status = "disabled";
 };
 
+/* Colibri SSP */
 &ecspi3 {
 	status = "okay";
 
@@ -46,26 +48,34 @@ mcp2515: can@0 {
 	};
 };
 
+/* Colibri Fast Ethernet */
 &fec1 {
 	status = "okay";
 };
 
+/* Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 */
 &i2c4 {
 	status = "okay";
 };
 
+/* Colibri PWM<A> */
 &pwm1 {
 	status = "okay";
 };
 
+/* Colibri PWM<B> */
 &pwm2 {
+	/* The pwm2 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
 	status = "okay";
 };
 
+/* Colibri PWM<C> */
 &pwm3 {
+	/* The pwm3 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
 	status = "okay";
 };
 
+/* Colibri PWM<D> */
 &pwm4 {
 	status = "okay";
 };
@@ -75,22 +85,27 @@ &rtc {
 	status = "okay";
 };
 
+/* Colibri UART_A */
 &uart1 {
 	status = "okay";
 };
 
+/* Colibri UART_B */
 &uart2 {
 	status = "okay";
 };
 
+/* Colibri UART_C */
 &uart3 {
 	status = "okay";
 };
 
+/* Colibri USBC */
 &usbotg1 {
 	status = "okay";
 };
 
+/* Colibri MMC/SD */
 &usdhc1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 0fc4b33d97be..4416b7befbfe 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -122,6 +122,7 @@ sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,bitclock-master = <&dailink_master>;
 		simple-audio-card,frame-master = <&dailink_master>;
+
 		simple-audio-card,cpu {
 			sound-dai = <&sai1>;
 		};
@@ -133,6 +134,7 @@ dailink_master: simple-audio-card,codec {
 	};
 };
 
+/* Colibri AD0 to AD3 */
 &adc1 {
 	vref-supply = <&reg_DCDC3>;
 };
@@ -146,12 +148,14 @@ &cpu0 {
 	cpu-supply = <&reg_DCDC2>;
 };
 
+/* Colibri SSP */
 &ecspi3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
-	cs-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>; /* SODIMM 86 / SSPFRM */
 };
 
+/* Colibri Fast Ethernet */
 &fec1 {
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
@@ -174,6 +178,7 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		/* Micrel KSZ8041RNL */
 		ethphy0: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			max-speed = <100>;
@@ -373,6 +378,7 @@ &gpio7 {
 			  "SODIMM_137";
 };
 
+/* NAND on such SKUs */
 &gpmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
@@ -381,6 +387,7 @@ &gpmi {
 	nand-ecc-mode = "hw";
 };
 
+/* On-module Power I2C */
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
@@ -388,7 +395,6 @@ &i2c1 {
 	pinctrl-1 = <&pinctrl_i2c1_recovery &pinctrl_i2c1_int>;
 	scl-gpios = <&gpio1 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio1 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
 	status = "okay";
 
 	codec: sgtl5000@a {
@@ -488,6 +494,7 @@ reg_LDO5: LDO5 { /* PWR_EN_+V3.3 */
 	};
 };
 
+/* Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 */
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
@@ -532,28 +539,32 @@ lcdif_out: endpoint {
 	};
 };
 
+/* Colibri PWM<A> */
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 };
 
+/* Colibri PWM<B> */
 &pwm2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 };
 
+/* Colibri PWM<C> */
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 };
 
+/* Colibri PWM<D> */
 &pwm4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 };
 
 &reg_1p0d {
-	vin-supply = <&reg_DCDC3>;
+	vin-supply = <&reg_DCDC3>; /* VDDA_1P8_IN */
 };
 
 &sai1 {
@@ -562,6 +573,7 @@ &sai1 {
 	status = "okay";
 };
 
+/* Colibri UART_A */
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1 &pinctrl_uart1_ctrl2>;
@@ -571,6 +583,7 @@ &uart1 {
 	fsl,dte-mode;
 };
 
+/* Colibri UART_B */
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -580,6 +593,7 @@ &uart2 {
 	fsl,dte-mode;
 };
 
+/* Colibri UART_C */
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
@@ -588,6 +602,7 @@ &uart3 {
 	fsl,dte-mode;
 };
 
+/* Colibri USBC */
 &usbotg1 {
 	dr_mode = "otg";
 	extcon = <0>, <&extcon_usbc_det>;
@@ -608,6 +623,7 @@ &usdhc1 {
 	wakeup-source;
 };
 
+/* eMMC on 1GB (eMMC) SKUs */
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
@@ -778,15 +794,15 @@ MX7D_PAD_SD2_WP__GPIO5_IO10			0x0
 
 	pinctrl_ecspi3_cs: ecspi3-cs-grp {
 		fsl,pins = <
-			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14 /* SODIMM 86 */
 		>;
 	};
 
 	pinctrl_ecspi3: ecspi3-grp {
 		fsl,pins = <
-			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2
-			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2
-			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2
+			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2 /* SODIMM 90 */
+			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2 /* SODIMM 92 */
+			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2 /* SODIMM 88 */
 		>;
 	};
 
@@ -831,8 +847,8 @@ MX7D_PAD_SD3_DATA7__NAND_DATA07		0x71
 
 	pinctrl_i2c4: i2c4-grp {
 		fsl,pins = <
-			MX7D_PAD_ENET1_RGMII_TD3__I2C4_SDA	0x4000007f
-			MX7D_PAD_ENET1_RGMII_TD2__I2C4_SCL	0x4000007f
+			MX7D_PAD_ENET1_RGMII_TD3__I2C4_SDA	0x4000007f /* SODIMM 194 */
+			MX7D_PAD_ENET1_RGMII_TD2__I2C4_SCL	0x4000007f /* SODIMM 196 */
 		>;
 	};
 
@@ -845,44 +861,44 @@ MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9	0x4000007f
 
 	pinctrl_lcdif_dat: lcdif-dat-grp {
 		fsl,pins = <
-			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
-			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
-			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
-			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
-			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
-			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
-			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
-			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
-			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
-			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
-			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
-			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
-			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
-			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
-			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
-			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
-			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
-			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79 /* SODIMM 76 */
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79 /* SODIMM 70 */
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79 /* SODIMM 60 */
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79 /* SODIMM 58 */
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79 /* SODIMM 78 */
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79 /* SODIMM 72 */
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79 /* SODIMM 80 */
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79 /* SODIMM 46 */
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79 /* SODIMM 62 */
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79 /* SODIMM 48 */
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79 /* SODIMM 74 */
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79 /* SODIMM 50 */
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79 /* SODIMM 52 */
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79 /* SODIMM 54 */
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79 /* SODIMM 66 */
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79 /* SODIMM 64 */
+			MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79 /* SODIMM 57 */
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79 /* SODIMM 61 */
 		>;
 	};
 
 	pinctrl_lcdif_dat_24: lcdif-dat-24-grp {
 		fsl,pins = <
-			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
-			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
-			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
-			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
-			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
-			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79 /* SODIMM 136 */
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79 /* SODIMM 138 */
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79 /* SODIMM 140 */
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79 /* SODIMM 142 */
+			MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79 /* SODIMM 144 */
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79 /* SODIMM 146 */
 		>;
 	};
 
 	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
 		fsl,pins = <
-			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
-			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
-			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
-			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79 /* SODIMM 56 */
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79 /* SODIMM 44 */
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79 /* SODIMM 82 */
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79 /* SODIMM 68 */
 		>;
 	};
 
@@ -897,70 +913,70 @@ MX7D_PAD_EPDC_DATA13__GPIO2_IO13        0x14 /* SODIMM 95 */
 
 	pinctrl_pwm1: pwm1-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79
-			MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x4
+			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79 /* SODIMM 59 */
+			MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x4  /* SODIMM 59 */
 		>;
 	};
 
 	pinctrl_pwm2: pwm2-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO09__PWM2_OUT		0x79
+			MX7D_PAD_GPIO1_IO09__PWM2_OUT		0x79 /* SODIMM 28 */
 		>;
 	};
 
 	pinctrl_pwm3: pwm3-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO10__PWM3_OUT		0x79
+			MX7D_PAD_GPIO1_IO10__PWM3_OUT		0x79 /* SODIMM 30 */
 		>;
 	};
 
 	pinctrl_pwm4: pwm4-grp {
 		fsl,pins = <
-			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x79
-			MX7D_PAD_ECSPI2_SCLK__GPIO4_IO20	0x4
+			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x79 /* SODIMM 67 */
+			MX7D_PAD_ECSPI2_SCLK__GPIO4_IO20	0x4  /* SODIMM 67 */
 		>;
 	};
 
 	pinctrl_uart1: uart1-grp {
 		fsl,pins = <
-			MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX	0x79
-			MX7D_PAD_UART1_RX_DATA__UART1_DTE_TX	0x79
-			MX7D_PAD_SAI2_TX_BCLK__UART1_DTE_CTS	0x79
-			MX7D_PAD_SAI2_TX_SYNC__UART1_DTE_RTS	0x79
+			MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX	0x79 /* SODIMM 33 */
+			MX7D_PAD_UART1_RX_DATA__UART1_DTE_TX	0x79 /* SODIMM 35 */
+			MX7D_PAD_SAI2_TX_BCLK__UART1_DTE_CTS	0x79 /* SODIMM 25 */
+			MX7D_PAD_SAI2_TX_SYNC__UART1_DTE_RTS	0x79 /* SODIMM 27 */
 		>;
 	};
 
 	pinctrl_uart1_ctrl1: uart1-ctrl1-grp {
 		fsl,pins = <
-			MX7D_PAD_SD2_DATA1__GPIO5_IO15		0x14 /* DCD */
-			MX7D_PAD_SD2_DATA0__GPIO5_IO14		0x14 /* DTR */
+			MX7D_PAD_SD2_DATA1__GPIO5_IO15		0x14 /* SODIMM 31 / DCD */
+			MX7D_PAD_SD2_DATA0__GPIO5_IO14		0x14 /* SODIMM 23 / DTR */
 		>;
 	};
 
 	pinctrl_uart2: uart2-grp {
 		fsl,pins = <
-			MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX 0x79
-			MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX 0x79
-			MX7D_PAD_SAI2_RX_DATA__UART2_DTE_RTS 0x79
-			MX7D_PAD_SAI2_TX_DATA__UART2_DTE_CTS 0x79
+			MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX	0x79 /* SODIMM 36 */
+			MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX	0x79 /* SODIMM 38 */
+			MX7D_PAD_SAI2_RX_DATA__UART2_DTE_RTS	0x79 /* SODIMM 32 / CTS */
+			MX7D_PAD_SAI2_TX_DATA__UART2_DTE_CTS	0x79 /* SODIMM 34 / RTS */
 		>;
 	};
 	pinctrl_uart3: uart3-grp {
 		fsl,pins = <
-			MX7D_PAD_UART3_TX_DATA__UART3_DTE_RX 0x79
-			MX7D_PAD_UART3_RX_DATA__UART3_DTE_TX 0x79
+			MX7D_PAD_UART3_TX_DATA__UART3_DTE_RX	0x79 /* SODIMM 19 */
+			MX7D_PAD_UART3_RX_DATA__UART3_DTE_TX	0x79 /* SODIMM 21 */
 		>;
 	};
 
 	pinctrl_usbc_det: gpio-usbc-det {
 		fsl,pins = <
-			MX7D_PAD_ENET1_CRS__GPIO7_IO14	0x14
+			MX7D_PAD_ENET1_CRS__GPIO7_IO14		0x14 /* SODIMM 137 / USBC_DET */
 		>;
 	};
 
 	pinctrl_usbh_reg: gpio-usbh-vbus {
 		fsl,pins = <
-			MX7D_PAD_UART3_CTS_B__GPIO4_IO7	0x14 /* SODIMM 129 USBH PEN */
+			MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14 /* SODIMM 129 / USBH_PEN */
 		>;
 	};
 
@@ -1079,14 +1095,14 @@ &iomuxc_lpsr {
 
 	pinctrl_gpio_lpsr: gpio1-grp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x59
-			MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3	0x59
+			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x59 /* SODIMM 135 */
+			MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3	0x59 /* SODIMM 22 */
 		>;
 	};
 
 	pinctrl_gpiokeys: gpiokeysgrp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x19
+			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x19 /* SODIMM 45 / WAKE_UP */
 		>;
 	};
 
@@ -1118,8 +1134,8 @@ MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x0
 
 	pinctrl_uart1_ctrl2: uart1-ctrl2-grp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x14 /* DSR */
-			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14 /* RI */
+			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x14 /* SODIMM 29 / DSR */
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14 /* SODIMM 37 / RI */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-aster.dts b/arch/arm/boot/dts/imx7d-colibri-aster.dts
index cfd75e3424fa..90aaeddfb4f6 100644
--- a/arch/arm/boot/dts/imx7d-colibri-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-aster.dts
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2017-2022 Toradex
- *
  */
 
 /dts-v1/;
@@ -35,6 +34,7 @@ &panel_dpi {
 	status = "okay";
 };
 
+/* Colibri USBH */
 &usbotg2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
index 7b4451699478..3ec9ef6baaa4 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
@@ -16,6 +16,7 @@ / {
 		     "fsl,imx7d";
 };
 
+/* Colibri USBH */
 &usbotg2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
index 3e84018392ee..6d505cb02aad 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
@@ -15,6 +15,7 @@ / {
 		     "fsl,imx7d";
 };
 
+/* Colibri USBH */
 &usbotg2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 2b4be7646631..2fb4d2133a1b 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -49,11 +49,13 @@ &gpio6 {
 			  "SODIMM_34";
 };
 
+/* Colibri USBH */
 &usbotg2 {
 	dr_mode = "host";
 	vbus-supply = <&reg_usbh_vbus>;
 };
 
+/* eMMC */
 &usdhc3 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
index 7aabe5691459..c7a8b5aa2408 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -38,14 +38,19 @@ &panel_dpi {
 	status = "okay";
 };
 
+/* Colibri PWM<B> */
 &pwm2 {
+	/* The pwm2 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
 	status = "okay";
 };
 
+/* Colibri PWM<C> */
 &pwm3 {
+	/* The pwm3 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
 	status = "okay";
 };
 
+/* Colibri USBH */
 &usbotg2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index d1469aa8b025..531a45b176a1 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -23,10 +23,12 @@ &cpu1 {
 	cpu-supply = <&reg_DCDC2>;
 };
 
+/* NAND */
 &gpmi {
 	status = "okay";
 };
 
+/* Colibri USBH */
 &usbotg2 {
 	dr_mode = "host";
 	vbus-supply = <&reg_usbh_vbus>;
diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
index 6589c4179177..38de76630d6a 100644
--- a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
@@ -38,10 +38,14 @@ &panel_dpi {
 	status = "okay";
 };
 
+/* Colibri PWM<B> */
 &pwm2 {
+	/* The pwm2 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
 	status = "okay";
 };
 
+/* Colibri PWM<C> */
 &pwm3 {
+	/* The pwm3 should be disabled to enable atmel_mxt_ts touchscreen for adapter. */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
index 2ce102b7f5d4..ef51395d3537 100644
--- a/arch/arm/boot/dts/imx7s-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -13,6 +13,7 @@ memory@80000000 {
 	};
 };
 
+/* NAND */
 &gpmi {
 	status = "okay";
 };
-- 
2.35.1

