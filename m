Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0220B56159D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiF3JCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiF3JCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:02:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3001CB07;
        Thu, 30 Jun 2022 02:02:41 -0700 (PDT)
X-UUID: c8264c97a84f4022940658597600f7ce-20220630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:01da2bf9-3a61-4179-a1bc-774a66fdd761,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.7,REQID:01da2bf9-3a61-4179-a1bc-774a66fdd761,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:87442a2,CLOUDID:d2243fd6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:76234cabd6b8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c8264c97a84f4022940658597600f7ce-20220630
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 435326770; Thu, 30 Jun 2022 17:02:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 30 Jun 2022 17:02:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Jun 2022 17:02:29 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bin.zhang@mediatek.com>,
        <benliang.zhao@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: [PATCH v2 1/2] arm64: dts: mt8173: Fix nor_flash node
Date:   Thu, 30 Jun 2022 17:01:56 +0800
Message-ID: <20220630090157.29486-2-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630090157.29486-1-xiangsheng.hou@mediatek.com>
References: <20220630090157.29486-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add axi clock since the driver change to DMA mode which need
to enable axi clock. And change spi clock to 26MHz as default.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 40d7b47fc52e..e603170100af 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -790,9 +790,12 @@ thermal: thermal@1100b000 {
 		nor_flash: spi@1100d000 {
 			compatible = "mediatek,mt8173-nor";
 			reg = <0 0x1100d000 0 0xe0>;
+			assigned-clocks = <&topckgen CLK_TOP_SPI_SEL>;
+			assigned-clock-parents = <&clk26m>;
 			clocks = <&pericfg CLK_PERI_SPI>,
-				 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
-			clock-names = "spi", "sf";
+				 <&topckgen CLK_TOP_SPINFI_IFR_SEL>,
+				 <&pericfg CLK_PERI_NFI>;
+			clock-names = "spi", "sf", "axi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.25.1

