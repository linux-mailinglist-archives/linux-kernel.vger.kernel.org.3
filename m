Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9C57C1FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiGUBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiGUBtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:49:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC1491FD;
        Wed, 20 Jul 2022 18:49:01 -0700 (PDT)
X-UUID: 3f71d9de29f44b5385516fb30577435b-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:2c02b54f-933e-42a3-8ee4-5fc1dd5811e9,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:2c02b54f-933e-42a3-8ee4-5fc1dd5811e9,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:16ded764-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:06119f92b37c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3f71d9de29f44b5385516fb30577435b-20220721
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 912515045; Thu, 21 Jul 2022 09:48:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 21 Jul 2022 09:48:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jul 2022 09:48:55 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible fallbacks and example
Date:   Thu, 21 Jul 2022 09:48:42 +0800
Message-ID: <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog timer of mt8186. mt8195 and mt7986 have their DT data.
We should not use 'mediatek,mt6589-wdt' as fallback.

For mediatek,wdt example of mt8183, We remove mediatek,mt6589-wdt fallback.

Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for MediaTek MT8186")
Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for Mediatek MT8195")
Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for Mediatek MT7986")
Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add #reset-cells")
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 762c62e428ef..67ef991ec4cf 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -14,12 +14,12 @@ Required properties:
 	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
 	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
 	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
-	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
+	"mediatek,mt7986-wdt": for MT7986
 	"mediatek,mt8183-wdt": for MT8183
-	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
+	"mediatek,mt8186-wdt": for MT8186
 	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
 	"mediatek,mt8192-wdt": for MT8192
-	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
+	"mediatek,mt8195-wdt": for MT8195
 
 - reg : Specifies base physical address and size of the registers.
 
@@ -32,8 +32,7 @@ Optional properties:
 Example:
 
 watchdog: watchdog@10007000 {
-	compatible = "mediatek,mt8183-wdt",
-		     "mediatek,mt6589-wdt";
+	compatible = "mediatek,mt8183-wdt";
 	mediatek,disable-extrst;
 	reg = <0 0x10007000 0 0x100>;
 	interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
-- 
2.18.0

