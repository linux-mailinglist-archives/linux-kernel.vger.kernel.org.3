Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4791657FEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiGYMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiGYMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:03:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA342186C5;
        Mon, 25 Jul 2022 05:03:35 -0700 (PDT)
X-UUID: 56201015ffa34e81bfc7c1236bbeebb2-20220725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:3b198551-7a35-4a20-adb4-6a1bd8852cb8,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:3b198551-7a35-4a20-adb4-6a1bd8852cb8,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:1991e1d3-912a-458b-a623-74f605a77e93,C
        OID:bafac9dde7aa,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 56201015ffa34e81bfc7c1236bbeebb2-20220725
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 617418347; Mon, 25 Jul 2022 20:03:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 25 Jul 2022 20:03:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 25 Jul 2022 20:03:30 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <broonie@kernel.org>
CC:     <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bin.zhang@mediatek.com>,
        <benliang.zhao@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V5] dt-bindings: mediatek: Add axi clock in mt8173 dts example
Date:   Mon, 25 Jul 2022 20:02:05 +0800
Message-ID: <20220725120204.10834-1-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For mt8173, it is needed to add the axi clock for dma mode.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
 ---
 Changes from v4:
 - none
 
 Changes from v3:
 - fix number of column characters

 Changes from v2:
 - remove assigned clocks and parents in dt-binding

 Changes from v1:
 - none
---
 .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml        | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 41e60fe4b09f..d3d7ed4b497b 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -82,8 +82,9 @@ examples:
         compatible = "mediatek,mt8173-nor";
         reg = <0 0x1100d000 0 0xe0>;
         interrupts = <1>;
-        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
-        clock-names = "spi", "sf";
+        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>,
+                 <&pericfg CLK_PERI_NFI>;
+        clock-names = "spi", "sf", "axi";
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.25.1

