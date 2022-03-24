Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE14E6677
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351625AbiCXP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbiCXP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:59:27 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262FADD67;
        Thu, 24 Mar 2022 08:57:40 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MCJn4-1nPCdq18T4-009PGS;
 Thu, 24 Mar 2022 16:57:16 +0100
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
Subject: [PATCH v1 06/10] arm64: dts: imx8mm-verdin: update iomux configuration
Date:   Thu, 24 Mar 2022 16:56:45 +0100
Message-Id: <20220324155649.285924-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324155649.285924-1-marcel@ziswiler.com>
References: <20220324155649.285924-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xEc+FKGNDUKDBq+QNNSuhc9gvTAISzFiRaE3RF25NY+RHc2m7xd
 SltXB36SgxMgfr9L4z9vu5/iUe7OFf94CK8anPV3nwLlGzKsTYKLXntzVtSGnm+cd8Auwrh
 BTjEaADA373LzSQgB6FjI1Hi8786s7nNE2KK1d7Ahyiq4rWF/Tq/o+0ldn165Rn8wtP0ts0
 2MVMiSzkq4OKGQ+RZTwrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hbLJtEPG2ts=:hDnRezwQYSAEnQJXU+MbqQ
 mYNvBkHfeurKotkhErxJNB6Z6PBrMcIr6NUzQIWYxsTRESZMDwZxwwTRc8cjIdWSzt3Wx1CyS
 dlmbk7VBJlafBeGUer6Ncv17+A3D40buRZF2d4vW7FoSUqIXMXp9hzfKmtkuEOI1YY4pCbMMo
 SfBXqPCkhijYc3UoxqskPefroZ4aF6LJIj15d8hDnWTp0AydZ7seQWCjW3VxVERQUDg2XhiaU
 htfGHkQmIrr6gCuhiosr+wkpLk95SAagQV5hVsvYqkkdSFlJSuraKZXVmHdJJyqAPRsUcC42V
 hu+i45+1CKdyMrqNgLDvRcolE/BDFmurTjE0M1rfobiywOAyuZ7BXJEz/Rt9WgtC85c58WG9c
 m26i6DhWI71rYmJCnDemSoscrYORxWjqjqPttFLXeLpCpNBIBOfFii397TjfbYki+Xu82sPTh
 eSvqq74Gctwh05XWmDBb/DdHy0LVH915w9BBJvpMsaZZ4tLhdPryt5QjzNBBdW+VGpqCD1Lx3
 deTQWoBm75Qk6RF1Nuf2S9EyJ7fASq9yP5BRpiWoP1JFaCnaOZ2sdw+3uzo3xEQpaVTbT6F4x
 pRO8+gFjYI1l3l6lbp6kt77HWhC8Vai1jQBfHpz92MsF+wBb8gLtL5gQDoRR39FFcTaE91tn9
 8A1O3kCKDnfbM1kYtZjewJ/eff2vOwYZ3xdE2syhhuwhMCOv8TSh9LNtNhxOjgdTXYYDR32j5
 xCsWxDKUl/xu7qaU
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

Update IOMUX configuration as required by the hardware design team.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 304 +++++++++---------
 1 file changed, 152 insertions(+), 152 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 4542c99ce906..7976d055f17b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -781,34 +781,34 @@ &iomuxc {
 
 	pinctrl_can1_int: can1intgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x1c4>;	/* CAN_1_SPI_INT#_1.8V */
+			<MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x146>;	/* CAN_1_SPI_INT#_1.8V */
 	};
 
 	pinctrl_can2_int: can2intgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x1c4>;	/* CAN_2_SPI_INT#_1.8V */
+			<MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x106>;	/* CAN_2_SPI_INT#_1.8V, unused */
 	};
 
 	pinctrl_ctrl_sleep_moci: ctrlsleepmocigrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1		0x1c4>;	/* SODIMM 256 */
+			<MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1		0x106>;	/* SODIMM 256 */
 	};
 
 	pinctrl_ecspi2: ecspi2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x4>,	/* SODIMM 196 */
-			<MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x4>,	/* SODIMM 200 */
-			<MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x1c4>,	/* SODIMM 198 */
-			<MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x1c4>;	/* SODIMM 202 */
+			<MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x6>,	/* SODIMM 196 */
+			<MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x6>,	/* SODIMM 200 */
+			<MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x6>,	/* SODIMM 198 */
+			<MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x6>;	/* SODIMM 202 */
 	};
 
 	pinctrl_ecspi3: ecspi3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x4>,	/* CAN_SPI_SCK_1.8V */
