Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779F157B6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiGTMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiGTMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:50:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFEC1C110;
        Wed, 20 Jul 2022 05:50:22 -0700 (PDT)
X-UUID: 47e5c28bc26947a892aed9378db2d4db-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:db877d1b-f2a0-4cff-8a59-c8a7c30b6920,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:efedcd64-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 47e5c28bc26947a892aed9378db2d4db-20220720
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1605568365; Wed, 20 Jul 2022 20:50:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 20 Jul 2022 20:50:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jul 2022 20:50:16 +0800
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
Subject: [PATCH v3 0/4] mediatek: watchdog: Fix compatible fallbacks
Date:   Wed, 20 Jul 2022 20:50:11 +0800
Message-ID: <20220720125015.13797-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Based on tag: next-20220719, linux-next/master

Beacase there are some PATCHs of mediatek wdt waiting to merge,
I remove "Convert binding to YAML" PATCH to not cause dtbs errors.

We will resend "watchdog: Convert binding to YAML" PATCH in the future.

changes since v2:
 - remove "Convert binding to YAML" PATCH from series
 - fix example
 - change cover letter title

changes since v1:
 - fix dtbs_check warnings in dts
 - use enum instead of multiple const values
 - remove timeout-sec
 - rewrite examples
 - rename schema to mediatek,wdt.yaml

Allen-KH Cheng (4):
  dt-binding: mediatek: watchdog: Fix compatible fallbacks and examples
  arm64: dts: mediatek: Remove mt6589 wdt fallback string from mt7986
  arm64: dts: mediatek: Remove mt6589 wdt fallback string from mt8195
  arm64: dts: mediatek: Fix the watchdog node name

 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 9 ++++-----
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi              | 3 +--
 arch/arm64/boot/dts/mediatek/mt8195.dtsi               | 3 +--
 arch/arm64/boot/dts/mediatek/mt8516.dtsi               | 2 +-
 4 files changed, 7 insertions(+), 10 deletions(-)

-- 
2.18.0

