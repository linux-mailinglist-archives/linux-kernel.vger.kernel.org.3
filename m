Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E24AD6FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353927AbiBHLa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356475AbiBHKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:49:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6693EC03FEC0;
        Tue,  8 Feb 2022 02:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644317374; x=1675853374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bVyjlOCtJLgcl05G5AMbfZqCl2pQSsFOps6GXgAhLc=;
  b=WhoX+SR9E+jNjvmGn39SRQI8K76Qr0hRuEvrGWq1UGHQvmSAaBBG8hB9
   VKKzUvulY2EbAbzSN3YdoVLA3j4Q70BNv7zdy712MmENXTUmfDlQAxM+R
   t3/emUUjl19uWeHSB3qJrWwlmg7znx+VIrK6FN6QPJX+1yEI/kSd5NvIQ
   SWTMFSn3VZVgMXKQ1jBXtlljD6IX4pkYwJltRL8Pnt6MaK8cbCAKjCNi2
   ylRp8coQ1SYHflMFdD/VhL2xrx98WdA99p1E1JOrxFbLblw4rnZOmQ6IK
   ZQTmPNzADZhCHXFyQER6OOLd5KbI8Bu5OzxbHgL2+jAhlogs6ChFB6/n+
   w==;
IronPort-SDR: paXrHcMzXITY/LEfDy4ZULOXn79Aik7ZevZXoqizNpmg3tQ53phwZt/2VbR8iy70Vv8dFse3il
 hrOqtig2JihYu0NLVdtdTk5+zDmOh9XKlV7WVRayqHsPVvNQmO7Q8o4gPIN7PV+c1Z7TcwExrU
 nomC21ceRNA+zx92WakxziCSb3VNR72utsgy1K8kD8On7ame2/UMxBFrAmyoGFAzvPhAs/5mci
 1gtQXfhJIO+EcoKyxn/csKGhv+0msT5daeDwV5muh0oZxVpDWy9myUVUI0zDa/rh+vnq3VThQn
 p7++QDtvQu46Fk15XuJmpqi2
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="85018008"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 03:49:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 03:49:33 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 03:49:30 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 3/3] dt-bindings: crypto: Convert Atmel SHA to yaml
Date:   Tue, 8 Feb 2022 12:49:18 +0200
Message-ID: <20220208104918.226156-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208104918.226156-1-tudor.ambarus@microchip.com>
References: <20220208104918.226156-1-tudor.ambarus@microchip.com>
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
---
 .../crypto/atmel,at91sam9g46-sha.yaml         | 59 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 25 --------
 2 files changed, 59 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
new file mode 100644
index 000000000000..e454f4468dc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only
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

