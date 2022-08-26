Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262EC5A245A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbiHZJ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343717AbiHZJ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:29:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2746B5A44;
        Fri, 26 Aug 2022 02:29:17 -0700 (PDT)
X-UUID: 19571836805f47a9ac453343de0445c4-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4RayBIx8fpgv/JRMfqcE3Iv+08TaIj0FKXAYZOJDnL4=;
        b=O1tRFQKBt1OjBVns60fxdOwmvEFacV8hADMMs7pizps+8YTUdZJZAdxCpsSubn1kFIECLF/Qe/SvBi/wWsVfMNMlMqWdkaut8Lop75qNWvOKQatmR576n7iGtCMz9E8IMgcrCKgRbwH3la4eBDoBKN3mA1Z/Zyo2Yo/8mPkEO40=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:44936b1f-bb89-4aed-94e7-71b18ade8c6c,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:7c49b4cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 19571836805f47a9ac453343de0445c4-20220826
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 614222849; Fri, 26 Aug 2022 17:29:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 17:29:10 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 17:29:09 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>
Subject: [V7,2/8] media: mtk-jpegdec: export jpeg decoder functions
Date:   Fri, 26 Aug 2022 17:28:58 +0800
Message-ID: <20220826092904.10283-3-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826092904.10283-1-irui.wang@mediatek.com>
References: <20220826092904.10283-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

mtk jpeg decoder is built as a module, export some functions to make them
visible by other modules.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 1e3852295f2f..d2f25f43e852 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -189,6 +189,7 @@ int mtk_jpeg_dec_fill_param(struct mtk_jpeg_dec_param *param)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_dec_fill_param);
 
 u32 mtk_jpeg_dec_get_int_status(void __iomem *base)
 {
@@ -200,6 +201,7 @@ u32 mtk_jpeg_dec_get_int_status(void __iomem *base)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_dec_get_int_status);
 
 u32 mtk_jpeg_dec_enum_result(u32 irq_result)
 {
@@ -216,11 +218,13 @@ u32 mtk_jpeg_dec_enum_result(u32 irq_result)
 
 	return MTK_JPEG_DEC_RESULT_ERROR_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_dec_enum_result);
 
 void mtk_jpeg_dec_start(void __iomem *base)
 {
 	writel(0, base + JPGDEC_REG_TRIG);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_dec_start);
 
 static void mtk_jpeg_dec_soft_reset(void __iomem *base)
 {
@@ -240,6 +244,7 @@ void mtk_jpeg_dec_reset(void __iomem *base)
 	mtk_jpeg_dec_soft_reset(base);
 	mtk_jpeg_dec_hard_reset(base);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_dec_reset);
 
 static void mtk_jpeg_dec_set_brz_factor(void __iomem *base, u8 yscale_w,
 					u8 yscale_h, u8 uvscale_w, u8 uvscale_h)
@@ -408,3 +413,4 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
 				   config->dma_last_mcu);
 	mtk_jpeg_dec_set_pause_mcu_idx(base, config->total_mcu);
 }
+EXPORT_SYMBOL_GPL(mtk_jpeg_dec_set_config);
-- 
2.18.0

