Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CF4562F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiGAJGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiGAJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:06:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9DFBC84;
        Fri,  1 Jul 2022 02:05:57 -0700 (PDT)
X-UUID: 7c594efba21a41439db7abf3a52454bd-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:bc41ca23-3ad4-4003-868d-9c3053912664,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:87442a2,CLOUDID:5ea82763-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 7c594efba21a41439db7abf3a52454bd-20220701
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 855301923; Fri, 01 Jul 2022 17:05:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 1 Jul 2022 17:05:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 17:05:47 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 0/6] Complete driver nodes for MT8192 SoC
Date:   Fri, 1 Jul 2022 17:05:41 +0800
Message-ID: <20220701090547.21429-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on matthias.bgg/linux.git, for-next

Also should reference below PATCH for dsi in chunkuang.hu/linux.git
dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml

changes since v1:
 - add Reviewed-by Tag
 - rename dsi-phy from dsi-dphy
 - add missing power-domains in disp mutex
 - Add remove mt8192 display rdma compatible PATCH in series
 - use "mediatek,mt8183-disp-rdma" as fallback
 - remove mediatek,larb from rdma node
 - remove syscon-dsi and add power-domains in dsi
 - add reset property in dsi and mt8192-resets.h
 - correct Typo: s/ndoe/node in commit message

Allen-KH Cheng (6):
  drm/mediatek: Remove mt8192 display rdma compatible
  arm64: dts: mt8192: Add pwm node
  arm64: dts: mt8192: Add mipi_tx node
  arm64: dts: mt8192: Add display nodes
  arm64: dts: mt8192: Add dsi node
  arm64: dts: mt8192: Add vcodec lat and core nodes

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 238 +++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c |   6 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   |   2 -
 3 files changed, 238 insertions(+), 8 deletions(-)

-- 
2.18.0

