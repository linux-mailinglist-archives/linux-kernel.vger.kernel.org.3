Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0491519B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347087AbiEDJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347029AbiEDJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:23:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011821E08;
        Wed,  4 May 2022 02:19:35 -0700 (PDT)
X-UUID: ca14d32183424d448c0d46d80d6965cd-20220504
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.4,REQID:9a534bc4-4e08-4372-9b2c-6373e0f64873,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD,
        ACTION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.4,REQID:9a534bc4-4e08-4372-9b2c-6373e0f64873,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:120
X-CID-META: VersionHash:faefae9,CLOUDID:b4bb74c7-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:1f104d78aec3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: ca14d32183424d448c0d46d80d6965cd-20220504
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 673786629; Wed, 04 May 2022 17:19:28 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 17:19:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 17:19:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 4 May 2022 17:19:26 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <jitao.shi@mediatek.com>, <xinlei.lee@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v6 0/4] Add mt8186 dsi compatoble & Convert dsi_dtbinding to .yaml
Date:   Wed, 4 May 2022 17:19:19 +0800
Message-ID: <20220504091923.2219-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v5:
1. Drop #address-cells, #size-cells.
2. Based on chunkuang.hu/linux.git/mediatek-drm-next

Changes since v4:
1. Modify DSI dt-binding.
2. Add support for MT8186 DSI in mtk_drm_drv.c.

Changes since v3:
1. Add dsi port property.
2. Fix some formatting.

Changes since v2:
1. Added #address-cells, #size-cells two properties.
2. Fix some formatting issues.

Changes since v1:
1. Delete the mediatek,dsi.txt & Add the mediatek,dsi.yaml.
2. Ignore the Move the getting bridge node function patch for V1.

Rex-BC Chen (1):
  drm/mediatek: Add MT8186 DSI compatible for mtk_drm_drv.c

Xinlei Lee (3):
  dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml
  dt-bindings: display: mediatek: dsi: Add compatible for MediaTek
    MT8186
  drm/mediatek: Add mt8186 dsi compatible to mtk_dsi.c

 .../display/mediatek/mediatek,dsi.txt         |  62 ----------
 .../display/mediatek/mediatek,dsi.yaml        | 116 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   2 +
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   8 ++
 4 files changed, 126 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml

-- 
2.18.0

