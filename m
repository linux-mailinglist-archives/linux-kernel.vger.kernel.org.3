Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C116511175
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358245AbiD0Grw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiD0Grt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:47:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6F14AAED;
        Tue, 26 Apr 2022 23:44:38 -0700 (PDT)
X-UUID: 0e831889765141cfbd5a4d616a384566-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:64ab579e-179c-44fa-839d-4abc634e2573,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:3456a4c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 0e831889765141cfbd5a4d616a384566-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2093635598; Wed, 27 Apr 2022 14:44:34 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Apr 2022 14:44:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 14:44:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 14:44:32 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <moudy.ho@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v17 2/6] soc: mediatek: mutex: add 8183 MUTEX MOD settings for MDP
Date:   Wed, 27 Apr 2022 14:44:21 +0800
Message-ID: <20220427064425.30383-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220427064425.30383-1-moudy.ho@mediatek.com>
References: <20220427064425.30383-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the purpose of module independence, related settings should be moved
from MDP to the corresponding driver.
This patch adds 8183 MUTEX MOD settings for MDP.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index a62ac1811419..92afdee14d43 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -80,6 +80,15 @@
 #define MT8183_MUTEX_MOD_DISP_GAMMA0		16
 #define MT8183_MUTEX_MOD_DISP_DITHER0		17
 
+#define MT8183_MUTEX_MOD_MDP_RDMA0		2
+#define MT8183_MUTEX_MOD_MDP_RSZ0		4
+#define MT8183_MUTEX_MOD_MDP_RSZ1		5
+#define MT8183_MUTEX_MOD_MDP_TDSHP0		6
+#define MT8183_MUTEX_MOD_MDP_WROT0		7
+#define MT8183_MUTEX_MOD_MDP_WDMA		8
+#define MT8183_MUTEX_MOD_MDP_AAL0		23
+#define MT8183_MUTEX_MOD_MDP_CCORR0		24
+
 #define MT8173_MUTEX_MOD_DISP_OVL0		11
 #define MT8173_MUTEX_MOD_DISP_OVL1		12
 #define MT8173_MUTEX_MOD_DISP_RDMA0		13
@@ -245,6 +254,17 @@ static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
 };
 
+static const unsigned int mt8183_mutex_table_mod[MUTEX_TABLE_IDX_MAX] = {
+	[MUTEX_TABLE_IDX_MDP_RDMA0] = MT8183_MUTEX_MOD_MDP_RDMA0,
+	[MUTEX_TABLE_IDX_MDP_RSZ0] = MT8183_MUTEX_MOD_MDP_RSZ0,
+	[MUTEX_TABLE_IDX_MDP_RSZ1] = MT8183_MUTEX_MOD_MDP_RSZ1,
+	[MUTEX_TABLE_IDX_MDP_TDSHP0] = MT8183_MUTEX_MOD_MDP_TDSHP0,
+	[MUTEX_TABLE_IDX_MDP_WROT0] = MT8183_MUTEX_MOD_MDP_WROT0,
+	[MUTEX_TABLE_IDX_MDP_WDMA] = MT8183_MUTEX_MOD_MDP_WDMA,
+	[MUTEX_TABLE_IDX_MDP_AAL0] = MT8183_MUTEX_MOD_MDP_AAL0,
+	[MUTEX_TABLE_IDX_MDP_CCORR0] = MT8183_MUTEX_MOD_MDP_CCORR0,
+};
+
 static const unsigned int mt8186_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8186_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8186_MUTEX_MOD_DISP_CCORR0,
@@ -296,6 +316,17 @@ static const unsigned int mt8183_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
 };
 
+static const unsigned int mt8183_mutex_table_sof[MUTEX_TABLE_IDX_MAX] = {
+	[MUTEX_TABLE_IDX_MDP_RDMA0] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_TABLE_IDX_MDP_RSZ0] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_TABLE_IDX_MDP_RSZ1] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_TABLE_IDX_MDP_TDSHP0] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_TABLE_IDX_MDP_WROT0] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_TABLE_IDX_MDP_WDMA] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_TABLE_IDX_MDP_AAL0] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_TABLE_IDX_MDP_CCORR0] = MUTEX_SOF_SINGLE_MODE,
+};
+
 static const unsigned int mt8186_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MT8186_MUTEX_SOF_DSI0 | MT8186_MUTEX_EOF_DSI0,
@@ -336,6 +367,8 @@ static const struct mtk_mutex_data mt8183_mutex_driver_data = {
 	.mutex_sof = mt8183_mutex_sof,
 	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
 	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+	.mutex_table_mod = mt8183_mutex_table_mod,
+	.mutex_table_sof = mt8183_mutex_table_sof,
 	.no_clk = true,
 };
 
-- 
2.18.0

