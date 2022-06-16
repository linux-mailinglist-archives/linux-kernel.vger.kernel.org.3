Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF454DB92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359388AbiFPHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359341AbiFPHaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:30:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EAF4FC72;
        Thu, 16 Jun 2022 00:30:54 -0700 (PDT)
X-UUID: 345cce1b489c4db79c81e907abac8e04-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:6a2d75bc-e928-4206-bf45-3f392d8f18ba,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:20
X-CID-META: VersionHash:b14ad71,CLOUDID:2491b748-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 345cce1b489c4db79c81e907abac8e04-20220616
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1114234420; Thu, 16 Jun 2022 15:30:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 15:30:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 15:30:46 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        "Allen-KH Cheng" <allen-kh.cheng@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 3/4] dt-bindings: dsp: mediatek: Add mt8186 dsp document
Date:   Thu, 16 Jun 2022 15:30:41 +0800
Message-ID: <20220616073042.13229-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220616073042.13229-1-tinghan.shen@mediatek.com>
References: <20220616073042.13229-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
new file mode 100644
index 000000000000..3e63f79890b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/mediatek,mt8186-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek mt8186 DSP core
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
+      - const: audiodsp
+      - const: adsp_bus
+
+  power-domains:
+    maxItems: 1
+
+  mboxes:
+    items:
+      - description: mailbox for receiving audio DSP requests.
+      - description: mailbox for transmitting requests to audio DSP.
+
+  mbox-names:
+    items:
+      - const: rx
+      - const: tx
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
+        clock-names = "audiodsp",
+                      "adsp_bus";
+        power-domains = <&spm 6>;
+        mbox-names = "rx", "tx";
+        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+    };
-- 
2.18.0