-			<MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x4>,	/* CAN_SPI_MOSI_1.8V */
-			<MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x1c4>,	/* CAN_SPI_MISO_1.8V */
-			<MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x1c4>,	/* CAN_1_SPI_CS_1.8V# */
-			<MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x1c4>;	/* CAN_2_SPI_CS#_1.8V */
+			<MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK		0x6>,	/* CAN_SPI_SCK_1.8V */
+			<MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI		0x6>,	/* CAN_SPI_MOSI_1.8V */
+			<MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO		0x6>,	/* CAN_SPI_MISO_1.8V */
+			<MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25		0x6>,	/* CAN_1_SPI_CS_1.8V# */
+			<MX8MM_IOMUXC_GPIO1_IO05_GPIO1_IO5		0x146>;	/* CAN_2_SPI_CS#_1.8V */
 	};
 
 	pinctrl_fec1: fec1grp {
@@ -827,7 +827,7 @@ pinctrl_fec1: fec1grp {
 			<MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91>,
 			<MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91>,
 			<MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f>,
-			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x1c4>;
+			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x146>;
 	};
 
 	pinctrl_fec1_sleep: fec1-sleepgrp {
@@ -846,170 +846,170 @@ pinctrl_fec1_sleep: fec1-sleepgrp {
 			<MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91>,
 			<MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91>,
 			<MX8MM_IOMUXC_ENET_TX_CTL_GPIO1_IO22		0x1f>,
-			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x184>;
+			<MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x106>;
 	};
 
 	pinctrl_flexspi0: flexspi0grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x1c2>,	/* SODIMM 52 */
-			<MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x82>,	/* SODIMM 54 */
-			<MX8MM_IOMUXC_NAND_CE1_B_QSPI_A_SS1_B		0x82>,	/* SODIMM 64 */
-			<MX8MM_IOMUXC_NAND_DQS_QSPI_A_DQS		0x82>,	/* SODIMM 66 */
-			<MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x82>,	/* SODIMM 56 */
-			<MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x82>,	/* SODIMM 58 */
-			<MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x82>,	/* SODIMM 60 */
-			<MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x82>;	/* SODIMM 62 */
+			<MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x106>,	/* SODIMM 52 */
+			<MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B		0x106>,	/* SODIMM 54 */
+			<MX8MM_IOMUXC_NAND_CE1_B_QSPI_A_SS1_B		0x106>,	/* SODIMM 64 */
+			<MX8MM_IOMUXC_NAND_DQS_QSPI_A_DQS		0x106>,	/* SODIMM 66 */
+			<MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0		0x106>,	/* SODIMM 56 */
+			<MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1		0x106>,	/* SODIMM 58 */
+			<MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2		0x106>,	/* SODIMM 60 */
+			<MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3		0x106>;	/* SODIMM 62 */
 	};
 
 	pinctrl_gpio1: gpio1grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_CE3_B_GPIO3_IO4		0x184>;	/* SODIMM 206 */
+			<MX8MM_IOMUXC_NAND_CE3_B_GPIO3_IO4		0x106>;	/* SODIMM 206 */
 	};
 
 	pinctrl_gpio2: gpio2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5		0x1c4>;	/* SODIMM 208 */
+			<MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5		0x106>;	/* SODIMM 208 */
 	};
 
 	pinctrl_gpio3: gpio3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_UART3_RXD_GPIO5_IO26		0x184>;	/* SODIMM 210 */
+			<MX8MM_IOMUXC_UART3_RXD_GPIO5_IO26		0x106>;	/* SODIMM 210 */
 	};
 
 	pinctrl_gpio4: gpio4grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_UART3_TXD_GPIO5_IO27		0x184>;	/* SODIMM 212 */
+			<MX8MM_IOMUXC_UART3_TXD_GPIO5_IO27		0x106>;	/* SODIMM 212 */
 	};
 
 	pinctrl_gpio5: gpio5grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x184>;	/* SODIMM 216 */
+			<MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x106>;	/* SODIMM 216 */
 	};
 
 	pinctrl_gpio6: gpio6grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x184>;	/* SODIMM 218 */
