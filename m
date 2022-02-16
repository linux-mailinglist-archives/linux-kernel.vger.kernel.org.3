Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7864B7CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbiBPBpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:45:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbiBPBpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:45:38 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7DFA219;
        Tue, 15 Feb 2022 17:45:27 -0800 (PST)
X-UUID: 88f8d295ebc64782ba95925e1d1d58e6-20220216
X-UUID: 88f8d295ebc64782ba95925e1d1d58e6-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1411497216; Wed, 16 Feb 2022 09:45:21 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 09:45:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 09:45:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 09:45:20 +0800
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
Subject: [2/4] dt-bindings: reset: mt8186: add toprgu reset-controller header file
Date:   Wed, 16 Feb 2022 09:45:03 +0800
Message-ID: <20220216014505.28428-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
References: <20220216014505.28428-1-rex-bc.chen@mediatek.com>
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

Add toprgu reset-controller header file for MT8186.

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8186-resets.h | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt8186-resets.h

diff --git a/include/dt-bindings/reset/mt8186-resets.h b/include/dt-bindings/reset/mt8186-resets.h
new file mode 100644
index 000000000000..36e5764e2e6c
--- /dev/null
+++ b/include/dt-bindings/reset/mt8186-resets.h
@@ -0,0 +1,33 @@
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
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8186 */
-- 
2.18.0

