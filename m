Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6783517EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiECHWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiECHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:22:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875AC3465B;
        Tue,  3 May 2022 00:18:30 -0700 (PDT)
X-UUID: 3162547f214840879f08ee6ecd67d4ae-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7d2376f6-b818-42d8-951a-31ceed8c07e6,OB:80,L
        OB:40,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ha
        m,ACTION:release,TS:80
X-CID-INFO: VERSION:1.1.4,REQID:7d2376f6-b818-42d8-951a-31ceed8c07e6,OB:80,LOB
        :40,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3
        D,ACTION:quarantine,TS:80
X-CID-META: VersionHash:faefae9,CLOUDID:c5cf4ac7-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:d2f05428c351,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 3162547f214840879f08ee6ecd67d4ae-20220503
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 649413000; Tue, 03 May 2022 15:18:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 3 May 2022 15:18:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:18:25 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
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
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v7 27/36] iommu/mediatek: Remove mtk_iommu.h
Date:   Tue, 3 May 2022 15:14:18 +0800
Message-ID: <20220503071427.2285-28-yong.wu@mediatek.com>
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

Currently there is a suspend structure in the header file. It's no need
to keep a header file only for this. Move these into the c file and rm
this header file.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c    | 14 +++++++++++++-
 drivers/iommu/mtk_iommu.h    | 32 --------------------------------
 drivers/iommu/mtk_iommu_v1.c | 11 ++++++++---
 3 files changed, 21 insertions(+), 36 deletions(-)
 delete mode 100644 drivers/iommu/mtk_iommu.h

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7383a5df6021..349640bcbd01 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/io-pgtable.h>
 #include <linux/list.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -30,7 +31,7 @@
 #include <asm/barrier.h>
 #include <soc/mediatek/smi.h>
 
-#include "mtk_iommu.h"
+#include <dt-bindings/memory/mtk-memory-port.h>
 
 #define REG_MMU_PT_BASE_ADDR			0x000
 #define MMU_PT_ADDR_MASK			GENMASK(31, 7)
@@ -166,6 +167,17 @@ struct mtk_iommu_iova_region {
 	unsigned long long	size;
 };
 
+struct mtk_iommu_suspend_reg {
+	u32			misc_ctrl;
+	u32			dcm_dis;
+	u32			ctrl_reg;
+	u32			int_control0;
+	u32			int_main_control;
+	u32			ivrp_paddr;
+	u32			vld_pa_rng;
+	u32			wr_len_ctrl;
+};
+
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat	m4u_plat;
 	u32			flags;
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
deleted file mode 100644
index 305243e18aa9..000000000000
--- a/drivers/iommu/mtk_iommu.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2015-2016 MediaTek Inc.
- * Author: Honghui Zhang <honghui.zhang@mediatek.com>
- */
-
-#ifndef _MTK_IOMMU_H_
-#define _MTK_IOMMU_H_
-
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/io-pgtable.h>
-#include <linux/iommu.h>
-#include <linux/spinlock.h>
-#include <soc/mediatek/smi.h>
-#include <dt-bindings/memory/mtk-memory-port.h>
-
-struct mtk_iommu_suspend_reg {
-	union {
-		u32			standard_axi_mode;/* v1 */
-		u32			misc_ctrl;/* v2 */
-	};
-	u32				dcm_dis;
-	u32				ctrl_reg;
-	u32				int_control0;
-	u32				int_main_control;
-	u32				ivrp_paddr;
-	u32				vld_pa_rng;
-	u32				wr_len_ctrl;
-};
-
-#endif
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 6d1c09c91e1f..3d1f0897d1cc 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -7,7 +7,6 @@
  *
  * Based on driver/iommu/mtk_iommu.c
  */
-#include <linux/memblock.h>
 #include <linux/bug.h>
 #include <linux/clk.h>
 #include <linux/component.h>
@@ -28,10 +27,9 @@
 #include <linux/spinlock.h>
 #include <asm/barrier.h>
 #include <asm/dma-iommu.h>
-#include <linux/init.h>
+#include <dt-bindings/memory/mtk-memory-port.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <soc/mediatek/smi.h>
-#include "mtk_iommu.h"
 
 #define REG_MMU_PT_BASE_ADDR			0x000
 
@@ -87,6 +85,13 @@
  */
 #define M2701_IOMMU_PGT_SIZE			SZ_4M
 
+struct mtk_iommu_suspend_reg {
+	u32			standard_axi_mode;
+	u32			dcm_dis;
+	u32			ctrl_reg;
+	u32			int_control0;
+};
+
 struct mtk_iommu_data {
 	void __iomem			*base;
 	int				irq;
-- 
2.18.0

