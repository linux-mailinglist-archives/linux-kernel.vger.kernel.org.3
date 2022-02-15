Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD03F4B6D43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbiBONUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:20:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiBONUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:20:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEBDF406D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:20:18 -0800 (PST)
X-UUID: dae550f7710c49e780f048a18a7ad624-20220215
X-UUID: dae550f7710c49e780f048a18a7ad624-20220215
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 736834964; Tue, 15 Feb 2022 21:20:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 21:20:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 21:20:12 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <chunkuang.hu@kernel.org>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>, <enric.balletbo@collabora.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [0/2] Add mmsys reset control for MT8186
Date:   Tue, 15 Feb 2022 21:19:50 +0800
Message-ID: <20220215131952.27861-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

This series is based on mmsys patch for MT8186 on [1].
[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220215075953.3310-4-rex-bc.chen@mediatek.com/

v1
1. Add a new variable in mmsys driver data to control different register offset for different SoCs.
2. Add MT8183 reset register offset.
3. Add mmsys reset control for MT8186.

Rex-BC Chen (2):
  soc: mediatek: mmsys: add sw0_rst_offset in mmsys driver data
  soc: mediatek: mmsys: add mmsys reset control for MT8186

 drivers/soc/mediatek/mt8183-mmsys.h | 2 ++
 drivers/soc/mediatek/mt8186-mmsys.h | 2 ++
 drivers/soc/mediatek/mtk-mmsys.c    | 7 +++++--
 drivers/soc/mediatek/mtk-mmsys.h    | 3 +--
 4 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.18.0

