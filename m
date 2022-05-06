Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3470851D914
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392591AbiEFN37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392606AbiEFN3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:29:01 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AA5193;
        Fri,  6 May 2022 06:25:17 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LqBHC-1oHuzW2hrU-00do03;
 Fri, 06 May 2022 15:25:03 +0200
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
Subject: [PATCH v3 13/13] ARM: dts: imx6ull-colibri: improve pinctrl node names
Date:   Fri,  6 May 2022 15:24:16 +0200
Message-Id: <20220506132416.273965-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tRLEt5KRAA5DyaTZ1wVXIj5nAvNNikzNfvudQtmSfN9J8qhom8U
 zVlS2+n1awxkbPmaJlb6b6XfJsFoStqtyLf2Y1aKf7D1HuRmvd5e3/xi79YF9u2js7Uo8Sj
 dSRGAH1GEh+zqfT+h2Eh6tcOCfj/jphNdpSYyiWFKQEERhYhlEkp+SRAR29t7IyV+rCupc2
 p3+gk3uYOUU9dJmyokXiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tbbC5en0/DQ=:0qIjDmZgnYUbc6I6ebWVgi
 e+ivx1af6A8uaQqrlKNjheZZOY+zfk8QHkjV/9nTG5PdnKo09AUmdR/g8FDgRmUHrTPZe2Ssb
 5N9VC5fQYAm3JcHLmHBJaoeJtwC/9TgnMjfG63kEqmaITd4dpSHtPBOTXnwp8W7fZDgkA7kh7
 aXyFKFik4iA42w4oHPyRjyznnUcc9Q2vhUdp2XpIETEA/JZY1zAE4YR5z+nalRSSNRx3XfwY/
 2SmcIsSl77qpOMBOvslEf/Ipbo0dV9CaQEpa+ee+BGeuaoc7BnGCkeEqgmHVepKERmlPz5afM
 yluqBQUZD88QgEbLCcyXcqXMTtFWkYzu5Ui4wKigo3aL2Dc9DWHIVX5V9iWmSiXOzorr5+OQd
 7b+yR4K7e/x7s1Lsdn3GQnZuzg100oFQhP9llzPBD+OZAmtCqGkXPdj3ay6xemP19E3hsQB3J
 6aMWu692fUxaZiGXuimkxmA/a5DgWcDmL4AS3/olt27umB74lXElxhlPlJRw9KYOZvQDC+Y5F
 sdeM4X5StecL2fSYyIgQdebIPuUIPqxp50oHk9rB56B17J+FxPM6iXJzm0lsJJYuPTvGEdeFr
 TRgEEBBLeUz/e2cpe2ymycIvFlsW+sjCeoDsjyIevPdmLeatSqD4rNDQfgXemW96TVIZ2xbfv
 SBSk8R+c9i1vOj3rhLCcq+Y0rYm52z2ijYJnIHjgjyMiEwrq9ZrgQckEcPWW56BbYOi90S71T
 cP5d40kHrvHOuB9o
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Improve on pinctrl node names.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

(no changes since v2)

Changes in v2:
- New commit with pinctrl node name improvements as suggested by Shawn.

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 93 +++++++++++++-------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 4292311bdc6e..15ebabcacfc5 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -292,7 +292,7 @@ &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_snvs_usdhc1_cd>;
-	pinctrl-3 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_sleep_cd>;
+	pinctrl-3 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd_sleep>;
 	assigned-clocks = <&clks IMX6UL_CLK_USDHC1_SEL>, <&clks IMX6UL_CLK_USDHC1>;
 	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
 	assigned-clock-rates = <0>, <198000000>;
@@ -312,7 +312,6 @@ &wdog1 {
 };
 
 &iomuxc {
-
 	pinctrl_adc1: adc1grp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00        0x3000 /* SODIMM 8 */
@@ -336,13 +335,13 @@ MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04     0xb0a0	/* SODIMM 107 */
 		>;
 	};
 
-	pinctrl_can_int: canint-grp {
+	pinctrl_can_int: canintgrp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04	0x13010	/* SODIMM 73 */
 		>;
 	};
 
-	pinctrl_enet2: enet2-grp {
+	pinctrl_enet2: enet2grp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
 			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
@@ -357,7 +356,7 @@ MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
 		>;
 	};
 
