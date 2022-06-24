Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4A559E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiFXQWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFXQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:22:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6595676B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:22:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u12so5697531eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYS0kphQrUZ27SsnoM13mR7jUP14ty0cByxPu8gKCIk=;
        b=HK2uiyivhaPV5sfrvS2eGOt2LyWTJ9bq/nz9CbzFAb9pqnfFA/3Mpv84tZvVkt9Y6I
         TgyDmNC2oSoOterV7IY5A11r+FuseW87b7DEgpppipalbbtb8aCNOSgmHtHtroDNgDFx
         UrPqyFDiP6jKRWSum/SpoIAC8QKM+DG7NZFKHAJfZGxeWVM6HWTuLWazrbh2P9eH0pUR
         K3nbumuEwRDn75h+zk1dkM891/+Ns2Xy0CDYDWozDH/0ZimvDnHpXbP95Dm6/m79Lrey
         jfoAOLeS5OD38UZYwbU5Vz2ndbNQNn0ZQ9UwyXw4Z9nyk1QtYT8ZnJI12viXpH0NzTaK
         mpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYS0kphQrUZ27SsnoM13mR7jUP14ty0cByxPu8gKCIk=;
        b=RZ2QCsIKjxBkPKThi3XsMhY90Z4IB9oep53LL8h5BFQiqVn3Wb0cR1HolroH0N4PWo
         Ad0t2gzoX/azXUeljUT6+AFrn2Ck1LTiXMdtm1dIQvlQoyb4SaDMlpTtMlGpIjyDF1Fb
         2j2lysgzzGECkOYytfJNrr7TdVGscZtPBPZQtM7il4VlKNoHuh/N8GjpkIX6rGiHoa0l
         tpTmeiY+ppPizbU3UJXkuZBQ3bhXq2tZGanQ5xdE0XDGm0j34kA9IUAEcPrLSI21m71V
         EKtgZsTG98+mD9TBpwyrSRsvuGlv2XVo9q3sGW5hgNiyc7hLz0ANDp4+G5ZqoAXyqJBu
         vCIw==
X-Gm-Message-State: AJIora9fTWotI8TTIjTMEwSxdvwFwy4UeTLW+3ryYOIsCx7KwN6cRwMY
        eNvvg4kOVGbN8HJVIZq9rFP9sA==
X-Google-Smtp-Source: AGRyM1t8apVUwtpqK9f+AuB+xavgZYcKt4ycH9bTdkv7323dillMym7El0pwbvAK1Xm7gEEODxChVw==
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id hr1-20020a1709073f8100b006ff1a3d9092mr14128573ejc.319.1656087721147;
        Fri, 24 Jun 2022 09:22:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ia10-20020a170907a06a00b0070b7875aa6asm1334374ejc.166.2022.06.24.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:22:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: connector: usb: align example indentation to four-space
Date:   Fri, 24 Jun 2022 18:21:41 +0200
Message-Id: <20220624162141.25890-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One DTS example was using 8-space indentation, while others 2-space.
For complex DTS with multiple levels, 2-space is not that readable and
in DTS examples 4-space is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/connector/usb-connector.yaml     | 152 +++++++++---------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 0420fa563532..ae515651fc6b 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -263,11 +263,11 @@ examples:
   # Micro-USB connector with HS lines routed via controller (MUIC).
   - |
     muic-max77843 {
-      usb_con1: connector {
-        compatible = "usb-b-connector";
-        label = "micro-USB";
-        type = "micro";
-      };
+        usb_con1: connector {
+            compatible = "usb-b-connector";
+            label = "micro-USB";
+            type = "micro";
+        };
     };
 
   # USB-C connector attached to CC controller (s2mm005), HS lines routed
