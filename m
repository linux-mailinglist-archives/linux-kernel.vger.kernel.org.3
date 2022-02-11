Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FF4B2365
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349178AbiBKKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:39:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349105AbiBKKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:38:41 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236CDCFC;
        Fri, 11 Feb 2022 02:38:39 -0800 (PST)
X-UUID: 2663b1bd16d14f7eb9263655d937bd31-20220211
X-UUID: 2663b1bd16d14f7eb9263655d937bd31-20220211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 948981048; Fri, 11 Feb 2022 18:38:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 11 Feb 2022 18:38:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 18:38:34 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <perex@perex.cz>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>
CC:     <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <zhangqilong3@huawei.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH 11/15] dt-bindings: mediatek: mt8186: add audio afe document
Date:   Fri, 11 Feb 2022 18:38:14 +0800
Message-ID: <20220211103818.8266-12-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds mt8186 audio afe document.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 .../bindings/sound/mt8186-afe-pcm.yaml        | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml

diff --git a/Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
new file mode 100644
index 000000000000..ad384a470b4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mt8186-afe-pcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek AFE PCM controller for mt8186
+
+maintainers:
+   - Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+properties:
+  compatible:
+      const: mediatek,mt8186-sound
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: audiosys
+
+  mediatek,apmixedsys:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of the mediatek apmixedsys controller
+
+  mediatek,infracfg:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of the mediatek infracfg controller
+
+  mediatek,topckgen:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle of the mediatek topckgen controller
+
+  clocks:
+    items:
+      - description: audio infra sys clock
+      - description: audio infra 26M clock
+      - description: audio top mux
+      - description: audio intbus mux
+      - description: mainpll 136.5M clock
+      - description: faud1 mux
+      - description: apll1 clock
+      - description: faud2 mux
+      - description: apll2 clock
+      - description: audio engen1 mux
+      - description: apll1_d8 22.5792M clock
+      - description: audio engen2 mux
+      - description: apll2_d8 24.576M clock
+      - description: i2s0 mclk mux
+      - description: i2s1 mclk mux
+      - description: i2s2 mclk mux
+      - description: i2s4 mclk mux
+      - description: tdm mclk mux
+      - description: i2s0_mck divider
+      - description: i2s1_mck divider
+      - description: i2s2_mck divider
+      - description: i2s4_mck divider
+      - description: tdm_mck divider
+      - description: audio hires mux
+      - description: 26M clock
+
+  clock-names:
+    items:
+      - const: aud_infra_clk
+      - const: mtkaif_26m_clk
+      - const: top_mux_audio
+      - const: top_mux_audio_int
+      - const: top_mainpll_d2_d4
+      - const: top_mux_aud_1
+      - const: top_apll1_ck
+      - const: top_mux_aud_2
+      - const: top_apll2_ck
+      - const: top_mux_aud_eng1
+      - const: top_apll1_d8
+      - const: top_mux_aud_eng2
+      - const: top_apll2_d8
+      - const: top_i2s0_m_sel
+      - const: top_i2s1_m_sel
+      - const: top_i2s2_m_sel
+      - const: top_i2s4_m_sel
+      - const: top_tdm_m_sel
+      - const: top_apll12_div0
+      - const: top_apll12_div1
+      - const: top_apll12_div2
+      - const: top_apll12_div4
+      - const: top_apll12_div_tdm
+      - const: top_mux_audio_h
+      - const: top_clk26m_clk
+
+required:
+  - compatible
+  - interrupts
+  - resets
+  - reset-names
+  - mediatek,apmixedsys
+  - mediatek,infracfg
+  - mediatek,topckgen
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    afe: mt8186-afe-pcm@11210000 {
+        compatible = "mediatek,mt8186-sound";
+        reg = <0x11210000 0x2000>;
+        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&watchdog 17>; //MT8186_TOPRGU_AUDIO_SW_RST
+        reset-names = "audiosys";
+        mediatek,apmixedsys = <&apmixedsys>;
+        mediatek,infracfg = <&infracfg>;
+        mediatek,topckgen = <&topckgen>;
+        clocks = <&infracfg_ao 44>, //CLK_INFRA_AO_AUDIO
+                 <&infracfg_ao 54>, //CLK_INFRA_AO_AUDIO_26M_BCLK
+                 <&topckgen 15>, //CLK_TOP_AUDIO
+                 <&topckgen 16>, //CLK_TOP_AUD_INTBUS
+                 <&topckgen 70>, //CLK_TOP_MAINPLL_D2_D4
+                 <&topckgen 17>, //CLK_TOP_AUD_1
+                 <&apmixedsys 12>, //CLK_APMIXED_APLL1
+                 <&topckgen 18>, //CLK_TOP_AUD_2
+                 <&apmixedsys 13>, //CLK_APMIXED_APLL2
+                 <&topckgen 19>, //CLK_TOP_AUD_ENGEN1
+                 <&topckgen 101>, //CLK_TOP_APLL1_D8
+                 <&topckgen 20>, //CLK_TOP_AUD_ENGEN2
+                 <&topckgen 104>, //CLK_TOP_APLL2_D8
+                 <&topckgen 63>, //CLK_TOP_APLL_I2S0_MCK_SEL
+                 <&topckgen 64>, //CLK_TOP_APLL_I2S1_MCK_SEL
+                 <&topckgen 65>, //CLK_TOP_APLL_I2S2_MCK_SEL
+                 <&topckgen 66>, //CLK_TOP_APLL_I2S4_MCK_SEL
+                 <&topckgen 67>, //CLK_TOP_APLL_TDMOUT_MCK_SEL
+                 <&topckgen 131>, //CLK_TOP_APLL12_CK_DIV0
+                 <&topckgen 132>, //CLK_TOP_APLL12_CK_DIV1
+                 <&topckgen 133>, //CLK_TOP_APLL12_CK_DIV2
+                 <&topckgen 134>, //CLK_TOP_APLL12_CK_DIV4
+                 <&topckgen 135>, //CLK_TOP_APLL12_CK_DIV_TDMOUT_M
+                 <&topckgen 44>, //CLK_TOP_AUDIO_H
+                 <&clk26m>;
+        clock-names = "aud_infra_clk",
+                      "mtkaif_26m_clk",
+                      "top_mux_audio",
+                      "top_mux_audio_int",
+                      "top_mainpll_d2_d4",
+                      "top_mux_aud_1",
+                      "top_apll1_ck",
+                      "top_mux_aud_2",
+                      "top_apll2_ck",
+                      "top_mux_aud_eng1",
+                      "top_apll1_d8",
+                      "top_mux_aud_eng2",
+                      "top_apll2_d8",
+                      "top_i2s0_m_sel",
+                      "top_i2s1_m_sel",
+                      "top_i2s2_m_sel",
+                      "top_i2s4_m_sel",
+                      "top_tdm_m_sel",
+                      "top_apll12_div0",
+                      "top_apll12_div1",
+                      "top_apll12_div2",
+                      "top_apll12_div4",
+                      "top_apll12_div_tdm",
+                      "top_mux_audio_h",
+                      "top_clk26m_clk";
+    };
+
+...
-- 
2.18.0