+			<MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x106>;	/* SODIMM 218 */
 	};
 
 	pinctrl_gpio7: gpio7grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x184>;	/* SODIMM 220 */
+			<MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x106>;	/* SODIMM 220 */
 	};
 
 	pinctrl_gpio8: gpio8grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x184>;	/* SODIMM 222 */
+			<MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x106>;	/* SODIMM 222 */
 	};
 
 	/* Verdin GPIO_9_DSI (pulled-up as active-low) */
 	pinctrl_gpio_9_dsi: gpio9dsigrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_RE_B_GPIO3_IO15		0x1c4>;	/* SODIMM 17 */
+			<MX8MM_IOMUXC_NAND_RE_B_GPIO3_IO15		0x146>;	/* SODIMM 17 */
 	};
 
-	/* Verdin GPIO_10_DSI */
+	/* Verdin GPIO_10_DSI (pulled-up as active-low) */
 	pinctrl_gpio_10_dsi: gpio10dsigrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_CE2_B_GPIO3_IO3		0x1c4>;	/* SODIMM 21 */
+			<MX8MM_IOMUXC_NAND_CE2_B_GPIO3_IO3		0x146>;	/* SODIMM 21 */
 	};
 
 	pinctrl_gpio_hog1: gpiohog1grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20		0x1c4>,	/* SODIMM 88 */
-			<MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1		0x1c4>,	/* SODIMM 90 */
-			<MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2		0x1c4>,	/* SODIMM 92 */
-			<MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3		0x1c4>,	/* SODIMM 94 */
-			<MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4		0x1c4>,	/* SODIMM 96 */
-			<MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5		0x1c4>,	/* SODIMM 100 */
-			<MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0		0x1c4>,	/* SODIMM 102 */
-			<MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11		0x1c4>,	/* SODIMM 104 */
-			<MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12		0x1c4>,	/* SODIMM 106 */
-			<MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13		0x1c4>,	/* SODIMM 108 */
-			<MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x1c4>,	/* SODIMM 112 */
-			<MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x1c4>,	/* SODIMM 114 */
-			<MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x1c4>,	/* SODIMM 116 */
-			<MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x1c4>,	/* SODIMM 118 */
-			<MX8MM_IOMUXC_SAI1_TXFS_GPIO4_IO10		0x1c4>;	/* SODIMM 120 */
+			<MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20		0x106>,	/* SODIMM 88 */
+			<MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1		0x106>,	/* SODIMM 90 */
+			<MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2		0x106>,	/* SODIMM 92 */
+			<MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3		0x106>,	/* SODIMM 94 */
+			<MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4		0x106>,	/* SODIMM 96 */
+			<MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5		0x106>,	/* SODIMM 100 */
+			<MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0		0x106>,	/* SODIMM 102 */
+			<MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11		0x106>,	/* SODIMM 104 */
+			<MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12		0x106>,	/* SODIMM 106 */
+			<MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13		0x106>,	/* SODIMM 108 */
+			<MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x106>,	/* SODIMM 112 */
+			<MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x106>,	/* SODIMM 114 */
+			<MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x106>,	/* SODIMM 116 */
+			<MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18		0x106>,	/* SODIMM 118 */
+			<MX8MM_IOMUXC_SAI1_TXFS_GPIO4_IO10		0x106>;	/* SODIMM 120 */
 	};
 
 	pinctrl_gpio_hog2: gpiohog2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x1c4>;	/* SODIMM 91 */
+			<MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2		0x106>;	/* SODIMM 91 */
 	};
 
 	pinctrl_gpio_hog3: gpiohog3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x1c4>,	/* SODIMM 157 */
-			<MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x1c4>;	/* SODIMM 187 */
+			<MX8MM_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x146>,	/* SODIMM 157 */
+			<MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15		0x146>;	/* SODIMM 187 */
 	};
 
 	pinctrl_gpio_keys: gpiokeysgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x1c4>;	/* SODIMM 252 */
+			<MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x146>;	/* SODIMM 252 */
 	};
 
 	/* On-module I2C */
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x400001c6>,	/* PMIC_I2C_SCL */
-			<MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c6>;	/* PMIC_I2C_SDA */
+			<MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL			0x40000146>,	/* PMIC_I2C_SCL */
+			<MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000146>;	/* PMIC_I2C_SDA */
 	};
 
 	pinctrl_i2c1_gpio: i2c1gpiogrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x400001c6>,	/* PMIC_I2C_SCL */
