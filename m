Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A14B2236
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbiBKJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:39:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbiBKJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:39:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E556E4D;
        Fri, 11 Feb 2022 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644572379; x=1676108379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vc01hpWMLj0MX7Suyo/gaNp3ZTgeddpPoZAPTjJV1OQ=;
  b=TvvUMZMavMXqX4ulR6kCZnKwDztadg5kxl/Gt8HTXOAiKxa5fZakU8b/
   hdNeW0GBcMfgIL4EzOvNSBepOC++ccO2Ym839h5ZuqKAB7zJu/Xx8HwCN
   YKTGJYYfsaYOb32QoM9Y5WydWdRbSl+kDQh+CuuMQ4IDn3uhLXOVjhvud
   KyexFDedBgN+6ocM5wy0IL6+LIQyu5t8cvANPyG1JbTAfOhKc1w807m57
   OzGLU7+dQ+fVI6lqtgDhGJDDoGjLEFqycaGrQhx3e/F+bTrtvDmMPdKSX
   5yNixBTtJi+CUJ04BMMBQ9r/GLjMxWMCIAj96m1jlyb3KvarBg7Js4Fgp
   A==;
IronPort-SDR: xfAmm2XmiOHNPcq++MvYfecbNJBno7ge3ynBF+N+c+hXUHUk3gI8c/gv8MHhSdDjsBHN0TOs2/
 L2ARxgIK9arZe03vQvraNKAqsftWFc0B4+nUarRP1wLXf/LPUwcVYZcrOdFoFrzr0jVhyM+mJN
 5JciyBEa4xkGcv/cAfcg6gg40ezi54RnDvNdDGPhjkcpDsHuzs5CxVWa+ZLO1HEIChbjBNBf3J
 eQOYtAn53RfQcvMO16P/XMCla33ag57eT1q0UVXVU75JUintNB+vOdppG+LNeK9oYVAJc+iPYr
 B/JHLnts3AHU0nog1D3IuQDV
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="161908023"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 02:39:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 02:39:38 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 02:39:35 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PACTH v4 3/3] dt-bindings: crypto: Convert Atmel SHA to yaml
Date:   Fri, 11 Feb 2022 11:39:22 +0200
Message-ID: <20220211093922.456634-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211093922.456634-1-tudor.ambarus@microchip.com>
References: <20220211093922.456634-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel SHA documentation to yaml format. With the conversion the
clock and clock-names properties are made mandatory. The driver returns
-EINVAL if "sha_clk" is not found, reflect that in the bindings and make
the clock and clock-names properties mandatory. Update the example to
better describe how one should define the dt node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../crypto/atmel,at91sam9g46-sha.yaml         | 60 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 25 --------
 2 files changed, 60 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
new file mode 100644
index 000000000000..5163c51b4547
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/atmel,at91sam9g46-sha.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Secure Hash Algorithm (SHA) HW cryptographic accelerator
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+properties:
+  compatible:
+    const: atmel,at91sam9g46-sha
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sha_clk
+
+  dmas:
+    maxItems: 1
+    description: TX DMA Channel
+
+  dma-names:
+    const: tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+
+    sha: crypto@e1814000 {
+      compatible = "atmel,at91sam9g46-sha";
+      reg = <0xe1814000 0x100>;
+      interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 83>;
+      clock-names = "sha_clk";
+      dmas = <&dma0 AT91_XDMAC_DT_PERID(48)>;
+      dma-names = "tx";
+    };
diff --git a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
deleted file mode 100644
index 5c6541cfcc4a..000000000000
--- a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Atmel HW cryptographic accelerators
-
-These are the HW cryptographic accelerators found on some Atmel products.
-
-* Secure Hash Algorithm (SHA)
-
-Required properties:
-- compatible : Should be "atmel,at91sam9g46-sha".
-- reg: Should contain SHA registers location and length.
-- interrupts: Should contain the IRQ line for the SHA.
-
-Optional properties:
-- dmas: One DMA specifiers as described in
-        atmel-dma.txt and dma.txt files.
-- dma-names: Contains one identifier string for each DMA specifier
-             in the dmas property. Only one "tx" string needed.
-
-Example:
-sha@f8034000 {
-	compatible = "atmel,at91sam9g46-sha";
-	reg = <0xf8034000 0x100>;
-	interrupts = <42 4 0>;
-	dmas = <&dma1 2 17>;
-	dma-names = "tx";
-};
-- 
2.25.1

