Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07E4CAE4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbiCBTKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242298AbiCBTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:10:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F6CA0F8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:09:45 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2020A3F609
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646248184;
        bh=WFYOXtt9pED7Md3w69qXaTq44oOJ0ADXDZapjGJ37mA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wYUrEwsjCUt6tgi2YlXzs25vJ4SJ6BdvxBvpSBUJkYDI+2mTFo2EguUvwPGSWC7hO
         cTRPKIhgP3w7qTMHJh4/iq2QQnfSsemYamhulvxzrhps2adTDNbo7Mk9vIAN0bMC7D
         1+0oAbUnUr9y2kj47EOKFeCw1dKJzxwhGFMtBBOyTqe1IjxHK9JacsgtZg++dQ10ji
         XPWZk+1/lIdx/CMJ+1VIcshxouO1HJd2FaYYLbd7UwBWDd3ZRa0TewhNfRbOssNFtm
         xrXTZsWBeoDcWCpao6Stdiy4VTS+IGHZQETro6lVYcqBnjXrX0LUhJVft+b542Y0G6
         i3NwBpaGeO+ag==
Received: by mail-ej1-f72.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso1466188ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFYOXtt9pED7Md3w69qXaTq44oOJ0ADXDZapjGJ37mA=;
        b=Mzdr8OqczvhkG0j79u1Py+G9D/skoZE8XE8yqxAk0gjzKjY12MHlnaBfB6ndQPFu1M
         18MA/0bMsjalQYayK1xnF6IP2r9PEnDDMwP/0UgqJDMN6HI3TIhOrUbo/grfXWfI5/H3
         zlZnaNVV561Hjh/C4XY8oUB0bR5RKtkMZjYkewIH7vJGBrxz2u3U8JYltpIcieRkobVC
         jbgu+Hv6pCmhBR0IAf1kDCrIkVM5VJ2f6y26LD8Myvja0mTeByKLm85a2dZkIeKOhCz8
         2rPJtBsWLKzqAQloV356wCOPiDEJ/v2aQPNAhKJAgh8UTVFj0VIq5o+MLlyNZaKzTsWX
         Uhfw==
X-Gm-Message-State: AOAM531hLVJvNoyUxfMOdU+gXUKjCg4qLiF88H4ZYa3hI3uytiKKS4aw
        58ls0K13VJn0fDQkIF81OlQHcYuZqztM7ZYeWi5ZeyLp6SMM3b9ivyqkVVuLXCVSisdWKTmxS8E
        cLu2y4j6sy/1UkhUEzeH4OcErS3by+JiCsLVk1xO37Q==
X-Received: by 2002:a05:6402:26c1:b0:412:8942:64a3 with SMTP id x1-20020a05640226c100b00412894264a3mr30774869edd.1.1646248183620;
        Wed, 02 Mar 2022 11:09:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoklmMKNHtJPsg1EFJJcOrrgUfuFjPLq1ALp547n1+JEqDuZaFh3NA3GvphfJApxkirIYcHg==
X-Received: by 2002:a05:6402:26c1:b0:412:8942:64a3 with SMTP id x1-20020a05640226c100b00412894264a3mr30774848edd.1.1646248183343;
        Wed, 02 Mar 2022 11:09:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7db89000000b0041372781e69sm8216383edt.52.2022.03.02.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:09:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: usb: samsung,exynos-dwc3: convert to dtschema
Date:   Wed,  2 Mar 2022 20:09:37 +0100
Message-Id: <20220302190938.6195-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220302190938.6195-1-krzysztof.kozlowski@canonical.com>
References: <20220302190938.6195-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung Exynos SoC USB 3.0 DWC3 Controller bindings to DT
schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/exynos-usb.txt    |  49 -------
 .../bindings/usb/samsung,exynos-dwc3.yaml     | 129 ++++++++++++++++++
 2 files changed, 129 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
index f7ae79825d7d..61c03c0ef19f 100644
--- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
+++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
@@ -64,52 +64,3 @@ Example:
 		phys = <&usb2phy 1>;
 		phy-names = "host";
 	};
-
-DWC3
-Required properties:
- - compatible: should be one of the following -
-	       "samsung,exynos5250-dwusb3": for USB 3.0 DWC3 controller on
-					    Exynos5250/5420.
-	       "samsung,exynos5433-dwusb3": for USB 3.0 DWC3 controller on
-					    Exynos5433.
-	       "samsung,exynos7-dwusb3": for USB 3.0 DWC3 controller on Exynos7.
- - #address-cells, #size-cells : should be '1' if the device has sub-nodes
-				 with 'reg' property.
- - ranges: allows valid 1:1 translation between child's address space and
-	   parent's address space
- - clocks: Clock IDs array as required by the controller.
- - clock-names: Names of clocks corresponding to IDs in the clock property.
-                Following clock names shall be provided for different
-                compatibles:
-                 - samsung,exynos5250-dwusb3: "usbdrd30",
-                 - samsung,exynos5433-dwusb3: "aclk", "susp_clk", "pipe_pclk",
-                                              "phyclk",
-                 - samsung,exynos7-dwusb3: "usbdrd30", "usbdrd30_susp_clk",
-                                           "usbdrd30_axius_clk"
- - vdd10-supply: 1.0V powr supply
- - vdd33-supply: 3.0V/3.3V power supply
-
-Sub-nodes:
-The dwc3 core should be added as subnode to Exynos dwc3 glue.
-- dwc3 :
-   The binding details of dwc3 can be found in:
-   Documentation/devicetree/bindings/usb/snps,dwc3.yaml
-
-Example:
-	usb@12000000 {
-		compatible = "samsung,exynos5250-dwusb3";
-		clocks = <&clock 286>;
-		clock-names = "usbdrd30";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		vdd10-supply = <&ldo11_reg>;
-		vdd33-supply = <&ldo9_reg>;
-
-		dwc3 {
-			compatible = "synopsys,dwc3";
-			reg = <0x12000000 0x10000>;
-			interrupts = <0 72 0>;
-			usb-phy = <&usb2_phy &usb3_phy>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
new file mode 100644
index 000000000000..22b91a27d776
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/samsung,exynos-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC USB 3.0 DWC3 Controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos5250-dwusb3
+      - samsung,exynos5433-dwusb3
+      - samsung,exynos7-dwusb3
+
+  '#address-cells':
+    const: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+  ranges: true
+
+  '#size-cells':
+    const: 1
+
+  vdd10-supply:
+    description: 1.0V power supply
+
+  vdd33-supply:
+    description: 3.0V/3.3V power supply
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+    description: Required child node
+
+required:
+  - compatible
+  - '#address-cells'
+  - clocks
+  - clock-names
+  - ranges
+  - '#size-cells'
+  - vdd10-supply
+  - vdd33-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5250-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: usbdrd30
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos54333-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aclk
+            - const: susp_clk
+            - const: pipe_pclk
+            - const: phyclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7-dwusb3
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: usbdrd30
+            - const: usbdrd30_susp_clk
+            - const: usbdrd30_axius_clk
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb {
+        compatible = "samsung,exynos5250-dwusb3";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+        clocks = <&clock CLK_USBD300>;
+        clock-names = "usbdrd30";
+        vdd33-supply = <&ldo9_reg>;
+        vdd10-supply = <&ldo11_reg>;
+
+        usb@12000000 {
+            compatible = "snps,dwc3";
+            reg = <0x12000000 0x10000>;
+            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+            phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
+            phy-names = "usb2-phy", "usb3-phy";
+            snps,dis_u3_susphy_quirk;
+        };
+    };
-- 
2.32.0

