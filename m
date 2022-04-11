Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053704FB178
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 03:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbiDKBnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 21:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiDKBnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 21:43:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DBEDF6F;
        Sun, 10 Apr 2022 18:41:33 -0700 (PDT)
X-UUID: 8d18cfee5cb641b087296e53aa965667-20220411
X-UUID: 8d18cfee5cb641b087296e53aa965667-20220411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 49525070; Mon, 11 Apr 2022 09:41:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Apr 2022 09:41:27 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 09:41:26 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <eddie.huang@mediatek.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hsin-hsiung.wang@mediatek.com>, <sean.wang@mediatek.com>,
        <macpaul.lin@mediatek.com>, <wen.su@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 1/1] dt-bindings: pwrap: mediatek: fix pwrap document for mt8195
Date:   Mon, 11 Apr 2022 09:41:21 +0800
Message-ID: <20220411014121.15015-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220411014121.15015-1-zhiyong.tao@mediatek.com>
References: <20220411014121.15015-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>

fix pwrap document description for mt8195

Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/pwrap.txt         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index d74a7a5ae9f2..601647717ceb 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -30,20 +30,20 @@ Required properties in pwrap device node.
 	"mediatek,mt8195-pwrap" for MT8195 SoCs
 	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
-- reg-names: Must include the following entries:
+- reg-names: Must include "pwrap", "pwrap-bridge" is optinal.
   "pwrap": Main registers base
   "pwrap-bridge": bridge base (IP Pairing)
 - reg: Must contain an entry for each entry in reg-names.
-- reset-names: Must include the following entries:
-  "pwrap"
-  "pwrap-bridge" (IP Pairing)
-- resets: Must contain an entry for each entry in reset-names.
 - clock-names: Must include the following entries:
   "spi": SPI bus clock
   "wrap": Main module clock
 - clocks: Must contain an entry for each entry in clock-names.
 
 Optional properities:
+- reset-names: Some SoCs include the following entries:
+  "pwrap"
+  "pwrap-bridge" (IP Pairing)
+- resets: Must contain an entry for each entry in reset-names.
 - pmic: Using either MediaTek PMIC MFD as the child device of pwrap
   See the following for child node definitions:
   Documentation/devicetree/bindings/mfd/mt6397.txt
-- 
2.18.0

