Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57E4574D99
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiGNM3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiGNM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:28:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B01BEBC;
        Thu, 14 Jul 2022 05:28:52 -0700 (PDT)
X-UUID: 3d3c3caf7502412687c0d8e4783a4b46-20220714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:1cc26805-5da1-481a-acab-bb082bee986f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:a339fd32-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 3d3c3caf7502412687c0d8e4783a4b46-20220714
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 94589542; Thu, 14 Jul 2022 20:28:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 14 Jul 2022 20:28:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 14 Jul 2022 20:28:40 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 06/19] arm64: dts: mediatek: Update mt81xx scpsys node to align with dt-bindings
Date:   Thu, 14 Jul 2022 20:28:24 +0800
Message-ID: <20220714122837.20094-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220714122837.20094-1-tinghan.shen@mediatek.com>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
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

Update scpsys nodes using simple-mfd in mt81xx SoC devicetree
to align with the bindings.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 54655f2feb04..b3debea0edf8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -36,9 +36,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			spm: power-controller {
 				compatible = "mediatek,mt8167-power-controller";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 6d9513c1f5bf..8f536f1344ec 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -444,9 +444,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9d32871973a2..699bf445cc2e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -761,9 +761,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index cbae5a5ee4a0..f5f944cc623c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -306,9 +306,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
-- 
2.18.0

