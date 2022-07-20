Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDE657B672
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiGTMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbiGTMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:30:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC31149B40;
        Wed, 20 Jul 2022 05:30:35 -0700 (PDT)
X-UUID: 4e0c844338e84b1da124ebd289ff1c07-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:215f7451-0fb5-47a7-91f1-0f1c8ea46a5f,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:0f94e32,CLOUDID:99547d33-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4e0c844338e84b1da124ebd289ff1c07-20220720
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 352377183; Wed, 20 Jul 2022 20:30:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 20 Jul 2022 20:30:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jul 2022 20:30:25 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for MediaTek SCPSYS
Date:   Wed, 20 Jul 2022 20:30:08 +0800
Message-ID: <20220720123023.13500-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220720123023.13500-1-tinghan.shen@mediatek.com>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System Control Processor System (SCPSYS) has several power
management related tasks in the system. Add the bindings for it.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
new file mode 100644
index 000000000000..4117a6dbc19c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Control Processor System
+
+maintainers:
+  - MandyJH Liu <mandyjh.liu@mediatek.com>
+
+description:
+  MediaTek System Control Processor System (SCPSYS) has several
+  power management tasks. The tasks include MTCMOS power
+  domain control, thermal measurement, DVFS, etc.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8167-scpsys
+          - mediatek,mt8173-scpsys
+          - mediatek,mt8183-scpsys
+          - mediatek,mt8192-scpsys
+          - mediatek,mt8195-scpsys
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^power-controller(@[0-9a-f]+)?$":
+    $ref: /schemas/power/mediatek,power-controller.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    syscon@10006000 {
+        compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
+        reg = <0x10006000 0x100>;
+
+        spm: power-controller {
+            compatible = "mediatek,mt8195-power-controller";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #power-domain-cells = <1>;
+
+            /* sample of power domain nodes */
+            power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
+                    reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;
+                    #power-domain-cells = <0>;
+            };
+
+            power-domain@MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY {
+                    reg = <MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
+                    #power-domain-cells = <0>;
+            };
+        };
+    };
-- 
2.18.0

