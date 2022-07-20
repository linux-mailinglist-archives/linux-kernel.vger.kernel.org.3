Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F099757B6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiGTMuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiGTMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:50:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9451D0CD;
        Wed, 20 Jul 2022 05:50:24 -0700 (PDT)
X-UUID: c958adf384694742811bd18d469b2955-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:b9b69d9f-2bbf-44ec-8858-6cd1b4de00db,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:25eecd64-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: c958adf384694742811bd18d469b2955-20220720
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2091067653; Wed, 20 Jul 2022 20:50:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 20 Jul 2022 20:50:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jul 2022 20:50:18 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 2/4] arm64: dts: mediatek: Remove mt6589 wdt fallback string from mt7986
Date:   Wed, 20 Jul 2022 20:50:13 +0800
Message-ID: <20220720125015.13797-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220720125015.13797-1-allen-kh.cheng@mediatek.com>
References: <20220720125015.13797-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog driver for mt7986 relies on DT data. The fallback
compatible "mediatek,mt6589-wdt" won't work.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index e3a407d03551..6ab8329c635f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -113,8 +113,7 @@
 		};
 
 		watchdog: watchdog@1001c000 {
-			compatible = "mediatek,mt7986-wdt",
-				     "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt7986-wdt";
 			reg = <0 0x1001c000 0 0x1000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			#reset-cells = <1>;
-- 
2.18.0

