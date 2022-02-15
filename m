Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE44B64FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiBOICJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:02:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiBOICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:02:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211441EAE7;
        Tue, 15 Feb 2022 00:01:55 -0800 (PST)
X-UUID: 9c005cb2e7cd4c34aa6a604ffa74f49a-20220215
X-UUID: 9c005cb2e7cd4c34aa6a604ffa74f49a-20220215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1432319270; Tue, 15 Feb 2022 16:01:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 16:01:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 16:01:52 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>
CC:     <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jassisinghbrar@gmail.com>, <fparent@baylibre.com>,
        <yongqiang.niu@mediatek.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v2,2/6] dt-bindings: display: mediatek: update supported SoC
Date:   Tue, 15 Feb 2022 15:59:49 +0800
Message-ID: <20220215075953.3310-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220215075953.3310-1-rex-bc.chen@mediatek.com>
References: <20220215075953.3310-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add decriptions about supported SoC: MT8186.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,disp.txt      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 78044c340e20..f22b3d90d45a 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -44,7 +44,7 @@ Required properties (all function blocks):
 	"mediatek,<chip>-dpi"        		- DPI controller, see mediatek,dpi.txt
 	"mediatek,<chip>-disp-mutex" 		- display mutex
 	"mediatek,<chip>-disp-od"    		- overdrive
-  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173, mt8183 and mt8192.
+  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173, mt8183, mt8186 and mt8192.
 - reg: Physical base address and length of the function block register space
 - interrupts: The interrupt signal from the function block (required, except for
   merge and split function blocks).
-- 
2.18.0

