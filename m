Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3176A4CFBEA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiCGKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbiCGKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:47:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C9125DB;
        Mon,  7 Mar 2022 02:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646647655; x=1678183655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9sVz8A6/3pKzsSyKWMfc35MVS+ww7R2A8G94llrGlNU=;
  b=nbeELro5Oddf2n7a/b+GXTDV5/ZDmH02D3X+DFYyiwI4g/BjJL7DJ/7b
   Ov4yJTtyRg3T26SE6btne9FO4sIjx3uo73jwjQlIYxq0wTbpOCt1OZcil
   RxPYan2TygvVvDCr8k4F9LnJVKB9PAWQGkbJqDP+i+GDRYDm0d5DFl1nj
   fcD3pDSrlAJaXL8f4jEfHY9RaX5Sts70EV0Tyt5RuvR+k3IfY0Y+yZLhw
   wULo8Z733UQLIxZjxxu7DmJrgk8U9rCb93S6EyyNmAIcY01p2zvXWWuZY
   Yz8vIfW8AXwK3n6oA2t8D+Icbnmoxj6omDNHLNQtVxFw6fPcu8+FwXe+O
   w==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643698800"; 
   d="scan'208";a="88045533"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 03:06:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 03:06:02 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 03:05:59 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 2/6] ASoC: dt-bindings: Document Microchip's PDMC
Date:   Mon, 7 Mar 2022 12:04:24 +0200
Message-ID: <20220307100428.2227511-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307100428.2227511-1-codrin.ciubotariu@microchip.com>
References: <20220307100428.2227511-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the new Microchip PDMC embedded in sama7g5 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - renamed patch from 'ASoC: add DT bindings for Microchip PDMC' to
   'ASoC: dt-bindings: Document Microchip's PDMC';
 - renamed yaml file from 'mchp,pdmc.yaml' to 'microchip,pdmc.yaml';
 - used imperative mode in commit description;
 - renamed mchp,pdmc.h to microchip,pdmc.h;
 - fixed 'title' to represent HW;
 - made 'compatible' first property;
 - s/microhpone/microphone;
 - none name in example set to 'sound';

 .../bindings/sound/microchip,pdmc.yaml        | 99 +++++++++++++++++++
 include/dt-bindings/sound/microchip,pdmc.h    | 13 +++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
 create mode 100644 include/dt-bindings/sound/microchip,pdmc.h

diff --git a/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
new file mode 100644
index 000000000000..edfa3cbd318e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/microchip,pdmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Pulse Density Microphone Controller
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+  The Microchip Pulse Density Microphone Controller (PDMC) interfaces up to 4 digital microphones
+  having Pulse Density Modulated (PDM) outputs.
+
+properties:
+  compatible:
+    const: microchip,sama7g5-pdmc
+
+  "#sound-dai-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+      - description: Generic Clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  dmas:
+    description: RX DMA Channel
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+  microchip,mic-pos:
+    description: |
+      Position of PDM microphones on the DS line and the sampling edge (rising or falling) of the
+      CLK line. A microphone is represented as a pair of DS line and the sampling edge. The first
+      microphone is mapped to channel 0, the second to channel 1, etc.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: value for DS line
+        - description: value for sampling edge
+      anyOf:
+        - enum:
+            - [0, 0]
+            - [0, 1]
+            - [1, 0]
+            - [1, 1]
+    minItems: 1
+    maxItems: 4
+    uniqueItems: true
+
+required:
+  - compatible
+  - "#sound-dai-cells"
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - microchip,mic-pos
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/sound/microchip,pdmc.h>
+
+    pdmc: sound@e1608000 {
+        compatible = "microchip,sama7g5-pdmc";
+        #sound-dai-cells = <0>;
+        reg = <0xe1608000 0x4000>;
+        interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(37)>;
+        dma-names = "rx";
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 68>, <&pmc PMC_TYPE_GCK 68>;
+        clock-names = "pclk", "gclk";
+        microchip,mic-pos = <MCHP_PDMC_DS0 MCHP_PDMC_CLK_POSITIVE>,
+                            <MCHP_PDMC_DS0 MCHP_PDMC_CLK_NEGATIVE>,
+                            <MCHP_PDMC_DS1 MCHP_PDMC_CLK_POSITIVE>,
+                            <MCHP_PDMC_DS1 MCHP_PDMC_CLK_NEGATIVE>;
+    };
diff --git a/include/dt-bindings/sound/microchip,pdmc.h b/include/dt-bindings/sound/microchip,pdmc.h
new file mode 100644
index 000000000000..96cde94ce74f
--- /dev/null
+++ b/include/dt-bindings/sound/microchip,pdmc.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_MICROCHIP_PDMC_H__
+#define __DT_BINDINGS_MICROCHIP_PDMC_H__
+
+/* PDM microphone's pin placement */
+#define MCHP_PDMC_DS0 0
+#define MCHP_PDMC_DS1 1
+
+/* PDM microphone clock edge sampling */
+#define MCHP_PDMC_CLK_POSITIVE 0
+#define MCHP_PDMC_CLK_NEGATIVE 1
+
+#endif /* __DT_BINDINGS_MICROCHIP_PDMC_H__ */
-- 
2.32.0

