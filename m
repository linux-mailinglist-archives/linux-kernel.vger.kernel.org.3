Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946AB49D30D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiAZUEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiAZUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:03:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BF0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:03:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u15so949365wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmvNokyx0vYilqgTp4H3XfCKVkPoSuYzvjsHlfClDlc=;
        b=r9RfV5etklztoUB/utGzVdnEOWno7SYoZgvb5Kf1ciRTtQweniiF1x/DeY58P1r4j+
         W4H9ovHhF0x+uvw1zY9k53VSbT08epZukONJ4n96w4k7lNZ+meJMpK3emgNFSC1YlqrV
         EqkNNzxaDwVKTzE/TP6Ct6uZOB7jXNFuQuGeHw1nM88kjv7w4X16vM/we0X2nGtLTnZt
         7zD99XudsMVBSWOyYVoxdN2eU9HWvRccsLgEY3jZ49moDC9LI8ZSPKwvUyWl7E37gsIA
         8vcPiIS7QBLvwUC64MOSoxc72xXJvb31OVRTb4s7daVSoGH6gSfhrKj4s/SE3KAYRZmg
         kEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmvNokyx0vYilqgTp4H3XfCKVkPoSuYzvjsHlfClDlc=;
        b=JmwxxTEXnodyzihl+y7oA4zyGChDIzFZQrOtQi4S10h0pdBYV1FjPwhZi8nm5o34mQ
         C+eMdZtYuGFsS37ECTar/2Dk2nSluCG3cm6dTM6shtATaV7jjHAM75LXXsjBI8pAJQNg
         Bp5tCxUvR3bfsIfafHeN69Fc9n0mP0GgAQVLNum5DdHvnjHByYUmbcn3rRKMwg4cq/r8
         PktrFLsqcfioKpZ5W4H52SVj0KZ6hMVQhZq11VFlyV8oY+rZGG/V2CbF35zONrLxeNSS
         tH8mCTPrWNxigkglI21I2xZGA4VOnWpCViP7NWOsmrBKiE0M0WSVRXswqjfv0bhi7EXF
         emBQ==
X-Gm-Message-State: AOAM530gSkg8T9SU1RcrRUNf7UHgolzQDkd/Mg4dzP5/mMLrSU875B44
        QANtxXJpzUJi4C2b504VseUN01xLcrQDMw==
X-Google-Smtp-Source: ABdhPJylUUBXOE4mq+qJbaAfmr8vAwBFgwMOyFWYZ1PAf3YktBAm6kPHU2xGJw+4KED6dyTaWOOn8w==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr149885wrc.718.1643227436461;
        Wed, 26 Jan 2022 12:03:56 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n10sm270140wrf.96.2022.01.26.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:03:55 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: hwmon: gpio-fan: convert to YAML
Date:   Wed, 26 Jan 2022 20:03:50 +0000
Message-Id: <20220126200350.3633576-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts hwmon/gpio-fan.txt to YAML

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---

I didnt found any clear maintainer and since DT yaml mandates a
maintainer section, I set devicetree@vger.kernel.org.

 .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 --------
 .../devicetree/bindings/hwmon/gpio-fan.yaml   | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
deleted file mode 100644
index f4cfa350f6a1..000000000000
--- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Bindings for fan connected to GPIO lines
-
-Required properties:
-- compatible : "gpio-fan"
-
-Optional properties:
-- gpios: Specifies the pins that map to bits in the control value,
-  ordered MSB-->LSB.
-- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
-  control value that should be set to achieve them. This array
-  must have the RPM values in ascending order.
-- alarm-gpios: This pin going active indicates something is wrong with
-  the fan, and a udev event will be fired.
-- #cooling-cells: If used as a cooling device, must be <2>
-  Also see:
-  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
-  min and max states are derived from the speed-map of the fan.
-
-Note: At least one the "gpios" or "alarm-gpios" properties must be set.
-
-Examples:
-
-	gpio_fan {
-		compatible = "gpio-fan";
-		gpios = <&gpio1 14 1
-			 &gpio1 13 1>;
-		gpio-fan,speed-map = <0    0
-				      3000 1
-				      6000 2>;
-		alarm-gpios = <&gpio1 15 1>;
-	};
-	gpio_fan_cool: gpio_fan {
-		compatible = "gpio-fan";
-		gpios = <&gpio2 14 1
-			 &gpio2 13 1>;
-		gpio-fan,speed-map =	<0    0>,
-					<3000 1>,
-					<6000 2>;
-		alarm-gpios = <&gpio2 15 1>;
-		#cooling-cells = <2>; /* min followed by max */
-	};
diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
new file mode 100644
index 000000000000..15bb5efd3cb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/gpio-fan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for fan connected to GPIO lines
+
+maintainers:
+  - OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>
+
+properties:
+  compatible:
+    const: gpio-fan
+
+  gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Specifies the pins that map to bits in the control value,
+      ordered MSB-->LSB.
+
+  gpio-fan,speed-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: A mapping of possible fan RPM speeds and the
+      control value that should be set to achieve them. This array
+      must have the RPM values in ascending order.
+
+  alarm-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: This pin going active indicates something is wrong with
+      the fan, and a udev event will be fired.
+
+  "#cooling-cells":
+    const: 2
+    description: If used as a cooling device, must be <2>
+      Also see Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
+      min and max states are derived from the speed-map of the fan.
+
+anyOf:
+  - required:
+      - gpios
+  - required:
+      - alarm-gpios
+
+additionalProperties: False
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    #include <dt-bindings/reset/cortina,gemini-reset.h>
+    #include <dt-bindings/gpio/gpio.h>
+    gpio1: gpio@4d000000 {
+      compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
+      reg = <0x4d000000 0x100>;
+      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+      resets = <&syscon GEMINI_RESET_GPIO0>;
+      clocks = <&syscon GEMINI_CLK_APB>;
+      gpio-controller;
+      #gpio-cells = <2>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
+    gpio_fan {
+      compatible = "gpio-fan";
+        gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+        gpio-fan,speed-map = <0    0>,
+                             <3000 1>,
+                             <6000 2>;
+        alarm-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    #include <dt-bindings/reset/cortina,gemini-reset.h>
+    #include <dt-bindings/gpio/gpio.h>
+    gpio2: gpio@4d000000 {
+      compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
+      reg = <0x4d000000 0x100>;
+      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+      resets = <&syscon GEMINI_RESET_GPIO0>;
+      clocks = <&syscon GEMINI_CLK_APB>;
+      gpio-controller;
+      #gpio-cells = <2>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
+    gpio_fan_cool: gpio_fan {
+      compatible = "gpio-fan";
+      gpios = <&gpio2 8 GPIO_ACTIVE_HIGH
+               &gpio2 1 GPIO_ACTIVE_HIGH>;
+      gpio-fan,speed-map = <0    0
+                           3000 1
+                           6000 2>;
+      alarm-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
+      #cooling-cells = <2>; /* min followed by max */
+    };
-- 
2.34.1

