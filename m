Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00C4CF236
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiCGGxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiCGGxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:53:38 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9651D1C92C;
        Sun,  6 Mar 2022 22:52:39 -0800 (PST)
X-UUID: fa47304c0d0240e886284b5964e4f489-20220307
X-UUID: fa47304c0d0240e886284b5964e4f489-20220307
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1256613541; Mon, 07 Mar 2022 14:52:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 14:52:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 14:52:33 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH V3 0/7] spi: mediatek: add single/quad mode support
Date:   Mon, 7 Mar 2022 14:52:23 +0800
Message-ID: <20220307065230.12655-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are based on spi for-next, and provide 7 patches
to support MT7986.

v3:
 1. add Rob Acked-by in "dt-bindings: spi: Add compatible for MT7986 with single mode";
 2. add a fix patch "spi: mediatek: support tick_delay without enhance_timing";
 3. fix Angelogioacchino comments;
 4. use mt7986 instead of ipm in dt-binding.

v2:
 1. rebase this series on spi for-next.
 2. fix Rob and Krzysztof comments in v1.

Leilk Liu (7):
  spi: mediatek: support tick_delay without enhance_timing
  dt-bindings: spi: Add compatible for MT7986 with single mode
  spi: mediatek: add MT7986 single mode design support
  dt-bindings: spi: Add compatible for MT7986 with quad mode
  spi: mediatek: add spi memory support for MT7986
  dt-bindings: spi: support spi-hclk
  spi: mediatek: support spi-hclk

 .../bindings/spi/mediatek,spi-mt65xx.yaml     |   6 +
 drivers/spi/spi-mt65xx.c                      | 512 ++++++++++++++++--
 2 files changed, 487 insertions(+), 31 deletions(-)

--
2.25.1


