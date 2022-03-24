Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63A4E667A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351552AbiCXP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351520AbiCXP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:59:10 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F1AD10C;
        Thu, 24 Mar 2022 08:57:36 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MfprR-1o08wQ0VwH-00gDul;
 Thu, 24 Mar 2022 16:57:19 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/10] arm64: dts: imx8mm-verdin: re-order pinctrl groups
Date:   Thu, 24 Mar 2022 16:56:46 +0100
Message-Id: <20220324155649.285924-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6cUVEBoGIHtTberT/gI+IXB2BBuEm4qmJHnE9EbIA7YaOm1LrZJ
 mlVMo364lIt3T24yu1TWhLctBAvXXaYEYhxblAvRKUvlWkGluWztX+cvexN6y4qMpXU6zCt
 5AXR3MjTwKnY4UbExdGkFG4vcFGJ9TYv2a9CiRXndalkJQ6YY3hihzm1pRZxowBBLgNKzvD
 mbIDeElBXqgtJqx+GUByg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L60ERafnbu4=:z/TxjYIhGD3oKgzQ/yGwX6
 aaF8co0BQRS8qiPMy0KjREFI2Lp2S65wfQGeQpe5xB4bdWYj0p79xZMDDsNrmQbSNgaKrDZKK
 5FygS4SlQV4ucHTvPhgj0SF2sOvQ4mLBVC1GAnuaMZrcbkuqjPpSbBjhZzlzZ5PgyyJlxQdmP
 p4uQrRtDAoQlHFp/w69hxEHt8ozaS2p39v+o6Lncdg7mojwFfKOkQVsXVkT86Q0d9WTIlOv1R
 zjsaCpZ1JwincWjes1m6fAG1pIWEaPUtEJT5a0peb3fkQGRJfel+JPUOgtPwt/gm13eIeqHvw
 3g0bbMklU/eoW7QJvkk5nseAZpqAxHWwFmgqIncRgRSWU3+i8e2vDBM3JxIY50fkwicVF8T0d
 4QGuE+EoNlKh0zDxKnjh1O5PNhH78QnMxqyG+Rqvs6k67WbDCqBbTl8loKcv6p13d1qsvPaDg
 oo6E0BNuPE6bBu1hfob3NK0UncMrO7wF1e5UfcUg7qmD5wdlSJUuiMwVn+1pjjzCfuynaYSON
 yCbakf9Rhece3m9GXIsU19KK4mRYIPRkDgpYJ683yJmirC+D4uq0tAVdDIfjPj2AxqAtZl+lf
 iVRJenCePgzHLYRl+33loFkJV5qFbSr2XveYKEksiRG3daT89weUwkfP4KKwdRrBRucBbXdRt
 yf4VjJOzTpt262eNzl/kDPZr09SaA6QWzrcSenOZ2UXwsKuJC1zC/4WbhlykjZl7ealXYxQQZ
 Njr95pFanIXUNJQJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Alphabetically re-order pinctrl groups.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 92 +++++++++----------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 7976d055f17b..f188ac187c37 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -796,36 +796,36 @@ pinctrl_ctrl_sleep_moci: ctrlsleepmocigrp {
 
 	pinctrl_ecspi2: ecspi2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x6>,	/* SODIMM 196 */
-			<MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x6>,	/* SODIMM 200 */
 			<MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x6>,	/* SODIMM 198 */
+			<MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x6>,	/* SODIMM 200 */
+			<MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x6>,	/* SODIMM 196 */
 			<MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x6>;	/* SODIMM 202 */
 	};
 
 	pinctrl_ecspi3: ecspi3grp {
 		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x146>,	/* CAN_2_SPI_CS#_1.8V */
 			<MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x6>,	/* CAN_SPI_SCK_1.8V */
 			<MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x6>,	/* CAN_SPI_MOSI_1.8V */
 			<MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x6>,	/* CAN_SPI_MISO_1.8V */
-			<MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x6>,	/* CAN_1_SPI_CS_1.8V# */
-			<MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x146>;	/* CAN_2_SPI_CS#_1.8V */
+			<MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x6>;	/* CAN_1_SPI_CS_1.8V# */
 	};
 
 	pinctrl_fec1: fec1grp {
 		fsl,pins =
 			<MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x3>,
 			<MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3>,
-			<MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f>,
-			<MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f>,
-			<MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f>,
-			<MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f>,
-			<MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91>,
-			<MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91>,
-			<MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91>,
 			<MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91>,
-			<MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f>,
+			<MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91>,
+			<MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91>,
+			<MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91>,
 			<MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91>,
 			<MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91>,
+			<MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x1f>,
+			<MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f>,
 			<MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f>,
 			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x146>;
 	};
