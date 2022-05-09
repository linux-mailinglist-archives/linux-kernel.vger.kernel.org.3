Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35A51F78F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiEII7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiEIIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:53:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48E1F639C;
        Mon,  9 May 2022 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652086200; x=1683622200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=P1qgV17lnh2akycIs/7RD3U7hySjZfZcLWGAANbzE+U=;
  b=AafctKHDrq8rWkdEnNDJnybSUa6WZFHoFUiefQ6O/oS06AHMbmNl1PXc
   SLGLbpxdkwJQorwXAKSWZyax+kG/Ez8JdUDlSPRekVgkApyJQMejXCUhi
   YsvFDjXXE31VNcO4j1dijIjQ3xdEyRkv8Mbw2e09eT1K3TIPpC34Wk4ps
   F5vk331qB93/ePDyIx89XsHt0Q4kSywTFQ1IVojw/8Xi7KMYgZLHDU/AZ
   PeCv46IcNRN9ao05fLLVTU+A5T1bTvYCKqPBXFYyBeZKKVtiavuMFGUD9
   3oAg1+KG/aBHw69XShTwFN3aKVzaueyDbpc/6SkBFWQC0KPcDP/CU+ysT
   w==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="172473008"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 01:49:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 01:49:48 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 9 May 2022 01:49:43 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 3/4] dt-bindings: mux: Add lan966 flexcom mux controller
Date:   Mon, 9 May 2022 14:19:19 +0530
Message-ID: <20220509084920.14529-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
References: <20220509084920.14529-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds DT bindings documentation for lan966 flexcom
mux controller.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../mux/microchip,lan966-flx-mux.yaml         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml

diff --git a/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml b/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
new file mode 100644
index 000000000000..63147a2e8f3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mux/microchip,lan966-flx-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Lan966 Flexcom multiplexer bindings
+
+maintainers:
+  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
+
+description: |+
+  The Microchip Lan966 have 5 Flexcoms. Each flexcom has 2 chip-selects
+  when operating in USART and SPI modes.
+  Each chip select of each flexcom can be mapped to 21 flexcom shared pins.
+  Define register offset and pin number to map a flexcom chip-select
+  to flexcom shared pin.
+
+allOf:
+  - $ref: /schemas/mux/mux-controller.yaml#
+
+properties:
+  compatible:
+    const: microchip,lan966-flx-mux
+
+  reg:
+    maxItems: 1
+
+  '#mux-control-cells':
+    const: 1
+
+  mux-offset-pin:
+    description: an array of register offset and flexcom shared pin(0-20).
+
+required:
+  - compatible
+  - reg
+  - '#mux-control-cells'
+  - mux-offset-pin
+
+additionalProperties: false
+
+examples:
+  - |
+    mux: mux-controller@e2004168 {
+        compatible = "microchip,lan966-flx-mux";
+        reg = <0xe2004168 0x8>;
+        #mux-control-cells = <1>;
+        mux-offset-pin = <0x18 9>; /* 0: flx3 cs0 offset, pin-9 */
+    };
+...
-- 
2.17.1