-			<MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15		0x400001c6>;	/* PMIC_I2C_SDA */
+			<MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x146>,	/* PMIC_I2C_SCL */
+			<MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15		0x146>;	/* PMIC_I2C_SDA */
 	};
 
 	/* Verdin I2C_4_CSI */
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x400001c6>,	/* SODIMM 55 */
-			<MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x400001c6>;	/* SODIMM 53 */
+			<MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL			0x40000146>,	/* SODIMM 55 */
+			<MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA			0x40000146>;	/* SODIMM 53 */
 	};
 
 	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16		0x400001c6>,	/* SODIMM 55 */
-			<MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17		0x400001c6>;	/* SODIMM 53 */
+			<MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16		0x146>,	/* SODIMM 55 */
+			<MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17		0x146>;	/* SODIMM 53 */
 	};
 
 	/* Verdin I2C_2_DSI */
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x400001c6>,	/* SODIMM 95 */
-			<MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x400001c6>;	/* SODIMM 93 */
+			<MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL			0x40000146>,	/* SODIMM 95 */
+			<MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA			0x40000146>;	/* SODIMM 93 */
 	};
 
 	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18		0x400001c6>,	/* SODIMM 95 */
-			<MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19		0x400001c6>;	/* SODIMM 93 */
+			<MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18		0x146>,	/* SODIMM 95 */
+			<MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19		0x146>;	/* SODIMM 93 */
 	};
 
 	/* Verdin I2C_1 */
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c6>,	/* SODIMM 14 */
-			<MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c6>;	/* SODIMM 12 */
+			<MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x40000146>,	/* SODIMM 14 */
+			<MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x40000146>;	/* SODIMM 12 */
 	};
 
 	pinctrl_i2c4_gpio: i2c4gpiogrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20		0x400001c6>,	/* SODIMM 14 */
-			<MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21		0x400001c6>;	/* SODIMM 12 */
+			<MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20		0x146>,	/* SODIMM 14 */
+			<MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21		0x146>;	/* SODIMM 12 */
 	};
 
 	/* Verdin I2S_2_BCLK (TOUCH_RESET#) */
 	pinctrl_i2s_2_bclk_touch_reset: i2s2bclktouchresetgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x184>;	/* SODIMM 42 */
+			<MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x6>;	/* SODIMM 42 */
 	};
 
 	/* Verdin I2S_2_D_OUT shared with SAI5 */
 	pinctrl_i2s_2_d_out_dsi_1_bkl_en: i2s2doutdsi1bklengrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x184>;	/* SODIMM 46 */
+			<MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x6>;	/* SODIMM 46 */
 	};
 
 	pinctrl_pcie0: pcie0grp {
@@ -1021,7 +1021,7 @@ pinctrl_pcie0: pcie0grp {
 
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x41>;	/* PMIC_INT# */
+			<MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141>;	/* PMIC_INT# */
 	};
 
 	/* Verdin PWM_3_DSI shared with GPIO1_IO1 */
@@ -1043,82 +1043,82 @@ pinctrl_pwm_3: pwm3grp {
 	/* Verdin PWM_3_DSI (pulled-down as active-high) shared with PWM1_OUT */
 	pinctrl_pwm_3_dsi_hpd_gpio: pwm3dsihpdgpiogrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x184>;	/* SODIMM 19 */
+			<MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x106>;	/* SODIMM 19 */
 	};
 
 	pinctrl_reg_eth: regethgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SD2_WP_GPIO2_IO20			0x184>;	/* PMIC_EN_ETH */
+			<MX8MM_IOMUXC_SD2_WP_GPIO2_IO20			0x146>;	/* PMIC_EN_ETH */
 	};
 
 	pinctrl_reg_usb1_en: regusb1engrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x184>;	/* SODIMM 155 */
+			<MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12		0x106>;	/* SODIMM 155 */
 	};
 
 	pinctrl_reg_usb2_en: regusb2engrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x184>;	/* SODIMM 185 */
+			<MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14		0x106>;	/* SODIMM 185 */
 	};
 
 	pinctrl_sai2: sai2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0xd6>,	/* SODIMM 32 */