-	pinctrl_enet2_sleep: enet2sleepgrp {
+	pinctrl_enet2_sleep: enet2-sleepgrp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06	0x0
 			MX6UL_PAD_GPIO1_IO07__GPIO1_IO07	0x0
@@ -372,13 +371,13 @@ MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x0
 		>;
 	};
 
-	pinctrl_ecspi1_cs: ecspi1-cs-grp {
+	pinctrl_ecspi1_cs: ecspi1csgrp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA21__GPIO3_IO26	0x70a0	/* SODIMM 86 */
 		>;
 	};
 
-	pinctrl_ecspi1: ecspi1-grp {
+	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA20__ECSPI1_SCLK	0x000a0	/* SODIMM 88 */
 			MX6UL_PAD_LCD_DATA22__ECSPI1_MOSI	0x000a0 /* SODIMM 92 */
@@ -386,27 +385,27 @@ MX6UL_PAD_LCD_DATA23__ECSPI1_MISO	0x100a0 /* SODIMM 90 */
 		>;
 	};
 
-	pinctrl_flexcan1: flexcan1-grp {
+	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_RX_DATA0__FLEXCAN1_TX	0x1b020
 			MX6UL_PAD_ENET1_RX_DATA1__FLEXCAN1_RX	0x1b020
 		>;
 	};
 
-	pinctrl_flexcan2: flexcan2-grp {
+	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_TX_DATA0__FLEXCAN2_RX	0x1b020
 			MX6UL_PAD_ENET1_RX_EN__FLEXCAN2_TX	0x1b020
 		>;
 	};
 
