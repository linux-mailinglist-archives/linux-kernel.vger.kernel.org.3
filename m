Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674F7468A8A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhLELiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhLELiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:38:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03053C061751;
        Sun,  5 Dec 2021 03:34:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so31320839edv.1;
        Sun, 05 Dec 2021 03:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drn9vOsb6iAqHOzxfiDRNaCywjfVvDrfai5oCr/V7F0=;
        b=lQIlXrbXohWJJFIMdIxCb+weN3v22wVNN/8LIBR0fbis3bCsTShbzwRguad8wtCcAX
         FR8MTqsmE6Ap2PYH5o+r5zKb0aFk4NthSD/h5ZDD3yKi2e9912tX+Bveq4eGW7rMnat6
         rMWW3JK6jeNR20m5LFxA+drnkZj/7n+jzQVuRE5Mq42PKbDiCq77Qn9O5OeE3ESAdQe9
         MTSc3Ac2WAaUT1lWyK25fbkFRqr9qsJ2orYdGGjoTrikGzX1B+0NvS4O70aKveDJk3Dp
         3c0evEMr7fQk+vghT+SPf2ev0jLuokFWksIKAUWjVff3NzTmPb+2ufcfsLWIZdxSjXHk
         lOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drn9vOsb6iAqHOzxfiDRNaCywjfVvDrfai5oCr/V7F0=;
        b=Bo8bzN21cizYu2fWMRKF2OHFSvkPDsGrxVnlskwXI/sQT5k51KjBSJCKkbuPqGcJ9z
         OphESYchDiZwuOUOaKJ6erP3NRH+ralgikhogfRDXcsQvtqdbf+GsLVT+ky8uwGXWNT+
         PBriU3l8m/2ld2vuijokzu04/zllRElbyelJTbAdxmIvM8uIyG/gMw0fV05iy5ZQ27jM
         UP0FXvIA196+qqkcctdeKMWoBn8EoxgWY8hLmWYQZr6jfQy2ZSVAHXcBhCA7HG2nYiu5
         l+sLCPa/wuWcgsVc9n2hXoV4fRIXL0lLsOvT1XwiK2+hITBE6/WDwftX/sy4AkwFbyBb
         lo2A==
X-Gm-Message-State: AOAM532fvx54jyhB7QuEPnVSGkxkmqWiHDJZ9GpU5BIYAZVFSrDHRlT3
        FN18K3zcGj+eyFkxGlVeSvY=
X-Google-Smtp-Source: ABdhPJw6oTqmkXFLt1WRJ5S7qZ96uqIntYT86j+Go/cMtLo4meqgLzieWm5/AEOtQ3wruwBG3VV8IA==
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr43106705edz.323.1638704083497;
        Sun, 05 Dec 2021 03:34:43 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id d1sm5878225edn.56.2021.12.05.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 03:34:43 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v10 2/3] dt-bindings: iio: add AD74413R
Date:   Sun,  5 Dec 2021 13:34:25 +0200
Message-Id: <20211205113426.41486-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205113426.41486-1-cosmin.tanislav@analog.com>
References: <20211205113426.41486-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD74412R and AD74413R are quad-channel, software configurable,
input/output solutions for building and process control applications.

They contain functionality for analog output, analog input, digital input,
resistance temperature detector, and thermocouple measurements integrated
into a single chip solution with an SPI interface.

The devices feature a 16-bit ADC and four configurable 13-bit DACs to
provide four configurable input/output channels and a suite of diagnostic
functions.

The AD74413R differentiates itself from the AD74412R by being
HART-compatible.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/addac/adi,ad74413r.yaml      | 158 ++++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
 2 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
