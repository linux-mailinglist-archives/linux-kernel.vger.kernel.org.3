Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929894C09D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiBWDC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbiBWDCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:02:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A84198A;
        Tue, 22 Feb 2022 19:02:27 -0800 (PST)
X-UUID: 1a2888e752254ea49520e8cd9de0fda5-20220223
X-UUID: 1a2888e752254ea49520e8cd9de0fda5-20220223
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 504627890; Wed, 23 Feb 2022 11:02:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Feb 2022 11:02:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Feb 2022 11:02:19 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <yongqiang.niu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: mailbox: add definition for mt8186
Date:   Wed, 23 Feb 2022 11:01:37 +0800
Message-ID: <20220223030138.13939-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220223030138.13939-1-rex-bc.chen@mediatek.com>
References: <20220223030138.13939-1-rex-bc.chen@mediatek.com>
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

Add definition of compatible and dt-binding header for mt8186.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index 98fe37e8b17b..c2aeba63bd47 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -10,7 +10,8 @@ mailbox.txt for generic information about mailbox device-tree bindings.
 
 Required properties:
 - compatible: can be "mediatek,mt8173-gce", "mediatek,mt8183-gce",
-  "mediatek,mt8192-gce", "mediatek,mt8195-gce" or "mediatek,mt6779-gce".
+  "mediatek,mt8186-gce", "mediatek,mt8192-gce", "mediatek,mt8195-gce" or
+  "mediatek,mt6779-gce".
 - reg: Address range of the GCE unit
 - interrupts: The interrupt signal from the GCE block
 - clock: Clocks according to the common clock binding
@@ -40,8 +41,9 @@ Optional properties for a client mutex node:
   defined in 'dt-bindings/gce/<chip>-gce.h'.
 
 Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h',
-'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8192-gce.h',
-'dt-bindings/gce/mt8195-gce.h' or 'dt-bindings/gce/mt6779-gce.h'.
+'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8186-gce.h'
+'dt-bindings/gce/mt8192-gce.h', 'dt-bindings/gce/mt8195-gce.h' or
+'dt-bindings/gce/mt6779-gce.h'.
 Such as sub-system ids, thread priority, event ids.
 
 Example:
-- 
2.18.0

