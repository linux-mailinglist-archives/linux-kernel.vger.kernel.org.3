Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E3473188
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbhLMQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbhLMQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:21:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBBC061748;
        Mon, 13 Dec 2021 08:21:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j3so28033668wrp.1;
        Mon, 13 Dec 2021 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W7JmkqZL6057xB+2JLQou2ueul7D5IPkF6eo9BZR3W8=;
        b=ZWJeYg6H5CQ05AQdKZdOrLJf/x4E7xmNU3f6x7ZHHi4gtTZ67KB9hW5+idOEku2Wx/
         NvgrDblHIv5lPQsUPoxpbjLgjE0H+N34yocg0QpRLppZpcWnUh0Uk4KNH1R13fPR7/L8
         SUvH2fRFsic5In8HITqQNOXPLB8Wtolhd8/9dGMd0qYp5J4DaY0Q7dZGXBv8DQS31gtO
         7ep1pYJuHgoI41zHqKa11Nfs02jytqG7hVIxVnvvOehbMsgMc2jGMD6TSvZyCMg/YAG7
         JcHMsn9mGAjMHKqSQmVYLSNIOMTW8KPFTUl9lrhKKvxXCEJeGXVbtIjlp092ryPQ1jDU
         PXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W7JmkqZL6057xB+2JLQou2ueul7D5IPkF6eo9BZR3W8=;
        b=b79vRGo4FgOXhThv2GxJs4EVjOrInW8OntHQDmL8ikhJiMOvD+LxDYEz1WVvT8/M33
         MOOMSUweOKLpSmdw8ShKTCL7bqZ9getU8GNGPk5RoAH5c2LwPGf/RDtHztP6kRqBjtl6
         4SSQc5zPgEfX68disN2hwd7XXvZtR8bHTPkMkjaJ4ihgKBfTQ9Fo4USuRRZuc3KDeWP6
         D4WrF9BYAikNcgGxsj70qs3DJM5uYDW6O5re/7fSRZMmvbSwIx4X2fMgUvbltmIYev8Z
         6ftNPf2l7ktFJiARmDHrN+XOU6uEmkZYkj8Go9oke8rcaFYCrw8ihhySSKG9kyG52Tcv
         2yZA==
X-Gm-Message-State: AOAM5308Cz2XR+/NaCJLAbPmwZPhzmylYfBo4aJlOn5zOK7HJ5zN/pxM
        kS2ai+WBmncey1zSou2mJPU=
X-Google-Smtp-Source: ABdhPJxs4ol0LLfMU0sl2h/zs18Eqsv79Fhhsy3/vOxMKxgGOuDoR5KkuqG5AMEh9JesICnEV2OVRA==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr32521017wrc.67.1639412516717;
        Mon, 13 Dec 2021 08:21:56 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id k13sm11109580wri.6.2021.12.13.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:21:55 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: memory: tegra: Update for Tegra194
Date:   Mon, 13 Dec 2021 17:21:46 +0100
Message-Id: <20211213162151.916523-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213162151.916523-1-thierry.reding@gmail.com>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The #interconnect-cells properties are required to hook up memory
clients to the MC/EMC in interconnects properties. Add a description for
these properties.

For the nested EMC controller, the list of required properties was
missing. Add it so that the validation can be more strict.

Also, allow multiple reg entries required by Tegra194 and later.

While at it, also remove the dummy BPMP node from the example because it
is incomplete and fails validation. It's also not necessary for this
file and the BPMP DT schema already has a full example.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- reword commit message to reflect changes in v2

Changes in v2:
- drop incomplete BPMP snippet from example
- explicitly set minItems for reg property
- describe MC and EMC general interrupts
- add required properties for EMC

 .../nvidia,tegra186-mc.yaml                   | 78 ++++++++++++++++---
 1 file changed, 67 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 611bda38d187..b496564b1bdf 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -33,10 +33,12 @@ properties:
           - nvidia,tegra194-mc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   interrupts:
-    maxItems: 1
+    items:
+      - description: MC general interrupt
 
   "#address-cells":
     const: 2
@@ -48,6 +50,9 @@ properties:
 
   dma-ranges: true
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^external-memory-controller@[0-9a-f]+$":
     description:
@@ -65,10 +70,12 @@ patternProperties:
               - nvidia,tegra194-emc
 
       reg:
-        maxItems: 1
+        minItems: 1
+        maxItems: 2
 
       interrupts:
-        maxItems: 1
+        items:
+          - description: EMC general interrupt
 
       clocks:
         items:
@@ -78,11 +85,65 @@ patternProperties:
         items:
           - const: emc
 
+      "#interconnect-cells":
+        const: 0
+
       nvidia,bpmp:
         $ref: /schemas/types.yaml#/definitions/phandle
         description:
           phandle of the node representing the BPMP
 
+    allOf:
+      - if:
+          properties:
+            compatible:
+              const: nvidia,tegra186-emc
+        then:
+          properties:
+            reg:
+              maxItems: 1
+
+      - if:
+          properties:
+            compatible:
+              const: nvidia,tegra194-emc
+        then:
+          properties:
+            reg:
+              minItems: 2
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - clocks
+      - clock-names
+      - "#interconnect-cells"
+      - nvidia,bpmp
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra186-mc
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra194-mc
+    then:
+      properties:
+        reg:
+          minItems: 3
+
+additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -90,8 +151,6 @@ required:
   - "#address-cells"
   - "#size-cells"
 
-additionalProperties: false
-
 examples:
   - |
     #include <dt-bindings/clock/tegra186-clock.h>
@@ -124,12 +183,9 @@ examples:
                 clocks = <&bpmp TEGRA186_CLK_EMC>;
                 clock-names = "emc";
 
+                #interconnect-cells = <0>;
+
                 nvidia,bpmp = <&bpmp>;
             };
         };
     };
-
-    bpmp: bpmp {
-        compatible = "nvidia,tegra186-bpmp";
-        #clock-cells = <1>;
-    };
-- 
2.34.1

