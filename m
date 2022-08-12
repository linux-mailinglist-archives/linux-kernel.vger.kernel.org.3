Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216A8590A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiHLDXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiHLDXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:23:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE739A346F;
        Thu, 11 Aug 2022 20:23:11 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27C3N4ta073657;
        Thu, 11 Aug 2022 22:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660274584;
        bh=ybRbRZ6XB/9I3M+k9jxHso72fMEjppEg2Jzo3Gg/Ci0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t9xdV5DE+53kwx2mWKohA0OJLNiI6EeXAiD4LBZ3UCtHbvA6mp22jMz4qO5QXaPs3
         zrzC3ZAV5KzWAP1UsnxVra+o2PAGjq2YeCiFZqy4xjlLRs9c+LNfGN9WcGP+yMXugY
         AFKD6kaZH6Jwjl8NYc9M5H0ZqQ3nnDAOBq48nM+c=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27C3N4oL119559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Aug 2022 22:23:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 11
 Aug 2022 22:23:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 11 Aug 2022 22:23:04 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27C3MkOr096105;
        Thu, 11 Aug 2022 22:22:57 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <j-keerthy@ti.com>, <lee@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 1/6] Documentation: tps6594x: Add DT bindings for the TPS6594x PMIC
Date:   Thu, 11 Aug 2022 20:22:37 -0700
Message-ID: <20220812032242.564026-2-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220812032242.564026-1-mranostay@ti.com>
References: <20220812032242.564026-1-mranostay@ti.com>
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

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../devicetree/bindings/mfd/ti,tps6594x.yaml  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
new file mode 100644
index 000000000000..9b5e17f63709
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594x.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,tps6594x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TPS6594x Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - ti,tps6594x
+
+  reg:
+    const: 0x48
+    description: I2C slave address
+
+  ti,system-power-controller:
+    type: boolean
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

