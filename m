Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AC647077C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhLJRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:41:32 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55978 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241539AbhLJRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:41:29 -0500
X-UUID: 3bf8c5b7870c4b4685f65dcd4d5be4e9-20211211
X-UUID: 3bf8c5b7870c4b4685f65dcd4d5be4e9-20211211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1747369831; Sat, 11 Dec 2021 01:37:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Dec 2021 01:37:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:37:50 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Flora Fu" <flora.fu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH 1/6] dt-bindings: soc: mediatek: apu: Add MT8195 APU power domain
Date:   Sat, 11 Dec 2021 01:37:38 +0800
Message-ID: <20211210173743.30906-2-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210173743.30906-1-flora.fu@mediatek.com>
References: <20211210173743.30906-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the MT8195 APU power domain bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 .../devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
index e1b7d4030dc9..66547f899014 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
@@ -21,6 +21,7 @@ properties:
     items:
       - enum:
           - mediatek,mt8192-apu-pm
+          - mediatek,mt8195-apu-pm
       - const: syscon
 
   reg:
-- 
2.18.0

