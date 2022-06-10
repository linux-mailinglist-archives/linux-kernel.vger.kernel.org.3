Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD0545F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346310AbiFJIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348124AbiFJI3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:29:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661885F25E;
        Fri, 10 Jun 2022 01:27:37 -0700 (PDT)
X-UUID: 7b78795591454539b3c8558f364708bb-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:3f98b8b2-7084-49fa-b1ae-6ef554f43b8e,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:20
X-CID-META: VersionHash:2a19b09,CLOUDID:831f62e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 7b78795591454539b3c8558f364708bb-20220610
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 153060196; Fri, 10 Jun 2022 16:27:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 10 Jun 2022 16:27:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 10 Jun 2022 16:27:29 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 4/8] dt-bindings: mediatek: mt8186: add audio afe document
Date:   Fri, 10 Jun 2022 16:27:20 +0800
Message-ID: <20220610082724.29256-5-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610082724.29256-1-jiaxin.yu@mediatek.com>
References: <20220610082724.29256-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8186 audio afe document.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/mt8186-afe-pcm.yaml        | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml

diff --git a/Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
new file mode 100644
index 000000000000..88f82d096443
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
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8186-sound
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

