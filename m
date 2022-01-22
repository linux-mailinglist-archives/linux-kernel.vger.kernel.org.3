Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36F9496AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiAVH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:56:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41072 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233629AbiAVH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:56:15 -0500
X-UUID: ea73b5345319419fa94d0185be6b4199-20220122
X-UUID: ea73b5345319419fa94d0185be6b4199-20220122
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1991601799; Sat, 22 Jan 2022 15:56:11 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 22 Jan 2022 15:56:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 22 Jan
 2022 15:56:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Jan 2022 15:56:08 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1, 0/3] support mt8186 decoder
Date:   Sat, 22 Jan 2022 15:56:03 +0800
Message-ID: <20220122075606.19373-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, add mt8186 compatible and private data, then add document for
compatible "mediatek,mt8186-vcodec-dec". For mt8186 is single core
architecture, need to add new interface for h264 hardware decoder.

Patche 1 add mt8186 compatible and private data.
Patche 2 add mt8186 compatible document.
Patche 3 add h264 single core driver.
---
This patch depends on "support for MT8192 decoder"[1]

[1]  https://patchwork.kernel.org/project/linux-mediatek/patch/20220122035316.18179-1-yunfei.dong@mediatek.com/
---
Yunfei Dong (3):
  mtk-vcodec: Support MT8186
  dt-bindings: media: mtk-vcodec: Adds decoder dt-bindings for mt8186
  mtk-vcodec: add h264 decoder driver for mt8186

 .../media/mediatek,vcodec-subdev-decoder.yaml |   4 +-
 .../platform/mtk-vcodec/mtk_vcodec_dec.h      |   1 +
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |   4 +
 .../mtk-vcodec/mtk_vcodec_dec_stateless.c     |  19 ++
 .../mtk-vcodec/vdec/vdec_h264_req_multi_if.c  | 164 ++++++++++++++++++
 .../media/platform/mtk-vcodec/vdec_drv_if.c   |   5 +-
 .../media/platform/mtk-vcodec/vdec_drv_if.h   |   1 +
 7 files changed, 196 insertions(+), 2 deletions(-)

-- 
2.25.1

