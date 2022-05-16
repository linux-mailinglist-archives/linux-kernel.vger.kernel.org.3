Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA4527D80
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiEPGVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiEPGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:21:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885124941;
        Sun, 15 May 2022 23:21:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so13524724plh.1;
        Sun, 15 May 2022 23:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XQvQdTgnCwDfmHkTZtajXuRMAeapjHZEvNeUkViza8=;
        b=ZLrZuXWGhglqCmNncstz6ccn5vDYbYWzH2VkXAZA1887OQvrY9eWeB0/8UQQgwWSGB
         pVzZi6ep4Ax9nm3l099qIlairb6gML7KBNuKERwrzUYQKU5NB+Chh4uwnt1fUGD3DE0v
         UVgcdupbcev1+NvQClM6qz9BVECcYIcbIAc2jk+cxmDVvMnR1sraxFf/z4kVM62+mgmr
         YG0sv49pzekIRo8vFDi2WXwQkJUYsQ4dyp/aZReuOOSbOFLpNQgBchkiWCIzyH9ZSWww
         0vH4RNk6R8t4fh5r6JasX81Clk/MpWUx0Ft4/SLtqC8ha+FyAKf7T2imbZHL04MZ9fsN
         zzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XQvQdTgnCwDfmHkTZtajXuRMAeapjHZEvNeUkViza8=;
        b=TiYkjbFzf0VJE0I0rbxTHbIaHH1+HUt+v2P4DVvXCceS4cpx8/i1Myv3jj905fGMk3
         5f/Di7zd6/FbK7g4QsFYjnpXbNeKwihfei9+QqUUhxZEOlDCnRUpAL5oHLAsqwTuXsAN
         iFCEVAzhHFTjEXF45SAKg7wOVTUjXID6NpQlU9v79dRmX1xRjeP3qcgIcc3QBdZcwq6U
         71mqpYBasORwnebHuDzedUB6MOMhbWgA+NLLHPIB7yPEyOCh4UUmjxOpsiJuZcs9GZWw
         F8ewnCkr9u1CqKlmf4oW6yDcnSSbIuurZ9sKzaNNYD4SKEYJJIm1kfyRDxQ0nkvKHik/
         YMkw==
X-Gm-Message-State: AOAM530p9Leq5DwdyEN6SpmrxxWqvhc9V0XCWApdcrlog/azxjU6BPJp
        nbNGqWIzTp+0lcGbAAcU81Q=
X-Google-Smtp-Source: ABdhPJydDWCC0cImtGR3ApozIWoml6FLqAUUWtzPeE7bW1eJQ3xAFnItpbdPcy3zKpfDYwU75NnssA==
X-Received: by 2002:a17:902:7593:b0:15e:fe5d:58e1 with SMTP id j19-20020a170902759300b0015efe5d58e1mr16364570pll.102.1652682093885;
        Sun, 15 May 2022 23:21:33 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:469:4645:1448:44e0:4d9f:8e5b])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090ad58f00b001d840f4eee0sm7597337pju.20.2022.05.15.23.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 23:21:33 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2] dt-bindings: mfd: Add bindings child nodes for the Mediatek MT6360
Date:   Mon, 16 May 2022 14:21:27 +0800
Message-Id: <20220516062127.99647-1-gene.chen.richtek@gmail.com>
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
 .../bindings/mfd/mediatek,mt6360.yaml         | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
index 4d8769f3748c..28eee02441ee 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6360.yaml
@@ -37,6 +37,18 @@ properties:
     description:
       The first cell is the IRQ number.
 
+  regulators:
+    $ref: /schemas/regulator/mt6360-regulator.yaml#
+
+  charger:
+    $ref: /schemas/power/supply/mt6360_charger.yaml#
+
+  tcpc:
+    $ref: /schemas/usb/mediatek,mt6360-tcpc.yaml#
+
+  led-controller:
+    $ref: /schemas/leds/leds-mt6360.yaml#
+
 required:
   - compatible
   - reg
@@ -51,6 +63,8 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+    #include <dt-bindings/leds/common.h>
+    #include <dt-bindings/usb/pd.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -63,5 +77,180 @@ examples:
             interrupt-names = "IRQB";
             interrupt-controller;
             #interrupt-cells = <1>;
