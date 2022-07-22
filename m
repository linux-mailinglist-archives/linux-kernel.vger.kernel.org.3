Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF057DB3C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiGVH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiGVH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:26:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFFF93C39;
        Fri, 22 Jul 2022 00:26:34 -0700 (PDT)
X-UUID: be26510acd5b45d48e69d57cab2bad23-20220722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:dd4ae563-79c8-4f1b-8ae6-898834020c17,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:f712fc64-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: be26510acd5b45d48e69d57cab2bad23-20220722
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 280666485; Fri, 22 Jul 2022 15:26:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 22 Jul 2022 15:26:27 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 22 Jul 2022 15:26:26 +0800
From:   Runyang Chen <Runyang.Chen@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: [PATCH] [2/3] dt-bindings: reset: mt8188: add toprgu reset-controller header file
Date:   Fri, 22 Jul 2022 15:23:15 +0800
Message-ID: <20220722072316.582-3-Runyang.Chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20220722072316.582-1-Runyang.Chen@mediatek.com>
References: <20220722072316.582-1-Runyang.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Runyang Chen <runyang.chen@mediatek.com>

Add toprgu reset-controller header file for MT8188

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8188-resets.h | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt8188-resets.h

diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
new file mode 100644
index 000000000000..377cdfda82a9
--- /dev/null
+++ b/include/dt-bindings/reset/mt8188-resets.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)*/
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Runyang Chen <runyang.chen@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8188
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8188
+
+#define MT8188_TOPRGU_CONN_MCU_SW_RST          0
+#define MT8188_TOPRGU_INFRA_GRST_SW_RST        1
+#define MT8188_TOPRGU_IPU0_SW_RST              2
+#define MT8188_TOPRGU_IPU1_SW_RST              3
+#define MT8188_TOPRGU_IPU2_SW_RST              4
+#define MT8188_TOPRGU_AUD_ASRC_SW_RST          5
+#define MT8188_TOPRGU_INFRA_SW_RST             6
+#define MT8188_TOPRGU_MMSYS_SW_RST             7
+#define MT8188_TOPRGU_MFG_SW_RST               8
+#define MT8188_TOPRGU_VENC_SW_RST              9
+#define MT8188_TOPRGU_VDEC_SW_RST              10
+#define MT8188_TOPRGU_CAM_VCORE_SW_RST         11
+#define MT8188_TOPRGU_SCP_SW_RST               12
+#define MT8188_TOPRGU_APMIXEDSYS_SW_RST        13
+#define MT8188_TOPRGU_AUDIO_SW_RST             14
+#define MT8188_TOPRGU_CAMSYS_SW_RST            15
+#define MT8188_TOPRGU_MJC_SW_RST               16
+#define MT8188_TOPRGU_PERI_SW_RST              17
+#define MT8188_TOPRGU_PERI_AO_SW_RST           18
+#define MT8188_TOPRGU_PCIE_SW_RST              19
+#define MT8188_TOPRGU_ADSPSYS_SW_RST           21
+#define MT8188_TOPRGU_DPTX_SW_RST              22
+#define MT8188_TOPRGU_SPMI_MST_SW_RST          23
+
+#define MT8188_TOPRGU_SW_RST_NUM               24
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8188 */
-- 
2.18.0

