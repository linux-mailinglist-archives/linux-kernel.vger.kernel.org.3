Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195F520F23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiEJH5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiEJH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:56:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC624311B;
        Tue, 10 May 2022 00:52:51 -0700 (PDT)
X-UUID: 3a21be4c2df748408c5cd2210c194c96-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:ad2caa75-2fdd-496b-8f09-3d6ada36a1b4,OB:10,L
        OB:30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:ad2caa75-2fdd-496b-8f09-3d6ada36a1b4,OB:10,LOB
        :30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:87fd3eb3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:930e672098a6,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 3a21be4c2df748408c5cd2210c194c96-20220510
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 881518546; Tue, 10 May 2022 15:52:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 15:52:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 10 May 2022 15:52:45 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v10 3/4] dt-bindings: arm: Add compatible for MediaTek MT8186
Date:   Tue, 10 May 2022 15:52:32 +0800
Message-ID: <20220510075233.5426-4-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220510075233.5426-1-allen-kh.cheng@mediatek.com>
References: <20220510075233.5426-1-allen-kh.cheng@mediatek.com>
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

This commit adds dt-binding documentation for the MediaTek MT8186
reference board.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4a2bd9759c47..5a29b7b381ef 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -131,6 +131,10 @@ properties:
           - enum:
               - mediatek,mt8183-evb
           - const: mediatek,mt8183
+      - items:
+          - enum:
+              - mediatek,mt8186-evb
+          - const: mediatek,mt8186
       - items:
           - enum:
               - mediatek,mt8192-evb
-- 
2.18.0

