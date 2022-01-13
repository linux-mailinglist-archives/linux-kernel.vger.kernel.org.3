Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACC48D669
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiAMLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:11:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58146 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233989AbiAMLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:11:15 -0500
X-UUID: b94f5930a4b445a3bfa0152062223c3c-20220113
X-UUID: b94f5930a4b445a3bfa0152062223c3c-20220113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 698236186; Thu, 13 Jan 2022 19:11:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 19:11:13 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 19:11:12 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <lc.kan@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 1/7] dt-bindings: memory: mtk-smi: Rename clock to clocks
Date:   Thu, 13 Jan 2022 19:10:51 +0800
Message-ID: <20220113111057.29918-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220113111057.29918-1-yong.wu@mediatek.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property "clock" should be rename to "clocks", and delete the "items",
the minItems/maxItems should not be put under "items".

Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../mediatek,smi-common.yaml                  | 28 ++++++++-----------
 .../memory-controllers/mediatek,smi-larb.yaml | 14 ++++------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 3a82b0b27fa0..4fca71f34310 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -88,10 +88,9 @@ allOf:
               - mediatek,mt2701-smi-common
     then:
       properties:
-        clock:
-          items:
-            minItems: 3
-            maxItems: 3
+        clocks:
+          minItems: 3
+          maxItems: 3
         clock-names:
           items:
             - const: apb
@@ -108,10 +107,9 @@ allOf:
       required:
         - mediatek,smi
       properties:
-        clock:
-          items:
-            minItems: 3
-            maxItems: 3
+        clocks:
+          minItems: 3
+          maxItems: 3
         clock-names:
           items:
             - const: apb
@@ -133,10 +131,9 @@ allOf:
 
     then:
       properties:
-        clock:
-          items:
-            minItems: 4
-            maxItems: 4
+        clocks:
+          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: apb
@@ -146,10 +143,9 @@ allOf:
 
     else:  # for gen2 HW that don't have gals
       properties:
-        clock:
-          items:
-            minItems: 2
-            maxItems: 2
+        clocks:
+          minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: apb
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index eaeff1ada7f8..bd7aa8257949 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -79,10 +79,9 @@ allOf:
 
     then:
       properties:
-        clock:
-          items:
-            minItems: 3
-            maxItems: 3
+        clocks:
+          minItems: 3
+          maxItems: 3
         clock-names:
           items:
             - const: apb
@@ -91,10 +90,9 @@ allOf:
 
     else:
       properties:
-        clock:
-          items:
-            minItems: 2
-            maxItems: 2
+        clocks:
+          minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: apb
-- 
2.18.0

