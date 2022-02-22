Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2FB4C04B4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiBVWgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiBVWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:36:41 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6910CF1C;
        Tue, 22 Feb 2022 14:36:15 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d84so1871753qke.8;
        Tue, 22 Feb 2022 14:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Fesjr/vH5Ggn3AhKvFPSmblwl+YCy9uYI5ORA6HhgM=;
        b=epzehdhawYLv/VnNrNpN5zVbE/QaqEVVSW9XRJHClekm4K5ur/jlp54nX1fyJHW/7F
         IoElS/NPIQ65U4bLwKYHpM1nMI3n989Q3sSmLto+oQoZEY9BMtaJBSa3ZKHI6oiSAqE2
         L4NnI+o1cK96z+DKh80EQ2yFI2wDeY5HbaxaiQw+BQFgmepbEj6Gryxpy5lz6KRQqYwI
         dIC9KYELvEEQF/oNjM9gPOMXWl2t2DTpxuodxhTTiNQXu22UGKh+CeKO5WNLZoC3JgKB
         gSAcdaqOBP4BZT29EZpNF0tRtUoxM+Dbi5SG4xFegAY84KN8e5K5EYbqYr4vTSb18llG
         Zrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0Fesjr/vH5Ggn3AhKvFPSmblwl+YCy9uYI5ORA6HhgM=;
        b=Ci4JTflDxYPz+OTa/qZ8bWwAYUGQw+xdDrQaocvd44f/daoy20O0/hlVd3IrwOl6lb
         rT/V19NEODdwyWvfWVJ/Eh+ixFp9WqkRsc4FEczf9D/RmRvdJfi5SsD9LneT+4kqm6sG
         nNhOBjy98p2NUWMBepAcOB/ESpAsNOc4ysz1ovvvW4+6qpp6w/u9a8a2ZvKI73ZkFFBP
         dWSYBG6oW3qpKwUMvr8nEScqHS+tc7qbUfhDSqcAtsmwCftTV0vhhQarfb3ulWdPM5Dt
         jddCU4rIduwz2T1cY88yEKueI6O4WzYPpY5St2bftFNJFe/c26ZuHJMl7nskvHQrebIz
         /arQ==
X-Gm-Message-State: AOAM5311qyfOxvSoKmYyA+6T1bH/3SCt4KV7QqcHxmSbqFt13YTphNgy
        yi2aPXJL+/ws+R3hiLF93y+HuxzE274WoQ==
X-Google-Smtp-Source: ABdhPJzCZXHBgbR5Wh+1IBfAvD/BmK/7ZFLPgkSMRThgy4N6BWI6uw+M9Fm05KhiNX1CV0qF1NQRbw==
X-Received: by 2002:a05:620a:25d0:b0:47b:2596:de51 with SMTP id y16-20020a05620a25d000b0047b2596de51mr16625029qko.531.1645569374220;
        Tue, 22 Feb 2022 14:36:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i20sm611882qtr.38.2022.02.22.14.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:36:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Agathe Porte <agathe.porte@nokia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v7 1/2] dt-bindings: hwmon: add tmp464.yaml
Date:   Tue, 22 Feb 2022 14:36:09 -0800
Message-Id: <20220222223610.23098-1-linux@roeck-us.net>
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
v7:
- No change

v6:
- Model ti,n-factor as int32 instead of int8.

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
index 000000000000..801ca9ba7d34
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
+        $ref: /schemas/types.yaml#/definitions/int32
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
+          ti,n-factor = <(-10)>;
+          label = "external";
+        };
+
+        channel@2 {
+          reg = <0x2>;
+          ti,n-factor = <0x10>;
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

