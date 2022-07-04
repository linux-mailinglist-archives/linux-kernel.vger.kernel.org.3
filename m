Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219AF565193
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiGDKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiGDKAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:00:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC13DF03;
        Mon,  4 Jul 2022 03:00:45 -0700 (PDT)
X-UUID: b6ac0974999748ddab64c239eff7ad7c-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:c35b9395-02ff-41eb-85a7-62f78447acbe,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:87442a2,CLOUDID:ad2e7e86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: b6ac0974999748ddab64c239eff7ad7c-20220704
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2106127853; Mon, 04 Jul 2022 18:00:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 4 Jul 2022 18:00:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 4 Jul 2022 18:00:31 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Trevor Wu <trevor.wu@mediatek.com>
Subject: [PATCH v1 13/16] arm64: dts: mt8195: Specify audio reset controller
Date:   Mon, 4 Jul 2022 18:00:25 +0800
Message-ID: <20220704100028.19932-14-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220704100028.19932-1-tinghan.shen@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trevor Wu <trevor.wu@mediatek.com>

Specify audio reset controller for audio hardware resetting.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 0e5614108c12..618fb2fa195a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -681,6 +681,7 @@
 				     "mediatek,mt6589-wdt";
 			mediatek,disable-extrst;
 			reg = <0 0x10007000 0 0x100>;
+			#reset-cells = <1>;
 		};
 
 		apmixedsys: syscon@1000c000 {
@@ -783,6 +784,8 @@
 			mediatek,topckgen = <&topckgen>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_AUDIO>;
 			interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+			resets = <&watchdog 14>;
+			reset-names = "audiosys";
 			clocks = <&clk26m>,
 				<&apmixedsys CLK_APMIXED_APLL1>,
 				<&apmixedsys CLK_APMIXED_APLL2>,
-- 
2.18.0

