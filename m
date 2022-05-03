Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2496518159
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiECJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiECJmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:42:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC453204F;
        Tue,  3 May 2022 02:39:08 -0700 (PDT)
X-UUID: 094c39c9956945e0acc3341aef8e0f7a-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8cfb887f-f45a-4f80-be43-160a1121c354,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:97e4872f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 094c39c9956945e0acc3341aef8e0f7a-20220503
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1362401295; Tue, 03 May 2022 17:39:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 17:39:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 3 May 2022 17:39:00 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v6 13/16] dt-bindings: reset: mediatek: Add infra_ao reset index for MT8192/MT8195
Date:   Tue, 3 May 2022 17:38:53 +0800
Message-ID: <20220503093856.22250-14-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
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

To support reset of infra_ao, add the index of infra_ao reset of
thermal/svs/pcei for MT8192 and thermal/svs for MT8195.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8192-resets.h | 8 ++++++++
 include/dt-bindings/reset/mt8195-resets.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
index be9a7ca245b9..1779ff6a832e 100644
--- a/include/dt-bindings/reset/mt8192-resets.h
+++ b/include/dt-bindings/reset/mt8192-resets.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
 #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
 
+/* TOPRGU resets */
 #define MT8192_TOPRGU_MM_SW_RST					1
 #define MT8192_TOPRGU_MFG_SW_RST				2
 #define MT8192_TOPRGU_VENC_SW_RST				3
@@ -27,4 +28,11 @@
 
 #define MT8192_TOPRGU_SW_RST_NUM				23
 
+/* INFRA resets */
+#define MT8192_INFRA_RST0_THERM_CTRL_SWRST		0
+#define MT8192_INFRA_RST2_PEXTP_PHY_SWRST		1
+#define MT8192_INFRA_RST3_THERM_CTRL_PTP_SWRST	2
+#define MT8192_INFRA_RST4_PCIE_TOP_SWRST		3
+#define MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST	4
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
index a26bccc8b957..0b1937f14b36 100644
--- a/include/dt-bindings/reset/mt8195-resets.h
+++ b/include/dt-bindings/reset/mt8195-resets.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8195
 #define _DT_BINDINGS_RESET_CONTROLLER_MT8195
 
+/* TOPRGU resets */
 #define MT8195_TOPRGU_CONN_MCU_SW_RST          0
 #define MT8195_TOPRGU_INFRA_GRST_SW_RST        1
 #define MT8195_TOPRGU_APU_SW_RST               2
@@ -26,4 +27,9 @@
 
 #define MT8195_TOPRGU_SW_RST_NUM               16
 
+/* INFRA resets */
+#define MT8195_INFRA_RST0_THERM_CTRL_SWRST     0
+#define MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST 1
+#define MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST 2
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8195 */
-- 
2.18.0