-	pinctrl_gpio_bl_on: gpio-bl-on-grp {
+	pinctrl_gpio_bl_on: gpioblongrp {
 		fsl,pins = <
 			MX6UL_PAD_JTAG_TMS__GPIO1_IO11		0x30a0	/* SODIMM 71 */
 		>;
 	};
 
-	pinctrl_gpio1: gpio1-grp {
+	pinctrl_gpio1: gpio1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x10b0 /* SODIMM 77 */
 			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x70a0 /* SODIMM 99 */
@@ -419,7 +418,7 @@ MX6UL_PAD_UART3_RTS_B__GPIO1_IO27	0x10b0 /* SODIMM 186 */
 		>;
 	};
 
-	pinctrl_gpio2: gpio2-grp { /* Camera */
+	pinctrl_gpio2: gpio2grp { /* Camera */
 		fsl,pins = <
 			MX6UL_PAD_CSI_DATA04__GPIO4_IO25	0x10b0 /* SODIMM 69 */
 			MX6UL_PAD_CSI_MCLK__GPIO4_IO17		0x10b0 /* SODIMM 75 */
@@ -429,20 +428,20 @@ MX6UL_PAD_CSI_DATA05__GPIO4_IO26	0x10b0 /* SODIMM 98 */
 		>;
 	};
 
-	pinctrl_gpio3: gpio3-grp { /* CAN2 */
+	pinctrl_gpio3: gpio3grp { /* CAN2 */
 		fsl,pins = <
 			MX6UL_PAD_ENET1_RX_EN__GPIO2_IO02	0x10b0 /* SODIMM 178 */
 			MX6UL_PAD_ENET1_TX_DATA0__GPIO2_IO03	0x10b0 /* SODIMM 188 */
 		>;
 	};
 
-	pinctrl_gpio4: gpio4-grp {
+	pinctrl_gpio4: gpio4grp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_DATA07__GPIO4_IO28	0x10b0 /* SODIMM 65 */
 		>;
 	};
 
-	pinctrl_gpio6: gpio6-grp { /* Wifi pins */
+	pinctrl_gpio6: gpio6grp { /* Wifi pins */
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0x10b0 /* SODIMM 89 */
 			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x10b0 /* SODIMM 79 */
@@ -454,7 +453,7 @@ MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x10b0 /* SODIMM 94 */
 		>;
 	};
 
-	pinctrl_gpio7: gpio7-grp { /* CAN1 */
+	pinctrl_gpio7: gpio7grp { /* CAN1 */
 		fsl,pins = <
 			MX6UL_PAD_ENET1_RX_DATA0__GPIO2_IO00	0xb0b0/* SODIMM 55 */
 			MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0xb0b0 /* SODIMM 63 */
@@ -465,7 +464,7 @@ MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0xb0b0 /* SODIMM 63 */
 	 * With an eMMC instead of a raw NAND device the following pins
 	 * are available at SODIMM pins.
 	 */
-	pinctrl_gpmi_gpio: gpmi-gpio-grp {
+	pinctrl_gpmi_gpio: gpmigpiogrp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_ALE__GPIO4_IO10		0x10b0 /* SODIMM 140 */
 			MX6UL_PAD_NAND_CE0_B__GPIO4_IO13	0x10b0 /* SODIMM 144 */
@@ -474,7 +473,7 @@ MX6UL_PAD_NAND_READY_B__GPIO4_IO12	0x10b0 /* SODIMM 142 */
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand-grp {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x100a9
 			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0x100a9
@@ -493,35 +492,35 @@ MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0x100a9
 		>;
 	};
 
-	pinctrl_i2c1: i2c1-grp {
+	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0	/* SODIMM 196 */
 			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0	/* SODIMM 194 */
 		>;
 	};
 
-	pinctrl_i2c1_gpio: i2c1-gpio-grp {
+	pinctrl_i2c1_gpio: i2c1-gpiogrp {
 		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__GPIO1_IO28 0x4001b8b0	/* SODIMM 196 */
 			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29 0x4001b8b0	/* SODIMM 194 */
 		>;
 	};
 
-	pinctrl_i2c2: i2c2-grp {
+	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL 0x4001f8b0
 			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA 0x4001f8b0
 		>;
 	};
 
-	pinctrl_i2c2_gpio: i2c2-gpio-grp {
+	pinctrl_i2c2_gpio: i2c2-gpiogrp {
 		fsl,pins = <
 			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30 0x4001f8b0
 			MX6UL_PAD_UART5_RX_DATA__GPIO1_IO31 0x4001f8b0
 		>;
 	};
 
-	pinctrl_lcdif_dat: lcdif-dat-grp {
+	pinctrl_lcdif_dat: lcdifdatgrp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00 0x00079	/* SODIMM 76 */
 			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01 0x00079	/* SODIMM 70 */
@@ -544,7 +543,7 @@ MX6UL_PAD_LCD_DATA17__LCDIF_DATA17 0x00079	/* SODIMM 61 */
 		>;
 	};
 
-	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x00079	/* SODIMM 56 */
 			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x00079	/* SODIMM 44 */
@@ -553,31 +552,31 @@ MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x00079	/* SODIMM 82 */
 		>;
 	};
 
-	pinctrl_pwm4: pwm4-grp {
+	pinctrl_pwm4: pwm4grp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_WP_B__PWM4_OUT	0x00079		/* SODIMM 59 */
 		>;
 	};
 
-	pinctrl_pwm5: pwm5-grp {
+	pinctrl_pwm5: pwm5grp {
 		fsl,pins = <
 			MX6UL_PAD_NAND_DQS__PWM5_OUT	0x00079		/* SODIMM 28 */
 		>;
 	};
 
-	pinctrl_pwm6: pwm6-grp {
+	pinctrl_pwm6: pwm6grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_TX_EN__PWM6_OUT	0x00079		/* SODIMM 30 */
 		>;
 	};
 
-	pinctrl_pwm7: pwm7-grp {
+	pinctrl_pwm7: pwm7grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET1_TX_CLK__PWM7_OUT	0x00079	/* SODIMM 67 */
 		>;
 	};
 
-	pinctrl_uart1: uart1-grp {
+	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART1_TX_DATA__UART1_DTE_RX	0x1b0b1	/* SODIMM 33 */
 			MX6UL_PAD_UART1_RX_DATA__UART1_DTE_TX	0x1b0b1	/* SODIMM 35 */
@@ -586,7 +585,7 @@ MX6UL_PAD_UART1_CTS_B__UART1_DTE_RTS	0x1b0b1	/* SODIMM 25 */
 		>;
 	};
 
-	pinctrl_uart1_ctrl1: uart1-ctrl1-grp { /* Additional DTR, DCD */
+	pinctrl_uart1_ctrl1: uart1ctrl1grp { /* Additional DTR, DCD */
 		fsl,pins = <
 			MX6UL_PAD_JTAG_TDI__GPIO1_IO13		0x70a0 /* SODIMM 31 / DCD */
 			MX6UL_PAD_LCD_DATA18__GPIO3_IO23	0x10b0 /* SODIMM 29 / DSR */
@@ -595,7 +594,7 @@ MX6UL_PAD_LCD_DATA19__GPIO3_IO24        0x10b0 /* SODIMM 37 / RI */
 		>;
 	};
 
-	pinctrl_uart2: uart2-grp {
+	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX6UL_PAD_UART2_TX_DATA__UART2_DTE_RX	0x1b0b1 /* SODIMM 36 */
 			MX6UL_PAD_UART2_RX_DATA__UART2_DTE_TX	0x1b0b1 /* SODIMM 38 */
@@ -603,20 +602,20 @@ MX6UL_PAD_UART2_CTS_B__UART2_DTE_RTS	0x1b0b1 /* SODIMM 32 */
 			MX6UL_PAD_UART2_RTS_B__UART2_DTE_CTS	0x1b0b1 /* SODIMM 34 */
 		>;
 	};
-	pinctrl_uart5: uart5-grp {
+	pinctrl_uart5: uart5grp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO04__UART5_DTE_RX	0x1b0b1 /* SODIMM 19 */
 			MX6UL_PAD_GPIO1_IO05__UART5_DTE_TX	0x1b0b1 /* SODIMM 21 */
 		>;
 	};
 
-	pinctrl_usbh_reg: gpio-usbh-reg {
+	pinctrl_usbh_reg: usbhreggrp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x10b0 /* SODIMM 129 / USBH_PEN */
 		>;
 	};
 
-	pinctrl_usdhc1: usdhc1-grp {
+	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059 /* SODIMM 47 */
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059 /* SODIMM 190 */
@@ -627,7 +626,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059 /* SODIMM 53 */
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
@@ -638,7 +637,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
 			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
@@ -649,7 +648,7 @@ MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
 		>;
 	};
 
-	pinctrl_usdhc2: usdhc2-grp {
+	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17069
 			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17069
@@ -677,7 +676,7 @@ MX6UL_PAD_NAND_DATA07__USDHC2_DATA7 0x17059
 		>;
 	};
 
-	pinctrl_wdog: wdog-grp {
+	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
 			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
 		>;
@@ -685,7 +684,7 @@ MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
 };
 
 &iomuxc_snvs {
-	pinctrl_snvs_gpio1: snvs-gpio1-grp {
+	pinctrl_snvs_gpio1: snvsgpio1grp {
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x110a0	/* SODIMM 93 */
 			MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x110a0	/* SODIMM 95 */
@@ -695,49 +694,49 @@ MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x110a0	/* SODIMM 138 */
 		>;
 	};
 
-	pinctrl_snvs_gpio3: snvs-gpio3-grp { /* Wifi pins */
+	pinctrl_snvs_gpio3: snvsgpio3grp { /* Wifi pins */
 		fsl,pins = <
 			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x130a0	/* SODIMM 127 */
 		>;
 	};
 
-	pinctrl_snvs_ad7879_int: snvs-ad7879-int-grp { /* TOUCH Interrupt */
+	pinctrl_snvs_ad7879_int: snvsad7879intgrp { /* TOUCH Interrupt */
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x100b0
 		>;
 	};
 
-	pinctrl_snvs_reg_sd: snvs-reg-sd-grp {
+	pinctrl_snvs_reg_sd: snvsregsdgrp {
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x400100b0
 		>;
 	};
 
-	pinctrl_snvs_usbc_det: snvs-usbc-det-grp {
+	pinctrl_snvs_usbc_det: snvsusbcdetgrp {
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x130b0
 		>;
 	};
 
-	pinctrl_snvs_gpiokeys: snvs-gpiokeys-grp {
+	pinctrl_snvs_gpiokeys: snvsgpiokeysgrp {
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x130a0	/* SODIMM 45 / WAKE_UP */
 		>;
 	};
 
-	pinctrl_snvs_usdhc1_cd: snvs-usdhc1-cd-grp {
+	pinctrl_snvs_usdhc1_cd: snvsusdhc1cdgrp {
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0a0 /* SODIMM 43 / MMC_CD */
 		>;
 	};
 
-	pinctrl_snvs_usdhc1_sleep_cd: snvs-usdhc1-cd-grp-slp {
+	pinctrl_snvs_usdhc1_cd_sleep: snvsusdhc1cd-sleepgrp {
 		fsl,pins = <
 			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x0
 		>;
 	};
 
-	pinctrl_snvs_wifi_pdn: snvs-wifi-pdn-grp {
+	pinctrl_snvs_wifi_pdn: snvswifipdngrp {
 		fsl,pins = <
 			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x130a0
 		>;
-- 
2.35.1

