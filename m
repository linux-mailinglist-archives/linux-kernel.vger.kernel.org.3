Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410444F657D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbiDFQdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbiDFQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:32:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D73A1C1E7F;
        Wed,  6 Apr 2022 06:52:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 236DqQmJ073045;
        Wed, 6 Apr 2022 08:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649253146;
        bh=ZlZPerePjjnbj3qgnIGG7yS3FTWwbY7C2WJBkoXBy6M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=La0pqumwT0j2FA5QBZGRs5ikic5wng09DaA3KWGUc0N5GzCiB7nm59TYt8JSTZkGO
         trzjCNPx2KX3SmRUuqW2e+5VG5F+nqjYMf7B1ac3IRS0B4KkKlrNk0zIXov0nzBffq
         VGijLZApk9wZTM3CfOtZg8wzDeTdmLSwZ9Hh8j8o=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 236DqQdo089793
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Apr 2022 08:52:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Apr 2022 08:52:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Apr 2022 08:52:26 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 236DqFso079424;
        Wed, 6 Apr 2022 08:52:23 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: usb: Add documentation for AM62 USB Wrapper module
Date:   Wed, 6 Apr 2022 19:22:10 +0530
Message-ID: <20220406135214.6989-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406135214.6989-1-a-govindraju@ti.com>
References: <20220406135214.6989-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

changes since v2:
- Removed the implementation of detecting the role from the wrapper
  driver and moved the implementation to using linux,extcon-usb-gpio
  driver for role detection.
- Updated the binding documentation and example to reflect the same.

 .../devicetree/bindings/usb/ti,am62-usb.yaml  | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
new file mode 100644
index 000000000000..59b5ccea5671
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
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
+    description: Clock phandle to usb2_refclk
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref
+
+  interrupts:
+    description:
+      interrupt line to be used for detecting changes in VBUS
+    maxItems: 1
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
+    description:
+      Specifier for conveying frequency of ref clock input, for the
+      operation of USB2PHY.
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+    description: Required child node
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
+    extcon_usb1: extcon-usb1 {
+      id-gpios = <&main_gpio1 51 GPIO_ACTIVE_HIGH>;
+    };
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      usbss1: usb@f910000 {
+        compatible = "ti,am62-usb";
+        reg = <0x00 0x0f910000 0x00 0x800>;
+        interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>; /* MISC IRQ */
+        clocks = <&k3_clks 162 3>;
+        clock-names = "ref";
+        ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
+        power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@31100000 {
+          compatible = "snps,dwc3";
+          reg =<0x00 0x31100000 0x00 0x50000>;
+          interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+                       <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
+          interrupt-names = "host", "peripheral";
+          maximum-speed = "high-speed";
+          extcon = <&extcon_usb1>;
+          dr_mode = "otg";
+        };
+      };
+    };
-- 
2.17.1

