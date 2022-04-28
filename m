Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77774513554
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347441AbiD1NlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347300AbiD1NlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:41:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C609F986D7;
        Thu, 28 Apr 2022 06:38:01 -0700 (PDT)
X-UUID: d309ffee3c9b4fbb96e6eb8d27b5a8e6-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:11fd026f-1d19-46a7-895e-072e0acfe536,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:ee51d6c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: d309ffee3c9b4fbb96e6eb8d27b5a8e6-20220428
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1992065373; Thu, 28 Apr 2022 21:37:55 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 21:37:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 21:37:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 21:37:54 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <jitao.shi@mediatek.com>, <xinlei.lee@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v5 0/4] Add mt8186 dsi compatoble & Convert dsi_dtbinding to .yaml
Date:   Thu, 28 Apr 2022 21:37:49 +0800
Message-ID: <20220428133753.8348-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../display/mediatek/mediatek,dsi.txt         |  62 ---------
 .../display/mediatek/mediatek,dsi.yaml        | 123 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   2 +
 drivers/gpu/drm/mediatek/mtk_dsi.c            |   8 ++
 4 files changed, 133 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml

-- 
2.18.0

