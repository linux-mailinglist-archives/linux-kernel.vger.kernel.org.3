Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE55142B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354822AbiD2G6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354780AbiD2G5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:57:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31959BCB54;
        Thu, 28 Apr 2022 23:54:37 -0700 (PDT)
X-UUID: ab076c800ea84e508dbe950d5233044f-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6c4b6a1f-b654-4e54-a69a-bd4651bef31c,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:6c4b6a1f-b654-4e54-a69a-bd4651bef31c,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:fb0ceec6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:30f2562fabcb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: ab076c800ea84e508dbe950d5233044f-20220429
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 22640415; Fri, 29 Apr 2022 14:54:32 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 29 Apr 2022 14:54:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Apr 2022 14:54:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 14:54:30 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <neal.liu@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 2/2] soc: mediatek: devapc: Add support for MT8186
Date:   Fri, 29 Apr 2022 14:54:29 +0800
Message-ID: <20220429065429.7957-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
References: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
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

Add devapc data and compatible to support MT8186 devapc.

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 7c65ad3d1f8a..762e0e4d967d 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -227,10 +227,25 @@ static const struct mtk_devapc_data devapc_mt6779 = {
 	.vio_shift_con_offset = 0xF20,
 };
 
+static const struct mtk_devapc_data devapc_mt8186 = {
+	.vio_idx_num = 519,
+	.vio_mask_offset = 0x0,
+	.vio_sta_offset = 0x400,
+	.vio_dbg0_offset = 0x900,
+	.vio_dbg1_offset = 0x904,
+	.apc_con_offset = 0xF00,
+	.vio_shift_sta_offset = 0xF10,
+	.vio_shift_sel_offset = 0xF14,
+	.vio_shift_con_offset = 0xF20,
+};
+
 static const struct of_device_id mtk_devapc_dt_match[] = {
 	{
 		.compatible = "mediatek,mt6779-devapc",
 		.data = &devapc_mt6779,
+	}, {
+		.compatible = "mediatek,mt8186-devapc",
+		.data = &devapc_mt8186,
 	}, {
 	},
 };
-- 
2.18.0

