Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8171C4CB1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiCBWJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbiCBWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:08:48 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA64B40C;
        Wed,  2 Mar 2022 14:08:02 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A22CAE0004;
        Wed,  2 Mar 2022 22:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646258881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16X9BXQF4VfuXp5t1pheaZ6cTaSX2VR20iPQ5mFHg/s=;
        b=Qa7baZspw4eYEN9MKNSalh7QZtMKvjTJl9B16E726kDfh6Y/0id/yr3fj09AsihTy9/7vk
        2EfpIR9Xzag1mgo9PBa3ftBh5gVtse5IlRpgwIsHwY1vrqKtxDzqvINSXhIQTCAag6iVpr
        naOgXli0o0obxfM9OuyKb2HKfszg936K5dTI5SgAAeut1TWiHGMpBbSy7iKJjQEppqoKHy
        eZXT40Sf1JxlOoe0W/nNxauS/Ice5ZyjAXMzxc8Nxo6deHocNbVfUKfb4q6p4WYG5liwgs
        sQl7lFlf06pIbSoOmQtK1VrgWSyd8dKgAzuz6GXa/jgxl9WQqJqqpmucd8FpsA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/9] dt-bindings: media: Add Allwinner A31 MIPI CSI-2 bindings documentation
Date:   Wed,  2 Mar 2022 23:07:34 +0100
Message-Id: <20220302220739.144303-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces YAML bindings documentation for the Allwinner A31 MIPI
CSI-2 controller.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../media/allwinner,sun6i-a31-mipi-csi2.yaml  | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml
new file mode 100644
index 000000000000..fa8199396332
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-mipi-csi2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 MIPI CSI-2 Device Tree Bindings
+
+maintainers:
+  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun6i-a31-mipi-csi2
+      - items:
+          - const: allwinner,sun8i-v3s-mipi-csi2
+          - const: allwinner,sun6i-a31-mipi-csi2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+  phys:
+    maxItems: 1
+    description: MIPI D-PHY
+
+  phy-names:
+    items:
+      - const: dphy
+
+  resets:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Input port, connect to a MIPI CSI-2 sensor
+
+        properties:
+          reg:
+            const: 0
+
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+            required:
+              - data-lanes
+
+        additionalProperties: false
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Output port, connect to a CSI controller
+
+        properties:
+          reg:
+            const: 1
+
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+        additionalProperties: false
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - resets
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun8i-v3s-ccu.h>
+    #include <dt-bindings/reset/sun8i-v3s-ccu.h>
+
+    mipi_csi2: csi@1cb1000 {
+        compatible = "allwinner,sun8i-v3s-mipi-csi2",
+                     "allwinner,sun6i-a31-mipi-csi2";
+        reg = <0x01cb1000 0x1000>;
+        interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_CSI>,
+                 <&ccu CLK_CSI1_SCLK>;
+        clock-names = "bus", "mod";
+        resets = <&ccu RST_BUS_CSI>;
+
+        phys = <&dphy>;
+        phy-names = "dphy";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mipi_csi2_in: port@0 {
+                reg = <0>;
+
+                mipi_csi2_in_ov5648: endpoint {
+                    data-lanes = <1 2 3 4>;
+
+                    remote-endpoint = <&ov5648_out_mipi_csi2>;
+                };
+            };
+
+            mipi_csi2_out: port@1 {
+                reg = <1>;
+
+                mipi_csi2_out_csi0: endpoint {
+                    remote-endpoint = <&csi0_in_mipi_csi2>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.35.1

