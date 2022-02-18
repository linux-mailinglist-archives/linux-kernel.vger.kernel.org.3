Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301154BBBDC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiBRPJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:09:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiBRPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:09:30 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E12B1A9E;
        Fri, 18 Feb 2022 07:09:12 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t21so1838745qkg.6;
        Fri, 18 Feb 2022 07:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+c8s0EjYkyxnfYNSAqg9hu3fSNA58Ks2lBfRjv9VfU=;
        b=djMc4wKdAPeU1YOMlgW/P1JNYMDyIUSWaMvVVy9WoimPqdT0EfrKZELxh2lgUpUsRO
         ZCPU8Mc/ughc8ugef1/n9R+q4Xko2PkNWkx537xwMfV11oz8gIoQr5hSRvNVaNCRvMxB
         9NTBYvPtQnT5RCs/chYAFRHH9fceF4bnuLyriKYnWdlPjor/URAtuswjwU+z9IMa/nG7
         WsH2CnxDyVDbycg7h5XHdIttjoVo9NQ6hp8Z/SyfQT6M1Xyjvk84+ikl9rwdGLYYr/Zt
         EqPpSe/p9/v3n26WcnffFwWeYmO5yrGDhYGnf4h9GKB/2ojiJ1TKCaiVSPen7P0aY+yj
         NRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L+c8s0EjYkyxnfYNSAqg9hu3fSNA58Ks2lBfRjv9VfU=;
        b=bEWfpee7Vj6YyYPeXCgZPIpmB0igCxwC1myBmR6Ul1SWAAi4O9BQ9afkOhC+5l+ff7
         aXNC0O3rzENiR0vNMhsSO1cJ2s9LSuZ6+2ETMf2yG5VQGk80IHtrT814/rzoX7DVUFo3
         7HyYnsrTcpdaLGBP2ln9EhPRxOTV+2y9Q16+1PRLEikMelV9FA8bqA3KhF+vfdDG34zm
         trt00b9h9NM9iWG0LIYhCtQXlbbDK+ANgkCadcsS4VxRMPtCWAmElT95KY88a21qUl18
         UM4EEaypQIZZ8TLWbWeerAmf9ZZ47i22khja0QzFZA65n6KEzaIq0AVjl8yTFeQb35+X
         E4bQ==
X-Gm-Message-State: AOAM532sWuLqSvg4R6pkqtYCDkW9QlpRehs5SrKhPbLKXYFZF8M3v5xK
        8ieLzoCJmctxh5NPWOzv6u1dhHvOOpIs3w==
X-Google-Smtp-Source: ABdhPJy34H3DievOaDVqStbNJDf7EHYM+soXVumHSfhGX63n+hnnLMGqWm+uPqn5mBaQpit2HPrUyA==
X-Received: by 2002:a37:713:0:b0:47e:3a22:85ad with SMTP id 19-20020a370713000000b0047e3a2285admr4911247qkh.70.1645196951850;
        Fri, 18 Feb 2022 07:09:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b186sm606081qkd.16.2022.02.18.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:09:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 1/2] dt-bindings: hwmon: add tmp464.yaml
Date:   Fri, 18 Feb 2022 07:09:07 -0800
Message-Id: <20220218150908.1947772-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Agathe Porte <agathe.porte@nokia.com>

Add basic description of the tmp464 driver DT bindings.

Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5:
- Dropped ti,n-factor from channel@0 example. Added additional
  channel to examples to show positive ti,n-factor property.

v4:
- No changes

v3:
- Addedd support for TMP468.
- Changed number of channels from 0..3 (which was wrong anyway) to 0..8.
- Changed value range for ti,n-factor to int8, with an example for
  a negative value.
- Added myself as driver maintainer.

 .../devicetree/bindings/hwmon/ti,tmp464.yaml  | 114 ++++++++++++++++++
 MAINTAINERS                                   |   7 ++
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
new file mode 100644
index 000000000000..14f6a3412b8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,tmp464.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TMP464 and TMP468 temperature sensors
+
+maintainers:
+  - Agathe Porte <agathe.porte@nokia.com>
+
+description: |
+  ±0.0625°C Remote and Local temperature sensor
+  https://www.ti.com/lit/ds/symlink/tmp464.pdf
+  https://www.ti.com/lit/ds/symlink/tmp468.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,tmp464
+      - ti,tmp468
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@([0-8])$":
+    type: object
+    description: |
+      Represents channels of the device and their specific configuration.
+
+    properties:
+      reg:
+        description: |
+          The channel number. 0 is local channel, 1-8 are remote channels.
+        items:
+          minimum: 0
+          maximum: 8
+
+      label:
+        description: |
+          A descriptive name for this channel, like "ambient" or "psu".
+
+      ti,n-factor:
+        description: |
+          The value (two's complement) to be programmed in the channel specific N correction register.
+          For remote channels only.
+        $ref: /schemas/types.yaml#/definitions/int8
+        items:
+          minimum: -128
+          maximum: 127
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sensor@4b {
+        compatible = "ti,tmp464";
+        reg = <0x4b>;
+      };
+    };
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sensor@4b {
+        compatible = "ti,tmp464";
+        reg = <0x4b>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0x0>;
+          label = "local";
+        };
+
+        channel@1 {
+          reg = <0x1>;
+          ti,n-factor = /bits/ 8 <(-10)>;
+          label = "external";
+        };
+
+        channel@2 {
+          reg = <0x2>;
+          ti,n-factor = /bits/ 8 <0x10>;
+          label = "somelabel";
+        };
+
+        channel@3 {
+          reg = <0x3>;
+          status = "disabled";
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fca970a46e77..f51bc7c7e439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19489,6 +19489,13 @@ S:	Maintained
 F:	Documentation/hwmon/tmp401.rst
 F:	drivers/hwmon/tmp401.c
 
+TMP464 HARDWARE MONITOR DRIVER
+M:	Agathe Porte <agathe.porte@nokia.com>
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
+
 TMP513 HARDWARE MONITOR DRIVER
 M:	Eric Tremblay <etremblay@distech-controls.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.35.1

