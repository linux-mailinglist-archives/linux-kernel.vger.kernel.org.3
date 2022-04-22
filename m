Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A179650B80D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447781AbiDVNQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447760AbiDVNQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:16:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A52580CB;
        Fri, 22 Apr 2022 06:13:26 -0700 (PDT)
X-UUID: 943aafd14c3045c29dbbaee4aeacdc79-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:548edf70-8e70-4202-b73e-a00a03dd0d28,OB:20,L
        OB:20,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:120
X-CID-INFO: VERSION:1.1.4,REQID:548edf70-8e70-4202-b73e-a00a03dd0d28,OB:20,LOB
        :20,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:120
X-CID-META: VersionHash:faefae9,CLOUDID:2eaba0f0-da02-41b4-b6df-58f4ccd36682,C
        OID:9f9ef6ce3947,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 943aafd14c3045c29dbbaee4aeacdc79-20220422
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1614880919; Fri, 22 Apr 2022 21:13:21 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 21:13:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 21:13:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 21:13:19 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 1/1] dt-bindings: timer: mediatek: Convert binding to YAML
Date:   Fri, 22 Apr 2022 21:13:17 +0800
Message-ID: <20220422131317.25410-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422131317.25410-1-allen-kh.cheng@mediatek.com>
References: <20220422131317.25410-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Mediatek timer devicetree binding to YAML.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 .../bindings/timer/mediatek,mtk-timer.txt     | 42 ----------
 .../bindings/timer/mediatek,mtk-timer.yaml    | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
deleted file mode 100644
index 6f1f9dba6e88..000000000000
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-MediaTek Timers
----------------
-
-MediaTek SoCs have two different timers on different platforms,
-- GPT (General Purpose Timer)
-- SYST (System Timer)
-
-The proper timer will be selected automatically by driver.
-
-Required properties:
-- compatible should contain:
-	For those SoCs that use GPT
-	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
-	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
-	* "mediatek,mt6582-timer" for MT6582 compatible timers (GPT)
-	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
-	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
-	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
-	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
-	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
-	* "mediatek,mt8516-timer" for MT8516 compatible timers (GPT)
-	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
-
-	For those SoCs that use SYST
-	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
-	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
-	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
-	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
-	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
-	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
-
-- reg: Should contain location and length for timer register.
-- clocks: Should contain system clock.
-
-Examples:
-
-	timer@10008000 {
-		compatible = "mediatek,mt6577-timer";
-		reg = <0x10008000 0x80>;
-		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&system_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.yaml
new file mode 100644
index 000000000000..be7eb09275f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mediatek,mtk-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoCs timers bindings
+
+description:
+  MediaTek SoCs have two different timers on different platforms,
+  - GPT (General Purpose Timer)
+  - SYST (System Timer)
+
+maintainers:
+  - Fengquan Chen <fengquan.chen@mediatek.com>
+  - Allen-KH Cheng <allen-kh.cheng@mediatek.com>
+
+properties:
+  $nodename:
+    pattern: '^timer@[a-f0-9]+$'
+
+  compatible:
+    oneOf:
+      - const: mediatek,mt6577-timer
+      - const: mediatek,mt6765-timer
+      - items:
+          - enum:
+              - mediatek,mt2701-timer
+              - mediatek,mt6580-timer
+              - mediatek,mt6582-timer
+              - mediatek,mt6589-timer
+              - mediatek,mt7623-timer
+              - mediatek,mt8127-timer
+              - mediatek,mt8135-timer
+              - mediatek,mt8173-timer
+              - mediatek,mt8516-timer
+          - const: mediatek,mt6577-timer
+      - items:
+          - enum:
+              - mediatek,mt7629-timer
+              - mediatek,mt8183-timer
+              - mediatek,mt8186-timer
+              - mediatek,mt8192-timer
+              - mediatek,mt8195-timer
+          - const: mediatek,mt6765-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: clk13m
+      - const: bus
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@10008000 {
+        compatible = "mediatek,mt6577-timer";
+        reg = <0xd4014000 0x100>;
+        interrupts = <13>;
+        clocks = <&coreclk 2>;
+    };
+
+...
-- 
2.18.0

