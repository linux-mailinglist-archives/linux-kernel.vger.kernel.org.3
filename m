Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F21250625C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbiDSC67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiDSC6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:58:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C162317F;
        Mon, 18 Apr 2022 19:56:08 -0700 (PDT)
X-UUID: 5b765cc5c6884ecab9f5c9fbd3df7ebd-20220419
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:9f7c98ca-d477-4e65-b5a6-7c8a284e8584,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:9f7c98ca-d477-4e65-b5a6-7c8a284e8584,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:b5f325f0-da02-41b4-b6df-58f4ccd36682,C
        OID:9b11c9d808ae,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 5b765cc5c6884ecab9f5c9fbd3df7ebd-20220419
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1801980909; Tue, 19 Apr 2022 10:56:02 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 19 Apr 2022 10:56:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Apr
 2022 10:56:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Apr 2022 10:56:00 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: mediatek: mt8192: complete clocks and clock-names
Date:   Tue, 19 Apr 2022 10:55:56 +0800
Message-ID: <20220419025557.22262-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220419025557.22262-1-allen-kh.cheng@mediatek.com>
References: <20220419025557.22262-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxin Yu <jiaxin.yu@mediatek.com>

Complete all clocks and clock-names be used for mt8192 SoC into dt-bindings.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 .../bindings/sound/mt8192-afe-pcm.yaml        | 165 +++++++++++++++++-
 1 file changed, 157 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
index 7a25bc9b8060..1b6b22a5732e 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -39,20 +39,67 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: AFE clock
-      - description: ADDA DAC clock
-      - description: ADDA DAC pre-distortion clock
-      - description: audio infra sys clock
-      - description: audio infra 26M clock
+    minItems: 56
+    maxItems: 56
 
   clock-names:
     items:
       - const: aud_afe_clk
       - const: aud_dac_clk
       - const: aud_dac_predis_clk
+      - const: aud_adc_clk
+      - const: aud_adda6_adc_clk
+      - const: aud_apll22m_clk
+      - const: aud_apll24m_clk
+      - const: aud_apll1_tuner_clk
+      - const: aud_apll2_tuner_clk
+      - const: aud_tdm_clk
+      - const: aud_tml_clk
+      - const: aud_nle
+      - const: aud_dac_hires_clk
+      - const: aud_adc_hires_clk
+      - const: aud_adc_hires_tml
+      - const: aud_adda6_adc_hires_clk
+      - const: aud_3rd_dac_clk
+      - const: aud_3rd_dac_predis_clk
+      - const: aud_3rd_dac_tml
+      - const: aud_3rd_dac_hires_clk
       - const: aud_infra_clk
       - const: aud_infra_26m_clk
+      - const: top_mux_audio
+      - const: top_mux_audio_int
+      - const: top_mainpll_d4_d4
+      - const: top_mux_aud_1
+      - const: top_apll1_ck
+      - const: top_mux_aud_2
+      - const: top_apll2_ck
+      - const: top_mux_aud_eng1
+      - const: top_apll1_d4
+      - const: top_mux_aud_eng2
+      - const: top_apll2_d4
+      - const: top_i2s0_m_sel
+      - const: top_i2s1_m_sel
+      - const: top_i2s2_m_sel
+      - const: top_i2s3_m_sel
+      - const: top_i2s4_m_sel
+      - const: top_i2s5_m_sel
+      - const: top_i2s6_m_sel
+      - const: top_i2s7_m_sel
+      - const: top_i2s8_m_sel
+      - const: top_i2s9_m_sel
+      - const: top_apll12_div0
+      - const: top_apll12_div1
+      - const: top_apll12_div2
+      - const: top_apll12_div3
+      - const: top_apll12_div4
+      - const: top_apll12_divb
+      - const: top_apll12_div5
+      - const: top_apll12_div6
+      - const: top_apll12_div7
+      - const: top_apll12_div8
+      - const: top_apll12_div9
+      - const: top_mux_audio_h
+      - const: top_clk26m_clk
 
 required:
   - compatible
@@ -88,13 +135,115 @@ examples:
         clocks = <&audsys CLK_AUD_AFE>,
                  <&audsys CLK_AUD_DAC>,
                  <&audsys CLK_AUD_DAC_PREDIS>,
+                 <&audsys CLK_AUD_ADC>,
+                 <&audsys CLK_AUD_ADDA6_ADC>,
+                 <&audsys CLK_AUD_22M>,
+                 <&audsys CLK_AUD_24M>,
+                 <&audsys CLK_AUD_APLL_TUNER>,
+                 <&audsys CLK_AUD_APLL2_TUNER>,
+                 <&audsys CLK_AUD_TDM>,
+                 <&audsys CLK_AUD_TML>,
+                 <&audsys CLK_AUD_NLE>,
+                 <&audsys CLK_AUD_DAC_HIRES>,
+                 <&audsys CLK_AUD_ADC_HIRES>,
+                 <&audsys CLK_AUD_ADC_HIRES_TML>,
+                 <&audsys CLK_AUD_ADDA6_ADC_HIRES>,
+                 <&audsys CLK_AUD_3RD_DAC>,
+                 <&audsys CLK_AUD_3RD_DAC_PREDIS>,
+                 <&audsys CLK_AUD_3RD_DAC_TML>,
+                 <&audsys CLK_AUD_3RD_DAC_HIRES>,
                  <&infracfg CLK_INFRA_AUDIO>,
