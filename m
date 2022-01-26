Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44E49CF13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiAZQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiAZQAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:00:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:00:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e2so11200343wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckaniTJrXjFPNb9ajEebiXyBklsXtwYbMy6SavKwAPM=;
        b=u9eCTlZ3WjziSPAVIm0Ax4tRzo2FcWclSJjBo/KTgbOPEK7FgC4dhT6UeXxfefSq7W
         4MLT64OHLOE1LDLFxA2+WNQ6p+nx+3M9IZhe3UemH3Nz8LGfIYGvKNxQWQFn+xs6Ssc/
         TiBAVP15NBUMyXEmqAHSSRh34Og8zzlbu74MBPSB4YC91AtLUXayH/x9svmGNAV3cddC
         /CSirsz73Lm9LvINd56Dy8qSOjd9HX9DxgEqJ/qwvmzVhS9y4k9vcm1L+96DozIsqLRH
         qZI8jVyDZ6xRFeVFZo3IOPtgZFxs/cmyhCEU7FbUkQZrAHAYqFux8vw4MdE8tY3lH3De
         Vb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckaniTJrXjFPNb9ajEebiXyBklsXtwYbMy6SavKwAPM=;
        b=t3rXepQpgz2IP+mHsxRQKUiFPWEQYswoA3rDZTqiwvuUK1c+Jo3n72RbIfESbQtW47
         NOY+k6qTV/H9Fegaa0RgWo/PbRxXzxBzByUg36WEITeRdPhOlshLGlMp3q1v5lY/SjbQ
         uym+wpbAbq1KaX6wqbrPemqgIaYzoocQzvCndN7e5X6oTFt6EtjH+ejJ7grt3ox5oHbs
         HyW4MVC6Sxz6Pt7mDb5JuH2ctKUPvry31HRA68We+ZqlpqP3QCkrjitgfezOKj1SH6qt
         QB6z+AecVfNCH6sSPBNZN0lk9B0ytt3x90Z5XXPMBlQKIAQjsXDS/CINXJ8uJ0lW3UEP
         Bgng==
X-Gm-Message-State: AOAM532J6wQYYBUx3QQ2qiRu4FU+JCBJEAhi0mHV24+0LpWQ8/0YcxSu
        SASVs60WbOZkPx/AqstQJ4eWCg==
X-Google-Smtp-Source: ABdhPJwcNs2MkAUvk6cLg4u2AE64qp2yxfqutljtC9X6uhKZNMfN7AsTKpM9jVCR1Hj5VkwWMQLT8A==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr23694666wrq.68.1643212832009;
        Wed, 26 Jan 2022 08:00:32 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id u3sm10253128wrs.55.2022.01.26.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:00:30 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     daniel.lezcano@linaro.org, robh+dt@kernel.org, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] dt-bindings: timer: Convert faraday,fttmr010 to yaml
Date:   Wed, 26 Jan 2022 16:00:21 +0000
Message-Id: <20220126160021.3537591-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts timer/faraday,fttmr010.txt to yaml.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- added moxart example
- relaxed some contraints as driver only support one clock and one
  interrupt (as used by moxa,moxart-timer)

 .../bindings/timer/faraday,fttmr010.txt       | 38 --------
 .../bindings/timer/faraday,fttmr010.yaml      | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
 create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
deleted file mode 100644
index 3cb2f4c98d64..000000000000
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Faraday Technology timer
-
-This timer is a generic IP block from Faraday Technology, embedded in the
-Cortina Systems Gemini SoCs and other designs.
-
-Required properties:
-
-- compatible : Must be one of
-  "faraday,fttmr010"
-  "cortina,gemini-timer", "faraday,fttmr010"
-  "moxa,moxart-timer", "faraday,fttmr010"
-  "aspeed,ast2400-timer"
-  "aspeed,ast2500-timer"
-  "aspeed,ast2600-timer"
-
-- reg : Should contain registers location and length
-- interrupts : Should contain the three timer interrupts usually with
-  flags for falling edge
-
-Optionally required properties:
-
-- clocks : a clock to provide the tick rate for "faraday,fttmr010"
-- clock-names : should be "EXTCLK" and "PCLK" for the external tick timer
-  and peripheral clock respectively, for "faraday,fttmr010"
-- syscon : a phandle to the global Gemini system controller if the compatible
-  type is "cortina,gemini-timer"
-
-Example:
-
-timer@43000000 {
-	compatible = "faraday,fttmr010";
-	reg = <0x43000000 0x1000>;
-	interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
-		   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
-		   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
-	clocks = <&extclk>, <&pclk>;
-	clock-names = "EXTCLK", "PCLK";
-};
diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
new file mode 100644
index 000000000000..db9fb171ea49
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/faraday,fttmr010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology timer
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  This timer is a generic IP block from Faraday Technology, embedded in the
+  Cortina Systems Gemini SoCs and other designs.
+
+properties:
+  compatible:
+    oneOf:
+      - const: faraday,fttmr010
+      - items:
+          - const: cortina,gemini-timer
+          - const: faraday,fttmr010
+      - items:
+          - const: moxa,moxart-timer
+          - const: faraday,fttmr010
+      - const: aspeed,ast2400-timer
+      - const: aspeed,ast2500-timer
+      - const: aspeed,ast2600-timer
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    description: Should contain the three timer interrupts usually with flags for falling edge
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: "PCLK"
+      - const: "EXTCLK"
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    /* taken from arch/arm/boot/dts/gemini.dtsi */
+    timer@43000000 {
+      compatible = "faraday,fttmr010";
+      reg = <0x43000000 0x1000>;
+      interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
+                   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
+                   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
+      clocks = <&extclk>, <&pclk>;
+      clock-names = "PCLK", "EXTCLK";
+      syscon = <&syscon>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    /* taken from arch/arm/boot/dts/moxart.dtsi */
+    timer: timer@98400000 {
+      compatible = "moxa,moxart-timer", "faraday,fttmr010";
+      reg = <0x98400000 0x42>;
+      interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+      clocks = <&clk_apb>;
+      clock-names = "PCLK";
+    };
+...
-- 
2.34.1

