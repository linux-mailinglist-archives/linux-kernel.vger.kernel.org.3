Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A64B8486
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiBPJdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:33:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiBPJdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:33:22 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F23EA374;
        Wed, 16 Feb 2022 01:33:08 -0800 (PST)
X-UUID: 5fd4be8d273d43679b2692eea5a580a8-20220216
X-UUID: 5fd4be8d273d43679b2692eea5a580a8-20220216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 712543306; Wed, 16 Feb 2022 17:33:05 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 17:33:04 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 17:33:03 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 16 Feb 2022 17:33:02 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <jitao.shi@mediatek.com>
CC:     <allen-kh.cheng@mediatek.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
Subject: [v2,2/4] dt-bindings: pwm: Add compatible for MediaTek MT8192
Date:   Wed, 16 Feb 2022 17:32:49 +0800
Message-ID: <1645003971-16908-3-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
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

From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>

Add dt-binding documentation of pwm for MediaTek MT8192 SoC.

Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index edf2a2e9ea72..825cad513309 100755
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -17,6 +17,7 @@ properties:
       - mediatek,mt6595-disp-pwm
       - mediatek,mt8173-disp-pwm
       - mediatek,mt8183-disp-pwm
+      - mediatek,mt8192-disp-pwm
 
   reg:
     maxItems: 1
-- 
2.18.0

