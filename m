Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74450B70E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447451AbiDVMNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447460AbiDVMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:13:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4152956C09;
        Fri, 22 Apr 2022 05:10:36 -0700 (PDT)
X-UUID: f9f6c9a48ceb4887a88d5199637521dd-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b8d344b9-3e8e-41d0-affe-030eca101461,OB:20,L
        OB:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:120
X-CID-INFO: VERSION:1.1.4,REQID:b8d344b9-3e8e-41d0-affe-030eca101461,OB:20,LOB
        :0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:120
X-CID-META: VersionHash:faefae9,CLOUDID:80479ff0-da02-41b4-b6df-58f4ccd36682,C
        OID:3b21fae82f57,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: f9f6c9a48ceb4887a88d5199637521dd-20220422
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 168344172; Fri, 22 Apr 2022 20:10:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 20:10:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 20:10:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 20:10:21 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: watchdog: mediatek: Convert binding to YAML
Date:   Fri, 22 Apr 2022 20:10:17 +0800
Message-ID: <20220422121017.23920-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422121017.23920-1-allen-kh.cheng@mediatek.com>
References: <20220422121017.23920-1-allen-kh.cheng@mediatek.com>
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

Convert Mediatek watchdog devicetree binding to YAML.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
 .../devicetree/bindings/watchdog/mtk-wdt.yaml | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
deleted file mode 100644
index 762c62e428ef..000000000000
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Mediatek SoCs Watchdog timer
-
-The watchdog supports a pre-timeout interrupt that fires timeout-sec/2
-before the expiry.
-
-Required properties:
-
-- compatible should contain:
-	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
-	"mediatek,mt2712-wdt": for MT2712
-	"mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
-	"mediatek,mt6589-wdt": for MT6589
-	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
-	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
-	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
-	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
-	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
-	"mediatek,mt8183-wdt": for MT8183
-	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
-	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
-	"mediatek,mt8192-wdt": for MT8192
-	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
-
-- reg : Specifies base physical address and size of the registers.
-
-Optional properties:
-- mediatek,disable-extrst: disable send output reset signal
-- interrupts: Watchdog pre-timeout (bark) interrupt.
-- timeout-sec: contains the watchdog timeout in seconds.
-- #reset-cells: Should be 1.
-
-Example:
-
-watchdog: watchdog@10007000 {
-	compatible = "mediatek,mt8183-wdt",
-		     "mediatek,mt6589-wdt";
-	mediatek,disable-extrst;
-	reg = <0 0x10007000 0 0x100>;
-	interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
-	timeout-sec = <10>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
new file mode 100644
index 000000000000..5788617027c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/mtk-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek SoCs Watchdog timer
+
+maintainers:
+  - Runyang Chen <runyang.chen@mediatek.com>
+  - Allen-KH Cheng <allen-kh.cheng@mediatek.com>
+
+description: |+
+  The watchdog supports a pre-timeout interrupt that fires timeout-sec/2
+  before the expiry.
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt2712-wdt
+      - const: mediatek,mt6589-wdt
+      - const: mediatek,mt8183-wdt
+      - const: mediatek,mt8192-wdt
+
+      - items:
+          - enum:
+              - mediatek,mt2701-wdt
+              - mediatek,mt6582-wdt
+              - mediatek,mt6797-wdt
+              - mediatek,mt7622-wdt
+              - mediatek,mt7623-wdt
+              - mediatek,mt7629-wdt
+              - mediatek,mt7986-wdt
+              - mediatek,mt8173-wdt
+              - mediatek,mt8183-wdt
+              - mediatek,mt8186-wdt
+              - mediatek,mt8192-wdt
+              - mediatek,mt8195-wdt
+              - mediatek,mt8516-wdt
+          - const: mediatek,mt6589-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  timeout-sec: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@10007000 {
+        compatible = "mediatek,mt8183-wdt",
+                     "mediatek,mt6589-wdt";
+        mediatek,disable-extrst;
+        reg = <0x10007000 0x100>;
+        interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
+        timeout-sec = <10>;
+        #reset-cells = <1>;
+    };
+
+...
-- 
2.18.0

