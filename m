Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE9517D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiECGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiECGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:32:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C47C25C4D;
        Mon,  2 May 2022 23:29:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so13310637pgl.11;
        Mon, 02 May 2022 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ommot/0z42sf3SBGFHfrVoBq7JJGjmk6km0fRERgWs=;
        b=BBZqsvfXLQMcxnvVKu19OiXFrM/hVM4VZ+TB4sAzS++ZfbcsGgC3gaIgYi3V/CxVyI
         hTagtqcDHop40+tn6XHh1FfNWGj1H2zX197W8q7SH3W2UjSFujx/4tRPHDTBTJonNB59
         1acUkA2RmNGSJP1O2DsYwghR/BvCSDcHfrbhet3gqQjaohsHzguix3TUsxF8g5UuVNDN
         42cX0PSkBmTTHScDbzKPD4gcE3amRx4DyJ4OrQdKRsblQHnC4eplMz5oadgNU2TWSllT
         Pp8ervTrj4BAOPhqAW0uVhaHRyGYWeIwN+OPWaAZNksm0dutDNUEiCZKv8LtEObohI0k
         fxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ommot/0z42sf3SBGFHfrVoBq7JJGjmk6km0fRERgWs=;
        b=VIDwkVoHGjEpHTVTBNnUrtk32Tnygq+k1ErnVvkbFqmE7a8rbrJGJxfYNV9uTEbBbH
         MR+JmEs4FbhOrrC03wF7YAspwARdsOqJN69YbdNB9Yeyr1XAizZs+B+PmLguOB3wO3vX
         yKbgsLRg7g1OUnHzkYmxmaiSvp4umy4oYfCBOrl7W2f49V+JJTLDk+E6af3WmsmfSbZv
         1DTWkE+SR51Af1Pa4gppIQFKdjNGIM7lPNVNHQE5jMR9MeOxD5VNVzjaAZe0WBFdvUVM
         iHkOo9QTjLA7Bb3HZxl6yGmjM7CE9JuyQNIjTNXvGqE4gqW9V+07XdRJQtaese5TPqFN
         Oz7A==
X-Gm-Message-State: AOAM5309BPjoq5DKLmK2dIq8WhXq7kzSXPmBigd2gYqi3rkliZYQjuma
        X7OtS4OWcBF7NU3pJjqtfQs=
X-Google-Smtp-Source: ABdhPJwVmWB/+4ZbUnTbaekuYC8MZ5UU5EvCLiYkYU2agpKq050H3bedHlbNmKr5ciuIuhR85HqFzw==
X-Received: by 2002:a63:87c1:0:b0:3ab:1a17:35b7 with SMTP id i184-20020a6387c1000000b003ab1a1735b7mr12716214pge.313.1651559350797;
        Mon, 02 May 2022 23:29:10 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:469:f77c:e84b:f663:23:a6cf])
        by smtp.gmail.com with ESMTPSA id j14-20020a63fc0e000000b003c260491adesm1313800pgi.82.2022.05.02.23.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:29:10 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: [PATCH] dt-bindings: mfd: Add bindings child nodes for the Mediatek MT6360
Date:   Tue,  3 May 2022 14:28:43 +0800
Message-Id: <20220503062843.12516-1-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Gene Chen <gene_chen@richtek.com>

Add bindings child nodes for the Mediatek MT6360

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Link: https://lore.kernel.org/all/YmqTzlrVL5KaVPuz@robh.at.kernel.org/
---
 .../bindings/mfd/mediatek,mt6360.yaml         | 212 +++++++++++++++++-
 1 file changed, 201 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
index 4d8769f3748c..b3eecf661bc1 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
@@ -37,6 +37,18 @@ properties:
     description:
       The first cell is the IRQ number.
 
+  regulators:
+    $ref: ../regulator/mt6360-regulator.yaml
+
+  charger:
+    $ref: ../power/supply/mt6360_charger.yaml
+
+  tcpc:
+    $ref: ../usb/mediatek,mt6360-tcpc.yaml
+
+  led-controller:
+    $ref: ../leds/leds-mt6360.yaml
+
 required:
   - compatible
   - reg