-			<MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0xd6>,	/* SODIMM 30 */
-			<MX8MM_IOMUXC_SAI2_MCLK_SAI2_MCLK		0xd6>,	/* SODIMM 38 */
-			<MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0xd6>,	/* SODIMM 36 */
-			<MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0xd6>;	/* SODIMM 34 */
+			<MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC		0x6>,	/* SODIMM 32 */
+			<MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK		0x6>,	/* SODIMM 30 */
+			<MX8MM_IOMUXC_SAI2_MCLK_SAI2_MCLK		0x6>,	/* SODIMM 38 */
+			<MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0		0x6>,	/* SODIMM 36 */
+			<MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0		0x6>;	/* SODIMM 34 */
 	};
 
 	pinctrl_sai5: sai5grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI5_RXD0_SAI5_RX_DATA0		0xd6>,	/* SODIMM 48 */
-			<MX8MM_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC		0xd6>,	/* SODIMM 44 */
-			<MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK		0xd6>,	/* SODIMM 42 */
-			<MX8MM_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0		0xd6>;	/* SODIMM 46 */
+			<MX8MM_IOMUXC_SAI5_RXD0_SAI5_RX_DATA0		0x6>,	/* SODIMM 48 */
+			<MX8MM_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC		0x6>,	/* SODIMM 44 */
+			<MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK		0x6>,	/* SODIMM 42 */
+			<MX8MM_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0		0x6>;	/* SODIMM 46 */
 	};
 
 	/* control signal for optional ATTPM20P or SE050 */
 	pinctrl_pmic_tpm_ena: pmictpmenagrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x1c4>;	/* PMIC_TPM_ENA */
+			<MX8MM_IOMUXC_SAI1_TXD7_GPIO4_IO19		0x106>;	/* PMIC_TPM_ENA */
 	};
 
 	pinctrl_tsp: tspgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6		0x140>,	/* SODIMM 148 */
-			<MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x140>,	/* SODIMM 152 */
-			<MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x140>,	/* SODIMM 154 */
-			<MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x140>,	/* SODIMM 174 */
-			<MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x140>;	/* SODIMM 150 */
+			<MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6		0x6>,	/* SODIMM 148 */
+			<MX8MM_IOMUXC_SAI1_RXD5_GPIO4_IO7		0x6>,	/* SODIMM 152 */
+			<MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8		0x6>,	/* SODIMM 154 */
+			<MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x146>,	/* SODIMM 174 */
+			<MX8MM_IOMUXC_SAI1_TXD5_GPIO4_IO17		0x6>;	/* SODIMM 150 */
 	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x1c4>,	/* SODIMM 149 */
-			<MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x1c4>;	/* SODIMM 147 */
+			<MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX		0x146>,	/* SODIMM 149 */
+			<MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX		0x146>;	/* SODIMM 147 */
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x1c4>,	/* SODIMM 129 */
-			<MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x1c4>,	/* SODIMM 131 */
-			<MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x1c4>,	/* SODIMM 133 */
-			<MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x1c4>;	/* SODIMM 135 */
+			<MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX		0x146>,	/* SODIMM 129 */
+			<MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX		0x146>,	/* SODIMM 131 */
+			<MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B		0x146>,	/* SODIMM 133 */
+			<MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B		0x146>;	/* SODIMM 135 */
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX		0x1c4>,	/* SODIMM 137 */
-			<MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX		0x1c4>,	/* SODIMM 139 */
-			<MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x1c4>,	/* SODIMM 141 */
-			<MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B	0x1c4>;	/* SODIMM 143 */
+			<MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX		0x146>,	/* SODIMM 137 */
+			<MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX		0x146>,	/* SODIMM 139 */
+			<MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x146>,	/* SODIMM 141 */
+			<MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B	0x146>;	/* SODIMM 143 */
 	};
 
 	pinctrl_uart4: uart4grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX		0x1c4>,	/* SODIMM 151 */
-			<MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX		0x1c4>;	/* SODIMM 153 */
+			<MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX		0x146>,	/* SODIMM 151 */
+			<MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX		0x146>;	/* SODIMM 153 */
 	};
 
 	pinctrl_usdhc1: usdhc1grp {
@@ -1171,45 +1171,45 @@ pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 
 	pinctrl_usdhc2_cd: usdhc2cdgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x1c4>;	/* SODIMM 84 */
+			<MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x6>;	/* SODIMM 84 */
 	};
 
 	pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x184>;	/* SODIMM 76 */
