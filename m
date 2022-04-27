Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B188510F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357459AbiD0DP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357372AbiD0DPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:15:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688112AB1;
        Tue, 26 Apr 2022 20:12:26 -0700 (PDT)
X-UUID: 66b716581ac54497bb89dc9a0819c794-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a2da5397-fdc2-4111-aee8-ba475d7bcf6e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:a2da5397-fdc2-4111-aee8-ba475d7bcf6e,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:2303d42e-6199-437e-8ab4-9920b4bc5b76,C
        OID:c943d8bcd364,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 66b716581ac54497bb89dc9a0819c794-20220427
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 220203164; Wed, 27 Apr 2022 11:12:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 11:12:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 11:12:20 +0800
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
Subject: [PATCH V4 12/15] dt-bindings: reset: mediatek: Add infra_ao reset bit for MT8192/MT8195
Date:   Wed, 27 Apr 2022 11:09:47 +0800
Message-ID: <20220427030950.23395-13-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
References: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- To support reset of infra_ao, add the bit definition of
  thermal/PCIe/SVS for MT8192.
- To support reset of infra_ao, add the bit definition of
  thermal/SVS for MT8195.
- Add the driver comment to separate the reset index for
  TOPRGU and INFRA.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8192-resets.h | 8 ++++++++
 include/dt-bindings/reset/mt8195-resets.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
index be9a7ca245b9..ee0ca02a39bf 100644
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
+#define MT8192_INFRA_THERMAL_CTRL_RST			0
+#define MT8192_INFRA_PEXTP_PHY_RST				79
+#define MT8192_INFRA_PTP_RST					101
+#define MT8192_INFRA_RST4_PCIE_TOP				129
+#define MT8192_INFRA_THERMAL_CTRL_MCU_RST		140
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
index a26bccc8b957..a3226f40779c 100644
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
+#define MT8195_INFRA_THERMAL_AP_RST            0
+#define MT8195_INFRA_PTP_RST                   101
+#define MT8195_INFRA_THERMAL_MCU_RST           138
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8195 */
-- 
2.18.0

