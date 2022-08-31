Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92545A76F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiHaGwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHaGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:52:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12108BB01B;
        Tue, 30 Aug 2022 23:52:08 -0700 (PDT)
X-UUID: 8cbad9a6adbf41e3a311077df023b96f-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zZjVZDQq7+xjRP70G/4mz1/Tz13+LwwewsQB5MYr1aY=;
        b=iU6zAe7w96O5/yok5Htj3g2Bc/sr8POkgi7lISwBVQufTXXgd2rWiF7MyFZBKf6E1+irrk+wpekJ7CIijyhyI9MCYr/44Hq3Bdwxdiwk1PmUfiLythwNmfZR49ShJDX3/UQ+Fre4eu0OeSgRmFgmDHKtK0atAT1hw1miUlYb+k8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:1f7046e8-c890-4ef2-9d7d-2ce6e5f48432,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:1f7046e8-c890-4ef2-9d7d-2ce6e5f48432,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:3a801e56-e800-47dc-8adf-0c936acf4f1b,C
        OID:84f7351a45d3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8cbad9a6adbf41e3a311077df023b96f-20220831
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 167975469; Wed, 31 Aug 2022 14:51:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 31 Aug 2022 14:51:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Aug 2022 14:51:57 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1] arm64: dts: mediatek: Fix build warnings of mt8173 vcodec nodes
Date:   Wed, 31 Aug 2022 14:51:00 +0800
Message-ID: <20220831065100.27722-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the phandle of power domain node referenced by vcodec nodes.

arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning (power_domains_property): /soc/vcodec@18002000: Missing property '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[0])
arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning (power_domains_property): /soc/vcodec@19002000: Missing property '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[0])

Fixes: d3dfd4688574 ("arm64: dts: mediatek: Update mt81xx scpsys node to align with dt-bindings")
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index b4d48f8b7eeb..7640b5158ff9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1467,7 +1467,7 @@
 			clock-names = "venc_sel";
 			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
 			assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_VENC>;
 		};
 
 		jpegdec: jpegdec@18004000 {
@@ -1518,7 +1518,7 @@
 			assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
 			assigned-clock-parents =
 				 <&topckgen CLK_TOP_VCODECPLL_370P5>;
-			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
+			power-domains = <&spm MT8173_POWER_DOMAIN_VENC_LT>;
 		};
 	};
 };
-- 
2.18.0

