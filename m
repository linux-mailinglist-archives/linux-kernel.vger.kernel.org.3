Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0470650B13E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444728AbiDVHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386732AbiDVHSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:18:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E439B84;
        Fri, 22 Apr 2022 00:15:42 -0700 (PDT)
X-UUID: 491d445a835548d2a02accb29f8cd3ea-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:80b17aca-6b6c-4c22-a8af-b9e43eafd7b9,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:80b17aca-6b6c-4c22-a8af-b9e43eafd7b9,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:a2f1bfef-06b0-4305-bfbf-554bfc9d151a,C
        OID:b4f7ef9c0733,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 491d445a835548d2a02accb29f8cd3ea-20220422
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 404748199; Fri, 22 Apr 2022 15:15:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 15:15:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 15:15:38 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
Date:   Fri, 22 Apr 2022 15:15:34 +0800
Message-ID: <20220422071534.15653-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
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

This patch adds mt8186 dsp document. The dsp is used for Sound Open
Firmware driver node. It includes registers, clocks, memory regions,
and mailbox for dsp.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---

This patch depends on MT8186 clock bindings.
https://lore.kernel.org/all/20220409132251.31725-2-chun-jie.chen@mediatek.com/

---
 .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
new file mode 100644
index 000000000000..00a79e880895
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/mediatek,mt8186-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek mt8186 DSP core
+
+maintainers:
+  - Tinghan Shen <tinghan.shen@mediatek.com>
+
+description: |
+  MediaTek mt8186 SoC contains a DSP core used for
+  advanced pre- and post- audio processing.
+
+properties:
+  compatible:
+    const: mediatek,mt8186-dsp
+
+  reg:
+    items:
+      - description: Address and size of the DSP config registers
+      - description: Address and size of the DSP SRAM
+      - description: Address and size of the DSP secure registers
+      - description: Address and size of the DSP bus registers
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: sram
+      - const: sec
+      - const: bus
+
+  clocks:
+    items:
+      - description: mux for audio dsp clock
+      - description: mux for audio dsp local bus
+
+  clock-names:
+    items:
+      - const: audiodsp_sel
+      - const: adsp_bus_sel
+
+  power-domains:
+    maxItems: 1
+
+  mboxes:
+    items:
+      - description: ipc reply between host and audio DSP.
+      - description: ipc request between host and audio DSP.
+
+  mbox-names:
+    items:
+      - const: mbox0
+      - const: mbox1
+
+  memory-region:
+    items:
+      - description: dma buffer between host and DSP.
+      - description: DSP system memory.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - power-domains
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8186-clk.h>
+    dsp@10680000 {
+        compatible = "mediatek,mt8186-dsp";
+        reg = <0x10680000 0x2000>,
+              <0x10800000 0x100000>,
+              <0x1068b000 0x100>,
+              <0x1068f000 0x1000>;
+        reg-names = "cfg", "sram", "sec", "bus";
+        clocks = <&topckgen CLK_TOP_AUDIODSP>,
+                 <&topckgen CLK_TOP_ADSP_BUS>;
+        clock-names = "audiodsp_sel",
+                      "adsp_bus_sel";
+        power-domains = <&spm 6>;
+        mbox-names = "mbox0", "mbox1";
+        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+    };
-- 
2.18.0

