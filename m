Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8BB4EC5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiC3NkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiC3NkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:40:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9B015A13;
        Wed, 30 Mar 2022 06:38:32 -0700 (PDT)
X-UUID: 6a0950ea26fb4a769ab5fcdc01b634a1-20220330
X-UUID: 6a0950ea26fb4a769ab5fcdc01b634a1-20220330
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 246571736; Wed, 30 Mar 2022 21:38:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Mar 2022 21:38:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 21:38:26 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v5 3/4] arm64: dts: mt8192: Add H264 venc device node
Date:   Wed, 30 Mar 2022 21:38:15 +0800
Message-ID: <20220330133816.30806-4-allen-kh.cheng@mediatek.com>
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

Adds H264 venc node for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index c1057878e2c6..3d61238fb102 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1166,6 +1166,29 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
 		};
 
+		vcodec_enc: vcodec@17020000 {
+			compatible = "mediatek,mt8192-vcodec-enc";
+			reg = <0 0x17020000 0 0x2000>;
+			iommus = <&iommu0 M4U_PORT_L7_VENC_RCPU>,
+				 <&iommu0 M4U_PORT_L7_VENC_REC>,
+				 <&iommu0 M4U_PORT_L7_VENC_BSDMA>,
+				 <&iommu0 M4U_PORT_L7_VENC_SV_COMV>,
+				 <&iommu0 M4U_PORT_L7_VENC_RD_COMV>,
+				 <&iommu0 M4U_PORT_L7_VENC_CUR_LUMA>,
+				 <&iommu0 M4U_PORT_L7_VENC_CUR_CHROMA>,
+				 <&iommu0 M4U_PORT_L7_VENC_REF_LUMA>,
+				 <&iommu0 M4U_PORT_L7_VENC_REF_CHROMA>,
+				 <&iommu0 M4U_PORT_L7_VENC_SUB_R_LUMA>,
+				 <&iommu0 M4U_PORT_L7_VENC_SUB_W_LUMA>;
+			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,scp = <&scp>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
+			clocks = <&vencsys CLK_VENC_SET1_VENC>;
+			clock-names = "venc-set1";
+			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
+		};
+
 		camsys: clock-controller@1a000000 {
 			compatible = "mediatek,mt8192-camsys";
 			reg = <0 0x1a000000 0 0x1000>;
-- 
2.18.0