@@ -51,17 +63,195 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+    #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/usb/pd.h>
     i2c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        pmic@34 {
-            compatible = "mediatek,mt6360";
-            reg = <0x34>;
-            wakeup-source;
-            interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
-            interrupt-names = "IRQB";
-            interrupt-controller;
-            #interrupt-cells = <1>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mt6360@34 {
+        compatible = "mediatek,mt6360";
+        reg = <0x34>;
+        wakeup-source;
+        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+        interrupt-names = "IRQB";
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        mt6360_charger: charger {
+          compatible = "mediatek,mt6360-chg";
+          richtek,vinovp-microvolt = <14500000>;
+
+          otg_vbus_regulator: usb-otg-vbus-regulator {
+            regulator-compatible = "usb-otg-vbus";
+            regulator-name = "usb-otg-vbus";
+            regulator-min-microvolt = <4425000>;
+            regulator-max-microvolt = <5825000>;
+          };
+        };
+
+        led-controller {
+          compatible = "mediatek,mt6360-led";
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          multi-led@0 {
+            reg = <0>;
+            function = LED_FUNCTION_INDICATOR;
+            color = <LED_COLOR_ID_RGB>;
+            led-max-microamp = <24000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            led@0 {
+              reg = <0>;
+              color = <LED_COLOR_ID_RED>;
+            };
+            led@1 {
+              reg = <1>;
+              color = <LED_COLOR_ID_GREEN>;
+            };
+            led@2 {
+              reg = <2>;
+              color = <LED_COLOR_ID_BLUE>;
+            };
+          };
+          led@3 {
+            reg = <3>;
+            function = LED_FUNCTION_INDICATOR;
+            color = <LED_COLOR_ID_WHITE>;
+            led-max-microamp = <150000>;
+          };
+          led@4 {
+            reg = <4>;
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            function-enumerator = <1>;
+            led-max-microamp = <200000>;
+            flash-max-microamp = <500000>;
+            flash-max-timeout-us = <1024000>;
+          };
+          led@5 {
+            reg = <5>;
+            function = LED_FUNCTION_FLASH;
+            color = <LED_COLOR_ID_WHITE>;
+            function-enumerator = <2>;
+            led-max-microamp = <200000>;
+            flash-max-microamp = <500000>;
+            flash-max-timeout-us = <1024000>;
+          };
+        };
+
+        regulators {
+          compatible = "mediatek,mt6360-regulator";
+          LDO_VIN3-supply = <&BUCK2>;
+          buck1 {
+            regulator-compatible = "BUCK1";
+            regulator-name = "mt6360,buck1";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1300000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP
+                 MT6360_OPMODE_ULP>;
+          };
+          BUCK2: buck2 {
+            regulator-compatible = "BUCK2";
+            regulator-name = "mt6360,buck2";
+            regulator-min-microvolt = <300000>;
+            regulator-max-microvolt = <1300000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP
+                 MT6360_OPMODE_ULP>;
+          };
+          ldo6 {
+            regulator-compatible = "LDO6";
+            regulator-name = "mt6360,ldo6";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <2100000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo7 {
+            regulator-compatible = "LDO7";
+            regulator-name = "mt6360,ldo7";
+            regulator-min-microvolt = <500000>;
+            regulator-max-microvolt = <2100000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo1 {
+            regulator-compatible = "LDO1";
+            regulator-name = "mt6360,ldo1";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+            ldo2 {
+            regulator-compatible = "LDO2";
+            regulator-name = "mt6360,ldo2";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo3 {
+            regulator-compatible = "LDO3";
+            regulator-name = "mt6360,ldo3";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
+          ldo5 {
+            regulator-compatible = "LDO5";
+            regulator-name = "mt6360,ldo5";
+            regulator-min-microvolt = <2700000>;
+            regulator-max-microvolt = <3600000>;
+            regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                 MT6360_OPMODE_LP>;
+          };
         };
+
+        tcpc {
+          compatible = "mediatek,mt6360-tcpc";
+          interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+          interrupt-names = "PD_IRQB";
+
+          connector {
+            compatible = "usb-c-connector";
+            label = "USB-C";
+            data-role = "dual";
+            power-role = "dual";
+            try-power-role = "sink";
+            source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+            op-sink-microwatt = <10000000>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                reg = <0>;
+                endpoint {
+                  remote-endpoint = <&usb_hs>;
+                };
+              };
+              port@1 {
+                reg = <1>;
+                endpoint {
+                  remote-endpoint = <&usb_ss>;
+                };
+              };
+              port@2 {
+                reg = <2>;
+                endpoint {
+                  remote-endpoint = <&dp_aux>;
+                };
+              };
+            };
+          };
+        };
+
+      };
     };
-- 
2.25.1

