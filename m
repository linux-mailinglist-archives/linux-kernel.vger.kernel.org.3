Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F084D92F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbiCODZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244124AbiCODZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:25:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A56035DC7;
        Mon, 14 Mar 2022 20:24:20 -0700 (PDT)
X-UUID: 4d5db35298df4f6387ccafd9c5da623e-20220315
X-UUID: 4d5db35298df4f6387ccafd9c5da623e-20220315
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 903344527; Tue, 15 Mar 2022 11:24:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Mar 2022 11:24:13 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 11:24:13 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH V4 0/6] spi: mediatek: add single/quad mode support
Date:   Tue, 15 Mar 2022 11:24:05 +0800
Message-ID: <20220315032411.2826-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are based on spi for-next, and provide 6 patches to support MT7986.

v4:
 1. fix Rob comment in v3;
 2. use "mediatek,mt7986-spi-ipm","mediatek,spi-ipm"

v3:
 1. add Rob Acked-by in "dt-bindings: spi: Add compatible for MT7986 with single mode";
 2. add a fix patch "spi: mediatek: support tick_delay without enhance_timing";
 3. fix Angelogioacchino comments;
 4. use mt7986 instead of ipm in dt-binding.

v2:
 1. rebase this series on spi for-next.
 2. fix Rob and Krzysztof comments in v1.

Leilk Liu (6):
  spi: mediatek: support tick_delay without enhance_timing
  dt-bindings: spi: Add compatible for MT7986
  spi: mediatek: add ipm design support for MT7986
  spi: mediatek: add spi memory support for ipm design
  dt-bindings: spi: support hclk
  spi: mediatek: support hclk

 .../bindings/spi/mediatek,spi-mt65xx.yaml     |   8 +
 drivers/spi/spi-mt65xx.c                      | 543 +++++++++++++++++-
 2 files changed, 520 insertions(+), 31 deletions(-)

--
2.25.1


