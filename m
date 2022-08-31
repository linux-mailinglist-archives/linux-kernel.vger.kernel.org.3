Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D685A7DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiHaMtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiHaMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:49:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B59A0606;
        Wed, 31 Aug 2022 05:49:00 -0700 (PDT)
X-UUID: 8686b52b92c842e29da994014b9ee2ca-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WQK1AyNx0JLk94WzgAavNJ5OIP6EmsCAETgWNY7s0Ns=;
        b=JPaXXtY5MT4GUStUHVDL4pTzWuGA+yirB/+kCz+Tg+KpNMhVzSkYgvSJpwQ4rYTQnRSygdqX4JP2AGDi2Q9buR5p4eL8YLQUnPU4NupeMXgJkt7XPcQJARpcC1ZdY4EQQ7+MRz602/q6yvGt39LyHtURBGlGwznCyGOQ7dyEJNs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:7411a64f-eeb4-45a4-b94d-fbabbbb6c81a,OB:0,L
        OB:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:25
X-CID-META: VersionHash:84eae18,CLOUDID:28752856-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8686b52b92c842e29da994014b9ee2ca-20220831
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1847041876; Wed, 31 Aug 2022 20:48:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 20:48:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 31 Aug 2022 20:48:52 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of MediaTek frequency hopping
Date:   Wed, 31 Aug 2022 20:48:48 +0800
Message-ID: <20220831124850.7748-3-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220831124850.7748-1-johnson.wang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new binding documentation for MediaTek frequency hopping
and spread spectrum clocking control.

Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,fhctl.yaml | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
new file mode 100644
index 000000000000..c5d76410538b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek frequency hopping and spread spectrum clocking control
+
+maintainers:
+  - Edward-JW Yang <edward-jw.yang@mediatek.com>
+
+description: |
+  Frequency hopping control (FHCTL) is a piece of hardware that control
+  some PLLs to adopt "hopping" mechanism to adjust their frequency.
+  Spread spectrum clocking (SSC) is another function provided by this hardware.
+
+properties:
+  compatible:
+    const: mediatek,fhctl
+
+  reg:
+    maxItems: 1
+
+  mediatek,hopping-ssc-percents:
+    description: |
+      Determine the enablement of frequency hopping feature and the percentage
+      of spread spectrum clocking for PLLs.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: PLL id that is expected to enable frequency hopping.
+        - description: The percentage of spread spectrum clocking for one PLL.
+          minimum: 0
+          maximum: 8
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8186-clk.h>
+    fhctl: fhctl@1000ce00 {
+        compatible = "mediatek,fhctl";
+        reg = <0x1000c000 0xe00>;
+        mediatek,hopping-ssc-percents = <CLK_APMIXED_MSDCPLL 3>;
+    };
-- 
2.18.0

