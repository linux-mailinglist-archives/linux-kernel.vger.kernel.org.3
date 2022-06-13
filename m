Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D7547DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiFMDXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiFMDWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:22:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734B812740;
        Sun, 12 Jun 2022 20:22:44 -0700 (PDT)
X-UUID: aa13092b62974c98a00350a76770ba81-20220613
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.5,REQID:367dbf97-d6f4-4f7e-ad7b-65467498ace0,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS6885A
        D,ACTION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.5,REQID:367dbf97-d6f4-4f7e-ad7b-65467498ace0,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:120
X-CID-META: VersionHash:2a19b09,CLOUDID:285f52c6-12ba-4305-bfdf-9aefbdc32516,C
        OID:5c7b1f35a894,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: aa13092b62974c98a00350a76770ba81-20220613
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1154491520; Mon, 13 Jun 2022 11:22:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 13 Jun 2022 11:22:38 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jun 2022 11:22:36 +0800
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
Subject: [V3,1/8] dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
Date:   Mon, 13 Jun 2022 11:22:25 +0800
Message-ID: <20220613032232.23187-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613032232.23187-1-irui.wang@mediatek.com>
References: <20220613032232.23187-1-irui.wang@mediatek.com>
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

Add mediatek,mt8195-jpgdec compatible to binding document.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
---
 .../media/mediatek,mt8195-jpegdec.yaml        | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
new file mode 100644
index 000000000000..c967d7eb6a00
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
@@ -0,0 +1,177 @@
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
+description: |-
+  MediaTek JPEG Decoder is the JPEG decode hardware present in MediaTek SoCs
+
+properties:
+  compatible:
+    items:
+      - const: mediatek,mt8195-jpgdec
+
+  mediatek,jpegdec-multi-core:
+    type: boolean
+    description: |
+      Indicates whether the jpeg encoder has multiple cores or not.
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 6
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
+  "^jpgdec@[0-9a-f]+$":
+    type: object
+    description: |
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
+      mediatek,hw-id:
+        minItems: 0
+        maxItems: 2
+        description: |
+          Current jpegdec hw id.
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
+          - const: jpgdec
+
+      power-domains:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - mediatek,hw-id
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
+                mediatek,jpegdec-multi-core;
+                power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
+                iommus = <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA0>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA0>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_WDMA1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
+                     <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+
+                jpgdec@1a040000 {
+                    compatible = "mediatek,mt8195-jpgdec-hw";
+                    reg = <0 0x1a040000 0 0x10000>;/* JPGDEC_C0 */
+                    mediatek,hw-id = <0>;
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
+                    mediatek,hw-id = <1>;
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
+                    mediatek,hw-id = <2>;
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

