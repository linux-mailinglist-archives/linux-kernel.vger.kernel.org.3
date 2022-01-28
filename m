Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0049F8E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348296AbiA1MHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:07:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59814 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231315AbiA1MHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:07:24 -0500
X-UUID: 686009ec37ba427bb52f2eeb8bb912f7-20220128
X-UUID: 686009ec37ba427bb52f2eeb8bb912f7-20220128
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 39610135; Fri, 28 Jan 2022 20:07:21 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Jan 2022 20:07:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 Jan
 2022 20:07:20 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 20:07:19 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v1, 0/4] add display support for mediatek SOC MT8186
Date:   Fri, 28 Jan 2022 20:07:14 +0800
Message-ID: <20220128120718.30545-1-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yongqiang Niu (4):
  soc: mediatek: mmsys: Add mt8186 mmsys routing table
  soc: mediatek: add mtk mutex support for MT8186
  drm/mediatek: split postmask component
  drm/mediatek: add mt8186 display support

 drivers/gpu/drm/mediatek/Makefile            |   1 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h      |   8 +
 drivers/gpu/drm/mediatek/mtk_disp_postmask.c | 155 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c  |  30 +---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c       |  41 +++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h       |   1 +
 drivers/soc/mediatek/mt8186-mmsys.h          | 113 ++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c             |  11 ++
 drivers/soc/mediatek/mtk-mutex.c             |  45 ++++++
 9 files changed, 378 insertions(+), 27 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_postmask.c
 create mode 100644 drivers/soc/mediatek/mt8186-mmsys.h

-- 
2.25.1