+			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x6>;	/* SODIMM 76 */
 	};
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190>,	/* SODIMM 78 */
-			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0>,	/* SODIMM 74 */
-			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0>,	/* SODIMM 80 */
-			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0>,	/* SODIMM 82 */
-			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0>,	/* SODIMM 70 */
-			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0>,	/* SODIMM 72 */
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0>;
+			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x90>,	/* SODIMM 78 */
+			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x90>,	/* SODIMM 74 */
+			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x90>,	/* SODIMM 80 */
+			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x90>,	/* SODIMM 82 */
+			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x90>,	/* SODIMM 70 */
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x90>,	/* SODIMM 72 */
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>;
 	};
 
 	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194>,
-			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4>,
-			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4>,
-			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4>,
-			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4>,
-			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4>,
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0>;
+			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x94>,
+			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x94>,
+			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x94>,
+			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x94>,
+			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x94>,
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x94>,
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>;
 	};
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196>,
-			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6>,
-			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6>,
-			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6>,
-			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6>,
-			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6>,
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0>;
+			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x96>,
+			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x96>,
+			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x96>,
+			<MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x96>,
+			<MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x96>,
+			<MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x96>,
+			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>;
 	};
 
 	/*
@@ -1218,56 +1218,56 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 	 */
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x190>,
-			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0>,
-			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0>,
-			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0>,
-			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0>,
-			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0>;
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x150>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x150>,
+			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x150>,
+			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x150>,
+			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x150>,
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x150>;
 	};
 
 	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194>,
-			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4>,
-			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4>,
-			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4>,
-			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4>,
-			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4>;
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x154>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x154>,
+			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x154>,
+			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x154>,
+			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x154>,
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x154>;
 	};
 
 	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196>,
-			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6>,
-			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6>,
-			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6>,
-			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6>,
-			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6>;
+			<MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x156>,
+			<MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x156>,
+			<MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x156>,
+			<MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x156>,
+			<MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x156>,
+			<MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x156>;
 	};
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6>;	/* PMIC_WDI */
+			<MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166>;	/* PMIC_WDI */
 	};
 
 	pinctrl_wifi_ctrl: wifictrlgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x1c4>,	/* WIFI_WKUP_BT */
-			<MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x1c4>,	/* WIFI_W_WKUP_HOST */
-			<MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x1c4>;	/* WIFI_WKUP_WLAN */
+			<MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x46>,	/* WIFI_WKUP_BT */
+			<MX8MM_IOMUXC_SAI1_RXD7_GPIO4_IO9		0x146>,	/* WIFI_W_WKUP_HOST */
+			<MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x46>;	/* WIFI_WKUP_WLAN */
 	};
 
 	pinctrl_wifi_i2s: bti2sgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI1_RXD4_SAI6_TX_BCLK		0xd6>,	/* WIFI_TX_BCLK */
-			<MX8MM_IOMUXC_SAI1_RXD5_SAI6_TX_DATA0		0xd6>,	/* WIFI_TX_DATA0 */
-			<MX8MM_IOMUXC_SAI1_RXD6_SAI6_TX_SYNC		0xd6>,	/* WIFI_TX_SYNC */
-			<MX8MM_IOMUXC_SAI1_TXD5_SAI6_RX_DATA0		0xd6>;	/* WIFI_RX_DATA0 */
+			<MX8MM_IOMUXC_SAI1_RXD4_SAI6_TX_BCLK		0x6>,	/* WIFI_TX_BCLK */
+			<MX8MM_IOMUXC_SAI1_RXD5_SAI6_TX_DATA0		0x6>,	/* WIFI_TX_DATA0 */
+			<MX8MM_IOMUXC_SAI1_RXD6_SAI6_TX_SYNC		0x6>,	/* WIFI_TX_SYNC */
+			<MX8MM_IOMUXC_SAI1_TXD5_SAI6_RX_DATA0		0x6>;	/* WIFI_RX_DATA0 */
 	};
 
 	pinctrl_wifi_pwr_en: wifipwrengrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x184>;	/* PMIC_EN_WIFI */
+			<MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x6>;	/* PMIC_EN_WIFI */
 	};
 };
-- 
2.34.1

