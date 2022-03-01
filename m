Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB04C837E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiCAFpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiCAFo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:44:58 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4FB5677C;
        Mon, 28 Feb 2022 21:44:17 -0800 (PST)
X-UUID: 4dd73bebb20948ff97e3fff8dcde1472-20220301
X-UUID: 4dd73bebb20948ff97e3fff8dcde1472-20220301
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 235188049; Tue, 01 Mar 2022 13:44:08 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 13:44:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Mar
 2022 13:44:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 13:44:07 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND V2 2/3] dt-bindings: reset: mt8186: add reset-controller header file
Date:   Tue, 1 Mar 2022 13:44:04 +0800
Message-ID: <20220301054405.25021-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220301054405.25021-1-rex-bc.chen@mediatek.com>
References: <20220301054405.25021-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Runyang Chen <runyang.chen@mediatek.com>

- Add toprgu reset-controller header file for MT8186.
- Add DSI software reset bit which is controlled in MMSYS for MT8186.

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 include/dt-bindings/reset/mt8186-resets.h | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt8186-resets.h

diff --git a/include/dt-bindings/reset/mt8186-resets.h b/include/dt-bindings/reset/mt8186-resets.h
new file mode 100644
index 000000000000..5f850370c42c
--- /dev/null
+++ b/include/dt-bindings/reset/mt8186-resets.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Runyang Chen <runyang.chen@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8186
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8186
+
+#define MT8186_TOPRGU_INFRA_SW_RST				0
+#define MT8186_TOPRGU_MM_SW_RST					1
+#define MT8186_TOPRGU_MFG_SW_RST				2
+#define MT8186_TOPRGU_VENC_SW_RST				3
+#define MT8186_TOPRGU_VDEC_SW_RST				4
+#define MT8186_TOPRGU_IMG_SW_RST				5
+#define MT8186_TOPRGU_DDR_SW_RST				6
+#define MT8186_TOPRGU_INFRA_AO_SW_RST				8
+#define MT8186_TOPRGU_CONNSYS_SW_RST				9
+#define MT8186_TOPRGU_APMIXED_SW_RST				10
+#define MT8186_TOPRGU_PWRAP_SW_RST				11
+#define MT8186_TOPRGU_CONN_MCU_SW_RST				12
+#define MT8186_TOPRGU_IPNNA_SW_RST				13
+#define MT8186_TOPRGU_WPE_SW_RST				14
+#define MT8186_TOPRGU_ADSP_SW_RST				15
+#define MT8186_TOPRGU_AUDIO_SW_RST				17
+#define MT8186_TOPRGU_CAM_MAIN_SW_RST				18
+#define MT8186_TOPRGU_CAM_RAWA_SW_RST				19
+#define MT8186_TOPRGU_CAM_RAWB_SW_RST				20
+#define MT8186_TOPRGU_IPE_SW_RST				21
+#define MT8186_TOPRGU_IMG2_SW_RST				22
+#define MT8186_TOPRGU_SW_RST_NUM				23
+
+/* MMSYS resets */
+#define MT8186_MMSYS_SW0_RST_B_DISP_DSI0			19
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8186 */
-- 
2.18.0

