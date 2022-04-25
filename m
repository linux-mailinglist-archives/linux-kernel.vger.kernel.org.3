Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6850DB98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiDYIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbiDYIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:51:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781D90CFA;
        Mon, 25 Apr 2022 01:48:10 -0700 (PDT)
X-UUID: 2e560d5a45c44bc8bbdbb1d4c8f693b3-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7d832b6c-6a11-4cc6-9244-ef1b24255576,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:5
X-CID-META: VersionHash:faefae9,CLOUDID:c31d03f0-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 2e560d5a45c44bc8bbdbb1d4c8f693b3-20220425
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1047185239; Mon, 25 Apr 2022 16:48:05 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 25 Apr 2022 16:48:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Apr
 2022 16:48:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 16:48:03 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
CC:     Lala Lin <lala.lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 1/1] dt-bindings: nvmem: mediatek: Convert mtk-efuse binding to YAML
Date:   Mon, 25 Apr 2022 16:48:00 +0800
Message-ID: <20220425084800.2021-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220425084800.2021-1-allen-kh.cheng@mediatek.com>
References: <20220425084800.2021-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MediaTek eFuse devicetree binding to YAML.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 .../devicetree/bindings/nvmem/mtk,efuse.yaml  | 70 +++++++++++++++++++
 .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ------------
 2 files changed, 70 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml
new file mode 100644
index 000000000000..d056bc61dd5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/mtk,efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek eFuse device tree bindings
+
+maintainers:
+  - Lala Lin <lala.lin@mediatek.com>
+  - Allen-KH Cheng <allen-kh.cheng@mediatek.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt8173-efuse
+          - mediatek,efuse
+      - items:
+          - enum:
+              - mediatek,mt7622-efuse
+              - mediatek,mt7623-efuse
+              - mediatek,mt8183-efuse
+              - mediatek,mt8192-efuse
+              - mediatek,mt8195-efuse
+              - mediatek,mt8516-efuse
+          - const: mediatek,efuse
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        maxItems: 1
+        description:
+          Offset and size in bytes within the storage device.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    efuse: efuse@10206000 {
+            compatible = "mediatek,mt8173-efuse";
+            reg	   = <0x10206000 0x1000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            /* Data cells */
+            thermal_calibration: calib@528 {
+                reg = <0x528 0xc>;
+            };
+    };
+...
diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
deleted file mode 100644
index 39d529599444..000000000000
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-= Mediatek MTK-EFUSE device tree bindings =
-
-This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
-
-Required properties:
-- compatible: should be
-	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
-	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
-	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
-	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
-	      "mediatek,mt8195-efuse", "mediatek,efuse": for MT8195
-	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
-- reg: Should contain registers location and length
-- bits: contain the bits range by offset and size
-
-= Data cells =
-Are child nodes of MTK-EFUSE, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	efuse: efuse@10206000 {
-		compatible = "mediatek,mt8173-efuse";
-		reg	   = <0 0x10206000 0 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/* Data cells */
-		thermal_calibration: calib@528 {
-			reg = <0x528 0xc>;
-		};
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-
-	thermal {
-		...
-		nvmem-cells = <&thermal_calibration>;
-		nvmem-cell-names = "calibration";
-	};
-- 
2.18.0

