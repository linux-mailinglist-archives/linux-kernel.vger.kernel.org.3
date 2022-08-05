Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E2A58A921
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiHEJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbiHEJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:57:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B477554
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:57:50 -0700 (PDT)
X-UUID: 19838886df76415796175e4224b4e904-20220805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GiKNv3RkbiGZ1UB2X/sb6BVxk6kdCrhz6SvNVbHZsl4=;
        b=Q/naowfOl5veuLDy+CvE6m3oP/teHFpjpBVTruJbaSU30DnBU09jfB6XS8ZmyNoLxsxuSoSogV1HfYYhq10UNdhrYx/Xj9/wqmFoFiNiaHNv2Dy6Q0YOOgcTmsY09BafseFZzn59HxgWcruvFTvQ7F/tWI2uHgSzvdlhdydzMcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:3d2a9201-c823-497e-b6e8-83845b445d2c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:1892e09b-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 19838886df76415796175e4224b4e904-20220805
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 289894038; Fri, 05 Aug 2022 17:57:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 5 Aug 2022 17:57:43 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 5 Aug 2022 17:57:43 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v2,0/2] Add dpi output format control for MT8186
Date:   Fri, 5 Aug 2022 17:57:39 +0800
Message-ID: <1659693461-27057-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Base on the branch of Linux-next/master.
This series are based on the following patch:
[1] Add MediaTek SoC(vdosys1) support for mt8195
https://patchwork.kernel.org/project/linux-mediatek/cover/20220711075245.10492-1-nancy.lin@mediatek.com/
[2] Add MediaTek SoC DRM (vdosys1) support for mt8195
https://patchwork.kernel.org/project/linux-mediatek/cover/20220804072827.22383-1-nancy.lin@mediatek.com/

Change since v1:
1. Modify mt8186 compatiable location.
2. Modify MT8186_DPI_OUTPUT_FORMAT name.

When MT8186 outputs dpi signal, it is necessary to add dual edge output
format control in mmsys.

Xinlei Lee (2):
  FROMLIST: soc: mediatek: Add mmsys func to adapt to dpi output for
    MT8186
  FROMLIST: drm: mediatek: Adjust the dpi output format to MT8186

 drivers/gpu/drm/mediatek/mtk_dpi.c      | 30 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  4 ++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 ++
 drivers/soc/mediatek/mt8186-mmsys.h     |  1 +
 drivers/soc/mediatek/mtk-mmsys.c        |  8 +++++++
 include/linux/soc/mediatek/mtk-mmsys.h  |  3 +++
 6 files changed, 48 insertions(+)

-- 
2.18.0

