Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85957500B32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiDNKfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiDNKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:34:56 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94268305;
        Thu, 14 Apr 2022 03:32:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23EAWMCE082972;
        Thu, 14 Apr 2022 05:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649932342;
        bh=2IngA7Gm6mwU2IBQyYuWGzv3GxBoNAtxIT4GL1GVDts=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hi5S4NmW5Y6+jTqokwgOsOwmocpnEm2e/hPGR1eOTco4x1O9Rnap2NQJfoKK3zpKl
         sX9rwaz5RFSqHi2FDz5F44TOmZ3NEt25kSwGYHly5oKtrU4SmpPaZNN3zwGe04JWdh
         +7iSHQHAlfNr+ICIBF9jKqh2oJAmonX8AwAvv/dw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23EAWMMo011655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Apr 2022 05:32:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Apr 2022 05:32:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 14 Apr 2022 05:32:22 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23EAWC6X097041;
        Thu, 14 Apr 2022 05:32:19 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: usb: Add documentation for AM62 USB Wrapper module
Date:   Thu, 14 Apr 2022 16:02:08 +0530
Message-ID: <20220414103211.16202-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220414103211.16202-1-a-govindraju@ti.com>
References: <20220414103211.16202-1-a-govindraju@ti.com>
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

Changes since v3:
- As VBUS_VALID interrupt is not being used, removed the interrupts
  property from the bindings. As there is change in the properties
  I did not pick the reviewed-by tags from the earlier version of
  the series.

 .../devicetree/bindings/usb/ti,am62-usb.yaml  | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
new file mode 100644
index 000000000000..d25fc708e32c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -0,0 +1,103 @@
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
+          dr_mode = "otg";
+        };
+      };
+    };
-- 
2.17.1

