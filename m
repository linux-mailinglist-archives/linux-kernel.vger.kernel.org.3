Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EFA4CB73A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiCCGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiCCGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:53:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A516A5AB;
        Wed,  2 Mar 2022 22:52:17 -0800 (PST)
X-UUID: 5549736d87384b38ad5d9abe7abc7575-20220303
X-UUID: 5549736d87384b38ad5d9abe7abc7575-20220303
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 219977567; Thu, 03 Mar 2022 14:52:11 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Mar 2022 14:52:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Mar
 2022 14:52:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 14:52:09 +0800
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
Subject: [PATCH V6 3/5] dt-bindings: display: mediatek: change to use enum for mutex
Date:   Thu, 3 Mar 2022 14:51:33 +0800
Message-ID: <20220303065205.22971-4-rex-bc.chen@mediatek.com>
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

All single entry cases in mutex can be merged as a single enum.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 .../display/mediatek/mediatek,mutex.yaml      | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
index 6eca525eced0..0378933201b4 100644
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

