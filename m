Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923DE57FCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiGYKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYKDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:03:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D51706F;
        Mon, 25 Jul 2022 03:03:07 -0700 (PDT)
X-UUID: 546db1d251104604b86b492a994e56a2-20220725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0c669bee-5efb-4c13-a930-313eec0af927,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:04e3c129-fd69-41f1-91fc-8b8a329d3a88,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 546db1d251104604b86b492a994e56a2-20220725
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1995892644; Mon, 25 Jul 2022 18:03:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 25 Jul 2022 18:03:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 25 Jul 2022 18:03:02 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 0/2] MT8186 pinctrl properties adjustments
Date:   Mon, 25 Jul 2022 18:02:51 +0800
Message-ID: <20220725100253.10687-1-allen-kh.cheng@mediatek.com>
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

Based on tag: next-20220720, linux-next/master.

In commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
PIN_CONFIG_DRIVE_STRENGTH_UA"), added support for using
drive-strength-microamp instead of mediatek,drive-strength-adv.

We replace the custom mediatek,drive-strength-adv property with
'drive-strength-microamp' in the mt8186 pinctrl dt-binding which
have a clearer meaning and is more standardized, also add
gpio-line-names property used in devicetrees to describe pin names.

Allen-KH Cheng (2):
  dt-bindings: pinctrl: mt8186: Add gpio-line-names property
  dt-bindings: pinctrl: mt8186: Add and use drive-strength-microamp

 .../bindings/pinctrl/pinctrl-mt8186.yaml      | 31 +++----------------
 1 file changed, 5 insertions(+), 26 deletions(-)

-- 
2.18.0

