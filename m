Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36ED53C317
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiFCBUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiFCBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:19:40 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578EC3B002;
        Thu,  2 Jun 2022 18:19:37 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f314077115so8992942fac.1;
        Thu, 02 Jun 2022 18:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rZrnXACiYHU0tdGBkAnUb9r6EhuOxuDJGNMNwRK9E4=;
        b=QQiVfEDk5W5dxgbe1JXxWhnoU8R0idGr+uRTcGbtVZSYT353CetKPVV/ufUIYgZ0+X
         oVpMhrbGQ+ks/lI4LbKuZUQ6AdzVQowNqOAozU3lbalT6QkSYpC8LuE8fqudAJkphLSu
         UHm0kgXlbLZqwgvbCeREhkcfI6NFVZ2WHv7WPX2GYvZ028G8iSlKI65X5UTvOkqKXLmG
         u42YnJxjaH9qPs+AOs7LYXHM/rGu715/yTuNq2qGSx3pjrYXcalIwtX98IFES3toqTPf
         U7KO/6P7NWXf8YuZ/nDIPcKRyCgP4/aMViLeaz1iuSChYDH2aOr6Ke8SbuV/g4azVKy5
         +58Q==
X-Gm-Message-State: AOAM533Yv6EsT52zcSPgiBv6LAX4yQfeN2sE4g9lxLmjrb8cxPnC0DHp
        /ZVEKdVi7kFde1TrmwklEg==
X-Google-Smtp-Source: ABdhPJxEcjtTgA8oQqqRMEKLDz2blWcCAcmTJrl4jX64e497/7pOz85t7ap+RCxTbkh68xETWXjO3Q==
X-Received: by 2002:a05:6870:b254:b0:ec:6ca4:c89f with SMTP id b20-20020a056870b25400b000ec6ca4c89fmr21772419oam.272.1654219176224;
        Thu, 02 Jun 2022 18:19:36 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id na14-20020a0568706c0e00b000f5d8d031b6sm2679746oab.49.2022.06.02.18.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 18:19:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] dt-bindings: arm: Convert CoreSight bindings to DT schema
Date:   Thu,  2 Jun 2022 20:19:32 -0500
Message-Id: <20220603011933.3277315-3-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220603011933.3277315-1-robh@kernel.org>
References: <20220603011933.3277315-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CoreSight component has slightly different requirements and
nothing applies to every component, so each CoreSight component has its
own schema document.

Signed-off-by: Rob Herring <robh@kernel.org>
--
v2:
 - Add missing arm,coresight-dynamic-replicator.yaml and
   arm,coresight-static-funnel.yaml
 - Update MAINTAINERS
 - Fix coresight.txt references
 - Fix double blank line
---
 .../bindings/arm/arm,coresight-catu.yaml      | 101 +++++
 .../bindings/arm/arm,coresight-cti.yaml       |   3 +-
 .../arm/arm,coresight-dynamic-funnel.yaml     | 126 ++++++
 .../arm/arm,coresight-dynamic-replicator.yaml | 126 ++++++
 .../bindings/arm/arm,coresight-etb10.yaml     |  92 ++++
 .../bindings/arm/arm,coresight-etm.yaml       | 156 +++++++
 .../arm/arm,coresight-static-funnel.yaml      |  89 ++++
 .../arm/arm,coresight-static-replicator.yaml  |  90 ++++
 .../bindings/arm/arm,coresight-stm.yaml       | 101 +++++
 .../bindings/arm/arm,coresight-tmc.yaml       | 131 ++++++
 .../bindings/arm/arm,coresight-tpiu.yaml      |  91 ++++
 .../arm/arm,embedded-trace-extension.yaml     |   1 -
 .../devicetree/bindings/arm/coresight.txt     | 402 ------------------
 Documentation/trace/coresight/coresight.rst   |   2 +-
 MAINTAINERS                                   |   3 +-
 15 files changed, 1106 insertions(+), 408 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
