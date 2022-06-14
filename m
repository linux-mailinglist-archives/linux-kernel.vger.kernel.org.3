Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54254B021
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiFNMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356576AbiFNMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:10:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33349C8E;
        Tue, 14 Jun 2022 05:10:36 -0700 (PDT)
X-UUID: a7d8bed1ce0a4dbca0c3d2aa678fb664-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:34b71ce3-6b37-41d2-957a-321600d99bac,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:20
X-CID-META: VersionHash:b14ad71,CLOUDID:34079207-b57a-4a25-a071-bc7b4972bc68,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: a7d8bed1ce0a4dbca0c3d2aa678fb664-20220614
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 217895939; Tue, 14 Jun 2022 20:10:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 20:10:28 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 14 Jun 2022 20:10:27 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, kyrie wu <kyrie.wu@mediatek.com>,
        <srv_heupstream@mediatek.com>
Subject: [RESEND V9,1/7] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
Date:   Tue, 14 Jun 2022 20:10:18 +0800
Message-ID: <20220614121024.31667-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614121024.31667-1-irui.wang@mediatek.com>
References: <20220614121024.31667-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

Add mediatek,mt8195-jpgenc compatible to binding document.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
---
 .../media/mediatek,mt8195-jpegenc.yaml        | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
new file mode 100644
index 000000000000..a7f9f723d5db
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegenc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek JPEG Encoder Device Tree Bindings
+
+maintainers:
+  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
+
+description: |-
+  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt8195-jpgenc
+
+  mediatek,jpegenc-multi-core:
+    type: boolean
+    description: |
+      Indicates whether the jpeg encoder has multiple cores or not.
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 4
+    description: |
+      Points to the respective IOMMU block with master port as argument, see
+      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+      Ports are according to the HW.
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+# Required child node:
+patternProperties:
+  "^jpgenc@[0-9a-f]+$":
+    type: object
+    description: |
+      The jpeg encoder hardware device node which should be added as subnodes to
+      the main jpeg node.
+
+    properties:
+      compatible:
+        const: mediatek,mt8195-jpgenc-hw
+
+      reg:
+        maxItems: 1
+
+      hw_id:
+        description: |
+          Current jpegenc hw id.
+
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description: |
+          List of the hardware port in respective IOMMU block for current Socs.
+          Refer to bindings/iommu/mediatek,iommu.yaml.
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: jpgenc
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - hw_id
+      - iommus
+      - interrupts
+      - clocks
+      - clock-names
+      - power-domains
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - power-domains
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt8195-memory-port.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        jpgenc_master {
+                compatible = "mediatek,mt8195-jpgenc";
+                mediatek,jpegenc-multi-core;
+                power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+                iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
+                <&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
+                <&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
+                <&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+
+                jpgenc@1a030000 {
+                        compatible = "mediatek,mt8195-jpgenc-hw";
+                        reg = <0 0x1a030000 0 0x10000>;
+                        hw_id = <0>;
+                        iommus = <&iommu_vdo M4U_PORT_L19_JPGENC_Y_RDMA>,
+                        <&iommu_vdo M4U_PORT_L19_JPGENC_C_RDMA>,
+                        <&iommu_vdo M4U_PORT_L19_JPGENC_Q_TABLE>,
+                        <&iommu_vdo M4U_PORT_L19_JPGENC_BSDMA>;
+                        interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH 0>;
+                        clocks = <&vencsys CLK_VENC_JPGENC>;
+                        clock-names = "jpgenc";
+                        power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
+                };
+
+                jpgenc@1b030000 {
+                        compatible = "mediatek,mt8195-jpgenc-hw";
+                        reg = <0 0x1b030000 0 0x10000>;
+                        hw_id = <1>;
+                        iommus = <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA>,
+                        <&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
+                        <&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
+                        <&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
+                        interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH 0>;
+                        clocks = <&vencsys_core1 CLK_VENC_CORE1_JPGENC>;
+                        clock-names = "jpgenc";
+                        power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
+                };
+        };
+    };
-- 
2.18.0

