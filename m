Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B6854F44A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380438AbiFQJbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiFQJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:31:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99566350A;
        Fri, 17 Jun 2022 02:31:41 -0700 (PDT)
X-UUID: fa6f525aee11493e833640cf55cf81a9-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:1929c5ef-431d-491c-abbe-02c1b031b1ff,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:2b0be648-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: fa6f525aee11493e833640cf55cf81a9-20220617
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 769793879; Fri, 17 Jun 2022 17:31:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 17 Jun 2022 17:31:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jun 2022 17:31:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/4] dt-bindings: nvmem: mediatek: efuse: add support mt8183
Date:   Fri, 17 Jun 2022 17:31:30 +0800
Message-ID: <20220617093132.22578-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617093132.22578-1-chunfeng.yun@mediatek.com>
References: <20220617093132.22578-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "mediatek,mt8183-efuse" to fix dtbs check warning.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v6: add acked-by Rob
v5: new patch
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index f6e01ddb7499..7c7233e29ecf 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -28,6 +28,7 @@ properties:
               - mediatek,mt7622-efuse
               - mediatek,mt7623-efuse
               - mediatek,mt8173-efuse
+              - mediatek,mt8183-efuse
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
               - mediatek,mt8516-efuse
-- 
2.18.0

