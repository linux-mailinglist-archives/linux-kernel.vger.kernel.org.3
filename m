Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301C04850AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiAEKFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:05:52 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:37272 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239199AbiAEKFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:05:48 -0500
X-UUID: d6203ac3c0c0467387f5d1cb273816aa-20220105
X-UUID: d6203ac3c0c0467387f5d1cb273816aa-20220105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1894310530; Wed, 05 Jan 2022 18:05:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 5 Jan 2022 18:05:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 5 Jan 2022 18:05:43 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: reset: mt7986: Add reset-controller header file
Date:   Wed, 5 Jan 2022 18:04:55 +0800
Message-ID: <20220105100456.7126-2-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220105100456.7126-1-sam.shih@mediatek.com>
References: <20220105100456.7126-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add infracfg, toprgu, and ethsys reset-controller header file
for MT7986 platform.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 include/dt-bindings/reset/mt7986-resets.h | 55 +++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt7986-resets.h

diff --git a/include/dt-bindings/reset/mt7986-resets.h b/include/dt-bindings/reset/mt7986-resets.h
new file mode 100644
index 000000000000..af3d16c81192
--- /dev/null
+++ b/include/dt-bindings/reset/mt7986-resets.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT7986
+#define _DT_BINDINGS_RESET_CONTROLLER_MT7986
+
+/* INFRACFG resets */
+#define MT7986_INFRACFG_PEXTP_MAC_SW_RST	6
+#define MT7986_INFRACFG_SSUSB_SW_RST		7
+#define MT7986_INFRACFG_EIP97_SW_RST		8
+#define MT7986_INFRACFG_AUDIO_SW_RST		13
+#define MT7986_INFRACFG_CQ_DMA_SW_RST		14
+
+#define MT7986_INFRACFG_TRNG_SW_RST		17
+#define MT7986_INFRACFG_AP_DMA_SW_RST		32
+#define MT7986_INFRACFG_I2C_SW_RST		33
+#define MT7986_INFRACFG_NFI_SW_RST		34
+#define MT7986_INFRACFG_SPI0_SW_RST		35
+#define MT7986_INFRACFG_SPI1_SW_RST		36
+#define MT7986_INFRACFG_UART0_SW_RST		37
+#define MT7986_INFRACFG_UART1_SW_RST		38
+#define MT7986_INFRACFG_UART2_SW_RST		39
+#define MT7986_INFRACFG_AUXADC_SW_RST		43
+
+#define MT7986_INFRACFG_APXGPT_SW_RST		66
+#define MT7986_INFRACFG_PWM_SW_RST		68
+
+#define MT7986_INFRACFG_SW_RST_NUM		69
+
+/* TOPRGU resets */
+#define MT7986_TOPRGU_APMIXEDSYS_SW_RST		0
+#define MT7986_TOPRGU_SGMII0_SW_RST		1
+#define MT7986_TOPRGU_SGMII1_SW_RST		2
+#define MT7986_TOPRGU_INFRA_SW_RST		3
+#define MT7986_TOPRGU_U2PHY_SW_RST		5
+#define MT7986_TOPRGU_PCIE_SW_RST		6
+#define MT7986_TOPRGU_SSUSB_SW_RST		7
+#define MT7986_TOPRGU_ETHDMA_SW_RST		20
+#define MT7986_TOPRGU_CONSYS_SW_RST		23
+
+#define MT7986_TOPRGU_SW_RST_NUM		24
+
+/* ETHSYS Subsystem resets */
+#define MT7986_ETHSYS_FE_SW_RST			6
+#define MT7986_ETHSYS_PMTR_SW_RST		8
+#define MT7986_ETHSYS_GMAC_SW_RST		23
+#define MT7986_ETHSYS_PPE0_SW_RST		30
+#define MT7986_ETHSYS_PPE1_SW_RST		31
+
+#define MT7986_ETHSYS_SW_RST_NUM		32
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7986 */
-- 
2.29.2

