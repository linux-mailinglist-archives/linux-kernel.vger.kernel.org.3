Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D35895F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiHDCQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbiHDCQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:16:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72625F9B9;
        Wed,  3 Aug 2022 19:16:03 -0700 (PDT)
X-UUID: e9b1129388ab4db89f66e323accd1ddc-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6XCLJi1b1GHbPwsBs59y1bciTCc4ZBKt1+LLwvRqQ8I=;
        b=iArgNcvcay83+Gt6jYp2hEufM0bOXYCDytx3T7GtdBV9C9DvhTMRAMLOgcZgcVqqPbc71GZGcUEiG/V8Z21LdFjTQIEcfzyhdDK6Bhv4v7KBRU/3BWsocIb1yPHQLZoB9jAQrWIFyK+EsilIWkBADXrsZWHEIR5C6l7UZ+ujFr4=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.8,REQID:43954860-acd5-4e5e-a3a5-943f83dd6e2d,OB:10,L
        OB:30,IP:0,URL:0,TC:0,Content:51,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885A
        D,ACTION:quarantine,TS:146
X-CID-INFO: VERSION:1.1.8,REQID:43954860-acd5-4e5e-a3a5-943f83dd6e2d,OB:10,LOB
        :30,IP:0,URL:0,TC:0,Content:51,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_US65DF41,
        ACTION:quarantine,TS:146
X-CID-META: VersionHash:0f94e32,CLOUDID:80432cd1-841b-4e95-ad42-8f86e18f54fc,C
        OID:b26f930e2af2,Recheck:0,SF:28|17|19|48|801,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e9b1129388ab4db89f66e323accd1ddc-20220804
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 41814932; Thu, 04 Aug 2022 10:15:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 10:15:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 10:15:56 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Fengquan Chen <fengquan.chen@mediatek.com>
Subject: [PATCH v5 08/20] arm64: dts: mt8195: Disable watchdog external reset signal
Date:   Thu, 4 Aug 2022 10:15:41 +0800
Message-ID: <20220804021553.14867-9-tinghan.shen@mediatek.com>
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

Disable the external output reset signal of watchdog reset to avoid losing
the reset reason stored in the watchdog registers.

Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
 b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 066c14989708a..436687ba826f4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -327,6 +327,7 @@
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8195-wdt",
 				     "mediatek,mt6589-wdt";
+			mediatek,disable-extrst;
 			reg = <0 0x10007000 0 0x100>;
 		};
 
-- 
2.18.0

