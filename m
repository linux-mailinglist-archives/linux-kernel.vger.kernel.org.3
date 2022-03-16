Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772434DA9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353621AbiCPFhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbiCPFhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:37:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92D45DE40
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:36:02 -0700 (PDT)
X-UUID: 33ea8af6e48649f3bae59bc1cfcc7359-20220316
X-UUID: 33ea8af6e48649f3bae59bc1cfcc7359-20220316
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1833142543; Wed, 16 Mar 2022 13:35:40 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Mar 2022 13:35:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Mar
 2022 13:35:38 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 16 Mar 2022 13:35:37 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v3,0/3] Add mt8186 dsi compatoble & Convert  dsi_dtbinding to .yaml
Date:   Wed, 16 Mar 2022 13:35:31 +0800
Message-ID: <1647408934-15775-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Changes since v2:
1. Added #address-cells, #size-cells two properties.
2. Fix some formatting issues.

Changes since v1:
1. Delete the mediatek,dsi.txt & Add the mediatek,dsi.yaml.
2. Ignore the Move the getting bridge node function patch for V1.

Xinlei Lee (3):
  dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml
  dt-bindings: display: mediatek: dsi: Add compatible for MediaTek
    MT8186
  drm/mediatek: Add mt8186 dsi compatible to mtk_dsi.c

 .../display/mediatek/mediatek,dsi.txt         | 62 ------------
 .../display/mediatek/mediatek,dsi.yaml        | 97 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  8 ++
 3 files changed, 105 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml

-- 
2.18.0

