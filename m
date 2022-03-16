Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7804DAA3D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353749AbiCPGDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiCPGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:03:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B1606D5;
        Tue, 15 Mar 2022 23:01:56 -0700 (PDT)
X-UUID: 501b0dfcbd144bcfa85feb8c39074dd8-20220316
X-UUID: 501b0dfcbd144bcfa85feb8c39074dd8-20220316
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1438559515; Wed, 16 Mar 2022 14:01:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Mar 2022 14:01:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 14:01:45 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <yc.hung@mediatek.com>
Subject: [PATCH v2 0/5] ASoC: mediatek: Add support for MT8195 sound card with max98390 and rt5682
Date:   Wed, 16 Mar 2022 14:01:34 +0800
Message-ID: <20220316060139.6211-1-trevor.wu@mediatek.com>
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

This series of patches adds support for mt8195 board with mt6359, max98390
and rt5682.

To prevent from copy-paste components, mt8195 machine drivers and 
dt-bindings are merged in the patch.

Patches are based on broonie tree "for-next" branch.

Changes since v1:
  - remove merged patches about reset controller
  - propose a common machine driver instead of machine driver common code
  - propose a common dt-bindings for mt8195 sound card

Trevor Wu (5):
  ASoC: mediatek: mt8195: merge machine driver
  ASoC: dt-bindings: mediatek: mt8195: merge mt8195 machine yaml
  ASoC: mediatek: mt8195: rename card controls
  ASoC: mediatek: mt8195: add machine support for max98390 and rt5682
  ASoC: dt-bindings: mediatek: mt8195: support
    mt8195-mt6359-max98390-rt5682

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   51 -
 ...-rt1019-rt5682.yaml => mt8195-mt6359.yaml} |    9 +-
 sound/soc/mediatek/Kconfig                    |   26 +-
 sound/soc/mediatek/mt8195/Makefile            |    3 +-
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      | 1198 -----------------
 ...mt6359-rt1019-rt5682.c => mt8195-mt6359.c} |  984 +++++++++-----
 6 files changed, 634 insertions(+), 1637 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
 rename Documentation/devicetree/bindings/sound/{mt8195-mt6359-rt1019-rt5682.yaml => mt8195-mt6359.yaml} (84%)
 delete mode 100644 sound/soc/mediatek/mt8195/mt8195-mt6359-rt1011-rt5682.c
 rename sound/soc/mediatek/mt8195/{mt8195-mt6359-rt1019-rt5682.c => mt8195-mt6359.c} (76%)

-- 
2.18.0