new file mode 100644
index 000000000000..d783d9276124
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-catu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Coresight Address Translation Unit (CATU)
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The CoreSight Address Translation Unit (CATU) translates addresses between an
+  AXI master and system memory. The CATU is normally used along with the TMC to
+  implement scattering of virtual trace buffers in physical memory. The CATU
+  translates contiguous Virtual Addresses (VAs) from an AXI master into
+  non-contiguous Physical Addresses (PAs) that are intended for system memory.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-catu
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-catu
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  interrupts:
+    maxItems: 1
+    description: Address translation error interrupt
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: AXI Slave connected to another Coresight component
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    catu@207e0000 {
+        compatible = "arm,coresight-catu", "arm,primecell";
+        reg = <0x207e0000 0x1000>;
+
+        clocks = <&oscclk6a>;
+        clock-names = "apb_pclk";
+
+        interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+        in-ports {
+            port {
+                catu_in_port: endpoint {
+                    remote-endpoint = <&etr_out_port>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index d32d214ed64e..72ffe4d1e948 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -12,8 +12,7 @@ description: |
   to one or more CoreSight components and/or a CPU, with CTIs interconnected in
   a star topology via the Cross Trigger Matrix (CTM), which is not programmable.
   The ECT components are not part of the trace generation data path and are thus
-  not part of the CoreSight graph described in the general CoreSight bindings
-  file coresight.txt.
+  not part of the CoreSight graph.
 
   The CTI component properties define the connections between the individual
   CTI and the components it is directly connected to, consisting of input and
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
new file mode 100644
index 000000000000..1eeedc22857c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-dynamic-funnel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight Programmable Trace Bus Funnel
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The Coresight funnel merges 2-8 trace sources into a single trace
+  stream with programmable enable and priority of input ports.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-dynamic-funnel
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-dynamic-funnel
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    patternProperties:
+      '^port(@[0-7])?$':
+        description: Input connections from CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Output connection to CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+  - out-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    funnel@20040000 {
+        compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+        reg = <0x20040000 0x1000>;
+
+        clocks = <&oscclk6a>;
+        clock-names = "apb_pclk";
+        out-ports {
+            port {
+                funnel_out_port0: endpoint {
+                    remote-endpoint = <&replicator_in_port0>;
+                };
+            };
+        };
+
+        in-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                funnel_in_port0: endpoint {
+                    remote-endpoint = <&ptm0_out_port>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                funnel_in_port1: endpoint {
+                    remote-endpoint = <&ptm1_out_port>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                funnel_in_port2: endpoint {
+                    remote-endpoint = <&etm0_out_port>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
new file mode 100644
index 000000000000..a26ed9214e00
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-dynamic-replicator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Coresight Programmable Trace Bus Replicator
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The Coresight replicator splits a single trace stream into two trace streams
+  for systems that have more than one trace sink component.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-dynamic-replicator
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-dynamic-replicator
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  qcom,replicator-loses-context:
+    type: boolean
+    description:
+      Indicates that the replicator will lose register context when AMBA clock
+      is removed which is observed in some replicator designs.
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Input connection from CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    patternProperties:
+      '^port(@[01])?$':
+        description: Output connections to CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+  - out-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    replicator@20120000 {
+        compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+        reg = <0x20120000 0x1000>;
+
+        clocks = <&soc_smc50mhz>;
+        clock-names = "apb_pclk";
+
+        out-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            /* replicator output ports */
+            port@0 {
+                reg = <0>;
+                replicator_out_port0: endpoint {
+                    remote-endpoint = <&tpiu_in_port>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                replicator_out_port1: endpoint {
+                    remote-endpoint = <&etr_in_port>;
+                };
+            };
+        };
+        in-ports {
+            port {
+                replicator_in_port0: endpoint {
+                    remote-endpoint = <&csys2_funnel_out_port>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
new file mode 100644
index 000000000000..fd06ede26ceb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-etb10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight Embedded Trace Buffer
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The CoreSight Embedded Trace Buffer stores traces in a dedicated SRAM that is
+  used as a circular buffer.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-etb10
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-etb10
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Input connection from CoreSight Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    etb@20010000 {
+        compatible = "arm,coresight-etb10", "arm,primecell";
+        reg = <0x20010000 0x1000>;
+
+        clocks = <&oscclk6a>;
+        clock-names = "apb_pclk";
+        in-ports {
+            port {
+                etb_in_port: endpoint {
+                    remote-endpoint = <&replicator_out_port0>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
new file mode 100644
index 000000000000..e0377ce48537
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-etm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight Embedded Trace MacroCell
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The Embedded Trace Macrocell (ETM) is a real-time trace module providing
+  instruction and data tracing of a processor.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - arm,coresight-etm3x
+          - arm,coresight-etm4x
+          - arm,coresight-etm4x-sysreg
+  required:
+    - compatible
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,coresight-etm4x-sysreg
+    then:
+      $ref: /schemas/arm/primecell.yaml#
+      required:
+        - reg
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          Embedded Trace Macrocell with memory mapped access.
+        items:
+          - enum:
+              - arm,coresight-etm3x
+              - arm,coresight-etm4x
+          - const: arm,primecell
+      - description:
+          Embedded Trace Macrocell (version 4.x), with system register access only
+        const: arm,coresight-etm4x-sysreg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  arm,coresight-loses-context-with-cpu:
+    type: boolean
+    description:
+      Indicates that the hardware will lose register context on CPU power down
+      (e.g. CPUIdle). An example of where this may be needed are systems which
+      contain a coresight component and CPU in the same power domain. When the
+      CPU powers down the coresight component also powers down and loses its
+      context.
+
+  arm,cp14:
+    type: boolean
+    description:
+      Must be present if the system accesses ETM/PTM management registers via
+      co-processor 14.
+
+  qcom,skip-power-up:
+    type: boolean
+    description:
+      Indicates that an implementation can skip powering up the trace unit.
+      TRCPDCR.PU does not have to be set on Qualcomm Technologies Inc. systems
+      since ETMs are in the same power domain as their CPU cores. This property
+      is required to identify such systems with hardware errata where the CPU
+      watchdog counter is stopped when TRCPDCR.PU is set.
+
+  cpu:
+    description:
+      phandle to the cpu this ETM is bound to.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Output connection from the ETM to CoreSight Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - cpu
+  - out-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ptm@2201c000 {
+        compatible = "arm,coresight-etm3x", "arm,primecell";
+        reg = <0x2201c000 0x1000>;
+
+        cpu = <&cpu0>;
+        clocks = <&oscclk6a>;
+        clock-names = "apb_pclk";
+        out-ports {
+            port {
+                ptm0_out_port: endpoint {
+                    remote-endpoint = <&funnel_in_port0>;
+                };
+            };
+        };
+    };
+
+    ptm@2201d000 {
+        compatible = "arm,coresight-etm3x", "arm,primecell";
+        reg = <0x2201d000 0x1000>;
+
+        cpu = <&cpu1>;
+        clocks = <&oscclk6a>;
+        clock-names = "apb_pclk";
+        out-ports {
+            port {
+                ptm1_out_port: endpoint {
+                    remote-endpoint = <&funnel_in_port1>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
new file mode 100644
index 000000000000..b9da30ab9ccd
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-static-funnel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight Static Trace Bus Funnel
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The Coresight static funnel merges 2-8 trace sources into a single trace
+  stream.
+
+properties:
+  compatible:
+    const: arm,coresight-static-funnel
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    patternProperties:
+      '^port@[0-7]$':
+        description: Input connections from CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Output connection to CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - in-ports
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    funnel {
+        /* non-configurable replicators don't show up on the
+        * AMBA bus.  As such no need to add "arm,primecell".
+        */
+        compatible = "arm,coresight-static-funnel";
+
+        out-ports {
+            port {
+                combo_funnel_out: endpoint {
+                    remote-endpoint = <&top_funnel_in>;
+                };
+            };
+        };
+
+        in-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                combo_funnel_in0: endpoint {
+                    remote-endpoint = <&cluster0_etf_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                combo_funnel_in1: endpoint {
+                    remote-endpoint = <&cluster1_etf_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
new file mode 100644
index 000000000000..66ee97370fb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-static-replicator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight Static Trace Bus Replicator
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The Coresight replicator splits a single trace stream into two trace streams
+  for systems that have more than one trace sink component.
+
+properties:
+  compatible:
+    const: arm,coresight-static-replicator
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Input connection from CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    patternProperties:
+      '^port@[01]$':
+        description: Output connections to CoreSight Trace bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - in-ports
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    replicator {
+        /* non-configurable replicators don't show up on the
+        * AMBA bus.  As such no need to add "arm,primecell".
+        */
+        compatible = "arm,coresight-static-replicator";
+
+        out-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            /* replicator output ports */
+            port@0 {
+                reg = <0>;
+                replicator_out_port0: endpoint {
+                    remote-endpoint = <&etb_in_port>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                replicator_out_port1: endpoint {
+                    remote-endpoint = <&tpiu_in_port>;
+                };
+            };
+        };
+
+        in-ports {
+            port {
+                replicator_in_port0: endpoint {
+                    remote-endpoint = <&funnel_out_port0>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
new file mode 100644
index 000000000000..905008faa012
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-stm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight System Trace MacroCell
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The STM is a trace source that is integrated into a CoreSight system, designed
+  primarily for high-bandwidth trace of instrumentation embedded into software.
+  This instrumentation is made up of memory-mapped writes to the STM Advanced
+  eXtensible Interface (AXI) slave, which carry information about the behavior
+  of the software.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-stm
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-stm
+      - const: arm,primecell
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: stm-base
+      - const: stm-stimulus-base
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Output connection to the CoreSight Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - out-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    stm@20100000 {
+        compatible = "arm,coresight-stm", "arm,primecell";
+        reg = <0x20100000 0x1000>,
+              <0x28000000 0x180000>;
+        reg-names = "stm-base", "stm-stimulus-base";
+
+        clocks = <&soc_smc50mhz>;
+        clock-names = "apb_pclk";
+        out-ports {
+            port {
+                stm_out_port: endpoint {
+                    remote-endpoint = <&main_funnel_in_port2>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
new file mode 100644
index 000000000000..3463b6e53aef
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-tmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight Trace Memory Controller
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  Trace Memory Controller is used for Embedded Trace Buffer(ETB), Embedded Trace
+  FIFO(ETF) and Embedded Trace Router(ETR) configurations. The configuration
+  mode (ETB, ETF, ETR) is discovered at boot time when the device is probed.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-tmc
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-tmc
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  arm,buffer-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    deprecated: true
+    description:
+      Size of contiguous buffer space for TMC ETR (embedded trace router). The
+      buffer size can be configured dynamically via buffer_size property in
+      sysfs instead.
+
+  arm,scatter-gather:
+    type: boolean
+    description:
+      Indicates that the TMC-ETR can safely use the SG mode on this system.
+
+  arm,max-burst-size:
+    description:
+      The maximum burst size initiated by TMC on the AXI master interface. The
+      burst size can be in the range [0..15], the setting supports one data
+      transfer per burst up to a maximum of 16 data transfers per burst.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Input connection from the CoreSight Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: AXI or ATB Master output connection. Used for ETR
+          and ETF configurations.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    etr@20070000 {
+        compatible = "arm,coresight-tmc", "arm,primecell";
+        reg = <0x20070000 0x1000>;
+
+        clocks = <&oscclk6a>;
+        clock-names = "apb_pclk";
+        in-ports {
+            port {
+                etr_in_port: endpoint {
+                    remote-endpoint = <&replicator2_out_port0>;
+                };
+            };
+        };
+
+        out-ports {
+            port {
+                etr_out_port: endpoint {
+                    remote-endpoint = <&catu_in_port>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
new file mode 100644
index 000000000000..e80d48200c37
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,coresight-tpiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm CoreSight Trace Port Interface Unit
+
+maintainers:
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+  - Mike Leach <mike.leach@linaro.org>
+  - Leo Yan <leo.yan@linaro.org>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+
+description: |
+  CoreSight components are compliant with the ARM CoreSight architecture
+  specification and can be connected in various topologies to suit a particular
+  SoCs tracing needs. These trace components can generally be classified as
+  sinks, links and sources. Trace data produced by one or more sources flows
+  through the intermediate links connecting the source to the currently selected
+  sink.
+
+  The CoreSight Trace Port Interface Unit captures trace data from the trace bus
+  and outputs it to an external trace port.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,coresight-tpiu
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: arm,coresight-tpiu
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: apb_pclk
+      - const: atclk
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: Input connection from the CoreSight Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    tpiu@e3c05000 {
+        compatible = "arm,coresight-tpiu", "arm,primecell";
+        reg = <0xe3c05000 0x1000>;
+
+        clocks = <&clk_375m>;
+        clock-names = "apb_pclk";
+        in-ports {
+            port {
+                tpiu_in_port: endpoint {
+                    remote-endpoint = <&funnel4_out_port0>;
+                };
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
index 2415beeb12ea..5f07fb166c56 100644
--- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
@@ -20,7 +20,6 @@ description: |
   Arm Trace Buffer Extension (TRBE)). Since the ETE can be connected to
   legacy CoreSight components, a node must be listed per instance, along
   with any optional connection graph as per the coresight bindings.
-  See bindings/arm/coresight.txt.
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
deleted file mode 100644
index c68d93a35b6c..000000000000
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ /dev/null
@@ -1,402 +0,0 @@
-* CoreSight Components:
-
-CoreSight components are compliant with the ARM CoreSight architecture
-specification and can be connected in various topologies to suit a particular
-SoCs tracing needs. These trace components can generally be classified as
-sinks, links and sources. Trace data produced by one or more sources flows
-through the intermediate links connecting the source to the currently selected
-sink. Each CoreSight component device should use these properties to describe
-its hardware characteristcs.
-
-* Required properties for all components *except* non-configurable replicators
-  and non-configurable funnels:
-
-	* compatible: These have to be supplemented with "arm,primecell" as
-	  drivers are using the AMBA bus interface.  Possible values include:
-		- Embedded Trace Buffer (version 1.0):
-			"arm,coresight-etb10", "arm,primecell";
-
-		- Trace Port Interface Unit:
-			"arm,coresight-tpiu", "arm,primecell";
-
-		- Trace Memory Controller, used for Embedded Trace Buffer(ETB),
-		  Embedded Trace FIFO(ETF) and Embedded Trace Router(ETR)
-		  configuration.  The configuration mode (ETB, ETF, ETR) is
-		  discovered at boot time when the device is probed.
-			"arm,coresight-tmc", "arm,primecell";
-
-		- Trace Programmable Funnel:
-			"arm,coresight-dynamic-funnel", "arm,primecell";
-			"arm,coresight-funnel", "arm,primecell"; (OBSOLETE. For
-				backward compatibility and will be removed)
-
-		- Embedded Trace Macrocell (version 3.x) and
-					Program Flow Trace Macrocell:
-			"arm,coresight-etm3x", "arm,primecell";
-
-		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
-			"arm,coresight-etm4x", "arm,primecell";
-
-		- Embedded Trace Macrocell (version 4.x), with system register access only.
-			"arm,coresight-etm4x-sysreg";
-
-		- Coresight programmable Replicator :
-			"arm,coresight-dynamic-replicator", "arm,primecell";
-
-		- System Trace Macrocell:
-			"arm,coresight-stm", "arm,primecell"; [1]
-		- Coresight Address Translation Unit (CATU)
-			"arm,coresight-catu", "arm,primecell";
-
-		- Coresight Cross Trigger Interface (CTI):
-			"arm,coresight-cti", "arm,primecell";
-			See coresight-cti.yaml for full CTI definitions.
-
-	* reg: physical base address and length of the register
-	  set(s) of the component.
-
-	* clocks: the clocks associated to this component.
-
-	* clock-names: the name of the clocks referenced by the code.
-	  Since we are using the AMBA framework, the name of the clock
-	  providing the interconnect should be "apb_pclk", and some
-	  coresight blocks also have an additional clock "atclk", which
-	  clocks the core of that coresight component. The latter clock
-	  is optional.
-
-	* port or ports: see "Graph bindings for Coresight" below.
-
-* Additional required property for Embedded Trace Macrocell (version 3.x and
-  version 4.x):
-	* cpu: the cpu phandle this ETM/PTM is affined to. Do not
-	  assume it to default to CPU0 if omitted.
-
-* Additional required properties for System Trace Macrocells (STM):
-	* reg: along with the physical base address and length of the register
-	  set as described above, another entry is required to describe the
-	  mapping of the extended stimulus port area.
-
-	* reg-names: the only acceptable values are "stm-base" and
-	  "stm-stimulus-base", each corresponding to the areas defined in "reg".
-
-* Required properties for Coresight Cross Trigger Interface (CTI)
-	See coresight-cti.yaml for full CTI definitions.
-
-* Required properties for devices that don't show up on the AMBA bus, such as
-  non-configurable replicators and non-configurable funnels:
-
-	* compatible: Currently supported value is (note the absence of the
-	  AMBA markee):
-		- Coresight Non-configurable Replicator:
-			"arm,coresight-static-replicator";
-			"arm,coresight-replicator"; (OBSOLETE. For backward
-				compatibility and will be removed)
-
-		- Coresight Non-configurable Funnel:
-			"arm,coresight-static-funnel";
-
-	* port or ports: see "Graph bindings for Coresight" below.
-
-* Optional properties for all components:
-
-	* arm,coresight-loses-context-with-cpu : boolean. Indicates that the
-	  hardware will lose register context on CPU power down (e.g. CPUIdle).
-	  An example of where this may be needed are systems which contain a
-	  coresight component and CPU in the same power domain. When the CPU
-	  powers down the coresight component also powers down and loses its
-	  context. This property is currently only used for the ETM 4.x driver.
-
-* Optional properties for ETM/PTMs:
-
-	* arm,cp14: must be present if the system accesses ETM/PTM management
-	  registers via co-processor 14.
-
-	* qcom,skip-power-up: boolean. Indicates that an implementation can
-	  skip powering up the trace unit. TRCPDCR.PU does not have to be set
-	  on Qualcomm Technologies Inc. systems since ETMs are in the same power
-	  domain as their CPU cores. This property is required to identify such
-	  systems with hardware errata where the CPU watchdog counter is stopped
-	  when TRCPDCR.PU is set.
-
-* Optional property for TMC:
-
-	* arm,buffer-size: size of contiguous buffer space for TMC ETR
-	  (embedded trace router). This property is obsolete. The buffer size
-	  can be configured dynamically via buffer_size property in sysfs.
-
-	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
-	  use the SG mode on this system.
-
-	* arm,max-burst-size: The maximum burst size initiated by TMC on the
-	  AXI master interface. The burst size can be in the range [0..15],
-	  the setting supports one data transfer per burst up to a maximum of
-	  16 data transfers per burst.
-
-* Optional property for CATU :
-	* interrupts : Exactly one SPI may be listed for reporting the address
-	  error
-
-* Optional property for configurable replicators:
-
-	* qcom,replicator-loses-context: boolean. Indicates that the replicator
-	  will lose register context when AMBA clock is removed which is observed
-	  in some replicator designs.
-
-Graph bindings for Coresight
--------------------------------
-
-Coresight components are interconnected to create a data path for the flow of
-trace data generated from the "sources" to their collection points "sink".
-Each coresight component must describe the "input" and "output" connections.
-The connections must be described via generic DT graph bindings as described
-by the "bindings/graph.txt", where each "port" along with an "endpoint"
-component represents a hardware port and the connection.
-
- * All output ports must be listed inside a child node named "out-ports"
- * All input ports must be listed inside a child node named "in-ports".
- * Port address must match the hardware port number.
-
-Example:
-
-1. Sinks
-	etb@20010000 {
-		compatible = "arm,coresight-etb10", "arm,primecell";
-		reg = <0 0x20010000 0 0x1000>;
-
-		clocks = <&oscclk6a>;
-		clock-names = "apb_pclk";
-		in-ports {
-			port {
-				etb_in_port: endpoint@0 {
-					remote-endpoint = <&replicator_out_port0>;
-				};
-			};
-		};
-	};
-
-	tpiu@20030000 {
-		compatible = "arm,coresight-tpiu", "arm,primecell";
-		reg = <0 0x20030000 0 0x1000>;
-
-		clocks = <&oscclk6a>;
-		clock-names = "apb_pclk";
-		in-ports {
-			port {
-				tpiu_in_port: endpoint@0 {
-					remote-endpoint = <&replicator_out_port1>;
-				};
-			};
-		};
-	};
-
-	etr@20070000 {
-		compatible = "arm,coresight-tmc", "arm,primecell";
-		reg = <0 0x20070000 0 0x1000>;
-
-		clocks = <&oscclk6a>;
-		clock-names = "apb_pclk";
-		in-ports {
-			port {
-				etr_in_port: endpoint {
-					remote-endpoint = <&replicator2_out_port0>;
-				};
-			};
-		};
-
-		out-ports {
-			port {
-				etr_out_port: endpoint {
-					remote-endpoint = <&catu_in_port>;
-				};
-			};
-		};
-	};
-
-2. Links
-	replicator {
-		/* non-configurable replicators don't show up on the
-		 * AMBA bus.  As such no need to add "arm,primecell".
-		 */
-		compatible = "arm,coresight-static-replicator";
-
-		out-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* replicator output ports */
-			port@0 {
-				reg = <0>;
-				replicator_out_port0: endpoint {
-					remote-endpoint = <&etb_in_port>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-				replicator_out_port1: endpoint {
-					remote-endpoint = <&tpiu_in_port>;
-				};
-			};
-		};
-
-		in-ports {
-			port {
-				replicator_in_port0: endpoint {
-					remote-endpoint = <&funnel_out_port0>;
-				};
-			};
-		};
-	};
-
-	funnel {
-		/*
-		 * non-configurable funnel don't show up on the AMBA
-		 * bus.  As such no need to add "arm,primecell".
-		 */
-		compatible = "arm,coresight-static-funnel";
-		clocks = <&crg_ctrl HI3660_PCLK>;
-		clock-names = "apb_pclk";
-
-		out-ports {
-			port {
-				combo_funnel_out: endpoint {
-					remote-endpoint = <&top_funnel_in>;
-				};
-			};
-		};
-
-		in-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				combo_funnel_in0: endpoint {
-					remote-endpoint = <&cluster0_etf_out>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-				combo_funnel_in1: endpoint {
-					remote-endpoint = <&cluster1_etf_out>;
-				};
-			};
-		};
-	};
-
-	funnel@20040000 {
-		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
-		reg = <0 0x20040000 0 0x1000>;
-
-		clocks = <&oscclk6a>;
-		clock-names = "apb_pclk";
-		out-ports {
-			port {
-				funnel_out_port0: endpoint {
-					remote-endpoint =
-							<&replicator_in_port0>;
-				};
-			};
-		};
-
-		in-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				funnel_in_port0: endpoint {
-					remote-endpoint = <&ptm0_out_port>;
-				};
-			};
-
-			port@1 {
-				reg = <1>;
-				funnel_in_port1: endpoint {
-					remote-endpoint = <&ptm1_out_port>;
-				};
-			};
-
-			port@2 {
-				reg = <2>;
-				funnel_in_port2: endpoint {
-					remote-endpoint = <&etm0_out_port>;
-				};
-			};
-
-		};
-	};
-
-3. Sources
-	ptm@2201c000 {
-		compatible = "arm,coresight-etm3x", "arm,primecell";
-		reg = <0 0x2201c000 0 0x1000>;
-
-		cpu = <&cpu0>;
-		clocks = <&oscclk6a>;
-		clock-names = "apb_pclk";
-		out-ports {
-			port {
-				ptm0_out_port: endpoint {
-					remote-endpoint = <&funnel_in_port0>;
-				};
-			};
-		};
-	};
-
-	ptm@2201d000 {
-		compatible = "arm,coresight-etm3x", "arm,primecell";
-		reg = <0 0x2201d000 0 0x1000>;
-
-		cpu = <&cpu1>;
-		clocks = <&oscclk6a>;
-		clock-names = "apb_pclk";
-		out-ports {
-			port {
-				ptm1_out_port: endpoint {
-					remote-endpoint = <&funnel_in_port1>;
-				};
-			};
-		};
-	};
-
-4. STM
-	stm@20100000 {
-		compatible = "arm,coresight-stm", "arm,primecell";
-		reg = <0 0x20100000 0 0x1000>,
-		      <0 0x28000000 0 0x180000>;
-		reg-names = "stm-base", "stm-stimulus-base";
-
-		clocks = <&soc_smc50mhz>;
-		clock-names = "apb_pclk";
-		out-ports {
-			port {
-				stm_out_port: endpoint {
-					remote-endpoint = <&main_funnel_in_port2>;
-				};
-			};
-		};
-	};
-
-5. CATU
-
-	catu@207e0000 {
-		compatible = "arm,coresight-catu", "arm,primecell";
-		reg = <0 0x207e0000 0 0x1000>;
-
-		clocks = <&oscclk6a>;
-		clock-names = "apb_pclk";
-
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-		in-ports {
-			port {
-				catu_in_port: endpoint {
-					remote-endpoint = <&etr_out_port>;
-				};
-			};
-		};
-	};
-
-[1]. There is currently two version of STM: STM32 and STM500.  Both
-have the same HW interface and as such don't need an explicit binding name.
diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index a15571d96cc8..529b7c80e6f3 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -130,7 +130,7 @@ Misc:
 Device Tree Bindings
 --------------------
 
-See Documentation/devicetree/bindings/arm/coresight.txt for details.
+See Documentation/devicetree/bindings/arm/arm,coresight-*.yaml for details.
 
 As of this writing drivers for ITM, STMs and CTIs are not provided but are
 expected to be added as the solution matures.
diff --git a/MAINTAINERS b/MAINTAINERS
index abfdc62abf98..ac2e7163ab14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1972,8 +1972,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
-F:	Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
-F:	Documentation/devicetree/bindings/arm/coresight.txt
+F:	Documentation/devicetree/bindings/arm/arm,coresight-*.yaml
 F:	Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
 F:	Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
 F:	Documentation/trace/coresight/*
-- 
2.34.1

