Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74F74F64F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiDFQSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiDFQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:18:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146DD5DA0B;
        Tue,  5 Apr 2022 20:01:29 -0700 (PDT)
X-UUID: e6ccae8af3fd40b3b75dfc2ca45ccbe8-20220406
X-UUID: e6ccae8af3fd40b3b75dfc2ca45ccbe8-20220406
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 923372643; Wed, 06 Apr 2022 11:01:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Apr 2022 11:00:13 +0800
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
Subject: [PATCH v10 3/4] dt-bindings: display: mediatek: add MT8186 SoC binding
Date:   Wed, 6 Apr 2022 11:00:08 +0800
Message-ID: <20220406030009.2357-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220406030009.2357-1-rex-bc.chen@mediatek.com>
References: <20220406030009.2357-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8186 SoC binding to AAL, CCORR, COLOR, DITHER, GAMMA, MUTEX,
OVL, POSTMASK and RDMA.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,aal.yaml    | 4 ++++
 .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml  | 4 ++++
 .../devicetree/bindings/display/mediatek/mediatek,color.yaml  | 1 +
 .../devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
 .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml  | 1 +
 .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml  | 1 +
 .../devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml | 4 ++++
 .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml    | 4 ++++
 .../bindings/display/mediatek/mediatek,postmask.yaml          | 4 ++++
 .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml   | 1 +
 10 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index cdb6d0819cca..cb4a2f39ff88 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -30,6 +30,10 @@ properties:
               - mediatek,mt8192-disp-aal
               - mediatek,mt8195-disp-aal
           - const: mediatek,mt8173-disp-aal
+      - items:
+          - enum:
+              - mediatek,mt8186-disp-aal
+          - const: mediatek,mt8183-disp-aal
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index 7766c806c102..63fb02014a56 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -29,6 +29,10 @@ properties:
           - enum:
               - mediatek,mt8195-disp-ccorr
           - const: mediatek,mt8192-disp-ccorr
+      - items:
+          - enum:
+              - mediatek,mt8186-disp-ccorr
+          - const: mediatek,mt8183-disp-ccorr
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
index 0c9095b0411e..d2f89ee7996f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
@@ -36,6 +36,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8183-disp-color
+              - mediatek,mt8186-disp-color
               - mediatek,mt8192-disp-color
               - mediatek,mt8195-disp-color
           - const: mediatek,mt8173-disp-color
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 8180ed0a89ff..8ad8187c02d1 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -26,6 +26,7 @@ properties:
           - const: mediatek,mt8183-disp-dither
       - items:
           - enum:
+              - mediatek,mt8186-disp-dither
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
           - const: mediatek,mt8183-disp-dither
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index 5f1825b4512b..a89ea0ea7542 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -27,6 +27,7 @@ properties:
           - const: mediatek,mt8183-disp-gamma
       - items:
           - enum:
+              - mediatek,mt8186-disp-gamma
               - mediatek,mt8192-disp-gamma
               - mediatek,mt8195-disp-gamma
           - const: mediatek,mt8183-disp-gamma
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
index b470fbb1b40a..3fdad71210b4 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
@@ -29,6 +29,7 @@ properties:
       - mediatek,mt8167-disp-mutex
       - mediatek,mt8173-disp-mutex
       - mediatek,mt8183-disp-mutex
+      - mediatek,mt8186-disp-mutex
       - mediatek,mt8192-disp-mutex
       - mediatek,mt8195-disp-mutex
 
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
index da999ba53b7c..4e94f4e947ad 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
@@ -25,6 +25,10 @@ properties:
           - const: mediatek,mt8183-disp-ovl-2l
       - items:
           - const: mediatek,mt8192-disp-ovl-2l
+      - items:
+          - enum:
+              - mediatek,mt8186-disp-ovl-2l
+          - const: mediatek,mt8192-disp-ovl-2l
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index 51f8235f1b1b..a2a27d0ca038 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -38,6 +38,10 @@ properties:
           - enum:
               - mediatek,mt8195-disp-ovl
           - const: mediatek,mt8183-disp-ovl
+      - items:
+          - enum:
+              - mediatek,mt8186-disp-ovl
+          - const: mediatek,mt8192-disp-ovl
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
index 2d769422e29f..654080bfbdfb 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
@@ -23,6 +23,10 @@ properties:
     oneOf:
       - items:
           - const: mediatek,mt8192-disp-postmask
+      - items:
+          - enum:
+              - mediatek,mt8186-disp-postmask
+          - const: mediatek,mt8192-disp-postmask
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index 9a6756f185ee..0882ae86e6c4 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -38,6 +38,7 @@ properties:
           - const: mediatek,mt2701-disp-rdma
       - items:
           - enum:
+              - mediatek,mt8186-disp-rdma
               - mediatek,mt8192-disp-rdma
           - const: mediatek,mt8183-disp-rdma
 
-- 
2.18.0

