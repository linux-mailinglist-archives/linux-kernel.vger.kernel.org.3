Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97A6558495
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiFWRoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiFWRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:38:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672D4705E;
        Thu, 23 Jun 2022 10:08:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25NH8B1l045818;
        Thu, 23 Jun 2022 12:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656004091;
        bh=j6QqpEy1GUThCO+tC17N8Mxplz9oP+bLaTtTJw+1a30=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kANU7q+LkeAGfgDwQZNO/O44i/0rWc5nKBzwkhyzXgMUhZMkp6TIvT82QB6n4acfW
         qy7Lgnz2gyOO03MRh/0A5c+G4zuZbAJKg2PFs38dFQucF2rGkZI4uwd+7M9ooH+K63
         7oJEMxVXd7m3Gu4ZA3lfj/wo7zdQzKcET72CREtU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25NH8BLG092608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 12:08:11 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 12:08:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 12:08:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25NH8BKc078201;
        Thu, 23 Jun 2022 12:08:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 1/2] dt-bindings: rtc: Add TI K3 RTC description
Date:   Thu, 23 Jun 2022 12:08:07 -0500
Message-ID: <20220623170808.20998-2-nm@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220623170808.20998-1-nm@ti.com>
References: <20220623170808.20998-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since V3:
* pickedup Krzysztof's reviewed-by

V3: https://lore.kernel.org/all/20220513194457.25942-2-nm@ti.com/
V2: https://lore.kernel.org/all/20220511002600.27964-2-nm@ti.com/
V1: https://lore.kernel.org/all/20220412073138.25027-2-nm@ti.com/
 .../devicetree/bindings/rtc/ti,k3-rtc.yaml    | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
new file mode 100644
index 000000000000..d995ef04a6eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml
@@ -0,0 +1,62 @@
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
+allOf:
+  - $ref: "rtc.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - ti,am62-rtc
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
+      - const: vbus
+      - const: osc32k
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
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
-- 
2.31.1

