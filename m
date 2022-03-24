Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB674E5F86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348659AbiCXHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbiCXHgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:36:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4031B6;
        Thu, 24 Mar 2022 00:34:36 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22O7YXTf060439;
        Thu, 24 Mar 2022 02:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648107273;
        bh=sBewfIeDXXLrqlPnqAIxcfeAVguPcDu3+MXG7XmvIxo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ofV5GrehroJbuNEVR50+prBqz8A/dyUpLLi3LbyxCKT/uD7hocmzovqiyoVstPcYo
         NJJlFG+S3xA46s2RVBixCL+STu5IIsN9Uu1CLNgL3rIe7l4dycdeBYh2MjaTWdYAnX
         gfvreg2xWs204UMB4LVDxc9GKCv8TTTIfQJhsOFk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22O7YXPC012217
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Mar 2022 02:34:33 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 24
 Mar 2022 02:34:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 24 Mar 2022 02:34:33 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22O7YQLm024942;
        Thu, 24 Mar 2022 02:34:30 -0500
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
Subject: [PATCH v2 1/2] dt-bindings: usb: Add documentation for AM62 USB Wrapper module
Date:   Thu, 24 Mar 2022 13:04:24 +0530
Message-ID: <20220324073425.18607-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324073425.18607-1-a-govindraju@ti.com>
References: <20220324073425.18607-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since v1:
- made correction in grammer of clocks property description
  and added maxItems in the interrupts property based on comments
  received from Roger
- corrected the title, fixed the description of
  ti,syscon-phy-pll-refclk, added pattern properties and child node
  in the example based on the comments from Krzysztof.

 .../devicetree/bindings/usb/ti,am62-usb.yaml  | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
new file mode 100644
index 000000000000..452bfdc6fb09
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -0,0 +1,117 @@
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
+  id-gpio:
+    description:
+      GPIO to be used as ID pin
+    maxItems: 1
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
+        id-gpio = <&main_gpio1 51 GPIO_ACTIVE_LOW>;
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
+          extcon = <&usbss1>;
+          dr_mode = "otg";
+        };
+      };
+    };
-- 
2.17.1

