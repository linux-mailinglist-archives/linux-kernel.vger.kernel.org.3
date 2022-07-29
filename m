Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF91F584BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiG2G01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiG2G0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:26:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CE625586;
        Thu, 28 Jul 2022 23:26:15 -0700 (PDT)
X-UUID: 127e7981e3e34f0a8a145970016e085f-20220729
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.8,REQID:b42189f1-9221-4d07-b96c-0939b8f3e292,OB:10,L
        OB:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885A
        D,ACTION:quarantine,TS:115
X-CID-INFO: VERSION:1.1.8,REQID:b42189f1-9221-4d07-b96c-0939b8f3e292,OB:10,LOB
        :0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:115
X-CID-META: VersionHash:0f94e32,CLOUDID:b0a6a9d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:60f806bf2fa7,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 127e7981e3e34f0a8a145970016e085f-20220729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 74606175; Fri, 29 Jul 2022 14:26:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 14:26:07 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 29 Jul 2022 14:26:06 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>
Subject: [V6,1/8] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
Date:   Fri, 29 Jul 2022 14:25:56 +0800
Message-ID: <20220729062603.5533-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729062603.5533-1-irui.wang@mediatek.com>
References: <20220729062603.5533-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

Add mediatek,mt8195-jpgdec compatible to binding document.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../media/mediatek,mt8195-jpegdec.yaml        | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
new file mode 100644
index 000000000000..ebda0ade8153
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8195-jpegdec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek JPEG Encoder Device Tree Bindings
+
+maintainers:
+  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
+
+description:
+  MediaTek JPEG Decoder is the JPEG decode hardware present in MediaTek SoCs
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt8195-jpgdec
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 6
+    description:
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
+  "^jpgdec@[0-9a-f]+$":
+    type: object
+    description:
+      The jpeg decoder hardware device node which should be added as subnodes to
+      the main jpeg node.
+
+    properties:
+      compatible:
+        const: mediatek,mt8195-jpgdec-hw
+
+      reg:
+        maxItems: 1
+
+      iommus:
+        minItems: 1
+        maxItems: 32
+        description:
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
+          - const: jpgdec
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
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
+        jpgdec_master {
+                compatible = "mediatek,mt8195-jpgdec";
+                power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+                iommus = <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA0>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA0>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+
+                jpgdec@1a040000 {
+                    compatible = "mediatek,mt8195-jpgdec-hw";
+                    reg = <0 0x1a040000 0 0x10000>;/* JPGDEC_C0 */
+                    iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+                    interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH 0>;
+                    clocks = <&vencsys CLK_VENC_JPGDEC>;
+                    clock-names = "jpgdec";
+                    power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
+                };
+
+                jpgdec@1a050000 {
+                    compatible = "mediatek,mt8195-jpgdec-hw";
+                    reg = <0 0x1a050000 0 0x10000>;/* JPGDEC_C1 */
+                    iommus = <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA0>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA1>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BSDMA1>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+                        <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+                    interrupts = <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH 0>;
+                    clocks = <&vencsys CLK_VENC_JPGDEC_C1>;
+                    clock-names = "jpgdec";
+                    power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+                };
+
+                jpgdec@1b040000 {
+                    compatible = "mediatek,mt8195-jpgdec-hw";
+                    reg = <0 0x1b040000 0 0x10000>;/* JPGDEC_C2 */
+                    iommus = <&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA0>,
+                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA0>,
+                        <&iommu_vpp M4U_PORT_L20_JPGDEC_WDMA1>,
+                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BSDMA1>,
+                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET1>,
+                        <&iommu_vpp M4U_PORT_L20_JPGDEC_BUFF_OFFSET0>;
+                    interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH 0>;
+                    clocks = <&vencsys_core1 CLK_VENC_CORE1_JPGDEC>;
+                    clock-names = "jpgdec";
+                    power-domains = <&spm MT8195_POWER_DOMAIN_VDEC2>;
+                };
+        };
+    };
-- 
2.18.0

