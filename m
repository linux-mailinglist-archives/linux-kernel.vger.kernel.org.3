Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19458F61B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiHKC6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiHKC61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:58:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919E688DE9;
        Wed, 10 Aug 2022 19:58:22 -0700 (PDT)
X-UUID: 090d2fc70ca74c8f95862d85f2e6788e-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zGavVwy7EYlT4pA18t1y7E0shYNsVQvTr6AYao2gGZg=;
        b=Lx89Py52GbF/N0it0pEgyWpITcI1eJSqb6MH94cn/36tVKi81FI0NLwQeTN/93NHohE3fTn8zJ27rlFEqRd12rp3akib90HMotYXVXXqpHqQP+KqQmt6jcgJCVxcOj/NDKK07JnSxeKRFrMNGGfXuKYUxwZVQNxoIsInS12qivs=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:970f8b1d-2c41-4880-825c-398ed7be4643,OB:0,LO
        B:40,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.9,REQID:970f8b1d-2c41-4880-825c-398ed7be4643,OB:0,LOB:
        40,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:3d8acc9,CLOUDID:e2077cae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:490ecd387210,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 090d2fc70ca74c8f95862d85f2e6788e-20220811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1760631513; Thu, 11 Aug 2022 10:58:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 10:58:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 10:58:16 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Trevor Wu <trevor.wu@mediatek.com>
Subject: [PATCH v6 15/20] arm64: dts: mt8195: Add audio related nodes
Date:   Thu, 11 Aug 2022 10:58:08 +0800
Message-ID: <20220811025813.21492-16-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220811025813.21492-1-tinghan.shen@mediatek.com>
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
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

