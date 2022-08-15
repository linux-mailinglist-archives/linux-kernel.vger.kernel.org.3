Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8201A592EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiHOMZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbiHOMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:25:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602B26AD8;
        Mon, 15 Aug 2022 05:25:13 -0700 (PDT)
X-UUID: 50c300657e1f4d69a339e5c30807e3dc-20220815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=s4Kcd+rkVLrqPY1boQicbU5RlczH2V6/bPYBfFWQSeE=;
        b=riBDeLO6akDi87eLDQLW+JtKQOQ4YOkDiNl79meC37C3ZZPl8ZmDXkMdEs78Es+jHHIem5o2OrnwSj90YGx4Z0banJ+GBdDEr7M+2LhPfSkbzxe1/v9zzsu2p8mezCgH0059xVLNAF1BBMsHmU9Ri7lFGqnKxAt93NUZTBs0Qgc=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:f8081439-3053-484c-b093-1881fb281e52,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.9,REQID:f8081439-3053-484c-b093-1881fb281e52,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:3d8acc9,CLOUDID:b8a85afd-9e71-4a0f-ba6b-417998daea35,C
        OID:a1104740697b,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 50c300657e1f4d69a339e5c30807e3dc-20220815
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1140131084; Mon, 15 Aug 2022 20:25:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 15 Aug 2022 20:25:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 15 Aug 2022 20:25:04 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH] dt-bindings: pinctrl: mt8186: Fix 'reg-names' for pinctrl nodes
Date:   Mon, 15 Aug 2022 20:25:03 +0800
Message-ID: <20220815122503.2768-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 8 GPIO physical address bases in mt8186, corresponding to the
items of 'reg-names' with the pinctrl driver. but the order of
'reg-names' is not correct. The mt8186 pinctrl driver would get the
wrong address, causing the system to restart when regulator initializes
. we fix 'reg-names' for pinctrl nodes and the pinctrl-mt8186 example
in bindings.

Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl file and binding document")
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
---
 .../bindings/pinctrl/pinctrl-mt8186.yaml         | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
index 1eeb885ce0c6..604445e390a7 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
@@ -41,12 +41,12 @@ properties:
       Gpio base register names.
     items:
       - const: iocfg0
-      - const: iocfg_bm
-      - const: iocfg_bl
-      - const: iocfg_br
+      - const: iocfg_lt
       - const: iocfg_lm
+      - const: iocfg_lb
+      - const: iocfg_bl
       - const: iocfg_rb
-      - const: iocfg_tl
+      - const: iocfg_rt
       - const: eint
 
   interrupt-controller: true
@@ -232,12 +232,12 @@ examples:
             <0x10002200 0x0200>,
             <0x10002400 0x0200>,
             <0x10002600 0x0200>,
-            <0x10002A00 0x0200>,
+            <0x10002a00 0x0200>,
             <0x10002c00 0x0200>,
             <0x1000b000 0x1000>;
-      reg-names = "iocfg0", "iocfg_bm", "iocfg_bl",
-                  "iocfg_br", "iocfg_lm", "iocfg_rb",
-                  "iocfg_tl", "eint";
+      reg-names = "iocfg0", "iocfg_lt", "iocfg_lm",
+                  "iocfg_lb", "iocfg_bl", "iocfg_rb",
+                  "iocfg_rt", "eint";
       gpio-controller;
       #gpio-cells = <2>;
       gpio-ranges = <&pio 0 0 185>;
-- 
2.18.0

