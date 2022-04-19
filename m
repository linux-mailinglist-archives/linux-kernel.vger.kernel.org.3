Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97C5062B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347151AbiDSDf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346806AbiDSDf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:35:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FED2B275;
        Mon, 18 Apr 2022 20:32:44 -0700 (PDT)
X-UUID: 36e1ede84adf4357a1101719831f52fa-20220419
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:62d7f7fb-dc53-4354-b49e-02909089ace3,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:4c6d51ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 36e1ede84adf4357a1101719831f52fa-20220419
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 950235646; Tue, 19 Apr 2022 11:32:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 19 Apr 2022 11:32:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Apr 2022 11:32:39 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>
CC:     <airlied@linux.ie>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 1/5] dt-bindings: arm: mediatek: mmsys: add power and gce properties
Date:   Tue, 19 Apr 2022 11:32:33 +0800
Message-ID: <20220419033237.23405-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
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

From: "jason-jh.lin" <jason-jh.lin@mediatek.com>

Power:
1. Add description for power-domains property.

GCE:
1. Add description for mboxes property.
2. Add description for mediatek,gce-client-reg property.

Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,mmsys.yaml | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index b31d90dc9eb4..6c2c3edcd443 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -41,6 +41,30 @@ properties:
   reg:
     maxItems: 1
 
+  power-domains:
+    description:
+      A phandle and PM domain specifier as defined by bindings
+      of the power controller specified by phandle. See
+      Documentation/devicetree/bindings/power/power-domain.yaml for details.
+
+  mboxes:
+    description:
+      Using mailbox to communicate with GCE, it should have this
+      property and list of phandle, mailbox specifiers. See
+      Documentation/devicetree/bindings/mailbox/mtk-gce.txt for details.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  mediatek,gce-client-reg:
+    description:
+      The register of client driver can be configured by gce with 4 arguments
+      defined in this property, such as phandle of gce, subsys id,
+      register offset and size.
+      Each subsys id is mapping to a base address of display function blocks
+      register which is defined in the gce header
+      include/dt-bindings/gce/<chip>-gce.h.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+
   "#clock-cells":
     const: 1
 
@@ -56,9 +80,16 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/power/mt8173-power.h>
+    #include <dt-bindings/gce/mt8173-gce.h>
+
     mmsys: syscon@14000000 {
         compatible = "mediatek,mt8173-mmsys", "syscon";
         reg = <0x14000000 0x1000>;
+        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+        mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
+                 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
+        mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
     };
-- 
2.18.0

