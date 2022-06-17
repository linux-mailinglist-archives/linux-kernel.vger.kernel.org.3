Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89C154F44E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380933AbiFQJbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241130AbiFQJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:31:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426D6350B;
        Fri, 17 Jun 2022 02:31:44 -0700 (PDT)
X-UUID: 1e41cd9acc2f43c0bd0648c8fb1d8043-20220617
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.6,REQID:4cedab06-6f8a-418f-8b40-4a03d254e7e4,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:115
X-CID-INFO: VERSION:1.1.6,REQID:4cedab06-6f8a-418f-8b40-4a03d254e7e4,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:115
X-CID-META: VersionHash:b14ad71,CLOUDID:470be648-4c92-421c-ad91-b806c0f58b2a,C
        OID:80d479e3f24d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1e41cd9acc2f43c0bd0648c8fb1d8043-20220617
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1118742490; Fri, 17 Jun 2022 17:31:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 17 Jun 2022 17:31:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jun 2022 17:31:34 +0800
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
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: nvmem: convert mtk-efuse.txt to YAML schema
Date:   Fri, 17 Jun 2022 17:31:29 +0800
Message-ID: <20220617093132.22578-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v6: no changes, based on kernel 5.19-rc1

v5: 
sync with the series:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=640196
   1. change title suggested by Krzysztof;
   2. No need drop 'reviewed-by Rob' suggested by Krzysztof
   3. add maintainer Lala who maintain efuse driver now;

v4: fix duplicated unit-address in example;
    drop reviewed-by Rob, due to changes;

v3: add reviewed-by Rob

v2:
   1. remove description of subnodes which is covered by nvmem.yaml
suggested by Rob
   2. change the example which is commoner than mt8173's
---
 .../bindings/nvmem/mediatek,efuse.yaml        | 87 +++++++++++++++++++
 .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ---------
 2 files changed, 87 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
new file mode 100644
index 000000000000..f6e01ddb7499
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/mediatek,efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek efuse
+
+description: |
+  MediaTek's efuse is used for storing calibration data, it can be accessed
+  on ARM devices usiong I/O mapped memory.
+
+maintainers:
+  - Andrew-CT Chen <andrew-ct.chen@mediatek.com>
+  - Lala Lin <lala.lin@mediatek.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  $nodename:
+    pattern: "^efuse@[0-9a-f]+$"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt7622-efuse
+              - mediatek,mt7623-efuse
+              - mediatek,mt8173-efuse
+              - mediatek,mt8192-efuse
+              - mediatek,mt8195-efuse
+              - mediatek,mt8516-efuse
+          - const: mediatek,efuse
+      - const: mediatek,mt8173-efuse
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@11c10000 {
+        compatible = "mediatek,mt8195-efuse", "mediatek,efuse";
+        reg = <0x11c10000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        u3_tx_imp_p0: usb3-tx-imp@184,1 {
+            reg = <0x184 0x1>;
+            bits = <0 5>;
+        };
+        u3_rx_imp_p0: usb3-rx-imp@184,2 {
+            reg = <0x184 0x2>;
+            bits = <5 5>;
+        };
+        u3_intr_p0: usb3-intr@185 {
+            reg = <0x185 0x1>;
+            bits = <2 6>;
+        };
+        comb_tx_imp_p1: usb3-tx-imp@186,1 {
+            reg = <0x186 0x1>;
+            bits = <0 5>;
+        };
+        comb_rx_imp_p1: usb3-rx-imp@186,2 {
+            reg = <0x186 0x2>;
+            bits = <5 5>;
+        };
+        comb_intr_p1: usb3-intr@187 {
+            reg = <0x187 0x1>;
+            bits = <2 6>;
+        };
+        u2_intr_p0: usb2-intr-p0@188,1 {
+            reg = <0x188 0x1>;
+            bits = <0 5>;
+        };
+        u2_intr_p1: usb2-intr-p1@188,2 {
+            reg = <0x188 0x2>;
+            bits = <5 5>;
+        };
+    };
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

