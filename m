Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5111B48EB68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiANOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:16:00 -0500
Received: from mout.perfora.net ([74.208.4.194]:38213 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241444AbiANOP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:15:59 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lkw9T-1mZrMM1Gx3-00apy9;
 Fri, 14 Jan 2022 15:15:31 +0100
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
Subject: [PATCH v2 01/11] arm64: dts: imx8mm: fix strange hex notation
Date:   Fri, 14 Jan 2022 15:14:57 +0100
Message-Id: <20220114141507.395271-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oESOtOPuWo8sPx81MeeTQKrPBLqUe0dN4Uy33o5E5eZu8mHV/LN
 1www8ErKZBd1DAjr/DflEkvkrA9HXV9NveOMa/3NQq8WVagTw8DqGFtoheRpv+t1AKY6b7x
 sW1jxEkIcmCnXWdTE0SHR7bZkvu/8KpXB9iRDdUKuqYJQMkhxM1CPJmoolCbeskU1exTVUq
 M/u+qPjxOXc50R7/iGw3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UkNeJRe/hQs=:HYIfJ6MdDX+fslLPC6fnfn
 qmIimZEiO/UoWZrSPRFMFMS+oGhzxDu733V6z2BMkvvd0+swtipGfBupD6Kk4FgmsjPEp3cj8
 8pcLBgnviYlIGmWVX6Tdoc5oapu1r3eRK23fzDyNezncV0TvpQuV9vv7a8JFrVWwkmEuckI3R
 AypiidV9jCv1C4cHESAcia1lWtghQ+n8PlAZ/UWZH264azRftZ2jCBVsrDoFhC/n9DmEZkzGs
 UYrPgqMVnyK1hwNB8ehTY8el4iwvsgcjt3DSbFd2qENOQLoUPTUAjKHgv50FhVb7g0rjrWK1G
 iEz6cHv9+e73ckHJ8EiP+V48g1zz6tM3thGGKOldNfwNIhMapuP35wtG9LpwGjNiOkDzFJOLc
 2wdX2rFPtj3WF3AZicQ6uXKintkuk/pAwApDuGs6uAznpRxNCjK8dy02bOugfN/FRlPFzi+MZ
 UOcMPC+2hfLdLr0Q1/aChEhyvUoYyXWlMSMTQ7PC94ct74CqnSyW/UHPkz9k9JmWQrG5+2YfA
 OVXi4ba7EpgG2UKjXNekmcWjJ1SWyXf+6cpd3wA03PGCzHm33abbLBLMNCaviLPL0bPQnbq7E
 2qML+g+sc9rc3qCtGPChcfJ75ze1GTP2J+R6wswv4Oe3XNEjC0Vqim53G9n+DoBCvp7z8cS/J
 Sl5vjS1tBH2xdoTSma5yYOZsTggQKA8c500a5Vb0CzI0khnysVSQLQoZJ6gXZHWWl/Zs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix strange hex notation with mixed lower-case and upper-case letters.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v2:
- Added Laurent's reviewed-by tag.

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

