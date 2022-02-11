Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07284B2008
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243030AbiBKIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:21:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348038AbiBKIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:21:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE26E67;
        Fri, 11 Feb 2022 00:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644567695; x=1676103695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vc01hpWMLj0MX7Suyo/gaNp3ZTgeddpPoZAPTjJV1OQ=;
  b=kIqT3gGAPfJFOAeO3gZHcha8PtevYZ7JYXcqP4B7bB7ucb+WQHFFljAH
   GYrlRVHVPrIgcNmrTOJREtkdQ+QQHkZauZJos17Kogz2r3cU+KwSD3w7F
   OqpuVi0pH0dBvbJBG2vpGZeyO2+NGrwJafn4Cm/4gcGZYlFTDzMzxSsAN
   +Z4ukNp+iP1Va6ALZfx7xUrxPMTk1y4WMEc88yiRr6VXDZW7nFaixFrEK
   M8f87rlWQ1mPmgYhfQ3GLY4aIlceWbnlBUxiIfQd77CrqpJc/MlasFCy8
   W5X91H6kh+amrO4grsYgv9DKrqBJQcIfSeE5BL76eiDaSsGlD7LuL8rNS
   A==;
IronPort-SDR: AoD7tbC++ffsEs145iwyzrlg7UQKfwt8ILlU73zaagyrnbfog0jfxkyJEVH04wszS5l60I6Z1V
 x+DfEzgN+JXC7Ioy/SfqYaLyVONM6YeiTP6EVcd7aPiR8Fv2rqV48y/w1g4s1YqCgPBRGe8Mv+
 oTPXZVKWQWwilnoGq9Zj2HpAmQkJrgCPDqxY3JvLVbmZf/qe8olJeKDsRgNIlNTKdHoqPEhqB3
 nU8khnli+k/JCD9TveS6AIjC+gqb5qPb56hxJlWUwKWmvREPizNKMr6ar2XMV4OXXlnWHFgEqo
 jL0cfjNkK5aBdzw3IZYC3VHz
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="153253186"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 01:21:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 01:21:30 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 01:21:26 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PACTH v3 3/3] dt-bindings: crypto: Convert Atmel SHA to yaml
Date:   Fri, 11 Feb 2022 10:21:14 +0200
Message-ID: <20220211082114.452911-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211082114.452911-1-tudor.ambarus@microchip.com>
References: <20220211082114.452911-1-tudor.ambarus@microchip.com>
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

