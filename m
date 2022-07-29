Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D37584C01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiG2Gd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiG2Gc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:32:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F47F536;
        Thu, 28 Jul 2022 23:32:27 -0700 (PDT)
X-UUID: 600466cbcace492e90889bd7122b4ef7-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:9917e365-43fa-4f3e-852c-4301881889d7,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:7b61b9cf-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 600466cbcace492e90889bd7122b4ef7-20220729
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 13644606; Fri, 29 Jul 2022 14:32:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 14:32:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 29 Jul 2022 14:32:14 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "MandyJH Liu" <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Trevor Wu <trevor.wu@mediatek.com>
Subject: [PATCH v4 15/20] arm64: dts: mt8195: Add audio related nodes
Date:   Fri, 29 Jul 2022 14:32:03 +0800
Message-ID: <20220729063208.16799-16-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220729063208.16799-1-tinghan.shen@mediatek.com>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio related nodes for mt8195.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d10db01a360aa..bbea0acff3d2f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -226,6 +226,17 @@
 		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
 	};
 
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <50>;
+	};
+
+	sound: mt8195-sound {
+		mediatek,platform = <&afe>;
+		status = "disabled";
+	};
+
 	clk26m: oscillator-26m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -728,6 +739,53 @@
 			#clock-cells = <1>;
 		};
 
+		afe: mt8195-afe-pcm@10890000 {
+			compatible = "mediatek,mt8195-audio";
+			reg = <0 0x10890000 0 0x10000>;
+			mediatek,topckgen = <&topckgen>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_AUDIO>;
+			interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>,
+				<&apmixedsys CLK_APMIXED_APLL1>,
+				<&apmixedsys CLK_APMIXED_APLL2>,
+				<&topckgen CLK_TOP_APLL12_DIV0>,
+				<&topckgen CLK_TOP_APLL12_DIV1>,
+				<&topckgen CLK_TOP_APLL12_DIV2>,
+				<&topckgen CLK_TOP_APLL12_DIV3>,
+				<&topckgen CLK_TOP_APLL12_DIV9>,
+				<&topckgen CLK_TOP_A1SYS_HP>,
+				<&topckgen CLK_TOP_AUD_INTBUS>,
+				<&topckgen CLK_TOP_AUDIO_H>,
+				<&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
+				<&topckgen CLK_TOP_DPTX_MCK>,
+				<&topckgen CLK_TOP_I2SO1_MCK>,
+				<&topckgen CLK_TOP_I2SO2_MCK>,
+				<&topckgen CLK_TOP_I2SI1_MCK>,
+				<&topckgen CLK_TOP_I2SI2_MCK>,
+				<&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>,
+				<&scp_adsp CLK_SCP_ADSP_AUDIODSP>;
+			clock-names = "clk26m",
+				"apll1_ck",
+				"apll2_ck",
+				"apll12_div0",
+				"apll12_div1",
+				"apll12_div2",
+				"apll12_div3",
+				"apll12_div9",
+				"a1sys_hp_sel",
+				"aud_intbus_sel",
+				"audio_h_sel",
+				"audio_local_bus_sel",
+				"dptx_m_sel",
+				"i2so1_m_sel",
+				"i2so2_m_sel",
+				"i2si1_m_sel",
+				"i2si2_m_sel",
+				"infra_ao_audio_26m_b",
+				"scp_adsp_audiodsp";
+			status = "disabled";
+		};
+
 		uart0: serial@11001100 {
 			compatible = "mediatek,mt8195-uart",
 				     "mediatek,mt6577-uart";
-- 
2.18.0

