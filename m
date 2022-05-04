Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B6519EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349132AbiEDL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiEDL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:58:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524D2CE25;
        Wed,  4 May 2022 04:55:09 -0700 (PDT)
X-UUID: a5790e3afd42459396b997f3f40f1ca8-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:1cf93376-e68b-41e0-906d-ee2c1d9152e4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:363a2b16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: a5790e3afd42459396b997f3f40f1ca8-20220504
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 425391039; Wed, 04 May 2022 19:55:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 19:55:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 4 May 2022 19:55:03 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <runyang.chen@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 3/3] soc: mediatek: devapc: Add support for MT8186
Date:   Wed, 4 May 2022 19:55:01 +0800
Message-ID: <20220504115501.3490-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devapc data and compatible to support MT8186 devapc.

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index f27e22cbb770..fc13334db1b1 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -234,10 +234,18 @@ static const struct mtk_devapc_data devapc_mt6779 = {
 	.regs_ofs = &devapc_regs_ofs_mt6779,
 };
 
+static const struct mtk_devapc_data devapc_mt8186 = {
+	.vio_idx_num = 519,
+	.regs_ofs = &devapc_regs_ofs_mt6779,
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

