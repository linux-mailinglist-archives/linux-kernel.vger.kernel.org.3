Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848694BA182
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiBQNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:41:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbiBQNlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:41:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FBA2AF929;
        Thu, 17 Feb 2022 05:40:44 -0800 (PST)
X-UUID: 5f465861d88a4398bd8999c9b0791c27-20220217
X-UUID: 5f465861d88a4398bd8999c9b0791c27-20220217
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 63017685; Thu, 17 Feb 2022 21:40:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Feb 2022 21:40:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 21:40:39 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 05/17] arm64: dts: mt8192: Add SCP node
Date:   Thu, 17 Feb 2022 21:40:23 +0800
Message-ID: <20220217134027.508-6-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220217134027.508-1-allen-kh.cheng@mediatek.com>
References: <20220217134027.508-1-allen-kh.cheng@mediatek.com>
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

Add SCP node for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index c432711a318d..9d9bb67bc65d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -705,6 +705,18 @@
 			status = "disabled";
 		};
 
+		scp: scp@10500000 {
+			compatible = "mediatek,mt8192-scp";
+			reg = <0 0x10500000 0 0x100000>,
+			    <0 0x10700000 0 0x8000>,
+			    <0 0x10720000 0 0xe0000>;
+			reg-names = "sram", "l1tcm", "cfg";
+			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_SCPSYS>;
+			clock-names = "main";
+			status = "disabled";
+		};
+
 		nor_flash: spi@11234000 {
 			compatible = "mediatek,mt8192-nor";
 			reg = <0 0x11234000 0 0xe0>;
-- 
2.18.0

