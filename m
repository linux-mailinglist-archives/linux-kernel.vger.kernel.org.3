Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08054F1CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380645AbiFQHYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380257AbiFQHXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:23:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D053E05;
        Fri, 17 Jun 2022 00:23:53 -0700 (PDT)
X-UUID: 894467609e6d49aca68c586da10d172a-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:a8aee636-c2eb-46ec-ac27-5bcf80d58329,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:e9b79cf6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 894467609e6d49aca68c586da10d172a-20220617
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 56061982; Fri, 17 Jun 2022 15:23:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 17 Jun 2022 15:23:48 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jun 2022 15:23:47 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH v4 2/2] arm64: dts: mediatek: mt8195: enable usb remote wakeup
Date:   Fri, 17 Jun 2022 15:23:44 +0800
Message-ID: <20220617072344.21461-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617072344.21461-1-chunfeng.yun@mediatek.com>
References: <20220617072344.21461-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB remote wakeup of all four xHCI controller

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v4: add tested-by Macpaul

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

