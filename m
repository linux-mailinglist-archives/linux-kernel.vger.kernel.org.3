Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280FB53438C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbiEYTDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344004AbiEYTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:03:37 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B5E018;
        Wed, 25 May 2022 12:03:21 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C38441C000B;
        Wed, 25 May 2022 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkDskoR8wjdnIKSCS4YkqYtISclu+O++Ibqt8W0S4WE=;
        b=MlJzvQAMWmxUG3lWNKubraSdG38jDCJl3i9nL5cNUPpey5qe/CFwFSuVB97vhARBFnsy2S
        Eg22AkQ9n5KdrvukhGKhfAxmSOdkMkgHNd0U6qOwfaX66G7oG3Eszkuz9ufL9vVgPr1mjS
        Q97l/tk0+ojGyAX/7tNTsCb/1EYFtB4EhMWaVg2AXhkkCOxgygbRFhJcaAhAdEJYrafOZV
        qyrrHNHpwZOEPxxu0yThy7rMuWWwKfN/X4DSxqKbQDxZzqiMHSN/Ej64pQ4lr+oAnC4312
        JhQn/9UrTaGjqKHv5VFFhhVfKfyQSRVC3KMB8JgTepHcAHOBD/bpt0nvkWneCw==
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
Subject: [PATCH v5 5/6] dt-bindings: media: Add Allwinner A83T MIPI CSI-2 bindings documentation
Date:   Wed, 25 May 2022 21:02:59 +0200
Message-Id: <20220525190300.696269-6-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190300.696269-1-paul.kocialkowski@bootlin.com>
References: <20220525190300.696269-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces YAML bindings documentation for the Allwinner A83T
MIPI CSI-2 controller.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../media/allwinner,sun8i-a83t-mipi-csi2.yaml | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml
new file mode 100644
index 000000000000..5b27482b5687
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/allwinner,sun8i-a83t-mipi-csi2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A83T MIPI CSI-2 Device Tree Bindings
+
+maintainers:
+  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+
+properties:
+  compatible:
+    const: allwinner,sun8i-a83t-mipi-csi2
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
+      - description: MIPI-specific Clock
+      - description: Misc CSI Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+      - const: mipi
+      - const: misc
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
+        unevaluatedProperties: false
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output port, connect to a CSI controller
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
+  - resets
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun8i-a83t-ccu.h>
+    #include <dt-bindings/reset/sun8i-a83t-ccu.h>
+
+    mipi_csi2: csi@1cb1000 {
+        compatible = "allwinner,sun8i-a83t-mipi-csi2";
+        reg = <0x01cb1000 0x1000>;
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_CSI>,
+                 <&ccu CLK_CSI_SCLK>,
+                 <&ccu CLK_MIPI_CSI>,
+                 <&ccu CLK_CSI_MISC>;
+        clock-names = "bus", "mod", "mipi", "misc";
+        resets = <&ccu RST_BUS_CSI>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mipi_csi2_in: port@0 {
+                reg = <0>;
+
+                mipi_csi2_in_ov8865: endpoint {
+                    data-lanes = <1 2 3 4>;
+
+                    remote-endpoint = <&ov8865_out_mipi_csi2>;
+                };
+            };
+
+            mipi_csi2_out: port@1 {
+                reg = <1>;
+
+                mipi_csi2_out_csi: endpoint {
+                    remote-endpoint = <&csi_in_mipi_csi2>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.36.1

