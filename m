Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379F4597F80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbiHRHu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHRHuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:50:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8654AEDB8;
        Thu, 18 Aug 2022 00:50:22 -0700 (PDT)
X-UUID: f4b565959cb54cf983c8fccf3b709810-20220818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vX2cKsWvqrnEhdZf9O25sP1+ldbSuDmn4Zp0hffNaYw=;
        b=QwwstUszz1fDHp5xQxEZkxNKfd3bC4i5HgLWyctQSYz+uG1kSuKWe+hmZ/pi/xfViyV8MS3/0WIQPRshaYhZhykc/J1Qqt52k1TwnNPZb5pBbZ/cmCmlguYZRsRP/xCuA8QdJkXh+a/A356G6UNuvwoX4HOkmpYQpRIIO0qwQEU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:b28166fc-59e6-46eb-a816-c7db45bb4653,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:84eae18,CLOUDID:b2dfabfd-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f4b565959cb54cf983c8fccf3b709810-20220818
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1820611805; Thu, 18 Aug 2022 15:50:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 18 Aug 2022 15:50:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 18 Aug 2022 15:50:14 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <wenst@google.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hui.liu@mediatek.com>, <jianguo.zhang@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <sean.wang@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/2] MediaTek pinctrl patch on mt8188
Date:   Thu, 18 Aug 2022 15:50:10 +0800
Message-ID: <20220818075012.20880-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series include 2 patches:
1.Add pinmux definition file and pinctrl binding document for mt8188.
2.Add pinctrl driver for mt8188.

Changes in patch v6:
1.Update driver file's coding style.

Changes in patch v5:
1.Move ref pincfg-node.yaml to the child '^pins' node in binding document.

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
  dt-bindings: pinctrl: mediatek: add support for mt8188
  pinctrl: mediatek: add mt8188 driver

 .../pinctrl/mediatek,mt8188-pinctrl.yaml      |  226 ++
 drivers/pinctrl/mediatek/Kconfig              |   12 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c     | 1673 ++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h | 2259 +++++++++++++++++
 .../pinctrl/mediatek,mt8188-pinfunc.h         | 1280 ++++++++++
 6 files changed, 5451 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8188.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h

--
2.18.0


