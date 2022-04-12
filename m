Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA5A4FD754
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388189AbiDLJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377924AbiDLHyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:54:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7D506C8;
        Tue, 12 Apr 2022 00:31:58 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23C7VegL024395;
        Tue, 12 Apr 2022 02:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649748700;
        bh=6AJZHAvc6kDT9/m7rBLTEzcu/QyIsm+/F/qafjCkGmk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n7xcgnLtDkztYhDpaIzdxYG38vhw6uiRIoELHkEsVsU3bQalKAyPABZ1Muk0sa6Js
         qS2FCkuc0bOPmzFbNlV08P+VAhPa/AE62MtY5zOUO51NYIup2IsKuM0WwsijbO7Krg
         dwBAgKkTyBtp2slpWIjDXG/VB10aOZuefvg/gzuc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23C7VeTk057268
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 02:31:40 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 02:31:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 02:31:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23C7Vdc1105779;
        Tue, 12 Apr 2022 02:31:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] dt-bindings: rtc: Add TI K3 RTC devicetree bindings documentation
Date:   Tue, 12 Apr 2022 02:31:37 -0500
Message-ID: <20220412073138.25027-2-nm@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412073138.25027-1-nm@ti.com>
References: <20220412073138.25027-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation for the devicetree bindings of the Texas
Instruments RTC modules on K3 family of SoCs such as AM62x SoCs or
newer.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/rtc/ti,k3-rtc.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
new file mode 100644
index 000000000000..16aebb8013a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/ti,k3-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 Real Time Clock
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+description: |
+  This RTC appears in the AM62x family of SoCs.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ti,am62-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: VBUS Interface clock
+      - description: 32k Clock source (external or internal).
+
+  clock-names:
+    items:
+      - const: "vbus"
+      - const: "osc32k"
+
+  power-domains:
+    maxItems: 1
+
+  assigned-clocks:
+    description: |
+      override default osc32k parent clock reference to the osc32k clock entry
+    maxItems: 1
+
+  assigned-clock-parents:
+    description: |
+      override default osc32k parent clock phandle of the new parent clock of osc32k
+    maxItems: 1
+
+  wakeup-source: true
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    rtc@2b1f0000 {
+        compatible = "ti,am62-rtc";
+        reg = <0x2b1f0000 0x100>;
+        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&bar 0>;
+        clocks = <&foo 0>, <&foo 1>;
+        clock-names = "vbus", "osc32k";
+        wakeup-source;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    rtc@2b1f0000 {
+        compatible = "ti,am62-rtc";
+        reg = <0x2b1f0000 0x100>;
+        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&bar 0>;
+        clocks = <&foo 0>, <&foo 1>;
+        clock-names = "vbus", "osc32k";
+        wakeup-source;
+        assigned-clocks = <&foo 1>;
+        assigned-clock-parents = <&foo 2>;
+
+    };
-- 
2.31.1

