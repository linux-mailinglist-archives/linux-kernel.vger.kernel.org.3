Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA9469469
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbhLFK5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbhLFK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:57:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00DC061746;
        Mon,  6 Dec 2021 02:54:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so41360073edv.1;
        Mon, 06 Dec 2021 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hjJXu5U3RswbUnmRhbftaDLLxi5Uoy/rRG5DX2Kc3w=;
        b=OAuQz+9UUi7680r+1fryuZCRRShCf+xgV6dUx3ngGnODqFazAj1gu+tHKkuto1Hx2O
         +AQdDm7vuSBvueG/+3mgPKJi/4f8GvLk5IzU67LnH+mDirJhb0LqLCiJ9yYiaFwA6gzN
         RL/OWBb/wXMc0MoRi7Ku0TQWEkkO4HR9GWlTUKiAV+cUGXPjm0af88pQCMvRaBA9zxtd
         x4Z47j+b/eWrZX8s4/uIklCNZfA3vNmk0qXH3l0B3yHWqxIxAYY+xrxK4mJsxoAgIdTx
         pIdF6wyIrcjcCxlfh/ZtmCSd/hlI+hRxPMQqbPB2jK79NITyBexzpXRFlwyEUpK8vs79
         4tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hjJXu5U3RswbUnmRhbftaDLLxi5Uoy/rRG5DX2Kc3w=;
        b=CdbvoXRPCbIoRx0kj/K4RwFW3zR2DVbj9ZYeitZalrzBN1vjx405hty7Qj4Fr0fH+F
         uLge1Q5m6QKp8Jr6fgVFmrFtKkiY5a6UCgl63P8QH+cnkAS94NetOGWIhL+Ejs4HdxYD
         9e4g4vrZaRPP0o3UcpZE7TLvG5apJmWKzoC99lIsXWm81l51/m8iwKjSDJFeGxhJ6BNO
         7cPeCBnJ8oQNm0FfTpWzcCyTc/wsNRwe43uuvA2eYzRPvYhdx7SEzpZHdABRHXn52juX
         k4VPzndo91ySIYa1FCTOfZCccI3kUhXNxjr55mlcKr9JluPMrA+O5wOWToXPM+DbI6J+
         WzlA==
X-Gm-Message-State: AOAM530H/TPnJfxRhd9ZutCcEbiNoVEYXW28RnUuLCNa48UwrgxawsPG
        TnSLKK2NU/p7eVjQhXJEkO7UOXHNy//KOg==
X-Google-Smtp-Source: ABdhPJyFaUaVwQl9KyFCJukop39lFYuWcyLCkepe56PSdKOISEFItw/daNz+aRV+/XP1HYu/Yl/kZg==
X-Received: by 2002:a05:6402:430e:: with SMTP id m14mr52913722edc.93.1638788053636;
        Mon, 06 Dec 2021 02:54:13 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id hd18sm6462605ejc.84.2021.12.06.02.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:54:13 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: iio: accel: add ADXL367
Date:   Mon,  6 Dec 2021 12:54:02 +0200
Message-Id: <20211206105403.53049-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.

The ADXL367 does not alias input signals to achieve ultralow power
consumption, it samples the full bandwidth of the sensor at all
data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
with a resolution of 0.25mg/LSB on the +-2 g range.

In addition to its ultralow power consumption, the ADXL367
has many features to enable true system level power reduction.
It includes a deep multimode output FIFO, a built-in micropower
temperature sensor, and an internal ADC for synchronous conversion
of an additional analog input.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
new file mode 100644
index 000000000000..1bf9e1602480
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl367.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL367 3-Axis Digital Accelerometer
+
+maintainers:
+  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+
+description: |
+  The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
+
+  The ADXL367 does not alias input signals by to achieve ultralow power
+  consumption, it samples the full bandwidth of the sensor at all
+  data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
+  with a resolution of 0.25mg/LSB on the +-2 g range.
+
+  In addition to its ultralow power consumption, the ADXL367
+  has many features to enable true system level power reduction.
+  It includes a deep multimode output FIFO, a built-in micropower
+  temperature sensor, and an internal ADC for synchronous conversion
+  of an additional analog input.
+    https://www.analog.com/en/products/adxl367.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl367
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adxl367@53 {
+        compatible = "adi,adxl367";
+        reg = <0x53>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+      status = "okay";
+
+      adxl367@0 {
+        compatible = "adi,adxl367";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
-- 
2.34.1

