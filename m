Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9814E1ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbiCUBlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbiCUBk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:40:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE833FBF0;
        Sun, 20 Mar 2022 18:39:32 -0700 (PDT)
X-UUID: 1bcb10ea6b434914b2d5dda597ab69d2-20220321
X-UUID: 1bcb10ea6b434914b2d5dda597ab69d2-20220321
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 383655719; Mon, 21 Mar 2022 09:39:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 21 Mar 2022 09:39:24 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 09:39:24 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH V6 0/3] spi: mediatek: add single/quad mode support
Date:   Mon, 21 Mar 2022 09:39:19 +0800
Message-ID: <20220321013922.24067-1-leilk.liu@mediatek.com>
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

This series of patches are based on spi for-next, and provide 3 patches to support MT7986.

V6:
 1. remove SPI_CFG3_IPM_PIN_MODE_OFFSET.
 2. add Reviewed-by: AngeloGioacchino Del Regno

V5:
 1. remove 3 patches that already applied.
 2. use devm_clk_get_optional.
 3. remove of_mtk_spi_parse_dt()

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

Leilk Liu (3):
  spi: mediatek: add spi memory support for ipm design
  dt-bindings: spi: support hclk
  spi: mediatek: support hclk

 .../bindings/spi/mediatek,spi-mt65xx.yaml     |   4 +
 drivers/spi/spi-mt65xx.c                      | 386 +++++++++++++++++-
 2 files changed, 373 insertions(+), 17 deletions(-)

--
2.25.1



