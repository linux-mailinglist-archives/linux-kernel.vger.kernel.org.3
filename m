Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D9C487BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbiAGSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:13 -0500
Received: from mout.perfora.net ([74.208.4.194]:47955 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348678AbiAGSEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:12 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MUoHN-1mxTYg35xR-00Qle6;
 Fri, 07 Jan 2022 19:03:48 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v1 01/14] arm64: dts: imx8mm: fix strange hex notation
Date:   Fri,  7 Jan 2022 19:03:01 +0100
Message-Id: <20220107180314.1816515-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Agtd2KULb4KbSyLtL1KrrX1DGxizXppFEHW5vtbd994J34X8ov1
 s/aLIDBUK/PIEeYfPSRD2JSWhyJJConkXlEqH76PikcaFlNMU2L59XyjYFx1ROwZzRMgJaz
 oU77EQViX7Vh2yDMiyoTV5gm1v8xs+JDeo6k3hBjk/hnOgs7Xm49AHaboWFQasi/RMiPI0r
 gBBvcde3s4ZUyspVEz5ew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OGTKMnhA35s=:S5UOzWON+ARNCqA85bA/qF
 6FY3+/ZjYIwOMyith5UL617TDwvHGeVbj0nSpgsG4E69etT3SCsOoXfH7VkaAVjivGnuSIHog
 aUa8FzOtOTQYYtJhxDx4clMPOjkT7Zip9TYza65DUJMjvtqxTjqVNaP0YITSHO4QsaB9HUuTn
 W2RyqXZy+cAbS1K4yf6KMJ1CYGCo4XWCB8tLYKGK/AmnLTACaQ2PqYuuzU8keL3zhcRbizwQ6
 zxMWFIv38/VhyzilX8ECvnLQXfhFlIbNJz6tJe/exZdVb8J3uw2aUhhhqoLgw1ZWIjRsvko8I
 XFv1woK4pSLlz+8xk+GIeOrO8FdPKxHx7ICgCop4IF25ogGEVnGdSpN2NASG1wlFRxMMJ3eQm
 RJoBtcBN7mqgSgCbQqPWWd7GOriTkMbVxawP83UiT9gzUW7VgS6iBxrJEkNj2PcNDx7XAiGZS
 2hG/IF3aIYIkY3gxNeKM707GHDTeaugyBxVq4JOH2Iupp+Cu0rOuJYhUK9meT+M3EndmSFlTX
 glHJwTf06ikyRMBgNmheZFDAVD3U0nfIVqpAYXkwxppR/XjmXFd05MKSvz797RtkfigjRdSMv
 ymcnr8ahmVnpFtB9k9AJuCkPNErWIwWZNtGDOZ2cydB+ysOJS3fezmmj1j4QWsrVm9ALQXyJi
 JYSaZTpVILsuH7Qml5svWbeoQIRyhxTsMbtcvlohV8V8e9bpvFiskct0Osbplz5sjR+Q=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix strange hex notation with mixed lower-case and upper-case letters.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

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

