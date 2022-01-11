Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FF048A7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348226AbiAKGjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:39:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57736 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348196AbiAKGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:39:17 -0500
X-UUID: 386eb9ecf7214617a1b39daafcb27da5-20220111
X-UUID: 386eb9ecf7214617a1b39daafcb27da5-20220111
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 113575811; Tue, 11 Jan 2022 14:39:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 11 Jan 2022 14:39:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 14:39:09 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <lc.kan@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/6] MT8186 SMI SUPPORT
Date:   Tue, 11 Jan 2022 14:38:58 +0800
Message-ID: <20220111063904.7583-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds mt8186 smi support, mainly adds a sleep control function.

Change note:
v2: a) Add two patches for the "make dtbs_check" warning.
    b) Seperate the "sleep control" into two functions.
       And add a "TODO" comment while sleep control fails.

v1: https://lore.kernel.org/linux-mediatek/20211203064027.14993-1-yong.wu@mediatek.com/
    Base on v5.16-rc1.

Yong Wu (6):
  dt-bindings: memory: mtk-smi: Fix larb-id dtbs_check warning
  dt-bindings: memory: mtk-smi: Fix the larb clock/clock-names dtbs
    warning
  dt-bindings: memory: mediatek: Add mt8186 support
  memory: mtk-smi: Fix the return value for clk_bulk_prepare_enable
  memory: mtk-smi: Add sleep ctrl function
  memory: mtk-smi: mt8186: Add smi support

 .../mediatek,smi-common.yaml                  |  4 +-
 .../memory-controllers/mediatek,smi-larb.yaml | 10 ++--
 drivers/memory/mtk-smi.c                      | 50 ++++++++++++++++++-
 3 files changed, 57 insertions(+), 7 deletions(-)

-- 
2.18.0


