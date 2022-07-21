Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51F57C1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiGUBtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiGUBtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:49:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C4C7697A;
        Wed, 20 Jul 2022 18:48:59 -0700 (PDT)
X-UUID: 4594b002f70c45eb9fc2e4b13eacfb1d-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:aad3bed3-a3a8-43e7-8281-f28e1e992832,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:f2320ad8-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4594b002f70c45eb9fc2e4b13eacfb1d-20220721
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1437525983; Thu, 21 Jul 2022 09:48:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 21 Jul 2022 09:48:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jul 2022 09:48:53 +0800
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
Subject: [PATCH v4 0/4] mediatek: watchdog: Fix compatible fallbacks
Date:   Thu, 21 Jul 2022 09:48:41 +0800
Message-ID: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
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

Based on tag: next-20220720, linux-next/master

Beacase there are some PATCHs of mediatek wdt waiting to merge,
I drop "Convert binding to YAML" PATCH to not cause dtbs errors in
series v2.

We will send "watchdog: Convert binding to YAML" PATCH in the future.

changes since v3:
 - fix commit title (from dt-binding to dt-bindings)
 - Add RoB tags

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
  dt-bindings: mediatek: watchdog: Fix compatible fallbacks and example
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

