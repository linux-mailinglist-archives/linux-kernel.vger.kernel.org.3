Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED054CE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355635AbiFOQTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355053AbiFOQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:19:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC364E3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:19:30 -0700 (PDT)
X-UUID: 2bda6adaf21547a9ae64f1e74e363d0d-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:03543455-41f7-4a9b-b92c-4c064885672b,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:03543455-41f7-4a9b-b92c-4c064885672b,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:9b5a5bf6-e099-41ba-a32c-13b8bfe63214,C
        OID:706f55ac7a6a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 2bda6adaf21547a9ae64f1e74e363d0d-20220616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1094555626; Thu, 16 Jun 2022 00:19:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 00:19:23 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 16 Jun 2022 00:19:22 +0800
From:   <yf.wang@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Subject: [PATCH v9 2/3] iommu/mediatek: Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR
Date:   Thu, 16 Jun 2022 00:12:22 +0800
Message-ID: <20220615161224.6923-3-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220615161224.6923-1-yf.wang@mediatek.com>
References: <20220615161224.6923-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Wang <yf.wang@mediatek.com>

Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR, and update MTK_IOMMU_ADDR
definition for better generality.

Signed-off-by: Ning Li <ning.li@mediatek.com>
Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bb9dd92c9898..3d62399e8865 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -265,8 +265,8 @@ static const struct iommu_ops mtk_iommu_ops;
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int bankid);
 
-#define MTK_IOMMU_TLB_ADDR(iova) ({					\
-	dma_addr_t _addr = iova;					\
+#define MTK_IOMMU_ADDR(addr) ({						\
+	unsigned long long _addr = addr;				\
 	((lower_32_bits(_addr) & GENMASK(31, 12)) | upper_32_bits(_addr));\
 })
 
@@ -381,8 +381,8 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       base + data->plat_data->inv_sel_reg);
 
-		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova), base + REG_MMU_INVLD_START_A);
-		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
+		writel_relaxed(MTK_IOMMU_ADDR(iova), base + REG_MMU_INVLD_START_A);
+		writel_relaxed(MTK_IOMMU_ADDR(iova + size - 1),
 			       base + REG_MMU_INVLD_END_A);
 		writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
 
-- 
2.18.0

