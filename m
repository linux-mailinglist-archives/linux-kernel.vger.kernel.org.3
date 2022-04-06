Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C84F58EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 11:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358175AbiDFJDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451246AbiDFI6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:58:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B694F4D;
        Tue,  5 Apr 2022 20:01:18 -0700 (PDT)
X-UUID: 86ce2accd19941c19653cafc602097aa-20220406
X-UUID: 86ce2accd19941c19653cafc602097aa-20220406
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 48669215; Wed, 06 Apr 2022 11:00:58 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 6 Apr 2022 11:00:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Apr
 2022 11:00:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 11:00:11 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <jassisinghbrar@gmail.com>,
        <fparent@baylibre.com>, <yongqiang.niu@mediatek.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v10 0/4] add display support for MediaTek SoC MT8186
Date:   Wed, 6 Apr 2022 11:00:05 +0800
Message-ID: <20220406030009.2357-1-rex-bc.chen@mediatek.com>
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

v10:
1. Rebase to 5.18-rc1
2. Drop "dt-bindings: display: mediatek: add aal binding for MT8183".
   I will move it to another series.

v9:
1. Revise [1/5] dt-bindings: display: mediatek: add aal binding for MT8183.

v8:
1. Revise [1/5] dt-bindings: display: mediatek: add aal binding for MT8183.

v7:
1. Rebase to chunkuang.hu/linux.git mediatek-drm-fixes

v6:
1. Remove mmsys patches which are accepted.
2. Fix error of dt-binding.

v5:
1. Add binding patch of aal for MT8183.
2. Revise enum to const.
3. Change to use enum for mutex.
4. Remove patches which are accepted by maintainers. (mmsys and mutex)

v4:
1. Remove binding of dsi and dpi.
2. Revise aal binding.
3. Fix indention in [4/5].

v3:
1. Modify display binding based on mtk display binding patch. ([1])
2. Remove patch: drm/mediatek: separate postmask component from mtk_disp_drv.c
3. Remove compatible of 8186 ovl because we can re-use compatible of 8192 for 8186.
4. Fix issue of space before tab on mutex patch.

[1]: repo: chunkuang.hu/linux.git, branch: mediatek-drm-next, id: 4ed545e7d10049b5492afc184e61a67e478a2cfd

v2:
1. Add binding documentation for mmsys, mutex and mtk_display.
2. Remove duplicated definition of postmask registers on mtk_drm_drv.
3. Add disp_ovl support for MT8186.
4. Add detailed commit messages.

Rex-BC Chen (3):
  dt-bindings: display: mediatek: revise enum to const
  dt-bindings: display: mediatek: change to use enum for mutex
  dt-bindings: display: mediatek: add MT8186 SoC binding

Yongqiang Niu (1):
  drm/mediatek: add display support for MT8186

 .../display/mediatek/mediatek,aal.yaml        |  5 ++-
 .../display/mediatek/mediatek,ccorr.yaml      |  5 ++-
 .../display/mediatek/mediatek,color.yaml      |  7 ++--
 .../display/mediatek/mediatek,dither.yaml     |  4 +--
 .../display/mediatek/mediatek,gamma.yaml      |  4 +--
 .../display/mediatek/mediatek,mutex.yaml      | 25 ++++++--------
 .../display/mediatek/mediatek,ovl-2l.yaml     |  4 +++
 .../display/mediatek/mediatek,ovl.yaml        |  8 +++--
 .../display/mediatek/mediatek,postmask.yaml   |  4 +++
 .../display/mediatek/mediatek,rdma.yaml       |  7 ++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 33 +++++++++++++++++++
 11 files changed, 74 insertions(+), 32 deletions(-)

-- 
2.18.0

