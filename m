Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A84AF100
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiBIMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiBIMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:34 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BEEC0045CB;
        Wed,  9 Feb 2022 03:19:46 -0800 (PST)
X-UUID: 08df87108ecb4667b6b5924c7089f56c-20220209
X-UUID: 08df87108ecb4667b6b5924c7089f56c-20220209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2120577437; Wed, 09 Feb 2022 19:19:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Feb 2022 19:19:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 19:19:40 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 1/6] dt-bindings: spi: Add compatible for Mediatek IPM IP with single mode
Date:   Wed, 9 Feb 2022 19:19:33 +0800
Message-ID: <20220209111938.16137-2-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209111938.16137-1-leilk.liu@mediatek.com>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
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

This commit adds dt-binding documentation for
Mediatek SPI IPM IP with single mode.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index bfa44acb1bdd..0a2fc0404cb3 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -41,6 +41,7 @@ properties:
               - mediatek,mt8135-spi
               - mediatek,mt8173-spi
               - mediatek,mt8183-spi
+              - mediatek,ipm-spi-single
 
   reg:
     maxItems: 1
-- 
2.25.1

