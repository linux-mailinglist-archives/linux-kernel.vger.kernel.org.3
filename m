Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA8530D62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiEWJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiEWJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:34:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4549F89;
        Mon, 23 May 2022 02:34:03 -0700 (PDT)
X-UUID: 50954336da7648ed8445a24754e6de17-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f05a2095-2aab-4608-bc4e-4c123ca89930,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:f05a2095-2aab-4608-bc4e-4c123ca89930,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:b8f6477a-5ef6-470b-96c9-bdb8ced32786,C
        OID:b76fb2c8b435,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 50954336da7648ed8445a24754e6de17-20220523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1127135092; Mon, 23 May 2022 17:33:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 23 May 2022 17:33:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 17:33:49 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <chun-jie.chen@mediatek.com>,
        <wenst@chromium.org>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND v8 13/19] dt-bindings: reset: mediatek: Add infra_ao reset index for MT8192/MT8195
Date:   Mon, 23 May 2022 17:33:40 +0800
Message-ID: <20220523093346.28493-14-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[Nícolas: Test for MT8192]
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 include/dt-bindings/reset/mt8192-resets.h | 8 ++++++++
 include/dt-bindings/reset/mt8195-resets.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-bindings/reset/mt8192-resets.h
index 764ca9910fa9..12e2087c90a3 100644
--- a/include/dt-bindings/reset/mt8192-resets.h
+++ b/include/dt-bindings/reset/mt8192-resets.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
 #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
 
+/* TOPRGU resets */
 #define MT8192_TOPRGU_MM_SW_RST					1
 #define MT8192_TOPRGU_MFG_SW_RST				2
 #define MT8192_TOPRGU_VENC_SW_RST				3
@@ -30,4 +31,11 @@
 /* MMSYS resets */
 #define MT8192_MMSYS_SW0_RST_B_DISP_DSI0			15
 
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

