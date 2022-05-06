Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4104551DC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443175AbiEFPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443168AbiEFPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:52:37 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27236D879;
        Fri,  6 May 2022 08:48:53 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MI55X-1nZ1yB2Hrj-00FA4f;
 Fri, 06 May 2022 17:48:40 +0200
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
Subject: [PATCH v1 22/24] ARM: dts: imx7-colibri: clean-up iomuxc pinctrl group naming
Date:   Fri,  6 May 2022 17:48:36 +0200
Message-Id: <20220506154836.297190-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Lxr25iwrTJEb11BTTqDEuztu9haEBdrtiokllEChmGSpMxHEilV
 FgU+94TnzauGkgeFocZCvtvrsyBGd65g/FQy/zCektCISrsp2c5H5gJVl3gs+Y8qiUMv5VL
 IMR6IOrEt5NL6CrPoSyaJQuJeVGZrN5w/TDP+E9wXtOOQ+sJqGphXWpH6m5O6uErorKbAPU
 lbM/BEoL7Ck4JXNIewfng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l4SffBwTJZI=:AgNqvdj1qIReT3bD6tttG6
 8tv1aM9AyMNEhd6TCBE2UB020vTbdaISiw77yOhdk4cUPGbP+UGUUwk2xgPpYYHTZlpDssrFj
 Qom3bJj5oVutHBm2C57qHoHJ1gt9KeMrqrn0NUKHTxWUOFbCgk501bBEIoeSSP14CtWHzJ2jF
 A24ebGMYWy4yZc3fXbKXRsId4nmrPV+nuuiMfOwdFjSi2tIm6efMQhWRWF6fHvK9RGXGzIVB3
 rlxIjMLuUzWFqO+RDkEV8mlNF48jRvNM9N6A7tPeThUbTBrEh07G2WVjAnVH8/h/z6oq80lgZ
 ZbtTsU1QKwFdTDRQra84TaRlfRf/4D2fRvIu+1quAcHQa9IvBajE3zanaz+Y09vXSgtos5oaV
 cTktf0k0YhNWnXWQHRGdMMWpCQvTxBqfiCexG2TeNQRY6LzznFKkrWG2gXGACnOimyW3GmkJc
 vUFD8T8kK4GW/rSGJtkO0Mfm2AxjLaeXx+x2r/kHOBafiIgfkNnTfYTDCPwCo02QKJAFTkswA
 dE9vDOUFFeBE2eJM4Neoy5mRWlMP/ZTToROxiI7UGDIcJQeZlDQfymOgc6WMhXDtE8xvttci9
 d4sBOTfOF3Ha6FlPsp6q+EijMFgnMPq8J756UCpProFpolujQzxabOZZegQPqg2vo5o0BFTfb
 2fzflzfNm2NvRVMNcwO14clk+z+HUz9IHFYpXZQG2ettg8tKTXN9u171vqbVDMl7KXO7V7OLL
 pjcKWuMByo1kR2vA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Clean-up iomuxc pinctrl group naming.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri.dtsi | 70 ++++++++++++++---------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 27706a2bc3c4..a8c31ee65623 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -667,13 +667,13 @@ MX7D_PAD_EPDC_DATA15__GPIO2_IO15	0x74 /* SODIMM 107 / INT */
 		>;
 	};
 
