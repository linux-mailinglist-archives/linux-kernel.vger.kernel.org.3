Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386E8517EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiECHYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiECHXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:23:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9023B012;
        Tue,  3 May 2022 00:19:40 -0700 (PDT)
X-UUID: 9a9ff156d4cd4b99bf15c2ff5e2909ff-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:41b97459-c66c-420c-a2b5-a55ef473fc31,OB:100,
        LOB:90,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_H
        am,ACTION:release,TS:80
X-CID-INFO: VERSION:1.1.4,REQID:41b97459-c66c-420c-a2b5-a55ef473fc31,OB:100,LO
        B:90,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B
        3D,ACTION:quarantine,TS:80
X-CID-META: VersionHash:faefae9,CLOUDID:d0ca822f-6199-437e-8ab4-9920b4bc5b76,C
        OID:81ae93af5fc3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 9a9ff156d4cd4b99bf15c2ff5e2909ff-20220503
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1948023288; Tue, 03 May 2022 15:19:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 15:19:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:19:32 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, <yen-chang.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v7 36/36] iommu/mediatek: Add mt8186 iommu support
Date:   Tue, 3 May 2022 15:14:27 +0800
Message-ID: <20220503071427.2285-37-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
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

Add mt8186 iommu supports.

Signed-off-by: Anan Sun <anan.sun@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0fa1d5240ac6..71b2ace74cd6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -160,6 +160,7 @@ enum mtk_iommu_plat {
 	M4U_MT8167,
 	M4U_MT8173,
 	M4U_MT8183,
+	M4U_MT8186,
 	M4U_MT8192,
 	M4U_MT8195,
 };
@@ -1437,6 +1438,20 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
 };
 
+static const struct mtk_iommu_plat_data mt8186_data_mm = {
+	.m4u_plat       = M4U_MT8186,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN | MTK_IOMMU_TYPE_MM,
+	.larbid_remap   = {{0}, {1, MTK_INVALID_LARBID, 8}, {4}, {7}, {2}, {9, 11, 19, 20},
+			   {MTK_INVALID_LARBID, 14, 16},
+			   {MTK_INVALID_LARBID, 13, MTK_INVALID_LARBID, 17}},
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
+	.iova_region    = mt8192_multi_dom,
+	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+};
+
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1503,6 +1518,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
+	{ .compatible = "mediatek,mt8186-iommu-mm",    .data = &mt8186_data_mm}, /* mm: m4u */
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
-- 
2.18.0

