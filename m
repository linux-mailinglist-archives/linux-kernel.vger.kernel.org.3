Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23F5AD404
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiIENeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiIENej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:34:39 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC01CA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:34:33 -0700 (PDT)
X-UUID: c99442c9e7f24fc1a7381be9178399cf-20220905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UfLaIp5pzzf3WxqPTjnVCo6M+9ve/q07xHmXwq/EvSA=;
        b=Cj+mzY5v8YN+085Ns48x24WF8uvt8pSkzr6T0lGKa0lN6GViZSviinnPj6SLN6izFYr5oa7SeMM+Dj7FBMnwA2xGYUMjrXbas3vwgUZRBwp0+bOiHyBT1lhU8/UC6wC6M1utNLQEZofBgy/fi6JG18/+gr1rQpbYZddARg3/9rY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:18bb6dd5-169a-4095-b8d4-8bdb52a8b798,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:18bb6dd5-169a-4095-b8d4-8bdb52a8b798,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:dee53b21-1c20-48a5-82a0-25f9c331906d,C
        OID:c4693867a301,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c99442c9e7f24fc1a7381be9178399cf-20220905
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 291383995; Mon, 05 Sep 2022 21:34:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 5 Sep 2022 21:34:26 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 5 Sep 2022 21:34:25 +0800
From:   <xinlei.lee@mediatek.com>
To:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <rex-bc.chen@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <chunkuang.hu@kernel.org>, <yongqiang.niu@mediatek.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v5,0/2] Add dpi output format control for MT8186
Date:   Mon, 5 Sep 2022 21:34:21 +0800
Message-ID: <1662384863-17281-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Base on the branch of Linux-next/master.

Changes since v4:
1. This series of cancellations is based on the following patches:
   [1] Add MediaTek SoC(vdosys1) support for mt8195
   https://patchwork.kernel.org/project/linux-mediatek/cover/20220711075245.10492-1-nancy.lin@mediatek.com/
   [2] Add MediaTek SoC DRM (vdosys1) support for mt8195
   https://patchwork.kernel.org/project/linux-mediatek/cover/20220804072827.22383-1-nancy.lin@mediatek.com/
2. Added mtk_mmsys_update_bits function in mtk-mmsys.c;
3. MMSYS 0x400 register is modified to MT8186_MMSYS_DPI_OUTPUT_FORMAT;
4. Fix formatting issues.

Changes since v3:
1. Fix formatting issues;
2. Modify the edge output control name & description;
3. Fix the threading problem.

Changes since v2:
1. Modify key nouns in the description;
2. Add the label of jitao to Co-developed-by;
3. Macro definition address lowercase problem and function naming;
4. Add missing a description of this property in the mtk_dpi_conf.

Change since v1:
1. Modify mt8186 compatiable location.
2. Modify MT8186_DPI_OUTPUT_FORMAT name.

When MT8186 outputs dpi signal, it is necessary to add dual edge output
format control in mmsys.

Xinlei Lee (2):
  FROMLIST: soc: mediatek: Add mmsys func to adapt to dpi output for
    MT8186
  FROMLIST: drm: mediatek: Adjust the dpi output format to MT8186

 drivers/gpu/drm/mediatek/mtk_dpi.c      | 31 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  5 ++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 ++
 drivers/soc/mediatek/mt8186-mmsys.h     |  1 +
 drivers/soc/mediatek/mtk-mmsys.c        | 16 +++++++++++++
 include/linux/soc/mediatek/mtk-mmsys.h  |  2 ++
 6 files changed, 57 insertions(+)

-- 
2.18.0

