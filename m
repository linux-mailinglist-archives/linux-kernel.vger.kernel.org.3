Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9054B9ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiBQI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:27:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiBQI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:27:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4641C4553
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:27:02 -0800 (PST)
X-UUID: 3bda9c3e7c77403d80421edde0fef750-20220217
X-UUID: 3bda9c3e7c77403d80421edde0fef750-20220217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 984733380; Thu, 17 Feb 2022 16:26:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Feb 2022 16:26:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 16:26:55 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <chunkuang.hu@kernel.org>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2,0/2] Add mmsys reset control for MT8186
Date:   Thu, 17 Feb 2022 16:26:24 +0800
Message-ID: <20220217082626.15728-1-rex-bc.chen@mediatek.com>
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

v2:
1. Change variable type from unsigned int to u16.

v1:
1. Add a new variable in mmsys driver data to control different register
   offset for different SoCs.
2. Add MT8183 reset register offset.
3. Add mmsys reset control for MT8186.

This series is based on mmsys patch for MT8186 on [1].
[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220216084831.14883-4-rex-bc.chen@mediatek.com/

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

