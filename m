Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9248C74F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbiALPhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:37:35 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:42906 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354643AbiALPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:37:20 -0500
X-UUID: a38c246a3e774bc7b3003fcd183cc0eb-20220112
X-UUID: a38c246a3e774bc7b3003fcd183cc0eb-20220112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1065663607; Wed, 12 Jan 2022 23:37:15 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 12 Jan 2022 23:37:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Jan
 2022 23:37:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 23:37:13 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <andrzej.hajda@intel.com>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v8, PATCH 0/3] force hsa hbp hfp packets multiple of lanenum to avoid screen shift
Date:   Wed, 12 Jan 2022 23:36:36 +0800
Message-ID: <20220112153639.12343-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v7:
 - Rebase to kernel 5.16
 - Add tags of reviewed-by and acked-by.
 - Add detailed commit message for flag "hs_packet_end_aligned" in DSI common driver.

Changes since v6:
 - Add "bool hs_packet_end_aligned" in "struct mipi_dsi_device" to control the dsi aligned.
 - Config the "hs_packet_end_aligned" in ANX7725 .attach().

Changes since v5:
 - Search the anx7625 compatible as flag to control dsi output aligned.

Changes since v4:
 - Move "dt-bindings: drm/bridge: anx7625: add force_dsi_end_without_null" before
   "drm/mediatek: force hsa hbp hfp packets multiple of lanenum to avoid".
 - Retitle "dt-bindings: drm/bridge: anx7625: add force_dsi_end_without_null".

Rex-BC Chen (3):
  drm/dsi: transfer DSI HS packets ending at the same time
  drm/mediatek: implement the DSI hs packets aligned
  drm/bridge: anx7625: config hs packets end aligned to avoid screen shift

 drivers/gpu/drm/bridge/analogix/anx7625.c |  1 +
 drivers/gpu/drm/mediatek/mtk_dsi.c        | 10 ++++++++++
 include/drm/drm_mipi_dsi.h                |  3 +++
 3 files changed, 14 insertions(+)

-- 
2.18.0

