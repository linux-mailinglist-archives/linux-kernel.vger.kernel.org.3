Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFADF4E4C56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbiCWFhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiCWFhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:37:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0838B70927;
        Tue, 22 Mar 2022 22:35:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22N5ZWbM045084;
        Wed, 23 Mar 2022 00:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648013732;
        bh=/QEiiVGlzdOsl7qH7NV03cnxdNoCqW4P0FqbZASu7U8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CzwLnhdFQ//6RE3KB/bDrX9cGIbtmfwQsV9poppAjUHYiYy6pjT7ARE4/1E9zQ3FS
         DaX5u1Bq4QalXxmyDHFj9SkI+IEf/EteLGsnO/C7VYqHl0w5ceYwI2Kdom9alOmcjg
         oLw6iSY7kf9H0b04uRnQ/i8UUUHL3kJdERgs7+C0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22N5ZWSt095584
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Mar 2022 00:35:32 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Mar 2022 00:35:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Mar 2022 00:35:31 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22N5ZOoP038635;
        Wed, 23 Mar 2022 00:35:28 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 1/2] dt-bindings: usb: Add documentation for AM62 USB Wrapper module
Date:   Wed, 23 Mar 2022 11:05:23 +0530
Message-ID: <20220323053524.7009-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220323053524.7009-1-a-govindraju@ti.com>
References: <20220323053524.7009-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
controller.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../devicetree/bindings/usb/ti,am62-usb.yaml  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
new file mode 100644
index 000000000000..4bb139d1926d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
+
+maintainers:
+  - Aswath Govindraju <a-govindraju@ti.com>
+
+properties:
+  compatible:
+    const: ti,am62-usb
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  power-domains:
+    description:
+      PM domain provider node and an args specifier containing
+      the USB ISO device id value. See,
+      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
+    maxItems: 1
+
+  clocks:
+    description: Clock phandles to usb2_refclk
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref
+
+  id-gpio:
+    description:
+      GPIO to be used as ID pin
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt line to be used for detecting changes in VBUS
+
+  ti,vbus-divider:
+    description:
+      Should be present if USB VBUS line is connected to the
+      VBUS pin of the SoC via a 1/3 voltage divider.
+    type: boolean
+
+  ti,syscon-phy-pll-refclk:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to the SYSCON entry
+          - description: USB phy control register offset within SYSCON
+    description: Specifier for configuring frequency of ref clock input.
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - clocks
+  - clock-names
+  - interrupts
+  - ti,syscon-phy-pll-refclk
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      dwc3-usb@f910000 {
+        compatible = "ti,am62-usb";
+        reg = <0x00 0x0f910000 0x00 0x800>;
+        interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>; /* MISC IRQ */
+        clocks = <&k3_clks 162 3>;
+        clock-names = "ref";
+        ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
+        power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+        id-gpio = <&main_gpio1 51 GPIO_ACTIVE_LOW>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+      };
+    };
-- 
2.17.1

