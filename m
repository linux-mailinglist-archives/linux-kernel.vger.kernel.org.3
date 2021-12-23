Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A31847E839
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350112AbhLWTRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:17:33 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47644 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350033AbhLWTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:17:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJHHfX029577;
        Thu, 23 Dec 2021 13:17:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640287037;
        bh=R0gbQOb2lXd5oxD5hSyV/eX7NgDQjbKY5xdCNgZr7z8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eWrMicoyEfLy7sdhVLgl0kzL3Hr68QYL+MEruRS50eQcu+7OKRiHXWmmcnjzJ8ec8
         AEq0KdzcAK0HmNMjqPWbkH/e4d2O7VbPkbvxF7fi8QRDRbEULzzDocAwg1G7kx1ya5
         vtK2fxqC0kWSBMS4hgp+fXamraod/iBbPHc1KG68=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNJHGvE007561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 13:17:16 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 13:17:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 13:17:16 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJGGQb006164;
        Thu, 23 Dec 2021 13:17:13 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH v5 14/14] media: dt-bindings: Convert Cadence CSI2RX binding to YAML
Date:   Fri, 24 Dec 2021 00:46:15 +0530
Message-ID: <20211223191615.17803-15-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211223191615.17803-1-p.yadav@ti.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Cadence CSI2RX binding to use YAML schema.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v5:
- Move clock description in comments under the clocks property.
- Make ports required.
- Add Rob's and Laurent's R-by.

Changes in v4:
- Add power-domains property.
- Drop maxItems from clock-names.
- Drop the type for data-lanes.
- Drop uniqueItems from data-lanes. Move it to video-interfaces.yaml
  instead.

Changes in v3:
- Add compatible: contains: const: cdns,csi2rx to allow SoC specific
  compatible.
- Add more constraints for data-lanes property.

Changes in v2:
- New in v2.

 .../devicetree/bindings/media/cdns,csi2rx.txt | 100 ----------
 .../bindings/media/cdns,csi2rx.yaml           | 176 ++++++++++++++++++
 2 files changed, 176 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
 create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml

diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt b/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
deleted file mode 100644
index 6b02a0657ad9..000000000000
--- a/Documentation/devicetree/bindings/media/cdns,csi2rx.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-Cadence MIPI-CSI2 RX controller
-===============================
-
-The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
-lanes in input, and 4 different pixel streams in output.
-
-Required properties:
-  - compatible: must be set to "cdns,csi2rx" and an SoC-specific compatible
-  - reg: base address and size of the memory mapped region
-  - clocks: phandles to the clocks driving the controller
-  - clock-names: must contain:
-    * sys_clk: main clock
-    * p_clk: register bank clock
-    * pixel_if[0-3]_clk: pixel stream output clock, one for each stream
-                         implemented in hardware, between 0 and 3
-
-Optional properties:
-  - phys: phandle to the external D-PHY, phy-names must be provided
-  - phy-names: must contain "dphy", if the implementation uses an
-               external D-PHY
-
-Required subnodes:
-  - ports: A ports node with one port child node per device input and output
-           port, in accordance with the video interface bindings defined in
-           Documentation/devicetree/bindings/media/video-interfaces.txt. The
-           port nodes are numbered as follows:
-
-           Port Description
-           -----------------------------
-           0    CSI-2 input
-           1    Stream 0 output
-           2    Stream 1 output
-           3    Stream 2 output
-           4    Stream 3 output
-
-           The stream output port nodes are optional if they are not
-           connected to anything at the hardware level or implemented
-           in the design.Since there is only one endpoint per port,
-           the endpoints are not numbered.
-
-
-Example:
-
-csi2rx: csi-bridge@0d060000 {
-	compatible = "cdns,csi2rx";
-	reg = <0x0d060000 0x1000>;
-	clocks = <&byteclock>, <&byteclock>
-		 <&coreclock>, <&coreclock>,
-		 <&coreclock>, <&coreclock>;
-	clock-names = "sys_clk", "p_clk",
-		      "pixel_if0_clk", "pixel_if1_clk",
-		      "pixel_if2_clk", "pixel_if3_clk";
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-
-			csi2rx_in_sensor: endpoint {
-				remote-endpoint = <&sensor_out_csi2rx>;
-				clock-lanes = <0>;
-				data-lanes = <1 2>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-
-			csi2rx_out_grabber0: endpoint {
-				remote-endpoint = <&grabber0_in_csi2rx>;
-			};
-		};
-
-		port@2 {
-			reg = <2>;
-
-			csi2rx_out_grabber1: endpoint {
-				remote-endpoint = <&grabber1_in_csi2rx>;
-			};
-		};
-
-		port@3 {
-			reg = <3>;
-
-			csi2rx_out_grabber2: endpoint {
-				remote-endpoint = <&grabber2_in_csi2rx>;
-			};
-		};
-
-		port@4 {
-			reg = <4>;
-
-			csi2rx_out_grabber3: endpoint {
-				remote-endpoint = <&grabber3_in_csi2rx>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
new file mode 100644
index 000000000000..399fe619377d
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/cdns,csi2rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence MIPI-CSI2 RX controller
+
+description: |
+  The Cadence MIPI-CSI2 RX controller is a CSI-2 bridge supporting up to 4 CSI
+  lanes in input, and 4 different pixel streams in output.
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    contains:
+      const: cdns,csi2rx
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    items:
+      - description: Main clock
+      - description: Register bank clock
+      - description: Pixel stream 0 output clock
+      - description: Pixel stream 1 output clock
+      - description: Pixel stream 2 output clock
+      - description: Pixel stream 3 output clock
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: sys_clk
+      - const: p_clk
+      - const: pixel_if0_clk
+      - const: pixel_if1_clk
+      - const: pixel_if2_clk
+      - const: pixel_if3_clk
+
+  phys:
+    maxItems: 1
+    description: phandle to the external D-PHY
+
+  phy-names:
+    items:
+      - const: dphy
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI-2 input
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  maximum: 4
+
+            required:
+              - clock-lanes
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Stream 0 output
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Stream 1 output
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Stream 2 output
+
+      port@4:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Stream 3 output
+
+    required:
+      - port@0
+
+
+dependencies:
+  phys: [ 'phy-names' ]
+  phy-names: [ 'phys' ]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    csi2rx: csi-bridge@d060000 {
+      compatible = "cdns,csi2rx";
+      reg = <0x0d060000 0x1000>;
+      clocks = <&byteclock>, <&byteclock>,
+        <&coreclock>, <&coreclock>,
+        <&coreclock>, <&coreclock>;
+      clock-names = "sys_clk", "p_clk",
+              "pixel_if0_clk", "pixel_if1_clk",
+              "pixel_if2_clk", "pixel_if3_clk";
+      phys = <&dphy0>;
+      phy-names = "dphy";
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+
+          csi2rx_in_sensor: endpoint {
+            remote-endpoint = <&sensor_out_csi2rx>;
+            clock-lanes = <0>;
+            data-lanes = <1 2>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+
+          csi2rx_out_grabber0: endpoint {
+            remote-endpoint = <&grabber0_in_csi2rx>;
+          };
+        };
+
+        port@2 {
+          reg = <2>;
+
+          csi2rx_out_grabber1: endpoint {
+            remote-endpoint = <&grabber1_in_csi2rx>;
+          };
+        };
+
+        port@3 {
+          reg = <3>;
+
+          csi2rx_out_grabber2: endpoint {
+            remote-endpoint = <&grabber2_in_csi2rx>;
+          };
+        };
+
+        port@4 {
+          reg = <4>;
+
+          csi2rx_out_grabber3: endpoint {
+            remote-endpoint = <&grabber3_in_csi2rx>;
+          };
+        };
+      };
+    };
-- 
2.33.1.835.ge9e5ba39a7

