Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBBE466DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358833AbhLBX2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357971AbhLBX2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:28:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B8C06174A;
        Thu,  2 Dec 2021 15:25:16 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so4090904edd.13;
        Thu, 02 Dec 2021 15:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBP3GhvAVXUIlWjIryejEKpIUiXn7IOo7hOhmkbzhkQ=;
        b=QTMiTUH/LYP198Fblb7d4xluaZwottT3Ern/hFpQChNfYNjkGhccrpv4z+egvspOum
         84MwI5RA2odgpJ5S6p8LFtjf3sGy5IINCwRndd779NflrYZvNfbaJaV+F9Dby9hgog5c
         087aMH5qmtB6G4K7rKLJP9qKMtvFz6DB49LLPb+gDPK0CfUvHccG2uY+dan8Uo53Ax54
         qP1FtJFzujYF5ksAq2OpNZWVJF6+qwHNLTdmhuNMj3QhQbHjNb6xoIAYPiFz+HM4A2vs
         jg9M9Iqty1/ntNLwlK0oiBzgisiDdH2fWAyPxGfCqTUbcchArt3GBBU7sZSB9F723tah
         rbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBP3GhvAVXUIlWjIryejEKpIUiXn7IOo7hOhmkbzhkQ=;
        b=hjlMQODkWtqpzbyhlJs7hURjF2z7FfBKUofJRRZ7s91F1J27JtD5qMUrHhqAk7go88
         e/LRteVXSVE/RhlyRdX1HHpcaTZggQXBvkvkNoKmu+R6/qODt8rpziZJ9h+PiiCkbSc1
         6L+bFprlsAhetSh0N4BCt8cegFaI9437DN4RjGkgTDTnzjcdphtm1TNvK54MrC0SZios
         Gsc790fttez97aMyn+Nx6RClneW2Mi6BLHnTBOeSRl1DQiiHP3RgQyTMdtdzvSlF8kyi
         gUM2LNbVmC/qmPbhEJYCkR+jZP50TW06K9iNCnY85qNGfAm8ZmY7vxZQmjwrxU7HFRC1
         /PNQ==
X-Gm-Message-State: AOAM532MQEZPKyHXnhjyFmhNSy1ZuETgNQVtkRh2lbo2QKaoyVtssL7T
        RuC+I8C5TsQJ6vho273p5X8=
X-Google-Smtp-Source: ABdhPJzzv7b2SBnWNucYJmDOgt9ic3jjIc1+9Hqa9OQrvaHSitW7eO1KPkA9oCirn+dwVkv3xu6uWg==
X-Received: by 2002:a17:906:2dcd:: with SMTP id h13mr18570270eji.135.1638487515163;
        Thu, 02 Dec 2021 15:25:15 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id w18sm701898edx.55.2021.12.02.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:25:14 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v9 2/3] dt-bindings: iio: add AD74413R
Date:   Fri,  3 Dec 2021 01:25:06 +0200
Message-Id: <20211202232507.358113-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202232507.358113-1-cosmin.tanislav@analog.com>
References: <20211202232507.358113-1-cosmin.tanislav@analog.com>
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
index 000000000000..a43b010f974f
--- /dev/null
+++ b/include/dt-bindings/iio/addac/adi,ad74413r.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_ADI_AD74413R_H
+#define _DT_BINDINGS_ADI_AD74413R_H
+
+#define CH_FUNC_HIGH_IMPEDANCE					0x0
+#define CH_FUNC_VOLTAGE_OUTPUT					0x1
+#define CH_FUNC_CURRENT_OUTPUT					0x2
+#define CH_FUNC_VOLTAGE_INPUT					0x3
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER			0x4
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER		0x5
+#define CH_FUNC_RESISTANCE_INPUT				0x6
+#define CH_FUNC_DIGITAL_INPUT_LOGIC				0x7
+#define CH_FUNC_DIGITAL_INPUT_LOOP_POWER		0x8
+#define CH_FUNC_CURRENT_INPUT_EXT_POWER_HART	0x9
+#define CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART	0xA
+
+#define CH_FUNC_MIN		CH_FUNC_HIGH_IMPEDANCE
+#define CH_FUNC_MAX		CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
+
+#endif /* _DT_BINDINGS_ADI_AD74413R_H */
-- 
2.34.1

