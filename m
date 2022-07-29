Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD41584C03
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiG2GdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiG2Gc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:32:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D17FE7C;
        Thu, 28 Jul 2022 23:32:24 -0700 (PDT)
X-UUID: 000c9eacb80f40af8a4b1f5fb0f0ce3c-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:1e1b4e5c-4610-47b1-919c-3ca102592f0a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:c9d2a9d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 000c9eacb80f40af8a4b1f5fb0f0ce3c-20220729
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 992836200; Fri, 29 Jul 2022 14:32:15 +0800
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
        YC Hung <yc.hung@mediatek.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Subject: [PATCH v4 16/20] arm64: dts: mt8195: Add adsp node and adsp mailbox nodes
Date:   Fri, 29 Jul 2022 14:32:04 +0800
Message-ID: <20220729063208.16799-17-tinghan.shen@mediatek.com>
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

From: YC Hung <yc.hung@mediatek.corp-partner.google.com>

Add adsp node and adsp mailbox nodes for mt8195.

Signed-off-by: YC Hung <yc.hung@mediatek.corp-partner.google.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index bbea0acff3d2f..f42d33414125f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -739,6 +739,43 @@
 			#clock-cells = <1>;
 		};
 
+		adsp: dsp@10803000 {
+			compatible = "mediatek,mt8195-dsp";
+			reg = <0 0x10803000 0 0x1000>,
+			      <0 0x10840000 0 0x40000>;
+			reg-names = "cfg", "sram";
+			clocks = <&topckgen CLK_TOP_ADSP>,
+				 <&clk26m>,
+				 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
+				 <&topckgen CLK_TOP_MAINPLL_D7_D2>,
+				 <&scp_adsp CLK_SCP_ADSP_AUDIODSP>,
+				 <&topckgen CLK_TOP_AUDIO_H>;
+			clock-names = "adsp_sel",
+				 "clk26m_ck",
+				 "audio_local_bus",
+				 "mainpll_d7_d2",
+				 "scp_adsp_audiodsp",
+				 "audio_h";
+			power-domains = <&spm MT8195_POWER_DOMAIN_ADSP>;
+			mbox-names = "rx", "tx";
+			mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+			status = "disabled";
+		};
+
+		adsp_mailbox0: mailbox@10816000 {
+			compatible = "mediatek,mt8195-adsp-mbox";
+			#mbox-cells = <0>;
+			reg = <0 0x10816000 0 0x1000>;
+			interrupts = <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		adsp_mailbox1: mailbox@10817000 {
+			compatible = "mediatek,mt8195-adsp-mbox";
+			#mbox-cells = <0>;
+			reg = <0 0x10817000 0 0x1000>;
+			interrupts = <GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
 		afe: mt8195-afe-pcm@10890000 {
 			compatible = "mediatek,mt8195-audio";
 			reg = <0 0x10890000 0 0x10000>;
-- 
2.18.0

