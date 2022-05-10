Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987CB5214E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbiEJMOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbiEJMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:14:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F66C29955D;
        Tue, 10 May 2022 05:10:36 -0700 (PDT)
X-UUID: 92a1bd6914d1409d9db17c935f30dbec-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:1424fca2-f29c-432f-9896-a60fc4a5f581,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:108
X-CID-INFO: VERSION:1.1.4,REQID:1424fca2-f29c-432f-9896-a60fc4a5f581,OB:0,LOB:
        0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:108
X-CID-META: VersionHash:faefae9,CLOUDID:c69448b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:fc5b4ba0009f,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 92a1bd6914d1409d9db17c935f30dbec-20220510
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1566241701; Tue, 10 May 2022 20:10:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 20:10:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 10 May 2022 20:10:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH next v3 2/2] arm64: dts: mediatek: mt8195: enable usb remote wakeup
Date:   Tue, 10 May 2022 20:10:27 +0800
Message-ID: <20220510121027.19041-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510121027.19041-1-chunfeng.yun@mediatek.com>
References: <20220510121027.19041-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB remote wakeup of all four xHCI controller

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add reviewed-by AngeloGioacchino;

NOTE:
  based on v5.18-next/dts64 of matthias.bgg's branch

v2: no changes, based on new version of mt8195.dtsi
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d5bc4cf5f4ac..3ad14e0e0956 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -573,6 +573,8 @@
 				 <&apmixedsys CLK_APMIXED_USB1PLL>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -636,6 +638,8 @@
 				 <&apmixedsys CLK_APMIXED_USB1PLL>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck","xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 104>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -655,6 +659,8 @@
 				 <&topckgen CLK_TOP_SSUSB_P2_REF>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -674,6 +680,8 @@
 				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
+			wakeup-source;
 			status = "disabled";
 		};
 
-- 
2.18.0

