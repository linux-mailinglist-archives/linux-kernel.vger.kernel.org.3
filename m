Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD44BB539
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiBRJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:18:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiBRJRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:17:12 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B610FF4;
        Fri, 18 Feb 2022 01:16:54 -0800 (PST)
X-UUID: 93edd37a171b480d82978a523621782a-20220218
X-UUID: 93edd37a171b480d82978a523621782a-20220218
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 884860929; Fri, 18 Feb 2022 17:16:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Feb 2022 17:16:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Feb 2022 17:16:51 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 16/23] arm64: dts: mt8192: Add H264 venc device node
Date:   Fri, 18 Feb 2022 17:16:26 +0800
Message-ID: <20220218091633.9368-17-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
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
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 40887120fdb3..936aa788664f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1342,6 +1342,29 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
 		};
 
+		vcodec_enc: vcodec@0x17020000 {
+			compatible = "mediatek,mt8192-vcodec-enc";
+			reg = <0 0x17020000 0 0x2000>;
+			iommus = <&iommu0 M4U_PORT_L7_VENC_RCPU>,
+				<&iommu0 M4U_PORT_L7_VENC_REC>,
+				<&iommu0 M4U_PORT_L7_VENC_BSDMA>,
+				<&iommu0 M4U_PORT_L7_VENC_SV_COMV>,
+				<&iommu0 M4U_PORT_L7_VENC_RD_COMV>,
+				<&iommu0 M4U_PORT_L7_VENC_CUR_LUMA>,
+				<&iommu0 M4U_PORT_L7_VENC_CUR_CHROMA>,
+				<&iommu0 M4U_PORT_L7_VENC_REF_LUMA>,
+				<&iommu0 M4U_PORT_L7_VENC_REF_CHROMA>,
+				<&iommu0 M4U_PORT_L7_VENC_SUB_R_LUMA>,
+				<&iommu0 M4U_PORT_L7_VENC_SUB_W_LUMA>;
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

