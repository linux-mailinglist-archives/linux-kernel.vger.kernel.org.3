Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015A64AEF47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiBIK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBIK23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:28:29 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F9E131E38;
        Wed,  9 Feb 2022 02:20:22 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MbB1Y-1nt0Pr3djU-00bav0;
 Wed, 09 Feb 2022 11:01:24 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/12] arm64: dts: imx8mm: fix strange hex notation
Date:   Wed,  9 Feb 2022 11:00:44 +0100
Message-Id: <20220209100055.181389-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lW93HK0eX9pdnaqywnxxNmUk6cyUc0fjb6WfDxBTWjvg/4qczlo
 qht/kzet8DGlGRgEgGsgETpHR1mjJvKvm8UeIlCydOQRCi92dUZSxa7MVirQbRb8DigWur8
 8VDMNElfzPGrzsUFNws03DshXjKqKKJzjX4XXvic8GHi3olUor41Uiaw02OluOpAd19WzG8
 9EAAUcrnwcmALZB/zK93g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VXZ4m6rt1Iw=:3v/RS+tw4jyghnYobwb0GJ
 zXH6oOcO8FLjbqGgP8tSLnfes1+Efv9vL8zLB7vz0keaxYOMg3lnY2Rutp3jqBpacWvJM1GW0
 07JB/HwSrOlH8FtKhmguIBIkWU/HiySSkVFD6mQKWuljJeFIbCwOkFmqq536M1VKUJBSuE2mT
 8sWI/I5cis4nIOBRqKzZHwtfIN8Nvwd/wQrZh5YGJlRgoEUpKoOFr9cgxA+SuJywLEqF0TSpm
 +XyihmkJ53f5/Zhw5/+G6Nr38tm6fn6SlR1YvqIrxyDYR1MnJzIsyyCw3Ti0xwuAWOnnJdPVt
 YVcZNp4J83qejwPEGoZwYquvR+gT0tuj/cPkG4RtJga3A8jEKJEMVbRPUz17ei6FRPJbshHrz
 DvBC0LnyLCInI6CPBqrdEtAHyRafm0LV6iYklQ0mmuJu8+cehri+8nbXQUhH8N9IHpyiyvsIZ
 RpVDlHKEzUNYHpSrqFpv9hHJMhkN4DlkzPalNQ8CPyGDvcm7iG3jiwoQK/wIfyKoiM2hq9gZ6
 8u793z0zaVSXDQgHBF6qHlvg/f3SqDPx/aVDgbAmTD4UDE9Cg9xgtIL6XoMetxsIKA7bDiEzs
 aMQuMTdK+4yJVlVpCFGXD3GkBIgOvs1tv9K7iUGcfZQ4xqqokKsdUKXrDSg+1n85cOEF8Lfix
 gtI7tKKRSODbNnU+EvrYevq7g+xz/nEGRIGnmYgxSZMfDaNAkwH6oNUQZ7KFXNmczHBc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix strange hex notation with mixed lower-case and upper-case letters.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v5:
- Add Rob's ack.

Changes in v2:
- Add Laurent's reviewed-by tag.

 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index a7411c800bef..83c8f715cd90 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -280,7 +280,7 @@
 #define MX8MM_IOMUXC_SAI5_RXD2_SAI1_TX_DATA4                                0x150 0x3B8 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI5_RXD2_SAI1_TX_SYNC                                 0x150 0x3B8 0x4CC 0x2 0x1
 #define MX8MM_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK                                 0x150 0x3B8 0x4E8 0x3 0x0
-#define MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2                                    0x150 0x3B8 0x53c 0x4 0x0
+#define MX8MM_IOMUXC_SAI5_RXD2_PDM_DATA2                                    0x150 0x3B8 0x53C 0x4 0x0
 #define MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23                                   0x150 0x3B8 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI5_RXD3_SAI5_RX_DATA3                                0x154 0x3BC 0x4E0 0x0 0x0
 #define MX8MM_IOMUXC_SAI5_RXD3_SAI1_TX_DATA5                                0x154 0x3BC 0x000 0x1 0x0
@@ -487,7 +487,7 @@
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC                                 0x1D8 0x440 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_GPT1_CAPTURE2                                0x1D8 0x440 0x000 0x1 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_SAI5_RX_DATA1                                0x1D8 0x440 0x4D8 0x2 0x2
-#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX                                 0x1D8 0x440 0x4Fc 0x4 0x2
+#define MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX                                 0x1D8 0x440 0x4FC 0x4 0x2
 #define MX8MM_IOMUXC_SAI3_TXFS_UART2_DTE_TX                                 0x1D8 0x440 0x000 0x4 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31                                   0x1D8 0x440 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SAI3_TXFS_TPSMP_HDATA1                                 0x1D8 0x440 0x000 0x7 0x0
@@ -495,7 +495,7 @@
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