-	pinctrl_can_int: can-int-grp {
+	pinctrl_can_int: canintgrp {
 		fsl,pins = <
 			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0X14 /* SODIMM 73 */
 		>;
 	};
 
-	pinctrl_ecspi3: ecspi3-grp {
+	pinctrl_ecspi3: ecspi3grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0x2 /* SODIMM 90 */
 			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0x2 /* SODIMM 92 */
@@ -681,7 +681,7 @@ MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0x2 /* SODIMM 88 */
 		>;
 	};
 
-	pinctrl_ecspi3_cs: ecspi3-cs-grp {
+	pinctrl_ecspi3_cs: ecspi3csgrp {
 		fsl,pins = <
 			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14 /* SODIMM 86 */
 		>;
@@ -702,7 +702,7 @@ MX7D_PAD_SD2_WP__ENET1_MDC			0x3
 		>;
 	};
 
-	pinctrl_enet1_sleep: enet1sleepgrp {
+	pinctrl_enet1_sleep: enet1-sleepgrp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_RGMII_RD0__GPIO7_IO0		0x0
 			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1		0x0
@@ -717,21 +717,21 @@ MX7D_PAD_SD2_WP__GPIO5_IO10			0x0
 		>;
 	};
 
-	pinctrl_flexcan1: flexcan1-grp {
+	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_RGMII_RD2__FLEXCAN1_RX	0x79 /* SODIMM 63 */
 			MX7D_PAD_ENET1_RGMII_RD3__FLEXCAN1_TX	0x79 /* SODIMM 55 */
 		>;
 	};
 
-	pinctrl_flexcan2: flexcan2-grp {
+	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x79 /* SODIMM 188 */
 			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x79 /* SODIMM 178 */
 		>;
 	};
 
-	pinctrl_gpio1: gpio1-grp {
+	pinctrl_gpio1: gpio1grp {
 		fsl,pins = <
 			MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x14 /* SODIMM 110 */
 			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14 /* SODIMM 111 */
@@ -774,7 +774,7 @@ MX7D_PAD_UART3_RTS_B__GPIO4_IO6		0x14 /* SODIMM 131 */
 		>;
 	};
 
-	pinctrl_gpio2: gpio2-grp { /* On X22 Camera interface */
+	pinctrl_gpio2: gpio2grp { /* On X22 Camera interface */
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_MISO__GPIO4_IO18	0x14 /* SODIMM 79 */
 			MX7D_PAD_ECSPI1_MOSI__GPIO4_IO17	0x14 /* SODIMM 103 */
@@ -791,7 +791,7 @@ MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x14 /* SODIMM 98 */
 		>;
 	};
 
-	pinctrl_gpio3: gpio3-grp { /* LCD 18-23 */
+	pinctrl_gpio3: gpio3grp { /* LCD 18-23 */
 		fsl,pins = <
 			MX7D_PAD_LCD_DATA18__GPIO3_IO23		0x14 /* SODIMM 136 */
 			MX7D_PAD_LCD_DATA19__GPIO3_IO24		0x14 /* SODIMM 138 */
@@ -802,27 +802,27 @@ MX7D_PAD_LCD_DATA23__GPIO3_IO28		0x74 /* SODIMM 146 */
 		>;
 	};
 
-	pinctrl_gpio4: gpio4-grp { /* Alternatively CAN2 */
+	pinctrl_gpio4: gpio4grp { /* Alternatively CAN2 */
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO14__GPIO1_IO14		0x14 /* SODIMM 188 */
 			MX7D_PAD_GPIO1_IO15__GPIO1_IO15		0x14 /* SODIMM 178 */
 		>;
 	};
 
-	pinctrl_gpio7: gpio7-grp { /* Alternatively CAN1 */
+	pinctrl_gpio7: gpio7grp { /* Alternatively CAN1 */
 		fsl,pins = <
 			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2	0x14 /* SODIMM 63 */
 			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3	0x14 /* SODIMM 55 */
 		>;
 	};
 
-	pinctrl_gpio_bl_on: gpio-bl-on {
+	pinctrl_gpio_bl_on: gpioblongrp {
 		fsl,pins = <
 			MX7D_PAD_SD1_WP__GPIO5_IO1		0x14 /* SODIMM 71 */
 		>;
 	};
 
-	pinctrl_gpmi_nand: gpmi-nand-grp {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_TX_BCLK__NAND_CE0_B	0x71
 			MX7D_PAD_SAI1_TX_DATA__NAND_READY_B	0x74
@@ -841,13 +841,13 @@ MX7D_PAD_SD3_STROBE__NAND_RE_B		0x71
 		>;
 	};
 
-	pinctrl_i2c1_int: i2c1-int-grp { /* PMIC / TOUCH */
+	pinctrl_i2c1_int: i2c1intgrp { /* PMIC / TOUCH */
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x79
 		>;
 	};
 
-	pinctrl_i2c4: i2c4-grp {
+	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_RGMII_TD2__I2C4_SCL	0x4000007f /* SODIMM 196 */
 			MX7D_PAD_ENET1_RGMII_TD3__I2C4_SDA	0x4000007f /* SODIMM 194 */
@@ -861,7 +861,7 @@ MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9	0x4000007f
 		>;
 	};
 
-	pinctrl_lcdif_dat: lcdif-dat-grp {
+	pinctrl_lcdif_dat: lcdifdatgrp {
 		fsl,pins = <
 			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79 /* SODIMM 76 */
 			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79 /* SODIMM 70 */
@@ -884,7 +884,7 @@ MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79 /* SODIMM 61 */
 		>;
 	};
 
-	pinctrl_lcdif_dat_24: lcdif-dat-24-grp {
+	pinctrl_lcdif_dat_24: lcdifdat24grp {
 		fsl,pins = <
 			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79 /* SODIMM 136 */
 			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79 /* SODIMM 138 */
@@ -895,7 +895,7 @@ MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79 /* SODIMM 146 */
 		>;
 	};
 
-	pinctrl_lcdif_ctrl: lcdif-ctrl-grp {
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
 		fsl,pins = <
 			MX7D_PAD_LCD_CLK__LCD_CLK		0x79 /* SODIMM 56 */
 			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79 /* SODIMM 44 */
@@ -913,33 +913,33 @@ MX7D_PAD_EPDC_DATA13__GPIO2_IO13        0x14 /* SODIMM 95 */
 		>;
 	};
 
-	pinctrl_pwm1: pwm1-grp {
+	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x4  /* SODIMM 59 */
 			MX7D_PAD_GPIO1_IO08__PWM1_OUT		0x79 /* SODIMM 59 */
 		>;
 	};
 
-	pinctrl_pwm2: pwm2-grp {
+	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO09__PWM2_OUT		0x79 /* SODIMM 28 */
 		>;
 	};
 
-	pinctrl_pwm3: pwm3-grp {
+	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
 			MX7D_PAD_GPIO1_IO10__PWM3_OUT		0x79 /* SODIMM 30 */
 		>;
 	};
 
-	pinctrl_pwm4: pwm4-grp {
+	pinctrl_pwm4: pwm4grp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI2_SCLK__GPIO4_IO20	0x4  /* SODIMM 67 */
 			MX7D_PAD_GPIO1_IO11__PWM4_OUT		0x79 /* SODIMM 67 */
 		>;
 	};
 
-	pinctrl_uart1: uart1-grp {
+	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_SAI2_TX_BCLK__UART1_DTE_CTS	0x79 /* SODIMM 25 */
 			MX7D_PAD_SAI2_TX_SYNC__UART1_DTE_RTS	0x79 /* SODIMM 27 */
@@ -948,14 +948,14 @@ MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX	0x79 /* SODIMM 33 */
 		>;
 	};
 
-	pinctrl_uart1_ctrl1: uart1-ctrl1-grp {
+	pinctrl_uart1_ctrl1: uart1ctrl1grp {
 		fsl,pins = <
 			MX7D_PAD_SD2_DATA0__GPIO5_IO14		0x14 /* SODIMM 23 / DTR */
 			MX7D_PAD_SD2_DATA1__GPIO5_IO15		0x14 /* SODIMM 31 / DCD */
 		>;
 	};
 
-	pinctrl_uart2: uart2-grp {
+	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX7D_PAD_SAI2_RX_DATA__UART2_DTE_RTS	0x79 /* SODIMM 32 / CTS */
 			MX7D_PAD_SAI2_TX_DATA__UART2_DTE_CTS	0x79 /* SODIMM 34 / RTS */
@@ -963,20 +963,20 @@ MX7D_PAD_UART2_RX_DATA__UART2_DTE_TX	0x79 /* SODIMM 38 */
 			MX7D_PAD_UART2_TX_DATA__UART2_DTE_RX	0x79 /* SODIMM 36 */
 		>;
 	};
-	pinctrl_uart3: uart3-grp {
+	pinctrl_uart3: uart3grp {
 		fsl,pins = <
 			MX7D_PAD_UART3_RX_DATA__UART3_DTE_TX	0x79 /* SODIMM 21 */
 			MX7D_PAD_UART3_TX_DATA__UART3_DTE_RX	0x79 /* SODIMM 19 */
 		>;
 	};
 
-	pinctrl_usbc_det: gpio-usbc-det {
+	pinctrl_usbc_det: usbcdetgrp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_CRS__GPIO7_IO14		0x14 /* SODIMM 137 / USBC_DET */
 		>;
 	};
 
-	pinctrl_usbh_reg: gpio-usbh-vbus {
+	pinctrl_usbh_reg: usbhreggrp {
 		fsl,pins = <
 			MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14 /* SODIMM 129 / USBH_PEN */
 		>;
@@ -1043,7 +1043,7 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE         0x19
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1a
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5a
@@ -1059,7 +1059,7 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE         0x1a
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CLK__SD3_CLK		0x1b
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x5b
@@ -1075,7 +1075,7 @@ MX7D_PAD_SD3_STROBE__SD3_STROBE         0x1b
 		>;
 	};
 
-	pinctrl_sai1: sai1-grp {
+	pinctrl_sai1: sai1grp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
 			MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
@@ -1084,7 +1084,7 @@ MX7D_PAD_SAI1_TX_SYNC__SAI1_TX_SYNC	0x1f
 		>;
 	};
 
-	pinctrl_sai1_mclk: sai1grp_mclk {
+	pinctrl_sai1_mclk: sai1mclkgrp {
 		fsl,pins = <
 			MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
 		>;
@@ -1107,7 +1107,7 @@ MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x0
 		>;
 	};
 
-	pinctrl_gpio_lpsr: gpio1-grp {
+	pinctrl_gpio_lpsr: gpiolpsrgrp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x59 /* SODIMM 135 */
 			MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3	0x59 /* SODIMM 22 */
@@ -1120,7 +1120,7 @@ MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x19 /* SODIMM 45 / WAKE_UP */
 		>;
 	};
 
-	pinctrl_i2c1: i2c1-grp {
+	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO04__I2C1_SCL	0x4000007f
 			MX7D_PAD_LPSR_GPIO1_IO05__I2C1_SDA	0x4000007f
@@ -1134,7 +1134,7 @@ MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x4000007f
 		>;
 	};
 
-	pinctrl_uart1_ctrl2: uart1-ctrl2-grp {
+	pinctrl_uart1_ctrl2: uart1ctrl2grp {
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14 /* SODIMM 37 / RI */
 			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x14 /* SODIMM 29 / DSR */
-- 
2.35.1

