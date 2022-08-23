Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F6D59E928
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiHWRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242294AbiHWRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:21 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1BAC254;
        Tue, 23 Aug 2022 07:57:38 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id g5-20020a4ac4c5000000b0044af7c8c4b3so2383350ooq.1;
        Tue, 23 Aug 2022 07:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZKzyS+QHTXVC7BDw1OAebS/EBaC9dZMOK/D2B0whWOI=;
        b=DpSgolFuedOKR7ZeH9ZgOox03O3VKsuxPuiIxXhModRrJIjInHEpw2rjoSYmQVyTrk
         CgCdHiQKlQc2guHHGMExs1HbSd6uAMame403DMkl5NK3pyKHymyRtXd3kX43/aZExINa
         +QFkODTnjTje10kTU1Bslovr9ioBhOQQCbOhbPygG7CBQDXDOYv3QtyhJdX8hdVvhC66
         RfgFl2Rai12+VjZXNqp/+Dz+qTgGzQ+AVmWCoX6Vt0Lb8jetwkYRbew9uSpN2TDodRbf
         G5namBWj9tDDVormW6/dXXIYVb5Fbf7/ZUG7MwKAuXvNBn6Q3QLrFYY0/H6Wa0miJfwW
         OIjw==
X-Gm-Message-State: ACgBeo1P6JU7117ZIb82T/Wx6Z5hs/RDwUtjY+pS8px54gzEmDhZqG8E
        nCETKAgeVv/8Zka6Ie+fWq2tQYR3UQ==
X-Google-Smtp-Source: AA6agR7IHw/8Bk3ruADMSCqp1/dFX6q7yLZ/8KGTPHZ0Fm3Cc51EjnpGlEW/s13N0YY5zenpVebTeg==
X-Received: by 2002:a4a:5e82:0:b0:44a:fe22:baff with SMTP id h124-20020a4a5e82000000b0044afe22baffmr7600316oob.86.1661266657256;
        Tue, 23 Aug 2022 07:57:37 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        - NeilBrown <neilb@suse.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:44 -0500
Message-Id: <20220823145649.3118479-13-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
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

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/leds/issi,is31fl319x.yaml           |  1 +
 .../devicetree/bindings/leds/leds-aw2013.yaml    |  1 +
 .../devicetree/bindings/leds/leds-gpio.yaml      |  1 +
 .../devicetree/bindings/leds/leds-lgm.yaml       | 10 +++++++---
 .../devicetree/bindings/leds/leds-max77650.yaml  |  9 ++-------
 .../devicetree/bindings/leds/leds-pwm.yaml       |  1 +
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml  |  6 ++++++
 .../bindings/leds/rohm,bd71828-leds.yaml         | 16 +++-------------
 .../devicetree/bindings/leds/ti,tca6507.yaml     |  1 +
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
index 940333f2d69c..2929382625b6 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
@@ -57,6 +57,7 @@ patternProperties:
   "^led@[1-9]$":
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
index e24b0d15ef01..6c3ea0f06cef 100644
--- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
@@ -33,6 +33,7 @@ patternProperties:
   "^led@[0-2]$":
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.yaml b/Documentation/devicetree/bindings/leds/leds-gpio.yaml
index 7ad2baeda0b0..f156d3e47b71 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.yaml
@@ -25,6 +25,7 @@ patternProperties:
     type: object
 
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       gpios:
diff --git a/Documentation/devicetree/bindings/leds/leds-lgm.yaml b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
index f8d7963c3a13..8b3b3bf1eaf2 100644
--- a/Documentation/devicetree/bindings/leds/leds-lgm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
@@ -56,7 +56,8 @@ properties:
 
     patternProperties:
       "^led@[0-2]$":
-        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
 
         properties:
           reg:
@@ -64,6 +65,9 @@ properties:
             minimum: 0
             maximum: 2
 
+          led-gpios:
+            maxItems: 1
+
           intel,sso-hw-trigger:
             type: boolean
             description: This property indicates Hardware driven/control LED.
@@ -118,14 +122,14 @@ examples:
           reg = <0>;
           function = "gphy";
           color = <LED_COLOR_ID_GREEN>;
-          led-gpio = <&ssogpio 0 0>;
+          led-gpios = <&ssogpio 0 0>;
         };
 
         led@2 {
           reg = <2>;
           function = LED_FUNCTION_POWER;
           color = <LED_COLOR_ID_GREEN>;
-          led-gpio = <&ssogpio 23 0>;
+          led-gpios = <&ssogpio 23 0>;
         };
       };
     };
diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.yaml b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
index c6f96cabd4d1..fdb08f44a45d 100644
--- a/Documentation/devicetree/bindings/leds/leds-max77650.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
@@ -30,9 +30,8 @@ properties:
 
 patternProperties:
   "^led@[0-2]$":
-    type: object
-    description: |
-      Properties for a single LED.
+    $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
@@ -41,10 +40,6 @@ patternProperties:
         minimum: 0
         maximum: 2
 
-      label: true
-
-      linux,default-trigger: true
-
 required:
   - compatible
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.yaml b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
index fe4d5fd25913..e60009863d07 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
@@ -22,6 +22,7 @@ patternProperties:
     type: object
 
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       pwms:
diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 497db289169d..6f43aadea3be 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -72,11 +72,17 @@ properties:
       "^led@[0-9a-f]$":
         type: object
         $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
 
 patternProperties:
   "^led@[0-9a-f]$":
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg: true
diff --git a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
index 86a37c92b834..ca92cea56a6f 100644
--- a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
@@ -26,26 +26,16 @@ properties:
 
 patternProperties:
   "^led-[1-2]$":
-    type: object
-    description:
-      Properties for a single LED.
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
     properties:
-      #allOf:
-        #- $ref: "common.yaml#"
       rohm,led-compatible:
         description: LED identification string
         $ref: "/schemas/types.yaml#/definitions/string"
         enum:
           - bd71828-ambled
           - bd71828-grnled
-      function:
-        description:
-          Purpose of LED as defined in dt-bindings/leds/common.h
-        $ref: "/schemas/types.yaml#/definitions/string"
-      color:
-        description:
-          LED colour as defined in dt-bindings/leds/common.h
-        $ref: "/schemas/types.yaml#/definitions/uint32"
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
index 32c600387895..e83964600993 100644
--- a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
+++ b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
@@ -40,6 +40,7 @@ patternProperties:
     type: object
 
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
-- 
2.34.1

