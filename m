Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D158960B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbiHDCRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiHDCQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:16:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4DF5FAD5;
        Wed,  3 Aug 2022 19:16:05 -0700 (PDT)
X-UUID: 73fbe67277224c8698e231a2c4711b90-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7QEfDCmJpysBJ72erbrBABvMpGnkHVze3l/EuEEccys=;
        b=jq2bAjoYa62PNQto15vHXvGPViBRIRd7FO3InRSrUcLafckwxGhRnxSrBqWR/ncMUq/PssYeWeEjLbK36rvHID3FwPpZonLdxtf3R/x7AdAZSfrT/9S9Puzvqu0reCATtAoQcqUqU+sJYBAKETnt6KTLWYxcFYreTVcoTFJ9hOE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:5e8eabc8-49ca-45c3-b03e-664e0b4aed57,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:3ac03bd0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 73fbe67277224c8698e231a2c4711b90-20220804
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 936671233; Thu, 04 Aug 2022 10:15:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 10:15:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 10:15:56 +0800
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 07/20] arm64: dts: mediatek: Update mt81xx scpsys node to align with dt-bindings
Date:   Thu, 4 Aug 2022 10:15:40 +0800
Message-ID: <20220804021553.14867-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220804021553.14867-1-tinghan.shen@mediatek.com>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update scpsys nodes using simple-mfd in mt81xx SoC devicetree
to align with the bindings.

Add specific compatibles for syscon node, even it's a dummy compatible,
because syscon node must come with a specific compatible.

Remove the '#power-domain-cells" propertry since the simple-mfd node is
not the power domain provider; the provider is the child node.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 +--
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
 b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 54655f2feb04d..fbe1a1128cc6a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -36,9 +36,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,mt8167-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			spm: power-controller {
 				compatible = "mediatek,mt8167-power-controller";
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
 b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 6d9513c1f5bfb..b4d48f8b7eebb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -444,9 +444,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,mt8173-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
 b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9d32871973a29..28d84f0054ee0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -761,9 +761,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,mt8183-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
 b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index cbae5a5ee4a0b..8cd5906fe3a89 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -306,9 +306,8 @@
 		};
 
 		scpsys: syscon@10006000 {
-			compatible = "syscon", "simple-mfd";
+			compatible = "mediatek,mt8192-scpsys", "syscon", "simple-mfd";
 			reg = <0 0x10006000 0 0x1000>;
-			#power-domain-cells = <1>;
 
 			/* System Power Manager */
 			spm: power-controller {
-- 
2.18.0

