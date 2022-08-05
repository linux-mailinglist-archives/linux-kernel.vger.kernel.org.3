Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96358A605
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiHEGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiHEGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:44:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE9273907;
        Thu,  4 Aug 2022 23:44:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2756iEJe007790;
        Fri, 5 Aug 2022 01:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659681854;
        bh=5TJvD2s4bz0iaOG+KuC/1yL4YUKZ7tGBhsxys0s5y8k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MMWvl2yhPxvPiqv+fL04fCk8EaWYvY/YZm0BruBNqzHUhAfrWSFSboKQREvINx4GS
         bcW8/ClOzXO8ozvmEo13M4LcqU+dMJXEtFhl19v3cXmK0Pprv9ot2sPMDcl3Qz2Id6
         Uh+E/l8fc5UWsGlQEf1wBqCwpggDa+0hCEij6z94=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2756iEHB021680
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Aug 2022 01:44:14 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 5
 Aug 2022 01:44:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 5 Aug 2022 01:44:14 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2756hvNE086657;
        Fri, 5 Aug 2022 01:44:08 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <lee@kernel.org>, <nm@ti.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 1/4] Documentation: tps6594x: Add DT bindings for the TPS6594x PMIC
Date:   Thu, 4 Aug 2022 23:43:49 -0700
Message-ID: <20220805064352.793918-2-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220805064352.793918-1-mranostay@ti.com>
References: <20220805064352.793918-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../devicetree/bindings/mfd/ti,tps6594x.yaml  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
new file mode 100644
index 000000000000..9fd3af87a861
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,tps65086.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TPS6594x Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    const: ti,tps6594x
+
+  reg:
+    const: 0x48
+    description: I2C slave address
+
+  ti,system-power-controller:
+    description: PMIC is controlling the system power.
+
+  rtc:
+    type: object
+    $ref: /schemas/rtc/rtc.yaml#
+    unevaluatedProperties: false
+    properties:
+      compatible:
+        const: ti,tps6594x-rtc
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic: pmic@48 {
+            compatible = "ti,tps6594x";
+            reg = <0x48>;
+
+            rtc {
+                compatible = "ti,tps6594x-rtc";
+            };
+        };
+    };
+
+...
-- 
2.36.1

