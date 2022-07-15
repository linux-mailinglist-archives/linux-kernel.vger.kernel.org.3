Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A951B575FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiGOLRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGOLRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:17:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E5B8736E;
        Fri, 15 Jul 2022 04:17:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:3153:7fbd:8a7b:29b6:89fb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 110A76601A54;
        Fri, 15 Jul 2022 12:17:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657883837;
        bh=shAU8e2R4WyLaEoC6EL3iDMxLiC1YqU5jesFwjQfPDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgAbBGu+aw0/WoT0FpNTxYZm9DeEdtzgpmfMcB1Lp5ts03MVbF3cabpRoG5tyXaIY
         MUcEA6NzQGWjxB5lo70Qss9YmlOXq2CNxEUQf6w3YaoHm7mh3mDr5LtLtOclN7jEjf
         CukNNpI75vLRS6LhmHwUWrub/9tU9cwWf23MmuQvs7tbSRGcL3SHGM1YWPP2r5ByjP
         Lga6P6Fqs6nFWUMXai9M+c1LS/pVN7pEk9VfkkYmLpy/g22//9x1Ynpy7S1daJjMCH
         IfObxlPWm7MAo3M8SSct8VCq/hYW2titTjxVvBm7a1XzE0xsmgW2CpbJ5ahcaQRXKi
         iuNK/HsPQOZlg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        dmitry.osipenko@collabora.com, Zhigang.Shi@liteon.com
Cc:     krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        andy.shevchenko@gmail.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v9 1/2] dt-bindings: Document ltrf216a light sensor bindings
Date:   Fri, 15 Jul 2022 16:46:25 +0530
Message-Id: <20220715111626.1066513-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220715111626.1066513-1-shreeya.patel@collabora.com>
References: <20220715111626.1066513-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for ltrf216a ambient light sensor.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v7
  - Fix the error reported by kernel test robot.

Changes in v5
  - Remove deprecated string 'ltr' from the bindings.

Changes in v3
  - Fix indentation in the example section

Changes in v2
  - Take over the maintainership for the bindings
  - Add interrupt and power supply property in DT bindings

 .../bindings/iio/light/liteon,ltrf216a.yaml   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
new file mode 100644
index 000000000000..7de1b0e721ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LTRF216A Ambient Light Sensor
+
+maintainers:
+  - Shreeya Patel <shreeya.patel@collabora.com>
+
+description:
+  Ambient light sensing with an i2c interface.
+
+properties:
+  compatible:
+    const: liteon,ltrf216a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@53 {
+            compatible = "liteon,ltrf216a";
+            reg = <0x53>;
+            vdd-supply = <&vdd_regulator>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
-- 
2.30.2

