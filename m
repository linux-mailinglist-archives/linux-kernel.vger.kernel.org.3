Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9264F5AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiDFJow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376358AbiDFJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:41:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8981F132E8A;
        Tue,  5 Apr 2022 20:02:02 -0700 (PDT)
X-UUID: b04ca12b9a994c618484c9721c598ed3-20220406
X-UUID: b04ca12b9a994c618484c9721c598ed3-20220406
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 656686267; Wed, 06 Apr 2022 11:01:41 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 6 Apr 2022 11:00:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Apr
 2022 11:00:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 11:00:13 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <jassisinghbrar@gmail.com>,
        <fparent@baylibre.com>, <yongqiang.niu@mediatek.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v10 2/4] dt-bindings: display: mediatek: change to use enum for mutex
Date:   Wed, 6 Apr 2022 11:00:07 +0800
Message-ID: <20220406030009.2357-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220406030009.2357-1-rex-bc.chen@mediatek.com>
References: <20220406030009.2357-1-rex-bc.chen@mediatek.com>
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

All single entry cases in mutex can be merged as a single enum.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../display/mediatek/mediatek,mutex.yaml      | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
index 00e6a1041a9b..b470fbb1b40a 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
@@ -23,21 +23,15 @@ description: |
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt2701-disp-mutex
-      - items:
-          - const: mediatek,mt2712-disp-mutex
-      - items:
-          - const: mediatek,mt8167-disp-mutex
-      - items:
-          - const: mediatek,mt8173-disp-mutex
-      - items:
-          - const: mediatek,mt8183-disp-mutex
-      - items:
-          - const: mediatek,mt8192-disp-mutex
-      - items:
-          - const: mediatek,mt8195-disp-mutex
+    enum:
+      - mediatek,mt2701-disp-mutex
+      - mediatek,mt2712-disp-mutex
+      - mediatek,mt8167-disp-mutex
+      - mediatek,mt8173-disp-mutex
+      - mediatek,mt8183-disp-mutex
+      - mediatek,mt8192-disp-mutex
+      - mediatek,mt8195-disp-mutex
+
   reg:
     maxItems: 1
 
-- 
2.18.0

