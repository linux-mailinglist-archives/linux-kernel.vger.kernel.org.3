Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0249B49FD77
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiA1QBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:01:48 -0500
Received: from mout.perfora.net ([74.208.4.196]:52375 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbiA1QBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:01:47 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LeNRr-1mScgb25Vt-00qDHw;
 Fri, 28 Jan 2022 17:01:24 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/12] arm64: dts: imx8mm: fix strange hex notation
Date:   Fri, 28 Jan 2022 17:00:49 +0100
Message-Id: <20220128160100.1228537-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Jy2SRP6pLYxJ2NSHDWvwfVzdx3V3OEautToWpwLoEiICTUF1yP2
 +rEviuL7Qqo2/xQv8loI9ajYtqCD+OSt959uLKvh3LiwSSqLXq6UDgg7g9KEUeMw3vhu+BP
 Bue1RB1NbvI/h/ZIMtfk/W0DbQuSd8enILF7CpUGpyJG763AmDhi3RA1U2jYWpLwSAKtPBz
 wJAos4NE5N4BOSvC4umlQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bx014uRTJ7g=:5bKjcpJy3H3ucXlL3aUrqK
 fKJStwjg/D8xh4BkzZkvb+AWLA0DYBYnubvwSJ/VB48pbFdPPFxVunSH97nhHoFsIOTihCfAf
 fAj+0g06tn/xcgCpsMFxQ9QdDyigOkvEGiVqa0B1GfFG94w0w1dSCLlb1nJji7ntK2rysc43u
 SqmnuU/g0PSs09Yq066YI1vcQwEnbx6mwgF+ylQU29359KNE+yHT+pCMoj10acETB9euly7C2
 p2KIKF7q6pXi7wN5eY8MD7jVjIX9IFiJ9r1toMEhunDGktPrJQ88HaT/qV1ekAbfHy7lX1Pv9
 Xi2U00sXhw9/ZEbogCHkE9DeItWoqFytCj03E69p0hyW7Lr6anaI49Udwu61zhyg8LNFcilzp
 eMSgtk2J9FC//r7VDfXi2Nsn50iLjv5g8/Azcvtmta31WFe/i+jfAugfMdRoSA0xAj+r6tC66
 BuC8P0hFfBfkzotBj75OtWArTKC4UHhbtgTMkDTg7GC18WUovEsHTjdiXvFN+7CNpGHm62KJP
 EVrwXckxa9NXyUaGmc214FaBNRGbXAz5jy80+QYsYpyPYtkdYGDuxiAaTAtD16dzYia+EhDzf
 gNQCik564Vd7ASD/taBjV70t8syp+0G6Y27BfMU6S/3Ge0PKpr5NZ6Z2Io+eW9GbsvUlh+8mE
 jZ3QZAL2E6nJaI+eU77dO8QgKqenOvL486Iz51HMa5TOXfu7PKZRmMezmok8GpDI1P8o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix strange hex notation with mixed lower-case and upper-case letters.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

(no changes since v2)

Changes in v2:
- Add Laurent's reviewed-by tag.

 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index a003e6af3353..c68a5e456025 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -279,7 +279,7 @@
 #define MX8MM_IOMUXC_SAI5_RXD2_SAI1_TX_DATA4                                0x150 0x3B8 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI5_RXD2_SAI1_TX_SYNC                                 0x150 0x3B8 0x4CC 0x2 0x1
 #define MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK                                 0x150 0x3B8 0x4E8 0x3 0x0
-#define MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2                                    0x150 0x3B8 0x53c 0x4 0x0
+#define MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2                                    0x150 0x3B8 0x53C 0x4 0x0
 #define MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23                                   0x150 0x3B8 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI5_RXD3_SAI5_RX_DATA3                                0x154 0x3BC 0x4E0 0x0 0x0
 #define MX8MM_IOMUXC_SAI5_RXD3_SAI1_TX_DATA5                                0x154 0x3BC 0x000 0x1 0x0
@@ -486,7 +486,7 @@
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC                                 0x1D8 0x440 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_GPT1_CAPTURE2                                0x1D8 0x440 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI5_RX_DATA1                                0x1D8 0x440 0x4D8 0x2 0x2
-#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX                                 0x1D8 0x440 0x4Fc 0x4 0x2
+#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX                                 0x1D8 0x440 0x4FC 0x4 0x2
 #define MX8MM_IOMUXC_SAI3_TXFS_UART2_DTE_TX                                 0x1D8 0x440 0x000 0x4 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31                                   0x1D8 0x440 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_TPSMP_HDATA1                                 0x1D8 0x440 0x000 0x7 0x0
@@ -494,7 +494,7 @@
 #define MX8MM_IOMUXC_SAI3_TXC_GPT1_COMPARE2                                 0x1DC 0x444 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_TXC_SAI5_RX_DATA2                                 0x1DC 0x444 0x4DC 0x2 0x2
 #define MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX                                  0x1DC 0x444 0x000 0x4 0x0
-#define MX8MM_IOMUXC_SAI3_TXC_UART2_DTE_RX                                  0x1DC 0x444 0x4Fc 0x4 0x3
+#define MX8MM_IOMUXC_SAI3_TXC_UART2_DTE_RX                                  0x1DC 0x444 0x4FC 0x4 0x3
 #define MX8MM_IOMUXC_SAI3_TXC_GPIO5_IO0                                     0x1DC 0x444 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_TXC_TPSMP_HDATA2                                  0x1DC 0x444 0x000 0x7 0x0
 #define MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0                                 0x1E0 0x448 0x000 0x0 0x0
-- 
2.33.1

