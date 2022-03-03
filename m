Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A893E4CB737
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiCCGxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiCCGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:53:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7316A5A8;
        Wed,  2 Mar 2022 22:52:16 -0800 (PST)
X-UUID: aa161c9d848341e992b21e21e65b033c-20220303
X-UUID: aa161c9d848341e992b21e21e65b033c-20220303
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 321541081; Thu, 03 Mar 2022 14:52:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 3 Mar 2022 14:52:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 14:52:08 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <yongqiang.niu@mediatek.com>, <hsinyi@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V6 2/5] dt-bindings: display: mediatek: revise enum to const
Date:   Thu, 3 Mar 2022 14:51:32 +0800
Message-ID: <20220303065205.22971-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220303065205.22971-1-rex-bc.chen@mediatek.com>
References: <20220303065205.22971-1-rex-bc.chen@mediatek.com>
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

There won't be more than 1 fallback for these bindings, so we modify
them to use const instead of enum.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,aal.yaml  | 3 +--
 .../bindings/display/mediatek/mediatek,ccorr.yaml           | 3 +--
 .../bindings/display/mediatek/mediatek,color.yaml           | 6 ++----
 .../bindings/display/mediatek/mediatek,dither.yaml          | 3 +--
 .../bindings/display/mediatek/mediatek,gamma.yaml           | 3 +--
 .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml  | 6 ++----
 .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml | 6 ++----
 7 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index 191b56e16bee..1528b2486f8f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -31,8 +31,7 @@ properties:
               - mediatek,mt8183-disp-aal
               - mediatek,mt8192-disp-aal
               - mediatek,mt8195-disp-aal
-          - enum:
-              - mediatek,mt8173-disp-aal
+          - const: mediatek,mt8173-disp-aal
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index 6894b6999412..1d8d2e214aca 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -28,8 +28,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8195-disp-ccorr
-          - enum:
-              - mediatek,mt8192-disp-ccorr
+          - const: mediatek,mt8192-disp-ccorr
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
index bc83155b3b4c..feb9999e4c00 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
@@ -32,15 +32,13 @@ properties:
           - enum:
               - mediatek,mt7623-disp-color
               - mediatek,mt2712-disp-color
-          - enum:
-              - mediatek,mt2701-disp-color
+          - const: mediatek,mt2701-disp-color
       - items:
           - enum:
               - mediatek,mt8183-disp-color
               - mediatek,mt8192-disp-color
               - mediatek,mt8195-disp-color
-          - enum:
-              - mediatek,mt8173-disp-color
+          - const: mediatek,mt8173-disp-color
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 9d89297f5f1d..68e982bdee39 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -28,8 +28,7 @@ properties:
           - enum:
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
-          - enum:
-              - mediatek,mt8183-disp-dither
+          - const: mediatek,mt8183-disp-dither
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index 247baad147b3..fd52995d8307 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -29,8 +29,7 @@ properties:
           - enum:
               - mediatek,mt8192-disp-gamma
               - mediatek,mt8195-disp-gamma
-          - enum:
-              - mediatek,mt8183-disp-gamma
+          - const: mediatek,mt8183-disp-gamma
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index e71f79bc2dee..84ee403dddd7 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -33,13 +33,11 @@ properties:
           - enum:
               - mediatek,mt7623-disp-ovl
               - mediatek,mt2712-disp-ovl
-          - enum:
-              - mediatek,mt2701-disp-ovl
+          - const: mediatek,mt2701-disp-ovl
       - items:
           - enum:
               - mediatek,mt8195-disp-ovl
-          - enum:
-              - mediatek,mt8183-disp-ovl
+          - const: mediatek,mt8183-disp-ovl
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index 8ef821641672..30f89afd3ab9 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -35,13 +35,11 @@ properties:
           - enum:
               - mediatek,mt7623-disp-rdma
               - mediatek,mt2712-disp-rdma
-          - enum:
-              - mediatek,mt2701-disp-rdma
+          - const: mediatek,mt2701-disp-rdma
       - items:
           - enum:
               - mediatek,mt8192-disp-rdma
-          - enum:
-              - mediatek,mt8183-disp-rdma
+          - const: mediatek,mt8183-disp-rdma
 
   reg:
     maxItems: 1
-- 
2.18.0

