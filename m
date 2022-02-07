Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB99D4ABD6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388435AbiBGLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385755AbiBGLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:32:28 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 03:32:22 PST
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8717CC0401C1;
        Mon,  7 Feb 2022 03:32:22 -0800 (PST)
X-UUID: 7db079af9470467e90622a5f580fced8-20220207
X-UUID: 7db079af9470467e90622a5f580fced8-20220207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1657494342; Mon, 07 Feb 2022 19:27:01 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Feb 2022 19:26:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Feb
 2022 19:26:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 19:26:59 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Subject: [PATCH] dt-bindings: pwm: mtk-disp: add compatible string for MT8183 SoC
Date:   Mon, 7 Feb 2022 19:26:57 +0800
Message-ID: <20220207112657.18246-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Add compatible string for MT8183 SoC in device tree binding.

Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
index 902b271891ae..691e58b6c223 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
@@ -6,6 +6,7 @@ Required properties:
    - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
    - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt8167 SoC.
    - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
+   - "mediatek,mt8183-disp-pwm": found on mt8183 SoC.$
  - reg: physical base address and length of the controller's registers.
  - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
    the cell format.
-- 
2.18.0

