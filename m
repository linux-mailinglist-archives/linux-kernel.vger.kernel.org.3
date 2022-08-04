Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA02158960C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbiHDCRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiHDCQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:16:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF35FACD;
        Wed,  3 Aug 2022 19:16:03 -0700 (PDT)
X-UUID: 724f2b5033614715ab0b907d44318a3e-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8O6G4k4vMW79Saml4R4eo//c6gNNaw0fDyOgHkkdvtw=;
        b=oo92lFEFJnHArzipuSbcdTLGktGOlhNc+oOm9guB3+eGSNAWOWSTkoA+h6Jz/L3ihSqpWP1Id/ObCMIzhU2xkEMdQxDHi/YizNcvfVj9BH7nspTILiZcLQkve8pHWtdbB2cFbNoVAcIwbKY9ELJ3ebmQSGhKTUl5O2FgAFysWEg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:b8cfe660-8124-4e03-beab-93826efaf06d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:b8cfe660-8124-4e03-beab-93826efaf06d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:14c03bd0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:e2aee46074ee,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 724f2b5033614715ab0b907d44318a3e-20220804
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1621848889; Thu, 04 Aug 2022 10:15:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 4 Aug 2022 10:15:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 10:15:55 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update condition for mt8195 smi node
Date:   Thu, 4 Aug 2022 10:15:35 +0800
Message-ID: <20220804021553.14867-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220804021553.14867-1-tinghan.shen@mediatek.com>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max clock items for the dts node with compatible
'mediatek,mt8195-smi-sub-common' should be 3.

However, the dtbs_check of such node will get following message,
arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names:
 ['apb', 'smi', 'gals0'] is too long
         From schema:
 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml

It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
matches the 'else' conditions for gen2 HW without gals.

Rewrite the 'else' condition to specifically identify the compatibles
that utilizing gen2 HW without gals.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../memory-controllers/mediatek,smi-common.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git
 a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
 b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 71bc5cefb49cf..4f5dd0a20109e 100644
---
 a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++
 b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -144,7 +144,16 @@ allOf:
             - const: gals0
             - const: gals1
 
-    else:  # for gen2 HW that don't have gals
+  - if:  # for gen2 HW that don't have gals
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt2712-smi-common
+            - mediatek,mt6795-smi-common
+            - mediatek,mt8167-smi-common
+            - mediatek,mt8173-smi-common
+
+    then:
       properties:
         clocks:
           minItems: 2
-- 
2.18.0

