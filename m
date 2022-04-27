Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63B2511199
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358247AbiD0GuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiD0GuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:50:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C466E4F44F;
        Tue, 26 Apr 2022 23:46:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R6kte7058373;
        Wed, 27 Apr 2022 01:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651042015;
        bh=ltmqJfmKEgeBcMnx1ndgzNfG+vhgSs/dz39mj7pbFVI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JmRlTSRqM6CwFNAKxS0mzb2xtg+/KYwjlwGOwwKV3oQ0SarmcOWBzUgK/lqCXWkXh
         lZm6TMO+3/yGWnfpr/voHan7fPrnLEFOVKOuwEzg3+qbKuVwrIZ7g80ZxII1zajbzz
         DXct3io9FKWsAoixnPcx5sT+q/gA82+RI0C4D3cg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R6kt3m042465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 01:46:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 01:46:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 01:46:55 -0500
Received: from keerthy.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R6kjX7031550;
        Wed, 27 Apr 2022 01:46:51 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <krzysztof.kozlowski@linaro.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
Date:   Wed, 27 Apr 2022 12:16:32 +0530
Message-ID: <20220427064635.24898-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427064635.24898-1-j-keerthy@ti.com>
References: <20220427064635.24898-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 .../bindings/thermal/ti,j72xx-thermal.yaml    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
new file mode 100644
index 000000000000..84b70fb108da
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -0,0 +1,64 @@
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
+    items:
+      - enum:
+          - ti,j721e-vtm
+          - ti,j7200-vtm
+
+  reg:
+    maxItems: 3
+    description:
+      Must be 3, in order to specify three register spaces for VTM cfg1, cfg2
+      and efuse register space.
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
+            <0x42050000 0x350>,
+            <0x43000300 0x10>;
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
+                mpu_crit: mpu-crit {
+                        temperature = <125000>; /* milliCelsius */
+                        hysteresis = <2000>; /* milliCelsius */
+                        type = "critical";
+                };
+        };
+    };
+...
-- 
2.17.1

