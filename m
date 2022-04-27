Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23801510F90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357481AbiD0Dey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiD0Dev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:34:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044183E5FD;
        Tue, 26 Apr 2022 20:31:39 -0700 (PDT)
X-UUID: 61da1a5d0516438bb599e74421a5e0f2-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:00822b95-e747-4fa7-a0a4-34dcb58f2ebe,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:50cd9cc6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 61da1a5d0516438bb599e74421a5e0f2-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1514958782; Wed, 27 Apr 2022 11:31:34 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 11:31:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 11:31:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 11:31:32 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2] dt-bindings: media: mtk-vcodec: Adds encoder power domain property
Date:   Wed, 27 Apr 2022 11:31:30 +0800
Message-ID: <20220427033130.18497-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds encoder power domain property.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
changes compared with v1:
- set "power-domains" as a non-required property

The 'make dtbs_check' warnings('mediatek,larb') can be fixed by patch:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=633993
---
 .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index deb5b657a2d5..2d1e0c9bd6ee 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -41,6 +41,9 @@ properties:
 
   assigned-clock-parents: true
 
+  power-domains:
+    maxItems: 1
+
   iommus:
     minItems: 1
     maxItems: 32
@@ -132,6 +135,7 @@ examples:
     #include <dt-bindings/clock/mt8173-clk.h>
     #include <dt-bindings/memory/mt8173-larb-port.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mt8173-power.h>
 
     vcodec_enc_avc: vcodec@18002000 {
       compatible = "mediatek,mt8173-vcodec-enc";
@@ -153,6 +157,7 @@ examples:
       clock-names = "venc_sel";
       assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
       assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
+      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
     };
 
     vcodec_enc_vp8: vcodec@19002000 {
@@ -173,4 +178,5 @@ examples:
       clock-names = "venc_lt_sel";
       assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
       assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
+      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
     };
-- 
2.18.0