-                 <&infracfg CLK_INFRA_AUDIO_26M_B>;
+                 <&infracfg CLK_INFRA_AUDIO_26M_B>,
+                 <&topckgen CLK_TOP_AUDIO_SEL>,
+                 <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+                 <&topckgen CLK_TOP_MAINPLL_D4_D4>,
+                 <&topckgen CLK_TOP_AUD_1_SEL>,
+                 <&topckgen CLK_TOP_APLL1>,
+                 <&topckgen CLK_TOP_AUD_2_SEL>,
+                 <&topckgen CLK_TOP_APLL2>,
+                 <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
+                 <&topckgen CLK_TOP_APLL1_D4>,
+                 <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
+                 <&topckgen CLK_TOP_APLL2_D4>,
+                 <&topckgen CLK_TOP_APLL_I2S0_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S1_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S2_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S3_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S4_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S5_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S6_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S7_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S8_M_SEL>,
+                 <&topckgen CLK_TOP_APLL_I2S9_M_SEL>,
+                 <&topckgen CLK_TOP_APLL12_DIV0>,
+                 <&topckgen CLK_TOP_APLL12_DIV1>,
+                 <&topckgen CLK_TOP_APLL12_DIV2>,
+                 <&topckgen CLK_TOP_APLL12_DIV3>,
+                 <&topckgen CLK_TOP_APLL12_DIV4>,
+                 <&topckgen CLK_TOP_APLL12_DIVB>,
+                 <&topckgen CLK_TOP_APLL12_DIV5>,
+                 <&topckgen CLK_TOP_APLL12_DIV6>,
+                 <&topckgen CLK_TOP_APLL12_DIV7>,
+                 <&topckgen CLK_TOP_APLL12_DIV8>,
+                 <&topckgen CLK_TOP_APLL12_DIV9>,
+                 <&topckgen CLK_TOP_AUDIO_H_SEL>,
+                 <&clk26m>;
         clock-names = "aud_afe_clk",
                       "aud_dac_clk",
                       "aud_dac_predis_clk",
+                      "aud_adc_clk",
+                      "aud_adda6_adc_clk",
+                      "aud_apll22m_clk",
+                      "aud_apll24m_clk",
+                      "aud_apll1_tuner_clk",
+                      "aud_apll2_tuner_clk",
+                      "aud_tdm_clk",
+                      "aud_tml_clk",
+                      "aud_nle",
+                      "aud_dac_hires_clk",
+                      "aud_adc_hires_clk",
+                      "aud_adc_hires_tml",
+                      "aud_adda6_adc_hires_clk",
+                      "aud_3rd_dac_clk",
+                      "aud_3rd_dac_predis_clk",
+                      "aud_3rd_dac_tml",
+                      "aud_3rd_dac_hires_clk",
                       "aud_infra_clk",
-                      "aud_infra_26m_clk";
+                      "aud_infra_26m_clk",
+                      "top_mux_audio",
+                      "top_mux_audio_int",
+                      "top_mainpll_d4_d4",
+                      "top_mux_aud_1",
+                      "top_apll1_ck",
+                      "top_mux_aud_2",
+                      "top_apll2_ck",
+                      "top_mux_aud_eng1",
+                      "top_apll1_d4",
+                      "top_mux_aud_eng2",
+                      "top_apll2_d4",
+                      "top_i2s0_m_sel",
+                      "top_i2s1_m_sel",
+                      "top_i2s2_m_sel",
+                      "top_i2s3_m_sel",
+                      "top_i2s4_m_sel",
+                      "top_i2s5_m_sel",
+                      "top_i2s6_m_sel",
+                      "top_i2s7_m_sel",
+                      "top_i2s8_m_sel",
+                      "top_i2s9_m_sel",
+                      "top_apll12_div0",
+                      "top_apll12_div1",
+                      "top_apll12_div2",
+                      "top_apll12_div3",
+                      "top_apll12_div4",
+                      "top_apll12_divb",
+                      "top_apll12_div5",
+                      "top_apll12_div6",
+                      "top_apll12_div7",
+                      "top_apll12_div8",
+                      "top_apll12_div9",
+                      "top_mux_audio_h",
+                      "top_clk26m_clk";
     };
 
 ...
-- 
2.18.0

