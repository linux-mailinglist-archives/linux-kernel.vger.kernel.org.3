Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7484EC5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346157AbiC3Nkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346133AbiC3NkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:40:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285D13FB9;
        Wed, 30 Mar 2022 06:38:30 -0700 (PDT)
X-UUID: fef7316869fd4bf3b87caa4c87531f33-20220330
X-UUID: fef7316869fd4bf3b87caa4c87531f33-20220330
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1270786931; Wed, 30 Mar 2022 21:38:26 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Mar 2022 21:38:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Mar
 2022 21:38:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 21:38:24 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v5 2/4] arm64: dts: mt8192: Add mmc device nodes
Date:   Wed, 30 Mar 2022 21:38:14 +0800
Message-ID: <20220330133816.30806-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
References: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmc nodes for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 69e8d1934d53..c1057878e2c6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -991,6 +991,38 @@
 			#clock-cells = <1>;
 		};
 
+		mmc0: mmc@11f60000 {
+			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11f60000 0 0x1000>, <0 0x11f50000 0 0x1000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
+				 <&msdc_top CLK_MSDC_TOP_H_MST_0P>,
+				 <&msdc_top CLK_MSDC_TOP_SRC_0P>,
+				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
+				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>,
+				 <&msdc_top CLK_MSDC_TOP_AXI>,
+				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
+			clock-names = "source", "hclk", "source_cg", "sys_cg",
+				      "pclk_cg", "axi_cg", "ahb_cg";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11f70000 {
+			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11f70000 0 0x1000>, <0 0x11c70000 0 0x1000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
+				 <&msdc_top CLK_MSDC_TOP_H_MST_1P>,
+				 <&msdc_top CLK_MSDC_TOP_SRC_1P>,
+				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
+				 <&msdc_top CLK_MSDC_TOP_P_MSDC1>,
+				 <&msdc_top CLK_MSDC_TOP_AXI>,
+				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
+			clock-names = "source", "hclk", "source_cg", "sys_cg",
+				      "pclk_cg", "axi_cg", "ahb_cg";
+			status = "disabled";
+		};
+
 		mfgcfg: clock-controller@13fbf000 {
 			compatible = "mediatek,mt8192-mfgcfg";
 			reg = <0 0x13fbf000 0 0x1000>;
-- 
2.18.0

