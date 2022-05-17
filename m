Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46C352A942
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351446AbiEQR3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351428AbiEQR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:29:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B0B36B71;
        Tue, 17 May 2022 10:29:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24HHTaQK003334;
        Tue, 17 May 2022 12:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1652808576;
        bh=deD3EIje9Vyk7QFSHVfQAyeVCw4AXB48R+C+3n6GWRY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q0DMtRozylqsCsX1qt3C73A+iz8Jq80paOwGlzbF0YOHctcqMsVo2a6syy7F1eeEn
         OmIx5mUbL4LTLxkCZS6BZIh33m9cOfo8mcroi+6X8jrKhbnRlZsV9YEEVP0jnlnjTT
         43IqCI0wb27HeUL9SgiJut4vDasCgoBLT14jFPic=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24HHTa5m108805
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 May 2022 12:29:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 17
 May 2022 12:29:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 17 May 2022 12:29:35 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24HHTRYE079003;
        Tue, 17 May 2022 12:29:32 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
Date:   Tue, 17 May 2022 22:59:19 +0530
Message-ID: <20220517172920.10857-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517172920.10857-1-j-keerthy@ti.com>
References: <20220517172920.10857-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VTM bindings documentation. In the Voltage Thermal
Management Module(VTM), K3 J72XX supplies a voltage
reference and a temperature sensor feature that are gathered in the band
gap voltage and temperature sensor (VBGAPTS) module. The band
gap provides current and voltage reference for its internal
circuits and other analog IP blocks. The analog-to-digital
converter (ADC) produces an output value that is proportional
to the silicon temperature.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/ti,j72xx-thermal.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
new file mode 100644
index 000000000000..c74f124ebfc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments J72XX VTM (DTS) binding
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,j721e-vtm
+      - ti,j7200-vtm
+
+  reg:
+    items:
+      - description: VTM cfg1 register space
+      - description: VTM cfg2 register space
+      - description: VTM efuse register space
+
+  power-domains:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    wkup_vtm0: thermal-sensor@42040000 {
+        compatible = "ti,j721e-vtm";
+        reg = <0x42040000 0x350>,
+              <0x42050000 0x350>,
+              <0x43000300 0x10>;
+        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+        #thermal-sensor-cells = <1>;
+    };
+
+    mpu_thermal: mpu-thermal {
+        polling-delay-passive = <250>; /* milliseconds */
+        polling-delay = <500>; /* milliseconds */
+        thermal-sensors = <&wkup_vtm0 0>;
+
+        trips {
+            mpu_crit: mpu-crit {
+                temperature = <125000>; /* milliCelsius */
+                hysteresis = <2000>; /* milliCelsius */
+                type = "critical";
+            };
+        };
+    };
+...
-- 
2.17.1