@@ -834,17 +834,17 @@ pinctrl_fec1_sleep: fec1-sleepgrp {
 		fsl,pins =
 			<MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x3>,
 			<MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x3>,
-			<MX8MM_IOMUXC_ENET_TD3_GPIO1_IO18		0x1f>,
-			<MX8MM_IOMUXC_ENET_TD2_GPIO1_IO19		0x1f>,
-			<MX8MM_IOMUXC_ENET_TD1_GPIO1_IO20		0x1f>,
-			<MX8MM_IOMUXC_ENET_TD0_GPIO1_IO21		0x1f>,
-			<MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91>,
-			<MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91>,
-			<MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91>,
 			<MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91>,
-			<MX8MM_IOMUXC_ENET_TXC_GPIO1_IO23		0x1f>,
+			<MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91>,
+			<MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91>,
+			<MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91>,
 			<MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91>,
 			<MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91>,
+			<MX8MM_IOMUXC_ENET_TD0_GPIO1_IO21		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD1_GPIO1_IO20		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD2_GPIO1_IO19		0x1f>,
+			<MX8MM_IOMUXC_ENET_TD3_GPIO1_IO18		0x1f>,
+			<MX8MM_IOMUXC_ENET_TXC_GPIO1_IO23		0x1f>,
 			<MX8MM_IOMUXC_ENET_TX_CTL_GPIO1_IO22		0x1f>,
 			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x106>;
 	};
@@ -854,11 +854,11 @@ pinctrl_flexspi0: flexspi0grp {
 			<MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x106>,	/* SODIMM 52 */
 			<MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x106>,	/* SODIMM 54 */
 			<MX8MM_IOMUXC_NAND_CE1_B_QSPI_A_SS1_B		0x106>,	/* SODIMM 64 */
-			<MX8MM_IOMUXC_NAND_DQS_QSPI_A_DQS		0x106>,	/* SODIMM 66 */
 			<MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x106>,	/* SODIMM 56 */
 			<MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x106>,	/* SODIMM 58 */
 			<MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x106>,	/* SODIMM 60 */
-			<MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x106>;	/* SODIMM 62 */
+			<MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x106>,	/* SODIMM 62 */
+			<MX8MM_IOMUXC_NAND_DQS_QSPI_A_DQS		0x106>;	/* SODIMM 66 */
 	};
 
 	pinctrl_gpio1: gpio1grp {
@@ -1063,9 +1063,9 @@ pinctrl_reg_usb2_en: regusb2engrp {
 
 	pinctrl_sai2: sai2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0x6>,	/* SODIMM 32 */
-			<MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0x6>,	/* SODIMM 30 */
 			<MX8MM_IOMUXC_SAI2_MCLK_SAI2_MCLK		0x6>,	/* SODIMM 38 */
+			<MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0x6>,	/* SODIMM 30 */
+			<MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0x6>,	/* SODIMM 32 */
 			<MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0x6>,	/* SODIMM 36 */
 			<MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0x6>;	/* SODIMM 34 */
 	};
@@ -1095,23 +1095,23 @@ pinctrl_tsp: tspgrp {
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x146>,	/* SODIMM 149 */
-			<MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x146>;	/* SODIMM 147 */
+			<MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x146>,	/* SODIMM 147 */
+			<MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x146>;	/* SODIMM 149 */
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x146>,	/* SODIMM 129 */
-			<MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x146>,	/* SODIMM 131 */
 			<MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x146>,	/* SODIMM 133 */
-			<MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x146>;	/* SODIMM 135 */
+			<MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x146>,	/* SODIMM 135 */
+			<MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x146>,	/* SODIMM 131 */
+			<MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x146>;	/* SODIMM 129 */
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX		0x146>,	/* SODIMM 137 */
-			<MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX		0x146>,	/* SODIMM 139 */
 			<MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x146>,	/* SODIMM 141 */
+			<MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX		0x146>,	/* SODIMM 139 */
+			<MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX		0x146>,	/* SODIMM 137 */
 			<MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B	0x146>;	/* SODIMM 143 */
 	};
 
@@ -1181,35 +1181,35 @@ pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x90>,	/* SODIMM 78 */
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x90>,	/* SODIMM 74 */
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x90>,	/* SODIMM 80 */
 			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x90>,	/* SODIMM 82 */
 			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x90>,	/* SODIMM 70 */
-			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x90>,	/* SODIMM 72 */
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>;
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x90>;	/* SODIMM 72 */
 	};
 
 	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x94>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x94>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x94>,
 			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x94>,
 			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x94>,
-			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x94>,
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>;
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x94>;
 	};
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x96>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x96>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x96>,
 			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x96>,
 			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x96>,
-			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x96>,
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>;
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x96>;
 	};
 
 	/*
@@ -1218,32 +1218,32 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 	 */
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x150>,
-			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x150>,
 			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x150>,
 			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x150>,
 			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x150>,
-			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x150>;
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x150>,
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x150>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x150>;
 	};
 
 	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x154>,
-			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x154>,
 			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x154>,
 			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x154>,
 			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x154>,
-			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x154>;
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x154>,
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x154>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x154>;
 	};
 
 	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x156>,
-			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x156>,
 			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x156>,
 			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x156>,
 			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x156>,
-			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x156>;
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x156>,
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x156>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x156>;
 	};
 
 	pinctrl_wdog: wdoggrp {
-- 
2.34.1

