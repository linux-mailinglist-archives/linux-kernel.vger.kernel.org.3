Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381F050C0CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiDVUnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiDVUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:43:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B72F2B0B;
        Fri, 22 Apr 2022 12:41:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so16339667ybu.0;
        Fri, 22 Apr 2022 12:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOuZ8W1MJjibB6swPo2RkQCIeQZ1wridYdEDKveCnMw=;
        b=75QeTDGw2CXuOQiRqR4x9mCo2fipdSQ2FnVmTTDAsV+ycc63HyxQgInkyz1UOUkcFO
         TJNwp65NQMLbcUjWH9YGwdMzcc1UEvalFVCxlU9cqy4F18erT1Js5XhTM56JeCuwn0S3
         40Ji+mVAmOQWRkQodiZc4Nf4z1FW9AzIsZ9UTwUV8tv70cHa652xQ1OAkeeGSA4qESsL
         YqY5TUhEgXRUNLe1A0Z50wildXvhsuLWUinzz+qnDKe+cdRnwE5NdJkn0Jla24PwTgN+
         y7xbMjDQcY0MhAoi//1J1Co0u5S3Q1UAZR9b6SD8YNnVL88f+bHtE9P7FA3j3bZ7Gb96
         XaIA==
X-Gm-Message-State: AOAM533NHaXEw+e1rmg8vLSJ9Q45NoCaXcNFd7lMbeVBS7It79fHpSFQ
        lpYOZkHyZlme+NvaqQV4LDmLOqXsNA==
X-Google-Smtp-Source: ABdhPJwYLw7ezcsEnAXRaBNaeuhKHOPAF+WazY3gcKcmVgQTsP9d3MdUusPnK8wJQL/5J1SzRjWOlw==
X-Received: by 2002:a9d:3624:0:b0:5e9:5778:d0c6 with SMTP id w33-20020a9d3624000000b005e95778d0c6mr2399677otb.367.1650655308747;
        Fri, 22 Apr 2022 12:21:48 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id x24-20020a056870a79800b000e2e53716fbsm1044094oao.31.2022.04.22.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:21:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Drop referenced nodes in examples
Date:   Fri, 22 Apr 2022 14:21:38 -0500
Message-Id: <20220422192139.2592632-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The additional nodes in the example referenced from the pinctrl node
'aspeed,external-nodes' properties are either incorrect (aspeed,ast2500-lpc)
or not documented with a schema (aspeed,ast2500-gfx). There's no need to
show these nodes as part of the pinctrl example, so just remove them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 81 ++++---------------
 1 file changed, 16 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 7c25c8d51116..9db904a528ee 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -76,73 +76,24 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/aspeed-clock.h>
-    apb {
-        compatible = "simple-bus";
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges;
-
-        syscon: scu@1e6e2000 {
-            compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
-            reg = <0x1e6e2000 0x1a8>;
-            #clock-cells = <1>;
-            #reset-cells = <1>;
-
-            pinctrl: pinctrl {
-                compatible = "aspeed,ast2500-pinctrl";
-                aspeed,external-nodes = <&gfx>, <&lhc>;
-
-                pinctrl_i2c3_default: i2c3_default {
-                    function = "I2C3";
-                    groups = "I2C3";
-                };
-
-                pinctrl_gpioh0_unbiased_default: gpioh0 {
-                    pins = "A18";
-                    bias-disable;
-                };
+    scu@1e6e2000 {
+        compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
+        reg = <0x1e6e2000 0x1a8>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        pinctrl: pinctrl {
+            compatible = "aspeed,ast2500-pinctrl";
+            aspeed,external-nodes = <&gfx>, <&lhc>;
+
+            pinctrl_i2c3_default: i2c3_default {
+                function = "I2C3";
+                groups = "I2C3";
             };
-        };
-
-        gfx: display@1e6e6000 {
-            compatible = "aspeed,ast2500-gfx", "syscon";
-            reg = <0x1e6e6000 0x1000>;
-            reg-io-width = <4>;
-            clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-            resets = <&syscon ASPEED_RESET_CRT1>;
-            interrupts = <0x19>;
-            syscon = <&syscon>;
-            memory-region = <&gfx_memory>;
-        };
-    };
-
-    lpc: lpc@1e789000 {
-        compatible = "aspeed,ast2500-lpc", "simple-mfd";
-        reg = <0x1e789000 0x1000>;
-
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0x0 0x1e789000 0x1000>;
-
-        lpc_host: lpc-host@80 {
-            compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
-            reg = <0x80 0x1e0>;
-            reg-io-width = <4>;
 
-            #address-cells = <1>;
-            #size-cells = <1>;
-            ranges = <0x0 0x80 0x1e0>;
-
-            lhc: lhc@20 {
-                   compatible = "aspeed,ast2500-lhc";
-                   reg = <0x20 0x24>, <0x48 0x8>;
+            pinctrl_gpioh0_unbiased_default: gpioh0 {
+                pins = "A18";
+                bias-disable;
             };
         };
     };
-
-    gfx_memory: framebuffer {
-        size = <0x01000000>;
-        alignment = <0x01000000>;
-        compatible = "shared-dma-pool";
-        reusable;
-    };
-- 
2.32.0

