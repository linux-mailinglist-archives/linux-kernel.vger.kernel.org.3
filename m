Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA784F60F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiDFOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiDFOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:07:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45C12F7E9B;
        Wed,  6 Apr 2022 02:47:02 -0700 (PDT)
X-UUID: 3f9df4538bfa4dcd9c209a067f064eb7-20220406
X-UUID: 3f9df4538bfa4dcd9c209a067f064eb7-20220406
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 102927999; Wed, 06 Apr 2022 17:46:57 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Apr 2022 17:46:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Apr
 2022 17:46:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 17:46:55 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <yongqiang.niu@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 3/3] dt-bindings: display: mediatek: Correct disp_aal binding for MT8192
Date:   Wed, 6 Apr 2022 17:46:54 +0800
Message-ID: <20220406094654.29722-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220406094654.29722-1-rex-bc.chen@mediatek.com>
References: <20220406094654.29722-1-rex-bc.chen@mediatek.com>
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

The driver data for MT8192 is the same with MT8183. Therefore, we
correct it.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,aal.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index f118075e4a89..407d7cbd6240 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -27,12 +27,12 @@ properties:
       - items:
           - enum:
               - mediatek,mt2712-disp-aal
-              - mediatek,mt8192-disp-aal
               - mediatek,mt8195-disp-aal
           - const: mediatek,mt8173-disp-aal
       - items:
           - enum:
               - mediatek,mt8186-disp-aal
+              - mediatek,mt8192-disp-aal
           - const: mediatek,mt8183-disp-aal
 
   reg:
-- 
2.18.0

