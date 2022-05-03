Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0227B5182C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiECLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiECLAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:00:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11174275F9;
        Tue,  3 May 2022 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651575391; x=1683111391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SRrXglg6r6VWu9S1ahzrarbkehQWcyMubV3bZWXG/sk=;
  b=n9x2ClDZ1kLDchFN9S+gak5/ooRIOhAV0No3vljj/Y0H4JqP3JXsvgrA
   F+HCVpEoNrnXMOyju5N7ugE7uxff6xsLWrApPXU8krft5roHo1JIW9rBo
   rxTm9SUmcOcOCTOlYCAzESNSiP5tyZGGyAu7ySkVl2y7uaePw0qD13/mE
   Yv+X425EceYxqcIgfL3DmarbiXlx+5yDwocAMn2GxKgl/HSJKbyS1dRnt
   bI3J1q/bPu5ypdxaE75bylMtiDZPV6lE54tVtTgeAOMMXI9GSFpy73mlZ
   kfrnDxmX3V9C7zPvoe4tfGG6X0Oy6JtwrvwdeJq8d/IAWF85shOyToSCK
   w==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="162127862"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 03:56:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 03:56:30 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 03:56:25 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH 3/4] dt-bindings: mux: Add lan966 flexcom mux controller
Date:   Tue, 3 May 2022 16:25:27 +0530
Message-ID: <20220503105528.12824-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
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
 .../mux/microchip,lan966-flx-mux.yaml         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml

diff --git a/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml b/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
new file mode 100644
index 000000000000..8b20f531781a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mux/microchip,lan966-flx-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: microchip Lan966 Flexcom multiplexer bindings
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
+properties:
+  compatible:
+    enum:
+      - microchip,lan966-flx-mux
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
+        mux-offset-pin =
+                <0x18 9>; /* 0: flx3 cs0 offset, pin-9 */
+    };
+
+    flx3 {
+        atmel,flexcom-mode = <2>;
+        mux-controls = <&mux 0>;
+        mux-control-names = "cs0";
+    };
+...
-- 
2.17.1

