Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A664CE617
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiCEQyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiCEQyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:54:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4064D40914;
        Sat,  5 Mar 2022 08:53:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c19so4707942ede.8;
        Sat, 05 Mar 2022 08:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GARCkxgiyMRjl3V6/FiJ6/g+bqmKHGIILslZSNmkwfA=;
        b=CxMvg7t+QzNo8qSLUxd9WqaQf1EfyJlmGoW0EN75IohMcxJ5YbxNgtgS1uFWOLGg+S
         3VIkJDTc8t6KYe+qfXjY0/NVvFCMIpKZkak0411IxIFsWN1UW+C/ojdb1O/Lh/ygLf5u
         sBCyk8wiT38A/y7dGAupbUCkwCbwcuVwPook+xm5s1JP0Wgf9zvATODjrga/AbGPZ/0t
         5NGXhCKLtmqGzl1GgDSGPVf1Mt2rlZD5f7MiZVnZBqYpuz7gk7UKEbOyZnjh8Bo9QSUb
         joKqRf9h8RwRbT7bVku9oO9Swe1JRduoubESnDWtTAfMpI1ei+knvNsArMdTRsRvH5hh
         9ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GARCkxgiyMRjl3V6/FiJ6/g+bqmKHGIILslZSNmkwfA=;
        b=BogI7EpKPJ2lZOjT5DqImXzP+EBATffjmPTK0pl5PVzcIq517/RwO6eKZBEWDm9PWZ
         azi2s4jNyRkj/aZU9WQ3lOPilNV1bM7U+8dPPvEKSt7YVOSU7uLNl935enU9XSP0f4HM
         uDvL+fOFTQxjZJfVPsns6scsP78KGIkBoG/50vH6vBRORIOkyJCZM6cPQZgWYgZpS+F3
         q8cxdj+YZPwq3qzvqy4OAguZfuly6+MzRf2q808/BMMlrqVd62A9EZ8QBUwm7n//ELti
         xtAD+fOTJ8YIDO+pQjwvvf5OUiPgFWrhzNyyQSSB1Sni5y4Ly7w5AL4hC/gAbUfVzqDg
         4D0A==
X-Gm-Message-State: AOAM532+qMvXTOTwelSjL+GdmGJvu0aTgTXXTkOV66I7/iVpCJG3uUQ2
        O+o/3hSPzZChZBDy7gwN6LWMIA6DL+a+Zw==
X-Google-Smtp-Source: ABdhPJw7/SNODPNwP4SkHtsWsm5Q7KdwB/9J+VJ0h9CXRTGkKDBA8K48SKRcPnR9E1NDpq3Ej58CfA==
X-Received: by 2002:a50:cf48:0:b0:415:df40:9e3d with SMTP id d8-20020a50cf48000000b00415df409e3dmr3546650edk.185.1646499223739;
        Sat, 05 Mar 2022 08:53:43 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id go41-20020a1709070da900b006d643bdd4d4sm2990932ejc.56.2022.03.05.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:53:43 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        jeff@labundy.com, markuss.broks@gmail.com,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, rydberg@bitmath.com,
        sfr@canb.auug.org.au, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v10 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Sat,  5 Mar 2022 18:53:29 +0200
Message-Id: <20220305165330.13061-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220305165330.13061-1-markuss.broks@gmail.com>
References: <20220305165330.13061-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device-tree bindings for the Imagis
IST3038C touch screen IC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../input/touchscreen/imagis,ist3038c.yaml    | 74 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..e3a2b871e50c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis IST30XXC family touchscreen controller bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  $nodename:
+    pattern: "^touchscreen@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - imagis,ist3038c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@50 {
+        compatible = "imagis,ist3038c";
+        reg = <0x50>;
+        interrupt-parent = <&gpio>;
+        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&ldo1_reg>;
+        vddio-supply = <&ldo2_reg>;
+        touchscreen-size-x = <720>;
+        touchscreen-size-y = <1280>;
+        touchscreen-fuzz-x = <10>;
+        touchscreen-fuzz-y = <10>;
+        touchscreen-inverted-x;
+        touchscreen-inverted-y;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 781a5795d8ff..3dca47d6f1d3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -560,6 +560,8 @@ patternProperties:
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
     description: ILI Technology Corporation (ILITEK)
+  "^imagis,.*":
+    description: Imagis Technologies Co., Ltd.
   "^img,.*":
     description: Imagination Technologies Ltd.
   "^imi,.*":
-- 
2.20.1

