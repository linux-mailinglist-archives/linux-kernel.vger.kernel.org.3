Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F4B595597
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiHPItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiHPIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:48:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8714EBB8;
        Mon, 15 Aug 2022 23:53:58 -0700 (PDT)
X-UUID: 5f3b04c4a2884e63824507c2f2463bff-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yLi9Y9lzraMMjpBP1+i+VEvrdSAb0bYIQ6O9q2fTfg4=;
        b=oroPVetDsuXdmmlGe7LtTtft0sZ+jPWE2S11V1bck8HmWswCoNxhYnxVFSnkSx1b1bAO0V+frKfKKUUd2Vz5TXS7wSbu+52vMMH69zu3M6RWIJWUgzQmTCqy2yzDsLnomi0iaytQS0vtUEc5/pfbYZkrMvvgEZV7FxH6KAXphq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:a1edbffc-0933-4e36-b078-0fee829ea440,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:82506ffd-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5f3b04c4a2884e63824507c2f2463bff-20220816
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1643670109; Tue, 16 Aug 2022 14:53:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 14:53:46 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 14:53:46 +0800
From:   Runyang Chen <Runyang.Chen@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Runyang Chen" <runyang.chen@mediatek.com>
Subject: [PATCH v2 2/3] dt-bindings: reset: mt8188: add toprgu reset-controller header file
Date:   Tue, 16 Aug 2022 14:53:29 +0800
Message-ID: <20220816065330.27570-3-Runyang.Chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
References: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Runyang Chen <runyang.chen@mediatek.com>

Add toprgu reset-controller header file for MT8188

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
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