@@ -275,34 +275,34 @@ examples:
   # DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
   - |
     ccic: s2mm005 {
-      usb_con2: connector {
-        compatible = "usb-c-connector";
-        label = "USB-C";
+        usb_con2: connector {
+            compatible = "usb-c-connector";
+            label = "USB-C";
 
-        ports {
-          #address-cells = <1>;
-          #size-cells = <0>;
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
 
-          port@0 {
-            reg = <0>;
-            usb_con_hs: endpoint {
-              remote-endpoint = <&max77865_usbc_hs>;
-            };
-          };
-          port@1 {
-            reg = <1>;
-            usb_con_ss: endpoint {
-              remote-endpoint = <&usbdrd_phy_ss>;
-            };
-          };
-          port@2 {
-            reg = <2>;
-            usb_con_sbu: endpoint {
-              remote-endpoint = <&dp_aux>;
+                port@0 {
+                    reg = <0>;
+                    usb_con_hs: endpoint {
+                        remote-endpoint = <&max77865_usbc_hs>;
+                    };
+                };
+                port@1 {
+                    reg = <1>;
+                    usb_con_ss: endpoint {
+                        remote-endpoint = <&usbdrd_phy_ss>;
+                    };
+                };
+                port@2 {
+                    reg = <2>;
+                    usb_con_sbu: endpoint {
+                        remote-endpoint = <&dp_aux>;
+                    };
+                };
             };
-          };
         };
-      };
     };
 
   # USB-C connector attached to a typec port controller(ptn5110), which has
@@ -310,16 +310,16 @@ examples:
   - |
     #include <dt-bindings/usb/pd.h>
     typec: ptn5110 {
-      usb_con3: connector {
-        compatible = "usb-c-connector";
-        label = "USB-C";
-        power-role = "dual";
-        try-power-role = "sink";
-        source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
-        sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
-                     PDO_VAR(5000, 12000, 2000)>;
-        op-sink-microwatt = <10000000>;
-      };
+        usb_con3: connector {
+            compatible = "usb-c-connector";
+            label = "USB-C";
+            power-role = "dual";
+            try-power-role = "sink";
+            source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+            sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
+                         PDO_VAR(5000, 12000, 2000)>;
+            op-sink-microwatt = <10000000>;
+        };
     };
 
   # USB-C connector attached to SoC and USB3 typec port controller(hd3ss3220)
@@ -332,20 +332,20 @@ examples:
         data-role = "dual";
 
         ports {
-                #address-cells = <1>;
-                #size-cells = <0>;
-                port@0 {
-                        reg = <0>;
-                        hs_ep: endpoint {
-                                remote-endpoint = <&usb3_hs_ep>;
-                        };
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                hs_ep: endpoint {
+                    remote-endpoint = <&usb3_hs_ep>;
                 };
-                port@1 {
-                        reg = <1>;
-                        ss_ep: endpoint {
-                                remote-endpoint = <&hd3ss3220_in_ep>;
-                        };
+            };
+            port@1 {
+                reg = <1>;
+                ss_ep: endpoint {
+                    remote-endpoint = <&hd3ss3220_in_ep>;
                 };
+            };
         };
     };
 
@@ -354,12 +354,12 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
 
     usb {
-      connector {
-        compatible = "gpio-usb-b-connector", "usb-b-connector";
-        type = "micro";
-        id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
-        vbus-supply = <&usb_p0_vbus>;
-      };
+        connector {
+            compatible = "gpio-usb-b-connector", "usb-b-connector";
+            type = "micro";
+            id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
+            vbus-supply = <&usb_p0_vbus>;
+        };
     };
 
   # Micro-USB connector with HS lines routed via controller (MUIC) and MHL
@@ -367,27 +367,27 @@ examples:
   # mobile phone
   - |
     muic-max77843 {
-      usb_con4: connector {
-        compatible = "samsung,usb-connector-11pin", "usb-b-connector";
-        label = "micro-USB";
-        type = "micro";
+        usb_con4: connector {
+            compatible = "samsung,usb-connector-11pin", "usb-b-connector";
+            label = "micro-USB";
+            type = "micro";
 
-        ports {
-          #address-cells = <1>;
-          #size-cells = <0>;
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
 
-          port@0 {
-            reg = <0>;
-            muic_to_usb: endpoint {
-              remote-endpoint = <&usb_to_muic>;
-            };
-          };
-          port@3 {
-            reg = <3>;
-            usb_con_mhl: endpoint {
-              remote-endpoint = <&sii8620_mhl>;
+                port@0 {
+                    reg = <0>;
+                    muic_to_usb: endpoint {
+                        remote-endpoint = <&usb_to_muic>;
+                    };
+                };
+                port@3 {
+                    reg = <3>;
+                    usb_con_mhl: endpoint {
+                        remote-endpoint = <&sii8620_mhl>;
+                    };
+                };
             };
-          };
         };
-      };
     };
-- 
2.34.1

