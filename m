Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDE471634
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhLKUk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 15:40:26 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:34768 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231246AbhLKUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 15:40:24 -0500
X-UUID: 8a8a74b4952e42f5928cec97a190f37c-20211212
X-UUID: 8a8a74b4952e42f5928cec97a190f37c-20211212
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1347071150; Sun, 12 Dec 2021 04:40:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 12 Dec 2021 04:40:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 12 Dec 2021 04:40:17 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <broonie@kernel.org>
CC:     <bgolaszewski@baylibre.com>, <sean.wang@mediatek.com>,
        <bayi.cheng@mediatek.com>, <gch981213@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v6 2/4] dt-bindings: spi: add new clock name 'axi' for spi nor
Date:   Sun, 12 Dec 2021 04:40:12 +0800
Message-ID: <20211211204014.8014-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20211211204014.8014-1-tinghan.shen@mediatek.com>
References: <20211211204014.8014-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mtk spi nor has dedicated dma(s) inside. Add a new clock name, axi,
for spi nor dma bus clock.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml       | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 7393f30535df..478afebfec9c 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -43,14 +43,19 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: clock used for spi bus
       - description: clock used for controller
+      - description: clock used for nor dma bus. this depends on hardware 
+                     design.
 
   clock-names:
+    minItems: 2
     items:
       - const: spi
       - const: sf
+      - const: axi
 
 required:
   - compatible
@@ -84,4 +89,3 @@ examples:
         };
       };
     };
-
-- 
2.18.0