new file mode 100644
index 000000000000..baa65a521bad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/addac/adi,ad74413r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD74412R/AD74413R device
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The AD74412R and AD74413R are quad-channel software configurable input/output
+  solutions for building and process control applications. They contain
+  functionality for analog output, analog input, digital input, resistance
+  temperature detector, and thermocouple measurements integrated
+  into a single chip solution with an SPI interface.
+  The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
+  four configurable input/output channels and a suite of diagnostic functions.
+  The AD74413R differentiates itself from the AD74412R by being HART-compatible.
+    https://www.analog.com/en/products/ad74412r.html
+    https://www.analog.com/en/products/ad74413r.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad74412r
+      - adi,ad74413r
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
+  spi-max-frequency:
+    maximum: 1000000
+
+  spi-cpol: true
+
+  interrupts:
+    maxItems: 1
+
+  refin-supply: true
+
+  shunt-resistor-micro-ohms:
+    description:
+      Shunt (sense) resistor value in micro-Ohms.
+    default: 100000000
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-cpol
+  - refin-supply
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@[0-3]$":
+    type: object
+    description: Represents the external channels which are connected to the device.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 4 channels numbered from 0 to 3.
+        minimum: 0
+        maximum: 3
+
+      adi,ch-func:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Channel function.
+          HART functions are not supported on AD74412R.
+          0 - CH_FUNC_HIGH_IMPEDANCE
+          1 - CH_FUNC_VOLTAGE_OUTPUT
+          2 - CH_FUNC_CURRENT_OUTPUT
+          3 - CH_FUNC_VOLTAGE_INPUT
+          4 - CH_FUNC_CURRENT_INPUT_EXT_POWER
+          5 - CH_FUNC_CURRENT_INPUT_LOOP_POWER
+          6 - CH_FUNC_RESISTANCE_INPUT
+          7 - CH_FUNC_DIGITAL_INPUT_LOGIC
+          8 - CH_FUNC_DIGITAL_INPUT_LOOP_POWER
+          9 - CH_FUNC_CURRENT_INPUT_EXT_POWER_HART
+          10 - CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
+        minimum: 0
+        maximum: 10
+        default: 0
+
+      adi,gpo-comparator:
+        type: boolean
+        description: |
+          Whether to configure GPO as a comparator or not.
+          When not configured as a comparator, the GPO will be treated as an
+          output-only GPIO.
+
+    required:
+      - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+      status = "okay";
+
+      ad74413r@0 {
+        compatible = "adi,ad74413r";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        spi-cpol;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+
+        refin-supply = <&ad74413r_refin>;
+
+        channel@0 {
+          reg = <0>;
+
+          adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
+        };
+
+        channel@1 {
+          reg = <1>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+        };
+
+        channel@2 {
+          reg = <2>;
+
+          adi,ch-func = <CH_FUNC_DIGITAL_INPUT_LOGIC>;
+          adi,gpo-comparator;
+        };
+
+        channel@3 {
+          reg = <3>;
+
+          adi,ch-func = <CH_FUNC_CURRENT_INPUT_EXT_POWER>;
+        };
+      };
+    };
+...
diff --git a/include/dt-bindings/iio/addac/adi,ad74413r.h b/include/dt-bindings/iio/addac/adi,ad74413r.h
new file mode 100644
index 000000000000..204f92bbd79f
--- /dev/null
+++ b/include/dt-bindings/iio/addac/adi,ad74413r.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_ADI_AD74413R_H
+#define _DT_BINDINGS_ADI_AD74413R_H
+
+#define CH_FUNC_HIGH_IMPEDANCE			0x0
+#define CH_FUNC_VOLTAGE_OUTPUT			0x1
+#define CH_FUNC_CURRENT_OUTPUT			0x2
+#define CH_FUNC_VOLTAGE_INPUT			0x3
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER		0x4
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER	0x5
+#define CH_FUNC_RESISTANCE_INPUT		0x6
+#define CH_FUNC_DIGITAL_INPUT_LOGIC		0x7
+#define CH_FUNC_DIGITAL_INPUT_LOOP_POWER	0x8
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER_HART	0x9
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART	0xA
+
+#define CH_FUNC_MIN	CH_FUNC_HIGH_IMPEDANCE
+#define CH_FUNC_MAX	CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
+
+#endif /* _DT_BINDINGS_ADI_AD74413R_H */
-- 
2.34.1