+
+            mt6360_charger: charger {
+                compatible = "mediatek,mt6360-chg";
+                richtek,vinovp-microvolt = <14500000>;
+
+                otg_vbus_regulator: usb-otg-vbus-regulator {
+                    regulator-compatible = "usb-otg-vbus";
+                    regulator-name = "usb-otg-vbus";
+                    regulator-min-microvolt = <4425000>;
+                    regulator-max-microvolt = <5825000>;
+                };
+            };
+
+            led-controller {
+                compatible = "mediatek,mt6360-led";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                multi-led@0 {
+                    reg = <0>;
+                    function = LED_FUNCTION_INDICATOR;
+                    color = <LED_COLOR_ID_RGB>;
+                    led-max-microamp = <24000>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    led@0 {
+                        reg = <0>;
+                        color = <LED_COLOR_ID_RED>;
+                    };
+                    led@1 {
+                        reg = <1>;
+                        color = <LED_COLOR_ID_GREEN>;
+                    };
+                    led@2 {
+                        reg = <2>;
+                        color = <LED_COLOR_ID_BLUE>;
+                    };
+                };
+                led@3 {
+                    reg = <3>;
+                    function = LED_FUNCTION_INDICATOR;
+                    color = <LED_COLOR_ID_WHITE>;
+                    led-max-microamp = <150000>;
+                };
+                led@4 {
+                    reg = <4>;
+                    function = LED_FUNCTION_FLASH;
+                    color = <LED_COLOR_ID_WHITE>;
+                    function-enumerator = <1>;
+                    led-max-microamp = <200000>;
+                    flash-max-microamp = <500000>;
+                    flash-max-timeout-us = <1024000>;
+                };
+                led@5 {
+                    reg = <5>;
+                    function = LED_FUNCTION_FLASH;
+                    color = <LED_COLOR_ID_WHITE>;
+                    function-enumerator = <2>;
+                    led-max-microamp = <200000>;
+                    flash-max-microamp = <500000>;
+                    flash-max-timeout-us = <1024000>;
+                };
+            };
+
+            regulators {
+                compatible = "mediatek,mt6360-regulator";
+                LDO_VIN3-supply = <&BUCK2>;
+                buck1 {
+                    regulator-compatible = "BUCK1";
+                    regulator-name = "mt6360,buck1";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP
+                         MT6360_OPMODE_ULP>;
+                };
+                BUCK2: buck2 {
+                    regulator-compatible = "BUCK2";
+                    regulator-name = "mt6360,buck2";
+                    regulator-min-microvolt = <300000>;
+                    regulator-max-microvolt = <1300000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP
+                         MT6360_OPMODE_ULP>;
+                };
+                ldo6 {
+                    regulator-compatible = "LDO6";
+                    regulator-name = "mt6360,ldo6";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <2100000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP>;
+                };
+                ldo7 {
+                    regulator-compatible = "LDO7";
+                    regulator-name = "mt6360,ldo7";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <2100000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP>;
+                };
+                ldo1 {
+                    regulator-compatible = "LDO1";
+                    regulator-name = "mt6360,ldo1";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP>;
+                };
+                ldo2 {
+                    regulator-compatible = "LDO2";
+                    regulator-name = "mt6360,ldo2";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP>;
+                };
+                ldo3 {
+                    regulator-compatible = "LDO3";
+                    regulator-name = "mt6360,ldo3";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP>;
+                };
+                ldo5 {
+                    regulator-compatible = "LDO5";
+                    regulator-name = "mt6360,ldo5";
+                    regulator-min-microvolt = <2700000>;
+                    regulator-max-microvolt = <3600000>;
+                    regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+                         MT6360_OPMODE_LP>;
+                };
+            };
+
+            tcpc {
+                compatible = "mediatek,mt6360-tcpc";
+                interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
+                interrupt-names = "PD_IRQB";
+
+                connector {
+                    compatible = "usb-c-connector";
+                    label = "USB-C";
+                    data-role = "dual";
+                    power-role = "dual";
+                    try-power-role = "sink";
+                    source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+                    sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
+                    op-sink-microwatt = <10000000>;
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        port@0 {
+                            reg = <0>;
+                            endpoint {
+                                remote-endpoint = <&usb_hs>;
+                            };
+                        };
+                        port@1 {
+                            reg = <1>;
+                            endpoint {
+                                remote-endpoint = <&usb_ss>;
+                          };
+                        };
+                        port@2 {
+                            reg = <2>;
+                            endpoint {
+                                remote-endpoint = <&dp_aux>;
+                            };
+                        };
+                    };
+                };
+            };
         };
     };
-- 
2.25.1

