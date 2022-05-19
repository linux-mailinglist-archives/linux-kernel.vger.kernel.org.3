Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D719052D345
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbiESM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiESMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:55:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85FA889B;
        Thu, 19 May 2022 05:55:36 -0700 (PDT)
X-UUID: 59c2aabd86074cb3bc2b35b21c0af5ba-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:047f56b0-595a-461d-986e-069a7809a09d,OB:20,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:047f56b0-595a-461d-986e-069a7809a09d,OB:20,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:2e8ccfe2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:63ae97993cc8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 59c2aabd86074cb3bc2b35b21c0af5ba-20220519
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 27516275; Thu, 19 May 2022 20:55:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 19 May 2022 20:55:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 20:55:31 +0800
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
Subject: [PATCH v7 17/19] dt-bindings: reset: mediatek: Add infra_ao reset index for MT8186
Date:   Thu, 19 May 2022 20:55:25 +0800
Message-ID: <20220519125527.18544-18-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
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
thermal/svs for MT8186.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 include/dt-bindings/reset/mt8186-resets.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/mt8186-resets.h b/include/dt-bindings/reset/mt8186-resets.h
index 5f850370c42c..2e9029c22f38 100644
--- a/include/dt-bindings/reset/mt8186-resets.h
+++ b/include/dt-bindings/reset/mt8186-resets.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8186
 #define _DT_BINDINGS_RESET_CONTROLLER_MT8186
 
+/* TOPRGU resets */
 #define MT8186_TOPRGU_INFRA_SW_RST				0
 #define MT8186_TOPRGU_MM_SW_RST					1
 #define MT8186_TOPRGU_MFG_SW_RST				2
@@ -33,4 +34,8 @@
 /* MMSYS resets */
 #define MT8186_MMSYS_SW0_RST_B_DISP_DSI0			19
 
+/* INFRA resets */
+#define MT8186_INFRA_THERMAL_CTRL_RST			0
+#define MT8186_INFRA_PTP_CTRL_RST				1
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8186 */
-- 
2.18.0

