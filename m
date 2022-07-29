Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69645584EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiG2KZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiG2KZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:25:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE20A82450;
        Fri, 29 Jul 2022 03:25:02 -0700 (PDT)
X-UUID: 1899f163b777413ca0fe6c7d74e23ee5-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:83e7240c-24e5-45f9-a811-6e74ce692894,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:1e7eba24-a982-4824-82d2-9da3b6056c2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 1899f163b777413ca0fe6c7d74e23ee5-20220729
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 47033403; Fri, 29 Jul 2022 18:24:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 29 Jul 2022 18:24:54 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jul 2022 18:24:53 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hui.liu@mediatek.com>, <jianguo.zhang@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <sean.wang@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] MediaTek pinctrl patch on mt8188
Date:   Fri, 29 Jul 2022 18:24:50 +0800
Message-ID: <20220729102452.9478-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series include 2 patches:
1.Add pinmux definition file and pinctrl binding document for mt8188.
2.Add pinctrl driver for mt8188.

Changes in patch v4:
1.Add gpio-line-names in binding document.
2.Fix typo in driver files.

Changes in patch v3:
1.Fix binding document dt_binding_check fail issue.

Changes in patch v2:
1.Change pinmux definition file name to mediatek,mt8188-pinfunc.h.
2.Change binding document name to mediatek,mt8188-pinctrl.yaml.
3.Update yaml description.

Changes in patch v1:
1.Add pinmux definition file.
2.Add binding document.
3.Add mt8188 pinctrl drivers.

*** BLURB HERE ***

Hui.Liu (2):
  dt-bindings: pinctrl: add support for mediatek mt8188
  pinctrl: mediatek: add mt8188 driver

 .../pinctrl/mediatek,mt8188-pinctrl.yaml      |  238 ++
 drivers/pinctrl/mediatek/Kconfig              |   12 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c     | 1669 ++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h | 2260 +++++++++++++++++
 .../pinctrl/mediatek,mt8188-pinfunc.h         | 1280 ++++++++++
 6 files changed, 5460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8188.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h

--
2.18.0


